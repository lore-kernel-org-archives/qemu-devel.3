Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE636C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVTc-0001IH-E6; Tue, 20 Feb 2024 14:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVTa-0001Hr-4G
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:08:22 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVTX-00038p-6n
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:08:20 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dc20645871so3680360a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708456097; x=1709060897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aS0cfblW6QTwZaN+5GZIsBmTEqfsJyQ7RI5SlgIolKI=;
 b=tlIE9VsOnPyhkuZH2x6EZdLUDQT2NgLitinMJwoaZnji5hYJpaRuIbs8sox2W5lpp4
 sxQ7RM6WCb24/R1Jd46THztxng6y7S0eVVOo827vDKWf0whq8MqW5L00MU4CMDSaM5+7
 giKFjf/tmmdK6C2Y7UCW4ye8QwnYYyxj+pmB9mLjWBUfjfqN6t3ejERXB+/2b5Hem2Mk
 1ynqRWDj38SrlLnEbpzVA1/EcKUu6vc8+kQiv26hoEym7Tlp8RKCxyt5+yJY6+wlhVx2
 seJclfczdAAiWUlGMADirLwLD2PGxuKEY2F3x1yCJFACUQfnuoFo8ilnJuOvFBUITnFw
 aqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708456097; x=1709060897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aS0cfblW6QTwZaN+5GZIsBmTEqfsJyQ7RI5SlgIolKI=;
 b=Ybcq/+zGqc/1WCs90CieJlX35DriBehLOsd84kJG3aH2hQ0cJecEC08oXWKOl4U+22
 pgI4KAwr73C+lQAVtsns3wop120en1O1wZFKwIPPS61i7XpazspP7CdDiYmheiDM9jHd
 HjVfUowRAYUKiCjDlywvXWOAPBHbgBtyrHbx4azSYLDwVlxg2x8VVb/N4O6Eb6tVMiAy
 XaUzlSMinNu2GhyUvkmEk12buyKDZL7V1hZS1yDIWZ26lDl9is0Wr/cBFNSNpqE6gRgI
 b2dK1I32oodqVH3FdxvufAQZ/j/Fvf4uI6kcD6jkRktdgrtoxLlq9+Te6tLkw55q8a+h
 DEQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6h+CXOdmMsUJXCZny0S4HHgvfwPuMbpw9O+3a0eHPDquRD9x8aMvYWkZRCDBnug8BngEezboutrkb6ErJkL7v3+gNPtg=
X-Gm-Message-State: AOJu0YzvjhCnUWI9tfZhmJfwbPu/BMAtm+J2PZZji9+LeFc16BzWlQww
 7IOvdBXf0uI71bdg4CioXWgvyIeI8OOvwCxTeR0wrHodf6gIGmG7K2xXrZwSI98=
X-Google-Smtp-Source: AGHT+IGWhoZWbZ2wzNZivnTmBhe9il3T6MJLWGxT/L4D42fOSR9DZ2kZGWigSewchba8L6Ux+WomyQ==
X-Received: by 2002:a05:6a21:3982:b0:1a0:9245:2f8 with SMTP id
 ad2-20020a056a21398200b001a0924502f8mr12950885pzc.23.1708456096928; 
 Tue, 20 Feb 2024 11:08:16 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 o19-20020a637313000000b005dbed0ffb10sm6945187pgc.83.2024.02.20.11.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:08:16 -0800 (PST)
Message-ID: <25fd2327-54e5-4732-baba-8a4dda14fed3@linaro.org>
Date: Tue, 20 Feb 2024 09:08:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: ensure nios2 processes queued work
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240220170803.888143-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220170803.888143-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/24 07:08, Alex Bennée wrote:
> While async processes are rare for linux-user we do use them from time
> to time. The most obvious one is tb_flush when we run out of
> translation space. We will also need this when we move plugin
> vcpu_init to an async task.
> 
> Fix nios2 to follow its older, wiser and more stable siblings.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   linux-user/nios2/cpu_loop.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

