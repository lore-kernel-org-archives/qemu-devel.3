Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A486C71157
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 00:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS301-0001Rg-6W; Wed, 18 Jun 2025 20:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uS2zw-0001Qk-8W
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 20:19:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uS2zu-00077V-DK
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 20:19:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235e1d710d8so3610045ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750292356; x=1750897156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ioIL4mlGLuVtD9rvtFpJNNDDnS0C6VPMIJP/hs2SPY=;
 b=zsehog5QwW8yIB8tOp9KZn6obPAirKne149iqvUvKpkLteiJj6WVhbfltcXU7gMzEn
 h8H/R9y2Og78L/5uE5/tFICljSqptJps8V4oQGlCOotZDeRHmnZx1ecWwMnkop7k5EB0
 ZY0wq5sR9+O0HZTbe3W84UWCVM0WhFoymCZF6PEU3tn5mV4p9M9F2OeAjwezVXoPLSHc
 +dc4Ki1nX0VD6Ch/EpYlaaAi5vmbQHheRgdbwvCEprRHMouq2xo7DnKvw+7Lgzo8DJRt
 7Kwcjw7OZMhgV8K1YxjxMXNMY8PWATgBsmOZJILIaD3vd6HVjYf40L1LbH5ictBkqQzZ
 KCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750292356; x=1750897156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ioIL4mlGLuVtD9rvtFpJNNDDnS0C6VPMIJP/hs2SPY=;
 b=L1ZHHg5+cm45mhRA6zUMSPVMhWNUAIpYhROY05nJ0TZimWVcn1K+k+AH/gRawjZlTU
 0m2iHpCkObyIRw8rN4Nv5cTqsIFbvf3vTKXduuMoGnr0XHGrPsQgUKjPkCVS2pWwYanE
 AxBrkefoHyA9lGU9svHdZzBuoU1qoySB5HLjOaXwKLcm4zAToDuZkrF8Q9EilhlHKVSg
 qTwULlKjVfraYDYyHsHILLVAgx71NvVmA379M7rKPb38C+VWb7fZMxnmVHL4oPRvuCgP
 V5Yl2S+mrKt5ptwDfiZP5pDGRrAYnvbPkmIiJc00ourr9+oqrstZAast/64qbOn0JYBk
 WijQ==
X-Gm-Message-State: AOJu0Yy2sTmatj9mWJkJurXRVlqkO9bTgAC8nGEfm152sZavEerHwSxt
 OxmIIQPUIlnsUvnZCwS6oUoJKzzW4I91RVzjlP11ddscgGHtAvLZ2xhHMZz3g4DO3Bs=
X-Gm-Gg: ASbGnctXTYsX10wNfytt2kX6Kassr5c4t+jBfb5muKWZ2ZGYmtncjXQDUY0dSCSZXhq
 kFZozQYgosC45h19/wCmS/F2jRFLhyj1qJby4gETACVKqc562FH208pSOYZL7C5wxfrJFUnp5Mc
 KalVlUOsQ1rKmGZTZwM7+XBW42enkCML2WuhA6QgRDkh4n6gyEZNE0tGluTSEuaZ+xe13UHsXzT
 FUI1pyeYSz1HGalARFq5PLnWoNHU+oTROTXlCOMrK1CNU8AxRKxxyOucQHSvvBavVgLLS6e2IzG
 bbKAUTlgAOvTGtRBg/BG/jN1lyvHemEU4KeiEHPWY2xr8Pxw0rKAB8UPz+JQjV4KfYxl6jJLj0c
 =
X-Google-Smtp-Source: AGHT+IGteDflxneLF8SteCKvOFUfiJFbcg6yb3QvCEPbE7lQZ1+WpAH1xzvMjopdHb/hso/zsRsHBw==
X-Received: by 2002:a17:902:c94e:b0:234:8a16:d62b with SMTP id
 d9443c01a7336-2366b34ed67mr326418275ad.12.1750292356076; 
 Wed, 18 Jun 2025 17:19:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365dea7d98sm107649265ad.151.2025.06.18.17.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 17:19:15 -0700 (PDT)
Message-ID: <630d1dd3-410c-4693-89b5-554a171557ba@linaro.org>
Date: Wed, 18 Jun 2025 17:19:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The current implementation status of ARM Secure SMMU in QEMU
To: GanDalf LeBron <lebrongandalf@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Mostafa Saleh <smostafa@google.com>
References: <CA+V5jYUjqDc-UWKvQrX24c+MKtm+zdx4YCWU036180A4rX4ybQ@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CA+V5jYUjqDc-UWKvQrX24c+MKtm+zdx4YCWU036180A4rX4ybQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Gandalf,

On 5/7/25 8:39 AM, GanDalf LeBron wrote:
> 
> Hi there!
> 
> I am writing to inquire about the current implementation status of 
> Secure SMMU features in QEMU.
> 
> I understand that non-secure SMMU emulation for general peripheral DMA 
> (IOVA to PA translation and protection managed by the Normal World) is 
> well-established in QEMU. However, my current understanding is that 
> specific *Secure SMMU* functionality—where the SMMU's configuration and 
> page tables are managed by Secure World software (e.g., at *Secure EL2)* 
> to protect DMA for secure peripherals or confidential VMs—may not yet be 
> fully implemented.
> 
> Could you please confirm or clarify this? Specifically, I'm interested 
> in whether QEMU supports management of SMMU page tables and 
> configurations by software running in Secure EL2?
> 
> Any pointers to existing support, relevant discussions, patches, or 
> roadmap information regarding Secure SMMU capabilities would be greatly 
> appreciated.
> 
> Thank you for your time and efforts.
> 
> LeBronGanDalf
> 

I guess you are referring to SMMUv3.2-SecEL2. It is indeed not yet 
implemented, as only SMMU v3.1 is supported at this moment.

At Linaro, we are working on device assignment emulation (for Arm CCA), 
and this feature will be needed, but there is no specific roadmap at the 
moment.
 From the discussion I had with Mostafa, who worked on smmu emulation, 
this will not be trivial, as we need to duplicate the state of SMMU, 
which is not covered by existing design.

If this is an option, I was informed that the device assignment for 
confidential VM is working fine under FVP model, but I didn't try it myself.

Regards,
Pierrick

