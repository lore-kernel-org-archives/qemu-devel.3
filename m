Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5CCD30013
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1o0p-0003ze-VE; Fri, 18 Oct 2024 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1o0m-0003yx-Jy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1o0j-00017j-QD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729261883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+ji3MmBbUmUohvZsWgk1CYJA2ndOfLEAFkTnf9i+v4=;
 b=db57Z5JSU1xX8cyafnEGtnHXnN18AZAkIZNbJpoLfbeB4MYw9SIuKYkx3mMkXsPNgmb/8Y
 tgFA44JpkrpG1VAWKSFSETHKyBMFwFp1sgkLfyMKEmo4VHBj7arn8geL/meZRGZMgmrLqa
 I4hNsjQmFxNgRDQhnJicQpPSr00nlig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-KJhjH6ArM0i3WjNUYAKAoA-1; Fri, 18 Oct 2024 10:31:22 -0400
X-MC-Unique: KJhjH6ArM0i3WjNUYAKAoA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4314f023f55so16963675e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261881; x=1729866681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+ji3MmBbUmUohvZsWgk1CYJA2ndOfLEAFkTnf9i+v4=;
 b=f4kFm+N3+2OVo1GzsQOmqz51ImC2Bzs5SwQooG6WgglBpW3n9aguQ/gtVTgXRC4adr
 IehxnMUB3B21l9OPBZRgQnh61/9jfdCbOeTCC9Ok4KPxpWm7QNJ/ZpGzpnLy1H+VohIs
 y8/2Cr4uTRB0ccUUYEUOvHoe+iHQVnUOjOJvWASU2Lal//vg9TjwqxspaQcVAZXIax9/
 60S3H7Rr6kigzQEi1UOj36GfCzvCXo2tBB8rBYzHcP67c4scgWNNEvxLFzDePOgXghxi
 DYWoJDGjMJEKLpp47HiEag8oH4nPISS0Gnz8Y4LUpFPhDk2duugZOdmyNtoaIjsQUFFD
 tciQ==
X-Gm-Message-State: AOJu0YxhmgbZovTTGFaIwK2tA8lADmG3sf5y6aPIqhVD4mfWsKfKM512
 DgIP56PtCCEsZvDuzS6HfQChueIxjYn4DfzqRY2LDjV8TN4Ky+7tlxy8C+c61tlti9meTDOf16r
 yvFRBL4LmHQ1T4KiXOG/pCBPzjA6E3ZGp5+fDdwquPCY4AHu3nLXW
X-Received: by 2002:a05:600c:8719:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-431616331ddmr19890085e9.7.1729261881441; 
 Fri, 18 Oct 2024 07:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Hc7HawGEX9kRMRyLwR2bNA/QRnAcaOySe74/Z/QRaDx6+/xkEUGkMrJKscgo/+GDdsso2A==
X-Received: by 2002:a05:600c:8719:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-431616331ddmr19889575e9.7.1729261880931; 
 Fri, 18 Oct 2024 07:31:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf133885sm2085251f8f.108.2024.10.18.07.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:31:20 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:31:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <andrew.jones@linux.dev>, <david@redhat.com>, <philmd@linaro.org>,
 <eric.auger@redhat.com>, <will@kernel.org>, <ardb@kernel.org>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <gshan@redhat.com>,
 <rafael@kernel.org>, <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <npiggin@gmail.com>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: Re: [PATCH V1 4/4] hw/acpi: Populate vCPU Hotplug VMSD to migrate
 `is_{present,enabled}` states
Message-ID: <20241018163118.0ae01a84@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241014192205.253479-5-salil.mehta@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-5-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 14 Oct 2024 20:22:05 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> The ACPI CPU hotplug states `is_{present, enabled}` must be migrated alongside
> other vCPU hotplug states to the destination VM. Therefore, they should be
> integrated into the existing CPU Hotplug VM State Description (VMSD) table.
> Depending on the architecture and its implementation of CPU hotplug events
> (such as ACPI GED, etc.), the CPU hotplug states should be populated
> appropriately within their corresponding subsections of the VMSD table.
> 
>     "acpi-ged (16)": {
>         "ged_state": {
>             "sel": "0x00000000"
>         },
>         [...]
>         "acpi-ged/cpuhp": {
>             "cpuhp_state": {
>                 "selector": "0x00000005",
>                 "command": "0x00",
>                 "devs": [
>                     {
>                         "is_inserting": false,
>                         "is_removing": false,
>                         "is_present": true,
>                         "is_enabled": true,
>                         "ost_event": "0x00000000",
>                         "ost_status": "0x00000000"
>                     },
>                     {
>                         "is_inserting": false,
>                         "is_removing": false,
>                         "is_present": true,
>                         "is_enabled": true,
>                         "ost_event": "0x00000000",
>                         "ost_status": "0x00000000"
>                     },
>                     {
>                         "is_inserting": false,
>                         "is_removing": false,
>                         "is_present": true,
>                         "is_enabled": true,
>                         "ost_event": "0x00000000",
>                         "ost_status": "0x00000000"
>                     },
>                     {
>                         "is_inserting": false,
>                         "is_removing": false,
>                         "is_present": true,
>                         "is_enabled": true,
>                         "ost_event": "0x00000000",
>                         "ost_status": "0x00000000"
>                     },
>                     {
>                         "is_inserting": false,
>                         "is_removing": false,
>                         "is_present": true,
>                         "is_enabled": false,
>                         "ost_event": "0x00000000",
>                         "ost_status": "0x00000000"
>                     },
>                     {
>                         "is_inserting": false,
>                         "is_removing": false,
>                         "is_present": true,
>                         "is_enabled": false,
>                         "ost_event": "0x00000000",
>                         "ost_status": "0x00000000"
>                     }
>                 ]
>             }
>         }
>     },
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/acpi/cpu.c                  |  2 ++
>  hw/acpi/generic_event_device.c | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 23ea2b9c70..d34c1e601e 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -340,6 +340,8 @@ static const VMStateDescription vmstate_cpuhp_sts = {
>      .fields = (const VMStateField[]) {
>          VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
>          VMSTATE_BOOL(is_removing, AcpiCpuStatus),
> +        VMSTATE_BOOL(is_present, AcpiCpuStatus),
> +        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),

that's likely will break x86 migration,
but before bothering peterx, maybe we won't need this hunk if
is_enabled is migrated as part of vCPU state.

>          VMSTATE_UINT32(ost_event, AcpiCpuStatus),
>          VMSTATE_UINT32(ost_status, AcpiCpuStatus),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf..a4d78a534c 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -331,6 +331,16 @@ static const VMStateDescription vmstate_memhp_state = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_cpuhp_state = {
> +    .name = "acpi-ged/cpuhp",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

this subsection likely needs is_needed hook to avoid breaking
case where target doesn't have cpuhp support (older QEMU)

> +
>  static const VMStateDescription vmstate_ged_state = {
>      .name = "acpi-ged-state",
>      .version_id = 1,
> @@ -379,6 +389,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_memhp_state,
> +        &vmstate_cpuhp_state,
>          &vmstate_ghes_state,
>          NULL
>      }


