Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459CEC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjI-0000p8-2O; Wed, 19 Aug 2026 23:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjG-0000op-G0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjF-00041z-0n
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso19233805ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197567; x=1787802367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xN0xQN5mdER04LVt6luBkNx814GvD/i+FtKZY4I0s/E=;
 b=ob7XLjWCqpscpoEtzncczxeNzDerfck5KpyfaqM39bb2i6Md5e6HlDNV1p2dJLvKEG
 sDCniTWxZ7CXaVzFq1Hzgkflp9GCBQioVO0zE3GjgK4G6HndZjdIT22hO4haxAqX5Ek1
 1DybwPgQ+sHI6mgJfDQC5dOn8+cpWGZcTvWSGjNciv989WQtVflAxkJb7ki6MhQwVjtt
 J/8vNQ1MLTNGAbUYNJEwj6bPS+i/4ijmo6eFlRjbJIBTpjdJop3Q4ZKnpXxFAKqVkvSP
 vDlbpdTR17RIgLDJZQFwG7z2TcRGqy3iid/s1uqC557ZaFG9u9wCA+53qGexZLk6esup
 Exuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197567; x=1787802367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xN0xQN5mdER04LVt6luBkNx814GvD/i+FtKZY4I0s/E=;
 b=WTUXMNFdxgVk+3OxhwJ9so7r33WBEWheXBIrNQNltc7ZmIOqri0DzluvWzpfb+uvDD
 CDuhNXoStHHFoA3KDG87waiORrbAOm/r4kmO6L/Be6TWViYc9SCfE2q3R887fPugAWdw
 rQ+Jw2OHIxTzgK+znF0c7qzHYw2kMueJI8jQpkoLh0kHQAJGSSTp8qb1LxFVoSY2WmMz
 NtYVGlp0T7x9f2dLLWrpB7jlQiXgIVCpAXmmfsC8h2+HWGpG+ZUhF/GxasoT9WRCgKZN
 j9WkS9OXin8HuJ2RqrAlKkxQjA6Bag+mqaZozNi2eLBf8S3Dc2OgTrEK5RCNPWxgWAjt
 WF/w==
X-Gm-Message-State: AFuF++kxVUwLQ9c6lz9nfdYWbR571VzKfdFpLeb9LpA+iJX7eJePMk1D
 J8NJsTsiBsYSETeqxJQCh3OMpvs5Gawz8YPVQt5/zJlCdm+uvoWCyOpuXW+PTw==
X-Gm-Gg: AR+sD13vUhx6nbADrQROnfq9nytTz5NE76AHpQCpoWBbKfoI6l31TOSQTuiiXrQVJhQ
 q9DIwcC7GGSqfRx9FD7yD3QANdkHdlhbn23jXn9MU9jMLpgsUeFpQW/EeWwQQJBMbvwxl6qL/oY
 WgfTZJIsoYtmZW89tevTXHEZTiv4MZ78kJhx4EGTawwgW5EheKu/z0kprTEPK6v9T4bq3HphO4c
 roMTjBDs12eGD038R5tAoCroEjjS9KCh8P7A2tyxJOa/RlpQ5a6STB1axWkfCZhJQyZxe/dZZQ7
 nCt96NFuLX7jho/uEtl72RZVyGVNLXwMaEJoyo4093LqdIjfr6C5OpmQCnbT3mxoBIi8qvoZL3E
 ucidTzlRGwQNBGsZA29IrR9VOsQdRmJljsDr5hdIAvPTUd2ar/LIr/PT/Tc8GrGDsuVXVv1obZy
 bzanXM2RqX4mae2y/LGyEjc2Ps7iuPsAmXmwSWAlwZ+hmOgjmtsFU9xHhto6BgDA210PniFMlMV
 cLgXA==
X-Received: by 2002:a17:90b:4e8f:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-395810844a8mr16935775a91.10.1787197567526; 
 Wed, 19 Aug 2026 20:46:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Ivan Efremov <nendensu@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/93] tests/qtest: Add seed CSR zero extension test
Date: Thu, 20 Aug 2026 13:43:25 +1000
Message-ID: <20260820034430.1186695-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Ivan Efremov <nendensu@ispras.ru>

Add a qtest that reads the seed CSR on RV64 machine with Zkr support
and verifies that the upper 32 bits are clear.

Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260802113130.7818-3-nendensu@ispras.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/riscv-csr-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
index bb1b0ffed3..7479a5c5bc 100644
--- a/tests/qtest/riscv-csr-test.c
+++ b/tests/qtest/riscv-csr-test.c
@@ -20,6 +20,12 @@
 #define CSR_MVENDORID       0xf11
 #define CSR_MISELECT        0x350
 
+#define CSR_SEED           0x015
+
+#define SEED_OPST_MASK     (UINT64_C(0x3) << 30)
+#define SEED_OPST_ES16     (UINT64_C(0x2) << 30)
+#define SEED_OPST_DEAD     (UINT64_C(0x3) << 30)
+
 static void run_test_csr(void)
 {
     uint64_t res;
@@ -46,12 +52,32 @@ static void run_test_csr(void)
     qtest_quit(qts);
 }
 
+static void run_test_seed_csr(void)
+{
+    uint64_t val = 0;
+    uint64_t opst;
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt -cpu tt-ascalon");
+
+    qtest_csr_call(qts, "get_csr", 0, CSR_SEED, &val);
+
+    opst = val & SEED_OPST_MASK;
+    g_assert_true(opst == SEED_OPST_ES16 ||
+                  opst == SEED_OPST_DEAD);
+
+    g_assert_cmphex(val >> 32, ==, 0);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     if (qtest_has_machine("virt")) {
         qtest_add_func("/cpu/csr", run_test_csr);
+        qtest_add_func("/cpu/csr/seed", run_test_seed_csr);
     }
 
     return g_test_run();
-- 
2.54.0


