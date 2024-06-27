Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB5AC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs82-0000Ed-Ul; Thu, 27 Jun 2024 12:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs80-0000DJ-M7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:37:44 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs7z-0006Mp-7m
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:37:44 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c9d70d93dbso5406938b6e.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506262; x=1720111062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBlrQ94xJqAcZtiA94krCBhAAA7GHABH3WP5W9oUbUU=;
 b=kcGcb/thXniNedfd0cvis92rci6q1u4FBSPotGUpvBLiUjHcG2Wj/kXm+6tPYDesth
 oMv58EZE75Zr5Kjn16C5h8bBwUTeXnmf+yzW9l0IcQNF5X7GCQEKW5k3rnGcQ5oUaU+f
 CEeLFbNJwo3oa3anMhLPoYoJRKemaEdVt5T9ras7aLJ/6ik6/Cz66WxkG/15iySEP0By
 4oCL2oKcXok38j/CIw8A/cxHHh/q7BpdmKn9VIKU3JooUdlqc7uCnV4fKRkczaHMROsS
 gVjg12jPs0QFtvwLPyQep8QBsmWNIHLSJc7ZgGrmC4PA68+iHpnF82vQhywKi0JrMY3a
 Fuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506262; x=1720111062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBlrQ94xJqAcZtiA94krCBhAAA7GHABH3WP5W9oUbUU=;
 b=FqVlRXWPBgSzOPylBZihLNeeLyv0BXvNFByf3b+Kvk3phNef6tJE3Lu1htPQ7XqI02
 WKzYBjh+yDdTGjpGGV8j6Ph4/q7Np3Ggfjq4Z4MVSnp3M4G8jbdEMjIwJycOF/dKZZGD
 YdpIqnA2ISe9VhIhVrQj6tsfyK/Ci3esKNFVSs1NrGbYHuU4hNlwTqWZ6xIGCV1gTIkh
 BH2vMx6eJuPlpihsDkKaiUnBo0KJW2VOKPfgP9NsXEOWkGkE4Zn9l5qYqdu5IBzBcTUR
 bisHnCQhvNCyB/TO2+phym8LiAKIWcLA881BBvl7l6dR1TRk5/pZAJXlIgwXgQX0rH6t
 BGXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPTPea1FXHMjqRv8iAnzfA/xIHVjCeszdS5Vzf5dSqQMm2Ack6+SyT8l0Kbok/yrs4J8gZF0HjkQgeiNwcImYolmlkOl0=
X-Gm-Message-State: AOJu0YzQMNAhTQGtwndI2DilKID0MPhl+sM3pLnWPe0WKQIlzhPjJeX9
 nnGAbgoNX9wcms9RQ8MoVKCbG6wZAigjDeli7p24fbAtpuyJgAa1O6D7Iup00dlnHaizCqmX8yO
 +
X-Google-Smtp-Source: AGHT+IFvh4SmahK2TjiUk+ehTFV17Bz44sbhWrW172mDgN0l5/HqwEuLwX4KJ3D3zLkDELWql92t4A==
X-Received: by 2002:a05:6808:21a6:b0:3d2:27ef:264f with SMTP id
 5614622812f47-3d54595d9e5mr16748139b6e.10.1719506261928; 
 Thu, 27 Jun 2024 09:37:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b491035dsm1576917b3a.67.2024.06.27.09.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 09:37:41 -0700 (PDT)
Message-ID: <e1cdf0ce-43f5-443a-a28b-3d1a8e54944f@linaro.org>
Date: Thu, 27 Jun 2024 09:37:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/i386: SEV: store pointer to decoded id_auth in
 SevSnpGuest
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org
References: <20240627145357.1038664-1-pbonzini@redhat.com>
 <20240627145357.1038664-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627145357.1038664-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 6/27/24 07:53, Paolo Bonzini wrote:
> Do not rely on finish->id_auth_uaddr, so that there are no casts from
> pointer to uint64_t.  They break on 32-bit hosts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

