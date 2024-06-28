Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4397CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNE33-0006BP-VA; Fri, 28 Jun 2024 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE31-0006Ab-8J
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:02:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE2z-0003Gd-89
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:02:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so5180395ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719590519; x=1720195319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u1zBg2dSlMJBfyzgYydD9HYz4rygSlRXEQ+WL6SO1+M=;
 b=JWLVTEboONZoRmphKES9e1VgKbpTs7pUWIGjJzQUmEchdSs0fVh7gxAQPLpfWg/WBk
 36mRRes9vM4EJlmvqGJ4SVH53Q96/YWkSBZVEEu7PuZDTQ9jJIVXZ7xl9mRzmPgPmawW
 Rt8K5ZiomCFh/aDhDFbQhF26tXDbTNI+zAwElgMR6/2D5ezts6NJevUdS7zBhmFta9V0
 fQfx4QUUxR4gIq/qKOHpVLCyuJ/D0sBZfK6GjAs5/4zni4fTfVnsljYqq5qG39ibTisw
 dDMPUGqidMizD+kdw8wIO24AkKrfENZQQctRZbGKtMHI8ZM0B51I0o1s6JU2+KOSyF6l
 zwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719590519; x=1720195319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1zBg2dSlMJBfyzgYydD9HYz4rygSlRXEQ+WL6SO1+M=;
 b=YWy8bNBa/RVFgiNOFmKcAMF+YiqYfq7N2KTB0c6MsA547qXqiLquuv3pQ9WW1TkdoM
 RfdZcVA6K9qMEacRJdevP/Xu3w6lkumE0dKN5aIkXPdeBsqOg1EPn5WV7knY5JXHSvBO
 TdjyKtnlSRFB/HTxjzG5O/xfYQeCbFQJhaPlqe+R87E2mtdusOdztb6uVfx9D5mkR28Y
 Hg/Ta8Wi51+P8kY3nsxEzbk/4bEbqZnOEzS2myJ9/MxC1gs2IlujndNvG/Nx4ckifnpD
 o9tZB5+9jrmki42Fq13eNkzBAUtUN3cbEGRazCSuk42iga9Lc/58QH5Pxu4NZz7hSlwr
 XqBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwg/xBG4JZcG+DI2yr2oidfPLKFfAU47aWzPL2sTg2K/uIjuMG+xMb2k9WduOdyALSdIsc1ijzPQUFeKeScj6Zx8xhggw=
X-Gm-Message-State: AOJu0YxfEQuR2whxjoUV4Nzp98U0XnATHrP85g6NSduzv0yHeEtPC4/C
 0amHyuqC5R8Yv3yDOJP5sTHoIinXhCwdz7RRg5GOmFRKSSDqddWUucPJZdDwu5c=
X-Google-Smtp-Source: AGHT+IGHY7z7pDh/dMHWgKIDwsFha8ICFDnUneIbnvUvKpE5WluTVOis/+njPLOr8jarUq2X6ySxyQ==
X-Received: by 2002:a17:902:f64f:b0:1fa:292f:cb20 with SMTP id
 d9443c01a7336-1fa292fcdabmr186282475ad.58.1719590518715; 
 Fri, 28 Jun 2024 09:01:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d1ccesm17400135ad.20.2024.06.28.09.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:01:58 -0700 (PDT)
Message-ID: <ea780763-ffb8-4a97-8a60-5128f1ed017e@linaro.org>
Date: Fri, 28 Jun 2024 09:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/arm: Support migration when FPSR/FPCR won't
 fit in the FPSCR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/28/24 07:23, Peter Maydell wrote:
> To support FPSR and FPCR bits that don't exist in the AArch32 FPSCR
> view of floating point control and status (such as the FEAT_AFP ones),
> we need to make sure those bits can be migrated. This commit allows
> that, whilst maintaining backwards and forwards migration compatibility
> for CPUs where there are no such bits:
> 
> On sending:
>   * If either the FPCR or the FPSR include set bits that are not
>     visible in the AArch32 FPSCR view of floating point control/status
>     then we send the FPCR and FPSR as two separate fields in a new
>     cpu/vfp/fpcr_fpsr subsection, and we send a 0 for the old
>     FPSCR field in cpu/vfp
>   * Otherwise, we don't send the fpcr_fpsr subsection, and we send
>     an FPSCR-format value in cpu/vfp as we did previously
> 
> On receiving:
>   * if we see a non-zero FPSCR field, that is the right information
>   * if we see a fpcr_fpsr subsection then that has the information
>   * if we see neither, then FPSCR/FPCR/FPSR are all zero on the source;
>     cpu_pre_load() ensures the CPU state defaults to that
>   * if we see both, then the migration source is buggy or malicious;
>     either the fpcr_fpsr or the FPSCR will "win" depending which
>     is first in the migration stream; we don't care which that is
> 
> We make the new FPCR and FPSR on-the-wire data be 64 bits, because
> architecturally these registers are that wide, and this avoids the
> need to engage in further migration-compatibility contortions in
> future if some new architecture revision defines bits in the high
> half of either register.
> 
> (We won't ever send the new migration subsection until we add support
> for a CPU feature which enables setting overlapping FPCR bits, like
> FEAT_AFP.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/machine.c | 134 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 132 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Not ideal, as vfp_get_{fpcr,fpsr} are called 3 or 4 times during migration.  But unless we 
have separate 'fp*r_migrate' fields in cpu state, initialized in pre_save, there's no 
getting around it.  And I suppose migration isn't exactly performance critical.


r~

