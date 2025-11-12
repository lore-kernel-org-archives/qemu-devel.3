Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51387CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ9JO-00038t-Vt; Wed, 12 Nov 2025 06:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ9Fv-0001g9-1j
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:43:23 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ9Ft-0006KD-9z
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:43:18 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429c8632fcbso502669f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762947794; x=1763552594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWt08JfmC5I/RW9AlFNFSUsZ57Ypm4q+BxEH35MpBec=;
 b=HlZwrFcY5/HqqjUQxPC6UzBkE1JoebY+6+Lin2i6yQr1CEa8n97xFzbAJFzQ7eHI0k
 XdW6r5DjGlfnlQIZSs7Ht2dpiHvZ3aUyKT8/yXpXxlyhyhYjWtkgFAJ65rJ90Vcul1C2
 KvXs/ilTSklYWBo3z8xqgvZMX9AKVnGRmn153BsKbrFoXvYQIBE4SOy0pmO+oaencXG3
 tB/wtmRgXx55HGDrX4wjQN1k7Q1z8BlWFCuijYQwXZNvKAfFgSsUa8VlpG/R4ulvBY4s
 zDWfKW2abKhFSkloSjwf5NlBLGiaxQEnpleGXRqF5UjrkLVQoRAIwTCWUMxoHmM2D4Ag
 ueRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762947794; x=1763552594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWt08JfmC5I/RW9AlFNFSUsZ57Ypm4q+BxEH35MpBec=;
 b=bV/qPBKqmDKXsI437CesTiP4CWq1LnLU8W/pQdGAM6nbvx/6pbX5p/2Yv7kquUKsiq
 PEf5A2mCdkyI5tNhK0UAnsI+I0RxvHbS4ZNofCahBPlNqOstaUJZjTzzb4laFfb/fFTh
 Fg+Cc0VpSS/bxV9X6cLEaZrVRJHwdxoAGPqVejJDteolXOFXJh9XA4oyWNq/xbpWJral
 Avdt0F+W8p1R9DK55sKFnYcMqfXwej/wR39/eYZiiEIEss6aFOalVKcTCgFXIUd6YP4Z
 3vRgBbwQnUeW5/dnwqu7qPvkzGaa6TmLykCSJ4WBa4xZ0yLsDW4wM2DfoaKPbT2E8jra
 mkDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfaUqYooE5hlFbFx3D4iwo/u4EW+Oh2DeoNCXT9rE3FybCbli1bKW2WRtTNtKm7UpiF6+T1IwFu/8w@nongnu.org
X-Gm-Message-State: AOJu0YwBsoALemMl57TpK3En4d3Zj/lQQY3btpW0RaBeRCdbOcWO02Pc
 Sj6+oba+Wm2x5bOM3QvckFVwBKnl55/6C05wTlhR+fvJ00svOBdf/cHk9xsDdFZv4p0=
X-Gm-Gg: ASbGncv3X5B0xnEKD+CsEDtApN3JUtZuJGeA6cfdELRt4s5OHtPqjDmPeFb0vU6KDI7
 iBYTS5yJG8SDr4iXa92wu4gUkMRk0+YvoQ4PBPU7DW+9Cuw7ANLar5VAO88mu2R2J6hfCuVUTfh
 ESuHbu5w8no6cd+oJaQBheL/a+J/pb3fJJzu91rZr2boyuaht78P/lJh4UOfl0vRhKVoKkaSgRD
 jUq0UV2srHvmsyzpDRGq2HDchBCJTPA2r5kcv8PwxntLTx8eOxD4bLCmewKDF1xUvJpgsfOIslt
 StEWSuI8Ax+ZNK7NXYRgMoh9tpQUOPmYrLywHVsvIgYljHz24fb2KKL59vDMyo+AunqgFu1OMF+
 rFYBw6zz/2vCl54f4xGX4xy1AT94c7DfyEW2KFDLTVozqjw6VNursYzZKYU3Fu6ERbje6JB08+r
 UsIvva7Q3yoay2iP2k2R2nccA43S8wFMSv0LK6O7xge8M=
