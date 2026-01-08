Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1309AD1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwzD-0001QV-PM; Thu, 08 Jan 2026 15:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwzB-0001Ps-Qn
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:52:01 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwzA-00022x-44
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:52:01 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so190747b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767905518; x=1768510318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WduuRd1zBnSprL751T9lZwTYZxTtQikxVMMFcslllPk=;
 b=UKDjq0qDmyaWY3t/WeXWiceyvH9yJ5wAE5b/aQMu+LGwxeIDf8GFoaAM7x47T59CU+
 LrSYK8SHUT4qFI6kcWkqhsPvGDLS/ojAN8cAkQDKnjRmZ6hxHBmxBmOYqvHYGfZ5WHMb
 JoeRpiAbKryoxd2CTFnGyQXMNVmtFsP1uqmBjLyrVgnxyL6HQS8+3TAEvSZPSMR3NRy5
 r4TkGj+iRgyKrikjb73k78hQCMFqBctQprAYpA+HRs6C66ijdkHiDDQ4YUuphjYqmZT1
 2zycffGREW0gBYng47xcFOkSAvrsnK9FBH4DPsNGSkboPiL7wlsW5Ti8GRQMWqTeEZ0x
 XYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905518; x=1768510318;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WduuRd1zBnSprL751T9lZwTYZxTtQikxVMMFcslllPk=;
 b=Pj9RrGYwD0dVLBzbVFNUWHhvv4RUtddZWpszg+Z8mr47fLbyNHGod2qcb+wKZpBW6i
 mdhbc+lC2AT8PKTK5vUBz2Cd7qeX/fJxyszZbkrqcIja3/Y7WUwk/Lrd/1UPKvtexYoo
 r/zcX0XHn8u4/GxC/HYl/HHoiSGvcAZPyvJunWO7FUprt0sgKvirYTn19nn8Dr28pOXd
 cF4P0jj9iZHVHnJNl66iKqsQsSPlmSfCGlD6fQ6VA7UKgJNjSdSRtwNCO4DF/So8T3bU
 30aS+RWolMr8FHJhh+MDkqcMUMWocVizJHd/BaFM4e0zcyPiMenkQF7KDjTJ/Yp1Spxc
 AG+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPxXx5xeBQzti37Z0z111cksm36VkKwEmP6Lbe4wZtWaTR+PD5HBe3kkZOQ2zwWPjFIeQRRiaoxNaM@nongnu.org
X-Gm-Message-State: AOJu0YzbSxr5cmcAcynNw20UkQ453+HMYBHr/mM9Bkvroe0xqOQVWEsg
 /WB4kr2EwVP5ypLtW39ynytkF7I9Ehr+6VcWjq5lO84IepWSXzCp5i7ua3A2jDq3Vbln57efWUi
 9WT/X
X-Gm-Gg: AY/fxX6zGH290+aZsdchWImwXBYD4irvsmi/ornOI9a1DtljqTeTtRE+5ZPNtZFUUiW
 zH0z+VGZVIhgO0vQIuIkF+7ho5zdT4vyRDmGMztmbHhGtpLdxyg3ZCulMV44RM/+mEyY5x+zi5A
 M0rjIPV3Nbag2WLmCqC1EXXNOt2qYfQrQwAcSsGqOSSQKc9KXKNbYB1Dy6pBsvI7FGUhS7E3MrU
 Kf6txPEAwLQsTx/aLikasfaZ/a3TtSvoun7QKhG5SHkXBFh7lLEH3s2Hr5TwykJb4IsKt9bx+N5
 JZFEEIJG0wEs+u845aYGJtiAyUV/fSw8aMe9lMt4ASEMiMqSrFVh7UQ0Js7uTXFrM1g+UNQxyjX
 FKFBvJJHAMKyyVLTbhrXwnKXxkwR5HzAS76NPDQyzxsG7CwCokBxk/2syAXVWJa3400Q6UP6qNW
 5QDJXvv4grC8orbDmmgIJsewplHuwga/jmjzRLPkiBe9IDZSILxe3ZFaEQ
X-Google-Smtp-Source: AGHT+IF37dwW1XI5WKygiZ0jxWbh59SKGcNWpszAJNZKwWluCvxNwGIdFJtLscAkrcPo/2a3ajgaDg==
X-Received: by 2002:a05:6a00:3286:b0:7aa:4f1d:c458 with SMTP id
 d2e1a72fcca58-81b7d85635emr6694239b3a.19.1767905518354; 
 Thu, 08 Jan 2026 12:51:58 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm8985488a12.14.2026.01.08.12.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:51:57 -0800 (PST)
Message-ID: <b654f3ac-acc8-418f-b7f2-2de27b1f14d9@linaro.org>
Date: Thu, 8 Jan 2026 12:51:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/50] tcg: Drop TCG_TARGET_REG_BITS test in region.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

