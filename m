Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64964606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xL72Z2vE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSM5-0007e7-5l; Thu, 29 Oct 2026 11:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSLx-0007ch-W0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:47:48 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSLv-0006Tt-WF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:47:45 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f48c750afcso1538524a34.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793288862; x=1793893662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TT9cMlOgoKTornWM44tx7mE5XZSvHK2IjKlrYae0dSw=;
 b=xL72Z2vEhSFxJ3JMuxz+SH35BPj2PjxPfpYhKOAH5ul0m2vkZRZyknttThWiCWR2mI
 GpnDYfmIuhp5q3CeNHCooxyleDGTaRyEvH3GbZT5qaEYE5k6+dn93hYRhlHs2zCCcG8x
 gjCcZ4dqXs1amrOEDp6+qzUr4bKj3Sl863Y+SEOizcbxrdXnDQcNX5M7z8kag9vhQB+A
 a85esBnkeLCvkMzX1cJaiXKPs1nRiqbehv14yIpELZtFI2qrRamp7NCikvr26lwvg8Be
 zWSMogDSU5VBkO6rsAdU0zPkRMXae3pRLy1/TCM/xaqDgROXWINcAgEp0iLuTTt9HJza
 LNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288862; x=1793893662;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TT9cMlOgoKTornWM44tx7mE5XZSvHK2IjKlrYae0dSw=;
 b=b0wLWAcAfD3vd+m1wBH4EsDYyT2q9XB7EqYTThbG+a2c5ZSV9Yc6BE7CdssuCgJEY7
 1CmChNIhSgxiAsXbJSuOtzK0Z+Z1pMwEEQ2fZgcfDttfsbP/mGvyyYb/JKGOblT9qhzZ
 eon1tEY/L1/w5P2i5JmeGV47a7ImWZbeMxkidj4leEqII4qGo7lIkbAFdoJcK+th2hjf
 2hMhwkvs2VPaogRSeFzK/M9X1kH0kY2/vnDHFioZlaU141DCzAOqzr1rrPZTBLBCC2WZ
 3StvLcIrhoPVBTvyfc+LsNVxF8en+1UrCJ0JRMhjDAOg5cWhnCInZpTxJxC/E/BeomEX
 SyeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj8GwURD6uu/NGY/XwQKN7LQJDT80kTb82QRz4X+PWZlDFX9tUWKG8t/9YojZd3ce13z621dmQPiZ6@nongnu.org
X-Gm-Message-State: AFq9FYLHURvu7OYiIj+WPbvZ+QM2m/RxR4sg1V3RmBp5PMhtMraUo79I
 +ghmMpBW70+LYz/mIFjXy9pjC5OCkCNh1CArY7M/ye7CogVNnHqpGAr8xc5RK6NbDlE=
X-Gm-Gg: AYBFou0y0FjMIZ8/7Svk6CD/WHN4dvYnzlWY/hDH47yHZJc9WKoXY89meAZRquGGsDr
 VSyEt5jvJdxFuGppVRTqhRbqaA5CvSQ1xGRxozLCnEmtbRPG/Au6Hn3Fxh/ga9gLGCqqXwZi1AW
 F/dYt8/L0wo6pKYJY6GDaSMAurvGXZosNKETZUUP95ehgcz1YuqeTLUM/fS72MWWziV6bE/8MUj
 IBikPlLuztWnFbjPlxZFtt790B/loNYr1UV2ht5uahefPwzfqQNsESQ2hR6SGYcN7Oqh6aU7OZ2
 11QTLPrqtjhtdpgHV2FgLm3q3F/3xRNpHQ1n/PAK63o5QbH/WLE6XuELMNEjPHSlG6DiUFpVrxZ
 0iosCbLs+lGDXBTrtajE0ArjKS6/5bStyUi5tVWzLiFtTk/rMD6GgzCCrDUd6tHtoPeGxqy3aak
 YEnwPDEgcoyOLiJWGmvF3UUd10y30zWY4Oe80HsddAbKdXjPue74gRWBHcZ0y69uQUksskbLbga
 aILXZxBeRcRmP3TkjDRVxDgzlu/IpENXRFiiChivFD0sf8G3CqLvNWgQ9hcNqLdScddH7o7ZXC/
 /R51fbygXjEAIv/0DINXOhL68EZddirEE00ZIQImlhkD
X-Received: by 2002:a05:6808:3509:b0:4e6:cc78:edc6 with SMTP id
 5614622812f47-56386832b52mr4213005b6e.39.1793288862305; 
 Thu, 29 Oct 2026 08:47:42 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c5342792sm4085245b6e.6.2026.10.29.08.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:47:41 -0700 (PDT)
Message-ID: <ea5c1985-9dca-4839-8255-6be49593a1df@linaro.org>
Date: Thu, 29 Oct 2026 10:47:35 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] target/mips: Translate MSA vector load/store
 opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:13, Philippe Mathieu-Daudé wrote:
> Missing review: 3 and 5
> 
> Since v5:
> - Rebased
> - Swap temporaries during store (rth)
> - Bswap d0 and d1 in ST.D (rth)
> 
> Since v4:
> - No algorithm change
> - Split to ease review
> 
> Philippe Mathieu-Daudé (6):
>    target/mips: Expand TRANS_DF_iv() macro for MSA Load/Store
>    target/mips: Convert MSA LD/ST.B (Byte Vector)
>    target/mips: Convert MSA LD/ST.H (Halfword Vector)
>    target/mips: Convert MSA LD/ST.W (Word Vector)
>    target/mips: Convert MSA LD/ST.D (Doubleword Vector)
>    accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

