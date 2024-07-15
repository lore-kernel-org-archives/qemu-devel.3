Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B58C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLF3-0003D9-HN; Mon, 15 Jul 2024 08:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLF1-00039Q-F5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLEz-0006uI-Mw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721048140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXhi9NpfTXWHgY2dNzLAaqkM6ZDMZMLVgAna//bNgsM=;
 b=bcL5geH5egfaRohoHdpevmYgxb8OiAYjc1k0yUA2yDnWiv+x4ENEA0vOGVEtRU0Q/W4d4q
 GQ7P/WKEn5YxRDpn3Mq+1Buza9B0AHfH7Ux8e9Kdexjo9SZBuVCg+fKTtllLpCMDJGT+qA
 2De0sMl5g4romLHKxpkGTZzaC8gDo00=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-VzO5CJdKPgiR2EW-b0yl8Q-1; Mon, 15 Jul 2024 08:55:38 -0400
X-MC-Unique: VzO5CJdKPgiR2EW-b0yl8Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee8eaccb7aso42135371fa.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 05:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721048137; x=1721652937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXhi9NpfTXWHgY2dNzLAaqkM6ZDMZMLVgAna//bNgsM=;
 b=YppaELFoeIzDlEexyx6SUbF+KdGT///b1H0qpKM338mSHVIMiAn5IdTnVzZlYNrUrP
 RxuZMpmRg7OeoafD1ApW/6ufP0OKpPq9Gnj+fX5uiWajNbq7N+t6vqq6JESFvcz9sBBO
 nfSNxP2CfyEx8H3YC4kuJIHMVZFuCMDdGacNGTG8tiF5ASufY2ZeFlfYhBj0PLTQo05w
 EbkyQxgTKsE+JRy5tfiEta/NRTt8To+PYSpa8kEQo8XaqzF2813TWyWCGpiOuj6GHeRY
 KTtaBfdGF9ZTWz0xOyLFATmXWhJgO1YK2dTeOMSAQJu1qw00rITW3ydH3w2XXW3apaqV
 DWkA==
X-Gm-Message-State: AOJu0YzpGF6+RC4oC+O7QBhmkl6MB8xW1Ed/TvEvna6lpKvcENR75/FA
 df1739efCokr54Hcf91R826n2aVoODIPNJXOHmWHjFgVV8orI6Bw754a10RAqnc/6+8qfEHpI9w
 XVKqtKRsZ0R4WNnmTVDrzByaQNKNrXyqNGWg2yIl9l++oFBgjn/pU
X-Received: by 2002:a2e:984b:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2eeb30feb61mr121242391fa.29.1721048137447; 
 Mon, 15 Jul 2024 05:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5t69s/oQdGoCvU0838QHjVWHc6yjxcwmeZbfhYKuuQesKJylhqkLb1Maqumo5giGTAMDiaA==
X-Received: by 2002:a2e:984b:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2eeb30feb61mr121241981fa.29.1721048136979; 
 Mon, 15 Jul 2024 05:55:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25a957sm120311775e9.13.2024.07.15.05.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 05:55:36 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:55:35 +0200
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
Subject: Re: [PATCH V15 4/7] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20240715145535.0626527e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240713182516.1457-5-salil.mehta@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240713182516.1457-5-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 13 Jul 2024 19:25:13 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
> results in start of the CPU scan. Scan figures out the CPU and the kind of
> event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
> method with the call to method \\_SB.CPUS.CSCN (via \\_SB.GED.CSCN)
> 
> Architecture specific code [1] might initialize its CPUs AML code by calling
> common function build_cpus_aml() like below for ARM:
> 
> build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry, memmap[VIRT_CPUHP_ACPI].base,
>                "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY);
> 
> [1] https://lore.kernel.org/qemu-devel/20240613233639.202896-13-salil.mehta@huawei.com/
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/generic_event_device.c         | 3 +++
>  include/hw/acpi/generic_event_device.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 1b31d633ba..15ffa12cb2 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -108,6 +108,9 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                  aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
>                                               MEMORY_SLOT_SCAN_METHOD));
>                  break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0(AML_GED_EVT_CPU_SCAN_METHOD));
> +                break;
>              case ACPI_GED_PWR_DOWN_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index e091ac2108..40af3550b5 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -87,6 +87,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"
>  #define AML_GED_EVT_SEL "ESEL"
> +#define AML_GED_EVT_CPU_SCAN_METHOD "\\_SB.GED.CSCN"
>  
>  /*
>   * Platforms need to specify the GED event bitmap


