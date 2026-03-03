Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB485EDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVJ0-0000wg-SU; Tue, 03 Mar 2026 14:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxVIl-0000qP-9K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:21:03 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxVIi-0000ii-DU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:21:02 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3598b95ad7dso1944658a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772565658; x=1773170458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FwrEeMC7PH4DkkcUv/KYmi+1n/SPYDKuQvG9A7/hxIk=;
 b=RxrEChBsIb9F7PyQfMUB/unRSIjJQKvh2wPYLl0N8Hn8mKlPLK9fkU5ufFWzn8rHzL
 KfHy8reMo5wOZAZ9H8ONtn8guTjwCBo2Yz2RsmicakkX6Y5YsGTPu9fMQ3PhHZwvP+8S
 o7559GE//Rf2FiTarYzqhiypb5C/0sz3VC4C8sS9B7PKyHHEnz8R4Hq5tbY+Idd+mNHY
 X5CdXXEbtsQ/AYep9FHAdqu8ecLT/d+nIR61Mi1jL2huwZ8LyGz5eDnvbHFyMFurzsTe
 yfqMN4A4ml0fiOtRA10jizcsoi/SQNcic6Pf8cHPUXI2TLktjJ0fzTzkXwi9wHHNAG1Q
 DLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772565658; x=1773170458;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwrEeMC7PH4DkkcUv/KYmi+1n/SPYDKuQvG9A7/hxIk=;
 b=keJwGE6epc6hmQEhfqoRHxF9JlgI6GBfIwHJY1hABEbM59c9R5Hp4tDwTfVuHxNtRi
 ClYQn+DSbDxrOYFrZTGeJ8v2Ruc6Du2W7+REdQPRjJglGMPFcksOnxfSWaHNdPEK+W4f
 djRcsnMnWfvDHNZx2mtaGS+hzbOxg/lmPn+gnlZ1Td1ZVUyvt3AEgXUjVXMbJSwqQXbu
 8ZpNtbOezNVqzp6Amavi5Nawb4CXdmGo1uAYs9eiFzxDxaTBOyYeUuxcKsYItBrp2n1X
 DxdpTDooH8c2BpDaCzZEl15MAnQ5twrfU7xuO6GL9s6dYa9hNusaF04KdayXt7WFvy4C
 oHXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXidfEkwLPcF1XhKGym5RZEw8UysB4Wx3KGBzwpswkvCxmtMGukAM0+i2H+HE7b9xOWzxWmm4wLQhDc@nongnu.org
X-Gm-Message-State: AOJu0YyyCTa203HYGhALTEflbyYn3h4aMB9aIC9GBqGegGePDc58hN8a
 7OE/X5A9OoVUP+Ms8uj/6RqXiWJqYHtOGeJ4iT40/lMhwNgEikT/F2zNeEYNWlhs59E=
X-Gm-Gg: ATEYQzxCntmE+o4q7YXDsgpHlahCeXQFPevLjHKlmmIdpjJaq8jN3M+79ss1nUig02w
 3IFs9kumBm2fTRe1Sxv5zykaLVAA2/5oVBAU87cGIcZ4InFk7VfixRSnEe1NphlAZnct2fp6956
 0WReLyGutJZQJIFlkjQmcju/aJ72A32qFHcNuN4jNfp5RWo18c37x53cloAEwk4sLhbKEt2cHdN
 hESjV3UKg+mQvIIKWYCVXKGchSwmJXZA3KB7Oud9fusd2imXYK2sPoRiVQh0dUfPJA0W/YnGvar
 5Kqeh90QzN7mb+WCVabVbHluHn2jCqPObJ+WBrawYW0KifR8WAeDVYo4rP/Wa+GhoII4gIDJxO4
 ONrCOr5+aGTF5MgGU3h3d7oriEOAnQ/NinaHz6fc11k8Re2bX/Nj4fKN4bo6Px7cvEMlUq9A+cE
 l6EQeAInAZaB+dWntwsvCGWzYR4IBXhklPmCLXFInFIxeOw33vr+S7Ij2I6RSBSk7dwSgp
X-Received: by 2002:a17:90b:4b8f:b0:34c:fe57:2793 with SMTP id
 98e67ed59e1d1-35965ccf181mr13897111a91.20.1772565658032; 
 Tue, 03 Mar 2026 11:20:58 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3599ca38be9sm2120476a91.4.2026.03.03.11.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 11:20:57 -0800 (PST)
