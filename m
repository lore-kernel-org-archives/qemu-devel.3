Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D50C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xgp-0006wn-V0; Fri, 03 May 2024 14:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xgn-0006vD-0X
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:31:21 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xgl-0003Xp-1a
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:31:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a598c8661f0so257034066b.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714761076; x=1715365876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XZs8t0j3fAEKMhSvtfPfrS+leG6UHBcAjjedCWwf9y4=;
 b=SsrF+sqrqjTCUQMVb0SxJzXjXAQVROWtsKM1eToZmRKEA09NUnXZBTjqN0TGjmhxpf
 XQGn4FTUoMj0NwOySR9AVCS+hfcTe5KM6cFrJzg64T4qMm8XaV5bYU+x3oMzKx1OLFJ3
 IgKwB2IszpySY+RlCE2lilmlfhtj7CcvhtDuyduuMJTEuKVO8WVV4ALNTB/krQgySPqh
 tFagVcJ5vjFowgASP3NKJX2sCw5ygW1YP/QgB3RSPWzhLf/FdYzbL/R5UUx4uOVnAjUx
 iiTCP1KEAvBMndMCTrncj22lLaimXY8cmfhXYZob9mlM/x7wg+FU41LNWASTlS6FV07h
 XW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714761076; x=1715365876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZs8t0j3fAEKMhSvtfPfrS+leG6UHBcAjjedCWwf9y4=;
 b=cHicZgShjpvXtNJHpCPZ7LLy9J0orTY/MtC+aDdGmzT6rPK7zDRA4tVP4iUpHityzn
 WqfZqFvpoKHrCvSjf30VdrfsGmUcmdxLySrEI2WSIKiEcieOdW0zSo0hlR/roW7pujV5
 vN4DEC/OjZLUQE6qSHaV4+Ui0XvcEaG4BOGJss5M635WoQLharrPXdqDu3fbPRDJLdUl
 GsnyeP8igMGz8DSFyloU54wfmERnXUx1AX+J6TcJYWWTMnG22AqI4v6u4jAaiQtS7iDC
 hTKHg0M4mLNdBPHyZrsQdfdf2gFf3btXh4hmHhXzAluulvxIdTRlSwjOIRehY8UOkb8Z
 /KAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTjuyMt/eWmbyWW1GDjb8w3o8y5DB7XSz7XpxIeapwqnquB+1CUzTE9R3zvMDBo2DvWeZGzIZg8sP9Gp752RCnZBU9J2g=
X-Gm-Message-State: AOJu0Yz5oUye93l2f9+m0U6o6v0tn+DI4cDsqaPoZJoVx8jwDgGacYJ8
 fth4jmSWqF5ExXa91AXb9GiJutW90LpBBLABYhJ/0+7g78/XKp9TcqQUY6Ft/wE=
X-Google-Smtp-Source: AGHT+IFSwNFYQLv93bRY9OLmNEHetyArqNDJZhKytH2Klft2frWvKg1LWXDrpdobWOSVjOwavSmvzA==
X-Received: by 2002:a17:907:3f07:b0:a59:8cd2:5b2e with SMTP id
 hq7-20020a1709073f0700b00a598cd25b2emr2529797ejc.38.1714761076015; 
 Fri, 03 May 2024 11:31:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a170906689900b00a58d0a68608sm1978348ejr.136.2024.05.03.11.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:31:15 -0700 (PDT)
Message-ID: <d7903c81-2062-4abb-a8ee-29d06ff877ef@linaro.org>
Date: Fri, 3 May 2024 20:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] target/sparc: Fix FMUL8x16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 2/5/24 18:55, Richard Henderson wrote:
> This instruction has f32 as source1, which alters the
> decoding of the register number, which means we've been
> passing the wrong data for odd register numbers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/translate.c  | 21 ++++++++++++++++++++-
>   target/sparc/vis_helper.c |  9 +++++----
>   3 files changed, 26 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


