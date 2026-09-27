Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3717EC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjNW-0000CW-84; Sun, 27 Sep 2026 03:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjNT-0008NA-Dt
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjNR-0006bT-Co
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QHFmcu3201316
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHFX0PvLMf+Hsw8xnGc25nM8FRuS49x8Ym+534oN7w0=; b=MIntgDM574gtXWIN
 Lfy1OUU5MEZygrzdJOb5WmW7uhsc8tx5LzQkHvCwWAY9js+ZYSkVFww+nirSvfQm
 zJ81eeOyjt7oxHBFOZAlb9Ymd8FpR5deR0IrOVnRywDaHYYOVRgQB4NJMS0ki389
 dWcHO4bULHHzlAj72fjVCYRH3HmB8pzY5GiPWmpgBzv9OxsdsYLpmd3AQhgQihYE
 1PtDH96e91OvHIpTZHQqvS7TjUxddVc615HClBepXYAEIqhsNUw714NlCNF241Ph
 WKQWusNgi7bx0Yw+6ihu7jwPi+xj1sWqdsgo3aO8Iw1qBpyLp5LhPtXnYUwCTrER
 E8qRSg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jtcnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53310b75674so38749521cf.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494367; x=1791099167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHFX0PvLMf+Hsw8xnGc25nM8FRuS49x8Ym+534oN7w0=;
 b=MWzlb1d6tDxd5nFRmVdeqMd1zjzMZymu4e0Q97/SBkud3DzUq16paodX+4d05cMh8T
 +bmsfjRZa4d4CsXm1wlJpYXvUqrYks5/7hKx1YyVqUIAa9A39Te22le1rWzPJbtUQAGn
 5qma7Uj81L5iLyk3jSpw2zcLqcpF6fXzUphTAOgckr2nDDBTk5/yc3DapaT+4icYw9C/
 0kerPjiZeCx0eMUzPMngZdvAN9S08FJNszwJuIGc06l3jw/4yxzyuXGRaNQ1QagfGvJ4
 3eRSoe6aitht5lh10L3b6Zdks1mh5QzFp+zE+KGhkztWUhFGiYCWNduPsFtX+puxoQMK
 cz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494367; x=1791099167;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHFX0PvLMf+Hsw8xnGc25nM8FRuS49x8Ym+534oN7w0=;
 b=ZF/Y5eS9bJQGS72iD71KnFCCqr0+T6C3xbLoGxPEyPEx57rivT/SfFaxR3UByp3FIJ
 hrCmITKYCNJ/bVVwYGse+Wl+naZxTHdfCZvFBIF3m+sHmKiDwHs+04/x4AfLeCLVJXn4
 bZIS8HQR6nDiiC+SIL+kclNMGNZmISpRsavKlhCi2VpyE4FREco+yULcohXkjOXs+MdW
 G+R1VOFRrIjqiQrFOzGQ2BbXfhE5I6yTWXvmu7D+5LkFEuis+iQoJwJQMbexvvV5AeLP
 Prec26l2T+UtzT/B9kn3Cz4sXW0DGFhcT+p6CVdNIDhpkfhJsoyq7N0SoTKfIANk3gmg
 CJKA==
X-Gm-Message-State: AFuF++klBxRvhXufbXBfIBi1DTmUwTP/JBy4Hm1HhewL74N/gFIuxnB6
 m548WxIgGDgvE0iZSdBMZqzZ4Idsn4OBBmQxBacdZ+lEWjPiToCoWkpEKFpQIMhZGqXfkGrPteh
 8RXeuk7FNMgI/2NDcpMNeU++1AwHNcCD3r8U6UZfUqEzj/OLVmz65xal0b3JrPCu7XA==
