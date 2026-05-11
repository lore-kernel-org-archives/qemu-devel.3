Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C501CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUx8-0006jD-0v; Mon, 11 May 2026 14:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMUx1-0006iJ-Mv
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:01:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMUwz-0004jq-A8
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:01:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b0046078so38922335e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778522509; x=1779127309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRYahPGX936mJwpAMBLzEIbPM9cPS1WS9nNZC7Gb/v4=;
 b=kDFADIt8Ld4aQi6F49lz+X/dfie4g3Axwk65U8gs9VHav4SKID2/W+0/OlNyYygQPH
 sKFSuaJm5DzGAm7EeSEXID3G+UHGcnEkq9DEu8MvYu1Hj461sdpiCRQXzk2nMZnMsoaq
 dntfy2O0HKL6SqxVYA8XopTepNGk5cup3jNF3+UrVi03jaonwnYE+RBr418qkzPZ4V7l
 D5VUKy+65v3um6WUJnJZszE0L4Z5DMQjpqi99uAvaapGmY2rzE2xQP6/io45EaP7xmO4
 lflnJb7fpzVjm9AQGD2FmPEi+Xhgobe01RNj0UhFiJzJcvqjPdOg1QHBF7O32Z9jGJhB
 gdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522509; x=1779127309;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SRYahPGX936mJwpAMBLzEIbPM9cPS1WS9nNZC7Gb/v4=;
 b=Ysr+Y57ebsInjD/eRclZmPsIFxWhQMsRN56XR7sheY0bmEQL2tdD0lP5/KyRHp8Smg
 cu9i1tr9fZyx3iwhIQbOg/tMFjCNGFo8eTi/4ncZG2QlwIdPYjmM2kFHaucd69lSN0NV
 SD2ghIA2EXWzeED4udd1EgKp9LimwFjJfIUuskdT8V2fryuEM59WaK/SYuwrr9haGJ14
 Ij24SKeYA4vpEahXTg3BAyKSYIK9d0sXiS1eVZsUniSz98xZh31pyVi9eceyUSCQ1ITc
 6l7up84hna5T49u5PhKsnrbkohBHguJNtLXkocaCNMGmursV9lkwZOlgllJOAVBQPW1X
 zV/w==
X-Gm-Message-State: AOJu0YweRD9rmlY8jXKEKWol/TdBns51Prosp7OySn2eqbKZowpuFmzf
 yeCRDic+XLZY4ucr9sj8W/+qztZ97+dkVf50puiOB/q5YrkcYFFhGy7HL4zLYOW1Yj6shgAxN8t
 YpdmnyxM=
X-Gm-Gg: Acq92OGuXb83xfIkaP2w3XRy3sO9zaNUKcNHPFgRiFhR4vMDJpMt3HLfEotbs3d0OWk
 IE6fV3JsXV4J035oEO6sQjj51quQIvjZh0x8seRSzSK/qqESxjj/QVzxb0M5omqrv76K4bcJRin
 GY0J9Wp07HkMgxqHcxHTcFkBctNI23qZ9kGVyjDMT9YmWAx0ukeBPg0vrwzMRwUb/bAX9wYo8op
 u4cBVZEEdzMSXSGkRGx5pEuF7aJ4nhe1orbCR2I+svCgNwModlZeu2HxY+mrF9OXnt3Ip0XjcY+
 guewdBCbAZGC/fkeydv/JWVfprdIuozph2r3GuFU28YwNtAKAymyzk9Clhiy4ANnrNSX/ggH58f
 1v0UIKbetEurUTwHQxHZAYGWLUSOelQExhEXI1Z0aSZfVR7YrzCtoAro6NqErkZJ+LMS0a/n5S9
 jxCDjttskQ9rPDtDNNExYqzl0=
