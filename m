Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74742FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 20:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvLST-0001Ux-AQ; Wed, 25 Feb 2026 15:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvLSS-0001TB-AU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:26:08 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvLSQ-0001Z0-Ls
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:26:08 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82735a41920so72235b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 12:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772051165; x=1772655965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xBgWXddbSEAM/brQCoswKKq3FYsW6vPsQkgk5p4XUdc=;
 b=PJHMMeOzxAkuuybaHc8ACCmzhTx8CK8MB9QXsYwAFsJWQ5howXVAIH8Zui85WcX2Cm
 lSyxAVLTI7fOiKOSagcyVyX5i9tQAXxE8PbUcccg/ym9Hyrj33y6JqzpJNY3sHTjd3OV
 /6lTRacmMalHY5kKwJrvXfBHbQSpYjy2Nc3+tt5Dm/sJBoo/9y/zXFxLnA+XZ7+ysO+Q
 lZV+0YN70sEWyZi54r0XE2hNI72w0Jbo3XzBlQ7DI6B8Cg0S1ZqVTzASUFGiHXdRmZnV
 S6tvFKYm6FNTa4LAVsMjLOVJWVjGteRZsoPFTYkSWNi/KWwIAJqwsQvpXly+8h0eXScx
 0cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772051165; x=1772655965;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBgWXddbSEAM/brQCoswKKq3FYsW6vPsQkgk5p4XUdc=;
 b=OUE2aRMzkvDFjpfqt5AN5E0fW5tHwtHup5qFwR28BxgewNeIqnQ5SNzEkDhyqCOBur
 nJtoBr1u9CwqjaV8AI2bHs/5mv8Y8VGfMN2M9kS64OoryTcPeBA/mH/PluZObXQOPs2L
 /dbxtZqaTqbncvO959m5Ksq3SOiPQWA8Qt46zk3oOCE5Uawj9xhQo3Q1uMgl9NwrNPkN
 qQnz7eCRf1xY0D5XAUhAM4zuUl1iG6mioSGajPncWQ7smDLiF3MHoz2pxYc/dhUVxc4W
 7rKYqGSRwLk4Jz9m4OCmU9v3w1t+ljwOtpTWmIjQNgUPyNWqaxbZ7wysrm9GtBlAB7Ct
 fZTQ==
X-Gm-Message-State: AOJu0YzJArthdo49V2CUCmHJq09eDwBJcygsjRUwFO3HiEJxGKcQhPxF
 JsgUS33hfzREPGoyBRk+fG50UoGweNi3dBo/kzDGsyvGQTeHx5HdPsvHydR4DgPtPOA=
X-Gm-Gg: ATEYQzz71oJ7KuGoTePvgo1GJegmaj4NAHQUY0T46JWYn16a8NvHNDP2Dmesc4qpObh
 sM71AxYZHy8qOL8EOvOJohlAqgSqS5uUG+gshcaj5+sTUyo/0L81ZEzyQoEu8S5LVkaaUJYQS6U
 eeT5OL0nZmxhsXKvsJ9cunt2f0UX7RhnxIpitqCamU7UY+JXU9MU6dmeSmTNNB71uA5kBheHGCB
 EHJiai13HkjbURqt7fp1yJZBWqHzcO3j6zrBI8aeVIiRJXTLjyY+sV/xVWSFEmR/ZAyRGpam7DH
 guXinUhr8wxUOpyJSbtESA9kAVQA2d6FdLy41C8SpvX2ifUTuubk9wsUQ+m3ELgqN1KYb2SyYA1
 RGGersRY1tQak1bLZLzEhyUiX8C22C/JbGYCIXl51c4WAvqQWlGroa3cUlj2x8s006d7DrGbisj
 DFgzaA5mG6YXO26a8ay4J1XOLX44xrknng2MWOKPjR0CJ52AsS4yt3wgH1OTZxOwhpi1gL
X-Received: by 2002:a05:6a00:71c7:b0:824:ae74:571f with SMTP id
 d2e1a72fcca58-826da9f1515mr13742958b3a.40.1772051164985; 
 Wed, 25 Feb 2026 12:26:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db4955sm98616b3a.29.2026.02.25.12.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 12:26:04 -0800 (PST)
Message-ID: <cb25af3d-c1c5-421f-a567-1ab1d4a720c7@linaro.org>
Date: Wed, 25 Feb 2026 12:26:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 04/31] hw/arm/smmuv3: Introduce banked registers for
 SMMUv3 state
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221100250.2976287-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/21/26 2:02 AM, Tao Tang wrote:
> Rework the SMMUv3 state management by introducing a banked register
> structure. This is a purely mechanical refactoring with no functional
> changes.
> 
> To support multiple security states, a new enum, SMMUSecSID, is
> introduced to identify each state, sticking to the spec terminology.
> 
> A new structure, SMMUv3RegBank, is then defined to hold the state
> for a single security context. The main SMMUv3State now contains an
> array of these banks, indexed by SMMUSecSID. This avoids the need for
> separate fields for non-secure and future secure registers.
> 
> All existing code, which handles only the Non-secure state, is updated
> to access its state via s->bank[SMMU_SEC_SID_NS]. A local bank helper
> pointer is used where it improves readability.
> 
> Function signatures and logic remain untouched in this commit to
> isolate the structural changes and simplify review. This is the
> foundational step for building multi-security-state support.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/smmuv3-accel.c        |  42 +++--
>   hw/arm/smmuv3-internal.h     |  24 ++-
>   hw/arm/smmuv3.c              | 345 +++++++++++++++++++----------------
>   include/hw/arm/smmu-common.h |   6 +
>   include/hw/arm/smmuv3.h      |  30 ++-
>   5 files changed, 257 insertions(+), 190 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

