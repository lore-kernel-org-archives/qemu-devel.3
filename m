Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC5BD26D9B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKRw-0004s9-7D; Fri, 09 Jan 2026 16:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKRc-0004l2-0P
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:55:00 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKRY-0001ej-NF
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:54:54 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7fc0c1d45a4so2651049b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767995690; x=1768600490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgW3rdvm3evjcmTiQ4UBh9cSm2+TVh0AojTms1MHKYc=;
 b=v/xk7xaD779Pzy9uclXAxOIiU+eKzNgdhmZwJjyXJbhB3n645/gzd/3VBLRP2ponSq
 3b3RyTpJwOgtzlivXamETzEoLxCAKOwvDglI7DfrShG5OTeMq6gzp2gNVxxmp/ONQ0uk
 5uZ3ufs2n09330f6ku25XrS2gFfp3GX5F8971YjFlvyrvEXwaLn5KM1Wo0YkIMdbz0I0
 asgU4DCdjucWdj38hECKbwc7okVXYDuwSYibuywokXSlvkrCnJCnuLBTguHOUjkiVM+C
 gfXkgXgT2HEAFnIknsfYFoz/0+i8KASyKL/EQP+gcUZUiDe1XEgJXeKGeMSuYgEvUzHa
 msRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767995690; x=1768600490;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DgW3rdvm3evjcmTiQ4UBh9cSm2+TVh0AojTms1MHKYc=;
 b=kvApb+CS2PLPgwLEUx4wZlGSp5HmnqMUh7/aHY82yvv86a7tl8jUzErK1f0NxXq6iS
 9p/RFnVow8lq6YpYaHbwSgipFNCo7T5Hno7q/B7fk7IeTQQRW2T4PZ85vDglBVe3Wp8x
 AqEdjKzhce5Tqymxnu9PJ7EPM2SfAjblMHwQBIhI4nu/jtJGrpD6pXyHErecfyrXElwI
 muT7be8mWwgIjF2aujUYsmgfQc2wTTMdnfea9fb+kPxIjXdrMr8NY3M6knTRuetale3f
 R9BPlCfwukskZLizRkrOrGfw6aTHM0K7TqLg2xn2NDYjmWG5Bv9QF+HkOuHZnOVFo/qw
 P8tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAIzaPjV5IGmLYP2/3PyA9Uikl1sP0wtlAJeGMVKEtkWpToQ7P1ikha82UT30dcBxKE9VLDULAhCFF@nongnu.org
X-Gm-Message-State: AOJu0YxUcAsodBJxI7/NV6wup9qL2FtHIpaF+CFQC2zwg8A38vPev1PR
 B9ACRwG02WpYXUqTdtewVlBAM7v7o/rX8k1G0FS5ZQqn6/eLPWDUyP2r0dfcvNKEhhUOS2mEO76
 SVdsX
X-Gm-Gg: AY/fxX4aS92NqxqNnDoMKYFIry6k7fXpOVdpkDGFltBxZ+q6yv3Np1pkHLQzTynb35P
 hEakH2K4pRiUHzl2TgcpGzFvA5P7Qscu7SEFg5IrQXERaMQWjGBw0AZJ0pGfJVxKDV6BEUDeBKR
 XPJTJ7J+BdUnCl63ieJEKhhfeHvC8/6Dlm8PiyZZVdUTyVE7ow++j8rHpXuxA6LB8M2WKMscLk7
 TEvH73vNoLsKMOfgmwy+xA+MIpGewlKd92wryUM7/J8YevfxWuiWUqkIKANxTNog8od1dlR5vqX
 2vcl4Cw0ZvOfJOYJ+k8kKAVJZyzOx3f+e0j+h0GiOQ23j/t2z6xJulQyjPnTZQ02JME15dXxQuz
 okFtWAl4W92meBCXg5rXMv5az5ZLOD+8+0bLHdV6Sdqmd8rMcLolm5TldQV7eqqxJXyEFK7l3DM
 F5pkdieUEFUGThOGj631Z9dNw/jLo0AtaxoDpnJVXT/b2pHWqVwS4SbAAX
X-Google-Smtp-Source: AGHT+IFlBik0QWbRb4nrJznrTU+jbj9a5mU26eXhyHZJDzx7EOZ/tM3UQCDn94R+w8HIHiq6XAv3eg==
X-Received: by 2002:a05:6a20:1592:b0:351:2c6e:6246 with SMTP id
 adf61e73a8af0-3898fa226f2mr10115470637.56.1767995689770; 
 Fri, 09 Jan 2026 13:54:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c5bsm114812265ad.58.2026.01.09.13.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:54:49 -0800 (PST)
Message-ID: <25fb8a5c-42ee-44be-a6c5-b3a1630b1009@linaro.org>
Date: Fri, 9 Jan 2026 13:54:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/29] target/arm/tcg/vec_helper.c: make compilation unit
 common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-10-pierrick.bouvier@linaro.org>
 <6ceec36f-2059-429a-b59b-1da03b59a49a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <6ceec36f-2059-429a-b59b-1da03b59a49a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 1/9/26 1:44 PM, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> We need to extract 64 bits helper in a new file (vec_helper64.c), and
>> extract some macro definition also, since they will be used in both
>> files.
>> As well, DO_3OP_PAIR was defined twice, so rename the second variant
>> to DO_3OP_PAIR_NO_STATUS to reflect what it does.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/vec_internal.h |  49 ++++++++
>>    target/arm/tcg/vec_helper.c   | 225 +++-------------------------------
>>    target/arm/tcg/vec_helper64.c | 140 +++++++++++++++++++++
>>    target/arm/tcg/meson.build    |   4 +-
>>    4 files changed, 210 insertions(+), 208 deletions(-)
>>    create mode 100644 target/arm/tcg/vec_helper64.c
> 
> The whole 32-bit helper vs 64-bit helper thing is a bit of a mess.
> 
> I think we need to ask if it's worthwhile to separate them, or just always include them
> all.  I know some of the vec_helper.c ifdeffery is because of the helper-a64.c separation.
>

This one is the worst for sure, mostly due to macro used to define them 
that has to be visible in both compilation units.

I don't mind defining them all the time even though they are used only 
on 64 bits target (same for all helpers by the way), but thought you 
would have been opposed to it for code size reasons.

> On the other hand, since you've now done the work,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


