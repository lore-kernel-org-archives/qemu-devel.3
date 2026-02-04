Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C5EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAO-0007aw-QI; Wed, 04 Feb 2026 14:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAD-0007Mi-FQ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA9-0007rk-SA
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLwO/omVOZxtIN6U7uD6xIh7qGAiRmp9jYMggRF++aY=;
 b=PkkN084bVsfIKjgRw94xB1qsW/s5OtG9US/x55MGtGoxb2DGaj8yIW5T09za6UKi9++luR
 JRgKezhAgMWlD4k6/7dd8rzLb7HlyhSzwSUG+l2ZVeZUAN6pgm64twiIgTbNgDi6OnOM0k
 hMYufhdC06djLx/dHRoSM676DaTWxSY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-w5hb0O65NHWsmHOucyiu3A-1; Wed, 04 Feb 2026 14:03:39 -0500
X-MC-Unique: w5hb0O65NHWsmHOucyiu3A-1
X-Mimecast-MFC-AGG-ID: w5hb0O65NHWsmHOucyiu3A_1770231818
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso144768f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231818; x=1770836618; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gLwO/omVOZxtIN6U7uD6xIh7qGAiRmp9jYMggRF++aY=;
 b=KVKck1UxKzOzOLAT0ebNoXdWSU9sewLNYHLtvcjUoip6XfQMR3HGmXrxB4oiASRviA
 Pmr2EaU3jNZPTch0SCHjnJc8LRYZJKTL3WYJUukj4nHv+KAYijdd/ZBHOdA8k+yceh+A
 GtbolrdMRmi5C08th9UBPgyeFkL7MELDEYCo13HEFrVPoSpIJ9AYBa9QVBDe15jzEix6
 HD3Tb7rnUvyIrj1Oamo5iOKkcuTlnb5t7Z1GiRMM4tjgSOBPZn1slOKyOGNZqDRsxENX
 DLTGXd7oHf4QkZ4eoBlVTWR/zB686nYS1X88WVnq9FuqFofJgJjTn6FXHP5srIuQe+0U
 5BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231818; x=1770836618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLwO/omVOZxtIN6U7uD6xIh7qGAiRmp9jYMggRF++aY=;
 b=ZNOfCASQzgLAZQu5vES8JR2H9kAi+JzR8z2cv9LcGToDG01Oqnnq71z7wPxcwxyN3D
 6J6Iigztidvy68cfF8qijYK2T8JLYxsHUu1jrrdRVX1rPn2oU615zI0LO0gEXtvxjeKX
 Hf5hGNIa2h9hOoBxvtvIryYsxOdI8eoBT0V5wOsWxJdrJg0Kl+NVTjUhs/FS8SLpJbIe
 EMAAa/Q7/UTgRiAe2wUpl1Zf6VoHWWZGuFejmEU8OAsgfdHsVKZd4hWQs1J7iWMy28pf
 0IHzTZrh4kxrS704EDR2OZ0L4T8W9jRbsHvK/wXLcqIgRhPbVXsMHOgDzDpuzJA27E8v
 ULVw==
X-Gm-Message-State: AOJu0YzsQeIm6yu0EPOmX0MjQRhDeWclbCS6qGwapSj5QSrP5ERJsejU
 dYRKRzwoHiU8BXBNtWH1BnslkztgcdNNVgAARP+ZUESmWBkvgkgXxUKbFY+/hqU5XXvdMEQIn5g
 StMV2PJC0teZyNPv/7dNvVwa760SkYBQse4yqr+BIdg9n6WN0betbOl5mdB2fPD2CQo/w225fMP
 ILiLxoAXWrSZ2a8LP+Rch7Zbs1Rf7BA/s15w==
X-Gm-Gg: AZuq6aJheBfuqGL3pireLO9JHhB11s/2wUHv+/vzJo43WCAKkuj5pzo7bRrxszC7GPD
 8dUoOjOhT/h/6ID01L8LX7Nu3CM3k2cGJJxPP0DVLZ5A85IQ/i1RODmqgXjMqbofwQwL7Hl1VfO
 JeIxUp8ra2ApVoLJsuwT4sQLRBaD6wo1Po5TftKMvhSxRQlb/fKFzT76t3s5OewFHf71RjtYRCR
 4KY12hbv8wKfBBYZd/n1mXsC/XsY3BqE7ZlXLUcZnr7uM7/50T4UuE6/cZLAnr7qIecMpw5+TWR
 43knuRZyf8hmWN6EJedAuyAJcM0taRnHhFsDtXCpz1pCwb5L8kRugodK2ufS6axKSb8VgLMHejz
 tRndX3gb5EPd/aEJNUOgsWr08Xl9bsQ/oZA==
X-Received: by 2002:a5d:5d84:0:b0:435:e061:9e10 with SMTP id
 ffacd0b85a97d-43617e39658mr6564021f8f.12.1770231817765; 
 Wed, 04 Feb 2026 11:03:37 -0800 (PST)
X-Received: by 2002:a5d:5d84:0:b0:435:e061:9e10 with SMTP id
 ffacd0b85a97d-43617e39658mr6563948f8f.12.1770231817228; 
 Wed, 04 Feb 2026 11:03:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e3a546sm9884677f8f.17.2026.02.04.11.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:36 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 20/51] acpi: add API to build WDAT instructions
Message-ID: <fbe220af04bbd75c0455d7424c7654c4c7faecdc.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Add definitions for WDAT[1] actions/instructions
and build_append_wdat_ins() API to build table entries.