X-Gm-Gg: AYBFou0ps0lFehxOQsGvv/qUklFbpV+7BzLapPKa/f1z5f9LYgjpdbI3IMsEfd4YPfL
 q8DpZM4OmvF13eZmHnBQFhv9uKmC0g2shNXuRAtt+y+LLtB4oKi4zSjT4zLDCdNu2E2uYet7fGz
 EV8efgHrL9/SFLva6RFuUsOpHIp/j1jAhuamhg0Vv16qKc95zNGySdcMZYRUSA5mSUT/ZHxgIxG
 RzAT/dXU6RN9DUOMj/FvVHSCwles6iHQlLC9eLdksAIA8uNHAg0nYGx5Dz9LQHl5mKdvfj19pcw
 qj9mkrjQdLkno4edyo/R87Yb4VI61olfbHIb9wAUNr34h0lPaH3jc1qXPE6vfYpXnhs0pD+Gyux
 MZ/g/Of1J+qcFaglUssZXjGjpCC2p3ya5lyNtz5Ex
X-Received: by 2002:a05:622a:2515:b0:533:3b67:75dd with SMTP id
 d75a77b69052e-5333b6778e8mr10934651cf.13.1790494366734; 
 Sun, 27 Sep 2026 00:32:46 -0700 (PDT)
X-Received: by 2002:a05:622a:2515:b0:533:3b67:75dd with SMTP id
 d75a77b69052e-5333b6778e8mr10934351cf.13.1790494366147; 
 Sun, 27 Sep 2026 00:32:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm38339935e9.9.2026.09.27.00.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] target-info: add multi-target test binary
Date: Sun, 27 Sep 2026 09:31:40 +0200
Message-ID: <20260927073140.41422-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX4txrOQjZ5zUc
 Jy1/N2C52T8cl0AsoCvQ+s91rPj1nTVYP9xscjgzZoDZmi8hlO/smzi/IuFLxwcckYtB6F8TR8H
 VjAjgqrzp/W0szJNjaWEOhEMC/n5WGc=
X-Proofpoint-GUID: TZFhzQHAarG1eEWY6wMXG1QHj2bD_EbF
X-Proofpoint-ORIG-GUID: TZFhzQHAarG1eEWY6wMXG1QHj2bD_EbF
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab8c69f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kv-CIVRGVCO3ybwTuYQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX3L2u+TIQvrH9
 kIUsXktAEJ3QCmTI4xiL3P5ikCiO+RAgNHmx7my1qx7P6dmz/sNSYLJC7CFbRUQUlultIJpQKys
 JkOYFjC0277RXL645jTSHn1UwSdaE/e4o8Xiyofo2du4863V2EsnZTSmbW7L9XFiB6bCkqiMN6R
 UD9QJyOVec2fnLyrCjy/zgrSYpHM0a8trR7ZG2zZaOm+Udy6TzK5InTwHXIOA1nSTdVbby8eSVi
 HJwYRXRD/tntwcKTnrJU25pxqFLLb/vCAusAeQsrfexOPnnOs6un5ND6ilART5KmBSA8mZ8rh1e
 SmKXelOTWiMA/j/PUgHsR9MYN6F3ZcKr5X516q0a6Ip6rNdUTRyhNUocnJwR9YnzmmGKAuNuQbh
 WRmEPGit/xMsyKk5PFi83WHxDnYTy4ayOjPyd7zUkGCIFbu6J1sa2iF4pSVEyAySop9FkXRWuJ+
 zBN7aMm7kopTpVRGErg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now we are able to link multiple targets together, we want to make sure
no build regression is introduced. For this, add a new unit test linking
compatible targets.

In addition, we check QOM types can be initialized, ensuring uniqueness
among all targets.

