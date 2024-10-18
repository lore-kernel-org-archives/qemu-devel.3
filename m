Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9F6D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1no7-00075Z-Fk; Fri, 18 Oct 2024 10:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1no5-00075A-E9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1no2-0007oG-Lh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729261097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vlis1wrdCPzJs0A3Vea7TA2gh4nT9iyy+d6woLENJUw=;
 b=cYry0z7KpPvMRAgDp/MgK7lIqC14gNtrx4tzdWD82GdKBzKlz200xgvVg2gqEjm+MB3ruw
 xB1VLqryd9EwcBqJxOApNDCQn87dScAN6xXjIlIe8VmFvM5MrrFpL63P9gbZJjzdYueTZX
 1+aF+lv27S+WRHfdJykKtPI57VtOXbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-PnsZ8Y5VPKunYU9Ejvhf_A-1; Fri, 18 Oct 2024 10:18:16 -0400
X-MC-Unique: PnsZ8Y5VPKunYU9Ejvhf_A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso13357425e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261095; x=1729865895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vlis1wrdCPzJs0A3Vea7TA2gh4nT9iyy+d6woLENJUw=;
 b=AFVhKfcm79o1Y7ouVwAV2823XKMkXLuVVV6r65A1svUPF4rk4xlC5FRRQW8gZzMdwz
 98oOeTFQiUINemLbQ1MEgp2xE/dsqPfdig6sAHDicNicPnBjWVB7+otl6ZZnsTxFc9Xe
 DjozpuHGC36O4qWrb5HSi+mqDrAxUIF31vSDjsUTmfgrzJww7c8+12rK7J8SUdQ8ssZp
 LG/6gippvjIC+YW+R2dhpGLw8WHCG8eZbrNRiksags8CY5tjTvAoCTBtfKd6sghJd1sx
 n+8X6EaJewo4wF+OrpX6oqgl0XuxbTuQVwbbELgIDM9z2hcrKGlHUdZpGhHSLF3pXVLS
 G0Rg==
X-Gm-Message-State: AOJu0Ywi7XC05zeAJjuBdhK4InexbL4GlVqxVS5E84vhHWi7cVf9IhFB
 DUz4EptVdknAKoyDimcj81eoztWCFDm8jni1VC0FWoWBESKz2B3A3iaaM9kkfpmJJlVkn4y4dxl
 3BUjmufWQha7yOiZ347qCguf7wn/KiYVAl4XIf1x1Be8hKnIK40m5
X-Received: by 2002:a05:600c:c84:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-43161622973mr21143155e9.6.1729261094918; 
 Fri, 18 Oct 2024 07:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4xNPUOYvnV9pPfxLANzb19EOQg1Sri5YRr72E14FCOsG0WdGSjZNf8+1EYYQ2LJZ05SYpuw==
X-Received: by 2002:a05:600c:c84:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-43161622973mr21142685e9.6.1729261094538; 
 Fri, 18 Oct 2024 07:18:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dbb4sm29303585e9.9.2024.10.18.07.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:18:14 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:18:11 +0200
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
Subject: Re: [PATCH V1 2/4] hw/acpi: Update ACPI CPU Status `is_{present,
 enabled}` during vCPU hot(un)plug
Message-ID: <20241018161811.4a88c7b7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241014192205.253479-3-salil.mehta@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-3-salil.mehta@huawei.com>
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

On Mon, 14 Oct 2024 20:22:03 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Update the `AcpiCpuStatus` for `is_enabled` and `is_present` accordingly when
> vCPUs are hot-plugged or hot-unplugged, taking into account the *persistence*
> of the vCPUs.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/acpi/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 083c4010c2..700aa855e9 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -291,6 +291,8 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>      }
>  
>      cdev->cpu = CPU(dev);
> +    cdev->is_present = true;
> +    cdev->is_enabled = true;

hmm, if cpu is always present, then these fields are redundant
since
  (!cdev->cpu) == present
and
  then is_enabled could be fetched from cdev->cpu directly

>      if (dev->hotplugged) {
>          cdev->is_inserting = true;
>          acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
> @@ -322,6 +324,11 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
>          return;
>      }
>  
> +    cdev->is_enabled = false;
> +    if (!acpi_persistent_cpu(CPU(dev))) {
> +        cdev->is_present = false;
> +    }

and other way around works as well.

then we don't have to carry around extra state and making sure that it's in sync/migrated.

> +
>      cdev->cpu = NULL;
>  }
>  


