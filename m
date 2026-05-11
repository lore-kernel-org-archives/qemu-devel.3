Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10037CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU4M-000171-KN; Mon, 11 May 2026 13:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU47-0000uP-JA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU44-0007oS-Gr
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso2379847f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519107; x=1779123907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DK8w3wWlNjyLdHUAxS2nkmLSUJ4xVH9mq/jC0j206M=;
 b=ZafP+sO0gdYvhC5u0iNFY1jBabfbaox14HNap2q1HDusgB45n/ScquR/MhCifOSaDM
 lDlutGIoXvzAYO9cDpYiokyFG9NZDr6MU5L0GFx+40Dbjzyeb1aciCWFlgCmOdBTbbQZ
 jybVFtCvRqxufAzwJnRDqY6II9hMkxRO9UsesYPfyto83p2euRwEvob8C1DsveSwpa0a
 SG5Ye0rWjWVPcDOSg5udRIFU4xpyOwCmHZYKx/jTzdYtHTVo9b357OJk/D+Nn+z3Zuq4
 +YNgCn9Cg+uc5BryMfPcG5CqokKqxG8PXXArRnBzA4lI+kUHLfva1C/Rrsz8F2zscbGa
 VWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519107; x=1779123907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8DK8w3wWlNjyLdHUAxS2nkmLSUJ4xVH9mq/jC0j206M=;
 b=nNNBG1g4dc0lxM/lYpLQ7J594M81A+5RMkanA0V5wgLUz6BlWtbafW3dWSlptUGm+V
 4rIzrsA2Pdhlzlpby/WVJ1CmtmHL5bf3eC5jfxFoGrRvus1XHvka3v0hCd10orvW6lSU
 50J16aPscz+q7z08ydSfuUin343LyJDkhjuBkOpoo888JGxvrc73lq6o23XzAO9Jw2nj
 3LR2JnHCzEqphRHoDWhWs2gfYhg6L++SDs2SE0yifBmQ/hpaeRN7qdwFdx6MvmAIEqCg
 r2KmuPJ/EPc2f6+IvcyVi9GqCYJDDJYlybMh5llr6YDaA4PXbZlfp3xvdc6yRE/FfMC0
 541Q==
X-Gm-Message-State: AOJu0YyMcj25/AS8SNkJEvKZ3X5oJ+UVUOfRaGT4wR+g9R3+rmDqckCH
 7NKzWUfiJlClUJ0P6WznMbpxWEy/P1vdHqwrPrj7/KiiAQoLOi0IdKBH0DTgKr/tgs3dMmoTKT5
 eXgCgMQU=
X-Gm-Gg: Acq92OG+11Rsjbn4pI6gtuSLXo4XdnMzEkEycEBIeoE7jnEFybhMODohJ3RPSJZXeUF
 MAGrathsc1DiOMZvNvfcHOvGoC/K0DBXn1HJGSvqlb3ropjyS4os+v+tvKlqxpyFVLMLhGFZKvx
 87CvkqvI3dSuTRsOBU2IjDn7UOVbo5c+9oo6gwUt5cZkJlKOwXlf+sU6MQjP5NUCSuR3OWuereL
 brZBIN67jbP4NXdjv1JKf9ZMclH980Nijvd1bOTtqV+hTR0CMbje6P8bFm2p61PFZlvhkwrp+7x
 ESlvKiG72F6MmwULtfDDp696rLRdSt+8tjvFg52/Wzy1rnHzwbi5PclpapHSasCNCcdnUd8suxC
 nRK377fmztj1xqThCCOmsTnZWiU++ZjFu6E9VLw7eXAzBGkIZc0c/5jsifLykJLsSJ2rdPxuQed
 pCp9dIp1d4khTWTUJRfUOhZgs2HVadUdouDw==
X-Received: by 2002:a05:6000:18a6:b0:455:cff5:9178 with SMTP id
 ffacd0b85a97d-455cff591b5mr18548550f8f.9.1778519106759; 
 Mon, 11 May 2026 10:05:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491304387sm25974694f8f.21.2026.05.11.10.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3582A60EFD;
 Mon, 11 May 2026 18:05:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 07/10] .agents/skills: add qemu-mail-thread skill
Date: Mon, 11 May 2026 18:04:56 +0100
Message-ID: <20260511170500.124211-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
v2
  - rename to qemu-mail-thread
  - add instructions on fetching threads via b4
  - refactor the metadata handling in the script
  - mention in AGENTS skill list
---
 .agents/skills/qemu-mail-thread/SKILL.md      | 34 +++++++
 .../scripts/qemu_mail_parser.py               | 98 +++++++++++++++++++
 AGENTS.md                                     |  1 +
 3 files changed, 133 insertions(+)
 create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
 create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py

diff --git a/.agents/skills/qemu-mail-thread/SKILL.md b/.agents/skills/qemu-mail-thread/SKILL.md
new file mode 100644
index 00000000000..58e7c833a27
--- /dev/null
+++ b/.agents/skills/qemu-mail-thread/SKILL.md
@@ -0,0 +1,34 @@
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
index fbbc3b65ed0..d99d3078378 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -28,6 +28,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
+- `qemu-mail-thread`: For analyzing and parsing mailing list threads.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


