Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A722BCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 16:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKfGT-0001P0-Uj; Wed, 06 May 2026 12:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKfGQ-0001Oq-Kv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 12:38:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKfGN-0004J2-8R
 for qemu-devel@nongnu.org; Wed, 06 May 2026 12:38:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so42582025e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778085496; x=1778690296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fez8zc4io7WxThJok/7BAm8YXKX1qxIKYOpELmIJyyI=;
 b=zrpzcO0FuZqgk12oASJw0SJuqKkJnXrBRATGL5VJI9gwCcNi3eAnZODctfjdF7SFNg
 uwWIXZvpdvLzdMLQcZhyYKQnCXfs5af2gQ7TCBL1nOFgeg7NAv0zTr1OE0cSFSlQcDEa
 rC7+9gsFz42yVatmkNOk9BnSWb+RKMn41tzDDTmS98pupRamAycEKxtJue+vzovLVkU1
 IGyrn7chjNtvjWQKajEwkqdOQ9mXla3qjPCAZuIe79guC1Br7CrZug9YbUMkVgksx6TC
 hxiPpeB55YsT2UNkLJF+wXXAcQsvQ8R+ddhEhmIxM8EHJuln5St9VErvrlUItXPJmSy5
 DXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778085496; x=1778690296;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fez8zc4io7WxThJok/7BAm8YXKX1qxIKYOpELmIJyyI=;
 b=Q+4PCFWfmL289dFjj0bq84TdQKMOwZNXE/ic2i80fHvlODXk1JUz/tU5LSIX4Ae7Tb
 ka5JHqMiIAyhLcjq/Y744RR5W0plXBI0XzQ4NtZW+SO4xonE3k8Pfdiqb557DBg3lWSQ
 p9USorj8DKmaURcbXZQUDg7Iv8a9JeCtuvWJFp2ayuB8cdKtY4ACQASBALgzKKzsSioc
 ALhofD59qg1jJiyd5DFeqDANmSEyAKQNx/MS7YmUaDGP1t8ERfLkTU8UKnZuM7Sp3MFO
 afm0NQyEQyTOPAk2gOqW5ezaQOQcbfN7DwS2Bz0tJhZnMrqpRE0GJ4nRfz/2YftoMj2J
 aZBw==
X-Gm-Message-State: AOJu0YzbT4W//dPVk8sNIRCcTkfg6AfrGKYSLva2kojkKuuosNGNADih
 I8HPNBDBMuFJHq2JxI4ydsHNA/ZOoHsDOQDFqkZO8AW2v11lxRMUdkXrNPPVuvuyc3X3PXnwFH4
 2nf8Oz8M=
X-Gm-Gg: AeBDieuOr0uVkAnKqlM6u++fhDHFvCVKraWupQNFTJmhUaVWTNye1bvEA+QXtvT3laY
 n6teTpwTwclelnl995pk73M5cp7v66fzdS0JYWitStxINlM7i4H2xlLCmCG+ND9XuVLBYWig+Jb
 JJTj+i+skiijjXuZkTx6WIYQvXyVSzkTxEtruWcGXnJ8BLu4h4zxMhSkGnLwbk3fc71mT80NT6b
 FepwcybjfwoFM9PYhE+TdKzLbjRbl7YrBU8g8ZrFn4iqjiTobSDn3TmktD7cJDAznmyqEP+3xMH
 2dXrTfbzn8GUldviHLbvvHyLO5qHj9yezTDmWGxMQqOWs2kHAWwcB7b8WlE1dLTzOH4gBl3gX9L
 agsxAA7Aym0xdm/LF6vdSh5rLJ72sn8eCHFp+aBeNlWVIPZzEK/WUYQDddOrpCy6SU3rAeehXI0
 tgKlg5/2iNk7vhiDJfMpHY64qtipahRQjKlg==
X-Received: by 2002:a05:600d:8408:b0:48a:58e1:6d17 with SMTP id
 5b1f17b1804b1-48e52bd4f17mr50047375e9.20.1778085496354; 
 Wed, 06 May 2026 09:38:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538aaa0fsm76111035e9.7.2026.05.06.09.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:38:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 771CB5F7EB;
 Wed, 06 May 2026 17:38:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 05/10] .agents/skills: add qemu-build skill