X-Google-Smtp-Source: AGHT+IHZtKBQ+vYyvg8Fd2aXKpmHtHipyc8Ym8h2Du7RgBbIHEGZoQmAG0GW3SHtZOlSAOoTnUhlDg==
X-Received: by 2002:a05:6000:1849:b0:42b:3806:2ba0 with SMTP id
 ffacd0b85a97d-42b4bb89b8amr2103888f8f.2.1762947794430; 
 Wed, 12 Nov 2025 03:43:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b314dae4bsm23976837f8f.34.2025.11.12.03.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 03:43:13 -0800 (PST)
Message-ID: <b189d246-74b2-4382-b0b9-8121caf713a5@linaro.org>
Date: Wed, 12 Nov 2025 12:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] hw/arm: Add new machine based on xilinx-zynq-a9
 for Beckhoff CX7200
Content-Language: en-US
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
 <20251111102836.212535-14-corvin.koehne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111102836.212535-14-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Yannick, Corvin,

On 11/11/25 11:28, Corvin Köhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> This commit introduces a new machine, derived from xilinx-zynq-a9.
> While retaining the foundational architecture, unnecessary peripherals
> have been removed and the remaining peripherals have been adapted to
> match the CX7200's hardware layout and behavior.
> 
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>   hw/arm/Kconfig           |  18 ++
>   hw/arm/beckhoff_CX7200.c | 443 +++++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build       |   1 +
>   3 files changed, 462 insertions(+)
>   create mode 100644 hw/arm/beckhoff_CX7200.c


> +static void beckhoff_cx7200_init(MachineState *machine)
> +{
> +    CX7200MachineState *cx7200_machine = CX7200_MACHINE(machine);

[...]

> +    n = beckhoff_cx7200_init_spi_flashes(0xE0006000, pic[58 - IRQ_OFFSET],
> +                                         false, 0);
> +    n = beckhoff_cx7200_init_spi_flashes(0xE0007000, pic[81 - IRQ_OFFSET],
> +                                         false, n);
> +    n = beckhoff_cx7200_init_spi_flashes(0xE000D000, pic[51 - IRQ_OFFSET],
> +                                         true, n);

[...]

> +    beckhoff_cx7200_binfo.ram_size = machine->ram_size;
> +    beckhoff_cx7200_binfo.board_id = 0xd32;
> +    beckhoff_cx7200_binfo.loader_start = 0;
> +    beckhoff_cx7200_binfo.board_setup_addr = BOARD_SETUP_ADDR;
> +    beckhoff_cx7200_binfo.write_board_setup = beckhoff_cx7200_write_board_setup;
> +
> +    arm_load_kernel(cx7200_machine->cpu[0], machine, &beckhoff_cx7200_binfo);
> +}
> +
> +static void beckhoff_cx7200_machine_class_init(ObjectClass *oc, void *data)
> +{

> +    mc->desc = "Beckhoff IPC based on the Xilinx Zynq Platform Baseboard";


> +    prop = object_class_property_add_str(oc, "boot-mode", NULL,
> +                                         beckhoff_cx7200_set_boot_mode);
> +    object_class_property_set_description(oc, "boot-mode",
> +                                          "Supported boot modes:"
> +                                          " jtag qspi sd nor");
> +    object_property_set_default_str(prop, "qspi");
> +}
> +
> +static const TypeInfo beckhoff_cx7200_machine_type = {
> +    .name = TYPE_CX7200_MACHINE,

A lot of code is duplicated from hw/arm/xilinx_zynq.c; this does not
sounds right. Can't you have your machine inherit from TYPE_ZYNQ_MACHINE
and expand it in a .instance_init() handler?

If this isn't possible, then we need to refactor hw/arm/xilinx_zynq.c:
- extract TYPE_ZYNQ_SOC from TYPE_ZYNQ_MACHINE
- have TYPE_CX7200_MACHINE use TYPE_ZYNQ_SOC

> +    .parent = TYPE_MACHINE,
> +    .class_init = beckhoff_cx7200_machine_class_init,
> +    .instance_size = sizeof(CX7200MachineState),
> +};
Regards,

Phil.

