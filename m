Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB6C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrz7-0001Mf-Ft; Mon, 08 Apr 2024 12:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtrz4-0001Ht-JW
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:36:38 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtrz3-0000gL-0T
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:36:38 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5aa1b7a37b3so1118078eaf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594196; x=1713198996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZflKapyE9fQ9avbCVLg7pRRpQ0yRZSP12pBJ9ZMcqI0=;
 b=LkFTWpTfQh40590/HMyXCWkq9wsJt3jbBQ9yaFPIZRHk/dJPXQfkFRZtzouikVCJni
 iGcbesUCGIVHzvc3vC4KdAnSiwXqESqBExKU9OcFC2Xvy2Eigl1aLaNwP3OtCdvHcEGD
 KX1ZZp6h6cic2TMsgQ7MRTi6nbTScCa+4zl/2PJyWD9JWPkOr4FOciZ/Yeug7Bd4SUB0
 nQ3PkfnphpVjqjElUvXf330w993HfwsJd8uzeBNzn4cbCBtCpv6zg+diO5QsPO3s9jqr
 csmDlQkZN6aOl0C/KYRw/l+1fl8iM6TNQMzZbGOnofrBbmhlUfbC84kwLSBnPN5XSC1q
 HMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594196; x=1713198996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZflKapyE9fQ9avbCVLg7pRRpQ0yRZSP12pBJ9ZMcqI0=;
 b=uJLamqS7ff/LVFxTsDLbMPiGN8U3MPXBie5T3RHhjBRF/0j6exsp+JXBQA6kCfIO81
 sYQlai8zwe4Yi/uGstZcx9lMez3NifPfrJ6cn5l8E0ZUfy14b8f235tHpQwTaPKIKj6N
 RyDmfsoBRoWxIr0V1VXgJB5c5xmtV+JeeB83G7x+vN81Gsx4EmSR1LW5lieNTbD8/tsX
 iCsJy7LV4SpXUTjc5bqujcdvLeTsAQ7JxS6UHYm8Sk7M6l9P7efqnkspMqC8f6mbMl2h
 z4TnRFRQMGJSKXjN7ktxowOIPP7d5Cd2HfpWnlBSb9llV8tR4iCan7Tf+t9mRUBGG8IA
 NXhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp9WIfE4ujYlZ0JXaMnQPEg7M/5PL4/XdB8geITe0iPo3yLJD7e6fn6k5ngEqPin+T+k0cYM+TBoKDs4WmY11AB9Z/IXc=
X-Gm-Message-State: AOJu0Yx2F0VJSlUAeplYYNuDpbVj6qojr5uE/CfRoHH+XfHyn/LF6MLs
 xFyB+7DfhQTuoJGXdERHupqnwxEQ/8SKnxFYZz2OYGuxRmE/lqvrWA6RBKK/Gmg=
X-Google-Smtp-Source: AGHT+IGN7sjvJWadCs/Q+BGnR5M+Z6I7KFIFMcqllygvSSsYGAUF+wbhwSlbhWkmMDYjmsKQo4ta/w==
X-Received: by 2002:a05:6870:c1d3:b0:22e:d2b2:25fe with SMTP id
 i19-20020a056870c1d300b0022ed2b225femr10176453oad.1.1712594195813; 
 Mon, 08 Apr 2024 09:36:35 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a63494c000000b005b7dd356f75sm6642031pgk.32.2024.04.08.09.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:36:35 -0700 (PDT)
Message-ID: <077ae160-cb25-49c9-87a4-8e474a2fb2ed@linaro.org>
Date: Mon, 8 Apr 2024 06:36:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 2/3] hw/block/nand: Have blk_load() return
 boolean indicating success
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20240408083605.55238-1-philmd@linaro.org>
 <20240408083605.55238-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408083605.55238-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 4/7/24 22:36, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/block/nand.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

