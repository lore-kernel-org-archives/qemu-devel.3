Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E39BC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kxr-0005ub-S1; Mon, 21 Sep 2026 16:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8kxi-0005qX-VJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:50:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8kxg-00025Z-EU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:50:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKf2qK2546651
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 20:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lB6Qm4no18l
 6gfbNW6QXiJW1644NvQW57Yxf2lJBiSo=; b=jPPrn6bQQvJ1rUlMwWp9oRTW62N
 He0IZnAq8st7GFFai4Da5ePVwbXFlBYZAvh51IO5jbyszmklyVDcpAlyzKPJfmp8
 2rVIlcYz2W+zdbeeVk1VXVddV4xIdRBut79yDYF74UgoksBBrBThLgigXUYNxzeM
 p5GSbIUzH+dZ/d3qHUJa5cYCSWETizWSq64cNAsiubi9adB1a9e9mafkbfjBCwQx
 8dzb/WrQUmjOvXmyBs9d1yVbCR9R7+2ziY6V4ziEubo2OVnKiSAiL60ksdvt3reF
 jBrtYBpVNxGAsiMIkp38niUV+I029Rd2dCHz/1YtWdQdvSt8QKbB12X7R3g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu011bbcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 20:50:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-85602449126so6966108b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790023802; x=1790628602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lB6Qm4no18l6gfbNW6QXiJW1644NvQW57Yxf2lJBiSo=;
 b=WuDq1/0lYHMXJfqqzVZRGZmQMfM+vDoOB+0GNmqCkMada8gyijVGRcE9/f6sGFirCg
 PdJQc8SSUj/ayCEO+zzQNAtKUZZZS9dDCGh4hR/aF+PrPCiQU7cF4hK9TJ0nE8GLO4Ex
 IT/TV1ctDcmO3sciTOqcZBzP9aJL6kLXqG2bLc6C43k+serp0rTgBLwmCRkOARrmBTEr
 Vb6Vp0FdBkwjExfD3hE/bunnhotmc0JB2Fbw52g90VFpY4riLpPpVOZJH6/EtfV1neVM
 7QQ/RM1PYug0rnEZ6Ge/hLt1vpT+kZp/KCSDFbAwBZXjSt8BeGOLc8dVMIYXZllj61Nd
 /0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023802; x=1790628602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lB6Qm4no18l6gfbNW6QXiJW1644NvQW57Yxf2lJBiSo=;
 b=ZI4fGc8fbSV6rCgvQNOrHeK60+XQAxT43psxfzcvKMQJJQ2iXA/v0l+VRB4wcBhMrm
 Cb/cHAJ8zNllqf8+uqOY7MMtcrumETRmi54S8KH/KyIF+3Z+djx/eAtz3NgXMaIA6Kgx
 omrY7xeUcMJ22l68IxzwceabHnzBz9sAijdR5TKF3WAIXKofrl3OzZu1vH3kWgEEwt0u
 VdGRmp+KKvl+/U1nVmvO6b9bBfA7or56N03Arl/uuwyELzSd3/cdeiO0K8g91JKYVV/p
 cnAVyhcYWcv3kt+GE7EOAxcfrIfaQ57vqnECd0wMgFSZs6uPvNlBYWg5LjiAecVlu6ga
 Znkw==
X-Gm-Message-State: AFuF++mh/jMoS9bFa17sWYepNedkf8jWtcfj6O5I72651VJEXJLzNkX0
 30fagIqFSD+phhA8yDOLwNOkk//zHLA7kVOhprZmhG2Lng9Qx2Wm+64h0Q8/pq5qS5bYbGMxv3p
 E2elQxVhiBdQesJJlnDfcFAtMMsJsG7Q8iUawPcKTNPc0cVUiFQJtP3qFis/o/GOh5w==
