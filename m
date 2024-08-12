Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605CFC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOB1-0000ZD-EP; Mon, 12 Aug 2024 02:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAy-0000OT-23
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:05:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAv-00023y-Ih
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:05:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso29098295e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723442700; x=1724047500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpP+IIT1So1TOkeHEkKZkPesP2Z083v+pZ+U/ZKdoYU=;
 b=KKbsn8HGsRWd5Jd9+Sj625lYFxW94kLJB6p+duIRUBJ90SV41Fpofju33UgN9db9Yq
 mdDK6gJxpnWbH0K9kPgcj4vR3ulWXBSAQzxjll+fZDx7VlxY4IUymxXJbPadjKB/eonP
 cvpuQVPPORKfMKpaGR+w6vXtaY/MvdO3qOr9S8l/tBRgGduCTX+I8VrjdGkaBBm/CmUz
 yMFCuinFnaV42kU10jNJlCaIBRxa1m89hx/VcwrpMH86Is76W8S9ZVZ7Q08Ml9+gPIdV
 2CfkEhZ/tZjS3S82Yju9egWiLxA/UYphO1O3oTrp0mOcPs5U1LVJgUr0mJoow3DtrmtR
 Fl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723442700; x=1724047500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpP+IIT1So1TOkeHEkKZkPesP2Z083v+pZ+U/ZKdoYU=;
 b=S0gONlQtOtmWiminh53xpQJO+0YyJmUZcNBfRUu8MlQmKSY6d8CLXiffAfl4sS3NqA
 MA14kojzlQ1YwaPQ/ewM/CdsyAgAKUOjxuDRYcDUmxWIcPlrWwMhziylcDKgUGdi1yq0
 XIVfYSEjSy4E2cP08lmFnJPM0Q4x7Yk1pQt43LxDo4tG/GGov5uKheM3ZnUzp1xvA2DK
 FOJ6QyX7ec//89F16+OYCVQ6RuEr+ZncDLZlkxa8tU2mQUB1P9+U6ImtMsQ/I1O02Fj2
 z3G3oDL7Zbjaejef3KaHDer3XWkaxP/dPSlbGyFEPttFTpSn0VZ+PBwk4hqroOH3pGDM
 SKog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBuIuUuRs28N9XV5+x1Vz0zPT9jx/raVcbNyEDtJBtfZSkOqH1fOOZP7UuwnBw6mMfy2yyHbnscM8kGedDxmNgHB9m0ek=
X-Gm-Message-State: AOJu0YxvY69/SOioy8tuDm1PRe5U/2oPD4CU2WMOERrY2wcD1jn/XLEs
 Dq4bx2Kyj6NGVMlgw1mPdt+ZmRBlZYmihRX6OT1Kp9SdxIialAJGL692ifTOYT8=
X-Google-Smtp-Source: AGHT+IGoeSvpRGkslflsTJGwCKh4Lgsu+9KJ/+Q6cbg1TtKL6+yyEK7BFKm5fNeQBhxsSf7Rgz4Emg==
X-Received: by 2002:a5d:60c5:0:b0:360:7c4b:58c3 with SMTP id
 ffacd0b85a97d-36d603555f9mr6341237f8f.54.1723442700120; 
 Sun, 11 Aug 2024 23:05:00 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm6484940f8f.115.2024.08.11.23.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:04:59 -0700 (PDT)
Message-ID: <379c9384-5196-456c-9cf1-6bfe3c103148@linaro.org>
Date: Mon, 12 Aug 2024 07:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/m68k: Introduce
 M68K_FEATURE_FPU_PACKED_DECIMAL
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20240812004451.13711-1-richard.henderson@linaro.org>
 <20240812004451.13711-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812004451.13711-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/8/24 02:44, Richard Henderson wrote:
> Set for 68020 and 68030, but does nothing so far.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/cpu.h | 2 ++
>   target/m68k/cpu.c | 2 ++
>   2 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


