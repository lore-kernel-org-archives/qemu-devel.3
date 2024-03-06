Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921DBC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhibk-0000gM-Bn; Tue, 05 Mar 2024 23:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhibg-0000fu-TG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:10:16 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhibe-0002hD-KF
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:10:16 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c1ea425a0fso1705967b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 20:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709698213; x=1710303013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KQ8nkclnb5PZgICeNqqZaM+a8NYSE3nwn5HIjlBN90k=;
 b=Md4df+ifLidprTB6qFj2Ilup5vF8dTOP08k2UWwRzhNso1F4C+B+sbXvxXPIcYS0NT
 /R+KMhusSXHDDGIhNjVSJU0N0jlgAJ8TtDQbmnVke28K9KzyLEZplyX+QctZEmnExgUi
 Jsrcn9Ra/uK3haH0faRdgb1xmlK/70M3uKHKjLhdhb1ycGC0SgjfNZ/TGEEOlfx1TmJu
 D6T9bmWz7Myh9p3PQ6kX5cw1gdvWoKrX0exwz2M4zkV84PkX8O7+mnAPE6i0S0R309ty
 380HWtydzXiVx0DZEMZeozzxEeVqJnZmAgEf4z3TSl9K2xjH6wGS9q2piez0TzVAHt1t
 Cbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709698213; x=1710303013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQ8nkclnb5PZgICeNqqZaM+a8NYSE3nwn5HIjlBN90k=;
 b=T+khv2Y9O/o2s1wv/ZjpoGHQsblHxZ4RcNfgO/dKq1oegs5YUjWvrOWoWNFhRZUIHD
 cUIByNBb+0Et68T2Qc7lpozsgsy5ZtW49skKPZkQrLbSp3Fx2GtAhJeQ3RqNvZSmL/yC
 yAnqQDBLc6LjUqYbvfl4I5jOQbMr75bSh7cTYKGIf0f9jDEgDaFqlOsRp4EP6lhf6Zgc
 LMwCIMF6gPikEr91GQdcsYeAeaxzBV2H1Nzf5M8djOGD6sIpJ8pTix8Hxp0hwcznz+HK
 19LFkmox5C1Lrien5l1/IUz9XxwBHt1Ngwm164DP+v1t8YR2o5hRpLgVXJwr1jRM8sys
 qe2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr7UeY5OcuANh/1hEKOMT9ceR63hFYmJxoz4TsCoU0w1U7WNKiRfAqYLacYtCJyUaIgrRu7Clrwxcz+k8Wswey3FeL8Pc=
X-Gm-Message-State: AOJu0YxW6e5GoH9DZtKj4pMnXjZt8DHULM1XRF1XJ2HwrqGWj1SNcD3u
 rljekx/BW1yeVeHr3L2qbvbAFqZQnKnUo7hKmyGluRdBvOaTLraml12z1Dq6HibOlFJEdDPku1M
 a
X-Google-Smtp-Source: AGHT+IE1ei1Gs1TuAxJLqgx/WUfF83sxFiNJsAuTQwNKJ70iIvt65uqEijrgJwt6x74RdbS0Faq28w==
X-Received: by 2002:a05:6808:2189:b0:3c1:35f2:ecb9 with SMTP id
 be9-20020a056808218900b003c135f2ecb9mr4579350oib.49.1709698213116; 
 Tue, 05 Mar 2024 20:10:13 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 j17-20020aa78d11000000b006e6454afe10sm1195957pfe.205.2024.03.05.20.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 20:10:12 -0800 (PST)
Message-ID: <fa6b408c-43fd-4011-b704-ac7ae256fcbf@linaro.org>
Date: Tue, 5 Mar 2024 18:10:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
Content-Language: en-US
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
 <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
 <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
 <dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org>
 <5325b63b-2a51-8448-bf70-c0659497db61@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5325b63b-2a51-8448-bf70-c0659497db61@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 3/5/24 17:52, lixianglai wrote:
> The LDDIR_PS variable is not described in detail in the manual, but is only an 
> intermediate variable to assist in page size calculation during tcg simulation.

This is exactly why I believe adding this intermediate variable is wrong.

What happens if LDPTE is *not* preceded by LDDIR?  It's not the usual way a tlb fill 
routine works, but *something* should happen if you construct a valid huge page tlb entry 
by hand and pass it directly to LDPTE.

With your implementation, this will not work because lddir_ps will not be initialized. 
But I expect that on real hardware it would work.

If this does not work on real hardware, then there *is* some heretofore undocumented 
hardware state.  If so, then we need a description of this state from the hardware 
engineers -- the documentation of LDDIR and LDPTE need updating.  Finally, this new 
hardware state needs to be added to the migration state.


r~

