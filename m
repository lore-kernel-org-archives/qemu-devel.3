Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D74C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjURc-0003Lz-MU; Tue, 14 Jul 2026 00:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURL-0003L1-O1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:18 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wjURK-00083n-6h
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:08:15 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so4030561a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784002093; x=1784606893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hUM7re2qkWc3Qaxh6rwwu//Pra5PQRoI7yDTSwv9ehY=;
 b=hhUJ89hFU9Xa05+m4Ctwu46tWCDY4JTEUDwmX5PT1GHLXjUFWDLZ2U7cErxyx7nkpq
 ktrNQ2kfGgJ3fjkiK/+ZQMsUEXKYfH0xdDhaac9lzr7n0iZcYO3tMQ+fQxZ7RYvsA3nT
 JXD3uwQP7I3tWZp/lDKUQRfjaD3ikSIbPRCu5GMOQgsydarMy2fQu+DNtb0pBp05pIaV
 hThqJW+10wJgAyCjaPWXey6G0Q5g/b4uaSjYSKlLocs86W4nQQtQbos1Yt2s2s7cbRdL
 cCm+SPUAw4ZO5/9HyVf/kaZ2qee+mVbwOj16VQd9EuHXWdDO9aQav7O0+ff3fJTIu4LR
 TXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784002093; x=1784606893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hUM7re2qkWc3Qaxh6rwwu//Pra5PQRoI7yDTSwv9ehY=;
 b=mHMYXvbXjzJCkvXYWrmtbQqJYtAygqB1Qdp0VJZsm17MLmjmaUnf1YqPOBV9yof+Mq
 geKBmqVD3jLnh6VsDmg0/mk9F7aQhciTf1wWBNVA7BKn0y5nzfL5c+Hm2rbT4DpOxgr5
 mUPCMXZapgJuvusdTUO+v+oZymSoiXy6G1N4tVL3ht7dJchcCBDD6/dTZrxZS/LWV0fy
 kk5ItMLc5HQGaV429x2h9DE5GMAYSePtMRymes/z5dkRg115aUwJbw6kQruHvkYMl4J0
 qMLkLXWIk/N52U0f8xdcgEGjRUAzRWA0zJeHv0rKaIMwRuACkymGbfqnvH77amCFZ9el
 T8gg==
X-Gm-Message-State: AOJu0Ywd0T3VNsk1zAQZ60qiwTDdvTFCyPtj8TJWlPyLnY3T/4Hj3L9U
 v3/az0swlwry9BizaZJKSC309aZ5AkEFvJG8Sfiqoo/yaZJhGsysbzm4eFDbOg==
X-Gm-Gg: AfdE7clLZCyKGwGChrIW5r2Fh4imC3czLWBT7AuO64Wr5UsXfEi7dY5Y9B9RfGFpabC
 MlN55nMBbRbjiUglUS3Pdp2oJH3xHMX5WTAUgRIOci/boQYZi/Ap5dYuJOMdsZq1EricCRQyD3A
 zH5xxSkWfGu5AFLxSDgBNSqpjwMr1kCYkuNNJIFrk3jqBj42zOWstrpPNkdjoddJKCyPvT63BCV
 L4qT6dNuWGq7AtkyjOjP8UQfE7J3lVqPEaWHdQrcPUrJbF69Vb1SXAH5QODP0BYJYgdtahOMIrN
 dc5BaHD4/SpezZXu5MrYYhzGWh5A6yGsKOUlYH1Sh+vzyqYrYx7J+w79UkjTXydzlR1vYageGQz
 EUW+47JaEsNrL+7kLQlE1zDAFV/E3oOcFTJqnHa4isZSW3JcaBbfUfsm5KWrH3OuMt7cRtOOC3t
 jbtMX2gjbDRmeQNyAdJA0UCUXYrRmPpxfmYa8R9Kh73yYgJZzq44r0
X-Received: by 2002:a17:90b:5585:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-38dc777b895mr10962268a91.22.1784002092861; 
 Mon, 13 Jul 2026 21:08:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6cfbsm778840a91.3.2026.07.13.21.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 21:08:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Yanfeng Liu <yfliu2008@qq.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/4] uftrace: riscv privilege level
Date: Tue, 14 Jul 2026 14:07:56 +1000
Message-ID: <20260714040758.28332-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714040758.28332-1-alistair.francis@wdc.com>
References: <20260714040758.28332-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Yanfeng Liu <yfliu2008@qq.com>

This adds RiscV virtual user and supervisor privilege levels to
uftrace plugin to avoid crashing with H extension guests.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 contrib/plugins/uftrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 9b0a4963ae..063e32220b 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -109,6 +109,8 @@ typedef enum {
     RISCV64_SUPERVISOR,
     RISCV64_RESERVED,
     RISCV64_MACHINE,
+    RISCV64_VUSER,
+    RISCV64_VSUPERVISOR,
     RISCV64_PRIVILEGE_LEVEL_MAX,
 } Riscv64PrivilegeLevel;
 
@@ -153,8 +155,10 @@ static void uftrace_write_map(bool system_emulation)
     const char *path = "./uftrace.data/sid-0.map";
 
     if (system_emulation && access(path, F_OK) == 0) {
-        /* do not erase existing map in system emulation, as a custom one might
-         * already have been generated by uftrace_symbols.py */
+        /*
+         * do not erase existing map in system emulation, as a custom one might
+         * already have been generated by uftrace_symbols.py
+         */
         return;
     }
 
@@ -706,6 +710,8 @@ static const char *riscv64_get_privilege_level_name(uint8_t pl)
     case RISCV64_SUPERVISOR: return "Supervisor";
     case RISCV64_RESERVED: return "Unknown";
     case RISCV64_MACHINE: return "Machine";
+    case RISCV64_VUSER: return "VUser";
+    case RISCV64_VSUPERVISOR: return "VSupervisor";
     default:
         g_assert_not_reached();
     }
@@ -986,7 +992,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
+    qemu_plugin_register_atexit_cb(id, at_exit,
+                                   (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
 
     return 0;
-- 
2.54.0


