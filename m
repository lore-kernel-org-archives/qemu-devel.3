Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA49CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRa-0005l3-CM; Fri, 15 May 2026 12:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-0005do-Nr
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRG-00027E-Ll
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so209615e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862661; x=1779467461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZoXmsx9fuy3KvKUwXq6IG9tmVKPqlhjKrQaqjqUgFM=;
 b=M8hRYF2bCsIp5ekbKcCmLXgzCBrH9CftJ5/T01F/sEiAPUWLKFu00yHC44SYnXMfCh
 IcyHj5ZCokt5HieqfD5UGAHg71+Srx3TbVz+UkaACfgT9ZwDorvfIv6xpw2KE2YKLZlE
 LeRs655+stOh1hdurzgMF6rcLYSIBnJoMAZtzsybkQ/MpXIW0bk34CvoLIqwAM0vVy2a
 ZaaR1Ky4wlujf6N1TA6xLrAmeyTdSIYmDiTdZljLg4oFi76dfH6drkEbbkWC/jIqaXaE
 X31GyAJCGAZwavbhVgh+HXyXQLfF7wYaTIHzVaLBFBjMPy7cl9dVHnUGCppUoIkz3WD8
 8dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862661; x=1779467461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ZoXmsx9fuy3KvKUwXq6IG9tmVKPqlhjKrQaqjqUgFM=;
 b=U9YM1fJlPvmTKxbtQlz+AsuHXtU9iszJ8TT0z1Okun9hiuwGbKGa82Ywy3Xi5RrJmJ
 GPVv1YcYa1IWM2GZNHxoVgVBMN7CRrf9l87z8V1Kw+W+Boo6+DtH/Cy2yzXpsaXkm5qm
 ONZVX0ymyPzgvFPXkFulELshJ/pu0l0SqlWa0acDmAc1zDKg+8QIWWCv/ycdvZ4pGk6q
 p0tO60hoeTpaWUsnWLcrs79/gPFBCVJedIV0C14Dk6rb88UlGR+DBsjXnWI9cLKm0VBf
 gsywX6C0Xdu0fwYjyhA5pv0ra/sFdAKMQ/aegYAsIsXiuMiom3g1CAuSZJMAPGOJlzfC
 KXjA==
X-Gm-Message-State: AOJu0YyMUz99vAo9PqIV/N0uYLBf3QB+5257P5gDD7An3rScWGOqyMDu
 ENjVlnrj1/GYNv00Q6IixaFhPNKlkD7X39bixMJiA2VTwNW8kvCshqzrNCi+ipHk6Gg=
X-Gm-Gg: Acq92OFrVLao3gSgYciGnGhUZ4I2jjuEnf4+V+D+1i6ZDr/Au5QApvis3nVfSaSuh77
 LaKN9lMk6rcKSmFC74T2UUxYOE7BzPcwkE4W4A05yFCD7ckPEKYjKpCbLKWheL2OeMG1UWgR1Yk
 OdaT7wDx1sBheii7qSqVq38dRIeBK4SpiaUaGqoBZCrH8NAP9y29Dwi+8//Tm3P9CCN0Pj+Ou5B
 bIfcuDzDENskbReExYVtDegTTv69vz2cnD0vJ7cvRW15lUd9U/M2by9tEaJDl32t++iNV4Nds7F
 wac8rwfOFiOUnbPhxJZ6RN/c3SbQ/wEGOLi3WZ/9ab6PRMjjyYxYzOZCdxI7zhzfDuBfi+dEMw1
 0Or0Z68UWtMQJ+1Kp5PxdeLU5VtSAp3Z8AbVFzOClSkRL79b/Lyr3Q83vW/+QBdWC4ayq49uV+9
 CPmk1p8Z+eKTOxV0EaF3V57zU=
X-Received: by 2002:a05:600c:37ca:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-48fe59b05b2mr72699765e9.0.1778862661147; 
 Fri, 15 May 2026 09:31:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5e9d5d9sm78863725e9.15.2026.05.15.09.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EA0A5FA02;
 Fri, 15 May 2026 17:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 08/11] .agents/skills: add qemu-mail-thread skill
Date: Fri, 15 May 2026 17:30:51 +0100
Message-ID: <20260515163055.1792262-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Teach agents how to fetch and deal with archives of mail threads.

Just YOLO'ing the entire mail thread into an LLM context is quite
expensive especially if reviewing a thread against your current tree
state. This skill allows the agent to extract just the comments and
tags saving tokens.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - add header.
v2
  - rename to qemu-mail-thread
  - add instructions on fetching threads via b4
  - refactor the metadata handling in the script
  - mention in AGENTS skill list
---
 .agents/skills/qemu-mail-thread/SKILL.md      | 40 ++++++++
 .../scripts/qemu_mail_parser.py               | 98 +++++++++++++++++++
 AGENTS.md                                     |  1 +
 3 files changed, 139 insertions(+)
 create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
 create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py

