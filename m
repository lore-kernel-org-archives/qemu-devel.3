Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954F0D3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SSa-0004n4-C0; Tue, 05 Nov 2024 17:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SSO-0004DP-OI
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:55:32 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SSN-0006Ai-39
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:55:28 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso5054850f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730847325; x=1731452125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfoyir+mNAEXf0MJKCr64L0tHPI8qAfQVkVEimKnDg0=;
 b=GUMhX7sppCFfS8yZmKVq+TxOJ/cTdFBt5DtzMqihLwNe0i1kgx2wkkrv+F34+eAM41
 yQYQDYHHKUTM3bnL/c6jZiYEQN4rACJGArd2G/mhFGzsw0PwwlnZJjQ/HcRI6qXmQ70K
 f3qp/62sSCWZbBWO2Xs8MJqX3Lv44AbrETLC9w4uBta3vEVrJdlFblGBThSz0mEYLkUY
 3QQU82UTP39f/Z6kA03QaAwLcwc55ao7Bb7DlZ/jqFaC+dhy12CDJixzmUta3SCDEr+k
 upJ/hjHX39RvBNvwG1msdcwM5/eK8WZOEiZ0zwgR17TgOC3w2qJyq/wSMV9IIzHaRcXT
 wzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847325; x=1731452125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfoyir+mNAEXf0MJKCr64L0tHPI8qAfQVkVEimKnDg0=;
 b=jVtk83bX5m2fo/1l/HOtEawKTZY5qh6sEmZb9NDQjKZc3wM15R3ZrMQbfdIAE2vbRK
 YqCXAq0fYCWi4rGkQFLTOD1t3BUtpxftXMnxPYqhctioSZjTX3JTXdK+qB9rJZM39lyp
 jKOUkr1RZ8qCPWiritYL7ZaBrFJcZioE+U77IWZKhh7kAZFK+OkxzTeflKE+vBjGBCIL
 l0f1QOgrzEOga1cuyH+wg++CR1QghUU9qDH/WeFePqhmjPsTcap5P7H8/7wUcdcZAt+/
 HNwG4Wfv3TxGbkO1qyjO4nhIcg5QgLwoUQ4gL4C+lPWEm0jXtZxiS7EMQS7RCB+1E0CD
 XJlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpGUspmYs+fa3CKRMJiDKhTxaJISoy5ZMwjtjwj/REInhgk/PzHavvJZX8+/UPz//hTeTiStRnA2tq@nongnu.org
X-Gm-Message-State: AOJu0Yz1ZIonONHQK2eDQ/vcjYMBYtVg6CNh/VJJLkLeNsrfj2cR+uim
 tl4WPL0YAXpJvAHiz9CrcUvNBowU0oaIRVOMk55Zjppo5Lz2Xd2fUETHE6JC+Qc=
X-Google-Smtp-Source: AGHT+IF30Avi0YXv5dsyrLwu0HFkyhQakQVUQHVdS2d4bGipuoNeohtI+EdnJLqjuOCQ9S10dSsaIg==
X-Received: by 2002:a5d:64cb:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-381c7a5ce0bmr16175511f8f.18.1730847323912; 
 Tue, 05 Nov 2024 14:55:23 -0800 (PST)
Received: from [172.20.143.32] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d2bsm17362898f8f.16.2024.11.05.14.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 14:55:22 -0800 (PST)
Message-ID: <b28ffff6-7b7f-47cb-b39c-8b132e353a2b@linaro.org>
Date: Tue, 5 Nov 2024 22:55:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/26] E500 Cleanup
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Bernhard,

On 3/11/24 14:33, Bernhard Beschow wrote:
> This series is part of a bigger series exploring data-driven machine creation
> using device tree blobs on top of the e500 machines [1]. It contains patches to
> make this exploration easier which are also expected to provide value in
> themselves.
> 
> The cleanup starts with the e500 machine class itself, then proceeds with
> machine-specific device models and concludes with more or less loosely related
> devices. Device cleanup mostly consists of using the DEFINE_TYPES() macro.
> 
> Patches still missing R-b tags: 1,2,6,8,9,15,23,26

I queued most of the reviewed patches.

> Bernhard Beschow (26):
>    hw/ppc/e500: Do not leak struct boot_info
>    hw/ppc/e500: Remove firstenv variable
>    hw/ppc/e500: Prefer QOM cast
>    hw/ppc/e500: Remove unused "irqs" parameter
>    hw/ppc/e500: Add missing device tree properties to i2c controller node
>    hw/ppc/e500: Reuse TYPE_GPIO_PWR
>    hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>      resources
>    hw/ppc/e500: Extract ppce500_ccsr.c
>    hw/ppc/ppce500_ccsr: Trace access to CCSR region
>    hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
>    hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access
>    hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
>    hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
>    hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
>    hw/net/fsl_etsec/miim: Reuse MII constants
>    hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
>    hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
>    hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
>    hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM Kconfig switch
>    hw/sd/sdhci: Prefer DEFINE_TYPES() macro
>    hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
>    hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
>    hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
>    hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
>    hw/vfio/platform: Let vfio_start_eventfd_injection() take
>      VFIOPlatformDevice pointer
>    MAINTAINERS: Add hw/gpio/gpio_pwr.c


