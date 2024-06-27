Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC7AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrwY-00054d-L9; Thu, 27 Jun 2024 12:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwW-0004mA-AZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwT-0002fs-2o
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424acfff613so25445565e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505547; x=1720110347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRec2147tzGGJgDwnAFCM7MdLQrzjYCwJA0fQ2k29gM=;
 b=j2bDukah92E5GI+Es1yyT9ols8Oga1rWffQYj8kU3o2VANhxXbCuWj+1SXVdPe3KTr
 geUZ/U67fZE+VFAoDnrWD1wTiYqiYa2q5Z4IwJs5sKMOm6qjWAkNgx/GPBqI0/XDVT/J
 ywgaes7IvzXol3uLJT7EEAdb9Bg3S6FbJQO4nqBM9Aa3soGKdzxAJjv0KIHf/bo4iF4d
 Scm4eHZUzHbk5TBt/xFkO+CZXYR6/SfHeOAWh8BQRZ6Opw244uRZomNrrTcv+UqzP7NX
 SETtnAjcI8f3ULD45a9T+ehVAs8Oh3FkUIYbjt52sWjQODxpQFFXG0wswbPubCOrVLgg
 9WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505547; x=1720110347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRec2147tzGGJgDwnAFCM7MdLQrzjYCwJA0fQ2k29gM=;
 b=YRtsQTzIDrpcjai4Ok2u9KgxvOLQd5IMubkYfYtwyaAA4AJvjhD4o1hbA6upELUexc
 jw8PDh2z3CaQCyYv3D8eQlBuseLJEQCQfF+H/GeJzfqL3CSUjXTzrqstMxDLt0775NA6
 cTa/ghTv3PkkXAAiqLzdDEcjrj3jVEhwa1lNlRUfNFOKYfaT+05EpwLVsuDFq04uJy+h
 wh8tB4eAM/qxFGfL7PVGFEHME2VR1yd13a8WHQ+hj9F3w+IZMQlBuJ7oXF9LxybqdSfy
 0qx4GhkM07z6ESNAbUetYQWKrYA0e1oCDG+rsKfXORJ3z5audVaex76rm/jpxMx6Krpk
 LtwA==
X-Gm-Message-State: AOJu0Ywr6sj8He2pNQD+KCuPw9j2lgFV3QYC3Mv/j7HxjEa3GI6QgPZT
 mPuO6JVBU3njAqMZ26P1QuhXMaTV2gwtbxnv+qpbEuRw5E+99ufKbmw52E5/Q9f8aP/MGd333+g
 cyTo=
X-Google-Smtp-Source: AGHT+IGpYCerMVIDXBhaqShg0NZF3BUM0fxmxgNvokf24REYz+KXYfpBqe57o2lDMPu42OWHAxNa/w==
X-Received: by 2002:a05:600c:3b84:b0:425:5f90:ed4a with SMTP id
 5b1f17b1804b1-4255f90ede3mr38178775e9.35.1719505547379; 
 Thu, 27 Jun 2024 09:25:47 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8424698sm75979115e9.29.2024.06.27.09.25.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:25:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 Shengtan Mao <stmao@google.com>
Subject: [PATCH v3 15/17] tests/qtest: Disable npcm7xx_sdhci tests using
 hardcoded RCA
Date: Thu, 27 Jun 2024 18:22:30 +0200
Message-ID: <20240627162232.80428-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Disable tests using 0x4567 hardcoded RCA otherwise when
using random RCA we get:

  ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: assertion failed: (ret == len)
  not ok /arm/npcm7xx_sdhci/read_sd - ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: assertion failed: (ret == len)
  Bail out!

See https://lore.kernel.org/qemu-devel/37f83be9-deb5-42a1-b704-14984351d803@linaro.org/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Hao Wu <wuhaotsh@google.com>
Cc: Shengtan Mao <stmao@google.com>
Cc: Tyrone Ting <kfting@nuvoton.com>
---
 tests/qtest/npcm7xx_sdhci-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/npcm7xx_sdhci-test.c b/tests/qtest/npcm7xx_sdhci-test.c
index 5d68540e52..6a42b142ad 100644
--- a/tests/qtest/npcm7xx_sdhci-test.c
+++ b/tests/qtest/npcm7xx_sdhci-test.c
@@ -44,6 +44,7 @@ static QTestState *setup_sd_card(void)
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x41200000, 0, (41 << 8));
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR);
+    g_test_skip("hardcoded 0x4567 card address");
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
                    SDHC_SELECT_DESELECT_CARD);
 
@@ -76,6 +77,9 @@ static void test_read_sd(void)
 {
     QTestState *qts = setup_sd_card();
 
+    g_test_skip("hardcoded 0x4567 card address used in setup_sd_card()");
+    return;
+
     write_sdread(qts, "hello world");
     write_sdread(qts, "goodbye");
 
@@ -108,6 +112,9 @@ static void test_write_sd(void)
 {
     QTestState *qts = setup_sd_card();
 
+    g_test_skip("hardcoded 0x4567 card address used in setup_sd_card()");
+    return;
+
     sdwrite_read(qts, "hello world");
     sdwrite_read(qts, "goodbye");
 
-- 
2.41.0


