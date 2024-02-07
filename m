Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAB5C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdpc-0002u0-CZ; Wed, 07 Feb 2024 04:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdpV-0002tK-10
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:02:53 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdpR-0005yx-DH
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:02:50 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a388c5542e9so19638966b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707296568; x=1707901368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fHwGSjHVXVHNUiahUB2RJJ0LQ7CGSwuntWOhWSUPVbM=;
 b=WDbg4sLTFXMcZddxbgPfuqN5sMplGBTGc33dykKNduBvx5GNOEBI+p7Z4ifiqMU+xP
 Cu3omVNgbnh0TS6v1qNa5+hZ2qBP2kIL7Bh8OWo01vlgDo6SsBu+MAsmRkNtHoUuCwTY
 473vHgQnRD46tCrlIVOI6iQ6H/yTPtQtsLci4PF4CsiSrKwg6f/O8LA728PsJMZegByu
 //zuIS2/TmiP8mbFVkfYu90O3kOuV8uMvTsEQzA1/a5/kjefbONnI+hDHXVOyl4evSW1
 eBsPxCnYcAlDWfR2SaHIzqcdNPN10NhBbivhCCGqjIEfN22e+242mjPpABtWFTMhBA/j
 FNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707296568; x=1707901368;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHwGSjHVXVHNUiahUB2RJJ0LQ7CGSwuntWOhWSUPVbM=;
 b=Ofl9U0zBCQuhpLtyPkw5LeoXC++rAv0r3Cm6WbKbgRPaI4pbLRCdbuZ7Sk7Xn5e/Lh
 7Fx14mLZ17y2PNidPUr2WTM3LIzpc7aBcgRkuPj/WQeL4z7ECzbpW7Xm8ePR+/pC7dB2
 2Sqv4XFjfZSqcXFCsJ6bXGz4rAfgeIgzIClK2CAk7Eg2O0A2czMDfkvpmQllilWtyV2Y
 3HZBb9GJ9udcY1taK/I9gpGhJt/O2rFFXjNV2BhSlSSWiyWc3DnRqs+Ro/+rWnOXBm3d
 2hvPLeGHtOE3h1Pb2IPCN42zOZxk6+X+GRxnf/PDRh0FAKNJfZgGOXh6ndAzq226yKbY
 RzJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCgfV4E9+THxCFLpK3gpWEyaMOR3xapTFAn3Tqoc5TIjLobzSHtIA+X+CIr4aGed+eUSkXyMF1ZEhhRFCqt+Q7Jmy1wVU=
X-Gm-Message-State: AOJu0Yx86sbgOJMdVGwai47eGFHBbaApfe1U3W/qBzJakrULfFZPPZv5
 WusY/qBYuTYyW5caNn6Q0scjNwUb32gJ2g6FndoAGXO8+eqzIPG3as2sN5aGQZU=
X-Google-Smtp-Source: AGHT+IGr5LzKLIjki0UL3IQXkYk3LN2ZfE3dwFfbdfLVx0aziK1jXuKQxybymSwO+Vv1YUDuA9uiog==
X-Received: by 2002:a17:906:eb07:b0:a35:e5bf:b585 with SMTP id
 mb7-20020a170906eb0700b00a35e5bfb585mr5424550ejb.35.1707296567862; 
 Wed, 07 Feb 2024 01:02:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUI4Y1gynNcQwOPQ09t+oZ1RUDWJUh3tzfWrA5Efy6jOpoRS+2mqrHfMfuapl9Y2HiBxPdS5ib3OtIZ0+QBgVR53HxejwXR565bWeEDVnsEEL64wrZU27ckiqjs45fQxKF3BWX+/hDRJFJC6He4PxEYE2DU5BbrREj3bnaS//Y=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 vh10-20020a170907d38a00b00a3875804883sm459014ejc.124.2024.02.07.01.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 01:02:47 -0800 (PST)
Message-ID: <b8fbf313-1b24-4cf3-b5c1-f9289b413a75@linaro.org>
Date: Wed, 7 Feb 2024 10:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/arm/mps3r: Initial skeleton for mps3-an536 board
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-9-peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> The AN536 is another FPGA image for the MPS3 development board. Unlike
> the existing FPGA images we already model, this board uses a Cortex-R
> family CPU, and it does not use any equivalent to the M-profile
> "Subsystem for Embedded" SoC-equivalent that we model in hw/arm/armsse.c.
> It's therefore more convenient for us to model it as a completely
> separate C file.
> 
> This commit adds the basic skeleton of the board model, and the
> code to create all the RAM and ROM. We assume that we're probably
> going to want to add more images in future, so use the same
> base class/subclass setup that mps2-tz.c uses, even though at
> the moment there's only a single subclass.
> 
> Following commits will add the CPUs and the peripherals.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |   3 +-
>   configs/devices/arm-softmmu/default.mak |   1 +
>   hw/arm/mps3r.c                          | 239 ++++++++++++++++++++++++
>   hw/arm/Kconfig                          |   5 +
>   hw/arm/meson.build                      |   1 +
>   5 files changed, 248 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/mps3r.c


> +/*
> + * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
> + * emulation of that much guest RAM, so artificially make it smaller.
> + */
> +#if HOST_LONG_BITS == 32
> +#define MPS3_DDR_SIZE (1 * GiB)
> +#else
> +#define MPS3_DDR_SIZE (3 * GiB)
> +#endif

Generically, can we migrate a VM started on a 32-bit host to a 64-bit
one?

> +static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
> +{
> +    /*
> +     * Set mc->default_ram_size and default_ram_id from the
> +     * information in mmc->raminfo.
> +     */
> +    MachineClass *mc = MACHINE_CLASS(mmc);
> +    const RAMInfo *p;
> +
> +    for (p = mmc->raminfo; p->name; p++) {
> +        if (p->mrindex < 0) {
> +            /* Found the entry for "system memory" */
> +            mc->default_ram_size = p->size;
> +            mc->default_ram_id = p->name;

Nice.

> +            return;
> +        }
> +    }
> +    g_assert_not_reached();
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


