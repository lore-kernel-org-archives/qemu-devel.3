Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA145C98335
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANZt-00084N-Ne; Sat, 26 Sep 2026 04:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANZs-00083b-1H
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:12 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANZp-0006mq-2D
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:11 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-34182b58c7eso1241553eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410567; x=1791015367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=exZwZi6kUGYGpdAf583ubd0KYwWAqRs91Lhg3wPcRlQ=;
 b=K61czQywXx8jWhWILNe+WgP2lub2PudojG/E7eyKCN3p5qFHHcViEerSLUD5BtB/lL
 c+YwFg4PJH5+hiE43WPR2/97bPSj9YIgAkIycCFd87CGAMnRLCosHNn6XdhnvDxuH0aN
 CfUKDenajkA3QoLAPa7nhALxIxudS8XdvAferE7tSXWEe+vKWUKpYa/0cv7TJT5kpck9
 GeyRLuGz4UiiE+mo4l0VNUUyho9cgg+naRWUkt/51rFQBsEdTzAnM8XrpfxRUaTnE7Zv
 J2HPJf9Yv3Yu5m+DOfdBDQF4I1d/cwk1nFDyMOKa8ULPtcNmB0SAuuNNbJ5s8PzJ7cuB
 F7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410567; x=1791015367;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=exZwZi6kUGYGpdAf583ubd0KYwWAqRs91Lhg3wPcRlQ=;
 b=F9V6VPdK/2Qd3Gbiuyu347XP2kS6Zh9wUWe2mg8ZDuHzDCrJ4bWtlzzwxP8cscUYQv
 v11gPMRPIwL17U5qGX/KxdSIARWkjQJ99peIo/wo9NzO2tklMv1yNz8Rt0wqQOqqcLDl
 irlZdWA59uhQ9GzfaaTTsytqOTz8UX+YFz4FZFWXuUxL0N4y2OpcjB9qcBhwPf7aiUva
 LVNfFXJPJJMJF+7jmazP3O7K7t0CIgbxhnZX/+TnF+Bj5ELgolCtp2Wji/xCI1ph+wBH
 Yrc/h3Lmm5R32IAddN0dTyGs10End1LesjaNn5hhOE/SCoSQZzaT/zK3wKBHJPNqpqM3
 Gj2A==
X-Gm-Message-State: AFuF++mTmFsiVmXbporYxXXocQgvBOMUnpTYZmGgVyDAJ9WqfJb26n87
 SDGauNAZKyxz1iPI4Yi04m0J1UFWHqZV1RcSRVwGqMjDMrefRrDEp5GVVyryQKtl
X-Gm-Gg: AYBFou3kt37izIgOysoUEJBHGFnpXmq7hzHaWNo7B/Sd36xJaCDJIbbzFergKY39nFi
 qCIsuB3pjh0M5TR747rNAg2YhrRQf+emu14X6MPDyTJxLzvHFQLVDn3UDXOuKLWlLPqVp5wgIbO
 hI8/ZykKU49lYbdhDgK8mgtbZWNaDM3wrvmFwpMth/OhUNq8CrmwrGEJUsjKQfQdAgbdLh+n9IO
 Hcy3Wn76YmG2PY6TxYqIu+j2Wb5Hfc+BB9nnZttaIKbkp0X97S/XnbC2QJrvw4pj296rk/FhUp9
 nfshOiw++HHSBS4RM9CCBCtRhsUWZzuwRRxxp1O2Vd/ZgcGC1fYlgkSagEmoWhhT7L0DBXQlc18
 Ewg9wGKsizUSEEOSTwvpei7t4fDSynQmP0UN3C7azO23j8GIVic43i1qnZFpKoA6WNiYjGwkVUs
 qdptIaFk5RM6scwSyNnAf7ln3k2DL4IMwyOFOIKBux4+S2mmJe98awN+IiFFFZrrobxGtjObBxa
 oqlALtPRAoPvuWqm9REqwnyslMPoovl
X-Received: by 2002:a05:7300:4728:b0:33c:e82:70c9 with SMTP id
 5a478bee46e88-34272c4f38amr1974119eec.32.1790410566579; 
 Sat, 26 Sep 2026 01:16:06 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:05 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
Date: Sat, 26 Sep 2026 16:15:41 +0800
Message-ID: <20260926081551.29-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
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


