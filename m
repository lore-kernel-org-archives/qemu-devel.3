Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF40C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNd0-0001eV-Ix; Fri, 07 Aug 2026 12:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVk-0004ZC-9D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:29:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVh-0007R3-Fp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:29:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so52488545ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786116564; x=1786721364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WRT7Ht2mEENkwBrIlmhqK7G+z/zY98Xv2eh9U+KRqmw=;
 b=H1Ud0nzS9R76fv183XdSoeSqRD9jB2ctPt44D3B3BzCwFGRWxWCMimQlKkFupv8Tw8
 PByRIhHWQMlbaWdd+0u7PZx3+0t191mANgKc1BS0Tupj/E5FJC/8Nof/d5J5H3xZVva7
 lCFa2e319aMsVlBaAx//QF4y+OaZE5VFfoI2NKiiktEXYocRXV3HqTqW8lxoFru/tgjj
 5BwivcPR4/DwVcj6pd0EYYhh1NOkzAVYeHsuSPGxWo5elP6wVLT5s8Mo9Abl+j/BPF0E
 cOLaf38ze+vP1qKPK75Ne7mnBIyF3H3kMBKBhxG+b5ZRqR/85J/qv1LHKBUlr55osRyC
 rD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116564; x=1786721364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WRT7Ht2mEENkwBrIlmhqK7G+z/zY98Xv2eh9U+KRqmw=;
 b=XxxmSXcQdIc2Cq6AcTIWAjzCI60p4EwpG9aU793Pkwd2QUQ58u/17e0jt4lyfN8DC9
 VxVPmH8RCGDvdtU0XkQJXg+b//G6tnnaflZeGXtO8EqUKTmv4kBhzAcxqVAQc6WwUKFo
 Q+8FzgDWZNKeowW/H4+1w7ywCWDQYvP/chsOeYFgw5HCy/+LNtygn12PT6+yYMupwIjO
 yteYPPZS4SgerSZBj2MxqPdVP+CqISBdhULtjHyWOXEkH8i2NABvLRHW3HOTpfNlxej3
 RXJIArqd37D3/zhNawNUKZQaFPBjgMtCK05Nav2FAE/5UCydE359oeTs65yw39gdFAUc
 jAYg==
X-Gm-Message-State: AOJu0YxRWTgzC/c10euQqiZ9l5dZRqUxLEi32u+/1eLydeHsIo7InrUz
 4vWD0ifHHGFsN9BlkcNVt4wbv+wWX3rFabdZW+jn3eXK7wcfvLXHCu/W
X-Gm-Gg: AR+sD10xlKboZ3BeD8/uKdY6T2uSfAKo9G72WNcDHhw6gjfGoy5Mm/w3qKilEsbAIUM
 CSKLIavV0USee8UiaeAt2UxgMMpt9YzWIIpRvTM+aYyWqbOMCMFBBkZpSlR7P2mfKEAFUngoomZ
 IYc+utjkbaioL2Csn/a7D1/zzDl/hr1xHuRBh5d5KsXZwNRR+n8DlQlcnlUVQ99435D0JVr1IpJ
 PKnY9aGfVSsi11X0RGiwgl3Cv6td1AboHvMor5VehdzddHJeheHKG/+UNAcg786ciaYPGnBO0uA
 s2w7P/469sH+C9Yyq9cJz7fSXYcBaiKsJW2/Pb3VQQ3AeREyZ8GsbGk1+/eK1gn/RnV+iYe2kLZ
 ++tgM58IvGrsYgVbjRUAMS5liWrRtpWxRsR01oZgCYyN8bq8RxY9dh65fzzok4nEd2DO+QBFTsD
 MSaiwfkgNBUKgJbwYBkWMdDNv84lcr2SOpA3tAk0xngLobpHpLQZx/ky2cALsZ/uzAuhOAohn7o
 Gb+oghE0Ds=
X-Received: by 2002:a17:903:3b87:b0:2ce:93a3:c168 with SMTP id
 d9443c01a7336-2d294b4b57bmr63393675ad.7.1786116564065; 
 Fri, 07 Aug 2026 08:29:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2406:da14:1cf8:d800:471c:a879:4603:554f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccae6f8sm10953895ad.1.2026.08.07.08.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:29:23 -0700 (PDT)
