Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5145C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM73-0001Rw-Tw; Thu, 19 Jun 2025 16:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM72-0001Rn-TB
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:43:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM71-0005ip-5c
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:43:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso843072f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365833; x=1750970633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aPawJDIcOsAw9OmMBzvU5j2uG8xgvuFN4z0OZ6WESOo=;
 b=X+3OVxNtLFO9Ts9TKMh+FXShf4J6ViTUuqXABZTSoq25lbteZIC01Oif9mr7+BnSxN
 IEZ37kSucej6v4Itr4PB+4KsIrd6R20SEUb1L2iHodaGeWrrUKHI/sj+jW850RDUx3YV
 M5Pdm5wzq8Ico9+c0JaZatahy1eqXfvoPlbKA4AnR0QyLpeiH3K8CvjAr7HeqgoJvKW+
 JSFt847D5daQFN5GcIBRpu0h/Nh0yQsCKJDs1iAq9zLTv9cY3zyhY9NsY5RN9qxDu9YC
 Lzzb057VjAjWNo6CRe5aAUvOQ9tP5fzxP4PGLoJ8BIrFgSOQgHMhYUlcMCC7mYeLj3Al
 gDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365833; x=1750970633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aPawJDIcOsAw9OmMBzvU5j2uG8xgvuFN4z0OZ6WESOo=;
 b=HrqmO2+h/NAu1hSzzhMX77Vd/XG1zJEMiFS9+cKOQUiFnW9ZHvJ85oVj4D7PisxPND
 geuaxCb0kuM9GtvsGkoF8z76puJKfF+6UKpsNNU032D6DBzD9WDW6mrhHAseJw2ywxhS
 c4VGVd3PSfeRuplz/PktLvVFIlSf+Pc7Bo6XylTB2tbWsSANb69jYVKXqbfIAPwDC/T/
 nN3dMZ3ycVz7W70RYfMxkgMFy4fBt1cy0jQN0WNV7JzUKO6PE62sJHCeUKw8Sk4QhQkc
 7APZulWgdL/0LvC9/pHPeMdjnebSEBry6H3oHE24PopndP/LQ3JvBX65dQW+nBL8LFQL
 YTcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW62owFwQWeilPfjc/qDyT8YolK2pgcc0j1SEXvW0r+QrcdLbfW+XApcvdMh3jo8IBebG/fJUSC6uEt@nongnu.org
X-Gm-Message-State: AOJu0YzxcCy//GyxtMXOhFYXSztlPIZXJFh2s1sRLC+x5h/FUnDoQvKg
 FpY6iyrNQzhQov38NhzaTH/yHkt+LFZfEe2OBcQCKCqy+3Ym+UyO0DRED4xG8aiyU8w=
X-Gm-Gg: ASbGnctwp97yAKy9TgrxAdcSabNmvGDcKu8I8B3IlgunoVzWPypCp4UGW+piXoCrpMJ
 uv80TRh1wWPpEmgGvKwlFf8UDq6BHI9O8D15leo6hiu23UxyYSa/WvxYUOyNj3WY1ISyVoTPIQ+
 cKpno35Qio8ZNi06qhb+aZb9lAVXuZSFg6wm6tLEc4vsyqhMAFnfmwbksj5wx1E1Ea1A61LxFms
 Q+TXRNZSdELsNz0CPL50RArm0U2ac1x0GcpNsJ9+VGXQECWoB0SOPY1VoAEp521+1iNhHikJCCP
 Tsf0bPReh2CSBPJJTG58wIyEoJCK7bCfilNI3K494H/xdLhST3L46zZJDgQ8sbwUwejMqAn9VrQ
 =
X-Google-Smtp-Source: AGHT+IG5NOq3zUA6IbK+HKtyXXVf4sr9XYnQ8rMXanaww0dvXp30YgVrmEUXG6f3alSDQHeOKknuGA==
X-Received: by 2002:a05:6000:2504:b0:3a5:39d5:d962 with SMTP id
 ffacd0b85a97d-3a6d13034a9mr273366f8f.41.1750365833582; 
 Thu, 19 Jun 2025 13:43:53 -0700 (PDT)
Received: from [192.168.69.167] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d11909f4sm277635f8f.88.2025.06.19.13.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:43:53 -0700 (PDT)
Message-ID: <d6ad1fad-25dc-4364-8bb6-e002b065cc8d@linaro.org>
Date: Thu, 19 Jun 2025 22:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] hw/i386/pc_piix.c: always initialise ISA IDE
 drives in pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-10-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> By definition an isapc machine must always use ISA IDE drives

ISA: yes, IDE: not necessarily. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> so ensure that they
> are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
> define since it will be enabled via the ISAPC Kconfig.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)


