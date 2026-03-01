Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E92FD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 22:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwpIF-0003Co-W1; Sun, 01 Mar 2026 17:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vwpID-0003CJ-27
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:29:41 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vwpIB-0002fv-Ct
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:29:40 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82735a41985so2159222b3a.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772404175; x=1773008975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kULR+4TIIC/fh8YK6atst1U7XW80edckJqSNS46GPsk=;
 b=ddt7HrU/EReSNNXIxO091UJPMNEhrNyZFuB9yzeDNWSmvtRRTnjGFQq3O4Xks9x3pT
 0nAK8NlNgoHQTWO4eunSlcSqxuf7iIMgnqOS63XOIAFR9ff0kzAxm1jU7VKqv1PBnsbW
 QJxEJ7G5/qVNJ5qTnMgPViv2SfYb0//bdd+fp6RTvqZvV9OrsxGJrkkuF7pk7liQd/nS
 nlCdSnYCbumbGQnmD/WDTi/eMeMIsHeDyks+AlWlASlzDlKf0Fu6UziVBIhAJPxzNSeR
 1AC+xn1hcAnflBve68muS5iwI5un+Wo+FO84mY33AaXyYloxD8yDRtANH/LM0D2VKhnf
 x0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772404175; x=1773008975;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kULR+4TIIC/fh8YK6atst1U7XW80edckJqSNS46GPsk=;
 b=M87Cc7yJimJwsCkQUPnN+nu6BBnktX9t4pHKjTapIWiy1Dcadn78aoYW57w1rocwp7
 4B4oewrsLZb4X+4FhLJRiNEf6d4WcDrNfYYfquJ5LN3/2GqKjr0SCktCjJ+TfV/QZ1kY
 KAp/X2Y6Hr1N1JJU6z0FCto/8DmOmD9ItP8P6bl86lXFYNBv3MMdzyhZcUKmv4HaJMK8
 dtrtrNqTwovieBEAK9r8YycX9u8sH7S8FuX4KkwZx0ANRQy95HebA+XAfMXDCfgzOuvP
 Zr1uYjoMyA2Sutg+8EDAlwkHOvF3CD7mjJl6beWduyDMy/zb4xfMYF3c3aQZbt+s1yJZ
 apJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL6FNQpN47dJzrQ7aGXnz2/IfXmO64MsHAac+2IhUYCAsAxk7cbmEnLb/6bUfSI5jEt1jzQQMuej51@nongnu.org
X-Gm-Message-State: AOJu0YzrMwpBnkov22QM/SyYwojADDjTm9iIhc+qubsKB9r0at3FRw1o
 cbHFz9LcfPMmwiFBHXnF2mGkZOkBL/JC73X4JzARKa4ncPZROrQV+C1Vg7TNLh407KQ=
X-Gm-Gg: ATEYQzyyO16/faF8d0JK8Rt4WDenqp92xJzRwYvfzHNqFu96uNJOa5Stb/e6pkewYym
 9sky/IxTXLwiIMk/ZCjpkqTg/O43wgpncgAQhYH4INi9h1tlsB/or9SXbRRbgWOM1G6wyEZnc7J
 BzsK6hA7PWNN0h9gDL7tssVzBO3m6M5HXtrBFyRAAY2uY+aQP4KDuREfIG7eJQ2nWVc4CZmkAl6
 N2GDADCqt1B2vT1HxjLcA6p/R7cWCAk2vdxJtVdZghstCqQ6qC6d/l7z3q4N1qd96hHIvnUC+Vq
 D753WEu3tRAl3hWA7pnZvGiVXQ/necOz2MRy4K6vZpIiBSmeTLPXYaasFgE5WaRGsJdL7mUnixL
 cUoK+GFP7c3Gq66sKa+gVsDh9Rxk36WAu+zeW7S+3ct6HYyrHeRu5inoBnbxUxFSIO9ypHFVa71
 x7c34qHXM2yD+KJkzq6DvC5P+jqyAYVfrOFnDKw0jv0Q==
X-Received: by 2002:a05:6a00:3a25:b0:81e:96c9:131f with SMTP id
 d2e1a72fcca58-8274da126d0mr10540463b3a.37.1772404175123; 
 Sun, 01 Mar 2026 14:29:35 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739dabd43sm12949039b3a.25.2026.03.01.14.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2026 14:29:34 -0800 (PST)
Message-ID: <8abec38d-8176-406e-9345-b98e69d5bed0@linaro.org>
Date: Mon, 2 Mar 2026 09:29:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260227-sme2-hvf-v5-0-1c60a92910c8@linaro.org>
 <20260227-sme2-hvf-v5-2-1c60a92910c8@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260227-sme2-hvf-v5-2-1c60a92910c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/27/26 19:56, Manos Pitsidianakis wrote:
> @@ -1121,18 +1122,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>   
>       clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
>   
> -    /*
> -     * Disable SME, which is not properly handled by QEMU hvf yet.
> -     * To allow this through we would need to:
> -     * - make sure that the SME state is correctly handled in the
> -     *   get_registers/put_registers functions
> -     * - get the SME-specific CPU properties to work with accelerators
> -     *   other than TCG
> -     * - fix any assumptions we made that SME implies SVE (since
> -     *   on the M4 there is SME but not SVE)
> -     */
> -    SET_IDREG(&host_isar, ID_AA64PFR1,
> -              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
> +    if (hvf_arm_sme2_supported()) {
> +        t = GET_IDREG(&host_isar, ID_AA64PFR1);
> +        t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
> +        SET_IDREG(&host_isar, ID_AA64PFR1, t);
> +
> +        t = GET_IDREG(&host_isar, ID_AA64SMFR0);
> +        t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 1);   /* FEAT_SME2 */
> +        SET_IDREG(&host_isar, ID_AA64SMFR0, t);

Why would you need to do this?  Surely these values are already correct.  And if they're 
not, did we miss enabling something earlier?

This will break the moment FEAT_SME2p1 is supported.


r~

