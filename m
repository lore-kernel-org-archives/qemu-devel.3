Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAA4A-0000Ta-Tv; Thu, 23 May 2024 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAA48-0000TQ-NA
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:09:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAA47-0006GJ-2C
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:09:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44d2b3130so3477296b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716476949; x=1717081749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ej+R6rBRn85rnUfLrrq954boqYxI09Znpz6E2PNv2Lk=;
 b=v8Ixm4Gzf0zicJGMqli47/BlQ3BYMNJGMg6iYlbe2Iy8ZLX6Dxlje+P1VHfC51sCbc
 CRu0CHJ6Xvd9L/JeWA0il5KLFvlEdowWOEpYaFMv2QMja+od2If2XaKe55ZmeCe+4+kY
 3nPOUCnj5Dv1927+M76P/bsp7hAiM5F15/uz7CAVJAdctSb0xsx4Ay+TFsfWfuKFz+bG
 yU90uXiXKsAYsGoJ5qa5dBWtT1F34kjVNDfdIJndLe0JqLDcltwsl5rx3GE+CvHLJjWL
 opeaToOwE61ne21qFsdUdX4GQpwdFEk0dxPKt7ycRTa3m6Ic0xxeayynMJoYOqrdPU72
 D1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476949; x=1717081749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ej+R6rBRn85rnUfLrrq954boqYxI09Znpz6E2PNv2Lk=;
 b=v1EehMb/BiWyz94BPYcCrwVDZ0loD6vicnhYbA7THYY71bJ0ie+jdE157iiriC1Iwh
 rvVZ87FgpqM4ZFVjOWSos5dKVbPaL6f8c6JMiKYczfEIfGu5CKafaZwj0FMNlYLmHT+A
 B/WxxMz5VQADJrq3OwF4c0o1I5ulfpHMm9QHKKTLrjVd2gZjOmvSbpkPaS76PlhYXWNB
 gdEqhu5PllBADw3z4pTKDorgPj8HVYuRSpzf26p9tGP/CnkWHiE8cDtt45QKvk/5I7gL
 reZQG1PxHXQ08XcTLdmJNm6AMTso+Slfmh0BlSiQ2urdhdR61iVOg/qq5D8YESsbFr2S
 6n2A==
X-Gm-Message-State: AOJu0YwKzAi5bIf2QJU4f/d79kuPtnIB9WAKlEmsOHnQ5Y7Nroym4zeC
 UFyeEwB+otquneKa3k2i+WO1wH/X1i5i70GrC1gYCebfAyS8lsOv/yS38c3HP4M=
X-Google-Smtp-Source: AGHT+IElYYo9HukZ3nNKN7JW9oGxWAEXibnaS/j5sUYhOOXj+UVUJk79zEio9LlqCvM4glYzEi6Qdw==
X-Received: by 2002:a05:6a00:4397:b0:6f8:ddfe:8fcf with SMTP id
 d2e1a72fcca58-6f8ddfe9a0fmr27314b3a.13.1716476949555; 
 Thu, 23 May 2024 08:09:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f67a67407csm13570562b3a.26.2024.05.23.08.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 08:09:08 -0700 (PDT)
Message-ID: <d7bc475c-1238-4413-a1b8-ea803a61fb81@linaro.org>
Date: Thu, 23 May 2024 08:09:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Move VSX arithmetic and max/min insns to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240523094821.124014-1-rathc@linux.ibm.com>
 <20240523094821.124014-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523094821.124014-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/23/24 02:48, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification:
> 
> 	x{s, v}{add, sub, mul, div}{s, d}p	: XX3-form
> 	xs{max, min}dp, xv{max, min}{s, d}p	: XX3-form
> 
> The changes were verfied by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                 | 44 ++++++++++----------
>   target/ppc/insn32.decode            | 30 ++++++++++++++
>   target/ppc/fpu_helper.c             | 44 ++++++++++----------
>   target/ppc/translate/vsx-impl.c.inc | 63 +++++++++++++----------------
>   target/ppc/translate/vsx-ops.c.inc  | 22 ----------
>   5 files changed, 101 insertions(+), 102 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

