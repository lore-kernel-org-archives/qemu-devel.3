Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCB7CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoIK-0001vO-K8; Tue, 12 May 2026 10:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMoIB-0001rl-9f
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:41:03 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMoI8-0004lE-F3
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:41:02 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8f231f3b130so433395985a.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596859; x=1779201659; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ofshx5/G1dwS9t8TC8Tw6dk+VcQzubVaCoyEMeFaYjk=;
 b=myhgM22nyL8vKD7aDuLAXtLcbeZ9LjKyovrH5FgGls/JfuA8vCDb9Nr/Q2YVvkQDv3
 pxI4zOCu/ID3NI6+10V+EQ7XV8nvrv08Ju+WbB11N2kQFm/yDxlGMPR3xFquczEU7rHZ
 Y7TqX7eB5wn7SbDx+HpD4GNNxUNRsFTnBZNPNmSPxqD7ikzpTlO4JektrWXV2BKxZrUU
 wBrBEeeeLd6zxExDFgqjQICg74X9FtHzmO1SKVNN4ZJZzE1TOEB2tvpEoKvLSwgPXYRk
 mMpLsICHjRFbzzCr7sqHM4iQBXFIPRoDIscjeXGYPmP5DBbczUg6wspaosaGQ/haqWC7
 Ue0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596859; x=1779201659;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ofshx5/G1dwS9t8TC8Tw6dk+VcQzubVaCoyEMeFaYjk=;
 b=RzVp7sqJ1pqn/55nsjUWasfiW7+67dAvU/3L5GXhu2W2hCZw41UXkFkTorz9mpA7Mr
 PhsJ9vtGPXr6VW62IcjcYwAD3MQz3p0Cp/5N0MeMF/7RZrNG2nJ+DGTZOU0gb2M8RQrP
 utrRI6m7dNEUuYa3wQQv2FhQrGxzhIxBqjKE+Tue0XXSFMO459LzNXwQ9Fim93PNFl4v
 134cTDgug4LkF2yN8kbEEFOpV7SSNLazsSMLQYmnHbPELhlm4A6ovC/XcGd2swI8nlO5
 sdZI9U3E7G34E7nUsdrNC/SvDk1Ne1gVEIw8zgfm7jM0LpWZy3nW6EmmTF+0OwCJhJ3j
 IVqg==
X-Gm-Message-State: AOJu0YzoEXN9FmCC0f5Gt6MEW1kpd4DU6xY6a/8EyfWMfxdikj3PvOZd
 y7Y/c6fGtkJHyzvCT5CVv1DO+tCsQtvl4IkySneRajbL0fVP2q/sB5Mz
X-Gm-Gg: Acq92OHD67DXDOSJUZ/tQbN0U/TJa6abpO/iBZ72sA2da4PQc51Eurl5P1j4eHvK4dJ
 mu4ZSmgwWAK1J5dUiA3kdM5N262CIo8/zc0sM5rZJrJO9ph0BcHv+JlmiSNhBnO6jehWT3UTLBT
 TmapU4X1BYPruqfCvoXeZtW2FP6o0qAHhML9+kiFnRnG7GSebyH9/7sj8BAcJGmpp/8cKDsAxpu
 yQ0JbasB8o91zn7xRDTJMgALUWYrwzzUSqPPYfhiDRpCldUCVEm+nf7fPOTUh+leHa3YFJJbyrb
 4oBgbN/Ysi9Or8KbRSTMl5nm3cNYLrkkp2FBEptH7HMzxhrH+60jfR+LYhnwX8A6tAjnrR0Xqxk
 SFy4yGzpPuENe7EQMqzkLGBJZiATCAAqIvePOYfdjr8dSxoksdcxGgYks1DeGD72TaNNNv+2iho
 URVTlZ0yllzqnVMcQAVq7VihMOM0Zze8x9PGRpkJUAxAEvk7KYoltvNtCpkEZoJFoQoYefJwzM
X-Received: by 2002:a05:622a:4ccc:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-51461f9e47fmr413642881cf.36.1778596858564; 
 Tue, 12 May 2026 07:40:58 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e7bf7e4sm120881711cf.17.2026.05.12.07.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:40:58 -0700 (PDT)
