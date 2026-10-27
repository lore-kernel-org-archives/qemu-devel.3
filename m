Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956BC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AO1T5oDM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf7D-00039q-Ph; Tue, 27 Oct 2026 07:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7B-00037S-U6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:14 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7A-0002u5-DV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:13 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2907033c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099591; x=1793704391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32XnSUYVfaw8pDaSjJQ1TXRXq88HLrWvXnAIvNKMIio=;
 b=AO1T5oDMdon/62b9SZ4m8hmtO2jxQcSmgs3rBOehvGshXOOWGd4G4nVmry9rzLmJ29
 5S2fChuUHUj6BHgFboZs+U5hF+kWH4IkENdjOCeEAVhEEUiNfAvau0HIFe9W/wJ6BjlS
 HkoF0Km3bG7i9U9pl3I1xPwNGhoVuEYJsoNWfwy9I8+vQy/niXcf6lH5xspHTGTHYWnT
 KAtPwWiikjS1CW81tUIJk3vhzSIILKbYRn+2BHl8CBnM0pNvuvvNLrb0OBaE0jljOitI
 kON78j9KrJcJwTMVETpRERSbt28qWkmZCS/WYqSHjqiPymjr8byEbT8yS9IIy4T9KgUD
 P5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099591; x=1793704391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=32XnSUYVfaw8pDaSjJQ1TXRXq88HLrWvXnAIvNKMIio=;
 b=mTqH0ntVp0U+1qE51lnLUWwqReLodo3m3Bh7BppntPvCJito/w3tSHfsPd1sgR9Pph
 yd/LpNpZSnoCXBYCuWl9kjz9sjfGRn4kdTL3wdgEDRa5QagztOBmCnrwGoGOgvQkaa/P
 roRT6z56fddRDUMu49jM0xftbHbbTJTVSRuQ7FwN6xyLsjWZGGMW1DaY07kisc48IfYS
 IY2Y+NrxG/+ciuadGd/+s+k/DjmWklpdglF4aaQepn3LK1TBiKPwkl0nwQqRdqYWyPWf
 4YldeY39C9987Q5J4Tacmh3pe6MyZDud4m3XQFeCGgKs4TtgWsRCWLe6rJHOY/4OEyP9
 6aVQ==
X-Gm-Message-State: AFq9FYLoqrH0xE48BeLsrz/x1h9TAFzV86UqHNiRiIByVAj2pQI/g99X
 cTQercZdUL7qvWTrXYxRde5Y6/7/Cu4Q752fs7kM5SJTdV5p3Rx1zNtQOXskvoDv
X-Gm-Gg: AYBFou26lOuLyZRDOvairf2E08IEJtEBH1PCV0UQnm64WGVPVaX9dQas6Vl6r32vrN8
 K4Dr6d/kmuad00MCqJWtTPc8aYA595HuQatX5IR9H21fVUCKz7/Jdz+VKHhdcYXne1GRZmcXtWf
 3lihIC6PVu5o5okmBEO0yIdwsXevbtmyiUS4w2+aiR3aR2kC0tViNcvmPkaF8QVtGN5Eq0v6/77
 HMBggj6HOy/ZOzW+2FV3M5KdTfeiFRp0IdMEC+/J0CvU5yht3PgrarZ0WT5wfZCL5/bt+/l7r0h
 OspJ6751FD1dHeo1gqc7ZfJtw7bA1dcYImNb5KBmiNUs1JEgyYOpixxngkaWeKAI852L78KzdJw
 bp78CdZYHvUCpVLF+qbRe++izrOI8wdC3bjkrv3zY3yfdF0DScAyDcsgYg1EMLUD9aRdiyd9/fw
 Y+Oc2ZQ1wxjFoeqwxPdDW9rcJFOboOMowHZSxYzJ6ecQYIKRkszVtuDT7YjYlrVTq0aDMeAStuB
 SBseBH7V1+dNcGBN3GlXIsuDGQElwkbNCDJ/Mt7t7MC8n5/tofOCR+p1p1+bnAY7S1v1chsfEAb
 U+mWUIhVRWSG
X-Received: by 2002:a05:7022:e806:b0:145:287:ce91 with SMTP id
 a92af1059eb24-19935625d41mr16005049c88.14.1793099590872; 
 Tue, 27 Oct 2026 04:13:10 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:10 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 07/17] hw/xtensa/virt: move virt TypeInfo into its type_init
Date: Tue, 27 Oct 2026 19:12:05 +0800
Message-ID: <20261027111216.392-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DEFINE_MACHINE() keeps the virt TypeInfo at file scope, so
.name has to be a constant expression. Register it from
xtensa_virt_machine_register_types() so a later commit can
compute the name: "virt" for a single-target binary, and
"<target_base_name>-virt" for a multi-target binary.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xtensa/virt.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..638007f6d32 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -115,8 +115,9 @@ static void xtensa_virt_init(MachineState *machine)
     xtensa_sim_load_kernel(cpu, machine);
 }
 
-static void xtensa_virt_machine_init(MachineClass *mc)
+static void xtensa_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
@@ -124,4 +125,15 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+static void xtensa_virt_machine_register_types(void)
+{
+    const TypeInfo xtensa_virt_machine_typeinfo = {
+        .name          = MACHINE_TYPE_NAME("virt"),
+        .parent        = TYPE_MACHINE,
+        .class_init    = xtensa_virt_machine_class_init,
+        .instance_size = sizeof(MachineState),
+    };
+    type_register_static(&xtensa_virt_machine_typeinfo);
+}
+
+type_init(xtensa_virt_machine_register_types)
-- 
2.52.0.windows.1


