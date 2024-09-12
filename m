Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3284CEED631
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooHX-0002xj-Kz; Thu, 12 Sep 2024 14:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooHW-0002w5-PC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:11:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooHV-0008Ef-3y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:11:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc47abc040so12131195ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726164659; x=1726769459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HFp14aqU2Jj4HAaHUJiG8DOP7MRAqiNoLF9oMyTFs7A=;
 b=VNXN+eYKJT96WjPDsIO1gPE8cM9r2w50WOgeOBqyAdvaZ8T5XsggQ7XPpGjeBsM2xh
 Hg0b3QeyHccNfALCdFzTMHT24jVbRQq6vOCTI6NTziZUbhGFcHAJ3UoQTeH8oGiMKySd
 Ua7UESf+9k26iN9TwZ61iH7h2rRX8EiuyIp2yfGIRLnKWBsreVBI1cSMfvyDd11KcEFP
 XtY652fVylkOGDO8rYEphfbpk1RbFPKIt48yxl5+A6n0n1ifEwSOCwBgjuxKwE7OThTd
 esZ9jpY4S59JPuCHog4BUt2G/UKA1XstSA2NL+f66ZlinGbGuQDvkxuGWJTK03MfgUOB
 VBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726164659; x=1726769459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFp14aqU2Jj4HAaHUJiG8DOP7MRAqiNoLF9oMyTFs7A=;
 b=WVvr6OmdmnnuTP7wC/26jx2E16gZLaoU5JYf8RAUabMpqoCM2B02Ceoj49CMHiPbhv
 ONH6b2AwBnwgMbXZX97bi1f4rfFzR3XFqJq2KAOUTz6ExrGLbmOG22bd5lbyRDVcyMVK
 9UMOo5+0gkjwCyo0Eed24rWOmz9fz8LSUU+XLYT7SHLzBakKdSasitHVhVPkwSnwt6YO
 S1YRcVt2SvIKwLmO91dTxBzInMDtKKJfpaPEgcV6vH1DZKgArytYqxf/+e656tWPgwlW
 9DHp5xosFkuzsJGCaiflQpvbeu66ct9NYbI9TuGg3SZY31JqYQZloOlm0zaDg1n2YzoP
 1nBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp8lUXOlv9OJtd7XDlL/t510dwf23F0pSfGy8PV9YgsVVhza9Ch7IaPwVdeHtvtjfnGlOnsnkc9JrC@nongnu.org
X-Gm-Message-State: AOJu0YzUXkychQq4vhDhDnYY+FJB3kn8Oh8OOyE0fD8Uw+M1o2sLcDLW
 vc0LF0kq53cjgiDV+KuSbNnYAMcVJSV4B5j0wbHHzDUh80XAusYPVCTygYb9Fib4gjmTY5ex5xM
 3
X-Google-Smtp-Source: AGHT+IGAAVRVM4a1qss2q9oeWswndZ/AYJCMl1NAPS1B9XYDpoC07KI3abg54BNyQOF+4ZEYk9FVaw==
X-Received: by 2002:a17:903:183:b0:207:15f9:484a with SMTP id
 d9443c01a7336-2076e350182mr41438565ad.15.1726164659132; 
 Thu, 12 Sep 2024 11:10:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc1105fesm12901904a91.43.2024.09.12.11.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:10:58 -0700 (PDT)
Message-ID: <aeba4e2d-f940-4a94-b0a1-f1ebb72fc0fb@linaro.org>
Date: Thu, 12 Sep 2024 11:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/48] hw/net: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-42-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912073921.453203-42-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/12/24 00:39, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/net/e1000e_core.c | 2 --
>   hw/net/igb_core.c    | 2 --
>   hw/net/vmxnet3.c     | 1 -
>   3 files changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