From: Wang Zhongyu <wzy15515798875@gmail.com>
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 5/5] tests/qtest: test K230 I2C transfers with slave devices
Date: Fri,  7 Aug 2026 23:28:30 +0800
Message-ID: <20260807152830.6833-6-wzy15515798875@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807152830.6833-1-wzy15515798875@gmail.com>
References: <20260807152830.6833-1-wzy15515798875@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=wzy15515798875@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 12:41:00 -0400
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

Add transfer tests using TMP105 and i2c-echo slave devices.

Cover single- and multi-byte reads and writes, combined write/read
transfers, repeated START and STOP handling, RX threshold and
overflow behavior, data NACK reporting, restart-disabled aborts.

Signed-off-by: Wang Zhongyu <wzy15515798875@gmail.com>
---
 tests/qtest/k230-i2c-test.c | 598 ++++++++++++++++++++++++++++++++++++
 1 file changed, 598 insertions(+)

diff --git a/tests/qtest/k230-i2c-test.c b/tests/qtest/k230-i2c-test.c
index 1d134de5d0..ee788216fb 100644
--- a/tests/qtest/k230-i2c-test.c
+++ b/tests/qtest/k230-i2c-test.c
@@ -38,7 +38,11 @@
 #define K230_IC_TX_TL                  0x3c
 #define K230_IC_CLR_INTR               0x40
 #define K230_IC_CLR_RX_UNDER           0x44
+#define K230_IC_CLR_RX_OVER            0x48
 #define K230_IC_CLR_TX_ABRT            0x54
+#define K230_IC_CLR_ACTIVITY           0x5c
+#define K230_IC_CLR_STOP_DET           0x60
+#define K230_IC_CLR_START_DET          0x64
 #define K230_IC_ENABLE                 0x6c
 #define K230_IC_STATUS                 0x70
 #define K230_IC_TXFLR                  0x74
@@ -63,20 +67,29 @@
 /* IC_DATA_CMD */
 #define IC_DATA_CMD_READ               BIT(8)
 #define IC_DATA_CMD_STOP               BIT(9)
+#define IC_DATA_CMD_RESTART            BIT(10)
 
 /* IC_INTR_STAT and IC_RAW_INTR_STAT */
 #define IC_INTR_RX_UNDER               BIT(0)
+#define IC_INTR_RX_OVER                BIT(1)
+#define IC_INTR_RX_FULL                BIT(2)
 #define IC_INTR_TX_EMPTY               BIT(4)
 #define IC_INTR_TX_ABRT                BIT(6)
 #define IC_INTR_ACTIVITY               BIT(8)
+#define IC_INTR_STOP_DET               BIT(9)
 #define IC_INTR_START_DET              BIT(10)
 
 /* IC_STATUS */
+#define IC_STATUS_ACTIVITY             BIT(0)
 #define IC_STATUS_TFNF                 BIT(1)
 #define IC_STATUS_TFE                  BIT(2)
+#define IC_STATUS_RFNE                 BIT(3)
+#define IC_STATUS_RFF                  BIT(4)
+#define IC_STATUS_MST_ACTIVITY         BIT(5)
 
 /* IC_TX_ABRT_SOURCE */
 #define IC_ABRT_7B_ADDR_NOACK          BIT(0)
+#define IC_ABRT_TXDATA_NOACK           BIT(3)
 #define IC_ABRT_GCALL_NOACK            BIT(4)
 #define IC_ABRT_GCALL_READ             BIT(5)
 #define IC_ABRT_SBYTE_NORSTRT          BIT(9)
@@ -86,6 +99,19 @@
 #define K230_IC_COMP_VERSION_VALUE     0x3132302a
 #define K230_IC_COMP_TYPE_VALUE        0x44570140
 
