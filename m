Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241F3C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 13:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ5Ld-0005GJ-Ir; Sat, 06 Jul 2024 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ5LY-0005EA-UK
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 09:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ5LX-0000GL-8S
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 09:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720272058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDkcqj2p7zjlaR6kdl0itNxFGJFmI88DVgz+HCfhMi4=;
 b=be19wbP4H+Ww2WOD3ReOML29aOyciXSJmyirGOYid+nTykmPHwwUgGq18byirCRLO2xV8I
 cIWa1Ui2wnwIOSG+Pnaa9nAwsqb8O2AViqW+sjOVfQS1wUUpNoNbBczIu7ApVNiQPOtnCg
 88v1u+bGzNaae0Kjkp5FqLSHs5dzqVE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-ZvCihrdOO1yKgPB7JWIVqA-1; Sat, 06 Jul 2024 09:20:54 -0400
X-MC-Unique: ZvCihrdOO1yKgPB7JWIVqA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso2021548f8f.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 06:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720272053; x=1720876853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDkcqj2p7zjlaR6kdl0itNxFGJFmI88DVgz+HCfhMi4=;
 b=T1yDzZqa835baSulmPFEVECD93vO1pItU+OQwxQOHh7cABROobh89he7zLTSSTG1eF
 mA7dpAMg1ECtj5Zq6lW+oIBMu01ebP7Hpazb/PxodsjOlOoDZATeQhblT8dITEEFWO11
 omCJ6XhiLK0I98FpxDrwB94bJbyYOTu+joc9Tf9pe4tZKV4LsSMO/YE7T65VrK0mgpb3
 6/0uUJZehiLUMgv91AoRtYTLaI63LeZBJM/7vWb7uHlY7Zy1JeJmrx/NrnobXvkP8PXy
 mgOrwuhF/eHNA3BO3kKrDCSnS6b7ZzRzaQ57g5hiTHqQgk/iQ7iIUwFJCxYJKjkeRBx2
 DMig==
X-Gm-Message-State: AOJu0Yyyg1nXKURqCrlcKwKWvV6Y6FGkxxEH5vdK0baV0utyTaQw3JAW
 pR03vb5mCCNeaQA8m2dEuFJuGKVFN3W//0Xob8pXL6US4C5yZoeGQUNBFfZpERfBIB5GPxLL/qD
 Cwk0Fo92RbKlHfjWNpIZEby/Ggfy8n2TZ1mSSUzndLQGAB/2lheXh
X-Received: by 2002:adf:e9d1:0:b0:360:7971:7e2c with SMTP id
 ffacd0b85a97d-3679dd66b01mr5080986f8f.54.1720272053628; 
 Sat, 06 Jul 2024 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi8MPuVg1cG3EFcEFHY1XLw8gb37vNLk4mdGSKio9Xs2Se8mf3kwOqBncOj1IbXrLC7RKNXA==
X-Received: by 2002:adf:e9d1:0:b0:360:7971:7e2c with SMTP id
 ffacd0b85a97d-3679dd66b01mr5080944f8f.54.1720272053208; 
 Sat, 06 Jul 2024 06:20:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca4dbsm96364735e9.33.2024.07.06.06.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 06:20:52 -0700 (PDT)
Date: Sat, 6 Jul 2024 15:20:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 2/8] hw/acpi: Move CPU ctrl-dev MMIO region len
 macro to common header file
Message-ID: <20240706152050.4f5f8109@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-3-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-3-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 7 Jun 2024 12:56:43 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> CPU ctrl-dev MMIO region length could be used in ACPI GED and various oth=
er
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
>=20
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/acpi/cpu.c                 | 2 +-
>  include/hw/acpi/cpu_hotplug.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 2d81c1e790..69aaa563db 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -1,13 +1,13 @@
>  #include "qemu/osdep.h"
>  #include "migration/vmstate.h"
>  #include "hw/acpi/cpu.h"
> +#include "hw/acpi/cpu_hotplug.h"
>  #include "hw/core/cpu.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-acpi.h"
>  #include "trace.h"
>  #include "sysemu/numa.h"
> =20
> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
>  #define ACPI_CPU_SELECTOR_OFFSET_WR 0
>  #define ACPI_CPU_FLAGS_OFFSET_RW 4
>  #define ACPI_CPU_CMD_OFFSET_WR 5
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 3b932abbbb..48b291e45e 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h

this file has deps on x86 machine and contains mainly
legacy CPU hotplug API for x86.=20

> @@ -19,6 +19,8 @@
>  #include "hw/hotplug.h"
>  #include "hw/acpi/cpu.h"
> =20
> +#define ACPI_CPU_HOTPLUG_REG_LEN 12

the better place for it would be include/hw/acpi/cpu.h

>  typedef struct AcpiCpuHotplug {
>      Object *device;
>      MemoryRegion io;


