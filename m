Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCF5C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98Sy-0003Bu-Pv; Tue, 22 Sep 2026 17:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98Sw-000376-UC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:55:54 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98St-0000uG-Vp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:55:54 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dce6e235so212521c88.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790114150; x=1790718950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=exZwZi6kUGYGpdAf583ubd0KYwWAqRs91Lhg3wPcRlQ=;
 b=SYfokA+929SbB+XxLm/CsLiCarVBt0rBzH1VI+JpLnfZOlVt2mH+5nUdfGCvvbHeL+
 oeibBoF8IbiT1/DsyGBbKplInFssB4M3mhHwHMxlZ1grnXBFvzMjg1Ys4XwtHx1EBj4B
 nb4gBBjA37wsnY/3gHa8ZCYZkh4KVodC7R4MRJxRoiEE2VFPD814me4oaOOzbv8axok1
 uxAGyaSxVSMiv4KwVH10HdSXDMdHVz24Ld2pZybT/z4R2ZkaAIjHagkwyE2MaSz0qS7C
 QkG9/tut+559Dt+vCn0KEAGh5zQF+hc2hBlvQoytKCOFlIn/WjsJ4rp100U5F56M5HLs
 WHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114150; x=1790718950;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=exZwZi6kUGYGpdAf583ubd0KYwWAqRs91Lhg3wPcRlQ=;
 b=VckSh9PBBiFOmo8rmdSX+Xpc6tvFcfTwDnmw4D5xWqaMvMP5ZpKshotWAvozwcIvlT
 9M9tpE1kBMWNnAhPuzWtWDGGxxAmdCDhswVutjnUxk7Xi3awDaqf7ivX3zEM1uvZDGq9
 XWC7/urznAcOYkia667FqCcSPzeyHgMy4lQWUJx8f0nleT30ewM0MQ9h7Dqb8zZRyEaD
 97igITFbWrbY1lCtEt+deAC7ENBdvR8++c1mENtfH7Dn6b5VOIR7VnE7PQK+JDG/CcCh
 Q5lGySeoaBHsiUFZTys8pU1VMI2X/TA8WfQ4ZKtuRG1mjO2WEn9O0qz92D3fPNLyDRup
 vcyA==
X-Gm-Message-State: AFuF++nzi5Ql1rlBzA9vIPzFL2q6ndpSbRaWCZNboHqAB0Kc0tArDPb5
 Z6mj8hRDhE8/bvrqdOA45Kfn8zAXxLWvfhobC/80n4H05iiZlTS5BTHRL7UcQlDR1b4=
X-Gm-Gg: AYBFou2JYSj2udm5fZ8i7heSfD8rutPDhMN+qqUjHT5LtJ+obkd+I+uYQsoyDUAZRvq
 Wf0u+EnPL59QynhKooTYGgMnTrreJgL0WZCK7PFQTGMkkFhHB7yu5/YtL2dzTIJpTZ/rD4t9TWf
 qCmqImmXH7X3qU84TzLU683BUW9DPXJ8yqocYK44Crxzy7aQXJex5F5yZvEKBZL3NonbMP462Q8
 N2Fiw6Ej8h0JKZ/PqX3kYhKH/TN5/mhDlY3wYdUEPpMLTIkX/hIMzn5j2++kYHaMw3onhp30Mf3
 bP8SF4VDJTggXVD6B28wtyGlycPuEwmThrhBU4DOXARuQr0s0WVwmdEFgfi5VMzRPBoG+RR8hSO
 eIK3w3oymf+qQ8cDheKGnSwMAFnSl4doI1uwDje9Sf/Avcrz0zZ7ODZe3Put3HBYUci1Onbs5ih
 6aalar57hbWpfxcb8RNX6S37+rzTAGYnBsi6JeMyMaHF8GiRzsdQFshfIMxdBXDHkYQXJhcm/1i
 w31lc5GvMAtY9Px/hbxcN1XYoSKLORNSX7i/hzwow==
X-Received: by 2002:a05:7022:3a08:b0:143:26f8:57e8 with SMTP id
 a92af1059eb24-144f9193eebmr885797c88.35.1790114150311; 
 Tue, 22 Sep 2026 14:55:50 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144f949e60dsm1001153c88.2.2026.09.22.14.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:55:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Markus Armbruster <armbru@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 1/9] machine: allow -M name to differ from QOM type
Date: Wed, 23 Sep 2026 05:55:24 +0800
Message-ID: <20260922215533.641-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260922215533.641-1-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine.c        |  6 ++++++
 include/hw/core/boards.h | 12 +++++++++++-
 system/vl.c              |  8 +++-----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 92f7be52a13..6b933f2302d 100644
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
index 3b86724cf00..851140ad052 100644
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
index 468a9fc247a..0d52c5d0a46 100644
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


