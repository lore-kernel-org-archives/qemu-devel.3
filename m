Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14911C44523
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 21:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlYvH-0007XM-7U; Sun, 19 Jul 2026 17:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlYvF-0007Wc-Ua
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:19:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlYvD-0006ps-TW
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:19:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so65382975e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784495978; x=1785100778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xwWetVbSJViUHp5bb0Y3AMHj8TPDUE3K1eNxqHubiHc=;
 b=eakdPSVLZBP0qx9ODlnuuYn6T2hKuo50wUECPFGj1lmE0YO1jMn1fo1mEw6nlTC414
 OJEhH07wEJUEUSaHm2M6Zg+yE40hEpkjuNj3dUSYXVxzL+J69u5zd/PUnr6GgS3y0ajW
 0RCZIFKJkt5lGQ1h/GtE0lgS3B5PPo6I/nCD5sVVP6H5ZuoKN8iqnO6zfTzhlUVrNGqh
 Fo8bEKXugId8OMB9PYF/FlbPLyTag2UIuQxz5v9Y7/odB9FNpd7XTi4jDV1k5bqxiGWG
 wiHEI2C4czSpd+M4LhhifuJ3apbRQ17DcAvWxBc+nxs/prTiHyoNf9EsDP/icJJcdVEl
 EXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784495978; x=1785100778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xwWetVbSJViUHp5bb0Y3AMHj8TPDUE3K1eNxqHubiHc=;
 b=Y1n0Rc9ZmOY0OyjPTiV+zqNQfIsAemi6U/aNb+PHwlRL1qxGzYTwfPCPSKT9dsXL3s
 x/TCb91STuGl7gLgd8d3KY1uzKubO3IqcHs+a1X67vm8ZO/U6u43+JyyrRbNktncxCHw
 VLyp+YdfoBmKrla675weWs3rsi4lfpzjk6OrcQVaamzv+UOI3/6ER5Mhbrs4sW+4dLEf
 /gklgClUit80idpJi4/H9qckrOmDTGRegKGjqAS0P2yic3FYs2KWTZgZ4V1CzGIb8Kn+
 AmGlGQcQixP4XR2wUenvxdClzqIDcXjbGfLNrPUJy44Vd7QHk6cuz2klAkwHmXi2bY12
 lKWQ==
X-Gm-Message-State: AOJu0YxglkhWXQ7159k8EaFbZ7r5mPb5uF8GUZ3HuoiRlt3e7QW0dzNR
 w5Wx4nVYzbReknEvYRTDT7Cphji/wkQPya8KptHC5mWpELmQgX9mtEOjznbP6g==
X-Gm-Gg: AfdE7cmPoIwWyDS8KkUAdoxiJMEV33x7fpgpOkDRDMFA5q7deH8ks8gdds1UynaHP9k
 7Mw2t/qHmlbKzxV4AiCvgR3OJDHuJTdOjL6swHmcQ+OXdLWRUuB6z62ojVB6MITHcvojqQ7m4h+
 Zt6sM0ibbSp96qTj3OCCrt3WTdERDOYf5ns5b144TB0FEVEOJ57Z/o40gnsLKV1iWhuPj2cg87E
 Sb7uTA6FVX5e8ZF/i0b+zCvU1zHUEMgrNf+8ETIdVcP9ckrGasV+0yHC9NtT/esYi/xN6RpqVDs
 1SBbq/J0bqm03AHy73adGO+He3R+Cmh/vD/8rolpdw+/Xw2ACpR8OgwqMem/rNn5atjfimhTsSQ
 E6RcVjYLOE3Mt/yzNMLf/Z1oG0UUMSwv5ihrvpsfJoZHI51G5lvAlww6kRIxx7Bi3x5qKseD9Qi
 TD+NoREydZbXXMaLY+qQeLzdWKQJvtbCncbJQ/DVn5woS9yiZFveyICTe9jouJXKvkKYt0oduo8
 1WU3wGDBTgTgyrI1yIuocuBzEhxqLTLOQxN
X-Received: by 2002:a05:600c:e54a:20b0:495:5d6d:9cd5 with SMTP id
 5b1f17b1804b1-4955d6d9e31mr15181025e9.27.1784495977865; 
 Sun, 19 Jul 2026 14:19:37 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1c56-1500-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c56:1500:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm234235155e9.3.2026.07.19.14.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 14:19:37 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
Date: Sun, 19 Jul 2026 23:19:23 +0200
Message-ID: <20260719211923.1079282-3-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719211923.1079282-1-shentey@gmail.com>
References: <20260719211923.1079282-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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

In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() while
the eSDHC code path uses the standard SDHC interface. Extract the quirk
into a new `usdhc_write()` function.

Fixes file system corruption on emulated i.MX53 where Linux'
esdhc_is_usdhc() returns false. The same likely happens on e500 and
imx25-pdk machines.

Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f..e58a610397 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_write(opaque, offset, value, size);
         break;
 
-    case ESDHC_MIX_CTRL:
-        /*
-         * So, when SD/MMC stack in Linux tries to write to "Transfer
-         * Mode Register", ESDHC i.MX quirk code will translate it
-         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
-         * order to get where we started
-         *
-         * Note that Auto CMD23 Enable bit is located in a wrong place
-         * on i.MX, but since it is not used by QEMU we do not care.
-         *
-         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
-         * here because it will result in a call to
-         * sdhci_send_command(s) which we don't want.
-         *
-         */
-        s->trnmod = value & UINT16_MAX;
-        break;
-    case SDHC_TRNMOD:
-        /*
-         * Similar to above, but this time a write to "Command
-         * Register" will be translated into a 4-byte write to
-         * "Transfer Mode register" where lower 16-bit of value would
-         * be set to zero. So what we do is fill those bits with
-         * cached value from s->trnmod and let the SDHCI
-         * infrastructure handle the rest
-         */
-        sdhci_write(opaque, offset, val | s->trnmod, size);
-        break;
     case SDHC_BLKSIZE:
         /*
          * ESDHCI does not implement "Host SDMA Buffer Boundary", and
@@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
+static void
+usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    SDHCIState *s = SYSBUS_SDHCI(opaque);
+    uint32_t value = (uint32_t)val;
+
+    switch (offset) {
+    case ESDHC_MIX_CTRL:
+        /*
+         * So, when SD/MMC stack in Linux tries to write to "Transfer
+         * Mode Register", uSDHC i.MX quirk code will translate it
+         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
+         * order to get where we started.
+         *
+         * Note that Auto CMD23 Enable bit is located in a wrong place
+         * on i.MX, but since it is not used by QEMU we do not care.
+         *
+         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
+         * here because it will result in a call to
+         * sdhci_send_command(s) which we don't want.
+         *
+         */
+        s->trnmod = value & UINT16_MAX;
+        break;
+
+    case SDHC_TRNMOD:
+        /*
+         * Similar to above, but this time a write to "Command
+         * Register" will be translated into a 4-byte write to
+         * "Transfer Mode register" where lower 16-bit of value would
+         * be set to zero. So what we do is fill those bits with
+         * cached value from s->trnmod and let the SDHCI
+         * infrastructure handle the rest
+         */
+        sdhci_write(opaque, offset, val | s->trnmod, size);
+        break;
+
+    default:
+        esdhc_write(opaque, offset, val, size);
+        break;
+    }
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
-    .write = esdhc_write,
+    .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.55.0


