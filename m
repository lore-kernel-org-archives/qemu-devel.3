Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D2AC5DF9A
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9nk-0007Q0-Ic; Sun, 23 Aug 2026 11:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9nj-0007PG-7R
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:07:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9ng-0008Gj-C2
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:07:58 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2821685a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497675; x=1788102475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IukQGcRHMsVbGXSG1mzI1R3dLtKOyYm2L7shctiJxkE=;
 b=buZO2k8g1g8cot/lybL9HqL7zbANnNDCB4c3EQT9FRSCeJbW5yD3Ip7jv0mIi3JwOS
 XgtMIz/g0y4JRhjGwKdf/CVG1RUUr3fEmd9+f4ZJJ1bmzByHWUFmgo0p3v3oZUBh8hbc
 xZVBUR0xuJblqNvTAYgDQIuPQcyKmqT0pzldzBarEXWzXfRwv2aOLBY1h09aM+JTdQTM
 xEdLEVnwFu+28dt1qiUUnbWXnwLV/FvxgF7zEKoN6J1ktJ6hPmzNtPaIKaeiX1/OGSwg
 /gBKQ7mb0yLZPieQnkyxCuQwOG5I7u9ATXey+nRJqgdkRVujj9DmLo3gGao1ov9ofGH+
 qRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497675; x=1788102475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IukQGcRHMsVbGXSG1mzI1R3dLtKOyYm2L7shctiJxkE=;
 b=OrvYuWfbtRrr7fn9zmmntOqQptBmdOBThO6E++g/ZTf6j6BTiFJLZo8jjNpb5RUxP9
 bpkXMefqbED2oo8B312u7r+9twRwQ40Ka3gcMgGpNyfR7BSo6LLZNSClc+5vQjioY5Tn
 nTTWj6ET+lWuD0i5xKvh2tQCGYHP+Qzp/+0aRqzA9K5jcDoOfjqhOor49UpdCWnVppDd
 HpetllitT/xOmiQRBVKghY8c1ZKkjRxuQQdNWRslbDFDvPFQnBWkjd7GntP348V9GZ1A
 asLBcZUykeXG/SnkX4eRv2an09tJTDDC9SfA2cmF82wm34ka5uz1Bl0Zm4aeWBxct031
 COjw==
X-Gm-Message-State: AFuF++msX0Ca+wzKp6TmhRdpYE+WYq2ZoBdwjZKNl5ABlMKxRG3JaS4U
 Lz5wNxWcBKZAX+j4aRqCWKVW6MkNL1WZhYa9WFK1br4eEILGSbSGW6spDwCz6on6Wfc=
X-Gm-Gg: AR+sD11bzvi/xT381pqUc4mUG75vTaN7KGr8tgCYIqgJj5OxGktMiQyWFySTnfEmUPH
 ZoV9YE1wBZ00fFwGgguAqfewoaa+RM65LVc82j+aii+jz/ISse2Jbk+rE9rujqMvfmqcPVwCSn1
 rqSvo6eMhqRySRC3vSlrniQhhdk2pxSfV/snkdTocw0+DvTgw52F0jLB+YJxI5JbnxwZXg1vYHK
 NiLD2BAsWp4IsQ7YX9J9Y+hSKRgnXTW5slrupQ3yLpWhpB4VSckLiuyb4D78xyTNOIrSvLE3z7l
 zz+kVfkE6WZeLF/kLwAJwlMgfAgBH68Qt3ssQVvMmiflAKw1qQ2jjukXx3ygIW5XsoR5xi1k1AI
 jgq+v0QhkIgu1gQC4CSEBDZdAI4o1FyvlKFh2DRFflDq01H0YsxfhJH9e4tK/8AAGrnJmDkDsIp
 oXf8JHrqt5NLT5CY9Un2SYDxLQr1ndHidTxdzpBrASxlPWHrmXb+qJvI7HyYVit9ms8XEmlpakT
 vsj4CmohK0crMcmY2Qy8A==
X-Received: by 2002:a17:90b:4484:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-395c3552988mr30259195a91.14.1787497674881; 
 Sun, 23 Aug 2026 08:07:54 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:07:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 01/12] accel: use a shared TYPE_ACCEL_CPU parent
Date: Sun, 23 Aug 2026 23:07:19 +0800
Message-ID: <20260823150731.896-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260823150731.896-1-luoyonggang@gmail.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1030.google.com
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

- TYPE_ACCEL_CPU was "accel-" CPU_RESOLVING_TYPE, so each arch compiled
  a different parent (accel-arm-cpu, accel-riscv-cpu, ...). Common code
  registered only one of those names from target_cpu_type() at
  MODULE_INIT_QOM.
- A combined binary still registers every linked AccelCPU subclass.
  RISC-V tcg-accel-riscv-cpu has parent accel-riscv-cpu even when the
  selected target is ARM, so the old one-parent type_init does not
  cover the other family. Creating the parent in the subclass
  register path would hide that, but it keeps per-arch parents that
  AccelCPUClass does not need.
- AccelCPUClass is arch-independent. The parent only supplies
  class_size and ACCEL_CPU_CLASS(). Make TYPE_ACCEL_CPU the fixed
  abstract type accel-cpu and register it once next to TYPE_ACCEL.
- Leaf names still encode the CPU type so accel_init_cpu_interfaces()
  can look up "<accel>-accel-" CPU_RESOLVING_TYPE (for example
  tcg-accel-arm-cpu). ACCEL_CPU_NAME() keeps that string; it is no
  longer derived from the parent type name.
- Drop register_accel_target_type(). Subclasses keep
  type_register_static() with .parent = TYPE_ACCEL_CPU.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/accel-common.c             | 21 ++++++---------------
 include/accel/accel-cpu-target.h |  3 +--
 include/accel/accel-cpu.h        |  2 ++
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f0..c4c365f38c7 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -126,21 +126,12 @@ static const TypeInfo accel_types[] = {
         .instance_size  = sizeof(AccelState),
         .abstract       = true,
     },
+    {
+        .name           = TYPE_ACCEL_CPU,
+        .parent         = TYPE_OBJECT,
+        .abstract       = true,
+        .class_size     = sizeof(AccelCPUClass),
+    },
 };
 
 DEFINE_TYPES(accel_types)
-
-static void register_accel_target_type(void)
-{
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
-    const TypeInfo accel_cpu_type = {
-        .name = name,
-        .parent = TYPE_OBJECT,
-        .abstract = true,
-        .class_size = sizeof(AccelCPUClass),
-    };
-
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_target_type);
diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 6feb344e29b..cf33ebd79fc 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -24,8 +24,7 @@
 #include "accel/accel-cpu.h"
 #include "cpu.h"
 
-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
+#define ACCEL_CPU_NAME(name) (name "-accel-" CPU_RESOLVING_TYPE)
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
 
 #endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..5cfc2b24223 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -12,6 +12,8 @@
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 
+#define TYPE_ACCEL_CPU "accel-cpu"
+
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-- 
2.52.0.windows.1