1)
"Hardware Watchdog Timers Design Specification"
  https://uefi.org/acpi 'Watchdog Action Table (WDAT)'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251030123750.136175-3-imammedo@redhat.com>
---
 hw/acpi/aml-build.c    |  14 +++++
 include/hw/acpi/wdat.h | 118 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 include/hw/acpi/wdat.h

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index dad4cfcc7d..3ec70825de 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/cutils.h"
+#include "hw/acpi/wdat.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -2639,3 +2640,16 @@ Aml *aml_error_device(void)
 
     return dev;
 }
+
+void build_append_wdat_ins(GArray *table_data,
+                           WDATAction action, uint8_t flags,
+                           struct AcpiGenericAddress as,
+                           uint32_t val, uint32_t mask)
+{
+    build_append_int_noprefix(table_data, action, 1);    /* Watchdog Action */
+    build_append_int_noprefix(table_data, flags, 1);     /* Instruction Flags */
+    build_append_int_noprefix(table_data, 0, 2);         /* Reserved */
+    build_append_gas_from_struct(table_data, &as);       /* Register Region */
+    build_append_int_noprefix(table_data, val, 4);       /* Value */
+    build_append_int_noprefix(table_data, mask, 4);      /* Mask */
+}
diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
new file mode 100644
index 0000000000..c539e97e9b
--- /dev/null
+++ b/include/hw/acpi/wdat.h
@@ -0,0 +1,118 @@
+/*
+ * Watchdog Action Table (WDAT) definitions
+ *
+ * Copyright Red Hat, Inc. 2025
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_H
+#define QEMU_HW_ACPI_WDAT_H
+
+#include "hw/acpi/acpi-defs.h"
+
+/*
+ * Watchdog actions as described in
+ *  "Hardware Watchdog Timers Design Specification"
+ * for link to spec see https://uefi.org/acpi
+ *     'Watchdog Action Table (WDAT)'
+ */
+typedef enum {
+    /*
+     * Restarts the watchdog timer's countdown. This action is
+     * required.
+     */
+    WDAT_ACTION_RESET = 0x1,
+    /*
+     * Returns the current countdown value of the watchdog hardware
+     * (in count intervals).
+     */
+    WDAT_ACTION_QUERY_CURRENT_COUNTDOWN_PERIOD = 0x4,
+    /*
+     * Returns the countdown value the watchdog hardware is
+     * configured to use when reset (in count intervals).
+     */
+    WDAT_ACTION_QUERY_COUNTDOWN_PERIOD = 0x5,
+    /*
+     * Sets the countdown value (in count intervals) to be used when
+     * the watchdog timer is reset. This action is required if
+     * WDAT_ACTION_RESET does not explicitly write a new
+     * countdown value to a register during a reset. Otherwise, this
+     * action is optional.
+     */
+    WDAT_ACTION_SET_COUNTDOWN_PERIOD = 0x6,
+    /*
+     * Determines if the watchdog hardware is currently in enabled/
+     * running state. The same result must occur when performed from
+     * both from enabled/stopped state and enabled/running state. If
+     * the watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_QUERY_RUNNING_STATE = 0x8,
+    /*
+     * Starts the watchdog, if not already in running state. If the
+     * watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_SET_RUNNING_STATE = 0x9,
+    /*
+     * Determines if the watchdog hardware is currently in enabled/
+     * stopped state. The same result must occur when performed from
+     * both the enabled/stopped state and enabled/running state. If
+     * the watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_QUERY_STOPPED_STATE = 0xA,
+    /*
+     * Stops the watchdog, if not already in stopped state. If the
+     * watchdog hardware is disabled, results are indeterminate.
+     * This action is required.
+     */
+    WDAT_ACTION_SET_STOPPED_STATE = 0xB,
+    /*
+     * Determines if the watchdog hardware is configured to perform a
+     * reboot when the watchdog is fired.
+     */
+    WDAT_ACTION_QUERY_REBOOT = 0x10,
+    /*
+     * Configures the watchdog hardware to perform a reboot when it
+     * is fired.
+     */
+    WDAT_ACTION_SET_REBOOT = 0x11,
+    /*
+     * Determines if the watchdog hardware is configured to perform a
+     * system shutdown when fired.
+     */
+    WDAT_ACTION_QUERY_SHUTDOWN = 0x12,
+    /*
+     * Configures the watchdog hardware to perform a system shutdown
+     * when fired.
+     */
+    WDAT_ACTION_SET_SHUTDOWN = 0x13,
+    /*
+     * Determines if the current boot was caused by the watchdog
+     * firing. The boot status is required to be set if the watchdog
+     * fired and caused a reboot. It is recommended that the
+     * Watchdog Status be set if the watchdog fired and caused a
+     * shutdown. This action is required.
+     */
+    WDAT_ACTION_QUERY_WATCHDOG_STATUS = 0x20,
+    /*
+     * Sets the watchdog's boot status to the default value. This
+     * action is required.
+     */
+    WDAT_ACTION_SET_WATCHDOG_STATUS = 0x21,
+} WDATAction;
+
+#define WDAT_INS_READ_VALUE 0x0
+#define WDAT_INS_READ_COUNTDOWN 0x1
+#define WDAT_INS_WRITE_VALUE 0x2
+#define WDAT_INS_WRITE_COUNTDOWN 0x3
+#define WDAT_INS_PRESERVE_REGISTER 0x80
+
+void build_append_wdat_ins(GArray *table_data,
+                           WDATAction action, uint8_t flags,
+                           struct AcpiGenericAddress as,
+                           uint32_t val, uint32_t mask);
+
+#endif /* QEMU_HW_ACPI_WDAT_H */
-- 
MST


