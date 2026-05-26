Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE50CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnEr-0007eO-9t; Tue, 26 May 2026 04:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnEo-0007eG-3h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:34:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnEl-0006Q0-TQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:34:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ed18d8a1bso680765f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779784446; x=1780389246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIbZQULdQpi60GblvsROKJz0POqC21/fZjac+UlEaLs=;
 b=T5GdH86wkBo6C8rAIqJZI0++iztGvYmSGIO4Ret44h7ccSB8RBfrE5Vv8VMrXqCMCM
 RlVSN8hWAfw7SpzzX13sxRZdCGdPIbz+fA5CMxaxtHe8U1qyULPuwHSxKdw8KG1Bu7dH
 Q4xr+UwqtdZ7HhFcCla8TThqI/vE5gi4ri4wfk3rGzTGXN4xz12UCHTq4bDfJB7uI9Fs
 C34XlQQzNfP4MBTyiOr6X+24lp+eMKhvuETa6uourvek5X6vlU3DKozvjDOxfVTNxYSQ
 LJFqoYjwiOhqnt+3uY9xnazzr2j/1T7Lj4wOFAyIYVLNQ2Tr0YfiSm7PFhpQKlmLxGKB
 dwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779784446; x=1780389246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIbZQULdQpi60GblvsROKJz0POqC21/fZjac+UlEaLs=;
 b=Jb0rK3A7+RFb8eG3TAhVV/Z3ua2IRcfK8bvO7HSlAZAir8MVHKe5VW+hOKFqdQxoKp
 vDD5FpK5p5I8Z56yrlcXdWkgJ8sLXlULiMHfi/BUek8/FuWq12rENSX6LzDSLbQFLFLg
 ERpQa4LL7TzHXzYDT0uwutgxP+DqKi8WQuBMr3K9t24O+llrr0zW47vqDoq9BbwMp7P2
 UrJEEgAsGilkVR6yFfUo5xyBNc+YKAeL+v6d+lFXdk8zUiOHQO1Qo6c+xdrHf5xYhFTG
 gtvGnxeXBvn3pFzAwHfQnhq2+HCKozFq/KbCZgyYIYCIPco0Lo+0wJI9HCrtYOANvm6r
 JibQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YDx5WSTAsGGm0VXw32M5PQCMSOtDWt6hvKRVmmLmtQ1Cwf6NqTEbtoqXZ3OQMLv0Zv6JbvFt7Wzb9@nongnu.org
X-Gm-Message-State: AOJu0YweKPuGFRYE+4Q0Wy5+LegOeQrKhMA7CMgKHnPGRgWES4gwybMo
 guNqhOfiBjqss0FbgXBfQPmJK5vjiCqQihoWvwmH0xdbsl3unPj/oT/32qzIJz6Qm18=
X-Gm-Gg: Acq92OEs18rVCUhQGc2jmBCJw88yAUG4wJtVboYlvuj0FkdiBc7/mlv1J+0B6bsi7cV
 J9Ctps8S6hheeDvQmS7XPg0TmNPWJ99tJ51bkrdzUjaSWqdm58gppFhhExlK6X4Cpu6wSqYcTvQ
 JRuW8iUBZcaQOKGdvSxwohircYs7ZJaozy/4zADGOOegV9sOBFrnlwR7NrZkZRMiFX7s7J1HGFH
 l3Y0Fs2bKHZ0vh704QpluSLNxkfcGQN8pR+LiDVxIxZg4hzGj58XRdn1/AEkyqhewy9eVKzFr8x
 90cASmDKfxKx767bf6DRx5msytrMgC5wGJ/QJAetcV4DXxIjNzpESYyuZnu1yTU2F5N8EvPUj61
 2YJSI1FsoxLTsT+rvXGBHS3BkjhjKo/JFOJ+xynSUIh0u4YmFxsmOZDoUln9QBJb9RO6faqk/5E
 7c2YH2X4Nq+U4U+SVFuUWDdzs++asafhJqQqW8j9/SOvDStLB3ssMTV+P3Up3FESbP7mE0HT0=
X-Received: by 2002:a05:6000:178c:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45eb38b86demr30772894f8f.31.1779784446179; 
 Tue, 26 May 2026 01:34:06 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9b980sm30812143f8f.3.2026.05.26.01.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 01:34:05 -0700 (PDT)
Message-ID: <85827a75-e224-448d-8c16-5ca9238737e5@linaro.org>
Date: Tue, 26 May 2026 10:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 19/39] hw/riscv: Add Microblaze V generic board
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
 <20241220015441.317236-20-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241220015441.317236-20-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sai,

On 20/12/24 02:54, Alistair Francis wrote:
> From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> 
> Add a basic board with interrupt controller (intc), timer, serial
> (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
> (configured via command line eg. -m 2g).
> This is basic configuration which matches HW generated out of AMD Vivado
> (design tools). But initial configuration is going beyond what it is
> configured by default because validation should be done on other
> configurations too. That's why wire also additional uart16500, axi
> ethernet(with axi dma).
> GPIOs, i2c and qspi is also listed for completeness.
> 
> IRQ map is: (addr)
> 0 - timer (0x41c00000)
> 1 - uartlite (0x40600000)
> 2 - i2c (0x40800000)
> 3 - qspi (0x44a00000)
> 4 - uart16550 (0x44a10000)
> 5 - emaclite (0x40e00000)
> 6 - timer2 (0x41c10000)
> 7 - axi emac (0x40c00000)
> 8 - axi dma (0x41e00000)
> 9 - axi dma
> 10 - gpio (0x40000000)
> 11 - gpio2 (0x40010000)
> 12 - gpio3 (0x40020000)
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20241125134739.18189-1-sai.pavan.boddu@amd.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS                                |   6 +
>   docs/system/riscv/microblaze-v-generic.rst |  42 +++++
>   docs/system/target-riscv.rst               |   1 +
>   hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
>   hw/riscv/Kconfig                           |   8 +
>   hw/riscv/meson.build                       |   1 +
>   6 files changed, 242 insertions(+)
>   create mode 100644 docs/system/riscv/microblaze-v-generic.rst
>   create mode 100644 hw/riscv/microblaze-v-generic.c


> +static void mb_v_generic_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "AMD Microblaze-V generic platform";
> +    mc->init = mb_v_generic_init;
> +    mc->min_cpus = 1;
> +    mc->max_cpus = 1;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;

Could you use or provide a proper CPU type for this machine?

> +    mc->default_cpus = 1;
> +}


