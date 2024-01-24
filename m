Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119B4C47DDB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTWq-0001n3-7y; Tue, 23 Jan 2024 22:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTWo-0001mf-9N
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:02:14 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTWm-0000Wd-PW
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:02:14 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso4225733a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706065331; x=1706670131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C7GQuDJPr1bok1hYG5awukZhJRYkajoJM7JEm596HIY=;
 b=QpI1R12a32wP1xJM0ZkGmxv9MlNFA34ksGuxggrOGI5XHucg4n81NcUbj6Mr2+bggY
 ZANRxrG3BZ2z3zM72qWuzRKlW5B9rSN2bMEvxxQa/+O3kX5/LZAsZqvPQT+lSvJ7CsG5
 dTnyNvbmzvUNk/JrptMxFeBMnBzqpjB7BXSQujRBGA/peCHtXBL9QrOvNnBLfE4nn8q2
 DZbeCLoBGQg7gWGmCvAwGt5dQmg0kCQ/MofGjPp1yvprwHH1+iPRUYu2ePJjHIRFw+A4
 eehsVfxZsRZo3JucOvmxWYiqj8Lfl3Df0bqXWz9eGi8lHfPvBFutgBwX2DeMWqcl0Akt
 WSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706065331; x=1706670131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7GQuDJPr1bok1hYG5awukZhJRYkajoJM7JEm596HIY=;
 b=BZK3VkbLQ/5oHZqROZUrFlNuS4yHlF7+4NQww/QI11iXdH03Kt4g0yvT2lgBDIqV7i
 wBJgxm5EvYg4dWtlA4DOYvsYoOrYSwOzMIho/+J3X/Jl82CzRB0lSfuyNTZSwyhvlEsY
 BpTXDtpspVU6KzqFCzXTKoGVEuUsQ93FCs5GYcvN2LHxrNCmo9+kGYq81+mupYxLzGNn
 bNyBIDQRjPProRA8fxVSJLeAkjG+rOT1jkiEzQiusFCFwXZTkgS7XZ14UoxEbs7cGcaI
 TJgh3QTRP0cf54rLTjkUYTSfXttntMBytukwvRjfEhsxfi1p3zwJlO4V1LPNSi4xpOoP
 9Ljg==
X-Gm-Message-State: AOJu0YxtIvw2XdJrd4a1W4aKpUvPu9h2v7oLljc7yktlQCz9vM/SdpP8
 DMn3PTPqhbozI21lwpDbUS6eAKxYqsL9CLriY29nSUFwtJqEG4E0AtY0A7Op4h8=
X-Google-Smtp-Source: AGHT+IGuYAvX1lgHRkGECCzT0ZDRRYh2hrQ2yBIPF9IR8qErFrgr1eHoVjeBjHb5vCoZ/yepKuFySw==
X-Received: by 2002:a05:6a20:17a7:b0:19a:9d9f:6af9 with SMTP id
 bl39-20020a056a2017a700b0019a9d9f6af9mr247335pzb.73.1706065331086; 
 Tue, 23 Jan 2024 19:02:11 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a056a000d4800b006dd952e734esm259860pfv.65.2024.01.23.19.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:02:10 -0800 (PST)
Message-ID: <35591bdc-a0d9-4351-beb5-a8f4c48a7ba7@linaro.org>
Date: Wed, 24 Jan 2024 13:02:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 28/34] accel/tcg: Make plugin-gen.c target independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-29-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-29-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Switches computation of offsets into CPUState to use that the offset
> between CPUState and CPUArchState is guaranteed to be sizeof(CPUState).
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   accel/tcg/plugin-gen.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

