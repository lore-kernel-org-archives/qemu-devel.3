Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D33FD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSrmK-000464-H3; Tue, 09 Dec 2025 02:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrmH-00045c-Nn
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:04:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrmG-0008AU-CX
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:04:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47755de027eso36524775e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 23:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765263891; x=1765868691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGKChLnUunsnUJjT7oMEbVbmOl4mVWwh6ouqgJUqt+8=;
 b=rzpecLT8mJ6gOLW4XlEzXKajINIk4zrq2WDHuTfK1pTJ6h7IfCzyUU3Xz0TqNNEH1a
 JogDfpcuTAbQ9OGkcdKhFgZitl+uQlYzRGfTeNT165WE/XxqGdjETgkCFXuN5Y3rZpOF
 SZ5cTOt1QyYpRQM0ke5j4AzgFRbdYrJzJLhSYXWTD3tbGv8ndjYs8yTCJV7iXswqOS//
 QHHfkgsBhuPTpw4xr1W0A3/c6QwocBh4lFE2pNGZouxnpF+kKfFzfmamIRQNmG2fVbEC
 yaU0I/AzOY3m7T4Mf96Wi408WbuxVv0fg9/vO4BuDnNmM3L69R8uzYMolBLiQNmRvYJZ
 guSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765263891; x=1765868691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QGKChLnUunsnUJjT7oMEbVbmOl4mVWwh6ouqgJUqt+8=;
 b=BJ8oJej5kgLLOe3ZzxG5MTWidQp6f2DWWOgIX1PtKEv8u9xKzIlZ8Z03a6dW0zEa7U
 EKTFnPQALw7jhZLa/dwHLgXxkputjbWGWoJo77cBU4wo7qG3Ml/B7SYRB0DmKdYyPpBt
 F1puQkN+fpwb3vAcNpa73UgGXGKQtKbLBWkmBsCVANQck9Uw7kAeKLR+Bb3tssR6VJh3
 KTVwHEWF/ErU339Pi7We7jDmH3PhmKP3M+3tgr7udNHyz1t01q94+uOY72qYf2R+TYdh
 NE6KtRo1KaP46DnJhDH6UPf/fVJvTm+Z1Vsih2Hu8bHTaG1D5YDFkX7I3g/7tgh6RxoN
 giSQ==
X-Gm-Message-State: AOJu0YwcIyJxGDrgBqkSek2uoyMmm1XE4Nh8aSWi1tYGavM0WSV7O2em
 GRXNLjU2XUEQrDJ1tjIs3mbuPeETJF4lb67IAV+8RXdQS1yTnWbUTXrCluHmp9DrNbo=
X-Gm-Gg: ASbGncsv2iL+SNWEUadyxUVs3qefu9q6Aq9geu0p/YRGflecH+Lp9oqJ1BZtt/m4xqu
 2n3FvKYl23mK8marSbOd7h4ALvSatayRu9j9T+XRVUef2XXsVKnW36u9CSQvgi2jo+Qdr8GfQkm
 7l0NyLVp+3wEYzr061akJvHBb6FXZBQ4bFxUh+U9EAWcU1i5srMI9ILp5v65Hzn1oJehXchOOXN
 pEPflrQ5mXgnXJHVln1e23RPBh89KtWKHdqbb/0BlllWdayC75/ealpBdNjYzHl4fJc2l/IxADD
 V62EBVrlXZvwuC1nGyIFTKH94IO15ZCd5MaqPrTnbd3S7c4o4mEN/hVsdkbkuDF4PQS43shCM9l
 WEB5TnpZhfyGVCbMnd83evIu87JM6u5mE/BqPD5pGwv2FihW/yZA+cnO4kMKEzUOnKXlO1FDfDM
 XD5dg8Kbkv6p3soY64Jia09dndqFBTlv3NBh8kaWAJBb7+0sFYnmMZcg==
X-Google-Smtp-Source: AGHT+IE19qbibLv5YO/fGiwGZ6R3+MYj1lRge+Fb/99uW536dItekgFFaENUY8LHdW5PiubKa4NhNA==
X-Received: by 2002:a05:600c:3105:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-47939df14ddmr87694335e9.1.1765263890616; 
 Mon, 08 Dec 2025 23:04:50 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6eb296sm23193285e9.1.2025.12.08.23.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 23:04:50 -0800 (PST)
Message-ID: <c77de6e3-51f9-44f3-a4e7-776c2b9ab63b@linaro.org>
Date: Tue, 9 Dec 2025 08:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: ensure PSCI register updates are flushed
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
 <20251205151115.2035930-3-alex.bennee@linaro.org>
 <ff000682-b14d-4152-88b3-cb2761b60bc1@linux.dev>
 <87zf7shped.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zf7shped.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 8/12/25 18:08, Alex Bennée wrote:

> --8<---------------cut here---------------start------------->8---
> target/arm: make HV_EXIT_REASON_CANCELED leave main loop
> 
> Without this we can spin tightly in the main HVF dispatch loop and
> never release the lock long enough.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> 1 file changed, 1 insertion(+)
>  target/arm/hvf/hvf.c | 1 +
> 
> modified    target/arm/hvf/hvf.c
> @@ -2020,6 +2020,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
>           break;
>       case HV_EXIT_REASON_CANCELED:
>           /* we got kicked, no exit to process */
> +        ret = -1;
>           break;
>       default:
>           g_assert_not_reached();
> --8<---------------cut here---------------end--------------->8---


