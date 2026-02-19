Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F58E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MH-0003zp-9p; Thu, 19 Feb 2026 09:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lp-0003k5-LV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lc-00082S-HA
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:49:54 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1037476f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512580; x=1772117380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6XbuelDKSmKPy76y/o+J48D8IcTsclY45iaYUbWGUQ=;
 b=e+/6+Json03MK2xDlAS5eMQRT/kDZq1SPqMiHxlrJQrPcbb/PoEev/4iVeI0cb6/Rq
 RJc6NC4tMKONKV1Evhr18yz+BRPzzEHSvUXThCK2yiXg1NYEHZh3892YJc4bSt/CI3p8
 reAp91wdqUnM/qup0wrPxlYndqHwltt/Q7OJ2uYv8Yzb7q2M4vJyvN+gYhgEiLKbvnLh
 +pwEU96bFHC/mRG3HVFX9O+TEEotB2tQQY+9J4ZwWu806wCo+VAzdynY2BIgGQCsrZDW
 /q5mWSzbD1z1+38hHUoJ4Dyj4NHHAaQiB2h7PbBACSSjxCw9Z3sOhL3PZboC3wu5hX8H
 V2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512580; x=1772117380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G6XbuelDKSmKPy76y/o+J48D8IcTsclY45iaYUbWGUQ=;
 b=aAhOg4WdULzvc2yAVM159VXY2w5JVeYF9L6LjqFGCyLhyuj/iLM0rSeO8iH96OtiM3
 w/gSGbXwn4TpP1rLfjykSzO7l2Vgqg096jGIdH7eU7jmdw9LR6q6K+S12aprWQDL9uTj
 oCe2J3+ZpZljMu5CwEthHEOEIEbYDoMr+cTxnT8OcCFsU2VwERyBsOiY/Pi5PwH2URwR
 yR3ufYUzAlQIEKj7KC3+bJ9Zz6mwH3SjD4ylcB/V4u0nGHgc0EdN7zVtnm5e0fpI5VZ/
 /bcdL2DV+mLFtyNDcJ4YWvITW4wDnoQ7FXbnvJrNf4GB21DcgWy7yE+IrzI8/au3Al/E
 By4A==
X-Gm-Message-State: AOJu0YzjTMqREOrMKcfoT6g3td71hWE70BPI4OAmITcGz9Rf18zVQina
 cX8jGh+JROIweuGxIN5uGf3d8OzLGB59I3Ia9W1xmW6Zdm/AMqOWngDR0sxfUFXg
X-Gm-Gg: AZuq6aIroXin2mYl4ARlGLZdgPGqa/+/vONo6NZoDZpkYlM1x2gIKer/3A5E8rcbMBd
 j0KxY4smAtymL8qMHJLb14J0TIADayR+isTEdttlONy4aU8pSagHZoelmvncN6HA+2deR2JOGgn
 wXVPndXVI7OuKHEpMpAzNGJqM2LJabFKohXM/q2MAbKMlQJnJbMbPlS76nd/w4BJAUFrUwFc5cb
 e9ZH5suyjcr/Krqj2Qatx4Vkln9aWO6qCSl3tQPCsRxqK4fVZKAIe2oO+5ftX3iWwCHDDSpXp1E
 A3pJBZGdRHoWv5E2ssk/H31tRp9/djlxjsn33qtgpRYef84JiS4hppFdR7JN0yIw+yyDSXcjHEo
 1ieGVrY12yrvbWLe5voHo1fCqSp6w87Q928g2idN1sNXL2+lO8+Jq8ng44l6T8HrZsU72EBvNGo
 mFh/96wyvKdpA2cWs3fy5ZIMKCN1ntNRygvJoo/TiRLEpkVlZwXbQQpECim2JFZmt4j324
X-Received: by 2002:a05:6000:26cf:b0:437:678b:83ca with SMTP id
 ffacd0b85a97d-4379dba36bamr30152921f8f.50.1771512579660; 
 Thu, 19 Feb 2026 06:49:39 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:39 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com
Subject: [PATCH v2 19/33] hw/core/machine: add '-hw-dtb' option for machine
Date: Thu, 19 Feb 2026 15:48:47 +0100
Message-ID: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x431.google.com
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
index d4ef620c17..affd24cd49 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -363,6 +363,20 @@ static void machine_set_dtb(Object *obj, const char *value, Error **errp)
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
@@ -1145,6 +1159,11 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dtb",
         "Linux kernel device tree file");
 
+    object_class_property_add_str(oc, "hw-dtb",
+                            machine_get_hw_dtb, machine_set_hw_dtb);
+    object_class_property_set_description(oc, "hw-dtb",
+                "A device tree binary used to describe the hardware to QEMU");
+
     object_class_property_add_str(oc, "dumpdtb",
         machine_get_dumpdtb, machine_set_dumpdtb);
     object_class_property_set_description(oc, "dumpdtb",
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index edbe8d03e5..722b79b5e4 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -403,6 +403,7 @@ struct MachineState {
 
     void *fdt;
     char *dtb;
+    char *hw_dtb;
     char *dumpdtb;
     int phandle_start;
     char *dt_compatible;
diff --git a/qemu-options.hx b/qemu-options.hx
index 33fcfe7ce6..1568f3ce4c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4518,6 +4518,15 @@ SRST(initrd)
 
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


