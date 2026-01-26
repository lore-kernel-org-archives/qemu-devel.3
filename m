Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C3CD19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd4-0001Z6-C7; Mon, 26 Jan 2026 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcs-0001Qm-H7
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcq-000094-JY
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4359a302794so2972911f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449422; x=1770054222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7ZOgBJTZuLhg69aGiSHD6L4SYNtfGCSvu0hKB10ga8=;
 b=En5jYSkOIBIzzY0ICGzVC0BsQMgAgGYo/nNckN+aYaRfAj1T0t7z++K5q2Z7kMGBPA
 qUBguzqiuzzjrJ/ru2Cn1l7ZyYC4DE04Np40XKOT6h792b2rlA0ZLEd595u67kztufK8
 qwJr8irr2HTrrVOiPvK55A/Ar4nmSegsbuBaKLOUAIT6JCVB1uuzDpTXWSb5j2KW4fV8
 iS5DbB6q7BducadOOY5QPPmQPgkDQXSvp+UHVvzJDTNg1nmwlUsp/asZtErwtk6RtJoX
 CfO40tJRiiucz3MN1uVMfT7yiWKUmkS8ghE6JfW/ry2qTN2gDCZANZSqLiXrku6VwjYm
 bNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449422; x=1770054222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+7ZOgBJTZuLhg69aGiSHD6L4SYNtfGCSvu0hKB10ga8=;
 b=Km8jNFix6o8VROZBJ+UpdT4qeDN3yrJ88WIFY0vUaRpXfnzndD7JPPwbtSnNknHdTj
 hE4aSJfhgo4qY1gdquIYddILaedxWLcB90YJ3IVI3h7UqM2BBFJb/4VP9TuRpkzXp26S
 LSokyIfcMga4SAkCVjMM5j+vduy8DhqJKRV9//uwA8Ib3gzxtNpvNT8i4GdDEHLOY5OX
 1oGKODurbL1kNFQsAvQ0rWlN+tZbkAPVHIu3fg94pSEqprpH0yLW5WyV/fB185WDSLqQ
 2CZuNqjUV7VNyw+H0XcU6Ebcn3sZ6IYjUGfclypVd5RL34rrrxsdJTR8yQ1ye1uqerfb
 5PHg==
X-Gm-Message-State: AOJu0YwtzYAeoIr/uuxig7eAML17FsXgGqZ8TDx8rl03cgFndvV0LsrO
 QrKgNvqPI84EYImX7BPWOVYlMbSwgomgsGBtwCbq5Vq4l2Dv2p4hdzZJ/BPIze8G
X-Gm-Gg: AZuq6aJF4GVnOG1Bnqu2YrXvpAFGxRtXeiu4uMheKZt5VqSwayi6GQ9CzP2uxuFOd33
 CdmUNZ3je0c6PwhgM/75OQLv/izKvujdW0TNc1UGZW/acMqkEFVmCep5nclyU9BnjqRT/7dnSc0
 hliuffJVHx23o2Rb3jNZPkn2XITE5CjEDGNhY9Qdz6lvpw47YY5+9dn9oilfrLO0sucoGKDhYwj
 L2LX68b4zKLyJzyWdwY0XAhO4vgnfEp6GWH/n/84te8SrnpHbz/bIN9lU2mKRN75Negm9uxk4bJ
 276qUVa2wE846AbBadMTe49VLsF6MjYsYdzg3aE+liPqrTWe+vOAtQ4CPToEtRzSKITcqRlhpWt
 s/JJ3br6mCdHZ2QTsFWiszbTnM2YhLlPHO2pHt6yDtyvXsD/LwgfczEwv2fWnh0opWiBylXGc88
 T+4lT6So8sO1fTA1JkOxDSyID0dEaqz6/lRV4IGBE/a4dJrOgU8pU14Q==
X-Received: by 2002:a5d:5d13:0:b0:435:7154:2a7 with SMTP id
 ffacd0b85a97d-435ca0f7b44mr6872588f8f.6.1769449421838; 
 Mon, 26 Jan 2026 09:43:41 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:41 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/27] hw/core/machine: add '-hw-dtb' option for machine
Date: Mon, 26 Jan 2026 18:43:04 +0100
Message-ID: <20260126174313.1418150-19-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add new '-hw-dtb' command-line option and corresponding
MachineState property.
The 'hw-dtb' option allows to specify a Device tree
binary with hardware description which Qemu should
emulate.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/machine.c        | 19 +++++++++++++++++++
 include/hw/core/boards.h |  1 +
 qemu-options.hx          |  9 +++++++++
 system/vl.c              |  3 +++
 4 files changed, 32 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..fc04cf75c0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -378,6 +378,20 @@ static void machine_set_dtb(Object *obj, const char *value, Error **errp)
     ms->dtb = g_strdup(value);
 }
 
+static char *machine_get_hw_dtb(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->hw_dtb);
+}
+
+static void machine_set_hw_dtb(Object *obj, const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->hw_dtb = g_strdup(value);
+}
+
 static char *machine_get_dumpdtb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1287,6 +1301,11 @@ static void machine_initfn(Object *obj)
     ms->ram_size = mc->default_ram_size;
     ms->maxram_size = mc->default_ram_size;
 
+    object_property_add_str(obj, "hw-dtb",
+                            machine_get_hw_dtb, machine_set_hw_dtb);
+    object_property_set_description(obj, "hw-dtb",
+                    "A device tree used to describe the hardware to QEMU.");
+
     if (mc->nvdimm_supported) {
         ms->nvdimms_state = g_new0(NVDIMMState, 1);
         object_property_add_bool(obj, "nvdimm",
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 07f8938752..c28c505bb6 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -402,6 +402,7 @@ struct MachineState {
 
     void *fdt;
     char *dtb;
+    char *hw_dtb;
     char *dumpdtb;
     int phandle_start;
     char *dt_compatible;
diff --git a/qemu-options.hx b/qemu-options.hx
index bd014a3244..6dd3e04e38 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4492,6 +4492,15 @@ SRST(initrd)
 
 ERST
 
+DEF("hw-dtb", HAS_ARG, QEMU_OPTION_hw_dtb, \
+    "-hw-dtb file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
+SRST
+``-hw-dtb file``
+    Use <file> as a device tree binary (dtb) image used to create the
+    emulated machine. This dtb will not be passed to the kernel, use -dtb
+    for that.
+ERST
+
 DEF("dtb", HAS_ARG, QEMU_OPTION_dtb, \
     "-dtb    file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
 SRST
diff --git a/system/vl.c b/system/vl.c
index aa9a155041..c890da586c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3020,6 +3020,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_dtb:
                 qdict_put_str(machine_opts_dict, "dtb", optarg);
                 break;
+            case QEMU_OPTION_hw_dtb:
+                qdict_put_str(machine_opts_dict, "hw-dtb", optarg);
+                break;
             case QEMU_OPTION_cdrom:
                 drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
                 break;
-- 
2.43.0


