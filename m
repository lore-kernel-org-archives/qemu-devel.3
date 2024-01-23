Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E60C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLkR-0004rJ-Ud; Tue, 23 Jan 2024 13:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLk7-0004ih-QC
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLk6-0002oM-0b
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:27 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64A1D40336
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706035396;
 bh=2lZi8/g8Zu9Qh6cePCjSVFHsW4sIk9nk2jSdvhZS48Q=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LSAfxdVLYKDXmRPnriHHuNXW0mXlvJQei5EyNDC1R+JVyrigzxkKqF9ZqHh0fBS/+
 Ra6kGB7IALAoHW8s6WdESWEyp5E/MCVFQzFuNIP7AFpT3NjWz0z0IarbGkjEXiTA3D
 X3sH5/yNc/TjMNUZQULFD7y/DClerl+PaIdpWhV5zsl36TGAzpIlZ235m/sl553vHE
 DwB0IQdtjs7HpVzvOeT5UWxJAEdLMlkI33hYo54+qWVbJxSCYBqvPraIU+xEZ03Gom
 dkD93uEwDbxTBCnJFq6mx1LMOg9MSSbbEPc+khv/HYS5ozur8c18YLshjOVqMeqedW
 ydLPieNPGOXHQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e40126031so46149525e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 10:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706035391; x=1706640191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lZi8/g8Zu9Qh6cePCjSVFHsW4sIk9nk2jSdvhZS48Q=;
 b=I0VJrFfoikeQ3eKzTS1AAckIoM8AxJpuCRxjewjrhhOjmSTbufkXvQe1FKMztQQfzB
 NUuOWzFoPXdvlMaAHXCAWq0lLV0hwyuIMgmsgwmw4cYwL/u09I+Z70Wam+wRCgA2RPuV
 x9Txn4YGPLg8fhrhOnBmU7eA5E1iUbHcZN+PJVWcJS749vsjcEER/seEGsdVWZD9oM0q
 uHFehLf84BjFbAI+dw2zL2w6XdKWuul+ErBoeHGBTGFnoA9DHYJoOnXyycyWif1IvjrE
 zidV1Sb0Oq6X4hfUC0niaz2AP6Sin19XGSPIT0gzVna5xkalSZJeEmE3+pdhN8B+dYea
 w9Ig==
X-Gm-Message-State: AOJu0YyxI3Rj6ZLow7PMaeC9q5C3DxpweNQ76UlFpBmKI99bedQl04D6
 SwIbR2/bZaen7FgzZooNLb7xtIVv33ulaWaMf5Sm6/jQfYQp01emJqU4UkhwV8IgE87gZIOgqQ1
 s79jwpwVIPc85Mtk9qaQX6Ae0CSVPjBBpX//qN/OV4eN5qpkXt+bVckMH5SlYRvbZdNSc
X-Received: by 2002:adf:fdc7:0:b0:337:bd80:c104 with SMTP id
 i7-20020adffdc7000000b00337bd80c104mr3625207wrs.71.1706035391767; 
 Tue, 23 Jan 2024 10:43:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk7rHpt3qwLbhbcrrQTiM1uunl2M1RzFx6Ly++PyLBcpoSS/G3+IGvdkBFAOdy6DKE48kfoQ==
X-Received: by 2002:adf:fdc7:0:b0:337:bd80:c104 with SMTP id
 i7-20020adffdc7000000b00337bd80c104mr3625193wrs.71.1706035391543; 
 Tue, 23 Jan 2024 10:43:11 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a5d6ac9000000b00337d392c6c3sm14180252wrw.13.2024.01.23.10.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:43:11 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 1/4] smbios: add processor-family option
Date: Tue, 23 Jan 2024 19:42:26 +0100
Message-ID: <20240123184229.10415-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
References: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For RISC-V the SMBIOS standard requires specific values of the processor
family value depending on the bitness of the CPU.

Add a processor-family option for SMBIOS table 4.

The value of processor-family may exceed 255 and therefore must be provided
in the Processor Family 2 field. Set the Processor Family field to 0xFE
which signals that the Processor Family 2 is used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v4:
	no change
v3:
	no change
v2:
	new patch
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
index ced8284863..d90bdffc7a 100644
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


