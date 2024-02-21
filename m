Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17805C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcos7-0004Bk-2z; Wed, 21 Feb 2024 10:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcorp-0003lY-SO
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:50:44 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcorn-0003Ae-Kz
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:50:41 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a30f7c9574eso863720466b.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708530636; x=1709135436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zsHcxReiCT3qx9ZuZIFORC2MKetXidUOVHo1k8P0RjA=;
 b=jnSwiJA0+7ltFhSklbc1ZL4TpZcOWcoq98qfZp3nTNUn3m6H6Vt/xb3/dunYRsB6aM
 fUlMuvYgs8rWXIglzmSDLKedGb+o5MejPYvi4it0r8g5U+czdOv1sR3KXM5HhTNo/5K0
 jlm+5TFLdel70BoXxkmxwnKxFw8Sk37xexSZ+ky9wuUMlvFzU5BrEFXJbWobnen7+jtH
 mBZQ14RjsxzghUeMl0dN08pDoZiM1bQPh4w1PIRoV0PHU3Pw2VwNz9mTQ/LLtZ3QMsqA
 RhwJLMaA27WjX+fHKdzafZ6Q7y+KNaTqqou0EnmsHEKUgi8D0nChq57rEPIBL5n6Zpir
 LzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530636; x=1709135436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsHcxReiCT3qx9ZuZIFORC2MKetXidUOVHo1k8P0RjA=;
 b=WLi4AsKQnM7qXItpFYWsrujr1pjjBIItD5RRRbmLv3m7TZ2YniuiKTdRkG2HmVv84n
 f8dESXnUOjvcP2VPK9tGByKMncwBfIPmj/dQVnz2gX6pxLroBw3MRHgqhezueeiP6nk0
 uPw1BX8KpDFPnlOtyBAN9EMDjsIx/ftIqezpCv3xc8rSpErdcczUpBQ1yM8dCVTFzWQN
 Ip2qVnNmyNLYsX543uQ0RV9TFdgDe5ftmTW7h3awgvd7BplUF3ndpHS2l3oqy2fi/c5s
 S2QngESBNtv9gUgCXTKgfPiN1lKmZjkuTzahctza6atP9QOMIqzV3OHTkIC/Ue15gxTe
 89LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNdmi/vamQ7DFVAMGLnvBjih4cH3Yg4Qx9gMTapcXaERx6S0NdNW73+7qsrCdz7cwo6XiMJKPvsjAg+joanJG/0x08XR0=
X-Gm-Message-State: AOJu0YyDHAfHNOZNcNszmXpjXal736pBSo13m31wApjdfzeSi4z1vAcA
 9AfVYXmV6V/43+1XkasVkvf+XwSZjr7gizprORpiCXGOpLWah5p6iDsWZcLy/TU=
X-Google-Smtp-Source: AGHT+IEuqLmeS136VDT5+Bz8pMcXzUika1dgpKBXOeeqb3snt2m/366BnlbECX1d+IUrBS5qzQYEWA==
X-Received: by 2002:a17:906:f2d9:b0:a3e:a0cd:5c4b with SMTP id
 gz25-20020a170906f2d900b00a3ea0cd5c4bmr5803399ejb.55.1708530635942; 
 Wed, 21 Feb 2024 07:50:35 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 ae2-20020a17090725c200b00a3e643e61e1sm3793695ejc.214.2024.02.21.07.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:50:35 -0800 (PST)
Message-ID: <002d9fca-56dd-4265-a79e-2850fbb1a822@linaro.org>
Date: Wed, 21 Feb 2024 16:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/i386/pc_{piix, q35}: Eliminate local
 pci_bus/pci_host variables
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-10-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> There is no advantage in having these local variables which 1/ needlessly have
> different identifiers in both machines and 2/ which are redundant to pcms->bus
> which is almost as short.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_piix.c | 14 ++++++--------
>   hw/i386/pc_q35.c  | 16 +++++++---------
>   2 files changed, 13 insertions(+), 17 deletions(-)

IMO it is a design mistake to have these fields in PCMachineState:

  27 typedef struct PCMachineState {

  36     /* Pointers to devices and objects: */
  37     PCIBus *bus;
  38     I2CBus *smbus;
  39     PFlashCFI01 *flash[2];
  40     ISADevice *pcspk;
  41     DeviceState *iommu;
  42     BusState *idebus[MAX_IDE_BUS];

Anyhow, back to your patch, please rename 'bus' -> 'pcibus'. Maybe
in a preliminary patch?

