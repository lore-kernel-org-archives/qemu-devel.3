Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF3C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 02:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCXl-0001jZ-1x; Wed, 03 Jul 2024 22:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCXj-0001il-FJ; Wed, 03 Jul 2024 22:49:55 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCXd-0004qK-9Y; Wed, 03 Jul 2024 22:49:55 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d55f198f1eso116498b6e.0; 
 Wed, 03 Jul 2024 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720061387; x=1720666187; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faVAZXn9bsK4fGeINzwAK3yajvwzHgOzvX/M33g9KJE=;
 b=HKXIhABcb4/+lEDZ7ctMxTLFyNH0HmUGEhuNuDBTCSvmgGQ6oRjDf+MpOU6AFOLoCW
 KHVZWzncHGh9r/+dZROvPUi7oR/nv9c0lcyC47k96LE9bwY+PX4odFm+OZIJUekXoL5E
 TL6+Njz+Sy9pNrt3nQKSkm6AoStVmvTDiFXXbCelR+Be056hQ1DOj3XH/GTN1wk48Fg3
 qQxPk7AQp5sGDiFl48lVsf2d409x3MnWjMG3+PdkOmTtXsaiGIDEVs78Stzg28alB59F
 bvqUD5WvLD7jMLFbsjLRJnN3r9K56u4oIuxwsEMvCS9KZLdv/+xUr4/iOlBM16Np3i6x
 bCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720061387; x=1720666187;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=faVAZXn9bsK4fGeINzwAK3yajvwzHgOzvX/M33g9KJE=;
 b=Q2GDuZz4msplXyTHrqJsO/Kkmthd+qRMRFElvoS/e8REaTaqkaQVt1lGdwXZA7nN9i
 KBIlvj8fB+9wiadBmub/CCbBpu64mRx4xhsf2msCmIPfRn9IGaOAPO1YiIQxlcrZHGzF
 7fq4lzKrhN6fSHDCbMFlQOc1Hcf59DFHbY3ekcoSlTdiTezz3FV/X7r0G7TUaTxG8R4f
 n6BUI62T8yYtqt0m92Dm45Hn1/Y5hQ+8Livr8cpv9seh34dIi0peAB9NM9gg6UV8L3VR
 AmkbzSuy7fCUV61Kzydr4oV+1SLk2awOnM6jwMe1u0gSXQgn4x01UstlsA2vgpFYLcod
 AmoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmtL2yddgVNbPQSuriNVV0YM/V7dj3I3VZm5PH3H3zjCzpBdfJSECTaV48v0B7n0Q/3RXLR0C1yFCD5SUZCzNHwwcy7GvZBg+m53unI1x86UgHuDhQ8Sm+ldo=
X-Gm-Message-State: AOJu0YyJu4Tyzjt1e0QEvuHzkr5U8MTzedRGVt3+6rIIb2R+tsHtNxIB
 w9P9PmBnKyubI1nfaQX3QT9TwGGVRshhFXKi+qeqe+mat1Nn0RSK
X-Google-Smtp-Source: AGHT+IEUtrGurlX1HtjaYCvPArOnmH69qkJ09MiCg5xXoxVF+wfQjl5oZlGGffxlfav7LhRHYvfhhg==
X-Received: by 2002:a05:6808:907:b0:3d6:30e5:ef06 with SMTP id
 5614622812f47-3d914c63b4fmr342690b6e.17.1720061387262; 
 Wed, 03 Jul 2024 19:49:47 -0700 (PDT)
Received: from localhost ([1.146.95.80]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803fc8b84sm11148870b3a.103.2024.07.03.19.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 19:49:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 12:49:29 +1000
Message-Id: <D2GEV8KD5L3F.FRD8UH16X3GU@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <mst@redhat.com>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 13/29] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
X-Mailer: aerc 0.17.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-14-salil.mehta@huawei.com>
In-Reply-To: <20240613233639.202896-14-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri Jun 14, 2024 at 9:36 AM AEST, Salil Mehta wrote:
> ARM arch does not allow CPUs presence to be changed [1] after kernel has =
booted.
> Hence, firmware/ACPI/Qemu must ensure persistent view of the vCPUs to the=
 Guest
> kernel even when they are not present in the QoM i.e. are unplugged or ar=
e
> yet-to-be-plugged

Do you need arch-independent state for this? If ARM always requires
it then can it be implemented between arm and acpi interface?

If not, then perhaps could it be done in the patch that introduces
all the other state?

> References:
> [1] Check comment 5 in the bugzilla entry
>    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5

If I understand correctly (and I don't know ACPI, so it's likely
I don't), that is and update to ACPI spec to say some bit in ACPI
table must remain set regardless of CPU hotplug state.

Reference links are good, I think it would be nice to add a small
summary in the changelog too.

Thanks,
Nick

>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  cpu-common.c          |  6 ++++++
>  hw/arm/virt.c         |  7 +++++++
>  include/hw/core/cpu.h | 21 +++++++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/cpu-common.c b/cpu-common.c
> index 49d2a50835..e4b4dee99a 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -128,6 +128,12 @@ bool qemu_enabled_cpu(CPUState *cpu)
>      return cpu && !cpu->disabled;
>  }
> =20
> +bool qemu_persistent_cpu(CPUState *cpu)
> +{
> +    /* cpu state can be faked to the guest via acpi */
> +    return cpu && cpu->acpi_persistent;
> +}
> +
>  uint64_t qemu_get_cpu_archid(int cpu_index)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5f98162587..9d33f30a6a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3016,6 +3016,13 @@ static void virt_cpu_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
>      virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
> +
> +    /*
> +     * To give persistent presence view of vCPUs to the guest, ACPI migh=
t need
> +     * to fake the presence of the vCPUs to the guest but keep them disa=
bled.
> +     * This shall be used during the init of ACPI Hotplug state and hot-=
unplug
> +     */
> +     cs->acpi_persistent =3D true;
>  }
> =20
>  static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 62e68611c0..e13e542177 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -540,6 +540,14 @@ struct CPUState {
>       * every CPUState is enabled across all architectures.
>       */
>      bool disabled;
> +    /*
> +     * On certain architectures, to provide a persistent view of the 'pr=
esence'
> +     * of vCPUs to the guest, ACPI might need to fake the 'presence' of =
the
> +     * vCPUs but keep them ACPI-disabled for the guest. This is achieved=
 by
> +     * returning `_STA.PRES=3DTrue` and `_STA.Ena=3DFalse` for the unplu=
gged vCPUs
> +     * in QEMU QoM.
> +     */
> +    bool acpi_persistent;
> =20
>      /* TODO Move common fields from CPUArchState here. */
>      int cpu_index;
> @@ -959,6 +967,19 @@ bool qemu_present_cpu(CPUState *cpu);
>   */
>  bool qemu_enabled_cpu(CPUState *cpu);
> =20
> +/**
> + * qemu_persistent_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU state should always be reflected as *present* via =
ACPI
> + * to the Guest. By default, this is False on all architectures and has =
to be
> + * explicity set during initialization.
> + *
> + * Returns: True if it is ACPI 'persistent' CPU
> + *
> + */
> +bool qemu_persistent_cpu(CPUState *cpu);
> +
>  /**
>   * qemu_get_cpu_archid:
>   * @cpu_index: possible vCPU for which arch-id needs to be retreived


