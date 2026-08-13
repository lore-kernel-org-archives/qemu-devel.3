Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7BEC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuauk-0008No-Bg; Thu, 13 Aug 2026 15:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaui-0008Lr-BC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaue-0002wO-R3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-472326ca506so129569f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786648582; x=1787253382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7T4Trc836AVrEIefselYZIhl3b4OWCl4A790SBnZvs=;
 b=my9QsuVpJP94eUl8ZyDcn9ykq26oFJpQ0lNwV+bmjuaeH4s9tP7WTpbJny2yGejnLo
 H2W3VnqOFYE1vyyZWeQZugTQkFzG3kYPJhiLXlO0canDHdRFo2Ok+WV/1gUZCbU87XT2
 NPdAELjMOUiVu0RlJH/SFtbNF6S6WgnzzUfc38nKzJm/MI0ynhkHWjk//KjRL3wrdSq4
 qCKrGk3Lif3ai1fdivG+KCDnMZHS4pcea69VgqTpYsf/GE+TOwJQZkHco1AyDQeBKqjF
 NIELh441pvUn6bXMkvVaF+Pa+wLSMW44dcl+FwrO7oGEE6Zjy8ivvTF/QXVVO7hqJx8i
 g2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648582; x=1787253382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O7T4Trc836AVrEIefselYZIhl3b4OWCl4A790SBnZvs=;
 b=Iy+JQ3B4Xsuz405WhCWfoC7fp+yuD5A5ZRgjdMqSr583AxmQ3HK76DQeU1t01l+dWl
 I7ZMETrp/c2KaO+RnByav+HI/S+SAsJVi3EqBkhqHuctfcp+BkpRiMoF0XM4JuXL6rEN
 IbEBEobhzjeyYR9vVajn9fXmM4xtiaiibunQ62wLXAJ/rTpOg0ZXsxY7trS+FVP0adAp
 Pj7/zBjLPQQCqP2Id320+90AesgicLYLx5Z+DkLI+kQ/GmfVyfQrDqVR8zTx0CJAZUNk
 rdrO+Yq488Cre5oGKZRHwRCHnHkTs2ZknXHHRiD6ryN9nSeuirl587B+zgB4Mf0ALfRk
 3cmw==
X-Gm-Message-State: AOJu0Yx+ZjfBJHvYDWj7qD9tMwvQU4WboLBBZKpOofaFA6bt2CyM9k8k
 do7kNP1s4SoQXWlgrSi7BFpvSzASx/8MEf+cNa7v4UO9dMHqHWMpKfK3DcIPtQuepFenIdQGCns
 jnPov
X-Gm-Gg: AR+sD115n6xmoXpQfHYFY482qK29aBb6dpK8nNkCid5shVif7ixO99PDJNXuFgpl9vs
 xFjyiX+f1Qf2D+ytSEFF3wYC2pM9sRkj62wCSwm6U2Do3qKrN+2Pv6EZ9Gf2t3HAis0ww5+JT+G
 FyUAarfFo3E6LbNygQSXrWaSXqAOwO7L51a4X4/CVrX+idQV7VMbfvVVAInUWhP0g2zE168pAD+
 3zrHycNTM6vHTbceExWflB9bJuGDIDdpxkX/av6kz29mNEpE8TLQ7XIxPmE99SBYbk/byW7dN7V
 6+G8mkfqtv+T2MDMpb5eXd3gf8Z/SmdvZyLvEfozdVrtWO0FS2alkpb+bzb9ATZbYxNSroXFEwo
 1+nbKnXXuHq1c/1M6mLBWPjYqGyp9fQpxX9QpoxQ4Nzx47ktQM9MIHv/SWTlmasLaaZcLUezSDj
 wxNOIia+of3Iq8IgJN2L99Ak/VUaR4k3NUbcR271A1/KamKbGbkhIgDGoe
X-Received: by 2002:adf:f252:0:b0:477:47c6:36e5 with SMTP id
 ffacd0b85a97d-48160788330mr514448f8f.25.1786648581932; 
 Thu, 13 Aug 2026 12:16:21 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:859:6d78:3324:fe2c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm1312493f8f.18.2026.08.13.12.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:16:21 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@oss.qualcomm.com, den@openvz.org
Subject: [PULL v3 5/7] tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
Date: Thu, 13 Aug 2026 21:16:10 +0200
Message-ID: <20260813191613.2323728-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813191613.2323728-1-den@openvz.org>
References: <20260813191613.2323728-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

Add /ahci/cdrom/{pio,dma}/raw: read several sectors with READ CD in
raw mode (atapi_raw), so the ATAPI 2352-byte unpack path is exercised
through the AHCI delivery, which IDE coverage does not reach. Each
sector's 2048-byte payload is verified at its in-sector offset.

The PIO case uses a byte-count limit of one raw sector per DRQ burst:
libqos asserts a one-sector PIO transfer, and the multi-sector unpack
loop is already covered by the IDE raw test.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 44799eea15..58bc04b3ef 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1565,6 +1565,31 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     return 0;
 }
 
+static int ahci_cb_cmp_raw(AHCIQState *ahci, AHCICommand *cmd,
+                           const AHCIOpts *opts)
+{
+    unsigned char *tx = opts->opaque;
+    unsigned char *rx;
+    unsigned i, nsectors;
+
+    if (!opts->size) {
+        return 0;
+    }
+
+    nsectors = opts->size / ATAPI_RAW_SECTOR_SIZE;
+    rx = g_malloc0(opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
+    /* Each raw sector carries its 2048-byte payload past a 16-byte header. */
+    for (i = 0; i < nsectors; i++) {
+        g_assert_cmphex(memcmp(rx + i * ATAPI_RAW_SECTOR_SIZE + 16,
+                               tx + i * ATAPI_SECTOR_SIZE,
+                               ATAPI_SECTOR_SIZE), ==, 0);
+    }
+    g_free(rx);
+
+    return 0;
+}
+
 static void ahci_test_cdrom(int nsectors, bool dma, uint8_t cmd,
                             bool override_bcl, uint16_t bcl)
 {
@@ -1625,6 +1650,47 @@ static void test_cdrom_pio_multi(void)
     ahci_test_cdrom_read10(3, false);
 }
 
+static void ahci_test_cdrom_raw(int nsectors, bool dma)
+{
+    AHCIQState *ahci;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    AHCIOpts opts = {
+        .size = (uint64_t)ATAPI_RAW_SECTOR_SIZE * nsectors,
+        .atapi = true,
+        .atapi_dma = dma,
+        .atapi_raw = true,
+        .set_bcl = true,
+        .bcl = ATAPI_RAW_SECTOR_SIZE, /* one raw sector per DRQ burst */
+        .post_cb = ahci_cb_cmp_raw,
+    };
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * (nsectors + 1);
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+    opts.opaque = tx;
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=raw "
+                                "-M q35 "
+                                "-device ide-cd,drive=drive0 ", iso);
+
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_CD, &opts);
+
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_cdrom_dma_raw(void)
+{
+    ahci_test_cdrom_raw(3, true);
+}
+
+static void test_cdrom_pio_raw(void)
+{
+    ahci_test_cdrom_raw(3, false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2100,8 +2166,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/dma/single", test_cdrom_dma);
     qtest_add_func("/ahci/cdrom/dma/multi", test_cdrom_dma_multi);
+    qtest_add_func("/ahci/cdrom/dma/raw", test_cdrom_dma_raw);
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
+    qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
-- 
2.53.0


