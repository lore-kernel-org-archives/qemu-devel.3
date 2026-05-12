Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5EDCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdhF-0004W5-6M; Mon, 11 May 2026 23:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMdh7-0004Vl-IM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:22:07 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMdh4-0005SI-1D
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:22:04 -0400
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8b4298d271fso86114286d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778556119; x=1779160919; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eGfV2/vTXEdeMnt0fEmEIMviVA/mktYH4BxoVLnlOW0=;
 b=rL3RiY0AvuQiUiajRhNTBTyS0iGEJyHS2eC34Oj6cD1J5rUd020Fj8oHcJz/4k3Qmo
 EuIVpx2HJFD7FmerPv89xj37CanCYqIKBN5a3TYGRthTx9J3StV4l52kgWlr3wRN0Rax
 7ci6+7KeHHISPgDDWgChVSOJUSsT2/UOjprEUuBUPq4NAZ7AmLV/Sv003hMB9IV6bgeE
 +g7WfSOt0sO0kNnKiVbtVhan2FDjwOuoA1b/xSIqq+WJzksnwvIU17HBwQqdnp9xzaXp
 prY+MZ+82Z6Ck09QnFQrNObpgiA63VmUEU7M4fj1FxSfdOmDf5Jv62UzZBmhSsb83Hay
 tfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556119; x=1779160919;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGfV2/vTXEdeMnt0fEmEIMviVA/mktYH4BxoVLnlOW0=;
 b=i828c6h9javQjIlK9XPYliZnURDY1y+NEr9hm+nOsZWWVKrKrvv0FiypUy8w13xINM
 03osCPRU2wUF5QMdSAM/TTnqqVEeOu4gIn3C+3mwJ5/aopLNW9Iei/RGXXTF2Xmovt2X
 PG4IesxEqu1+KKDeCLi/D3KNu3VQd3MaJASyGTmtKciU4XU5vbRUeDbuRqGWfgNyPmJC
 BnDpZA2d5NCRiFqexafD2Ile8jJX32x5lOUwwnzhGL+fXvP1P/8Kcl1X/hKc75COVEZF
 h7dEs5eVSXL8q5xSviiu2q+atfPJMyIOq3M8MKxd1TtsVDGWu9je5SVjYp5qTP7oPBpA
 ghSw==
X-Gm-Message-State: AOJu0YxtlTUcEqt8pVffGcbURmCvvb8U7OaU+h/RgIh2lM7/KAarEARJ
 h17AmgHLmKzVP/FRKqHyRUyWIoUw5ZmF9O4yLKM12J6OHsIh9IpvaOSp
X-Gm-Gg: Acq92OFSg2myt/Yf/2txjumy+rdnm7htod4smTB408mnNl2WYq9aXcKDdRXzZ1s1dbU
 lRf2/MpVL1PFM6Fj3SjTc8J+d2ZqQD5TwYd7AYdu91DUDOtQ+rqmQGyiltQUISQsx4io6NzfhOI
 f0meKK+fBBue7MA/M5JWLQ010Em8GBUNDwJbA9TnlEMzg4aw8vrNyFve1A3UsGeLp+1GkhSym6A
 rRZtrY9uaVVd69aMJtn7iU1PvpKIPYCRX6FjwD+wvYAk0JE51uxkR1Xh/RHP0riglWLnBu7dzn6
 9+io1R47qXHPM0Yw8PMTbVbKznnR7LXI2QrQMj54FF6SrTAxsN8fgdVIFcq55q/aoyPzDaqKG2C
 cDCNAwIWybmq7RzMAJtzDHeuWWFu7LhKgX076WzKLhNFVtqg8RPNkr2329gDlsAekAueXq2kdie
 NzH/3DuC3wyxCsiKAanovxY+Q2q5igZmOPrG1CiA09/qR5X3t8Xl/nnoTvHwmQ1ge6FDq0+LDD
X-Received: by 2002:a05:6214:3308:b0:8bd:59a6:41f4 with SMTP id
 6a1803df08f44-8c660d1c59dmr19599466d6.9.1778556119327; 
 Mon, 11 May 2026 20:21:59 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d450dcbsm332373206d6.45.2026.05.11.20.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:21:59 -0700 (PDT)
Date: Tue, 12 May 2026 11:21:46 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 06/10] .agents/skills: add qemu-code-reviewer skill
Message-ID: <agKZ1Pd0KskNZdtd@ZEVORN-PC.localdomain>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511170500.124211-7-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf41.google.com
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

