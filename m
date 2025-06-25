Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06841C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURPY-0005oV-Ul; Wed, 25 Jun 2025 10:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURPQ-0005iJ-Fp
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:47:33 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURPM-00059Q-1C
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:47:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2350fc2591dso10570445ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862844; x=1751467644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ssBgkQmbzbFVaatDuHnShGtRFmB5XgnQJ231sG4UcPc=;
 b=E7M66qKEKkQiC5NpMZ2/Gdxg9KIELOpVBhuTH5TC6JvVx8FB/hER9/nmtXEgirtzwP
 a5NPlgRFuICqJqkEM/b12EDI9JThbnkDko5X2aZdQSti+eO99gWhtURkCeoYUyHZqI4A
 cWYHClAtdhX7GBGv73EFOMQprZQL6jEkPJDTEV8mCgX0gB8/66NenmSE4qMZypXNYUMo
 NBt5NNg8Wnu3hcapeGBo6SaJKy/vvKxRSOrb5UomrinV1F07YogUObpGP+fqtJ/7n0K6
 ejD74RAaWFxOorqKRlyasPvQh1+CmVabSNZMkG+Cbn1qxwRHEkcnjGl8DgOiEcEVburz
 zR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862844; x=1751467644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssBgkQmbzbFVaatDuHnShGtRFmB5XgnQJ231sG4UcPc=;
 b=gEKKljgkNGqr1ddr06EXyjK7CNG2aSGWLjn5vlxHuYTs9oTamjRMVwXTB9B/f8AmH3
 d5rXvxnCKxQs9aRJGuLx42mDdbxY915YMzqdWxeKXk8l30MaEVZ5FPp/ISHE4zeEaUc+
 34tGgJvQ9YueV+acmYzswI04okVxMxI/EcSbPDkIcme+bE3N7F999hJXKk/7rLGfhHZ9
 xQJUTJMbPWnCxaPAqYB/HmQSpGAI1Rfyv02tcnfkreoHD89GSH1RNyIwCbvC0V6e6lpI
 ZmyEvfMtfIK8IOX6SFS6wqC2ji2y5owh8of+a48EJ3ASCLA5U0fjxZLjZifL9XfqXGwz
 SXfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA8n5f6CoXPIKNvL+5ZLmy9C55gPI0jGivlbs+nMUjoB2pifwsZPYG+9CuLZW0kYJFVGmqMeLD8Q+f@nongnu.org
X-Gm-Message-State: AOJu0Yz2VcCGCST45M7a1JteAKIZX7wBwQ5PfXxhBHdmxNZJeyt+EPXd
 /UrL9qLI278KL4RjjJxFdlqDJOv3VHI7gX4vnPfTeseUUCOhvR4bjtU1q9iZCp7CT70=
X-Gm-Gg: ASbGncu2H3clMMXfnPFnv1qVNDnSnwy2FbK5u1nVOdl+Iopai86oFb8SmLkbPmegdzb
 Bj7S7qDy+sIxfofrmc2cu94qRvxML4Q1P9j1x5qV1qoxD13gCEqgQQhIgDEK6LvYdi4WPO+lxHi
 KHsmgyC+HDVzWLkFHEwTS6PucOjta6pi69ZBmC3223LMTsWhzCb8H1fVJdOkwZQl01V57Jc8uNJ
 fP7OIa4V/uYwXQK0GUIhafLaCetHdKx1Ads4KjSKBNj1kQm9r/yeBsVPYX8iVIMXkqcUfReQcyc
 58U39X10wO5lOG1JuaO4UsR6fJOixIEUkTwSPDh0XcigxLP9dFI+6TF/UP9MlqES8iYLlePZ8WQ
 =
X-Google-Smtp-Source: AGHT+IHNb5KDHKI9OV/KIO3KX3U35hwkZBCHCEuTV/Q/3kbMknW3qZSmJ7dpN7iUqHdi9uJNEekcwg==
X-Received: by 2002:a17:903:191:b0:234:7837:91de with SMTP id
 d9443c01a7336-238024d14e2mr144944355ad.26.1750862844283; 
 Wed, 25 Jun 2025 07:47:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53ecb31sm2052725a91.43.2025.06.25.07.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:47:23 -0700 (PDT)
Message-ID: <390ac9be-8b90-4c6e-bd41-94937b3b49fc@linaro.org>
Date: Wed, 25 Jun 2025 07:47:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_eqv
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


