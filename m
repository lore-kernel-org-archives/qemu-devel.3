Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878F0CF34C8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTMv-0004sp-Ly; Thu, 03 Oct 2024 17:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTMu-0004sZ-47
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:28:16 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTMs-0004tU-KV
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:28:15 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e6ed072cdaso908855a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727990893; x=1728595693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wnonoa1XQC6cJPI3Si8el3IxlLiMd0VGStJItHsYufk=;
 b=FUBt5eiRWZKczXvTi63v2X64EGWVfQ8Ilw4Jt0x3WYlhmlKx/AWd93bvs5t/xYSLgY
 2bP2p6sdHV502rKWNT6cdrP8QMEGtUPQHYB3EUOIw1SsnmEVDy/IVOCYBg8Dk2HC23nY
 P6W8hVmRmkvTRUBKNilqmuLVDH/FWQ2RNZNtOp/SkHMa/MFv0v1mrYLUSI+p+LL0KqaN
 UsC/2mGsuOCcQD7H4qyVfJy51o0pKsIBJYK3LpH1/+xwOnqDbJEfeOANE1MHXnsCBne+
 js14CtgZN40O8mb68UZuq4nr0xcOGKXLgH0Ba6VRACkVfYEm1vcuSXwlT+mmWj9M9i5x
 OTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727990893; x=1728595693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wnonoa1XQC6cJPI3Si8el3IxlLiMd0VGStJItHsYufk=;
 b=qRMrccyQaNjY028fKPlXbOYWWJqlZDmvW18UFUN5VizGH/e3s8bF6p826Fn+F8joda
 ONTPno3KFvOW+BOaLxoY1Sa5xqw7BfospEEerMnD5VDvKLc30JL5woFDFzQggltHlow8
 ScRBuWtL2gWCUP4Y9ZzYxZPsUFvMtI8/OWCI71Mj92EyniLu8gDs6qjKMhu7IZNGnJBv
 gTZSxkc6ZMLXSB6lHDYHS15re0Yc/8SU44RwhVblJe5F26NwGAXJXV6H8GktwYuSukQd
 zduuXPPtdpUzCzZ8OkuPclL378/0Xi1+PkiddpjD8lIxyCjCvjVw170Re+Px8nLK3sEe
 LdiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX395EAsJ4kW/KMbkgWhriUa7zKt8BL4FEJ+37FXDJpRBCdUTYTpKsnYaXT84FaiXEjKxHWOiAP2Sci@nongnu.org
X-Gm-Message-State: AOJu0YxU68Fszg166QiCdgxEgjbcw+ZJCYngkL+nXeOxDXahYxcAeMzH
 4xQi0a0yyWwS0KCFxzC4v8RP6cCts/sTB7O5G23wuT/Kg9fsDV4JMa9wmNB9K6reAfzm/HVzYqB
 z
X-Google-Smtp-Source: AGHT+IHHpk5/b4enKsLfWygxsvmlknlA3wtTE7jITj9RjLJtBvXIWjR+Ji5A318jkOS3x0/4i53A1w==
X-Received: by 2002:a05:6a21:2d09:b0:1cc:e7a2:2bef with SMTP id
 adf61e73a8af0-1d6dfa48a6fmr1042049637.30.1727990892950; 
 Thu, 03 Oct 2024 14:28:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9ddb6ecsm1828181b3a.121.2024.10.03.14.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:28:12 -0700 (PDT)
Message-ID: <39042725-ed09-4ab4-9cd2-52d4899c2e3b@linaro.org>
Date: Thu, 3 Oct 2024 14:28:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-2-philmd@linaro.org>
 <4c8e6941-e73d-4504-b289-987ddf49582d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4c8e6941-e73d-4504-b289-987ddf49582d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 10/3/24 13:50, Philippe Mathieu-Daudé wrote:
> On 30/9/24 09:34, Philippe Mathieu-Daudé wrote:
>> Introduce the ld/st_endian_p() API, which takes an extra
> 
> Alternatively we could use ld/st_te_p() since we already
> have ld/st_he_p() for host endianness.

That's what ld/st_p are -- target-specific, in exec/cpu-all.h.


r~

