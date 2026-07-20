Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80F0C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluLB-00067N-F0; Mon, 20 Jul 2026 16:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wluL9-00064e-2A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:11:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wluL6-00065w-LJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:11:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso25243315e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784578307; x=1785183107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oOhv/ptlHCElcrsanQtecf376OnNniCHz8PAgnXjrx8=;
 b=Q9bw4US0eXceDQbkwBlVjJ2K3efQmxOLdgHHvUZh8jR+n4sTnhZMljrq844QJ5kHAY
 xcQ0wUQfM3tqgZmzg5vLVfcGPfD4SVP0c2sN4yvpEbYRj6gyIN+6DBsGQZ7dPh/ZM0l0
 r68Rw29vbZXuRUOQ29y+WZJ1KRqJSFvKEaGK83+RONPnScZRJ9k5XJk4WjUj1Fi6XHlx
 qBEJVfEN9GxAqexy/0D3wJd2Xr7LvSjjjlGO4OfCigx1om7d6UUqW64lyQkocLWorJyy
 7WFbh2ThQW+ZFzyVNUPuYTQNAp2XfOLkEqyB+HUgoFuOZVdaFGfSW1BTOhvAQN0fMKkf
 n4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784578307; x=1785183107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oOhv/ptlHCElcrsanQtecf376OnNniCHz8PAgnXjrx8=;
 b=Pnc8vQKLFgiKwbjco2zc4WEg2prfiAUwWuZzlaKXzRaiBOhaVzfmnesyX2ouE+zVv9
 Se+nnWcQNMT1I0ZMEPyJmsXepfn0t3d3WnEPu/sdjIybriGZzz5D8ZshnCfljvouJX6Z
 TgqXwCiqGvbQtCf3p8RIzTQ6s0j0UqiEdMcvVFspRFwIqOIp1kn+RfJ/3QwWx7L+dz+G
 TLZ5rfS2Mx3vXkIegwnG2FJmJNwFlzj0aE/nn7K/M2sL0+4MdeicagzPvCT43p5o5BEg
 P+OptutBbCJgeePZshGaEiG7RMbq/RZlmDmDvJll0nMbbqt0MIgXXKZt+/m3UY/9ahMv
 bHWA==
X-Gm-Message-State: AOJu0Yzrtt8xNNkNjXATil185A/Uqvh2m4kSZj8akRC64VRCH4La2Chw
 0ypO5VcvC1VUcLkk1wy+S6feHg1wwDb+gXQHhfhYnfny+rMZRJ02tRMNRUUKzQ==
X-Gm-Gg: AfdE7cnnSnUmHbv7I1zhLA1v+mMT2HCyTx8yYsKq1m7u5BKZcPNywSlX5utK84lzy2N
 t9Unu2Gcl9DacqOoEcXzqpadWxqEEA6Fd5hzAoKSX5UPMXNNLDjD4NUHxSVNFajsxqIKZehuX/5
 dt5oahm0W+Jev1/CYx9OvL0LcEEkIJQ5pG8j+i7flaX9fB2bV1zp7xg2SAW5I/4g54lKNrF6+4s
 fY1NSVve+nGK6diEpWyejIOa5YGXThO+lo6XLiYvZYiqM8uCKGXV5aJGXIiy9euEygMfy0kzB6W
 pDQLWgxybN0VTN++R28EDr0JcSQm7mw9jzKknU9FxHHvKBUtklsA6bAVLKjL4NfIXzdXJ+Tf4K0
 BuKUq8mEUbLVpT3NOOx8lEDqTHeF9M7tWx00A6L/4qMnLVOBtGoIvJxqstuneFV+IdQdLogvVL+
 /s+WgUP3cpCzIP/YIjJ9o8CziKNxkUB7V4MuLCeJknTQgmZdidhcypvwUkhnrd/fD6vs2E9G1xp
 PvzlKVBhshOGqoWXz3ntS9iOw==
X-Received: by 2002:a05:600c:3b19:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-4954a3db76amr179216375e9.11.1784578307042; 
 Mon, 20 Jul 2026 13:11:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-225b-5200-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:225b:5200:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfabesm15934935e9.10.2026.07.20.13.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:11:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v2 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
Date: Mon, 20 Jul 2026 22:11:33 +0200
Message-ID: <20260720201133.24796-3-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720201133.24796-1-shentey@gmail.com>
References: <20260720201133.24796-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
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

In Linux, the ESDHC_MIX_CTRL quirk is guarded by esdhc_is_usdhc() while
the eSDHC code path uses the standard SDHC interface. Extract the quirk
into a new `usdhc_write()` function.

Fixes file system corruption on emulated i.MX53 where Linux'
esdhc_is_usdhc() returns false. The same likely happens on e500 and
imx25-pdk machines.

Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
cc: qemu-stable
Reviewed-by: Bin Meng <bin.meng@processmission.com>
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


