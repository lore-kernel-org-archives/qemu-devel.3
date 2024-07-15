Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AB5C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTL9f-0005jd-OK; Mon, 15 Jul 2024 08:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTL9e-0005eW-Cb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTL9b-0005a6-Ux
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721047806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lu2dlxaAnoyG8M5dAWM8Rq5ps2y5YNbk/Nphh1M5u8c=;
 b=SBJn+pqP6aIDlw2NUDabL65R+nrp5Pb761V+ZRORpx51t1y2TR7H1+76KGKoLwnaWTnlcQ
 7CZkrdfM4AxXdsmc/1UikCUu/CrDLoV/OChaHaTH5YCkXdJq/Sd0M8WI1GT3oVyovkJvGY
 f0YeBNN0G1D9AcWypStSgRZl+uDPhaY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-chPYR-kEP5urBAa7fcEmAw-1; Mon, 15 Jul 2024 08:50:05 -0400
X-MC-Unique: chPYR-kEP5urBAa7fcEmAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42668699453so40417585e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721047804; x=1721652604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lu2dlxaAnoyG8M5dAWM8Rq5ps2y5YNbk/Nphh1M5u8c=;
 b=fFr/zWLxM9YDbA34Jq1KQBydxSsZAkCvJaMDFFrC0fmzq77IYD6Q7tPwFXs4Ktkq+0
 yOqrNwwWX4hzXYtJnxMbx75lYHRz4ODct+H8vDN9X2Pre/qAw9H2XbH5DYrbLMrERYRl
 0bxiZlBRVuzSoCFCgdNKeKiBux1KSN1Vi6/gntdDYKMhS8Z4FBgy9irihpZdfaDsRaHf
 LesjJo6zedkhaEgERioGey3TINFz7dUzJ2KwDBffCIxle7bkaSJbOOhaUU5NPcxQ1e1O
 tmdr9q0U3mqlpI0kzx1N2inQ+NLi9mOTopEKfE4F5o6v6MQ4Bzv39lOT6VrlOCWqOUyV
 Y3Zw==
X-Gm-Message-State: AOJu0YxKG4L6aKkkkAqNRGghm1g6w9Agy2/88f4oomHXPnGCkp00hq4R
 NdkGzwGkmJFhYfxeqvByuvgL/yTinrdbBSWiVGMWLd5434ajIKXsib70vD14lXAGvAC4nPuGHfa
 neFKaxSCjs58GLSDFO6FuRb5ZMULp6RKAaXn+BrzDjYMvAiG+KSB5
X-Received: by 2002:a5d:47a7:0:b0:360:75b1:77fb with SMTP id
 ffacd0b85a97d-367cea46438mr20868810f8f.8.1721047803986; 
 Mon, 15 Jul 2024 05:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBOMAr/JGL1SERF6gkJMDOcFpMynDA+km7rRqTPDZnhcaIdZCRfWhNWGy0t91+VeOqz/AT7w==
X-Received: by 2002:a5d:47a7:0:b0:360:75b1:77fb with SMTP id
 ffacd0b85a97d-367cea46438mr20868788f8f.8.1721047803690; 
 Mon, 15 Jul 2024 05:50:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf151sm6303913f8f.29.2024.07.15.05.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 05:50:03 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:50:02 +0200
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
Subject: Re: [PATCH V15 2/7] hw/acpi: Move CPU ctrl-dev MMIO region len
 macro to common header file
Message-ID: <20240715145002.0cedd39d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240713182516.1457-3-salil.mehta@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240713182516.1457-3-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Sat, 13 Jul 2024 19:25:11 +0100
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/cpu.c         | 1 -
>  include/hw/acpi/cpu.h | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 2d81c1e790..cf5e9183e4 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -7,7 +7,6 @@
>  #include "trace.h"
>  #include "sysemu/numa.h"
> =20
> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
>  #define ACPI_CPU_SELECTOR_OFFSET_WR 0
>  #define ACPI_CPU_FLAGS_OFFSET_RW 4
>  #define ACPI_CPU_CMD_OFFSET_WR 5
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index e6e1a9ef59..df87b15997 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -19,6 +19,8 @@
>  #include "hw/boards.h"
>  #include "hw/hotplug.h"
> =20
> +#define ACPI_CPU_HOTPLUG_REG_LEN 12
> +
>  typedef struct AcpiCpuStatus {
>      CPUState *cpu;
>      uint64_t arch_id;


