Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298ED42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuEk-0001Hh-2W; Tue, 12 Nov 2024 11:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuEi-0001Fi-QB; Tue, 12 Nov 2024 11:59:28 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuEh-0000xv-71; Tue, 12 Nov 2024 11:59:28 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720d01caa66so5640635b3a.2; 
 Tue, 12 Nov 2024 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430765; x=1732035565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=NOpclEzqac2nJTuz/sojOl17P4j7bNUwoWt1GENLg1o=;
 b=UkTvlVOSOVN9pjv/VVLpeakefveHVOBPYl6wWQaeMvej1fCCwIWMKXB0qq4hRLhLqT
 Ifrf4S4FBc8GBvbHVteMv6EiCK12fiiOW6Pq1NplJsrSmaMyasCg8V3TSBvgJpz0WrZy
 2c3Mr4oDtS8ZAYP+pyge77bCfiRunb2TcZiOEgVH9pRMJLfSLf2I2OqpxRMoJb8dxfNA
 b+KJ6MpDPTXEWnKiT3bd3U+rb5LSiIeLkT1YsdrvpComWdVzGD6GBxPQRxtTBsNN4Gb7
 labAmummAUodGxieibYzNnR7Wcypp4Xi/ZI8FkYVNvXfyXSAXyGNsdwUCi9HFQywMP9J
 GRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430765; x=1732035565;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOpclEzqac2nJTuz/sojOl17P4j7bNUwoWt1GENLg1o=;
 b=tQck0U/td5CuW6koQjTVUylpoT9YiyhsPTL2LZORCePOC00e7yCunDDCTJQ08wEb0u
 nFM3e3RScKtWkjio9KLkvORhF5Il/E7WTlI3RdD1VyW/twQNkC6mkTJu4FGYYLKIZflk
 SSBoBhl3ifk++Wx3QFGpjxLsKfFiNa26rILF6ETlwqA5VnvZ+JttZHA4zKBVj8xe20Gl
 yKSI8xMBhWD3aDRewmd7wbNUmIXIOOi/aBwyHebyV+aHFXUbTNkqAibyoCj0cut+h9vL
 6je8lDLas4wS1NqQhrm1eDCgcD7ueBkBD9yTKEvG5rurqK67pNOnKo6mRExOTgkWL1iJ
 TudA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDidSNvtNsTdlukWwrsAz7KDwJAhODskHIGzXvkOkZfI2eAuL5o20MHze/pFtjrBZZsNs0CAJebw==@nongnu.org
X-Gm-Message-State: AOJu0YxJ+IjbX+3AhYPEYXCfQC9S+uGADWGz11NR0EdIr4oA7r1Tk17S
 woGU2Y8xXKuajgTm4d5kVZm+ECuUqyXOUaroM4YgKPdYFRHmFNHOdbytbw==
X-Google-Smtp-Source: AGHT+IF8+gNuTQUECmG7FbNkvUt1jZyRCHL02D260iCGWGryeTmlrPVbPEVmXmnCq7g8QOSdBVNsfw==
X-Received: by 2002:a05:6a00:2e1e:b0:71e:52ec:638d with SMTP id
 d2e1a72fcca58-724132a0020mr22597185b3a.10.1731430764932; 
 Tue, 12 Nov 2024 08:59:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a2367dsm11468240b3a.169.2024.11.12.08.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 08:59:24 -0800 (PST)
Message-ID: <f89a684f-8639-4990-9bd1-3e1cff5bf29e@roeck-us.net>
Date: Tue, 12 Nov 2024 08:59:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] usb/uhci: Add UHCI sysbus support, and enable for
 AST machines
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
References: <20241112165618.217454-1-linux@roeck-us.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241112165618.217454-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Oops, sorry, the subject should have started with "[PATCH 00/10]"

Why do I always see that one second after sending :-(

Guenter

On 11/12/24 08:56, Guenter Roeck wrote:
> Some machines (like Aspeed ARM) only support a sysbus UHCI controller.
> The current UHCI implementation in qemu only supports PCI based UHCI
> controllers.
> 
> This patch series separates basic and PCI functionality from the hcd-uhci
> implementation and then adds uhci-sysbus support. This is then used
> to implement and enable sysbus based UHCI support for Aspeed machines.
> 
> The series is submitted as RFC since I am quite sure that I didn't get
> everything right. All code surrounding VMStates deserves special scrutiny,
> as well as the changes outside hw/usb/ and hw/arm/.
> 
> A side effect of this patch series is that Aspeed AST2400/2500 machines
> will now instantiate UHCI, even if the machine does not actually support
> it (it also always instantiates both EHCI ports, so that is not really
> different). This means that the default USB bus is now the UHCI bus,
> not the second EHCI bus. The bus number must therefore now be specified
> explicitly when attaching a device unless attaching it to the UHCI port
> is ok. I don't know if it is possible to avoid that and to ensure that
> the default USB port is still the second EHCI port.
> 
> The code was tested on x86 machines to ensure that the existing UHCI
> implementation still works. It was also tested on various Aspeed machines
> with enabled UHCI ports (ast2500-evb, ast2600-evb, and rainier-bmc).
> 
> Changes since RFC:
> - Rebased to v9.1.0-1673-g134b443512
> - Added Reviewed-by: tags
> - Fixed bug in interrupt initialization of vt82c686-uhci-pci.c
>    which if instantiated caused a machine crash
> - Instantiate UHCI controllers as companion devices on AST2600 machines
> 
> ----------------------------------------------------------------
> Guenter Roeck (10):
>        usb/uhci: checkpatch cleanup
>        usb/uhci: Introduce and use register defines
>        usb/uhci: Move PCI-related code into a separate file
>        usb/uhci: enlarge uhci memory space
>        usb/uhci: Add support for usb-uhci-sysbus
>        usb/uhci: Add aspeed specific read and write functions
>        aspeed: Add uhci support for ast2600
>        aspeed: Add uhci support for ast2400 and ast2500
>        usb-hub: Add support for v2.0 hubs
>        usb-hub: Fix handling port power control messages
> 
>   hw/arm/Kconfig                |   1 +
>   hw/arm/aspeed_ast2400.c       |  14 ++
>   hw/arm/aspeed_ast2600.c       |  20 +++
>   hw/isa/Kconfig                |   4 +-
>   hw/isa/vt82c686.c             |   4 +-
>   hw/usb/Kconfig                |  10 +-
>   hw/usb/dev-hub.c              |  85 ++++++++++-
>   hw/usb/hcd-uhci-pci.c         | 255 ++++++++++++++++++++++++++++++++
>   hw/usb/hcd-uhci-pci.h         |  63 ++++++++
>   hw/usb/hcd-uhci-sysbus.c      | 202 +++++++++++++++++++++++++
>   hw/usb/hcd-uhci-sysbus.h      |  34 +++++
>   hw/usb/hcd-uhci.c             | 337 +++++++++++++-----------------------------
>   hw/usb/hcd-uhci.h             |  30 ++--
>   hw/usb/meson.build            |   2 +
>   hw/usb/vt82c686-uhci-pci.c    |  18 +--
>   include/hw/arm/aspeed_soc.h   |   3 +
>   include/hw/southbridge/piix.h |   4 +-
>   include/hw/usb/uhci-regs.h    |  11 ++
>   18 files changed, 822 insertions(+), 275 deletions(-)
>   create mode 100644 hw/usb/hcd-uhci-pci.c
>   create mode 100644 hw/usb/hcd-uhci-pci.h
>   create mode 100644 hw/usb/hcd-uhci-sysbus.c
>   create mode 100644 hw/usb/hcd-uhci-sysbus.h