X-Gm-Gg: AYBFou0N7aVr5Vc7xcNBorBjkwIgu/YWWsJj2LO8jGmdgTyI3+Ev2zZAUf0u+JwNM5b
 8zqAyKOMXOwPkN71IODFVocRx9PWZPUJnFCdsz/Wi1FksYej5TA4NH9/40gs7+/3NspgnzPdMDg
 59ReCxVY191bu70uWfkeezPT9zcwnS6T+ge77gp4dT1Cqsh7OsP4bMQieNpW8DoDe7Kvw2iJCJL
 eeYJePc8JycN8rGRJ6uUPDX8JoBVF1rbKoRSTmZyds6rg+3H/3Q0eVjxZ4LKBkShwQUG8DnK9hl
 YpOos/GseGv7BQmHgxq3ATjvzU56BcraqmbybX65lrOtzOYB46o8fVWPMv02mt3t/CVPWRPrywg
 bnX82Qq2I7klOlTdI1RwTjmH5eTy2Azqzv9jDbuSRSIJHwQ3k5J5mptIki0XH+A==
X-Received: by 2002:a05:6a00:1c8d:b0:848:6f5c:a327 with SMTP id
 d2e1a72fcca58-874dcef0843mr16372586b3a.15.1790023801997; 
 Mon, 21 Sep 2026 13:50:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c8d:b0:848:6f5c:a327 with SMTP id
 d2e1a72fcca58-874dcef0843mr16372561b3a.15.1790023801407; 
 Mon, 21 Sep 2026 13:50:01 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87bf5781b4esm51692b3a.3.2026.09.21.13.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:50:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] target-info: add multi-target test binary
Date: Mon, 21 Sep 2026 20:49:54 +0000
Message-ID: <20260921204954.50529-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921204954.50529-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921204954.50529-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8BcpAwVLJkxfMPP8LxE3o2nLfFBPg91g
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab1987b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=vWpnfD-RLob1JoR1014A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMwNSBTYWx0ZWRfX1IVkhT/hNO2N
 /0OHaWXPDU2rr4v7MeV4121f6fwHmvEGKI9uju7GbSBXBKYMezqv/11rQFkSmez0bMtAZeU/Cv+
 lzj8V53X46IFSzG/jeWv16qz1lpO9I0Q7n2MZ4PhETkF04jhauVkF0HjVzPJktZBsNRNDsn/Nq8
 C3eEQ+UQr0bEn0NqayF1e4QBUjsJ3MxKh6xjK3BcIq/HRulUn88rmZTkvnKe0898YXpyAgBf7Vn
 fN+2Sa7/8gMwofFltTedHtKyaz+u5VdBUhgI9zF3Aw+DdP/hJxXjhZO6W11F5MXtwPwJv136Jcu
 /AThkghOCswh8fuTic3BRdn8qdQMLRI0ElBVXxyuQPsy6gwwAooIL4O+x3QErhgctr5TQEV95jR
 3bjQCffs9ZczUJ7THf+SFMLYfjgccIyVu/idnbGEiHuqRC3Ja6EXG0Oj1UpE5DZeMDfh7EtESsO
 nI924N2/sVeLzcf9V1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMwNSBTYWx0ZWRfXwLNTxSEk1X6g
 AFLqRNrEOxoHQFhLbCld3WJADaU8BrKXPtt7vVKGHeIq6IWp8K9Yu/IxoE9PxqU91UzrFIUSlMY
 d+ZEwnqCDCsbNLFTbhQw00N1QSgnlOg=
X-Proofpoint-ORIG-GUID: 8BcpAwVLJkxfMPP8LxE3o2nLfFBPg91g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210305
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
---
 MAINTAINERS                    |  1 +
 include/qemu/target-info-qom.h |  1 +
 meson.build                    | 23 +++++++++++++++
 target-info-qom.c              |  5 ++++
 tests/unit/meson.build         | 12 ++++++++
 tests/unit/test-multi-target.c | 53 ++++++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+)
 create mode 100644 tests/unit/test-multi-target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b9..62e048d1824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2146,6 +2146,7 @@ S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
 F: configs/targets/*.c
+F: tests/unit/test-multi-targets.c
 
 Xtensa Machines
 ---------------
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..8b6e1ece969 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -26,5 +26,6 @@ typedef struct TargetInfoQomClass {
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
 void target_info_qom_set_target(void);
+void target_info_qom_set_target_info(const TargetInfo *ti);
 
 #endif /* QEMU_TARGET_INFO_QOM_H */
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
-- 
2.43.0


