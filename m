Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDD6CD1292
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 19:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtY7V-0006rx-QP; Sun, 07 Apr 2024 15:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtY7U-0006rU-Pw
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 15:24:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtY7T-0001Wp-Cx
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 15:24:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e40042c13eso2106605ad.2
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712517838; x=1713122638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q+8qkq1XPIUbenDF5k3epgzNpnV8qvT0XoLa6h+bGqA=;
 b=DsmucruZUPOZYgpMz41aeEh6Avt6FbSppgMrMq2iALJOn+3V2r6H4at9/DeUrSIpTt
 AYNEFS2ZFYpOBdfj+sb3fFH2va3PNTQV+1XzBtEMhxSwpCSokK+2VLqFrOK9Iziqn1Ng
 45kcPFZkETiNyWZGz2JeqxCJXQC7SMR79lo5CbMpXYOFu/fM8jNghYnWNxb7uu71vVyR
 N86pCRGKljVTwJwzP+zRbk4aCpVQB1QkdUN3NofuBE+z1mfsZua8ZOTZOmIaPwu+4bMj
 3sETN69tzS44IlDqpwLKVE/wNS1+tli5FkE+blIrmR6UTWQaQi8NDlWDFT5fIiOeP2mY
 E3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712517838; x=1713122638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+8qkq1XPIUbenDF5k3epgzNpnV8qvT0XoLa6h+bGqA=;
 b=W4HByDB2Xkc6Y/qyxFBPWb3WirnqGFYRdB8JF5tfGGnx0CBT8lKLvIpGBlwiEg8YS8
 or7QQ0zmr4/2jLtKNP3Z9ipJa+VVIhAqPUfGsZSrGyN5VfJF6VifjPjZaNPZ5NhMju8A
 48qZLN/oFTSEcblrRijLzweqqMzaSwkzrf+6omsW++WwDcQpHcouDpPiyWQmEixk4Wk7
 xL5IVatjvWkAYe1Pm9D8PEGp8ACXu7DxT+yZcrWeBNtvqGdMq82lskahc1tii2b93wOC
 tcgCG14PbQga3rxx+6HESlj/yn33n3hda40YQO+vZEhRzSgx1Sa6hC85em8ic35JzORA
 mGvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp/i/Yq1aT7zS1eHpbIQPn5XRshpYZPQgtuq1/kD0qRm0ubArz8PHxXdhZeRA4v6tou010plBBIdMWeW7CqXVWYcD0WlE=
X-Gm-Message-State: AOJu0YxRsaded9TlI/iDkzYfggwLv6UddpvQRmBiGHPTQJs1FvO+P5Fr
 IaEbvdfSq8f2TfcmNV+gjECOpZvWnq6uLJTRMnMEaKs302UtSSdZwpxHm0qPtaA=
X-Google-Smtp-Source: AGHT+IGMBX9F2j5I+DfvEwL91Bbtv+6lrCRudB/bQDOffjb4me4GDulrQ2wMJy+VzmUyHpNglPCf/g==
X-Received: by 2002:a17:903:41c1:b0:1e3:f622:f22c with SMTP id
 u1-20020a17090341c100b001e3f622f22cmr2068941ple.47.1712517837835; 
 Sun, 07 Apr 2024 12:23:57 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a170902cec200b001e0b863b815sm5310571plg.96.2024.04.07.12.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 12:23:57 -0700 (PDT)
Message-ID: <6012a84f-155b-440d-aeb8-0df0678c3ee7@linaro.org>
Date: Sun, 7 Apr 2024 09:23:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: add missing CHECK_NOT_DELAY_SLOT
To: Zack Buhman <zack@buhman.org>, qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
References: <20240407150705.5965-1-zack@buhman.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240407150705.5965-1-zack@buhman.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/7/24 05:07, Zack Buhman wrote:
> CHECK_NOT_DELAY_SLOT is correctly applied to the branch-related
> instructions, but not to the PC-relative mov* instructions.
> 
> I verified the existence of an illegal slot exception on a SH7091 when
> any of these instructions are attempted inside a delay slot.
> 
> This also matches the behavior described in the SH-4 ISA manual.
> 
> Signed-off-by: Zack Buhman<zack@buhman.org>
> ---
>   target/sh4/translate.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

