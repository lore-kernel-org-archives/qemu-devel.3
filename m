Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50634C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzDU-0006vR-C8; Thu, 06 Aug 2026 10:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrzDS-0006vA-D4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:37:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrzDQ-0007Nl-Pm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:37:02 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1795866a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786027017; x=1786631817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dy62uuWKUKMtmYjdKMRCm7YdkjNAcph0aERzfe+DhZI=;
 b=zswKvm2vI1R/MrKxMqQxCdnfQEAe2Zv/l9dik5ek7vjqlAt0SVLQNCUv4NxPVrtCU2
 F3TFYFBz4pnN8qhU+hGgJmXztPwlC9a1hM1r/q+FcOUau4UxhaZvfO1Wpm/lAZXTjiJw
 59uthq8kmpictG5dQINTb18MH1ygchQgX5pVZ0JdMxzdHeB6P+/tJ1s/jj8hAdEHnWNa
 x/uwDfOsADqxpF2ST7Ay3p29bLm8Ju9FhMcNOeCcM2UVHkHuj5G4/ZT+52OHi1qg6sk2
 xjEp8F2FJacv7nvsviCvk/EfoCDQj7cCgTu7vWEAfh+v32BmWR8XLdadAd8POt4UwyUP
 J4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786027017; x=1786631817;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dy62uuWKUKMtmYjdKMRCm7YdkjNAcph0aERzfe+DhZI=;
 b=CyH8e+jPa4t7Jv1fDKZm2s/knqAF/hzjVvbC5S9QAlyGwSqYxaFE15QHyuoA7hC96m
 9GSTgOe95COZN3ue4rmZDfvIo096gcSdIa84Plfk845ErK4u20zzJmOamQ0O2h1VrBha
 zy+ISHijyrNUBuxXFABMhM4sVDE4S36Pl25JQVzOtUa7/8nhbz/xR6mGEpJpP2JI8Xfb
 A6S19SpTw+UCqgu0Ake56fo0wSuCqfmB9eiEtL9rH4T+xpI2OXS3dVLzrG8U1ABkVQ+s
 J5tXUww/olH/7WaStUDMpM7XTORTbTKXTX4VUsB0BMPZiGxLUjD4VglaZca8A2DUJJOg
 LPkw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ronp0knXlxaKFkbxN2qb1xpoSokM8LoQsUbRyj7VmERJRkN5sYKSnb8hd0CiavMmkWdKOZ3tNnKG5Lg@nongnu.org
X-Gm-Message-State: AOJu0YwuCcqiKsTjNUyHmHHKbNzTliIwGEK29vrTQW0as3ShsAMANj04
 QFEgoMpLga9NAlOs9grG5ZUGiHT4Ul8rWj1MoOB7uCkZlBjSXL1Cb6BHjleh3cwqGUc=
X-Gm-Gg: AR+sD12E1WJnEbEUxhQaoLMB1sCoRqMMCFdHNZgonhGsOyGoyGP20GMyUrEr3b7Qid0
 g2L4VLgIUyWbK/NSs7eELnAIlxnjs38Bi1Oqvwlu5mX/Q0JCDv4ZTcZBpJL/ICZxb+Ruz3hmwgk
 i5apMqWpfrxJifPsc7Ot5GGaOTk3aFYIx2F/Del3MG2JPnCvZQL3mXZk8eIhE0BFIFYBigKO1sy
 a31YZwfpIlS9mPVW+WvbIFhuoMRNW8E6S3bU4amiw07OOJeWJE2+xgWD4Hh3NkHA61lkIUANI6q
 Aii0CuvuCZrIopnR4kRTaxTm4ZfqK7tUU1FASSJN96A59SHIsERBDfhv7qKfAlY7x6SGe9SY+7J
 ySp8Jl06FeUPWsndwXvrj/Z9lt4VybJfvWz5Q12BYPNglPHAlyhRdwzUwzkv0NQyzBy4RQmYzJZ
 Dazc6wT2s7NX2TJ5vQ4/U8HUVmJKHSoP24sUo9kouTwiUX5QuIhP5+xfZGHJDDD7CbD0uVcwwpL
 dWsJxKa1+fipAx4gVfhDqwJslEoB2OlU99SAOc=
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3903c5c443dmr12998026a91.16.1786027017133; 
 Thu, 06 Aug 2026 07:36:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085db4a61sm1674900a91.4.2026.08.06.07.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 07:36:56 -0700 (PDT)
Message-ID: <441540fd-620d-46e7-ad67-b0f95923ebd7@linaro.org>
Date: Thu, 6 Aug 2026 07:36:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/hexagon: add GVec overrides for HVX
 saturating add/sub
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
 <20260806043223.3787083-3-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260806043223.3787083-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 8/5/26 21:32, Brian Cain wrote:
> +#define fGEN_TCG_PAIR_ADDSUB(OP, VECE, DST, SRC_A, SRC_B) \
> +    do { \
> +        tcg_gen_gvec_##OP(VECE, DST, SRC_A, SRC_B, \
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +        tcg_gen_gvec_##OP(VECE, DST + sizeof(MMVector), \
> +                         SRC_A + sizeof(MMVector), \
> +                         SRC_B + sizeof(MMVector), \
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +    } while (0)

Is this on a MMVectorPair structure?  If so, you can implement this with one operation of 
size 2 * VECTOR_SIZE_BYTE instead of two separate operations.


r~

