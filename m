Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132FBC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbO-0000Wi-Eo; Tue, 12 Mar 2024 18:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb3-000847-Ct
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb1-0004Rs-1v
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTX598p9HArzTLuFOxLRmny//KCE0d5V+ZWq2MLzXgc=;
 b=QxS+FDY/zP7uIwQub2R6AkEb4Erxop61k1p+mJzWeC5I4LRsUGb8uv4NsAytCikPCaSgqG
 eqriYXGIhOxLyvKH6DFHY4m1M/JkaEgAXEUXqqY5f4Qjp6wREafjX8R1/1wU5pArKtmUhQ
 n4q8xl/ivfLobCii4rToRYO/lKM8GYs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-hw04cfAjPsmqkqFyvvBt6w-1; Tue, 12 Mar 2024 18:27:41 -0400
X-MC-Unique: hw04cfAjPsmqkqFyvvBt6w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5684b85e0c9so296076a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282459; x=1710887259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTX598p9HArzTLuFOxLRmny//KCE0d5V+ZWq2MLzXgc=;
 b=WD+9/4v42lRgC5qIck+mLZhMhBxPeWU4NmlViPBzi36V4aAeedoz9naPsvFoMdCIvu
 uJ6VPTNZWGV2N9wzF5+Dk/gtP5C/QuB+xo0qgoOj2jnp/pSuO+yD1a0J20JRxHzUK0WK
 or8W+JLShiP4vUOTQy1E/R8BrASV2838HymJYZwqyNlp/HgsvC2YESMD7lUNwU1nP2Mu
 /i/NZfvxml3ivkWZBtvGLreVived0gfauZJKwfs8+L05YXpKu2kZWoWF1y8lKNxtwRtz
 hGTdUXYtrQzk/yhgABnOTWLfPFf0mnNocTK2TjfRER/qitt+2hltDOpt2PnKYAt/0wjk
 yPPA==
X-Gm-Message-State: AOJu0YyZVlD9OWyiK93sqlPkVzIgK8aJBlP6bAV7XaDu3sJ4PVKVq9bM
 Q1uy1dffXpHku2s0bc2zJOIz9tUKii+WhILBSzDBE4cmO2s5gyX2V/BGdPEQNweNmrZYqVWibwo
 qfm9dtNvbq+mGCsUA+i0ezrhu5Z13HRkDk7K/XZ1kFAxWC/JeruYCfzDwsfJPyJzlSd+w/Yj1m9
 X7GTNSDmyzNHiLDQ3bPzB4/cS7XxZXejxW
X-Received: by 2002:a50:cc89:0:b0:566:d083:df68 with SMTP id
 q9-20020a50cc89000000b00566d083df68mr707136edi.21.1710282459418; 
 Tue, 12 Mar 2024 15:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa5S5keexVi6Dkun5xvRgm/rGhpB0nN6qsiA5dFpVWMgHBQyZQ3SAvwwblUKBHQFX95crq8Q==
X-Received: by 2002:a50:cc89:0:b0:566:d083:df68 with SMTP id
 q9-20020a50cc89000000b00566d083df68mr707095edi.21.1710282458418; 
 Tue, 12 Mar 2024 15:27:38 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 m26-20020aa7c2da000000b005682d4f12b4sm4339184edp.45.2024.03.12.15.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:38 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Felix Wu <flwu@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 40/68] Implement base of SMBIOS type 9 descriptor.
Message-ID: <735eee07d1f963635d3c3bf9f5e4bf1bc000870e.1710282274.git.mst@redhat.com>
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

Version 2.1+.

Signed-off-by: Felix Wu <flwu@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Message-Id: <20240221170027.1027325-2-nabihestefan@google.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h | 13 +++++
 hw/smbios/smbios.c           | 99 ++++++++++++++++++++++++++++++++++++
 qemu-options.hx              |  3 ++
 3 files changed, 115 insertions(+)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 6e514982d4..9ab114aea2 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -211,6 +211,19 @@ struct smbios_type_8 {
     uint8_t port_type;
 } QEMU_PACKED;
 