+#define TMP105_ADDRESS                  0x49
+#define I2C_ECHO_ADDRESS                0x50
+
+#define TMP105_REG_TEMPERATURE          0x00
+#define TMP105_REG_CONFIG               0x01
+#define TMP105_REG_T_LOW                0x02
+#define TMP105_REG_T_HIGH               0x03
+
+#define K230_I2C_SLAVE_MACHINE_ARGS                             \
+    "-machine k230 "                                            \
+    "-device tmp105,id=tmp105-test,address=0x49 "                \
+    "-device i2c-echo,id=i2c-echo-test,address=0x50"
+
 static const uint64_t k230_i2c_base[K230_I2C_COUNT] = {
     K230_I2C0_BASE,
     K230_I2C1_BASE,
@@ -94,6 +120,129 @@ static const uint64_t k230_i2c_base[K230_I2C_COUNT] = {
     K230_I2C4_BASE,
 };
 
+static QTestState *k230_i2c_init_with_slaves(void)
+{
+    return qtest_init(K230_I2C_SLAVE_MACHINE_ARGS);
+}
+
+static void k230_i2c_configure_master(QTestState *qts, uint64_t base,
+                                      uint8_t target, bool restart_enable)
+{
+    uint32_t con;
+
+    qtest_writel(qts, base + K230_IC_ENABLE, 0);
+
+    con = qtest_readl(qts, base + K230_IC_CON);
+    con |= IC_CON_MASTER_MODE;
+    con &= ~IC_CON_10BITADDR_MASTER;
+
+    if (restart_enable) {
+        con |= IC_CON_RESTART_EN;
+    } else {
+        con &= ~IC_CON_RESTART_EN;
+    }
+
+    qtest_writel(qts, base + K230_IC_CON, con);
+    qtest_writel(qts, base + K230_IC_TAR, target);
+    qtest_writel(qts, base + K230_IC_ENABLE, 1);
+}
+
+static void k230_i2c_assert_no_abort(QTestState *qts, uint64_t base)
+{
+    uint32_t raw;
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_TX_ABRT_SOURCE),
+                    ==, 0);
+}
+
+static uint64_t k230_i2c_find_tmp105_bus(QTestState *qts)
+{
+    for (int i = 0; i < K230_I2C_COUNT; i++) {
+        uint64_t base = k230_i2c_base[i];
+        uint32_t raw;
+
+        k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+
+        /*
+         * A one-byte write selects the temperature register.  The
+         * controller whose bus contains TMP105 completes without aborting.
+         */
+        qtest_writel(qts, base + K230_IC_DATA_CMD,
+                     IC_DATA_CMD_STOP | TMP105_REG_TEMPERATURE);
+
+        raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+
+        if (!(raw & IC_INTR_TX_ABRT)) {
+            qtest_writel(qts, base + K230_IC_ENABLE, 0);
+            return base;
+        }
+
+        qtest_readl(qts, base + K230_IC_CLR_TX_ABRT);
+        qtest_writel(qts, base + K230_IC_ENABLE, 0);
+    }
+
+    g_assert_not_reached();
+}
+
+static void k230_i2c_write_bytes(QTestState *qts, uint64_t base,
+                                 const uint8_t *data, size_t len)
+{
+    g_assert_cmpuint(len, >, 0);
+
+    for (size_t i = 0; i < len; i++) {
+        uint32_t command = data[i];
+
+        if (i == len - 1) {
+            command |= IC_DATA_CMD_STOP;
+        }
+
+        qtest_writel(qts, base + K230_IC_DATA_CMD, command);
+    }
+
+    k230_i2c_assert_no_abort(qts, base);
+}
+
+static void k230_i2c_select_register(QTestState *qts, uint64_t base,
+                                     uint8_t reg)
+{
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | reg);
+    k230_i2c_assert_no_abort(qts, base);
+}
+
+static void k230_i2c_queue_reads(QTestState *qts, uint64_t base,
+                                 size_t len, bool restart_first,
+                                 bool stop_last)
+{
+    g_assert_cmpuint(len, >, 0);
+
+    for (size_t i = 0; i < len; i++) {
+        uint32_t command = IC_DATA_CMD_READ;
+
+        if (i == 0 && restart_first) {
+            command |= IC_DATA_CMD_RESTART;
+        }
+
+        if (i == len - 1 && stop_last) {
+            command |= IC_DATA_CMD_STOP;
+        }
+
+        qtest_writel(qts, base + K230_IC_DATA_CMD, command);
+    }
+
+    k230_i2c_assert_no_abort(qts, base);
+}
+
+static void k230_i2c_tmp105_combined_read(QTestState *qts, uint64_t base,
+                                          uint8_t reg, size_t len)
+{
+    qtest_writel(qts, base + K230_IC_DATA_CMD, reg);
+    k230_i2c_queue_reads(qts, base, len, true, true);
+}
+
 static void test_reset_values(void)
 {
     QTestState *qts = qtest_init("-machine k230");
@@ -824,6 +973,432 @@ static void test_start_byte_abort(void)
     qtest_quit(qts);
 }
 
