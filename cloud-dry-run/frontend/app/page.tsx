"use client";

import { useState } from "react";

export default function Home() {
  const [label, setLabel] = useState("");
  const [message, setMessage] = useState("");

  const callService = async (name: string, port: string) => {
    try {
      

      const res = await fetch(`https://sample-environment-group.34-36-194-136.nip.io/cloud-run-proxy${port}hello`);
      const data = await res.json(); // read as JSON, not text
      setLabel(name);
      setMessage(data.message);
    } catch (err) {
      setLabel(name);
      setMessage(`Error calling ${name}`);
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <div className="flex flex-col items-center gap-4">
        <div className="flex my-auto">
          <button
            onClick={() => callService("MS-A", "/microservice-a/")}
            className="bg-black border-2 mr-8 text-white px-8 py-3 text-2xl rounded-md hover:cursor-pointer hover:scale-105 duration-200"
          >
            MS-A
          </button>
          <button
            onClick={() => callService("MS-B", "/microservice-b/")}
            className="bg-black border-2 text-white px-8 py-3 text-2xl rounded-md hover:cursor-pointer hover:scale-105 duration-200"
          >
            MS-B
          </button>
        </div>

        {message && (
          <div className="text-lg mt-4 text-center">
            <p>
              <strong>{label} Response:</strong> {message}
            </p>
          </div>
        )}
      </div>
    </div>
  );

}
