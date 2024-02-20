Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83381C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVK4-0002kC-Kj; Tue, 20 Feb 2024 13:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVK1-0002iG-TM
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:58:30 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVJz-0001IS-RH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:58:29 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so77161541fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708455505; x=1709060305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wle9bqqx/TBzxF2PRDTdvIyQz+6o2XvLrYI/4TcEA7s=;
 b=jOtUdx2akm0QY+u+sFAlFX6fnQAtUrElSdhRODFtimIdC5eINIgfkCET37NpTwCSvR
 bukpC0J+mcDBtllJYKKe4DWpQWhHVgFbO4i6+u4gJLDn/oJ+KTE2ibst8hNcLVs9Yx9t
 nsPd1JVC1wiP/l/O2udS76zdQRbN080jkydhazamNM8nK95VZCIWPXLmQVGqJuFlo1wI
 0zbEN0moiHgnA/SYiiJulKyq3VXwJMnb5moGoQTvHXHP02ylcb7PcL6hnml5t9Oqc2/6
 9t+R3DkF4U+2UWDmXC/YuLUiNtDYqij6O+ZBSLOjJ8j0NZbxSq0XAdBAI7tRJPmuY1iw
 LWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708455505; x=1709060305;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wle9bqqx/TBzxF2PRDTdvIyQz+6o2XvLrYI/4TcEA7s=;
 b=FRnwV8HUznMPlFwMfy+OG4cx2O1LK4g3hJwwxDvBkMh4ln275xVuBEKREni6ZGZUeT
 B7BZVSsKrrs+vAIJYP5YFcKj6uWQo1yKeWwYb/dnJ+TFfaK0YPDjdKbve/UswgMHOr3E
 svrOu72YVt8tJSPYftIObv0BLCJv1ewzsUTVo/Ke5WvqRrmKUlOEOlb1I0/lZLZPG5EQ
 rt72s4Mj6Bf1m1EAj/tckVstyC4kLvOUtAIl1ouehIYTsZ+NV2g6yIfNaSV1lMii5bsy
 GHPdGLGysLRGwsdL0tXAOgAYqqZr8BPBDNFOMR0+Fyt/dInxfOSwymMqOifHDfJD7AmS
 3ffw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLIY1vmArMgCI5UrwFOgvDuifEIYRvUW0KtfAwDQQeTWGplYe9v3DtrXd4PxZ45M2bD1/HJ6qmz9syWGyJm9i2EJMbuGo=
X-Gm-Message-State: AOJu0YwwO+1XKHRZwzmbkJ6zzajQJtJlFSyy/S1UCkATRa+udpK/gly8
 L7BR2v5mw4BeFkTk58qRGF9GUlR8QhB2CaucQ9QrN3N52XAc83oQ7CKhb+OiP14=
X-Google-Smtp-Source: AGHT+IHzN1rlJxtY0BssfA/+5G3hIpBjif7eXLM7R7KZ051uZDERmnL4h+HpPTBBmr1k0teMyn/lMw==
X-Received: by 2002:a2e:b60a:0:b0:2d2:31e2:ec00 with SMTP id
 r10-20020a2eb60a000000b002d231e2ec00mr5464543ljn.30.1708455505316; 
 Tue, 20 Feb 2024 10:58:25 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 t12-20020a5d460c000000b0033b48190e5esm14369956wrq.67.2024.02.20.10.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 10:58:24 -0800 (PST)