Date: Tue, 12 May 2026 22:40:42 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 04/10] .agents/skills: add qemu-build skill
Message-ID: <agM64b07ygnlb57_@ZEVORN-PC.localdomain>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511170500.124211-5-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x742.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, May 11, 2026 at 06:04:53PM +0100, Alex Bennée wrote:
> This provides basic instructions for building QEMU.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - drop ECA/qemu-helper-agent sub-agent language
>   - mention configure --help
>   - drop mention of full paths - not needed for compilation
>   - moved earlier is series so code-reviewer can refer to it
> ---
>  .agents/skills/qemu-build/SKILL.md | 50 ++++++++++++++++++++++++++++++
>  AGENTS.md                          |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 .agents/skills/qemu-build/SKILL.md
> 
> diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-build/SKILL.md
> new file mode 100644
> index 00000000000..91819a0992a
> --- /dev/null
> +++ b/.agents/skills/qemu-build/SKILL.md
> @@ -0,0 +1,50 @@
> +---
> +name: qemu-build
> +description: Provides step-by-step instructions on configuring and building QEMU. You MUST trigger this skill whenever the user asks to build QEMU or debug build failures. It includes critical details on build directory reuse and spawning sub-agents.
> +license: GPL-2.0-or-later
> +---
> +
> +# Instructions
> +
> +## Examining and Re-using Build Directories
> +Before creating a new build directory, check if an existing one can be re-used. QEMU uses out-of-tree builds, typically in `build` or `builds/` sub-directories.
> +
> +1. **Check existing configs**: You can examine how an existing build directory was configured by checking its `config.log`. Run `head -n 2 builds/<dir>/config.log`. The second line typically contains the full `../configure` command line used.
> +2. **Re-use and Reconfigure**: You have latitude to re-use existing directories when appropriate (e.g., `builds/debug` which is a general-purpose debug directory for whatever is currently going on). If an existing directory has the right flags (like debug/sanitizers) but the wrong target list, you can reconfigure it to keep the same config but change the `--target-list`:
> +   ```bash
> +   cd builds/debug
> +   # Check the old config.log, then re-run configure with the new target-list
> +   ../../configure <old-flags> --target-list=<new-targets>
> +   ```
> +
I tested it, and it works okay. Maybe we should add builds/ to .gitignore to
avoid accidentally committing multiple build cache files.

Tested-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> +## Launching Builds
> +**Crucial**: You MUST NEVER run builds directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent.
> +Pass the specific build commands, along with the required working directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
> +For example: `task: "Navigate to builds/debug and run ninja. If it fails, report the exact compiler errors."`
> +
> +## Configuring a New Build
> +If no suitable build directory exists, create a new one.
> +
> +1. **Create build directory**: `mkdir -p builds/test-target; cd builds/test-target`
> +2. **Basic Configure**: `../../configure --target-list=[list of targets]`
> +   - Common targets: `x86_64-softmmu`, `aarch64-softmmu`, `riscv64-softmmu`, `x86_64-linux-user`.
> +3. **Common Options**:
> +   - `--enable-debug-info`: Include symbols.
> +   - `--enable-debug`: Enable assertions.
> +4. **Sanitizers**:
> +   - `--enable-asan`: Address Sanitizer.
> +   - `--enable-tsan`: Thread Sanitizer.
> +   - `--enable-ubsan`: Undefined Behavior Sanitizer.
> +5. **Help**:
> +   - `--help`: will give a comprehensive list of options
> +
> +## Building
> +**Important**: Always re-run the build after making changes to the source code.
> +
> +## Reporting Results
> +**Crucial**: After completing the build task, provide a concise summary of the results to the user.
> +1. **Summary**: State whether the build passed or failed.
> +2. **Failure Excerpts**: If the build fails, include relevant excerpts from the logs (e.g., compiler errors).
> +
> +## Debugging and Environment
> +- **Verbose**: `V=1` for detailed output.
> diff --git a/AGENTS.md b/AGENTS.md
> index 74516c378ed..08bfe13ebd2 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -25,6 +25,7 @@ security stance. In brief:
>  ## Agent Skills (see `.agents/skills`)
>  You should use the following specialized skills for common tasks:
>  - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
> +- `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
>  
>  ## Source Code Layout (see `docs/devel/codebase.rst`)
>  - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
> -- 
> 2.47.3
> 
> 

