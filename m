Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B725DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpxb-0006VB-UW; Wed, 21 Feb 2024 12:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MSzWZQwKChgByz652GH23yB4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--nabihestefan.bounces.google.com>)
 id 1rcpxW-0006Mr-Ki
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:00:40 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MSzWZQwKChgByz652GH23yB4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--nabihestefan.bounces.google.com>)
 id 1rcpxU-00037P-7x
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:00:37 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-607cd6c11d7so101458267b3.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708534833; x=1709139633; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mbb6F/kEymqfJxvlakPQcJAgpZqMaRxUss3YZiC7LPU=;
 b=sJ/c7HSaj6d9qA/gmF2W7UGWRM4Z2GMCScw6ex2t0VOXOHVh2GdQhYKqLcASXZI8sq
 hmzh137v7g7gVhYxEuUFlVtKkOMztIjL+W+e/5/PCLg8sOYT06hoKHDmToLWO+dXyebO
 JfFhGLVR4D090yRSTyAU+UDskHBp/SO47kqoD8IepjruebPeAS4hPfDrq9q/dHf9Ousm
 SNoAzgtiMWytRdRC4vJCzCxAbyT+2xFDKOEifQ3zUx+AmfRmk5I2P8IuN34hQNT/XKy2
 3WCauzVL6qf37jAEGTORkjDjlMPYosoJnKrDu9pLFBRz9+tSzPSIoj4xBsgx+pC/6lVU
 6e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708534833; x=1709139633;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mbb6F/kEymqfJxvlakPQcJAgpZqMaRxUss3YZiC7LPU=;
 b=IMXDIlY2D86PSS05NOpU+s/3LV2q++8qJBUsxYi00TVQfJ1S+ZkHBsH+sLvSCrBu2t
 x660/Ikn0tNhI2xwRMIAS8LZxZkcREf9cyFFrZShbV18YTr/M0lmPwvd/C6zdXbmwJoN
 GI9+J8xnJ67q6Kisj8CnFaDarP4HAxHbVX0rNZFhGwmIC1GjTVBWms6WX/JLyVDUxqou
 83qvgrzcHz8Fori8VzMq7Lw4lrD/r5ARlnBtNOKLNBURbvfjlRHZGLsZHempHaNVgZQw
 dmiMYkPG5F7YCIA2uxb3AG1DTOGB+mgSsRq86r4TQ/8v1r5mefvVbmNqa9MnLePbbkrC
 emeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViVZ753cFtbZ8a16I1qG7aQz7+C/YCQ+thuQS/TzTLlSCvBEyqmSYrYckr10zN8/jMesFcuvaMVytSE9Wh9LlAg76E4fs=
X-Gm-Message-State: AOJu0YzSefuJpT38o691B+f1tiaRvXag495kXEMN+WHptDxntl345nFA
 gtLmpnpdA7GOzu226RQcOGWa9jcp1hh+1WHt5WwCiDVxsccXWlu/qIIWII9kFZV6qFNgpETZ/WT
 Mb8imkW1R+K0+hm29e7M1ICF3Ng==
X-Google-Smtp-Source: AGHT+IGpVFzx0UGI3M5BFpE/hmh31dUzXAItDfCRiZEOZikplzFcedrVvubmvJBHcWxGa6sB3OXRnumAwMxwxyavkfI=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:f20f:0:b0:608:788f:8cfa with SMTP
 id i15-20020a81f20f000000b00608788f8cfamr609080ywm.1.1708534833092; Wed, 21
 Feb 2024 09:00:33 -0800 (PST)
Date: Wed, 21 Feb 2024 17:00:26 +0000
In-Reply-To: <20240221170027.1027325-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240221170027.1027325-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221170027.1027325-2-nabihestefan@google.com>
Subject: [PATCH 1/2] Implement base of SMBIOS type 9 descriptor.
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, eric.auger@redhat.com, mst@redhat.com, 
 imammedo@redhat.com, anisinha@redhat.com, flwu@google.com, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3MSzWZQwKChgByz652GH23yB4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
---
 hw/smbios/smbios.c           | 99 ++++++++++++++++++++++++++++++++++++
 include/hw/firmware/smbios.h | 13 +++++
 qemu-options.hx              |  3 ++
 3 files changed, 115 insertions(+)

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
diff --git a/qemu-options.hx b/qemu-options.hx
index 8547254dbf..9ddb1b1fb3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2717,6 +2717,9 @@ SRST
 ``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-family=%d][,processor-id=%d]``
     Specify SMBIOS type 4 fields
 
+``-smbios type=9[,slot_designation=str][,slot_type=%d][,slot_data_bus_width=%d][,current_usage=%d][,slot_length=%d][,slot_id=%d][,slot_characteristics1=%d][,slot_characteristics12=%d]``
+    Specify SMBIOS type 9 fields
+
 ``-smbios type=11[,value=str][,path=filename]``
     Specify SMBIOS type 11 fields
 
-- 
2.44.0.rc0.258.g7320e95886-goog


