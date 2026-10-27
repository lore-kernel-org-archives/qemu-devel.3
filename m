Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PMfWEsr0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf7L-0003EX-JU; Tue, 27 Oct 2026 07:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7J-0003Cg-VB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:21 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7G-0002vR-Uq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:21 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so1384436c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099597; x=1793704397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=65RqURJMvc+L/nAMQdvkbZXrbEP0r76RON8s7SLwv20=;
 b=PMfWEsr0ev6OO6V6c5m4gQIipXA5zMSMD6vat3JdrkNzbcVGWFscxk9XHXEfGw6SSJ
 syNrqXBeXjCv6zIvnlyefsALpK3s7L8veoJzH5CTIkNpWi4lKTxbp98SDJRtor2jOG2A
 tAE92OnL8oiIkqPTizUrT5s9OQwu02tTJRG6SiA6thIf6IJfsVoGcbF2azE5tLS3YoKW
 G1l4vbFMau9aJ899B0VsD/1Ex2erjA7VMLoPXaa/SsHi/7IEhN2T7HPYhPfQxeJTaSKx
 9lGrMTFGamfPynwJzGqCJ97qk5i5dsvvMSlrt9bBvhEdbSrcKq4OgpzjXjcqpXqiaoyT
 hHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099597; x=1793704397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=65RqURJMvc+L/nAMQdvkbZXrbEP0r76RON8s7SLwv20=;
 b=OWnV6sD2E8JITE8J2vROlF58qswUy1yGQInHiSK2TtZBgmRxfHyszKrCfgPz7pyzZq
 lHDEKL+8vti4f3SCOSC/sCLdADupNaZRoY/O7m8YL13r8zQ3vCi1xgt1szaYLHbd2uCt
 /0bg2uEJTDbQhFy8It3SyqJvwdvBatj7EkLtp3CxFOVWc3fHewaw3t8NLSLzatKAuuUy
 fdd8GXRzSO2HFmSHD+10wq3Z5SBKbgUjIAs6XvfUT+WpqBw+X+jtfYASZA3QilSBB4/s
 ZiEOuOE9dTrARoNLVR+kRGzS0OZ0pN0RLAyvNft+BYBi6R4kBh0b5QfWwkZ/E8Jp8CgH
 f3kg==
X-Gm-Message-State: AFq9FYLTBVy5tBYHdtiTyyOthHo9kPRp4K1YFkGZ59Kykq5st/DvSpO6
 knocAJ1ViU6IsXl4YNDKgK6bQVXwU768+j5qpF4l4Ectk3ACRojeWLoS9lak1h3N
X-Gm-Gg: AYBFou0Iw04xZEl9EnbdAxjJ38f9j8e2X885Z2r47nt3nVBCeTrXGSoUpiPsB1mBFXv
 tQa1D3P/2MOPvVsXAkVslTTt3I00btdcNvhkvH4TOnQho0b+HXHhl3qKBpyTRcVvBuT+jeq20Eb
 MUnpBLiUOdB5krHelku/IiNyJ0E/8t8bqjo4bShbeXAfvp3XMezS0UYRtl/dQBkrJtonLOhtI03
 AxDxC7gok83U/e1m3fHRS3chGnGkmN7yQz583iakTb5uCSafgyeMmeIqHmxLQZB/QSL4rCA2d0M
 PMfJfoFvZ77sE5DJkcu27c2cTU7jjfYwPF7LGVf4p98FsHDViLALUCompDQ5WlHgy2wKbFidL3O
 trpilIDPV1tjihOWyU7oyw37Ki6j8kUaTgChTJ+5pO/eiFGCK7AX/kLnxHcjaMuuSq/XNHGh33G
 XoO/wEfVrsKA5bxjL1ki8xufBfhZxjrp+A0gjO0lrwt736kSwxcUl43YE34NfwwPhMzIifGOJzg
 s+4i9j190n7D4wB9zc8GPgPEsPL5WHKWHVrX02S7hhG2v2tWTi23aaaqEHdxRe3AJjLOEEYVA+n
 1LMfcP8WwJJT9I4f1YlPXuXfl5YtmmszWoF3KH86ywMlXNU5ypFvQLeU0+TcbA==
X-Received: by 2002:a05:701b:42cd:10b0:190:af51:d56c with SMTP id
 a92af1059eb24-19936d40791mr14230975c88.31.1793099597243; 
 Tue, 27 Oct 2026 04:13:17 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:16 -0700 (PDT)
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
Subject: [PATCH v4 08/17] machine: allow -M name to differ from QOM type
Date: Tue, 27 Oct 2026 19:12:06 +0800
Message-ID: <20261027111216.392-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122f.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index d9ac4b419a3..9c897cddbd6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1219,6 +1219,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
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
index d0e4ad98201..db2d0137fc1 100644
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