Message-ID: <c2eecadd-9064-4814-9f69-90e5f9b5a9fd@linaro.org>
Date: Tue, 20 Feb 2024 19:58:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl, pc: turn -no-fd-bootchk into a machine property
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240220155352.416710-1-pbonzini@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220155352.416710-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 20/2/24 16:53, Paolo Bonzini wrote:
> Add a fd-bootchk property to PC machine types, so that -no-fd-bootchk
> returns an error if the machine does not support booting from floppies
> and checking for boot signatures therein.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/i386/pc.h |  2 +-
>   hw/i386/pc.c         | 30 +++++++++++++++++++++++++-----
>   system/globals.c     |  1 -
>   system/vl.c          |  2 +-
>   qemu-options.hx      |  2 +-
>   5 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 02a0deedd3c..e5382a02e7a 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -50,6 +50,7 @@ typedef struct PCMachineState {
>       bool hpet_enabled;
>       bool i8042_enabled;
>       bool default_bus_bypass_iommu;
> +    bool fd_bootchk;
>       uint64_t max_fw_size;
>   
>       /* ACPI Memory hotplug IO base address */
> @@ -147,7 +148,6 @@ OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
>   GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>   
>   /* pc.c */
> -extern int fd_bootchk;
>   
>   void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>   
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 28194014f82..31f4bb25a3e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -399,8 +399,8 @@ static int boot_device2nibble(char boot_device)
>       return 0;
>   }
>   
> -static void set_boot_dev(MC146818RtcState *s, const char *boot_device,
> -                         Error **errp)
> +static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
> +                         const char *boot_device, Error **errp)
>   {
>   #define PC_MAX_BOOT_DEVICES 3
>       int nbds, bds[3] = { 0, };
> @@ -420,12 +420,14 @@ static void set_boot_dev(MC146818RtcState *s, const char *boot_device,
>           }
>       }
>       mc146818rtc_set_cmos_data(s, 0x3d, (bds[1] << 4) | bds[0]);
> -    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | (fd_bootchk ? 0x0 : 0x1));
> +    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | !pcms->fd_bootchk);
>   }
>   
>   static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
>   {
> -    set_boot_dev(opaque, boot_device, errp);
> +    PCMachineState *pcms = PC_MACHINE(current_machine);
> +
> +    set_boot_dev(pcms, opaque, boot_device, errp);
>   }
>   
>   static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
> @@ -617,6 +619,9 @@ void pc_cmos_init(PCMachineState *pcms,
>       mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
>       mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
>   
> +    object_property_add_bool(obj, "fd-bootchk", pc_machine_get_fd_bootchk,
> +                             pc_machine_set_fd_bootchk);
> +
>       object_property_add_link(OBJECT(pcms), "rtc_state",
>                                TYPE_ISA_DEVICE,
>                                (Object **)&x86ms->rtc,
> @@ -625,7 +630,7 @@ void pc_cmos_init(PCMachineState *pcms,
>       object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
>                                &error_abort);
>   
> -    set_boot_dev(s, MACHINE(pcms)->boot_config.order, &error_fatal);
> +    set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
>   
>       val = 0;
>       val |= 0x02; /* FPU is there */
> @@ -1559,6 +1564,20 @@ static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
>       visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
>   }
>   
> +static bool pc_machine_get_fd_bootchk(Object *obj, Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +
> +    return pcms->fd_bootchk;
> +}
> +
> +static void pc_machine_set_fd_bootchk(Object *obj, bool value, Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +
> +    pcms->fd_bootchk = value;
> +}
> +
>   static bool pc_machine_get_smbus(Object *obj, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
> @@ -1747,6 +1766,7 @@ static void pc_machine_initfn(Object *obj)
>   #ifdef CONFIG_HPET
>       pcms->hpet_enabled = true;
>   #endif
> +    pcms->fd_bootchk = true;
>       pcms->default_bus_bypass_iommu = false;
>   
>       pc_system_flash_create(pcms);
> diff --git a/system/globals.c b/system/globals.c
> index b6d4e72530e..5d0046ba105 100644
> --- a/system/globals.c
> +++ b/system/globals.c
> @@ -41,7 +41,6 @@ int vga_interface_type = VGA_NONE;
>   bool vga_interface_created;
>   Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>   int win2k_install_hack;
> -int fd_bootchk = 1;
>   int graphic_rotate;
>   QEMUOptionRom option_rom[MAX_OPTION_ROMS];
>   int nb_option_roms;
> diff --git a/system/vl.c b/system/vl.c
> index a82555ae155..4627004304b 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2927,7 +2927,7 @@ void qemu_init(int argc, char **argv)
>                             optarg, FD_OPTS);
>                   break;
>               case QEMU_OPTION_no_fd_bootchk:
> -                fd_bootchk = 0;
> +                qdict_put_str(machine_opts_dict, "fd-bootchk", "off");
>                   break;
>               case QEMU_OPTION_netdev:
>                   default_net = 0;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8547254dbf9..a9e0107b4f0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2650,7 +2650,7 @@ DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
>   SRST
>   ``-no-fd-bootchk``
>       Disable boot signature checking for floppy disks in BIOS. May be
> -    needed to boot from old floppy disks.
> +    needed to boot from old floppy disks.  Synonym of ``-m fd-bootchk=off``.

Thank you!

Shouldn't we deprecate -no-fd-bootchk in favor of -m fd-bootchk=off?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   ERST
>   
>   DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,


