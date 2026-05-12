Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5665CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjGg-0005dj-TS; Tue, 12 May 2026 05:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMjGf-0005dO-96
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:19:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMjGc-0000kD-Qp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:19:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d73422431so4034242f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778577545; x=1779182345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9TKna+8yBRJi3TbeRgEc1FSfyDesakdW/scU4LeG0U=;
 b=FNwSF1rFBIGXFYmmp6hlRqWIeaYksACyKIzzOgWm+lNNV98cqUX163myxntkX8MIec
 dE98qF8EOtxYZOE49k4gSOdatca+fPCOcbxpOqWE7dd0wKZzT1M4cXXXoXtK5Xmy1KeQ
 dMVJsBa2oCqjHETFah9sqZ4ecX5Xh3zHClU436R8nNIK/tFhmZGcHx/imNCmI9Yq2wlA
 eI5iEAVkoXmWNJyVj0OMZqmC9ZrNZJjicjzB67YJFhVJKrPDVThs/ROy8MARh3xsljAU
 2MKVDKKUrC8YgOJDuOGhnGXgy1EbAAwB2B5O5I3vab3eNWR9mo4ju/kZnh2bTnSNNSZE
 T1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778577545; x=1779182345;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9TKna+8yBRJi3TbeRgEc1FSfyDesakdW/scU4LeG0U=;
 b=HOLFgkIe+FI/NywCFpq2vFrsagY6M1wce3snpBY1dvqgtaPwBcJWDPhTKTj5CDN7hq
 FHNG3APPSiplrV+8O8J9iD9/MS0tLXGz7mEDTICzUA/yb1HA5MSQTXhoaghZzVZERGDt
 B2cwXD9btIr+bRUC3gqocPhzGLy/jmZhsWAjug9Wf9yFwxP5sgBAQh9D/EhInr88yX2k
 y9uu92r5Zk5RZlNx2GFCWEGOsMWOm/NHOIOkdJ54WffHg13LB/qdE87YHHrxX79G/mD+
 Ckyqw+Sbvd7C/2VnlOSSlFnRsQKu9HbvrlEuCe9zcvwVDZVu1ZtLkH5kXiR77USKI3A0
 jo6w==
X-Gm-Message-State: AOJu0Yy593E8roboOX+WOas38hdEsr9hd1pYZU6UUduXpkabQKsSVEiQ
 S4r0/hPSVjXZ1PqNnRYXSrnrPzQDICncNlBFiL6Ik9bHP5CoDeub9AKSqcIOTWdueFY=
X-Gm-Gg: Acq92OHQLTc7XTAfWBhMPG1lYY+5oVha0dH8ku596i+rEoIkX6JhOOzXgk8ATfo9D38
 iZnDhklPzPyLRWxbtGGfXmdEsORA8IzLFwadupD7WcDEs4qP5n1grnumlkvgDKXtyh7f70pc2/A
 Zh+gixzBFwNXXa+uPfmI+P7NgKMVDQf/axIoMJ6JNWvmtJTH+FXUMuLJb2RsA9wA9uwWobz8FFA
 EPbGk6pRsfmGxM3Puq+b9z5xkLnV2SZ4hnXovI+5BTGG/emU2ilPj/TjegrAga6A2eWqT8SBDj3
 jIp/QQOIQGaKQhhjEjgqmBbKb60z8qAZKQ9w8gs3uIesHjVPhiEKosGw+r8UFc9pYxSc2fNcFPD
 49yz8V9eqm1wS3K7XpF3RAYgJVQzAnpq5jyx7JKCblbVR/ngQYVXVxj+usfHM22dbOKeFQS1uCO
 FlTJhxY6lGwNhTwijJ5Vx+v00=
X-Received: by 2002:a5d:5d87:0:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-4515b524224mr43791821f8f.16.1778577544570; 
 Tue, 12 May 2026 02:19:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454917d57aesm31718536f8f.26.2026.05.12.02.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:19:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D13E45F7B1;
 Tue, 12 May 2026 10:19:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 06/10] .agents/skills: add qemu-code-reviewer skill
In-Reply-To: <agKZ1Pd0KskNZdtd@ZEVORN-PC.localdomain> (Chao Liu's message of
 "Tue, 12 May 2026 11:21:46 +0800")
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-7-alex.bennee@linaro.org>
 <agKZ1Pd0KskNZdtd@ZEVORN-PC.localdomain>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 12 May 2026 10:19:02 +0100
Message-ID: <87h5odc7eh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Chao Liu <chao.liu.zevorn@gmail.com> writes:

> On Mon, May 11, 2026 at 06:04:55PM +0100, Alex Benn=C3=A9e wrote:
>> This provides basic instructions for how to download and apply a
>> patch series from the mailing list.
>>=20
>> Currently it is only taught about checkpatch but we could consider
>> adding common code smells and review comments that come up frequently.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>   - merge checkpatch skill
>>   - moved later in series to leverage build and test skills
>>   - properly reference qemu-build and qemu-tester skills
>>   - mention the qemu-code-explorer skill for navigation
>> ---
>>  .agents/skills/qemu-code-reviewer/SKILL.md | 93 ++++++++++++++++++++++
>>  AGENTS.md                                  |  1 +
>>  2 files changed, 94 insertions(+)
>>  create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md
>>=20
>> diff --git a/.agents/skills/qemu-code-reviewer/SKILL.md b/.agents/skills=
/qemu-code-reviewer/SKILL.md
>> new file mode 100644
>> index 00000000000..48ec6b07520
>> --- /dev/null
>> +++ b/.agents/skills/qemu-code-reviewer/SKILL.md
>> @@ -0,0 +1,93 @@
>> +---
>> +name: qemu-code-reviewer
>> +description: Pull and apply patch series from mailing lists for review =
and testing in QEMU, including style and build validation.
>> +license: GPL-2.0-or-later
>> +---
>> +
>> +# QEMU Code Reviewer Skill
>> +
>> +This skill provides instructions on how to retrieve patch series submit=
ted to the QEMU mailing list (`qemu-devel@nongnu.org`) using `b4` or manual=
 methods.
