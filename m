Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DE1C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggis-0007cS-Gt; Mon, 06 Jul 2026 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiZ-00078s-94
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiX-0003TA-Jg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493d1e8aa46so14425325e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334304; x=1783939104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8l3yST6GZrvLVJku6YOM2ND9IxJ3TA/gXvQHEv8TIoA=;
 b=hamHxj3g/NbP0kBBXpdzY4pDngitVDL+qXVaSfNHMLKKRcLw5D7bNLpEtCnFuIuNEF
 GEQ93ZImhcAM7ccFjZJMkj9NXHZz/HQM30CGO+qs6mg6puAWkegveZnMMc2IPuwJaDKX
 iyvSUXy1xmlb2q14sPW58wod9ngcod3+AYZeFzIyrP1AcfHHUBAKKVz9svnf/UT8U7/i
 srAABdHwuI+TzIwS8fN7g9CZpGMsZN5Lf3E8RSAgjqgGfk0lFBLSNWEtE0MiufN+Z/eA
 FKONSDDqM2HQz9hf4iO/4UrnR0W2IW/KQNrmyaa7DEsPx7RCJD2ZrGOLLqgUIFC8fbJz
 ZEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334304; x=1783939104;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8l3yST6GZrvLVJku6YOM2ND9IxJ3TA/gXvQHEv8TIoA=;
 b=G4+l7tUnGoZAvKlmbDwGhiEkUkJYUaq4XFLaBNxUQ+X/vTj/8ncxl1JVxE2AfMpykm
 JG06/jr+jGhgqcbDVdC2tlLGHv9otHyLnS8xL9Wv2iwZEjDh7LbowjD8hcE2CM09hi3K
 rt2fIG2PRj3yzjzAWUuTtelRt3Og8e5sDjdVHbtKBNxYtBuXvaJBGvBxegfpQnXeclCP
 vpurpfAJf2v2eCcaN7TQqMbY6ebO4IXf8cgNMm38kTVZkkbgSBuK0UsE75IfYND8p1VH
 0wBHFecufFYQFtAjavo/ptcLctj/AEJTDdG6A3kPoSKmaXejVArcnX7qibRYxJZhGHpl
 yZWA==
X-Gm-Message-State: AOJu0Yz91chmntDvriAtEigS+IU8jQ/3cik1FisVj3PJDSBnmPj0dl5J
 GGLNu5pS2Z6vL7nS9lwHyYYuRmrOgdPQ7UR09Qxk04APq0ULvBBCqbZbp/+nHAluqkhka24hkNJ
 6j3c08b1nUA==
X-Gm-Gg: AfdE7ck9Geh5Yr7PKDZmDxmamZ8tf5nkd824Spyi5YoHPHOSLqJYQFSXua2RhX/heao
 udKAfcQF1lC40kvcsF5gnzd1rBRiY85evaCuxZhPsm8RuJLPiOaoMcR6bywGKejWdp/oT0qN0Sw
 2yAuRZdnxB89QB2jrWywl4yOg7qTruGrmyLteGbNZ4J+28Xpo7zxt6k/ID0DXPseAVET6VCIj94
 tsj0Cou0WYts5/KrqC47GzuFFVBnBE1HkMH4ZJ0LX33Mz2lMTcEg/ZbxGX65/BBq7heoO+Pmr/p
 GAPbpVU+2nvRSxAeGYV2RU7kcuXxM2nO9em+jJCqizEq4VbHs5pLPoJp6fAsMWPNfhXex2S7bmi
 0mRhkAMFsh/88mGA6rsFO0E5mGo6bwKZfOMaAv0qtPw3KZrPTVJzO2HudJSKqPG9HpFHQHNNX3A
 AlJ00dXseG/ydgNEsovif9EGeRPcxDwEneQoi+1N7UysL0KSFd3YXQMNP+oCOYTIfer+y0W/SUD
 fijMlHSubKSyTsNI9Gchw==
X-Received: by 2002:a05:600c:8010:b0:493:bb2e:11a5 with SMTP id
 5b1f17b1804b1-493d11d7e1emr111726935e9.15.1783334304088; 
 Mon, 06 Jul 2026 03:38:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/49] hw/nvram: add load_image_to_fw_cfg_file()
Date: Mon,  6 Jul 2026 11:37:30 +0100
Message-ID: <20260706103752.320511-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Function is simliar to load_image_to_fw_cfg() but loads the
image into a named fw_cfg file instead of fixed keys.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260521112806.504961-2-kraxel@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/fw_cfg.c         | 22 ++++++++++++++++++++++
 include/hw/nvram/fw_cfg.h | 15 +++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index a9d45adb2d..b057d870c0 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1139,6 +1139,28 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
     fw_cfg_add_bytes(fw_cfg, data_key, data, size);
 }
 
+void load_image_to_fw_cfg_file(FWCfgState *fw_cfg,
+                               const char *fw_cfg_name,
+                               const char *image_name)
+{
+    GMappedFile *mapped_file;
+    GError *gerr = NULL;
+
+    if (image_name == NULL) {
+        return;
+    }
+
+    mapped_file = g_mapped_file_new(image_name, false, &gerr);
+    if (!mapped_file) {
+        error_report("qemu: error reading %s: %s",
+                     image_name, gerr->message);
+        exit(1);
+    }
+    fw_cfg_add_file(fw_cfg, fw_cfg_name,
+                    g_mapped_file_get_contents(mapped_file),
+                    g_mapped_file_get_length(mapped_file));
+}
+
 static void fw_cfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b75858025f..20e2c7190e 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -399,4 +399,19 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
                           uint16_t data_key, const char *image_name,
                           bool try_decompress);
 
+/**
+ * load_image_to_fw_cfg_file() - Load an image file into an fw_cfg entry
+ *                               identified by fw_cfg file name.
+ * @fw_cfg:         The firmware config instance to store the data in.
+ * @fw_cfg_name:    The name of the fw_cfg (pseudo) file.
+ * @image_name:     The name of the image file to load. If it is NULL, the
+ *                  function returns without doing anything.
+ *
+ * In case of failure, the function prints an error message to stderr and the
+ * process exits with status 1.
+ */
+void load_image_to_fw_cfg_file(FWCfgState *fw_cfg,
+                               const char *fw_cfg_name,
+                               const char *image_name);
+
 #endif
-- 
2.43.0


