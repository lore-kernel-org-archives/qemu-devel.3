Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A91C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDsx-0007Sh-KQ; Wed, 30 Jul 2025 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDVz-0001PZ-C3
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:35:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDVx-0005eq-BS
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:35:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso3661285ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907703; x=1754512503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=83iMmGOym2u/y7T61DrKEIvLaUsK7Fe13OpXjZFMAXw=;
 b=jWIchY7HwpMOZzWeovKIJSKVUevoJZlFEVdnDUHCBkTL2rPsmU5Y++ybx1F6E5kIKG
 PiWbKV9VkWZhxFOh8PrtUANOaX7yhbAQ8TtN6RMqmRe3elq3KNKncm2O/N9IWKyfS2Je
 hruY082h+bFwJInvQZqe4dw7berr3vRE2AuqLfkJ77rySIQMLaTouW5AYR5767/VOSOq
 4m7M3e43C+eLQe0km6c+UImbRpo7a2QM8pRlndFzEDFygVaH4I/k4/UlNlX/QFlHTCPZ
 JulMFq2LsDenSDjZiF9ShYfeGAO/BbKj2RSccHkeUTPhbS4iJ/ZUBgs+m2ABvZNoZGNz
 Uz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907703; x=1754512503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83iMmGOym2u/y7T61DrKEIvLaUsK7Fe13OpXjZFMAXw=;
 b=Of+WFJQ42/gVmffaadC/Tm/7XMRrhg0cinbuddrgD1DchXMiOizHv518l4aCvbQQzN
 0Spvy0tuQ6mhUjPwTW8nCaiEesvr6QC6dlt7sgp2XVKZCukDryZaa9pfgdLe0PVgsi+9
 JMSUOQDCpA+MK3flexriLqmH/L6vgFzboIySQcDBX3jgvFzveceMn65YHJBi/9WZB/oG
 Z872rKRWI8SocQROUjHpgwLDJJlC8rKnVjrrP5M5JVmlGg4j6l46OQiAgoOgD4Oinsk0
 niBH1G0PDCgtxkLHafj6yiv14qEvVXyE/P8fSBUNIjGQPjKQ/6/NsgDmo0UiueuSBOIB
 D3Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFf/IgveeW5u4gjX0Dw0QCTtwdSvvBsc8dmCLv2UAZ6vEN+HU5VIhW7gBWIFTSdb+qWw9dQ9BfUssG@nongnu.org
X-Gm-Message-State: AOJu0Yy6G2vIIYD5caJYG18XnNdjjraViUTBpYuXmQY6+McE82wC134m
 VXS09pN189ZZXcJbIXzXPzd9SSQfOE2lh2eecIyx19IvUxfp6Z+3vRMJ4OzEcGGQZ3I=
X-Gm-Gg: ASbGncsdMGZRP10mHjrudpkhoTqt6YOxsu/YyFnPMo97q/AV8cY5MI/P4urKdA2M30B
 Ez5SCgiX3rtQZiOxN612f5AHGxfYXTvFbj18RQYWkVQEQy6D/fKhshh+uM8jp9ieUMttp6dHsm8
 Rm6Iz8N3Tio8flcPRvvYvPfbJz4emtWe0SvDUY/V4thB0P7gsUgB+6KmhZxL0GZdIneqSaM6uvU
 JvH7cosY+VtP6qJm7eXjmzYWuP3Aar4mQ7LxAZ/+ToJ1Wjazk+R+swaItkMGGq6WCZQ9zxx4KfY
 H18cTOWIlFP336TdYTU8HridRc0IHtf57V3lyFlZhNhndjcnEefIB65tmJ1Pcdkw+RyGmsh+/DZ
 uiagMoiZO0dyfT5Zpjv0uIp57MsR8JlLVCc0=
X-Google-Smtp-Source: AGHT+IFNFLCjDJHBHAQKFXqxsQMSLziaAJZBe4+kwHkbcFJx1IVsm8+2rrJRr52PTpZ+PKQR/xzLqA==
X-Received: by 2002:a17:902:f686:b0:234:b123:b4ff with SMTP id
 d9443c01a7336-24096ad15edmr76658715ad.21.1753907703430; 
 Wed, 30 Jul 2025 13:35:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f1efe8sm78305ad.69.2025.07.30.13.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:35:03 -0700 (PDT)
Message-ID: <ba3dc166-07bc-4909-82cd-1c52fe513e99@linaro.org>
Date: Wed, 30 Jul 2025 13:35:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/82] target/arm: Add prot_check parameter to do_ats_write
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
> Separate protection check from access type, in preparation
> for skipping the protection check altogether.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpregs-at.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


