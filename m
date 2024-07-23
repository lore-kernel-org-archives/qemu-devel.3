Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048B8C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDFD-0001eP-7L; Tue, 23 Jul 2024 06:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEx-0000XB-Rq
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEv-0002NW-UR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZSgHsYIlqu62oOYqEz8U74/NNGfq5BqJa6TiXLGU28=;
 b=NTvI+PgpzMLUfhGDur9ZMnej8IbcnZObz2AWFOaoVgKPj27jz3nGA6tG2bweEM0v86tlm7
 8IUaC1hJeZ1YJM5fePgxzrkVU1ZgAzWdSyro+IpKXBT26VpjqCULeYiI50a+WU0ekKo8hc
 Norpbif+13CXl7cMARqqMgLxVinhaRk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-xyfaqT61P4abb_3Y26_FqA-1; Tue, 23 Jul 2024 06:59:26 -0400
X-MC-Unique: xyfaqT61P4abb_3Y26_FqA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427df7c3a2aso20041875e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732365; x=1722337165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZSgHsYIlqu62oOYqEz8U74/NNGfq5BqJa6TiXLGU28=;
 b=SBUur9tzE/HEEHZA6P6WpS6G5HbQb/k0K5wq2NgOJfe1G5toBDxPvDribno4WuF6kS
 9/Z2vCMyVCvEuEDEFWOUFCuZdGThjytbprb9Gp00u5LZ4lDM5KjoTljfbT0a58DLAFWA
 u21Y8PTb3zkGhXwE4RE/lLXCx6pOZvYSYsGA6tUOYxmwuADgRzJvWKZq3u//WVLFHa84
 LAQHEOEPqW6vLzXgJKf1RmFE/qvPRaILcDoNb5lg8SQmtWmvihLs1hzFfO1D9viDjR0v
 jzacb8wDoasAH6vwtDgxPDC16Sg7r/y7G7JN6eOJTOQRZkn05rzf8bs1WIN1vPshRadu
 7AoA==
X-Gm-Message-State: AOJu0Yz0ZmAs+U5WZU0zRhzNlA01Ad6+gJZgD6B4AtoP2DyM5brN6Q3h
 1KtShLfS7tPGQdLTp98w4kKiA8kowLawUKHEVxklhq7KdhruDjRE/Wn4LW6rCP1vsK1na9Urjfc
 Tg1oDP+XkdzVItc3Yh4DFOXIS+kFDwIBeuJ3Ok8ZfW9AeYm4BCBlIjJaELDv308CtS5GibLikln
 ixNPGRk/n0oE5Ve7NSybnUD86Ox7CKBw==
X-Received: by 2002:a05:600c:1c27:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-427dc515f90mr58917435e9.2.1721732365224; 
 Tue, 23 Jul 2024 03:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0C/0uC6m5IL0qVb7HMUY+AUzbnJl48FID37cxT3ijTRR6OYAKyjXokxjyyIACahz0wL6VRA==
X-Received: by 2002:a05:600c:1c27:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-427dc515f90mr58917135e9.2.1721732364587; 
 Tue, 23 Jul 2024 03:59:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d7263687sm166836685e9.4.2024.07.23.03.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:24 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Salil Mehta <salil.mehta@huawei.com>

OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
results in start of the CPU scan. Scan figures out the CPU and the kind of
event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
method with the call to method \\_SB.CPUS.CSCN (via \\_SB.GED.CSCN)

Architecture specific code [1] might initialize its CPUs AML code by calling
common function build_cpus_aml() like below for ARM:

build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry, memmap[VIRT_CPUHP_ACPI].base,
               "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY);

[1] https://lore.kernel.org/qemu-devel/20240613233639.202896-13-salil.mehta@huawei.com/

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-5-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h | 1 +
 hw/acpi/generic_event_device.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index e091ac2108..40af3550b5 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -87,6 +87,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
 #define AML_GED_EVT_SEL "ESEL"
+#define AML_GED_EVT_CPU_SCAN_METHOD "\\_SB.GED.CSCN"
 
 /*
  * Platforms need to specify the GED event bitmap
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 4641933a0f..15b4c3ebbf 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -108,6 +108,9 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                 aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
                                              MEMORY_SLOT_SCAN_METHOD));
                 break;
+            case ACPI_GED_CPU_HOTPLUG_EVT:
+                aml_append(if_ctx, aml_call0(AML_GED_EVT_CPU_SCAN_METHOD));
+                break;
             case ACPI_GED_PWR_DOWN_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
-- 
MST


