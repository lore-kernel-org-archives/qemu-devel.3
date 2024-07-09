Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149CEC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBZL-00038c-FP; Tue, 09 Jul 2024 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRBZJ-00033a-9c
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:11:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRBZH-0007a5-Fk
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:11:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36794da7c96so3274653f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534301; x=1721139101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7vYtHKbZ2cJT8oGb2gM+7beXn/UcCM+JbgqbyZMXSw=;
 b=YDKHdJiB1wfJlpueIigdz3o6cJ2O6GtGjfgFWK0Ndfr9aacfvXpPCPShEgsFk6yOgQ
 n/H0EHB8pnkOGx8kZk1b4N5fxqRKwe1Aag5/wRipAvTYHIsuH4FZwENCTfbpvfxF7zFw
 fooOU+4AsRxpFhg4QOYMJvyK33depD05h+9G6YE+jrMhUctaDP4PXMn96N/M48309yS2
 TsV037EURvegsdsNpHq/chkg2bCH1o27EDEZctw8SqDk06bM5j+vA0qUdEubJWQFzTgV
 plHU/OknewfBUBXZVi9mhbYTNV9URg05M+nYVpb1I8oxtXHM8sL5Fltg9/WrU4n3dZ1z
 kPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534301; x=1721139101;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7vYtHKbZ2cJT8oGb2gM+7beXn/UcCM+JbgqbyZMXSw=;
 b=XnJIcWOPyI0+iIuUrLIZeu4QicbTFHpYMKYSs4ucEmGIl6e5Ul2z/6FW5knoeGQfMW
 q8AddjbsIigh8dskx7HjvzHhIST5F9x9WQv/f6v1v0OdF/zajsXeqBDy0kAXRZ0yPQ6w
 ZthTOhpImT/+vScDo/qES6hD32HQYWHm0KzXjHpc4me7TiyKkX+0cBEHLvmSkncdAGl6
 7ccKA6RAt5DWfoEoussY3OSqytNePCzAnXDxyzXKi0p6lcUkANJEyMza+g42y5RIE22H
 3Folsdp94CJgyGxYuSFbaEPzx05QDaNG7Tx3HiA6E/I4HNPwjD1qiq+Jat639vC0+M8u
 sMww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaCEI8XHF+gvMsfpEWCr5sq8F9DNTfjmrljQncecf1NvpXs4mf78nY4T+HBqf4uq6hPUXew/lhYV+qe4ULmK8FQqyl6yM=
X-Gm-Message-State: AOJu0YwC4jHdGag+cW83Dp8GIoogu2/wfWYJI9fZwFIKXvHDAV2cqBDv
 JQSuhqN6A0LhMFsekic3XuSC9lu/38zVBMiUQ5KK8Au30xTWN4pOEb9rhqXWvFA=
X-Google-Smtp-Source: AGHT+IEAmO/IQs+bt+XZhhXtxRgpnCwWUzh7aVxR8v12ABtQcGGAlUaDvCtpvFuSrGZu3A6Lop+KaA==
X-Received: by 2002:a05:6000:144a:b0:367:9279:c402 with SMTP id
 ffacd0b85a97d-367cea467eemr2549424f8f.1.1720534301620; 
 Tue, 09 Jul 2024 07:11:41 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa0666sm2672131f8f.73.2024.07.09.07.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 07:11:41 -0700 (PDT)
Message-ID: <448e03c7-9bf8-48f5-b172-36bb06ec1139@linaro.org>
Date: Tue, 9 Jul 2024 16:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Fix handling of LDAPR/STLR with negative
 offset
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240709134504.3500007-1-peter.maydell@linaro.org>
 <20240709134504.3500007-2-peter.maydell@linaro.org>
Content-Language: en-US
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240709134504.3500007-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 9/7/24 15:45, Peter Maydell wrote:
> When we converted the LDAPR/STLR instructions to decodetree we
> accidentally introduced a regression where the offset is negative.
> The 9-bit immediate field is signed, and the old hand decoder
> correctly used sextract32() to get it out of the insn word,
> but the ldapr_stlr_i pattern in the decode file used "imm:9"
> instead of "imm:s9", so it treated the field as unsigned.
> 
> Fix the pattern to treat the field as a signed immediate.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 2521b6073b7 ("target/arm: Convert LDAPR/STLR (imm) to decodetree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2419
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 223eac3cac2..f873e8bc8b9 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -520,7 +520,7 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
>   LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
>   
>   &ldapr_stlr_i   rn rt imm sz sign ext
> -@ldapr_stlr_i   .. ...... .. . imm:9 .. rn:5 rt:5 &ldapr_stlr_i
> +@ldapr_stlr_i   .. ...... .. . imm:s9 .. rn:5 rt:5 &ldapr_stlr_i

BTW I noted some instr formats use 'uimm*' for unsigned immediate.
Maybe we could recommend/enforce that, having 'imm*' always signed.

