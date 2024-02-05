Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52E9C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWrJH-0004MG-Ew; Mon, 05 Feb 2024 00:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWrJC-0004H7-46
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:14:18 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWrJA-0003SU-JJ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:14:17 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso3949943a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 21:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707110051; x=1707714851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u/xNVY93iE8I2CWFpsVGXxwBE5FGLGvYquxS0XscqOA=;
 b=koDsuWE8SCiZyDAwmPXWKkEGp9Us+c8Olb0oNK7VFL2HTQ/V3BTQldWR2vqFpMfZ57
 3AUoucIY3RkEObClKsShPnN7LzKooaKoglSe2DwiN+eE31yF/HHMO9oe442tDAF0w5IB
 YajfSMV5L0de7tQz9QSzyJKueD0EoVVDFmECtvVcYmKzOTmO7AMHQ7UCAdrBY6BPIH9w
 kQr4IM2ttRPV41V9uYoRDd9Xkgr9GE6vpFdP2qqsBWABgzEy10zQLZKlq21JRIwoWQUn
 4P6zBlsNeqQMj4+ahLJFxRKIn9CcuWUSB8c4/K9Jj4nUucfMdQ51dfd2/rSdGf3YcH4g
 Agxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707110051; x=1707714851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u/xNVY93iE8I2CWFpsVGXxwBE5FGLGvYquxS0XscqOA=;
 b=Yvcz6Ff+G3uRFqkdjmWCw088gSLAVSLqktNwQEffmc03vCxfM48m7itDLi8q04c9SS
 tDS8BHe7v7Vg6mDmZNrzZOuvwjYKQiakFeQ7zqupZPoVZWDPx9szVtjyUQuBbTgMTnrj
 W5uAJ+PoXLOagEbhl3Rw6S9ExZFcnf8PbEds2SWw+XVziEsz06lKUNZkzftWdrVf51Ny
 pWayWM8K4WFDxo81ebHGKcDiNF8ww/Q8/aQ0AIB+dzh12xuqAXMl/nyseYLhxVnINzUt
 pHiGMlN3LyLrvihTz/K7McG2rrhLEa/tlwPHc3zm/haZnjMONX1nUdNnynbSM/AdM6ZW
 lufw==
X-Gm-Message-State: AOJu0Yxzv7KLGxQwiScc6/goDiCQ6PHjcvHmAga+KBYGUQ0McTTirUKv
 r/5aDxTMDAgOYXeirCcP5KdynxZPKC7c4wEPvbHWKVlD8URYjmzKaiF11lbE4e4=
X-Google-Smtp-Source: AGHT+IG6FiMibdR+j1QvAkwgRY5k8/bkzcgIcEBXwqaQmDbRh44h7wMLMiFv3/78a8G/bviMXLit/w==
X-Received: by 2002:a05:6a20:2d0d:b0:19e:3654:7d15 with SMTP id
 g13-20020a056a202d0d00b0019e36547d15mr19621880pzl.15.1707110050793; 
 Sun, 04 Feb 2024 21:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVU8CFz0ot0lFfSqGgYrfkPxPpI+vENB5pulkW/kX0ivNFPdA0RYBA2ontTzCwSprS2V2vXsrY6sIqbgsJkBHhXiMNoDQ==
Received: from [192.168.0.100] ([43.252.112.216])
 by smtp.gmail.com with ESMTPSA id
 sx3-20020a17090b2cc300b00296a70afc5esm389886pjb.38.2024.02.04.21.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 21:14:10 -0800 (PST)
Message-ID: <efeb90b4-1ae2-4e1d-8572-e341bac2f236@linaro.org>
Date: Mon, 5 Feb 2024 15:14:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/riscv: Fix sizeof_reg typo in vdso unwind info
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Vineet Gupta <vineetg@rivosinc.com>
References: <20240112220348.49021-1-richard.henderson@linaro.org>
 <CAKmqyKOHJ9mXQDFDs=CC8v0UzP48FGTdLL=o4Kp8ySmMmhSEgw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKmqyKOHJ9mXQDFDs=CC8v0UzP48FGTdLL=o4Kp8ySmMmhSEgw@mail.gmail.com>
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

On 2/5/24 14:33, Alistair Francis wrote:
> On Sat, Jan 13, 2024 at 8:04 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Reported-by: Vineet Gupta <vineetg@rivosinc.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Is there a branch with this so I can pull in the binary changes?

Already merged as

commit 1b21fe27e75a59bfe2513f5abcc6a18cfc35cfc8
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Sat Jan 13 09:02:38 2024 +1100

     linux-user/riscv: Adjust vdso signal frame cfa offsets


r~

