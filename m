Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CC606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Kr2HZs75
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLpcL-0002Sa-7l; Tue, 27 Oct 2026 18:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLpcG-0002SG-8K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 18:26:00 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLpcC-00039e-Rw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 18:26:00 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6fe4372c5f3so289788eaf.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793139954; x=1793744754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DTrArx4Wg5lkx68TXL73TFXJli23Uy3pE3zSZ0XVCR8=;
 b=Kr2HZs75d7MWEP7j4HagAZdTuljpvsKfq2f4x0bh1bvrqwR99PF5ygoe36bTOsZoYH
 haRml3jO4ok97XZrxzLe9asWTpxnZ15WGo7EPmnMq3Fu4oPwe7G7HSTPyNyE9Mb6RFTO
 IoiogSX6b3I0WxSnIt7i6JPQlEOttZvFqsTI3QAtq3iGTDhzckj79gvMPPDj/eyjBKU3
 Ji4oZcL/ijzwOpbd4MptlVFzmttwmFmkkJg2gtDWPWy5JBmtSKm+LYVucGnsCGmtPKVA
 yYCJsFBE0zrTm8g7DIdUZPKRA4EHzdk4OI36ODdUipxv5kbXD8A1vdnKVL05D8iKzTNk
 1L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793139954; x=1793744754;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DTrArx4Wg5lkx68TXL73TFXJli23Uy3pE3zSZ0XVCR8=;
 b=nc5eXtQ2Ej1YvyO5g90iB2996atPmszlF+ea7tU2lTgCPUQwtaDqHrl3NqV+vXabU4
 yCvInh63aa6mWLqZTzsgNdMXvwc5vLLH3oCJZApiGmXHg0+rKoMt7BVzWuGqru3n+2Dt
 vkast3cp3z5mcrg16y926UWcj0gzFbPGpuTHazExiBfxXqRPOUG7tDzDu+d1CqYddCqf
 51FnrYxwf3v1T3CXIuXC/qDf4NNRGlVS8sq1IEMZFBq/J+7oIKFW6nqsCWLo31DDk1iu
 KkqUalCXkqmAnFpk7V+c9l9daLILOslTBxrIG5eWMmoKBVMM3Mr0f3txAM/8l9RYN/UH
 VZ3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc46qQQNNwG9hjRfPIufu3wudWXjezK4DprUQziLCS4wBcTkpkwVoZXRUDVLV2Fy5z911ywIXzn4d7@nongnu.org
X-Gm-Message-State: AFq9FYLwRN41748z6KK4o44SjhaUNoxbKHsWAzetw7oUmV7OeCczwrhx
 4UX8RDArWaMAuh2oOJn35Kz55+byiUuXDNmgsj788SCZuHXr98Kpr9q3ND+NMsmrX6dvmtcQv2O
 HFXD7
X-Gm-Gg: AYBFou2SKz0bmfXbS+O95/MVhDskdmsQZbrYwS/3NSm1NJDqpWoqZ+emudhxYIsF+Re
 /TujwtgCJ3zR8FQJAodSMqmvoYGFJvngt86lFGZ7V+U1TYIPUYHhb7TeaPB3irrNkqUn/NFKkiW
 wepmix8O8pV/BzXeBKqn2azp7Ta/kVhtOJpNs/YDbfAS+96CSScYFuIuvor9OS2b4+HhCOGI0ES
 PNJdH/7kB8YDH/gXUvEi70wTFEvnhJoo5hOnK/R07cBRebUyIT2S8CNpJE543e68LBEfREhnlkN
 /p2NvX1bK8F2Zyom/6hd0EhqiysZVWk0xrQd9wGOcKKQqyUQY0ZbysqFHWEjnnI1BbDvg03yXFX
 9PrQNEIvfEXk231dqAbn+Ss3RD5LOkzgcZMom/7DZ6435BYFCFvs/GLKFxAudlPpa37anJrbdxN
 di1xY1/zvB6x0aQQbt7ziQVsKdU54WiNravKk1oyLqaNEMXMSy3VQm8u8KrPYlvHdtknv0cQGF1
 4hZTSX85GWe2+vp19OzAZQzWVn4t+rk3d4rhmRO4RUBHMnqHKIkIP4JuLUOIQwvDyZ5KYM=
X-Received: by 2002:a05:6820:a299:10b0:70b:1217:4aa3 with SMTP id
 006d021491bc7-713eaf5bc42mr291951eaf.5.1793139953798; 
 Tue, 27 Oct 2026 15:25:53 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850f8458d8esm12219371a34.1.2026.10.27.15.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 15:25:53 -0700 (PDT)
Message-ID: <9d78d6fe-2e7a-4979-9fc9-77616a7102e6@linaro.org>
Date: Tue, 27 Oct 2026 17:25:51 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 01:27, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:
> 
>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261027
> 
> for you to fetch changes up to bf67d56f282c1ee25b67dfda3f8ca54d2bd4648e:
> 
>    target/riscv: Fix CPU state access on big-endian hosts (2026-10-27 10:26:46 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 11.2
> 
> * Add experimental Zvabd extension support
> * Mask vsepc according to IALIGN
> * Reset vCPU on VM reset via MP_STATE_INIT_RECEIVED
> * Improve modeling of the Atlantis UART
> * Fix IOMMU entry leak with ioatc-limit=0
> * Fix integer handling issues in k230_gsdma and k230_decomp_gzip
> * Reclaim invalidated IOATC entries for IOMMU
> * Duct tape fix for QMP and RV profiles introspection
> * Move RISC-V 'Z' CPU properties section to removed features
> * Use TSO barriers instead of full barriers for Ztso
> * Make mnstatus.MNPELP writable with Zicfilp
> * Gate envcfg CBO fields on extensions
> * Fix stale PMP state across reset
> * Use 1ULL for a value we're going to shift by 63
> * Remove unused IMISC macro
> * Encode debug translation ranges in IOMMU
> * Allow regular mstatus MPV/GVA writes again
> * Fix uninitialised upper half in pmu_timer_trigger_irq
> * Fix CPU state access on big-endian hosts

Applied, thanks.

r~