+static void test_tmp105_config_read_write(void)
+{
+    static const uint8_t write_data[] = {
+        TMP105_REG_CONFIG,
+        0x60,
+    };
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+
+    k230_i2c_write_bytes(qts, base, write_data,
+                         G_N_ELEMENTS(write_data));
+
+    k230_i2c_tmp105_combined_read(qts, base,
+                                  TMP105_REG_CONFIG, 1);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x60);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 0);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_tmp105_limit_read_write(void)
+{
+    static const uint8_t write_data[] = {
+        TMP105_REG_T_LOW,
+        0x12,
+        0x34,
+    };
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+
+    k230_i2c_write_bytes(qts, base, write_data,
+                         G_N_ELEMENTS(write_data));
+
+    k230_i2c_tmp105_combined_read(qts, base,
+                                  TMP105_REG_T_LOW, 2);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 2);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x12);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x30);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 0);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_tmp105_direct_read(void)
+{
+    static const uint8_t write_data[] = {
+        TMP105_REG_CONFIG,
+        0x20,
+    };
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+
+    k230_i2c_write_bytes(qts, base, write_data,
+                         G_N_ELEMENTS(write_data));
+    k230_i2c_select_register(qts, base, TMP105_REG_CONFIG);
+
+    /*
+     * Start a read while the controller is idle.  This covers the
+     * IDLE-to-RECEIVING path without a preceding repeated START.
+     */
+    k230_i2c_queue_reads(qts, base, 1, false, true);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x20);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_tmp105_read_write_restart(void)
+{
+    static const uint8_t initial_data[] = {
+        TMP105_REG_CONFIG,
+        0x20,
+    };
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+
+    k230_i2c_write_bytes(qts, base, initial_data,
+                         G_N_ELEMENTS(initial_data));
+    k230_i2c_select_register(qts, base, TMP105_REG_CONFIG);
+
+    /*
+     * Leave the read transfer active, then switch from receiving to
+     * sending with a repeated START.
+     */
+    k230_i2c_queue_reads(qts, base, 1, false, false);
+
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_RESTART | TMP105_REG_CONFIG);
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x60);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x20);
+
+    k230_i2c_tmp105_combined_read(qts, base,
+                                  TMP105_REG_CONFIG, 1);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x60);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_tmp105_same_direction_restart(void)
+{
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+
+    /*
+     * Start in the sending state, issue an explicit repeated START
+     * without changing direction, and then write the config register.
+     */
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 TMP105_REG_T_LOW);
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_RESTART | TMP105_REG_CONFIG);
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x40);
+
+    k230_i2c_assert_no_abort(qts, base);
+
+    k230_i2c_tmp105_combined_read(qts, base,
+                                  TMP105_REG_CONFIG, 1);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x40);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_transfer_status_with_slave(void)
+{
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+    uint32_t raw;
+    uint32_t status;
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+    qtest_readl(qts, base + K230_IC_CLR_INTR);
+
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 TMP105_REG_CONFIG);
+
+    status = qtest_readl(qts, base + K230_IC_STATUS);
+    g_assert_cmphex(status & IC_STATUS_ACTIVITY,
+                    ==, IC_STATUS_ACTIVITY);
+    g_assert_cmphex(status & IC_STATUS_MST_ACTIVITY,
+                    ==, IC_STATUS_MST_ACTIVITY);
+    g_assert_cmphex(status & IC_STATUS_TFNF,
+                    ==, IC_STATUS_TFNF);
+    g_assert_cmphex(status & IC_STATUS_TFE,
+                    ==, IC_STATUS_TFE);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_START_DET,
+                    ==, IC_INTR_START_DET);
+    g_assert_cmphex(raw & IC_INTR_ACTIVITY,
+                    ==, IC_INTR_ACTIVITY);
+
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x20);
+
+    status = qtest_readl(qts, base + K230_IC_STATUS);
+    g_assert_cmphex(status & IC_STATUS_ACTIVITY, ==, 0);
+    g_assert_cmphex(status & IC_STATUS_MST_ACTIVITY, ==, 0);
+    g_assert_cmphex(status & IC_STATUS_TFNF,
+                    ==, IC_STATUS_TFNF);
+    g_assert_cmphex(status & IC_STATUS_TFE,
+                    ==, IC_STATUS_TFE);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_STOP_DET,
+                    ==, IC_INTR_STOP_DET);
+    g_assert_cmphex(raw & IC_INTR_ACTIVITY,
+                    ==, IC_INTR_ACTIVITY);
+
+    qtest_readl(qts, base + K230_IC_CLR_START_DET);
+    qtest_readl(qts, base + K230_IC_CLR_STOP_DET);
+    qtest_readl(qts, base + K230_IC_CLR_ACTIVITY);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_START_DET, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_STOP_DET, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_ACTIVITY, ==, 0);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_rx_threshold_with_slave(void)
+{
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+    uint32_t raw;
+    uint32_t stat;
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+    qtest_writel(qts, base + K230_IC_RX_TL, 1);
+    qtest_writel(qts, base + K230_IC_INTR_MASK,
+                 IC_INTR_RX_FULL);
+
+    k230_i2c_select_register(qts, base, TMP105_REG_T_LOW);
+    qtest_readl(qts, base + K230_IC_CLR_INTR);
+
+    k230_i2c_queue_reads(qts, base, 1, false, false);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_FULL, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 1);
+
+    k230_i2c_queue_reads(qts, base, 1, false, true);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    stat = qtest_readl(qts, base + K230_IC_INTR_STAT);
+
+    g_assert_cmphex(raw & IC_INTR_RX_FULL,
+                    ==, IC_INTR_RX_FULL);
+    g_assert_cmphex(stat & IC_INTR_RX_FULL,
+                    ==, IC_INTR_RX_FULL);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 2);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x4b);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_FULL, ==, 0);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x00);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_rx_overflow_with_slave(void)
+{
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+    uint32_t raw;
+    uint32_t status;
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, true);
+    qtest_writel(qts, base + K230_IC_RX_TL, 63);
+    qtest_writel(qts, base + K230_IC_INTR_MASK,
+                 IC_INTR_RX_FULL | IC_INTR_RX_OVER);
+
+    k230_i2c_select_register(qts, base, TMP105_REG_T_LOW);
+    qtest_readl(qts, base + K230_IC_CLR_INTR);
+
+    /*
+     * TMP105 returns two register bytes and then 0xff.  Sixty-five
+     * read commands therefore fill the 64-byte RX FIFO and overflow
+     * on the final command.
+     */
+    k230_i2c_queue_reads(qts, base, 65, false, true);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 64);
+
+    status = qtest_readl(qts, base + K230_IC_STATUS);
+    g_assert_cmphex(status & IC_STATUS_RFNE,
+                    ==, IC_STATUS_RFNE);
+    g_assert_cmphex(status & IC_STATUS_RFF,
+                    ==, IC_STATUS_RFF);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_FULL,
+                    ==, IC_INTR_RX_FULL);
+    g_assert_cmphex(raw & IC_INTR_RX_OVER,
+                    ==, IC_INTR_RX_OVER);
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x4b);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_DATA_CMD),
+                    ==, 0x00);
+
+    for (int i = 0; i < 62; i++) {
+        g_assert_cmphex(qtest_readl(qts,
+                                   base + K230_IC_DATA_CMD),
+                        ==, 0xff);
+    }
+
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 0);
+
+    status = qtest_readl(qts, base + K230_IC_STATUS);
+    g_assert_cmphex(status & IC_STATUS_RFNE, ==, 0);
+    g_assert_cmphex(status & IC_STATUS_RFF, ==, 0);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_FULL, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_RX_OVER,
+                    ==, IC_INTR_RX_OVER);
+
+    qtest_readl(qts, base + K230_IC_CLR_RX_OVER);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_OVER, ==, 0);
+
+    k230_i2c_assert_no_abort(qts, base);
+    qtest_quit(qts);
+}
+
+static void test_restart_disabled_abort(void)
+{
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+    uint32_t raw;
+    uint32_t status;
+
+    k230_i2c_configure_master(qts, base, TMP105_ADDRESS, false);
+
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 TMP105_REG_CONFIG);
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_READ | IC_DATA_CMD_STOP);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    status = qtest_readl(qts, base + K230_IC_STATUS);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT,
+                    ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(qtest_readl(qts,
+                               base + K230_IC_TX_ABRT_SOURCE),
+                    ==, 0);
+    g_assert_cmphex(status & IC_STATUS_ACTIVITY, ==, 0);
+    g_assert_cmphex(status & IC_STATUS_MST_ACTIVITY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 0);
+
+    qtest_readl(qts, base + K230_IC_CLR_TX_ABRT);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_echo_data_nack(void)
+{
+    static const uint8_t accepted_data[] = {
+        0x7f,
+        0x11,
+        0x22,
+    };
+    QTestState *qts = k230_i2c_init_with_slaves();
+    uint64_t base = k230_i2c_find_tmp105_bus(qts);
+    uint32_t raw;
+    uint32_t source;
+    uint32_t status;
+
+    k230_i2c_configure_master(qts, base, I2C_ECHO_ADDRESS, true);
+
+    for (size_t i = 0; i < G_N_ELEMENTS(accepted_data); i++) {
+        qtest_writel(qts, base + K230_IC_DATA_CMD,
+                     accepted_data[i]);
+    }
+
+    /*
+     * i2c-echo accepts three bytes.  The fourth byte is rejected,
+     * allowing the controller's TXDATA_NOACK path to be tested.
+     */
+    qtest_writel(qts, base + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x33);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts, base + K230_IC_TX_ABRT_SOURCE);
+    status = qtest_readl(qts, base + K230_IC_STATUS);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT,
+                    ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_TXDATA_NOACK,
+                    ==, IC_ABRT_TXDATA_NOACK);
+    g_assert_cmphex(source & IC_ABRT_7B_ADDR_NOACK, ==, 0);
+    g_assert_cmphex(status & IC_STATUS_ACTIVITY, ==, 0);
+    g_assert_cmphex(status & IC_STATUS_MST_ACTIVITY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, base + K230_IC_RXFLR),
+                    ==, 0);
+
+    qtest_readl(qts, base + K230_IC_CLR_TX_ABRT);
+
+    raw = qtest_readl(qts, base + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts, base + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
+    g_assert_cmphex(source, ==, 0);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -857,5 +1432,28 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-i2c/start-byte-abort",
                    test_start_byte_abort);
 
