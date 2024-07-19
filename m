Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVP-00041Q-OK; Fri, 19 Jul 2024 13:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3c5SaZggKCkI0lirhvmoksskpi.gsquiqy-hiziprsrkry.svk@flex--whendrik.bounces.google.com>)
 id 1sUqUK-0002XA-SC
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:45 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3c5SaZggKCkI0lirhvmoksskpi.gsquiqy-hiziprsrkry.svk@flex--whendrik.bounces.google.com>)
 id 1sUqUI-0004Ho-53
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:44 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso829269f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406579; x=1722011379; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ZW/1TRXl7m0ZA5No/Rpuot8W2YBPnMu73Yf0ZI7truY=;
 b=vx1xH4s+/e763oZxceJNjjAhJP6s3jr0NWhDx8Ssw3kMQTaQQ69uiPRfFeSBV3AxHb
 n/N3JECNa5Wii6ASBng9XQ8TID9jCOGWWysKIUTzx3sTlIrJqlh4rHZ89FZ8yFXlWNk1
 u8Ww032RCTXfYYnVQ7sd8AkhuN6kgsvgQL+u5XRcyCrN/w5AO9YqjZHQt8nQsFhmCXau
 VQG7qOqAH4FWCCgGCSVN94ZtBDvD/MPAs5Wfv02/9/7grcYmIJZCOi2bLhTinw+eNYIi
 r+IjBgPwPqH+BuqLdKiY7V31S3UxfnWSukydi/ZHfZa/Me3wQDBDzG4d4Z2xbh7hVkp5
 JsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406579; x=1722011379;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZW/1TRXl7m0ZA5No/Rpuot8W2YBPnMu73Yf0ZI7truY=;
 b=Dw+sya2Hb0Rle3nGbXZszRP1XiibbFkgEacqyZcDTC/pAZwL8I9X+BxTPhMVsDQA6b
 4YuMIh18jKymMZyrMDnsasf4XNUmqxOpp7Oagxhy31snJHKUgn0XAVDrVt+pt7HOGn65
 R4iA/04UHNSsaO4UJaP0rhy75jVJ5hY46DZmdiIk8MaTeno3zCz4jj2dIGTygrtAA7TX
 4qLup6qnL7XodvlPM7ZnvjLRra0aLdeSGzjyQgnLXpaDpYM7V74MDqDR3+VL13c8eL0O
 Oors2s/iDJrgbsRL6GDIkeIgBWynjhKgoQjQIlPg6/n6fzBkbAhaAoC3drf1NKhOfbUh
 F9ew==
X-Gm-Message-State: AOJu0YxhGwQmtUAAKiNAZRX/FH7OXkyHcL39Mlra1Zd39t9sXkuPxFrN
 lEG812r10J6Eiw/IbUQptRFPWO3Tghq9QooN48qgZsmWqVf5fYQqdEGV5hlXb9URWz/2egWXhL/
 Kn63vPGgp177VXdWFTcnAE3oatj3P0mFCLL2/mmmfYvkfb2YCKtmr53+ZAjA1IlilH/jiwBeqys
 aknLJUvhCj2Kmid812anpwmDDuSHTXqaeb2lJnIDhqNw==
X-Google-Smtp-Source: AGHT+IGQ7kObEYSbIaHxjCqWvS9YyvimJB1dV3hKVxmB/fVqBU15KuvEC7QzOnmZ8mE7sUg7x7vCGjCyjODQ/g==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a5d:6942:0:b0:367:4e17:3ec6 with SMTP id
 ffacd0b85a97d-369b674fe1cmr195f8f.2.1721406579302; 
 Fri, 19 Jul 2024 09:29:39 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:22 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-3-whendrik@google.com>
Subject: [PATCH v1 2/9] Add state for RDT device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3c5SaZggKCkI0lirhvmoksskpi.gsquiqy-hiziprsrkry.svk@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:48 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Add structures and variables needed to emulate Intel RDT, including
module-internal sturctures and state in ArchCPU. No functionality yet.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c     | 33 +++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 0a5e95606b..cf246ab835 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -7,12 +7,44 @@
 #include "target/i386/cpu.h"
 #include "hw/isa/isa.h"
=20
+/* Max counts for allocation masks or CBMs. In other words, the size of re=
spective MSRs*/
+#define MAX_L3_MASK_COUNT      128
+#define MAX_L2_MASK_COUNT      48
+#define MAX_MBA_THRTL_COUNT    31
+
 #define TYPE_RDT "rdt"
+#define RDT_NUM_RMID_PROP "rmids"
=20
 OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
=20
+struct RDTMonitor {
+    uint64_t count_local;
+    uint64_t count_remote;
+    uint64_t count_l3;
+};
+
+struct RDTAllocation {
+    uint32_t active_cos;
+};
+
+struct RDTStateInstance {
+    uint32_t active_rmid;
+    GArray *monitors;
+
+    RDTState *rdtstate;
+};
+
 struct RDTState {
     ISADevice parent;
+
+    uint32_t rmids;
+
+    GArray *rdtInstances;
+    GArray *allocations;
+
+    uint32_t msr_L3_ia32_mask_n[MAX_L3_MASK_COUNT];
+    uint32_t msr_L2_ia32_mask_n[MAX_L2_MASK_COUNT];
+    uint32_t ia32_L2_qos_ext_bw_thrtl_n[MAX_MBA_THRTL_COUNT];
 };
=20
 struct RDTStateClass { };
@@ -20,6 +52,7 @@ struct RDTStateClass { };
 OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
=20
 static Property rdt_properties[] =3D {
+    DEFINE_PROP_UINT32(RDT_NUM_RMID_PROP, RDTState, rmids, 256),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1e121acef5..bd0bbb75f2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1987,6 +1987,8 @@ typedef struct CPUArchState {
=20
 struct kvm_msrs;
=20
+struct RDTState;
+struct rdtStateInstance;
 /**
  * X86CPU:
  * @env: #CPUX86State
@@ -2143,6 +2145,9 @@ struct ArchCPU {
     struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
     Notifier machine_done;
=20
+    /* Help the RDT MSRs find the RDT device */
+    struct RDTStateInstance *rdt;
+
     struct kvm_msrs *kvm_msr_buf;
=20
     int32_t node_id; /* NUMA node this CPU belongs to */
--=20
2.45.2.1089.g2a221341d9-goog


