Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AA9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdfy6-0006Vk-Hj; Mon, 12 Aug 2024 21:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdfy2-0006Uh-TN
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdfy0-0002Za-2b
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723511090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ioazDRmVc3QZtq4wp5en7NtK6ltFlUagoPAs3rc4Ge0=;
 b=MMJhDBA5l87n6ab68iaiu2wf5dAQm9RDWsaQaXErbUsqbMdQkXiArCx2iamA3YWr2qaT3j
 Z4vdw3wJ7C7EVi/NDaS+wqQrNF2+S36pf7B0QPk4gdIRPLE1cEb0/R1e1azUdTbxlRyMXv
 BhHHfVlpNg5BU4kNquDr1dZErZ41Nu8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-YhitWv3KMIaUxmzagVsR2w-1; Mon, 12 Aug 2024 21:04:47 -0400
X-MC-Unique: YhitWv3KMIaUxmzagVsR2w-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7ad78c1a019so4316111a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 18:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723511087; x=1724115887;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ioazDRmVc3QZtq4wp5en7NtK6ltFlUagoPAs3rc4Ge0=;
 b=evZkGFxzMAkOSCGNVDTGuxGQlFziA0en6C0AKkAIOrOKdka9ZPgrFuRviP5lMrdTUE
 +P3c6Ih01v8cIi1e535bEQurufO5v1kWnbT1RfmKFHtku5qmYwaNlDsKT0V28OUKL1yu
 q9o/SEfOxQYHaABKQ5lRLHgoB2MdQ2PGco0auDoGHd75AQG3q+Dd2h2dhHTN1cCuxg4L
 Ka31LV4azFxwDlLBHfPHcXbmoQt54RxmfeLGrv0GXTe7U1YrqZMes24lUE1bHP5/NkDJ
 UQZgFPq6K64R/ujej2ae9FcOOA1/Ka4XUQK/xjecpJvtZ6V3e7HfYnVb/ecEOf+zLQE/
 QTow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7raRxg7m3meBInVX3vazK9MpjtZvL41utGduX1FUDdzLekJbDjQ4eokBFB5Z2QND0TevFT367/TfgrKqZ/S70DbIKdU=
X-Gm-Message-State: AOJu0YzHNcPWIjB9oG80N+wtN+br9fJ0uI51fPeI+ENPb1OZpKTE5kP9
 ebWdDYJBRk0q/d0592jx6n2HED/RM9T6h8dmhSaDKW/rkseEuCib5Dhjh2zhMo0WdnOJobrxsfC
 PNZSPx9YoSL/aU8fr8ViJUnVQYJXrewjd93vrEQsadib0pLIlE0LU
X-Received: by 2002:a17:902:d2c2:b0:1fd:a7a7:20b7 with SMTP id
 d9443c01a7336-201ca175a05mr24328525ad.30.1723511086757; 
 Mon, 12 Aug 2024 18:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5v3/K+JnjTWLdm5ZsOdXUqEzru2NHAFjRySE4NRxjEJYDkj+4uvaguB4b3JfL/Fnq0YE3Tw==
X-Received: by 2002:a17:902:d2c2:b0:1fd:a7a7:20b7 with SMTP id
 d9443c01a7336-201ca175a05mr24328345ad.30.1723511086342; 
 Mon, 12 Aug 2024 18:04:46 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd14ab01sm2753095ad.82.2024.08.12.18.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 18:04:45 -0700 (PDT)
Message-ID: <143ad7d2-8f45-4428-bed3-891203a49029@redhat.com>
Date: Tue, 13 Aug 2024 11:04:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 11/29] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-12-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-12-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/14/24 9:36 AM, Salil Mehta wrote:
> ACPI CPU hotplug state (is_present=_STA.PRESENT, is_enabled=_STA.ENABLED) for
> all the possible vCPUs MUST be initialized during machine init. This is done
> during the creation of the GED device. VMM/Qemu MUST expose/fake the ACPI state
> of the disabled vCPUs to the Guest kernel as 'present' (_STA.PRESENT) always
> i.e. ACPI persistent. if the 'disabled' vCPU objectes are destroyed before the
> GED device has been created then their ACPI hotplug state might not get
> initialized correctly as acpi_persistent flag is part of the CPUState. This will
> expose wrong status of the unplugged vCPUs to the Guest kernel.
> 
> Hence, moving the GED device creation before disabled vCPU objects get destroyed
> as part of the post CPU init routine.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 918bcb9a1b..5f98162587 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2467,6 +2467,12 @@ static void machvirt_init(MachineState *machine)
>   
>       create_gic(vms, sysmem);
>   
> +    has_ged = has_ged && aarch64 && firmware_loaded &&
> +              virt_is_acpi_enabled(vms);
> +    if (has_ged) {
> +        vms->acpi_dev = create_acpi_ged(vms);
> +    }
> +
>       virt_cpu_post_init(vms, sysmem);
>   
>       fdt_add_pmu_nodes(vms);
> @@ -2489,9 +2495,7 @@ static void machvirt_init(MachineState *machine)
>   
>       create_pcie(vms);
>   
> -    if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
> -        vms->acpi_dev = create_acpi_ged(vms);
> -    } else {
> +    if (!has_ged) {
>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>       }
>   

It's likely the GPIO device can be created before those disabled CPU objects
are destroyed. It means the whole chunk of code can be moved together, I think.

Thanks,
Gavin


