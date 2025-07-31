Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8421C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaqk-0004U5-NJ; Thu, 31 Jul 2025 17:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaag-0005xc-Oh
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:13:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaae-0005CU-PJ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:13:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2402774851fso7701185ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996407; x=1754601207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJXW1Eq8Tj+zNzSdOZYt2lyqQhSub7BZreGuAHChbqA=;
 b=H1k7mpuEHR7yZY2k+s9T+0kSVdQ3nSvkzn+ORZnEIQssZBkY5S7tsVeSoQExDe12xq
 6k0NearMYRTcR2qMg1QrAzsbsf3diUEUPuvKqrd+reYuRvfAi/V/KKSPwcpBP8TGY+gC
 9JCttqCM6z9ZTkiNzQ1l8kSpjIOlXAU/u2QcM346JK81jm6hfBTpfQbeNwtfdu5d0s5k
 bQX+mNLlcbsIQZ1jr3enRU22kur6JxqJ9SdnKVRHPDeoaq3iZherUqws1KU/oqBi2VUw
 gKM7BAvxS7R5sZdAfsC+7Zibnf5yWoG8NxfV6K4pmW7QOgxWkQ6oZ0rOE5gAv3d9wwH7
 V8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996407; x=1754601207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJXW1Eq8Tj+zNzSdOZYt2lyqQhSub7BZreGuAHChbqA=;
 b=f1Ttg1JyZBcO/zdpSbuS1MweP5Xv9wG0Xr66/okCRzubjPN83t3+l8/vGJ8kAj+Gyk
 fwzfPG4QgfLeH+FrWbqxWIlaRgY54WnUM4xvdabJ8lZx7xNSaNK3pnGBdokP/qLWNtCq
 2YZFnb8L0LSQMM7YHO7YHCxRqNiDyiQYKfLrOxATqppyMQz8scI7ZWGeZLMOiUpBY4y7
 Kz+5knajOaeX5wrncICYY2zV61L8V+q0gOdIDrcEkS9JOeOGRf8k7rfdhXm+zADbIZyt
 wgq2DRDHKBC9CMgsDW3BPsOAKVBLO1Rk693P+uoxzWnH3jC3C1ZFLhqFE91NqYOYxBlK
 dgWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd7/t6j5/ua1ywfWPomoGJg9knz+2EA2IuWULcnfgnl12h8WyQdsGD4sQwHCjvoodKGhw0enE8+EiJ@nongnu.org
X-Gm-Message-State: AOJu0Yy76RBYv/KbSGb5Ik6vtiejP3sMM27yFr2hkpUcJNYDbfmvcTWH
 YiOpgt7gxlpyejq3MCVUb0UKwnexZ+hCbJ+pjK6D3rT1NptX1KBVmls+zWOTKIuP+Cq8u6L8/eu
 eRfdg
X-Gm-Gg: ASbGncve36pxvBzX4w5TBNoadSF9qn/jC+XWpS2WwQEQft1FNg6iXc4FJuCr7dKGtl8
 1k5YOR1Luv1giiRWSGweXpBHe306VWim9gWK8yrSQhafr7bHhHl1Vcz8bjpMWB02XlO+vCuK/zv
 bZ2vzT1wfGgPr24o6nvMl0OJjX6hNqo6oB7drmneFlrjwUxLqKdGX2xuVHgaAmkPnzbvTkOeniu
 lvX2xZQXve6FG5W125Ex1U5C7EtXxjHYzIqKBsQqiA1hueoaa/QYs1WCjNugsc3Ue3rorv2thQM
 P3OfQoiaPugBziJXPAF5QPgKeBRzh4e0J4R4IPGWJ/rsNzk+I5nTfsMqVs2M5x8PllyfHt7QCeY
 vgSPEejZthYym0AcirMKRhWa+e+wpxtCKA+Q=
X-Google-Smtp-Source: AGHT+IFDOlYCvxsS5P1o13PSFcDw+Yd6tToodxD+QGIEsTzGYuV5/WcWEz3N5XbdnUtsQwXKsIAP3A==
X-Received: by 2002:a17:902:cec7:b0:240:9006:1523 with SMTP id
 d9443c01a7336-2422a4313c7mr2391905ad.10.1753996406818; 
 Thu, 31 Jul 2025 14:13:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef67aesm26267915ad.6.2025.07.31.14.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:13:26 -0700 (PDT)
Message-ID: <a41aabcc-039b-4ab9-bfd8-f5571db3fafc@linaro.org>
Date: Thu, 31 Jul 2025 14:13:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/82] target/arm: Implement get_S2prot_indirect
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Move the stage2 permissions for normal accesses to
> GetPhysAddrResult.s2prot.  Put the stage2 permissions
> for page table walking in CPUTLBEntryFull.prot.
> This allows the permission checks in S1_ptw_translate
> and arm_casq_ptw to see the right permission.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h |  7 ++++
>   target/arm/ptw.c       | 81 +++++++++++++++++++++++++++++++-----------
>   2 files changed, 68 insertions(+), 20 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