diff --git a/.agents/skills/qemu-mail-thread/SKILL.md b/.agents/skills/qemu-mail-thread/SKILL.md
new file mode 100644
index 00000000000..a3257dabc2f
--- /dev/null
+++ b/.agents/skills/qemu-mail-thread/SKILL.md
@@ -0,0 +1,40 @@
+---
+name: qemu-mail-thread
+description: Fetch and extract reviewer comments from QEMU mailing list threads, handling mbox files or raw text dumps.
+license: GPL-2.0-or-later
+---
+
+# QEMU Mail Thread
+
+This skill helps you fetch and extract reviewer comments from QEMU mailing list threads. It can handle standard `mbox` files (e.g., from `b4 mbox`) or raw text dumps from the user.
+
+## How to fetch a mail thread
+
+If you have a Message-ID (e.g., from a patch series), use `b4` to fetch the entire thread:
+
+```bash
+b4 mbox <message-id>
+```
+
+This will typically save an `.mbx` file in your current directory.
+
+## How to parse comments
+
+Use the included Python script to extract feedback, filtering out quoted text and diffs.
+
+```bash
+python .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py <path_to_mail_thread_file>
+```
+
+The script automatically detects whether the input is a standard mbox or a raw text dump.
+
+## Expected Output
+The script generates `parsed_comments.txt` in the current working directory:
+```
+--- REPLY FROM Reviewer Name <email@example.com> ---
+Subject: Re: [PATCH 01/10] ...
+Comment text here...
+============================================================
+```
+
+Use this structured text to efficiently analyze the feedback and identify outstanding suggestions.
diff --git a/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
new file mode 100644
index 00000000000..fdaac57ac15
--- /dev/null
+++ b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+import sys
+import os
+import mailbox
+
+
+def is_metadata_line(line):
+    """Check if a line is metadata (quotes, diff, etc.)"""
+    return (line.startswith(">") or
+            line.startswith("---") or
+            line.startswith("diff "))
+
+
+def parse_raw_text(text, output_f):
+    # Split by the separator used in lore.kernel.org / b4 dumps
+    messages = text.split("----------------------------------------")
+    for msg in messages:
+        if not msg.strip(): continue
+
+        lines = msg.strip().split('\n')
+        author = ""
+        subject = ""
+        body_start = 0
+        for i, line in enumerate(lines):
+            if line.startswith("From: "): author = line[6:]
+            if line.startswith("Subject: "): subject = line[9:]
+            if not line.strip() and body_start == 0:
+                body_start = i + 1
+                break
+
+        is_reply = subject and ("Re: " in subject or subject.startswith("Re:"))
+
+        if is_reply and author != "" and not author.startswith("qemu-devel"):
+            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
+
+            for line in lines[body_start:]:
+                if not is_metadata_line(line):
+                    output_f.write(line + "\n")
+            output_f.write("="*60 + "\n\n")
+
+
+def parse_mbox(mbox_path, output_f):
+    mbox = mailbox.mbox(mbox_path)
+    for message in mbox:
+        subject = message['subject']
+        if subject and 'Re: ' in subject:
+            author = message['from']
+            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subject}\n")
+
+            payload = message.get_payload()
+            body = ""
+            if isinstance(payload, list):
+                # Handle multipart
+                for part in payload:
+                    if part.get_content_type() == 'text/plain':
+                        body = part.get_payload(decode=True).decode('utf-8', errors='ignore')
+                        break
+            else:
+                body = message.get_payload(decode=True).decode('utf-8', errors='ignore')
+
+            # Simple heuristic to extract comments
+            for line in body.split('\n'):
+                if line.strip() and not is_metadata_line(line.strip()):
+                    output_f.write(line + "\n")
+            output_f.write("="*60 + "\n\n")
+
+
+def main():
+    if len(sys.argv) < 2:
+        print("Usage: python qemu_mail_parser.py <mail_thread_file>")
+        sys.exit(1)
+
+    input_file = sys.argv[1]
+    output_file = "parsed_comments.txt"
+
+    if not os.path.exists(input_file):
+        print(f"Error: File not found - {input_file}")
+        sys.exit(1)
+
+    with open(output_file, "w", encoding="utf-8") as out_f:
+        # Detect if it's an mbox or raw text
+        with open(input_file, 'rb') as f:
+            header = f.read(15)
+            is_mbox = header.startswith(b'From mboxrd@z ')
+
+        if is_mbox:
+            print(f"Parsing {input_file} as mbox...")
+            parse_mbox(input_file, out_f)
+        else:
+            print(f"Parsing {input_file} as raw text dump...")
+            with open(input_file, "r", encoding="utf-8", errors='ignore') as f:
+                text = f.read()
+            parse_raw_text(text, out_f)
+
+    print(f"Done. Extracted comments saved to {output_file}")
+
+if __name__ == "__main__":
+    main()
diff --git a/AGENTS.md b/AGENTS.md
index fe50057cef7..26a9c93007b 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -34,6 +34,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
+- `qemu-mail-thread`: For analyzing and parsing mailing list threads.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