+/* SMBIOS type 9 - System Slots (v2.1+) */
+struct smbios_type_9 {
+    struct smbios_structure_header header;
+    uint8_t slot_designation;
+    uint8_t slot_type;
+    uint8_t slot_data_bus_width;
+    uint8_t current_usage;
+    uint8_t slot_length;
+    uint16_t slot_id;
+    uint8_t slot_characteristics1;
+    uint8_t slot_characteristics2;
+} QEMU_PACKED;
+
 /* SMBIOS type 11 - OEM strings */
 struct smbios_type_11 {
     struct smbios_structure_header header;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a3c4e52ce9..38b3ea172c 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -121,6 +121,16 @@ struct type8_instance {
 };
 static QTAILQ_HEAD(, type8_instance) type8 = QTAILQ_HEAD_INITIALIZER(type8);
 
+/* type 9 instance for parsing */
+struct type9_instance {
+    const char *slot_designation;
+    uint8_t slot_type, slot_data_bus_width, current_usage, slot_length,
+            slot_characteristics1, slot_characteristics2;
+    uint16_t slot_id;
+    QTAILQ_ENTRY(type9_instance) next;
+};
+static QTAILQ_HEAD(, type9_instance) type9 = QTAILQ_HEAD_INITIALIZER(type9);
+
 static struct {
     size_t nvalues;
     char **values;
@@ -380,6 +390,54 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
     { /* end of list */ }
 };
 
+static const QemuOptDesc qemu_smbios_type9_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
+    {
+        .name = "slot_designation",
+        .type = QEMU_OPT_STRING,
+        .help = "string number for reference designation",
+    },
+    {
+        .name = "slot_type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "connector type",
+    },
+    {
+        .name = "slot_data_bus_width",
+        .type = QEMU_OPT_NUMBER,
+        .help = "port type",
+    },
+    {
+        .name = "current_usage",
+        .type = QEMU_OPT_NUMBER,
+        .help = "current usage",
+    },
+    {
+        .name = "slot_length",
+        .type = QEMU_OPT_NUMBER,
+        .help = "system slot length",
+    },
+    {
+        .name = "slot_id",
+        .type = QEMU_OPT_NUMBER,
+        .help = "system slot id",
+    },
+    {
+        .name = "slot_characteristics1",
+        .type = QEMU_OPT_NUMBER,
+        .help = "slot characteristics1, see the spec",
+    },
+    {
+        .name = "slot_characteristics2",
+        .type = QEMU_OPT_NUMBER,
+        .help = "slot characteristics2, see the spec",
+    },
+};
+
 static const QemuOptDesc qemu_smbios_type11_opts[] = {
     {
         .name = "type",
@@ -609,6 +667,7 @@ bool smbios_skip_table(uint8_t type, bool required_table)
 #define T2_BASE 0x200
 #define T3_BASE 0x300
 #define T4_BASE 0x400
+#define T9_BASE 0x900
 #define T11_BASE 0xe00
 
 #define T16_BASE 0x1000
@@ -807,6 +866,28 @@ static void smbios_build_type_8_table(void)
     }
 }
 
+static void smbios_build_type_9_table(void)
+{
+    unsigned instance = 0;
+    struct type9_instance *t9;
+
+    QTAILQ_FOREACH(t9, &type9, next) {
+        SMBIOS_BUILD_TABLE_PRE(9, T9_BASE + instance, true);
+
+        SMBIOS_TABLE_SET_STR(9, slot_designation, t9->slot_designation);
+        t->slot_type = t9->slot_type;
+        t->slot_data_bus_width = t9->slot_data_bus_width;
+        t->current_usage = t9->current_usage;
+        t->slot_length = t9->slot_length;
+        t->slot_id = t9->slot_id;
+        t->slot_characteristics1 = t9->slot_characteristics1;
+        t->slot_characteristics2 = t9->slot_characteristics2;
+
+        SMBIOS_BUILD_TABLE_POST;
+        instance++;
+    }
+}
+
 static void smbios_build_type_11_table(void)
 {
     char count_str[128];
@@ -1126,6 +1207,7 @@ void smbios_get_tables(MachineState *ms,
         }
 
         smbios_build_type_8_table();
+        smbios_build_type_9_table();
         smbios_build_type_11_table();
 
 #define MAX_DIMM_SZ (16 * GiB)
@@ -1460,6 +1542,23 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             t8_i->port_type = qemu_opt_get_number(opts, "port_type", 0);
             QTAILQ_INSERT_TAIL(&type8, t8_i, next);
             return;
+        case 9: {
+            if (!qemu_opts_validate(opts, qemu_smbios_type9_opts, errp)) {
+                return;
+            }
+            struct type9_instance *t;
+            t = g_new0(struct type9_instance, 1);
+            save_opt(&t->slot_designation, opts, "slot_designation");
+            t->slot_type = qemu_opt_get_number(opts, "slot_type", 0);
+            t->slot_data_bus_width = qemu_opt_get_number(opts, "slot_data_bus_width", 0);
+            t->current_usage = qemu_opt_get_number(opts, "current_usage", 0);
+            t->slot_length = qemu_opt_get_number(opts, "slot_length", 0);
+            t->slot_id = qemu_opt_get_number(opts, "slot_id", 0);
+            t->slot_characteristics1 = qemu_opt_get_number(opts, "slot_characteristics1", 0);
+            t->slot_characteristics2 = qemu_opt_get_number(opts, "slot_characteristics2", 0);
+            QTAILQ_INSERT_TAIL(&type9, t, next);
+            return;
+        }
         case 11:
             if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
                 return;
diff --git a/qemu-options.hx b/qemu-options.hx
index ac4a30fa83..7da9235b08 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2718,6 +2718,9 @@ SRST
 ``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-family=%d][,processor-id=%d]``
     Specify SMBIOS type 4 fields
 
+``-smbios type=9[,slot_designation=str][,slot_type=%d][,slot_data_bus_width=%d][,current_usage=%d][,slot_length=%d][,slot_id=%d][,slot_characteristics1=%d][,slot_characteristics12=%d]``
+    Specify SMBIOS type 9 fields
+
 ``-smbios type=11[,value=str][,path=filename]``
     Specify SMBIOS type 11 fields
 
-- 
MST