+    if (qtest_has_device("tmp105") && qtest_has_device("i2c-echo")) {
+        qtest_add_func("/k230-i2c/tmp105-config-read-write",
+                       test_tmp105_config_read_write);
+        qtest_add_func("/k230-i2c/tmp105-limit-read-write",
+                       test_tmp105_limit_read_write);
+        qtest_add_func("/k230-i2c/tmp105-direct-read",
+                       test_tmp105_direct_read);
+        qtest_add_func("/k230-i2c/tmp105-read-write-restart",
+                       test_tmp105_read_write_restart);
+        qtest_add_func("/k230-i2c/tmp105-same-direction-restart",
+                       test_tmp105_same_direction_restart);
+        qtest_add_func("/k230-i2c/transfer-status-with-slave",
+                       test_transfer_status_with_slave);
+        qtest_add_func("/k230-i2c/rx-threshold-with-slave",
+                       test_rx_threshold_with_slave);
+        qtest_add_func("/k230-i2c/rx-overflow-with-slave",
+                       test_rx_overflow_with_slave);
+        qtest_add_func("/k230-i2c/restart-disabled-abort",
+                       test_restart_disabled_abort);
+        qtest_add_func("/k230-i2c/echo-data-nack",
+                       test_echo_data_nack);
+    }
+
     return g_test_run();
 }
-- 
2.43.0


