Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57626C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOgX-0003Bh-D7; Fri, 09 Feb 2024 06:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdU-0007Yp-VJ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:42 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdK-0000se-Uf
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:35 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so534354a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476485; x=1708081285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuMOQMPstt+t/BCplSjk2Zw5tvEo5gDeByiMj5qhz2A=;
 b=mxapqQatxETrN4aVT9UJ2IAcrR/4YwmDybmTq+W4YuFta1/8W9TpA+ltVyxlKpXx9F
 11qhLimcYwqFjOr9UN+Hq5x5ebB8AEJP7sc1G0kEGQHg0wecSrahCX2ofPLUzZJBEpZu
 HeCn3heSrkypfXh1UpVGvfNohA01o21POPvOF8MEzeft+76ZXB0Ni/FEFcYq0iyvK0H9
 P3MTdUf15mWbuKteqdpAcHrdkzaPjZAlcZ1whJqdZUHmXYhLfdc0x81s8sBX2VPTCr3l
 cJV4FEUizVDl/r/NYmniaiY8fUq8Ra8YDWpjl4vdiEL3sToqjQfOZsNViGOo35NCcsFh
 BAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476485; x=1708081285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuMOQMPstt+t/BCplSjk2Zw5tvEo5gDeByiMj5qhz2A=;
 b=YORaEBKg2IpCb5LlLY0Uvgx76kjuZrqJ7sfjyz109KjElBN03nY3laps7ALaCYdLTD
 ueMXjbaI77jhSIFpezlq0nPf5c3SEz6kGNOUD/aikC4jf6MIeJkS5E9PBPT1TiOXFjnv
 0ObUv93rh3ZOqq5KOIG+KEhvm9HniZ6wEmqPwh4N1d/vZbT4HNskwckb+0KPaWYDe+9c
 /aBS5LP5Gik3OZTC5uOTr/Tl829b21jZAKt1MA2Kfz75hWGPFTIYGzBgg3ogFoVSESUC
 D2y/2XR4gRE+dMxQMZej5cRMcObZtC8nH0SIQQtMseUgCnwQdxBl5AYiDPJONMGzpRC/
 cCpg==
X-Gm-Message-State: AOJu0Yy7F7uA55CvgOjRLJ1wN+Ry/b9iqqnWvSKA8KSNLhBsCCt0BWnq
 fHyOT1iEGV8j6Vh1kSXWBcFD1Ya/bduGhg0hp4uc1MmsYrVu4fDQLHY3z8OEJIRwKw==
X-Google-Smtp-Source: AGHT+IF4qUSWNK3wS++oOkl/YWF9QcuPAXSpYIIK4FNx8ojstNzkSxTJmbam2m9jkXBuwJV57eduWA==
X-Received: by 2002:a17:90a:3187:b0:296:1ddc:d46a with SMTP id
 j7-20020a17090a318700b002961ddcd46amr1079262pjb.39.1707476485238; 
 Fri, 09 Feb 2024 03:01:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXRseWg8oBdDML+mvL0p9VoERjqc2ctTffucg6ahlXvrRYxwJ9x6RBVCJDI6WmC6qCVZdPrC7NyPuTMlitOjcscQZuKJowKWp2yUJMqD9bxf4h8JFRm83RBEZJnfLhy87VLLgKlcLaBAPcogJcNfMBXrZr1rk67n4+jDsivs9HXBTc4HH8=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 55/61] smbios: add processor-family option
Date: Fri,  9 Feb 2024 20:58:07 +1000
Message-ID: <20240209105813.3590056-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

For RISC-V the SMBIOS standard requires specific values of the processor
family value depending on the bitness of the CPU.

Add a processor-family option for SMBIOS table 4.

The value of processor-family may exceed 255 and therefore must be provided
in the Processor Family 2 field. Set the Processor Family field to 0xFE
which signals that the Processor Family 2 is used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240123184229.10415-2-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/smbios/smbios.c | 13 +++++++++++--
 qemu-options.hx    |  4 ++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 2a90601ac5..647bc6d603 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -102,6 +102,7 @@ static struct {
 #define DEFAULT_CPU_SPEED 2000
 
 static struct {
+    uint16_t processor_family;
     const char *sock_pfx, *manufacturer, *version, *serial, *asset, *part;
     uint64_t max_speed;
     uint64_t current_speed;
@@ -110,6 +111,7 @@ static struct {
     .max_speed = DEFAULT_CPU_SPEED,
     .current_speed = DEFAULT_CPU_SPEED,
     .processor_id = 0,
+    .processor_family = 0x01, /* Other */
 };
 
 struct type8_instance {
@@ -337,6 +339,10 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
         .name = "part",
         .type = QEMU_OPT_STRING,
         .help = "part number",
+    }, {
+        .name = "processor-family",
+        .type = QEMU_OPT_NUMBER,
+        .help = "processor family",
     }, {
         .name = "processor-id",
         .type = QEMU_OPT_NUMBER,
@@ -726,7 +732,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     snprintf(sock_str, sizeof(sock_str), "%s%2x", type4.sock_pfx, instance);
     SMBIOS_TABLE_SET_STR(4, socket_designation_str, sock_str);
     t->processor_type = 0x03; /* CPU */
-    t->processor_family = 0x01; /* Other */
+    t->processor_family = 0xfe; /* use Processor Family 2 field */
     SMBIOS_TABLE_SET_STR(4, processor_manufacturer_str, type4.manufacturer);
     if (type4.processor_id == 0) {
         t->processor_id[0] = cpu_to_le32(smbios_cpuid_version);
@@ -758,7 +764,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
 
     t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
-    t->processor_family2 = cpu_to_le16(0x01); /* Other */
+    t->processor_family2 = cpu_to_le16(type4.processor_family);
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
@@ -1402,6 +1408,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
                 return;
             }
             save_opt(&type4.sock_pfx, opts, "sock_pfx");
+            type4.processor_family = qemu_opt_get_number(opts,
+                                                         "processor-family",
+                                                         0x01 /* Other */);
             save_opt(&type4.manufacturer, opts, "manufacturer");
             save_opt(&type4.version, opts, "version");
             save_opt(&type4.serial, opts, "serial");
diff --git a/qemu-options.hx b/qemu-options.hx
index 5adbed1101..78fceae4c1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2686,7 +2686,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
-    "              [,processor-id=%d]\n"
+    "              [,processor-family=%d,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
@@ -2714,7 +2714,7 @@ SRST
 ``-smbios type=3[,manufacturer=str][,version=str][,serial=str][,asset=str][,sku=str]``
     Specify SMBIOS type 3 fields
 
-``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-id=%d]``
+``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str][,processor-family=%d][,processor-id=%d]``
     Specify SMBIOS type 4 fields
 
 ``-smbios type=11[,value=str][,path=filename]``
-- 
2.43.0


