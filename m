Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4D3C982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M83-0006ck-VU; Thu, 17 Sep 2026 20:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M81-0006cI-Lh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:06:57 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M80-0004rW-2n
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:06:57 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-8748f34b1f2so220634b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690014; x=1790294814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qhnt2dJkpAm5GGzTe4QbVNjnCDc43sqrIBCwyZpio2Y=;
 b=lBWvr1Nu8rtsaBvfJryI5Cak1knOPQm+5tecJHcRtcjhsQljc7l+vcPE6hcq7ZpZSK
 j/mC16lj/cLQSp+MRy55Py96EPods82LlTAhZCVMTa3hoyV4fpIAA+1HH8HNkWptT5Lj
 eNnFxJD6YoDHrUEdNYtHkKh6210EmaV0atEUHO1//o4NKX7Wokvf4f8kaqjvN08ANlcY
 1hn3y/+rjUgTjQiiOKce8jREtepNHEK+1dvxLgOPtxJPASKWOeqCU5IRZVVngaLa5sDE
 0GgO2n59Cln4/LsT+LdmLdxevHIYDJDkODa0hCcWKW6ZixoAYcKBo4wvVCDYW8miD4Op
 kv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690014; x=1790294814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qhnt2dJkpAm5GGzTe4QbVNjnCDc43sqrIBCwyZpio2Y=;
 b=o/qBE7K/fjHMkp9LISWtD9UfnqKMrxPyZkopH6P76cKY2Rr45NgS+QX4vWOISZ3mZo
 0uIMVXRJ1Ho5itGo5G2ms05YYTZiRPU8MY2ld3ZXi8jHxcCtLfaev8Fax1EDT+bMacaW
 d4nv+I4r6pXABCpaitaL1LE3eFf+WN6EQMMLFsvB13ceonF3914OPe3eJvKLtY3P5Rmx
 utcN+pbnZza3wgvOTFpD3xg6attdV4cGrnvL5RUFpY8zcVUhjY+rAXfH8OEtlMtIGcWm
 4RmpaHKAgwgzlkZGiHVJHA8Ma1xy9w95eIrGwxdlMEYaS8AQsNxtPy/uAz03FYJ48J8W
 ZGOA==
X-Gm-Message-State: AFuF++ldQXB+7ZplFPOemUaL1RLNVq+s5KC5BFU+168JFKAUXd1mhcXx
 kCZKxPjTdeYHHyyLF8QBvhoRnYpyi7Z1nmLgYDVKhSE8XHF22cKL38uMycqqCXtTLcI=
X-Gm-Gg: AYBFou2c4fMVdUkI/xq1dNmVPHI2J/JSeW7kHnQlEqBKtnidNK0uDq3ZR7GLfTk+K9f
 cWXODY+mCNpK/W/qB3I2Xgk49PxDHnIwBN3tBa9L2z1hv/J1JVKXOFmS0mAmGrW+PKNxPUfG9jI
 i3oyAOMmKmizVAqngYwmSIJJ6BZDIuLQFXoFdnIfTgk9W9vzvxxra4Onz26qMjGBg10Hjsw+WVl
 kUyWIS99yWus4OdU1Mdfnd27v/wmMf0pvWo12BZh84KhevqDCvLJQbMcscHYwGOAfaQMTzui/bp
 9PW2jEokGzotkSLkfuPnb8diT1ZQiNEOkodzVYVVA0yt2JyY+BPusJ4J5+ryDiiP0FeWTsFlsqX
 PABQ1/8tiSuuq44+lth9DkBKJ4nDxOEJBuDF1d26d3bFx+P9AZO0rQQqIkq5IjSiaMHu+nemPMF
 ZMK7Sb8DkijGL6Q1RL3DlD4CaAMvWw7upHBCg+PK1E2K8lgKfI5+VKBq3GVY7iPeLRqhlkkLiEK
 fL84VJPg96BmEnd4w9ARvXw9jf7j8XU
X-Received: by 2002:a05:6a21:596:b0:3d1:deec:9265 with SMTP id
 adf61e73a8af0-3dd8c3f2321mr1152234637.6.1789690014513; 
 Thu, 17 Sep 2026 17:06:54 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm20328212eec.28.2026.09.17.17.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:06:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/8] machine: allow -M name to differ from QOM type
Date: Fri, 18 Sep 2026 08:06:32 +0800
Message-ID: <20260918000640.1001-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918000640.1001-1-luoyonggang@gmail.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Add machine_class_set_name() so boards can keep a stable -M name
  when the QOM type is uniquified. machine_class_base_init still
  defaults the name to the QOM type without -machine.
- Document that MachineClass::name is the -M name, not the QOM type.
- Sort -M help by MachineClass::name so order matches the printed names
  when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/core/machine.c        |  6 ++++++
 include/hw/core/boards.h | 12 +++++++++++-
 system/vl.c              |  8 +++-----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8939ae16666..3cca243c3cb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1215,6 +1215,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
         "Memory size configuration");
 }
 
+void machine_class_set_name(MachineClass *mc, const char *name)
+{
+    g_free(mc->name);
+    mc->name = g_strdup(name);
+}
+
 static void machine_class_base_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index dba465efc2c..d397ffb3c2c 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -36,6 +36,16 @@ const char *machine_default_cpu_type(const MachineState *ms);
  * @mc: Machine class
  */
 const char *machine_class_default_cpu_type(MachineClass *mc);
+/**
+ * machine_class_set_name: Set the -M name when it differs from the QOM type
+ * @mc: Machine class
+ * @name: Name used by -M lookup, help, and migration
+ *
+ * machine_class_base_init sets MachineClass::name from the QOM type with
+ * the -machine suffix removed. Call this from board class_init when the
+ * CLI name must stay stable after the QOM type is uniquified.
+ */
+void machine_class_set_name(MachineClass *mc, const char *name);
 
 void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
@@ -269,7 +279,7 @@ struct MachineClass {
     /*< public >*/
 
     const char *family; /* NULL iff @name identifies a standalone machtype */
-    char *name;
+    char *name; /* -M name; default is QOM type without -machine */
     const char *alias;
     const char *desc;
     const char *deprecation_reason;
diff --git a/system/vl.c b/system/vl.c
index 9bd7664b85c..456b3a8e10d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1538,10 +1538,9 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
     if (mc1->family == NULL) {
         if (mc2->family == NULL) {
             /* Compare standalone machine types against each other; they sort
-             * in increasing order.
+             * in increasing order by the name shown in -M help.
              */
-            return strcmp(object_class_get_name(OBJECT_CLASS(mc1)),
-                          object_class_get_name(OBJECT_CLASS(mc2)));
+            return strcmp(mc1->name, mc2->name);
         }
 
         /* Standalone machine types sort after families. */
@@ -1560,8 +1559,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
     }
 
     /* Within the same family, machine types sort in decreasing order. */
-    return strcmp(object_class_get_name(OBJECT_CLASS(mc2)),
-                  object_class_get_name(OBJECT_CLASS(mc1)));
+    return strcmp(mc2->name, mc1->name);
 }
 
 static void machine_help_func(const QDict *qdict)
-- 
2.52.0.windows.1


