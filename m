Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC77C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUCR-0005Bd-TT; Wed, 13 Mar 2024 15:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkUCJ-0005Ap-27
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:23:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkUCH-00014x-55
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:23:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6c8b1ccd7so87600b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710357807; x=1710962607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eRHh2p+QifmRsULT1pE4FP41vA504ysLQ/KxMHYj6Bs=;
 b=CQ+y0swYDSsO+sWVcpVBAtVU+742J77qMchePBfjIGxekDmEITMKs4hxdfjSn6VmWT
 +eV6gc5km60SVdZh46FHwGrgJV2CSR2SetEl2B6Iup2XJJ9yFpJaDfb05YUUaHVaWIkL
 h3j82ly8Ny2hmNU/eFcXHKclWGGWUIgrcY5ntTib5Irvv4xB+sPgnlXthI47cIbI3BQq
 O8oJFR1d9AzPz0WwuFgI4d9qv+ZjeGbqpRH1RVDNDPTYF43jOwcTxb6yIXenSnJJvkGc
 /nO19DexjDRu1J6+Mdqlusjml2SSwiDJIjRX3SY2L1BttNFRWOHbS7WGlfJJAuzQOJI9
 98nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710357807; x=1710962607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eRHh2p+QifmRsULT1pE4FP41vA504ysLQ/KxMHYj6Bs=;
 b=G+LeBD7y+ufsbNTunGzoTu4VpXSe7ohN93TVlVCYVR4L8F17tVu1ZcIfaJxq+ftoNh
 T1NHMqTU+CXtUk8BLa5YzzpcElX6Pa5+tW/qIOJxGQmyarNXt3W/iP1wrLWaPLBv1Y0q
 u42IrE/jBx+ioQ88f+h6VmZVhg8qpxQFgWEhb0KBtJBMC/Owh9sy5FHZ+KJwmQEgfQEF
 47FbVvPi50J/f9b0vW6CGH2DOUwzjlJBZEoXqJkKhUOrFQUSb8GqWzTvRIPUnsexKEha
 ltKpQQ02T3dRy6P50HMSEc3CkJ1VSZsFnK4DSy/kMchOjNe0Dkn+iY7Jtp8pKcZxezNj
 NPYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHeqDuTzh1Thm55z8lGeV2Yf1uJwAFoPR0zKk81MOv9UXX58WeLJMDkjcIe1EAQtcGV9roJXSVdPw7HI2b5617hSFBGaM=
X-Gm-Message-State: AOJu0YxXJf0rBWpCy8UGIJ/JW/kzi2Iod6Auq6nEQrSfhUR59LPDTDnL
 1hkQSP2lLVCHiEEA7VD4/CXdBvZHjRazIM5JfeoHn7hRS5RWe0pN4TSutJdyIm4=
X-Google-Smtp-Source: AGHT+IFl6YRMUaI/2nQGHhzca/oiPrae94oulpWFt7L6BCa6GOobZ85tgCn/GXGw1FPXJxTi5Rvgbw==
X-Received: by 2002:a05:6a20:da82:b0:1a1:87a9:5cb6 with SMTP id
 iy2-20020a056a20da8200b001a187a95cb6mr13097955pzb.6.1710357807254; 
 Wed, 13 Mar 2024 12:23:27 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y3-20020aa78543000000b006e641fee598sm8534878pfn.141.2024.03.13.12.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 12:23:26 -0700 (PDT)
Message-ID: <a5d84da4-5c7b-41d8-80f0-5a23af3b33c7@linaro.org>
Date: Wed, 13 Mar 2024 09:23:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Fix 32-bit SMOPA
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhuojia Shen <chaosdefinition@hotmail.com>
References: <20240305163931.242795-1-richard.henderson@linaro.org>
 <ffe7207d-c88f-444f-804f-a3597976ee3e@tls.msk.ru>
 <1f5e8229-18d5-46e5-afba-3fecf2c5504b@linaro.org>
 <0ad81b09-e115-42df-a5c0-b8032b0e8875@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0ad81b09-e115-42df-a5c0-b8032b0e8875@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 3/13/24 09:12, Michael Tokarev wrote:
> warning: TCG temporary leaks before 0000000000400730
> qemu-aarch64: ../tcg/tcg.c:1052: tcg_temp_free_internal: Assertion `ts->temp_allocated != 
> 0' failed.
> timeout: the monitored command dumped core
> Trace/breakpoint trap
> 
> Does it make sense to pick this for 7.2 with the above failures?

No, it doesn't.

I guess it was in the 8.x series that we eliminated the need for freeing tcg temporaries. 
The patch set would need adjustment for that, and I don't think it's worth the effort.


r~

