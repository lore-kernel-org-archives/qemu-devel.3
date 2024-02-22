Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AEDC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 19:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdEhL-0001iH-60; Thu, 22 Feb 2024 14:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdEhJ-0001hm-Op
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:25:33 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdEhI-0005Fb-2d
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:25:33 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29951f5c2e7so129309a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708629930; x=1709234730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oF4lpGq2MDfl+zCgIfXJbR8cwX/+n0Z38trpUl0o/OU=;
 b=HADGdSepPPBWimeGbO23qMwTKauAjtMKwO/SgSiZ9zhILG8jK9WH0MAz6zSmgZB4mg
 UWzjJkMIYJtmieSddcQcJPW86KYNoo/uTA/HxmFakIfpaN0qxZmyerOOsOThrV6neAiM
 E0UyjiVI5K0smgZ579/e1FKopxtLU85DhX6M5cvfMb5FPUEHoa+ZMKRKyBFaJxxYChzk
 JSUc0jJE4mDBp/KdNd1N8sHvfPaMLNQOGj/O3t3DOa0XwI/9sRYjM6JdLQiViDuR4uof
 z2hWK0YKf9vXroJ0Cc0IbYErYc7TcuJn4QMNKnLEokj6ThR8XlBd++cAMhc7dJdwHDJL
 DtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708629930; x=1709234730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oF4lpGq2MDfl+zCgIfXJbR8cwX/+n0Z38trpUl0o/OU=;
 b=YXwnd592EwLp04BVN6GkuFG55eH8Qr7a5/TZncoaAhycG79J8z5G3aZkNkCQ6NqJTD
 t7XMFCrvSqt9PnRF3nKLyr52XMgaLf4pErJn96gvxk/aADtUbZt3LJcSr79MloqiAEzt
 spcxnA5OUb4S/09tl/TB+OWZhS6hpoc/IINu9HH3VhOcHMQHxLYhLx5oXaJXy1PLz9sY
 KpduErvr7Qpd6/uofiCOVXRZx/FC1mEFbGTbofDk8fjO3VBM+QeEUsgcTS26lze7XEo4
 eeM3qLsgyJ3rc9d8AofCAy1HX5aVZRda7CMm7LWzNmk5Mx9DEc1XhKURw8xkGxPsxQeo
 dWfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP5m4og+YULAj7Z6Me5eXgKN/Jb1HXaz5/gP4IBMBxQVQlysS4FLnYmQDoKl0NFeVyzAsrM5uTYL9eI6NuaSu/fHdB188=
X-Gm-Message-State: AOJu0YyVHa5NJcgyjAZUtyI5DBtsMAZv2lkXZ8yhnQph81icTP68s8wM
 /gcFX6duxN6YAbfxkBLadSxFWM7jZCdA3ntiF7VTZ2i4ag4rECk+wjlt4i/4gm4=
X-Google-Smtp-Source: AGHT+IHW/sgW5u4Pb//3d4Omv/+H2sQQ5W/fAZzRBljk89zLVCTOcHOqK0FI8kwoELEpAHfezUI9GQ==
X-Received: by 2002:a17:90a:bd86:b0:299:560e:79a0 with SMTP id
 z6-20020a17090abd8600b00299560e79a0mr12810306pjr.31.1708629930214; 
 Thu, 22 Feb 2024 11:25:30 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ev5-20020a17090aeac500b0029a56afe382sm1603836pjb.39.2024.02.22.11.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 11:25:29 -0800 (PST)
Message-ID: <5f72beff-64a8-44fe-b87d-6e532e2b210d@linaro.org>
Date: Thu, 22 Feb 2024 09:25:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/22] target/arm: Add PSTATE.ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-4-ruanjinjie@huawei.com>
 <5f25d9cf-3ca0-4adb-860e-71a8fac3b504@linaro.org>
 <7e42f863-0079-18bd-94b5-83f3f40191a5@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7e42f863-0079-18bd-94b5-83f3f40191a5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/21/24 15:48, Jinjie Ruan wrote:
>> Why is this split out from env->pstate?
>>
>> The allint bit matches the documentation for SPSR_EL1, which is how
>> env->pstate is documented.  The other exclusions have some performance
>> imperative which I don't see for allint.
> 
> It seems to me that allint is a bit like daif, so it is reasonable to
> maintain it separately in ENV as what daif do it.

daif is shared between aa64 pstate and aa32 cpsr; keeping those bits separate means we 
don't have to check the execution state in order to find them.

allint has no aa32 counterpart, so it can live in pstate always.


r~

