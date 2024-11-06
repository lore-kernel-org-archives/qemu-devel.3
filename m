Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C223D59F55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jfp-0001qF-Kh; Wed, 06 Nov 2024 12:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jfo-0001ps-3b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:18:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jfm-0000f0-3d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:18:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4319399a411so347725e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730913504; x=1731518304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IUl1i7vZoct9nux8s1wJMohWUs4BYFVRvq13Tcz1Voc=;
 b=C223yYzVnz6K/tKq6wnXUS0WKYTyno+VWlXD4vkvyiFUjIkJPhm3162Zoj+25kFxfx
 4TUBskegf194lSy/geK92/G2R9M32YuoZi7oMpJEE5y3w+CS41nM4pLJM5AyJAyN054a
 NK5h6Zy1J9jEfp12yHV3zz9WYhY1ekcYM2fN8RaWbEJVKM4dJ9NtDbHc1Prq7oObd2OZ
 HTzZIVPWTo9wJcNTD/0MStRYUT+UUKyUcHxlG6Yh9rGdxjhTEKKldFxgoR7o8IC2/tSw
 myXE30xAZjAOKi6flWz4Yku/GhiKto4ClLwd8sQzUsWKCgFEjiPRQBUl5spV4syyiGcj
 gYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730913504; x=1731518304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IUl1i7vZoct9nux8s1wJMohWUs4BYFVRvq13Tcz1Voc=;
 b=IUOzcTJgNKA778b+B6JNcKvj3/Mw/ROUf6wMP7D6NPrxMOeF0ybIIxBGwwq7MlHvg6
 I+SLhvdqAabQHirVfPzhcfpOrGJPQXcSlIaUi5HafY8cVagAV8WV4t+HVlfGV+LNiVgp
 Hm5rIPMQQ5GrCsltDvIjFyK/UzCVkfRtpCpYorBDspe93RuSRWgPziso3qhvJUri7dbC
 cPeq7WPqlY6FAHEBSP4q3461tV11+O2ylJWubOPs4jxBUDkCbbBcR3lBd5vmVQF4fDZW
 o6d6aDw3pAsmGuW7/T3g2IEFFJtOa830pUq2C2sOuGT+VtYLEqctron+IQFJmx6qXPPI
 4gcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWX3H7xv1dsq2qomNVUxdDfgboWye0f64RxUl3Wyv60BLL1qscrIVwtsOw+ndpyKbvzYYNs+HZMh8g@nongnu.org
X-Gm-Message-State: AOJu0YyWzgSGwptj1LsGx1O+0+Cw2BPphr1baN6nbGGH/9KoBrPZmZNd
 vX3Jx0fniGgk/6UKBOh+OagM0dYuaLNafnzyygSyYLHkXq+4r6C4AlQys3pLv0M=
X-Google-Smtp-Source: AGHT+IHpYTVOtAX+czG8EeMu7snyAG6wpPohSxb+RZccO2aTSkRKTfY7+/+AdGUQaa37mlj4oFDt3Q==
X-Received: by 2002:a05:600c:1d15:b0:431:55bf:feb with SMTP id
 5b1f17b1804b1-4319ad0899dmr374307035e9.25.1730913504007; 
 Wed, 06 Nov 2024 09:18:24 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b58d1sm30067285e9.11.2024.11.06.09.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:18:23 -0800 (PST)
Message-ID: <1e5d970f-cab9-46ae-b295-8e91dff9b762@linaro.org>
Date: Wed, 6 Nov 2024 09:18:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Check current_migration in
 migration_is_running()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20241105182725.2393425-1-peterx@redhat.com>
 <f11c663c-49c4-439a-a20d-baccbc1e0756@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f11c663c-49c4-439a-a20d-baccbc1e0756@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/6/24 01:43, Thomas Huth wrote:
> On 05/11/2024 19.27, Peter Xu wrote:
>> Report shows that commit 34a8892dec broke iotest 055:
>>
>> https://lore.kernel.org/r/b8806360-a2b6-4608-83a3-db67e264c733@linaro.org
> 
> FWIW, this patch also fixes a lot of other broken iotests (vmdk and vpc)
> that occur when running "make check SPEED=thorough".
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> 
> 
> 

Good news!

I'm a bit confused by your message. I thought SPEED=slow was the most 
complete test setup, but is it SPEED=thorough instead?