X-Received: by 2002:a05:600c:3507:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-48e706b2726mr161266355e9.15.1778522509054; 
 Mon, 11 May 2026 11:01:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e5efe57sm2722425e9.2.2026.05.11.11.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:01:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6362F5F7C1;
 Mon, 11 May 2026 19:01:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 07/10] .agents/skills: add qemu-mail-thread skill
In-Reply-To: <20260511170500.124211-8-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 11 May 2026 18:04:56 +0100")
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-8-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 11 May 2026 19:01:47 +0100
Message-ID: <87y0hpddv8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Teach agents how to fetch and deal with archives of mail threads.
>
> Just YOLO'ing the entire mail thread into an LLM context is quite
> expensive especially if reviewing a thread against your current tree
> state. This skill allows the agent to extract just the comments and
> tags saving tokens.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - rename to qemu-mail-thread
>   - add instructions on fetching threads via b4
>   - refactor the metadata handling in the script
>   - mention in AGENTS skill list
> ---
>  .agents/skills/qemu-mail-thread/SKILL.md      | 34 +++++++
>  .../scripts/qemu_mail_parser.py               | 98 +++++++++++++++++++
>  AGENTS.md                                     |  1 +
>  3 files changed, 133 insertions(+)
>  create mode 100644 .agents/skills/qemu-mail-thread/SKILL.md
>  create mode 100644 .agents/skills/qemu-mail-thread/scripts/qemu_mail_par=
ser.py
>
> diff --git a/.agents/skills/qemu-mail-thread/SKILL.md b/.agents/skills/qe=
mu-mail-thread/SKILL.md
> new file mode 100644
> index 00000000000..58e7c833a27
> --- /dev/null
> +++ b/.agents/skills/qemu-mail-thread/SKILL.md

Amazingly I was testing this fine (probably because it was in the
context) but missed:

---
name: qemu-mail-thread
description: Fetch and extract reviewer comments from QEMU mailing list thr=
eads, handling mbox files or raw text dumps.
license: GPL-2.0-or-later
---


> @@ -0,0 +1,34 @@
> +# QEMU Mail Thread
> +
> +This skill helps you fetch and extract reviewer comments from QEMU maili=
ng list threads. It can handle standard `mbox` files (e.g., from `b4 mbox`)=
 or raw text dumps from the user.
> +
> +## How to fetch a mail thread
> +
> +If you have a Message-ID (e.g., from a patch series), use `b4` to fetch =
the entire thread:
> +
> +```bash
> +b4 mbox <message-id>
> +```
> +
> +This will typically save an `.mbx` file in your current directory.
> +
> +## How to parse comments
> +
> +Use the included Python script to extract feedback, filtering out quoted=
 text and diffs.
> +
> +```bash
> +python .agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py <path=
_to_mail_thread_file>
> +```
> +
> +The script automatically detects whether the input is a standard mbox or=
 a raw text dump.
