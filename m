Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0E6C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5U5q-0005ST-6n; Fri, 10 May 2024 13:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5U5o-0005SJ-Dp
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:31:36 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5U5m-0004ox-Sm
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:31:36 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a5a1192c664so606126366b.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715362293; x=1715967093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IAkAjxKOTWlqCrbAoBhZ6a/vsUWyrKQOk7M2z63g7y4=;
 b=xpJ/XnIPZ9GJFeaxk1ytRBsh79/56oCJKZAUk/8wdc7FB559ThLbZ/Du9+IpypfkI0
 9b4dOTOFWp6cy9rhrAp0ZUbhC6orGtIkHb1/uzBa2Qyl0zEdmHmOOUvXchZ07dCwPtHP
 c6cD+JaISekNrRUdjWnoPkMP2NZPh1X6x9mV8dsrlABncy4FGHW8wOKR2lms7iHQ2lQ6
 YrYRQttgqBHZdlMAYRvzHWRt9Ssq0fYK6ol2DCSUiOMsKGz+c2o8qR44e9rxNqftj3ax
 1cVP1eLj4YgBQ10nAkrKHueSicXzX8YbFQKuJuWMIDTyU/jh0lauPet+wTvRAd+uF4+L
 c9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715362293; x=1715967093;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAkAjxKOTWlqCrbAoBhZ6a/vsUWyrKQOk7M2z63g7y4=;
 b=PodJho4edfv42L9WgVl7hF9vKTf1pNquk4uOQL6lhpz/JwsyDCh+j8TIpYN8W7jdtj
 wngXp8KnzEmP5D0zLP6A3As/g2eT6Ds/dnj0/3CHGGC13WkL9UYBau2b4eNqQ9SI/TvR
 Wor85XpPfsQ4O9NM9P7ygz/UUT6/94+7h+oy6cWiRXgvEDDFZqs8eE4h4D+uMtdGbJGC
 0+qbZgzdM2DXwVxpF29Pz71yYwrbBPDHpFDbKsqtADfmblpYcMAVkO04mQ5xIhHeoF1R
 TpEqyZ41/cSWpTOsHpp0izDHFPovbhO0LIKjs4ycPDfDkIreyJ8b1b+GhYQb4EVCAflE
 yL+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGXa8QqtLo+q6qE1jh1TYDXV7imJTYMmnwAcp9XT6Ij+VlIwO8JLZ9h8LDN8RPI/dMJrvAEmoW1f1YBvSmAHSV/cHYkQg=
X-Gm-Message-State: AOJu0YyEA0SSw8i4BanghRtBsh5AX5gQi7j8H4LnhCXDQ8f7rS3Yz10/
 UhisKu4ppo9U6lSqFQEkMLdSyEy2ua1CG0qV9+Y2xETF+fqdMnuZWDOykNUpc6yym91Oo6hVzS8
 Y
X-Google-Smtp-Source: AGHT+IHv88ZzWzHkKTtZ8hdHcFWsqoOz3fJgT2WghtcI3zONQ5SRvlb4DDwATOHzZgsMVpnY7HRKpw==
X-Received: by 2002:a17:906:ca4d:b0:a59:af4c:c7d1 with SMTP id
 a640c23a62f3a-a5a2d65ecf4mr306153266b.49.1715362293188; 
 Fri, 10 May 2024 10:31:33 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17727sm203980466b.208.2024.05.10.10.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:31:32 -0700 (PDT)
Message-ID: <3bb21d14-5370-49bb-a071-20cd86aa3e12@linaro.org>
Date: Fri, 10 May 2024 19:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/41] target/sparc: Enable VIS4 feature bit
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-42-richard.henderson@linaro.org>
 <72849956-04b9-4d52-9f32-098a2ea691a6@linaro.org>
Content-Language: en-US
In-Reply-To: <72849956-04b9-4d52-9f32-098a2ea691a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/5/24 19:16, Philippe Mathieu-Daudé wrote:
> On 2/3/24 06:16, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/sparc/cpu.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> 
>> @@ -882,6 +883,8 @@ static Property sparc_cpu_properties[] = {
>>                       CPU_FEATURE_BIT_VIS3, false),
>>       DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
>>                       CPU_FEATURE_BIT_IMA, false),
>> +    DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
>> +                    CPU_FEATURE_BIT_VIS4, false),
> 
> I don't see any current CPU with this bit enabled. Nitpicking,
> maybe use "Allow enabling VIS4 feature" as subject? (I suppose
> you tried using -cpu foo,vis4=on).

Doh this is what you mentioned in the cover letter...

> Could we add the M7 to sparc_defs[]?
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


