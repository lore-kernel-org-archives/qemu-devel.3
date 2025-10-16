Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E120ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RVc-0001ZS-ON; Thu, 16 Oct 2025 13:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RVV-0001NH-1y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:11:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RVO-0003fE-1e
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:11:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso646349b3a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634666; x=1761239466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K39YbJ8V0SFQMeOuwPXO7YyEdomsHJKYwlcAPQMmelY=;
 b=jXB9l/MWmX8uYImigLmuNnpuSFW8jJx3sX7NDctsHj5cw6nSO3w1o0X5Kuoy87ddem
 eK3illCIR40kxcGu9pksh4uCKyp2iCSgW+0uNJv/ujRV602a2v3Mtwi8bLtHhh5gKKao
 yK+P3iynZ0XOmQEHf7f01f8Fwv/ZH/ItCXwW5j0ws9IqRRxAFoF6/gBM8G+jU4Fevvd3
 h6MeF6UODhsN+4sQJuOOhpdauJE7hOJXxnFIbdycH6vMIBbTph8ketb5xr1JdFdBrgeU
 CYuiFqxNkF+SkKk2X523zD/kZpHmTIJy+WsG+tR4eYapcAKT8MyJoIjbeGxg5W4yfpNJ
 zFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634666; x=1761239466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K39YbJ8V0SFQMeOuwPXO7YyEdomsHJKYwlcAPQMmelY=;
 b=bF6K5ZvKxFAnEZSJsyH97a4p6M4Wcw+7iD+u4rSJbMwtGxl4qayDzahUu6kg3w8fEW
 orlDiWgFyqnbhM7bbEIZOZSdbSS0ZCpJ6GE7pGjw0WGsOEn5TFpRykxxlBzTZri7TnNk
 XJilxwq2sD6JcGrFiV6HX+pchWSUMpoctjreAhaZuce9MMAK1Nqad5Rbaukwls37nKnz
 feP5zw0XkDYCnxDrFw83lWJUnGqA30pXiN9R9Yg9qgH2rFcDm/t3RgaBbuMS3ZryTU8w
 p+XIoKl4VTmBov2KE0+47YrNMPIJWxBCmMMyQWFQYB54mY4PPAdwBkqhA+xM3+8zdI5E
 H2Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0EqyRW/HnHXQhJacdULqKl++ZYuaImXWcDuu+zadQuL8i/SDSfOT3BGV9EA31qOgCswnQQj5lmvJQ@nongnu.org
X-Gm-Message-State: AOJu0Yw96ELKCAyZikJcDbanDYQ596K1hMPC9vKkJRZA5EMnvkyw9K2N
 zys5EJWZNjrQ995E5iKm3RXQTK/hT0dFtFrdY6kGfiNPxCGihGch626jRHk3wXtAy5M=
X-Gm-Gg: ASbGncvP4CSyp98hwlaae7clOkC8YYF98cYoSJIL9DUd7okRrkOdpdgaRsth1Im5OJ8
 AsPwfwVuFfncuLZz33Z6oweU98AvTA4zU9hRNlHaguzVubLbKKpeYcyt1+d3XPrEcYi15dyqEQN
 ecyxRl2PiIkF34PeoP4os/2PPvm9riVtvk4+t2Fa181aUK6z8Lg0TrniSSm9oBXbkMsYzzoufLM
 TuWMuih/9f4nzovYZmUPGh1fC+677s+LP0C4tjvDvjaHjnD+HIWwk41uxDDljhYOZ5xik7C/lc+
 XY04LqgMEIMwcIuMuLJ7NVBHcBH4mDOnftorEsWz5N0xzueo0Dv3AUU0uqfNnDZPdiCje9cJJKv
 1/9P5KZXeYcTeAJ/qhmqiKopfQa79zGhe+APkDMI6xzIJe5NkMrrozYWqOiUYkyEAPM7qJe4cz2
 WlziCnQ54eOixG
X-Google-Smtp-Source: AGHT+IEVtlrZhg/XjQQtIqOB96+jdcBFExfh4wze5+8/y99XoPAXoumLttosjY3oO+kv5n+KGFMDlw==
X-Received: by 2002:a05:6a21:3399:b0:32d:b946:dc55 with SMTP id
 adf61e73a8af0-334a85398b9mr843561637.22.1760634666520; 
 Thu, 16 Oct 2025 10:11:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-79cf0a052b8sm14518427b3a.67.2025.10.16.10.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:11:06 -0700 (PDT)
Message-ID: <1de38eaa-28f8-4b56-9673-624f6c9b8b10@linaro.org>
Date: Thu, 16 Oct 2025 10:11:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/24] docs: arm: update virt machine model description
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-17-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-17-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> Update the documentation to match current QEMU.
> 
> Remove the mention of pre-2.7 machine models as those aren't provided
> anymore.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   docs/system/arm/virt.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