> +
> +## Expected Output
> +The script generates `parsed_comments.txt` in the current working direct=
ory:
> +```
> +--- REPLY FROM Reviewer Name <email@example.com> ---
> +Subject: Re: [PATCH 01/10] ...
> +Comment text here...
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +```
> +
> +Use this structured text to efficiently analyze the feedback and identif=
y outstanding suggestions.
> diff --git a/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py =
b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
> new file mode 100644
> index 00000000000..fdaac57ac15
> --- /dev/null
> +++ b/.agents/skills/qemu-mail-thread/scripts/qemu_mail_parser.py
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +import sys
> +import os
> +import mailbox
> +
> +
> +def is_metadata_line(line):
> +    """Check if a line is metadata (quotes, diff, etc.)"""
> +    return (line.startswith(">") or
> +            line.startswith("---") or
> +            line.startswith("diff "))
> +
> +
> +def parse_raw_text(text, output_f):
> +    # Split by the separator used in lore.kernel.org / b4 dumps
> +    messages =3D text.split("----------------------------------------")
> +    for msg in messages:
> +        if not msg.strip(): continue
> +
> +        lines =3D msg.strip().split('\n')
> +        author =3D ""
> +        subject =3D ""
> +        body_start =3D 0
> +        for i, line in enumerate(lines):
> +            if line.startswith("From: "): author =3D line[6:]
> +            if line.startswith("Subject: "): subject =3D line[9:]
> +            if not line.strip() and body_start =3D=3D 0:
> +                body_start =3D i + 1
> +                break
> +
> +        is_reply =3D subject and ("Re: " in subject or subject.startswit=
h("Re:"))
> +
> +        if is_reply and author !=3D "" and not author.startswith("qemu-d=
evel"):
> +            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subj=
ect}\n")
> +
> +            for line in lines[body_start:]:
> +                if not is_metadata_line(line):
> +                    output_f.write(line + "\n")
> +            output_f.write("=3D"*60 + "\n\n")
> +
> +
> +def parse_mbox(mbox_path, output_f):
> +    mbox =3D mailbox.mbox(mbox_path)
> +    for message in mbox:
> +        subject =3D message['subject']
> +        if subject and 'Re: ' in subject:
> +            author =3D message['from']
> +            output_f.write(f"--- REPLY FROM {author} ---\nSubject: {subj=
ect}\n")
> +
> +            payload =3D message.get_payload()
> +            body =3D ""
> +            if isinstance(payload, list):
> +                # Handle multipart
> +                for part in payload:
> +                    if part.get_content_type() =3D=3D 'text/plain':
> +                        body =3D part.get_payload(decode=3DTrue).decode(=
'utf-8', errors=3D'ignore')
> +                        break
> +            else:
> +                body =3D message.get_payload(decode=3DTrue).decode('utf-=
8', errors=3D'ignore')
> +
> +            # Simple heuristic to extract comments
> +            for line in body.split('\n'):
> +                if line.strip() and not is_metadata_line(line.strip()):
> +                    output_f.write(line + "\n")
> +            output_f.write("=3D"*60 + "\n\n")
> +
> +
> +def main():
> +    if len(sys.argv) < 2:
> +        print("Usage: python qemu_mail_parser.py <mail_thread_file>")
> +        sys.exit(1)
> +
> +    input_file =3D sys.argv[1]
> +    output_file =3D "parsed_comments.txt"
> +
> +    if not os.path.exists(input_file):
> +        print(f"Error: File not found - {input_file}")
> +        sys.exit(1)
> +
> +    with open(output_file, "w", encoding=3D"utf-8") as out_f:
> +        # Detect if it's an mbox or raw text
> +        with open(input_file, 'rb') as f:
> +            header =3D f.read(15)
> +            is_mbox =3D header.startswith(b'From mboxrd@z ')
> +
> +        if is_mbox:
> +            print(f"Parsing {input_file} as mbox...")
> +            parse_mbox(input_file, out_f)
> +        else:
> +            print(f"Parsing {input_file} as raw text dump...")
> +            with open(input_file, "r", encoding=3D"utf-8", errors=3D'ign=
ore') as f:
> +                text =3D f.read()
> +            parse_raw_text(text, out_f)
> +
> +    print(f"Done. Extracted comments saved to {output_file}")
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> diff --git a/AGENTS.md b/AGENTS.md
> index fbbc3b65ed0..d99d3078378 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -28,6 +28,7 @@ You should use the following specialized skills for com=
mon tasks:
>  - `qemu-build`: For configuring and building QEMU (including debug and s=
anitizer builds).
>  - `qemu-testing`: For finding, listing, and running individual tests (Un=
it, QTest, Functional, TCG).
>  - `qemu-code-reviewer`: For pulling and applying patch series from maili=
ng lists.
> +- `qemu-mail-thread`: For analyzing and parsing mailing list threads.
>=20=20
>  ## Source Code Layout (see `docs/devel/codebase.rst`)
>  - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and arc=
hitecture-agnostic acceleration code.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

