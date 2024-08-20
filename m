Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E2DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 19:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgUqo-00063z-9j; Tue, 20 Aug 2024 15:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgUqi-00061g-Ot
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 15:49:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgUqf-00040R-QJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 15:49:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428e3129851so48623685e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724183333; x=1724788133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ro0NGeEr0uwvCT+HwYSX+h2o22rx1Cwt4pNsykHPcNU=;
 b=rqdKWbdSv5Ig9GOpZDO9PC/QuXW/Xs4jIWjpUaFXkHGx4idvEMfIL4OK5Yhx8szc4q
 cvDewcB2VqakturySRgGMr9Y/3bM1kkZ5yL8TTQrJ6ZbB9jxJyIAWh+5JMoogU/R8SaK
 weaWbKmSZbQP1MPIxRne57IU2Edw3tUce/OhuF+GANfJku0gc3ww7ZC7JMbAQZooHR1T
 gfKvYcf4QdVyhQhG5JLjZ0zIDRq6sWjA90P1ryNcJViGJlPVmJUP3DxXHxMU3Lc+hl9c
 hDCneB6LL9z4IVXlvMiQ1seWcapk27V0ZyPT7bsgGf33CM+zTK4/RZNoYubPf5//QpAU
 cNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724183333; x=1724788133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ro0NGeEr0uwvCT+HwYSX+h2o22rx1Cwt4pNsykHPcNU=;
 b=MF7MYiNmHDsVV0fWl/jh+nAcSvQZ61ySxkoOcLdweevpdB8I9BTS87JCzgkQwJnlTT
 nH6s0dIU3BkE7R9i8WQXqqdo5ECx1Ft+ipmkIKAOrMZB0Njs5HHBjcsKfoUgRPL0HpBQ
 7rCSxKdxP45OVXOJDvkzPf8GAnjUyptglcWEvb6+MuovoUjc2aZfMVanN8hFpYI4HHvp
 7vM7sdBpua6eWjfb7AKDWrJ5Le06fWwi0PSTmZZfFEfLTZmdrHA4GBdsaTxU90PLKFcn
 Q8yNyRVXwfnegTQtM9L2w3ghDYH6Iuh92Qe3eWAshax5UZ2E1wlc8BTj5nMN6k6q5bs2
 6m7A==
X-Gm-Message-State: AOJu0YyPiRcUZXZfVL4cCOmXY6ldfVenpr3P/tV6ia68LMHjvVA16wB2
 Hav5FdOKhEJE6eXaHJD9SYFLe+UvlEduVfbtWRec+feSUpU1oKW9HZNKaPDUxOeAzjyD1Q81ed5
 s374=
X-Google-Smtp-Source: AGHT+IGjkPXRnwnBVSc6Xthl9pDzQzHXzTV5OWJXGuvfOZKFswXV94Hve/85hAuo1S1Q4mSXKq9UbA==
X-Received: by 2002:a05:600c:1c9e:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-42abcfe68d5mr3313455e9.0.1724183333064; 
 Tue, 20 Aug 2024 12:48:53 -0700 (PDT)
Received: from [192.168.69.100] (che77-h02-176-184-42-204.dsl.sta.abo.bbox.fr.
 [176.184.42.204]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded364fesm203193475e9.27.2024.08.20.12.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 12:48:52 -0700 (PDT)
Message-ID: <ee5b8c9e-09fe-4b28-86fb-c6859085f988@linaro.org>
Date: Tue, 20 Aug 2024 21:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/20] hw/i386/pc: Unify vmport=auto handling
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 Bernhard Beschow <shentey@gmail.com>
References: <20240819225116.17928-1-philmd@linaro.org>
 <20240819225116.17928-19-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240819225116.17928-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Kamil,

On 20/8/24 00:51, Philippe Mathieu-Daudé wrote:
> From: Kamil Szczęk <kamil@szczek.dev>
> 
> The code which translates vmport=auto to on/off is currently separate
> for each PC machine variant, while being functionally equivalent.
> This moves the translation into a shared initialization function, while
> also tightening the enum assertion.
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <v8pz1uwgIYWkidgZK-o8H-qJvnSyl0641XVmNO43Qls307AA3QRPuad_py6xGe0JAxB6yDEe76oZ8tau_n-2Y6sJBCKzCujNbEUUFhd-ahI=@szczek.dev>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc.c      | 5 +++++
>   hw/i386/pc_piix.c | 5 -----
>   hw/i386/pc_q35.c  | 5 -----
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..72229a24ff 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1217,6 +1217,11 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>           isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
>       }
>   
> +    assert(pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX);

Coverity reported:

 >>>     CID 1559533:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
 >>>     "pcms->vmport >= 0" is always true regardless of the values of 
its operands. This occurs as the logical first operand of "&&".

QAPI enums are unsigned because they start at 0, see:
https://www.qemu.org/docs/master/devel/qapi-code-gen.html#enumeration-types

   The generated C enumeration constants have values 0, 1, …, N-1
   (in QAPI schema order), where N is the number of values. There
   is an additional enumeration constant PREFIX__MAX with value N.

Could you post a patch to address this issue?

Thanks,

Phil.

> +    if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> +        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> +    }
> +
>       /* Super I/O */
>       pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>                       pcms->vmport != ON_OFF_AUTO_ON);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d9e69243b4..347afa4c37 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -310,11 +310,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>   
>       pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
>   
> -    assert(pcms->vmport != ON_OFF_AUTO__MAX);
> -    if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> -        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> -    }
> -
>       /* init basic PC hardware */
>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>                            !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 9d108b194e..f2d8edfa84 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -276,11 +276,6 @@ static void pc_q35_init(MachineState *machine)
>           x86_register_ferr_irq(x86ms->gsi[13]);
>       }
>   
> -    assert(pcms->vmport != ON_OFF_AUTO__MAX);
> -    if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> -        pcms->vmport = ON_OFF_AUTO_ON;
> -    }
> -
>       /* init basic PC hardware */
>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_floppy,
>                            0xff0104);


