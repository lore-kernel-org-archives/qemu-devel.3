Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01B9CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLiYd-0006Oz-5X; Sat, 09 May 2026 10:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLiYT-0006N3-RM
 for qemu-devel@nongnu.org; Sat, 09 May 2026 10:21:24 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLiYS-0002py-1T
 for qemu-devel@nongnu.org; Sat, 09 May 2026 10:21:21 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de7dc85b74so2572337a34.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778336478; x=1778941278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l5OMJ8UTrcLi8nRodwJtY90LErtMjeKIWcQ2J5YKuPE=;
 b=JWz/D5IgH2ypsIiuT3rKzRtiWUhHq23b21fQDNKR+PAgIeADirMAEda17o6nz8zU5+
 lE0R0vXt/G4pHzFaJrvu4cpMDHM09mGNtg+ONWG7v+v+O/eOQ08gPmoTSmjPmj0lLMWA
 Gj8GTNULVf05PUHEG9P0i063JMmfvhCO73R4TvoixmQ3c7zDrqyzJH8TsA1qPdP/FVwD
 WrkDT7uDFkDbB0BTYh8m/l/7KN1eD6WXzFoZbZ++a5y3KHZYqbwptZ+hX14uui9Niumb
 sQoU2Oa/sx2UH8/+4RQoJnjs4mbqL+GnBclFiOCfATbl9x5XGFB9PudV61MzAfaa8YGO
 HB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778336478; x=1778941278;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5OMJ8UTrcLi8nRodwJtY90LErtMjeKIWcQ2J5YKuPE=;
 b=Wz4Vpy/WWl35pv1KZLbpI2stGvO+TZ/nplTzMaIUTanrXWFUoVbloyGrzdaFm69H7R
 qwF5iRDItJPXhzMMRKswlFqEKbhEhjxMMfMgJ4B02sikGRIjySNXaS2iQ0CIO6HQbWKG
 hFI7CaDBj4DlTcfiiSbSeGtAewQb6GvQXFqWqgFmbf6+teP77q9F0JwoGS31nXoRL+hk
 +93mgfj4/7wLcdET4IJsG0Iffx7t77liLhJDHk8POXLJx3ZC1wwdEJewCNr+pbPu3PTJ
 7jqSt6iA2gCJ793t/BcxqNTt7b+fdtl0p/QCm7+IXZW2vHHG9jlzRTbKMn0iwYIMw58W
 S5FQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ85S3pv7wpQswfJfcAbRozMzOJwA5PP+N2XNIk6kvD1h50mcs0JiGKJhsJTW993i7xVyS6d00/S1eYT@nongnu.org
X-Gm-Message-State: AOJu0YyIXEuuqL3DGv5LgIf2ghHvxSXxyp7ITNVKl7QQKM0Zm6TP/u5B
 LFhgf01IfPBG4F+s1Rwe0tvRszqVd0PYqCzoWufYyjL0PX6Fq1shO3tDI10ucanSs1o=
X-Gm-Gg: Acq92OHtbaKx1GoE4cOzTIsiaPQWbByoT90bymddqiyn5c6ELXydtOcfSFPDyuaBOxM
 Bc/BfmrvFkLLZNaR1Y1gZlWzaRw4orEjaP5XYmzhTnLCBmSpPTMBQz61aF4KvnOpz6XzitsaSaV
 Laedif77/oS1Xvmc6FyfoceXNSvZf6K6nEnv0Y+Xv2Nq1uUsMw/dwX+wmhwHO0NvWaF8HkC8azT
 K1DNVyveDJb/iYeYOL7gBlbqgjm1OeYiTQfHYbLbVSMcFwzpIN/wFM0gY2H8oCgt1gi1EZEL/OD
 sjubfz8/2xv4Y+qKV8GwZiGMY+rarLe8O/2nz0dIiNgT+deTuoVc0lPUOszoZJgXei9wYjzga9G
 kO4ke4SjjugH3G6OTTm8lV9aIu4r++/azwvYUY9ezj8Juz2ilUha0iCnah3RlJ97Wm5iVRTsAsZ
 YsP1rI2Zd5ovbJ1+yklqqaHe2z3/FePA+pshaCERagZjavtEqH3e1TvvPMmaXRNz0aWB8NyOep8
 Nk2TLbB+Q==
X-Received: by 2002:a05:6830:4c04:b0:7d7:f90c:5833 with SMTP id
 46e09a7af769-7e1df1de442mr11240211a34.27.1778336477989; 
 Sat, 09 May 2026 07:21:17 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:88d3:58e4:a68b:b30c?
 ([2600:381:c938:6375:88d3:58e4:a68b:b30c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e00sm3126877a34.7.2026.05.09.07.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 07:21:17 -0700 (PDT)
Message-ID: <ceab513c-06fe-4039-adac-514ab8024980@linaro.org>
Date: Sat, 9 May 2026 09:21:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] qom/object: initialize type_table in static ctor
 with fundamental QOM types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-3-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509005453.3984184-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/8/26 19:54, Pierrick Bouvier wrote:
> This saves us having to check if it's initialized everytime we have to
> access it. No other QOM type should be initialized or accessed during
> static ctor calls, so we don't depend on their ordering.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   qom/object.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

