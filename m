Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50D2D232F2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve81x-0005G5-O2; Fri, 09 Jan 2026 03:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve81w-0005Fb-0G
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:39:36 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve81u-0003wv-JR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:39:35 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so2483342b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767947973; x=1768552773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FiR+gzV1vqB1L8tOebByW+fWHpdaDPImYkIb57eWylQ=;
 b=EG90XfEuzl22O+05Z7PpV83KMhto8SQpznYWUHKV6V3BWJaaztbUpNAwJKtya3GhcH
 fZAVo5ulFloLmMxtnIdmQ081aTWzk+KP6u8nvGgOUKj8933R9tKG2AwX0VRV7A/UJIpq
 iutc+OoinkWnZP3LRJg6eUDqDLJkzVinImPfReqEX7hMHvLfvVxC7exwOqDf2BuWEDbc
 ceaXb9/l/W8+oCQdQ51/vCCLCwFO2s7BUqmP4bG1TvXo17Nb3CJ2FpOMkx4qEn71i9Bz
 r+H/CaKjRG5uTUBwx0gd9bxZ5RVhWVZseiVfBbQJn57DGdY0ocl0yFe1cKyXlfAcQPlu
 s3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767947973; x=1768552773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FiR+gzV1vqB1L8tOebByW+fWHpdaDPImYkIb57eWylQ=;
 b=Y2x+w/o/SG7h9PWgHff8EG89IatkgAM0n69yWUi5ecboAx0Qa2+KJlZ9npo0oBbtxT
 D+5wo9Oc8LK7vcMJ9UPopoyDkEUiWsraMDxI8BLrP53K4hP2TQ10g+5dUp89o7p4GYT4
 8AIbnqTVx5JVIdQIzY9bgyEXlbWiiU8PWSLeucJ9onk0dmJ55R7/2mQH5VVLWCivm1Sd
 ruxmoifAD7RUE2OSD7RgvvBZeBBsdu7DF5Eyy9byujOEtxc18JDqq7pFViFFyNSZrhrA
 KW+4Jzgf2MI0+JqCzu6W3TbMLPhgFHzDtjr+Xdv1WazpBS/dl9e2K/JoDqX2pjokimpL
 cYkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXBs4tm9/kSZeC0EBWzY9E7eSEvFit2soKxpH+1t4d6qXyfOFNo7T7SiATkrViJiRpu+/RBNLMo2XZ@nongnu.org
X-Gm-Message-State: AOJu0Yyca661wL8PGRmA+gIfZn6Y74HZdbD93S8ZZyvBvKi8RfPPY1kC
 ACCExbkTXglZ8091rtFXRaTmtz0zZxqaxPaMOHjz2ozpT0Vp5kMHIeJOjP/0Jrz8lM8VDkhD4p4
 pY+jU
X-Gm-Gg: AY/fxX69hjrwsPeI3NPzV7d4bvCO6vAtdWE/N7A5Hv+MszJlY+AvU0AMaMk9oyfIDDL
 D5lC5ZKrZ5T/+hIu2hulp+fPyg4x1FxJ1G15mGry00+EHjxbjoeFWgj5efulEGi78PHO5qBjiXH
 zWyPHF1dJWEaTH6L0nnpVDhLYCq8fXcwgTDx4dfY80VH/x2pabEtbBkuObSQkPELuPzO0yRDKor
 lhIwdMAu1GQkCch/6YfYhZd7fnVNJGr48AE/IH8P0VUfhAwPFJKAi6AqfsM8WTXjfWkTI2ajW5F
 GwXRMzYwGF+tnbWnGfWbPUgSFenFGhm61LGWxTiMNOTkV2pfwJZc/HxBIcvRrWR2QR1VuwMLAaR
 X/aLoOt+Mtne4XkB7uUlAZqQ3H9rSnuhFQHgRj/UZdhtBHeROHD9i9AYIDU1tV6cilNd2q4UXzy
 Ho0ff5hCqJzmVoqnucGV/nA75j98bp1GUZ6jgs5f1lpTWlmOm+buWJx+vxHY6YZJAzM/I=
X-Google-Smtp-Source: AGHT+IFdzadHaSNOjMe6Su0Vl5S35hnP5Zejss/LNmkC8OM3wOao6kau/ZdzTc8ImOMc7l9VPR50KQ==
X-Received: by 2002:a05:6a00:8d8e:b0:7b9:ef46:ec61 with SMTP id
 d2e1a72fcca58-81b7f108957mr8437429b3a.26.1767947972984; 
 Fri, 09 Jan 2026 00:39:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bafe991dsm9696995b3a.16.2026.01.09.00.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:39:32 -0800 (PST)
Message-ID: <b94c5770-e6f1-4916-b83e-93a696ea0c80@linaro.org>
Date: Fri, 9 Jan 2026 00:39:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <347ae217-134a-4181-9a31-c5ff8c83d7f7@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <347ae217-134a-4181-9a31-c5ff8c83d7f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/9/26 12:02 AM, Philippe Mathieu-Daudé wrote:
> On 9/1/26 06:31, Pierrick Bouvier wrote:
>> This define will be used to replace TARGET_LONG_BITS in tcg-op-*
>> headers. The goal here is to allow a compilation unit to set explicitely
>> which variant of the arch it's targeting (32 vs 64 bits).
>>
>> By default, we simple let it defined as TARGET_LONG_BITS, so existing
>> code does not need to be changed, and we can progressively convert new
>> files.
>>
>> target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
>> some TARGET_AARCH64 defines). For other arch, this is a work that will
>> have to be done before converting them.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/tcg/tcg-op-address-bits.h | 21 +++++++++++++++++++++
>>    include/tcg/tcg-op-gvec.h         | 11 +++--------
>>    include/tcg/tcg-op.h              | 22 +++++++---------------
>>    3 files changed, 31 insertions(+), 23 deletions(-)
>>    create mode 100644 include/tcg/tcg-op-address-bits.h
> 
> Nice.
>

You can say thanks to our Richard here :).

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


