Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDCFF9D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdhh-0000qE-BV; Tue, 14 Apr 2026 09:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhf-0000q0-VK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdhe-000809-57
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:21:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso1858061f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776172876; x=1776777676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iR6Z60525WsUcAHnGzZLKIJqtugk1SSKoNFtM74g22c=;
 b=mWTBhqiLyjx88Grp7ur6Fe8IoF185uhRPfE5/ZFPoA4joBRJJRLxFsWSJ5udUnH2gU
 Ux2V3qCG7to1Q1X3T7l0LLYA0aHs/uAi34Kn09ZhEhq+O3WWHLoT5LIESsYZZKYhM6AK
 +hocTTwNFp9Btv/0b/sdfbkHjUhealBwzhZUOAs2NBLiQZponjtPk6B+M0N0g9JQ3OPC
 CsGoFIiWh3SCR8BDXBWsqZxXYWQij86zSK6mjv486+7wIJxgFwKP17OVeXlJy1YG/GOU
 Dp/19oaeoJnq1pKsFNhRB8H3uIHnUJ8vxlD+ohga1GNAX0vO9GgsKQoyiXm0CqPbAjBl
 DzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172876; x=1776777676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iR6Z60525WsUcAHnGzZLKIJqtugk1SSKoNFtM74g22c=;
 b=XkNbz9+OPH9mCxPU4u3X0XzZUIJkMxH17tMqS5hcKhJvO1IyZwYgtYYdfwJC/QilZn
 U6+HYtD+RF/QoDsAPqBzD7iZ4yFWs5w9sVl1ARk3UP6ovbjyqTO+DXPXyiYkVfQ3mnib
 J2j+Jbcnh0oram5Xm5gxKaqi1yud6pinKQ9t/5YGva+bImlCubl9Jod0UuCbhRD7SmuM
 vgQP6KyhXhOpbE22AYZo9wrZjiRUv+36Pcf9dKYxBpthE1RnaRS7Q5rFb557toJJYSDD
 +nqIFEcOZb5YetTYF9GrSZfGoF3lP4YWOv8F0WcvYcrMertmxtA6wfCGLF0S22i3lWRo
 qBzQ==
X-Gm-Message-State: AOJu0YwhnVockztkkAL1J2XOrsmzALWQdBj++EEWrTxTp1qu3boSS6LJ
 OfufAdfNC4ixe566zdYRN6XRO6sI5pDQb846M7xk/eMunZ4S3OLzfdIGL27LoZoXyYcKv38Xf+T
 W1eRfKDI=
X-Gm-Gg: AeBDietRPnMgF1kLv+oXSjnynXGLiwnClq30i3WWlWAlWZpcyHTGy1Fxe8z0XC8O0QX
 wveD1pVn0MyZ92YIqTKFcmjkitjCUwDCc32IdDEOHq+eH+1yfKixpWRBsy4FtiacexzA9LdLo1k
 u7okl/dCIgluCidpRZ18hf7kjaFYXM6hb7BYKkQJ+NINmTr+gzsXJolyCe7MD/W1BK2i39ElTTd
 zCyPdVCTkqB3wLQuBJz1Smpep5xdzeD29AHBZofov4j7HJAD0EBrcdF/kD+REMnXtovNabojsVY
 mlCn/qrnaNRv23v8QXGWHNdqnmdqg18bYhoKyxAj5CHOqlJDZ62Q1yhr0fO8VVRPg4mlFQz9eUd
 OIh9AIYcXeK/spVO6FEiPOKeUdUy5N/14Od9D5Rg+WHUapcJkligIvVEcBVZpYNsXNHouwXDsHS
 ceOchq2BGS9OX3JXXzYNq0W8QrBR7/foE306+ujAj+agLmAQY2X2aZcaFSjMss59pQyiDJ4IOm
X-Received: by 2002:a5d:6a90:0:b0:43d:6fb7:fedb with SMTP id
 ffacd0b85a97d-43d6fb801bamr10964943f8f.36.1776172876195; 
 Tue, 14 Apr 2026 06:21:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6a1203b8sm37370938f8f.16.2026.04.14.06.21.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 06:21:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] hw: q35: fix VGA text console with SMM disabled
Date: Tue, 14 Apr 2026 15:20:58 +0200
Message-ID: <20260414132100.53861-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414132100.53861-1-philmd@linaro.org>
References: <20260414132100.53861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Work around black screen in VGA mode with SMM disabled.

Required by NVMM, HVF and WHPX backends.

https://gnats.NetBSD.org/59721
https://gitlab.com/qemu-project/qemu/-/issues/2608
https://gitlab.com/qemu-project/qemu/-/work_items/3085

Patch written by Taylor R Campbell <riastradh@NetBSD.org>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260413170407.57574-1-mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/q35.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b37..05ef5222f7a 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -372,6 +372,10 @@ static void mch_update_smram(MCHPCIState *mch)
         memory_region_set_enabled(&mch->high_smram, false);
     }
 
+    if (!mch->has_smm_ranges) {
+        goto out;
+    }
+
     if ((pd->config[MCH_HOST_BRIDGE_ESMRAMC] & MCH_HOST_BRIDGE_ESMRAMC_T_EN) &&
         (pd->config[MCH_HOST_BRIDGE_SMRAM] & SMRAM_G_SMRAME)) {
         switch (pd->config[MCH_HOST_BRIDGE_ESMRAMC] &
@@ -405,7 +409,7 @@ static void mch_update_smram(MCHPCIState *mch)
                               mch->below_4g_mem_size - tseg_size);
     memory_region_set_alias_offset(&mch->tseg_window,
                                    mch->below_4g_mem_size - tseg_size);
-
+out:
     memory_region_transaction_commit();
 }
 
@@ -474,15 +478,15 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
     if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
                        MCH_HOST_BRIDGE_SMRAM_SIZE)) {
         mch_update_smram(mch);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
                        MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
         mch_update_ext_tseg_mbytes(mch);
@@ -585,10 +589,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
@@ -604,6 +604,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
                                         &mch->open_high_smram, 1);
     memory_region_set_enabled(&mch->open_high_smram, false);
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     /* smram, as seen by SMM CPUs */
     memory_region_init(&mch->smram, OBJECT(mch), "smram", 4 * GiB);
     memory_region_set_enabled(&mch->smram, true);
-- 
2.53.0