In-Reply-To: <8685c75f-09eb-4c05-a109-f16eca871999@oracle.com> (Alejandro
 Jimenez's message of "Wed, 6 May 2026 11:48:12 -0400")
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-6-alex.bennee@linaro.org>
 <8685c75f-09eb-4c05-a109-f16eca871999@oracle.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 06 May 2026 17:38:14 +0100
Message-ID: <87bjesmr2h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Alejandro Jimenez <alejandro.j.jimenez@oracle.com> writes:

> On 5/5/26 1:01 PM, Alex Benn=C3=A9e wrote:
>> This provides basic instructions for building QEMU.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .agents/skills/qemu-build/SKILL.md | 50 ++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 .agents/skills/qemu-build/SKILL.md
>>=20
>> diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-bu=
ild/SKILL.md
>> new file mode 100644
>> index 00000000000..a78678ff632
>> --- /dev/null
>> +++ b/.agents/skills/qemu-build/SKILL.md
>> @@ -0,0 +1,50 @@
>> +---
>> +name: qemu-build
>> +description: Provides step-by-step instructions on configuring and
>> building QEMU. You MUST trigger this skill whenever the user asks to
>> build QEMU or debug build failures. It includes critical details on
>> build directory reuse and spawning sub-agents.
>> +license: GPL-2.0-or-later
>> +---
>> +
>> +# Instructions
>> +
>> +## Examining and Re-using Build Directories
>> +Before creating a new build directory, check if an existing one can be =
re-used. QEMU uses out-of-tree builds, typically in `build` or `builds/` su=
b-directories.
>> +
>> +1. **Check existing configs**: You can examine how an existing
>> build directory was configured by checking its `config.log`. Run
>> `head -n 2 builds/<dir>/config.log`. The second line typically
>> contains the full `../configure` command line used.
>> +2. **Re-use and Reconfigure**: You have latitude to re-use existing
>> directories when appropriate (e.g., `builds/debug` which is a
>> general-purpose debug directory for whatever is currently going on).
>> If an existing directory has the right flags (like debug/sanitizers)
>> but the wrong target list, you can reconfigure it to keep the same
>> config but change the `--target-list`:
>> +   ```bash
>> +   cd builds/debug
>> +   # Check the old config.log, then re-run configure with the new targe=
t-list
>> +   ../../configure <old-flags> --target-list=3D<new-targets>
>> +   ```
>> +
>> +## Launching Builds
>> +**Crucial**: You MUST NEVER run builds directly in the main agent conte=
xt. You MUST ALWAYS launch them by spawning a sub-agent using the `eca__spa=
wn_agent` tool.
>
> "ECA heritage" showing with the eca__spawn_agent mention. Ending the
> sentence after "sub-agent" is likely enough for the model to do the right
> thing based on its available tools?
>
>> +Always use the `qemu-helper-agent` for these tasks.

And this is on my personal config as well ;-)

I have added a rule to my config:

  ---
  paths:=20
    - "/home/alex/lsrc/qemu.git/**"
  ---

  There is a qemu-helper-agent for use in QEMU related tasks.
  Use `env GITLAB_TOKEN=3D$(pass gitlab-api)` to pass the auth token for gl=
ab actions.

And cleaned up the references from the project agent skills.

>> +Pass the specific build commands, along with the required working direc=
tory, in the `task` argument. Give the subagent explicit instructions on wh=
at to verify and what to report back to you.
>> +For example: `task: "Navigate to builds/debug and run ninja. If it fail=
s, report the exact compiler errors."`
>> +
>> +## Configuring a New Build
>> +If no suitable build directory exists, create a new one.
>> +
>> +1. **Create build directory**: `mkdir -p builds/test-target; cd builds/=
test-target`
>> +2. **Basic Configure**: `../../configure --target-list=3D[list of targe=
ts]`
>> +   - Common targets: `x86_64-softmmu`, `aarch64-softmmu`, `riscv64-soft=
mmu`, `x86_64-linux-user`.
>> +3. **Common Options**:
>> +   - `--enable-debug-info`: Include symbols.
>> +   - `--enable-debug`: Enable assertions.
>> +4. **Sanitizers**:
>> +   - `--enable-asan`: Address Sanitizer.
>> +   - `--enable-tsan`: Thread Sanitizer.
>> +   - `--enable-ubsan`: Undefined Behavior Sanitizer.
>> +
>> +## Building
>> +**Important**: Always re-run the build after making changes to the sour=
ce code.
>> +
>> +## Reporting Results
>> +**Crucial**: After completing the build task, provide a concise summary=
 of the results to the calling agent.
>> +1. **Summary**: State whether the build passed or failed.
>> +2. **Failure Excerpts**: If the build fails, include relevant excerpts =
from the logs (e.g., compiler errors).
>> +3. **Full Paths**: Always provide the **absolute file paths** to the fu=
ll logs for further inspection.
>> +
>> +## Debugging and Environment
>> +- **Verbose**: `V=3D1` for detailed output.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