On Mon, May 11, 2026 at 06:04:55PM +0100, Alex Bennée wrote:
> This provides basic instructions for how to download and apply a
> patch series from the mailing list.
> 
> Currently it is only taught about checkpatch but we could consider
> adding common code smells and review comments that come up frequently.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - merge checkpatch skill
>   - moved later in series to leverage build and test skills
>   - properly reference qemu-build and qemu-tester skills
>   - mention the qemu-code-explorer skill for navigation
> ---
>  .agents/skills/qemu-code-reviewer/SKILL.md | 93 ++++++++++++++++++++++
>  AGENTS.md                                  |  1 +
>  2 files changed, 94 insertions(+)
>  create mode 100644 .agents/skills/qemu-code-reviewer/SKILL.md
> 
> diff --git a/.agents/skills/qemu-code-reviewer/SKILL.md b/.agents/skills/qemu-code-reviewer/SKILL.md
> new file mode 100644
> index 00000000000..48ec6b07520
> --- /dev/null
> +++ b/.agents/skills/qemu-code-reviewer/SKILL.md
> @@ -0,0 +1,93 @@
> +---
> +name: qemu-code-reviewer
> +description: Pull and apply patch series from mailing lists for review and testing in QEMU, including style and build validation.
> +license: GPL-2.0-or-later
> +---
> +
> +# QEMU Code Reviewer Skill
> +
> +This skill provides instructions on how to retrieve patch series submitted to the QEMU mailing list (`qemu-devel@nongnu.org`) using `b4` or manual methods.
> +
> +## Using b4 (Recommended)
> +
> +`b4` is the preferred tool for working with patch series from public-inbox instances like `lore.kernel.org`.
> +
> +### 1. Fetching a series
> +To download a series and prepare it for `git am`:
> +```bash
> +b4 am <message-id-or-url>
> +```
> +This creates a `.mbx` file containing the entire series, properly ordered.
> +
> +### 2. Applying a series directly
> +To apply a series directly to your current branch:
> +```bash
> +b4 shazam <message-id-or-url>
> +```
> +This is often the fastest way to get a series ready for testing.
> +
> +### 3. Creating a local branch for the series
> +```bash
> +b4 am -t <message-id-or-url>
> +git am ./*.mbx
> +```
> +The `-t` flag (or `--trust-all`) can be useful if you know the source.
I suggest using the git worktree command for workspace isolation before
applying patches.

> +
> +## Manual mbox Retrieval (Alternative)
> +
> +If `b4` is unavailable, you can fetch the mbox manually from `lore.kernel.org`.
> +
> +### 1. Locate the thread
> +Find the patch series on [lore.kernel.org/qemu-devel/](https://lore.kernel.org/qemu-devel/).
> +
> +### 2. Download the mbox
> +Every thread on lore has an `mbox.gz` link. You can use `curl` or `wget`:
> +```bash
> +curl -L "https://lore.kernel.org/qemu-devel/<message-id>/raw" -o series.mbox
> +```
> +*Note: Appending `/raw` to the message URL usually provides the mbox format.*
> +
> +### 3. Apply with git am
> +```bash
> +git am series.mbox
> +```
> +
> +## Post-Application Steps
> +
> +Once the patches are applied, you should perform initial validation:
> +
> +### 1. Style Check
> +Run the QEMU checkpatch script to ensure the patches follow the project's coding style.
> +
> +- **Check applied patches**:
> +  ```bash
> +  ./scripts/checkpatch.pl master..HEAD
> +  ```
> +- **Check a specific commit**:
> +  ```bash
> +  ./scripts/checkpatch.pl <commit-hash>^..
> +  ```
> +- **Check a specific file**:
> +  ```bash
> +  ./scripts/checkpatch.pl -f <file-path>
> +  ```
> +- **Strict mode** (often required for new code or specific subsystems):
> +  ```bash
> +  ./scripts/checkpatch.pl --strict <commit-range>
> +  ```
> +
> +### 2. Build and Test
> +Refer to the `AGENTS.md` or the `qemu-build` and `qemu-testing` skills for build and test instructions.
> +- Ensure you are in a clean build directory.
> +- Run `ninja` or `make`.
> +- Run relevant tests (e.g., `make check-qtest`).
> +
> +### 3. Reviewing Patches
> +Refer to the `qemu-code-explorer` skill for navigating the code base and resolving functions and where they are called from.
> +
If the patches have multiple versions, should we ask the agent to summarize
the review history of the previous versions, as well as briefly summarize
the discussion across the current patch thread? This can be easy to miss
during manual review, but an agent can handle it well.

However, this seems better suited as a new skill.

Thanks,
Chao
> +
> +
> +## Common Troubleshooting
> +
> +- **Applying fails**: If `git am` fails due to conflicts, you may need to use `git am --3way` or manually resolve conflicts.
> +- **Missing dependencies**: Ensure your tree is up to date with the base branch the patches were intended for (usually `master`).
> diff --git a/AGENTS.md b/AGENTS.md
> index d9d1964d45a..fbbc3b65ed0 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -27,6 +27,7 @@ You should use the following specialized skills for common tasks:
>  - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
>  - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
>  - `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
> +- `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
>  
>  ## Source Code Layout (see `docs/devel/codebase.rst`)
>  - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
> -- 
> 2.47.3
> 
> 