Message-ID: <acd9b835-ae52-42aa-87f8-9fedccd79d04@linaro.org>
Date: Tue, 3 Mar 2026 11:20:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v6 0/7] Enable PC diversion via the plugin API
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 3/3/26 5:07 AM, Florian Hofhammer wrote:
> Hi,
> 
> This patch series builds on top of the discussion from the thread at
> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/
> and adds a plugin API function to set the program counter of the guest,
> as just writing to it via qemu_plugin_write_register() has no direct
> effect.
> 
> This version v6 of the patch series addresses the requested changes from
> the previous v4 submission and an incorrect commit message from v5
> (details below).
> Note: checkpatch.pl still reports a warning about line length violations
> in patch nr. 6/7 but I did not fix this, as the line was already > 80
> characters long previously, the change added only a single character,
> and I think the readability of the code is better as it is now. Please
> let me know if you disagree and would like me to fix this!
> 
> Best regards,
> Florian
> 
> Changes:
> v6:
> - update commit message for patch 4/7
> v5:
> - make QEMU abort via asserts instead of just returning an error from
>    the plugin API if preconditions are violated
> - extend tests for qemu_plugin_set_pc() to different contexts
> - fix issues highlighted by checkpatch.pl
> v4:
> - switch strcmp out in favor of g_strcmp0
> - split the patch introducing the qemu_plugin_set_pc() API into three
>    patches, two for preparing the plugin infrastructure and the syscall
>    handling code and a third introducing the actual plugin API
> v3:
> - make PC registers read-only across architectures
> - add tests for read-only registers
> - adjust test structure for qemu_plugin_set_pc() by moving
>     architecture-specific tests into corresponding directories
> v2:
> - add setjmp() in syscall handling path to allow PC redirection from
>     syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>     exiting a TB would not be live anymore in syscall handlers)
> - add flags to ensure the qemu_plugin_set_pc() API is only called from
>     contexts where the CPU is live
> - add test for qemu_plugin_set_pc() API
> v1:
> - initial version
> 
> ---
> Florian Hofhammer (7):
>        plugins: add flag to specify whether PC is rw
>        linux-user: make syscall emulation interruptible
>        plugins: add PC diversion API function
>        tests/tcg: add tests for qemu_plugin_set_pc API
>        plugins: add read-only property for registers
>        plugins: prohibit writing to read-only registers
>        tests/tcg/plugins: test register accesses
> 
>   MAINTAINERS                                        |   1 +
>   include/plugins/qemu-plugin.h                      |  19 +++
>   linux-user/aarch64/cpu_loop.c                      |   2 +-
>   linux-user/alpha/cpu_loop.c                        |   2 +-
>   linux-user/arm/cpu_loop.c                          |   2 +-
>   linux-user/hexagon/cpu_loop.c                      |   2 +-
>   linux-user/hppa/cpu_loop.c                         |   1 +
>   linux-user/i386/cpu_loop.c                         |   8 +-
>   linux-user/include/special-errno.h                 |   8 ++
>   linux-user/loongarch64/cpu_loop.c                  |   5 +-
>   linux-user/m68k/cpu_loop.c                         |   2 +-
>   linux-user/microblaze/cpu_loop.c                   |   2 +-
>   linux-user/mips/cpu_loop.c                         |   9 +-
>   linux-user/or1k/cpu_loop.c                         |   2 +-
>   linux-user/ppc/cpu_loop.c                          |  10 +-
>   linux-user/riscv/cpu_loop.c                        |   2 +-
>   linux-user/s390x/cpu_loop.c                        |   2 +-
>   linux-user/sh4/cpu_loop.c                          |   2 +-
>   linux-user/sparc/cpu_loop.c                        |   4 +-
>   linux-user/syscall.c                               |  16 +++
>   linux-user/xtensa/cpu_loop.c                       |   1 +
>   plugins/api.c                                      |  42 ++++++-
>   plugins/core.c                                     |  29 +++--
>   tests/tcg/arm/Makefile.target                      |   6 +
>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>   .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>   .../{ => plugin}/test-plugin-mem-access.c          |   0
>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++++++
>   tests/tcg/plugins/meson.build                      |   2 +
>   tests/tcg/plugins/registers.c                      |  79 ++++++++++++
>   tests/tcg/plugins/setpc.c                          | 120 ++++++++++++++++++
>   31 files changed, 495 insertions(+), 42 deletions(-)
> ---
> base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
> change-id: 20260303-setpc-v5-c1df30bad07f

Hi Florian,

it seems like there is a small issue building documentation with this 
series, which should be trivial to fix.
https://github.com/p-b-o/qemu-ci/actions/runs/22632339221

For v7, you can run this by yourself before sending the series. It's 
easy, quick and instructions are here:
https://github.com/p-b-o/qemu-ci?tab=readme-ov-file#qemu-ci

It simply saves time by making sure we don't need to pull, build and run 
any test by ourselves. If any failure is left when making a pull request 
on GitLab, it will be our personal responsibility to fix it.

Regards,
Pierrick

