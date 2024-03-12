Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B2EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbS-000121-I3; Tue, 12 Mar 2024 18:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb6-00089z-Ew
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb3-0004SE-K4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NqqINJTPjtPrz9SrOlmZuaNG/epdXuQvR5UtyixbkoQ=;
 b=I0wzsbSmJd4VOW9JkRAUVcTrJleu9kw4sAWLbTikvkIypQT63lJMkQ69cJMnZnbnrkCeOi
 6OAKpVB2fyj8gC5d9NCjLs7iTO9xAdHJ45WG+LrqcKeZySEoXLzJnhn63CahO5C2lqY6Ze
 WGQ26fhU+AROJ982NrCz2lm70BuBc/k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-bK85dkSoMJyIq9ccpL3ITg-1; Tue, 12 Mar 2024 18:27:43 -0400
X-MC-Unique: bK85dkSoMJyIq9ccpL3ITg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5684c1abc33so2350646a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282462; x=1710887262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqqINJTPjtPrz9SrOlmZuaNG/epdXuQvR5UtyixbkoQ=;
 b=mavIEnlSqC9WD3Wyy0zdJz4mlFEdBhF4AeHW25JRmu/moGaqRyjbZlHNI+9x2K99mb
 yu+r/25fI1ONU/vWLdqmqChcKAjx9j7NplyjYWlEKGBAGm2S9jHVRVcVm86ICIWXXq4X
 SRBwYCHUHEc3oODiWNv2/Yhrxy4+s+MeNksrWPQM5lQEgk5wfRQllrI9bNyIf3ThnzEq
 OA7mqlI5ecMFIYBqz26BXiJjUtFuIihLlG96mFKeAYGL//iJM7LYem6tQZxxFxCEapkV
 8XhxwcFlW2nGa1juYSEovxHVFG2jFB1s3as4NY8QiMmtm5HI2Tp1NoHJIanC60BbcvmA
 eQmg==
X-Gm-Message-State: AOJu0YxyRDFy3vUBtiTk0OaS5YeFwGsKdwLjMyJFvv+7IiHOuewyoLAv
 dTZgSvhIr8xwcnNX1HnlLHMKD0lEVpY06paBaZ808+e09cZwPkxB1lWn9POqBApRnU0cmTCzMns
 Sx6ujsuqv8UKMJNTdvio6B1LRB5dc0TFEKi9mfVI/IKiKdNeWtJvtsT8Tg116A9cBwuTa22eozZ
 teF8zTuAnMbODGJTFHYOEFOtWujDfHS4Aw
X-Received: by 2002:a50:d65c:0:b0:565:cbba:b7a1 with SMTP id
 c28-20020a50d65c000000b00565cbbab7a1mr2363372edj.1.1710282461942; 
 Tue, 12 Mar 2024 15:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3xP+hoJCD7tM/5GLrYX3TvO3O01GDiQDOFMhaSmPaWqureyJ5Ly4APgqiEGnwWA/i7FxgDw==
X-Received: by 2002:a50:d65c:0:b0:565:cbba:b7a1 with SMTP id
 c28-20020a50d65c000000b00565cbbab7a1mr2363353edj.1.1710282461517; 
 Tue, 12 Mar 2024 15:27:41 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 r24-20020aa7d158000000b00568525ab2e8sm2964730edo.55.2024.03.12.15.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:41 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Felix Wu <flwu@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 41/68] Implement SMBIOS type 9 v2.6
Message-ID: <04f143d828845d0fd52dd4a52664d81a4f5431f7.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Felix Wu <flwu@google.com>

Signed-off-by: Felix Wu <flwu@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Message-Id: <20240221170027.1027325-3-nabihestefan@google.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  4 +++
 hw/smbios/smbios.c           | 49 +++++++++++++++++++++++++++++++++---
 qemu-options.hx              |  2 +-
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 9ab114aea2..c21b8d3285 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -222,6 +222,10 @@ struct smbios_type_9 {
     uint16_t slot_id;
     uint8_t slot_characteristics1;
     uint8_t slot_characteristics2;
+    /* SMBIOS spec v2.6+ */
+    uint16_t segment_group_number;
+    uint8_t bus_number;
+    uint8_t device_number;
 } QEMU_PACKED;
 
 /* SMBIOS type 11 - OEM strings */
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 38b3ea172c..e3d5d8f2e2 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -123,7 +123,7 @@ static QTAILQ_HEAD(, type8_instance) type8 = QTAILQ_HEAD_INITIALIZER(type8);
 
 /* type 9 instance for parsing */
 struct type9_instance {
-    const char *slot_designation;
+    const char *slot_designation, *pcidev;
     uint8_t slot_type, slot_data_bus_width, current_usage, slot_length,
             slot_characteristics1, slot_characteristics2;
     uint16_t slot_id;
@@ -436,6 +436,11 @@ static const QemuOptDesc qemu_smbios_type9_opts[] = {
         .type = QEMU_OPT_NUMBER,
         .help = "slot characteristics2, see the spec",
     },
+    {
+        .name = "pci_device",
+        .type = QEMU_OPT_STRING,
+        .help = "PCI device, if provided."
+    }
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {
@@ -866,7 +871,7 @@ static void smbios_build_type_8_table(void)
     }
 }
 
