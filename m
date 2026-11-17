Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDED606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iQEHLhyn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOUx-0006us-TO; Tue, 17 Nov 2026 14:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOUs-0006uM-MY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:05:40 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOUr-0001QS-5g
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:05:38 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2efddf749e5so6158425ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942335; x=1795547135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=reWDJSRJtSwzbbbMUztuEr255Jat88MCy8hS18RrQPA=;
 b=iQEHLhyn8MDYAB8ChsBhC60xiCHCTHoFSFe7ADiZcfcAzdpOuPlNyQE7EmPG9whSXM
 IScT2f7MQq0plHrvPIX0FeqrOM7ZEk+/HBEAiSkrV9nVmqVj2Xkh4akjOpGWDIVoS3No
 /KSo23744hXzUIg2PNy+9Z1d11rmK5Qc96vng+P7iaYWzX3YoZh6pyAwCCKxii8BzhCw
 TtJnPWHz/BoUI3BYXMpxnBFN7jkGDi+Z0/GI5rC5O9llwo8N9vnriFsmwcK+HW7ceRPF
 DIR/RL+PXlqJClyy+vobha8yDgZ8uXPBvsUtgrXlj/HegSljCoZqVxUxZs5SKYuJdoG+
 ggng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942335; x=1795547135;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=reWDJSRJtSwzbbbMUztuEr255Jat88MCy8hS18RrQPA=;
 b=IUbWo/Jik2WMOYqSaJqRGkCYCVTBsLr/88GGGCKIaJh+BZqQ6LWfl5/EMKBcy1XmUp
 iyvi+zm+aq3uaUQufZi0zV/fqXyTSHvaQPKmjrNiH5+Bwwf4+Ad2szbn50SgeoKqpokv
 iEegIEe0oFz8QmUELpFeVwWduXCGStswZj0dzEHxQt0lKjdKEB6yMc/vednSkUah3Fdz
 f8CZ6CeORbR7S7xok9PIDxjth1UDB0V4EVDCSdgSPZ6DSAM6CMMYMzc0JqEdVz5YfEda
 EPraF4xHqxR6q3pKdW2BSiKGR4lI+zxTbPaOxjc6gtjLDerOpVFVM1XWTlEhSCP7+wbu
 9RlA==
X-Forwarded-Encrypted: i=1;
 AL+hErE3jtp8CN/HVMZSr/1CoHeMqWpnNsjwy37+UAZ2pY0Eh2uggzm4XV30sDlefeluBokwJRxXHpIxfkz6@nongnu.org
X-Gm-Message-State: APuU4Z8uad/c68bHs+1CGgzdkedqTNlCpnZhQtmsHOYv56sck4MRshnb
 OZYMo+r8IzlmEzkVDkEA4prvcoqpHm5z2yS8SMbnxkx9//6FxmjF7NUAMz4NV0k3vW8=
X-Gm-Gg: AZFdTZfZFQulnFIyHyDHOAN+qWe1y/ekTIAK8jfhzzVeoTe9rOAO3c1Q8WXGu5DE8oZ
 0pd0SWrl6rxKOkwW5EUm4NYckszTS4cbboF18TyGLcwBVn9x1fhuS+eziMCU98Xc0JM5e0qFkz7
 eSLFDzS8+r1ZxpOUrZxPaBFH+6pMnIu2eG5p82F/Cl9jV4+7mDyk+razvQlQtcVBh0uF8DC/tSD
 91a0ieIvInMHu7blJZKZ1QnapGd/SANnm1eNaJ/erdjbmsWbSEu5j/c6+OqNu6Vn+DE14EOXpzu
 wZGR426mAWpKDMK9XNmv3hkHIPsi0gGQsN0RAM4rLxSrE4wIqFvFZj/s8zwcQR/FONT/CCD1qhe
 WKhn9MgBYT15GoxtqH8ZWPBPf0QPtIwyQLcm8s9VyIq6VHkjqQdy5x4MU1zJT5K5N80qcJ7ANtN
 Re1YsqjwOeQ/LroDl4MowKHisOmekKK1/kWgsoYtRWdTM+keMt0+hFNnRXCmnlDJrcfGrp5DhUe
 dXJ542yZlxzG9Z10saqJc29IoSSXSnEBIb6c3seWfn9Er3W3GAg9KHmv43Q7Dm2TcgvSX1PKp9R
 0e6FqQ5vVeFWMUhPSXZUv+vgmLML7il+SLa9oVgfMlv95U6EahkX8zMKdZGsld5Sf7COHeI=
X-Received: by 2002:a17:902:d488:b0:2ef:cfd2:ada9 with SMTP id
 d9443c01a7336-2efd9eee1ebmr27979645ad.39.1794942335224; 
 Tue, 17 Nov 2026 11:05:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6227103sm1672255ad.48.2026.11.17.11.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:05:34 -0800 (PST)
Message-ID: <35cd360b-5116-4f52-a9f9-6174b1ce4a08@linaro.org>
Date: Tue, 17 Nov 2026 11:05:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] target/mips: Enforce alignment and 64-bit CPU for
 the DSP LX loads
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The DSP LHX, LWX and LDX loads require a naturally aligned address
> and raise Address Error otherwise (MD00374 r3.01 p.130-131, MD00375
> r3.02 p.145). Use the default memop alignment mask for them (strict,
> except under linux-user FIXADE); LBUX is a byte access.
> The Octeon LX forms share gen_lx() and are unchanged.
> 
> LDX belongs to the MIPS64 DSP module only, but was decoded on any DSP
> CPU in a 64-bit build, including 32-bit ones such as the 24KE or 74K.
> Call check_mips_64() after the DSP Disabled check to raise Reserved
> Instruction there.
> 
> Fixes: 9b1a1d68d041 ("target-mips: Add ASE DSP load instructions")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