For now, supported targets are:
- arm-softmmu
- aarch64-softmmu
- microblaze-softmmu

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921204954.50529-3-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS                    |  1 +
 meson.build                    | 23 +++++++++++++++
 include/qemu/target-info-qom.h |  1 +
 target-info-qom.c              |  5 ++++
 tests/unit/test-multi-target.c | 53 ++++++++++++++++++++++++++++++++++
 tests/unit/meson.build         | 12 ++++++++
 6 files changed, 95 insertions(+)
 create mode 100644 tests/unit/test-multi-target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 026c11bd9b0..1b66c65f689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2146,6 +2146,7 @@ S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
 F: configs/targets/*.c
+F: tests/unit/test-multi-targets.c
 
 Xtensa Machines
 ---------------
diff --git a/meson.build b/meson.build
index cfac634cf13..cae1591cd28 100644
--- a/meson.build
+++ b/meson.build
@@ -4259,6 +4259,15 @@ if host_os == 'darwin'
 endif
 
 traceable = []
+multi_target_libs = []
+multi_target_deps = []
+multi_target_crates = []
+multi_target_supported_targets = [
+  'aarch64-softmmu',
+  'arm-softmmu',
+  'microblaze-softmmu',
+]
+
 emulators = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
@@ -4414,6 +4423,12 @@ foreach target : target_dirs
                  build_by_default: false)
 
   if target.endswith('-softmmu')
+    if target in multi_target_supported_targets
+      multi_target_libs += lib
+      multi_target_deps += arch_deps
+      multi_target_deps += target_stubs
+      multi_target_crates += main_rs
+    endif
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
@@ -4497,6 +4512,14 @@ endforeach
 
 # Other build targets
 
+multi_target_objects = []
+foreach lib: multi_target_libs
+  multi_target_objects += lib.extract_all_objects(recursive: true)
+endforeach
+
+multi_target_link_args = emulator_link_args
+multi_target_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
+
 if get_option('plugins')
   install_headers('include/plugins/qemu-plugin.h')
   if host_os == 'windows'
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..8b6e1ece969 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -26,5 +26,6 @@ typedef struct TargetInfoQomClass {
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
 void target_info_qom_set_target(void);
+void target_info_qom_set_target_info(const TargetInfo *ti);
 
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/target-info-qom.c b/target-info-qom.c
index 6965e4d1169..3ae1627b8fb 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -53,3 +53,8 @@ void target_info_qom_set_target(void)
 
     target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
 }
+
+void target_info_qom_set_target_info(const TargetInfo *ti)
+{
+    target_info_ptr = ti;
+}
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
new file mode 100644
index 00000000000..89b55bb1632
--- /dev/null
+++ b/tests/unit/test-multi-target.c
@@ -0,0 +1,53 @@
+/*
+ * Test for multiple targets
+ *
+ * Ensures targets compatible can be linked together.
+ * Also that each QOM type is unique among them and can be initialized.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Author:
+ *  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
+#include "qom/object.h"
+
+#ifdef CONFIG_SDL
+/*
+ * SDL insists on wrapping the main() function with its own implementation on
+ * some platforms; it does so via a macro that renames our main function, so
+ * <SDL.h> must be #included here even with no SDL code called from this file.
+ */
+#include <SDL.h>
+#endif
+
+/* stub for system/main.c */
+int (*qemu_main)(void);
+
+static void test_qom_types_are_unique(void)
+{
+    module_call_init(MODULE_INIT_TARGET_INFO);
+    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+    g_assert(targets);
+    const TargetInfo *first_ti = TARGET_INFO_CLASS(targets->data)->target_info;
+    target_info_qom_set_target_info(first_ti);
+
+    /* register all types */
+    module_call_init(MODULE_INIT_QOM);
+    /* trigger type_initialize for all types */
+    object_class_get_list("", false);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/multi-targets/qom-types-are-unique",
+                   test_qom_types_are_unique);
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index e47bc7225ab..d17435c1877 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -215,3 +215,15 @@ foreach test_name, extra: tests
        suite: ['unit'] +
               (slow_tests.has_key(test_name) ? ['slow'] : []))
 endforeach
+
+# Multi targets test
+if multi_target_objects != []
+  test('test-multi-target',
+       executable('test-multi-target',
+                  sources: [multi_target_crates, files('test-multi-target.c')],
+                  dependencies: multi_target_deps,
+                  objects: multi_target_objects,
+                  link_depends: [block_syms, qemu_syms],
+                  link_args: multi_target_link_args),
+       suite: ['unit'])
+endif
-- 
2.53.0