-static void smbios_build_type_9_table(void)
+static void smbios_build_type_9_table(Error **errp)
 {
     unsigned instance = 0;
     struct type9_instance *t9;
@@ -883,6 +888,43 @@ static void smbios_build_type_9_table(void)
         t->slot_characteristics1 = t9->slot_characteristics1;
         t->slot_characteristics2 = t9->slot_characteristics2;
 
+        if (t9->pcidev) {
+            PCIDevice *pdev = NULL;
+            int rc = pci_qdev_find_device(t9->pcidev, &pdev);
+            if (rc != 0) {
+                error_setg(errp,
+                           "No PCI device %s for SMBIOS type 9 entry %s",
+                           t9->pcidev, t9->slot_designation);
+                return;
+            }
+            /*
+             * We only handle the case were the device is attached to
+             * the PCI root bus. The general case is more complex as
+             * bridges are enumerated later and the table would need
+             * to be updated at this moment.
+             */
+            if (!pci_bus_is_root(pci_get_bus(pdev))) {
+                error_setg(errp,
+                           "Cannot create type 9 entry for PCI device %s: "
+                           "not attached to the root bus",
+                           t9->pcidev);
+                return;
+            }
+            t->segment_group_number = cpu_to_le16(0);
+            t->bus_number = pci_dev_bus_num(pdev);
+            t->device_number = pdev->devfn;
+        } else {
+            /*
+             * Per SMBIOS spec, For slots that are not of the PCI, AGP, PCI-X,
+             * or PCI-Express type that do not have bus/device/function
+             * information, 0FFh should be populated in the fields of Segment
+             * Group Number, Bus Number, Device/Function Number.
+             */
+            t->segment_group_number = 0xff;
+            t->bus_number = 0xff;
+            t->device_number = 0xff;
+        }
+
         SMBIOS_BUILD_TABLE_POST;
         instance++;
     }
@@ -1207,7 +1249,7 @@ void smbios_get_tables(MachineState *ms,
         }
 
         smbios_build_type_8_table();
-        smbios_build_type_9_table();
+        smbios_build_type_9_table(errp);
         smbios_build_type_11_table();
 
 #define MAX_DIMM_SZ (16 * GiB)
@@ -1556,6 +1598,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             t->slot_id = qemu_opt_get_number(opts, "slot_id", 0);
             t->slot_characteristics1 = qemu_opt_get_number(opts, "slot_characteristics1", 0);
             t->slot_characteristics2 = qemu_opt_get_number(opts, "slot_characteristics2", 0);
+            save_opt(&t->pcidev, opts, "pcidev");
             QTAILQ_INSERT_TAIL(&type9, t, next);
             return;
         }
diff --git a/qemu-options.hx b/qemu-options.hx
index 7da9235b08..937fd7ed84 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2718,7 +2718,7 @@ SRST
 ``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-family=%d][,processor-id=%d]``
     Specify SMBIOS type 4 fields
 
-``-smbios type=9[,slot_designation=str][,slot_type=%d][,slot_data_bus_width=%d][,current_usage=%d][,slot_length=%d][,slot_id=%d][,slot_characteristics1=%d][,slot_characteristics12=%d]``
+``-smbios type=9[,slot_designation=str][,slot_type=%d][,slot_data_bus_width=%d][,current_usage=%d][,slot_length=%d][,slot_id=%d][,slot_characteristics1=%d][,slot_characteristics12=%d][,pci_device=str]``
     Specify SMBIOS type 9 fields
 
 ``-smbios type=11[,value=str][,path=filename]``
-- 
MST