>> +
>> +## Using b4 (Recommended)
>> +
>> +`b4` is the preferred tool for working with patch series from public-in=
box instances like `lore.kernel.org`.
>> +
>> +### 1. Fetching a series
>> +To download a series and prepare it for `git am`:
>> +```bash
>> +b4 am <message-id-or-url>
>> +```
>> +This creates a `.mbx` file containing the entire series, properly order=
ed.
>> +
>> +### 2. Applying a series directly
>> +To apply a series directly to your current branch:
>> +```bash
>> +b4 shazam <message-id-or-url>
>> +```
>> +This is often the fastest way to get a series ready for testing.
>> +
>> +### 3. Creating a local branch for the series
>> +```bash
>> +b4 am -t <message-id-or-url>
>> +git am ./*.mbx
>> +```
>> +The `-t` flag (or `--trust-all`) can be useful if you know the source.
> I suggest using the git worktree command for workspace isolation before
> applying patches.

I don't know if this gets too much into the weeds of per-developer
preference. Everyone has slightly different ways of working but they do
want confidence that when they hand the wheel to their agent it isn't go
to mess up their nice flow.

>
>> +
>> +## Manual mbox Retrieval (Alternative)
>> +
>> +If `b4` is unavailable, you can fetch the mbox manually from `lore.kern=
el.org`.
>> +
>> +### 1. Locate the thread
>> +Find the patch series on [lore.kernel.org/qemu-devel/](https://lore.ker=
nel.org/qemu-devel/).
>> +
>> +### 2. Download the mbox
>> +Every thread on lore has an `mbox.gz` link. You can use `curl` or `wget=
`:
>> +```bash
>> +curl -L "https://lore.kernel.org/qemu-devel/<message-id>/raw" -o series=
.mbox
>> +```
>> +*Note: Appending `/raw` to the message URL usually provides the mbox fo=
rmat.*
>> +
>> +### 3. Apply with git am
>> +```bash
>> +git am series.mbox
>> +```
>> +
>> +## Post-Application Steps
>> +
>> +Once the patches are applied, you should perform initial validation:
>> +
>> +### 1. Style Check
>> +Run the QEMU checkpatch script to ensure the patches follow the project=
's coding style.
>> +
>> +- **Check applied patches**:
>> +  ```bash
>> +  ./scripts/checkpatch.pl master..HEAD
>> +  ```
>> +- **Check a specific commit**:
>> +  ```bash
>> +  ./scripts/checkpatch.pl <commit-hash>^..
>> +  ```
>> +- **Check a specific file**:
>> +  ```bash
>> +  ./scripts/checkpatch.pl -f <file-path>
>> +  ```
>> +- **Strict mode** (often required for new code or specific subsystems):
>> +  ```bash
>> +  ./scripts/checkpatch.pl --strict <commit-range>
>> +  ```
>> +
>> +### 2. Build and Test
>> +Refer to the `AGENTS.md` or the `qemu-build` and `qemu-testing` skills =
for build and test instructions.
>> +- Ensure you are in a clean build directory.
>> +- Run `ninja` or `make`.
>> +- Run relevant tests (e.g., `make check-qtest`).
>> +
>> +### 3. Reviewing Patches
>> +Refer to the `qemu-code-explorer` skill for navigating the code base an=
d resolving functions and where they are called from.
>> +
> If the patches have multiple versions, should we ask the agent to summari=
ze
> the review history of the previous versions, as well as briefly summarize
> the discussion across the current patch thread? This can be easy to miss
> during manual review, but an agent can handle it well.

That's a good idea. I've had good success in getting agents to review
threads and summarise what was asked for. I have even had them apply the
changes for me to review before committing.

>
> However, this seems better suited as a new skill.

The qemu-mail-thread skill is a general purpose thread handling skill we
could teach about versioning?

>
> Thanks,
> Chao
>> +
>> +
>> +## Common Troubleshooting
>> +
>> +- **Applying fails**: If `git am` fails due to conflicts, you may need =
to use `git am --3way` or manually resolve conflicts.
>> +- **Missing dependencies**: Ensure your tree is up to date with the bas=
e branch the patches were intended for (usually `master`).
>> diff --git a/AGENTS.md b/AGENTS.md
>> index d9d1964d45a..fbbc3b65ed0 100644
>> --- a/AGENTS.md
>> +++ b/AGENTS.md
>> @@ -27,6 +27,7 @@ You should use the following specialized skills for co=
mmon tasks:
>>  - `qemu-code-explorer`: For finding where things are defined, how they'=
re used, or understanding a specific subsystem.
>>  - `qemu-build`: For configuring and building QEMU (including debug and =
sanitizer builds).
>>  - `qemu-testing`: For finding, listing, and running individual tests (U=
nit, QTest, Functional, TCG).
>> +- `qemu-code-reviewer`: For pulling and applying patch series from mail=
ing lists.
>>=20=20
>>  ## Source Code Layout (see `docs/devel/codebase.rst`)
>>  - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and ar=
chitecture-agnostic acceleration code.
>> --=20
>> 2.47.3
>>=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

