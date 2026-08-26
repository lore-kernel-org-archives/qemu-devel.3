Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC97C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbX-0007q7-LD; Wed, 26 Aug 2026 07:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbU-0007nG-E3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:36 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbS-0004Hb-Dm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:35 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so1037776a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742933; x=1788347733; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YFE/K/4vNyqzMwiTk1xBUvuX5IsKmMx8aQ0HWwkIsCk=;
 b=YMi1xQC/BR5aAan5RBfYBRXSCWV+wSzNJJAd80OpYrjEaqjW2Map6YDcytMo7fMNCf
 D6lnsUqkyIgQmRInc0w8KUcEcDo3YVa+1yCxnVBr605oj9nPC4Hi9JVsmI0FO2FOpkMS
 CFaX7Jm+BvgwwjHVlqRNGVCBhKZyLayrrA8NjK5Dw8P1YMKuG3LKrl2+odakOJbCsTV2
 kDVXLpVsgUS24pWYM6Zdg5hWMJORaKqV/sCm++9B81xZGhfu/balBoLHZ6Nz5VjQu+Pp
 GdpvfVXxTa2UUSMJxSpMBKkexcXI05wbFLsfjbXeuAUQ+EVav7cfSCSk55+9hYk13fir
 n17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742933; x=1788347733;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YFE/K/4vNyqzMwiTk1xBUvuX5IsKmMx8aQ0HWwkIsCk=;
 b=bRTGXiwZOwVZ2NpJvcKaQ6EwNGLGhYTbeBjp/ViWEWeQOoqIsVrvNGBQ5OCpycg+4q
 HQhZRmTEbTnpVr9IHr+//KxT/MXVygvQulP+afSNPCU4G664xuPO6oA2A9ZsbXyE3kMI
 y5fFM9NHpklNMxp2mWbSz+VRoEGbtfwb18/A2ZDg2w4GMmyhJgReoWyuKm8ZyLE9V8pQ
 ITttyx5dploxtiWF6os7boGsLyq1Vm2qWamNWLRvo3En2RYh7BUQ8wPZrilRlpoCbjuc
 wUmm/saYKmmHVAIHMylOSI95UC4FUxLSRPZi3EwxMpOBSRzTFFeAkWrV75o9xZrEPhHZ
 C7eQ==
X-Gm-Message-State: AFuF++n3l3dqQObv/gTFYDMg+/4qWIeOCxikrDK/B307eBTymJlz3enA
 567v4KKgRNQAu4zh6HXiGUHxSl4S9hp1aZynP7OCNXWCQiFFCufYca4SHc8CTAmtMkN3+KsZ5x0
 laCYz
X-Gm-Gg: AR+sD11oM9wBo6FjYuTozbrlHtIP7emI+xXMAaqPF7vyzM3VIOwBhabq0KSpBNrIopl
 WyGDLD3gPDlfshz9rNFELYT/G264fyjF1yJCYJaHRDCXi+KpCXdyaqfq9wN63tlcauyENi8wVsN
 rgq44LA8hvm+fgOvqLv+rYAkuyWvlp+BpFVdF+Zo/wGbjlsNsF54DOP7VqHaFqYzhgzMkkvzuZl
 ZAszI2lhxdYdoSLl4P6vF8LW/clWfZRwhlJt5lf77fN9HZMp8+gHFBD+cEiPX6ChS3uF8b+Jzol
 mnTMgpX1v8bip5F8XpBb70y1t6WcTob/QanMsrcNX9f4iZS85pvNiQya56suXl8hFOH+D4eN/tX
 gcTLAagZV1e4aBhh55NQY05IlIpKBQZeCxJyzXVhr85YiwdqICEq/exsF6phs+5DyMrYSIt/C+L
 yinKPmffy/KCh70ENhq/R+qwUTXcDAlKdhqLGUapRIlndVgjvlVA==
X-Received: by 2002:a05:6402:2b98:b0:6a1:f7f4:200b with SMTP id
 4fb4d7f45d1cf-6a5df662229mr8875196a12.12.1787742932914; 
 Wed, 26 Aug 2026 04:15:32 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/28] tests/qtest/ahci: cover the sector count of INITIALIZE
 DEVICE PARAMETERS
Date: Wed, 26 Aug 2026 13:15:19 +0200
Message-ID: <20260826111524.3383479-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=den@openvz.org; helo=mail-ed1-x529.google.com
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

From: Denis V. Lunev <den@openvz.org>

The sector count register of a legacy port is eight bits wide, so
ide-test can only reach the lower end of the range the command has to
refuse. A register FIS carries a 16 bit count, which leaves AHCI as the
only way to ask for a translation of 256 sectors per logical track or
more.

Ask for 0, 256 and 65535 sectors and expect each to be aborted, then ask
for 32 and expect it to be accepted, so that the check cannot pass by
refusing everything.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 71d23fe56a..30d7005626 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -905,6 +905,30 @@ static void ahci_test_flush(AHCIQState *ahci)
     ahci_test_nondata(ahci, CMD_FLUSH_CACHE);
 }
 
+static void ahci_test_specify(AHCIQState *ahci, uint16_t sectors,
+                              bool supported)
+{
+    AHCICommand *cmd;
+    uint8_t port;
+
+    port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    cmd = ahci_command_create(CMD_INIT_DP);
+    ahci_command_set_count(cmd, sectors);
+    if (!supported) {
+        ahci_command_expect_error(cmd, ATA_ERR_ABRT);
+    }
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue(ahci, cmd);
+    if (!supported) {
+        ASSERT_BIT_SET(ahci_px_rreg(ahci, port, AHCI_PX_TFD),
+                       AHCI_PX_TFD_STS_ERR);
+    }
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+}
+
 static void ahci_test_max(AHCIQState *ahci)
 {
     RegD2HFIS *d2h = g_malloc0(0x20);
@@ -1012,6 +1036,21 @@ static void test_identify(void)
     ahci_shutdown(ahci);
 }
 
+static void test_specify(void)
+{
+    AHCIQState *ahci;
+
+    ahci = ahci_boot_and_enable(NULL);
+
+    /* A register FIS carries 16 bits of count, the legacy ports only eight */
+    ahci_test_specify(ahci, 0, false);
+    ahci_test_specify(ahci, 256, false);
+    ahci_test_specify(ahci, 0xffff, false);
+    ahci_test_specify(ahci, 32, true);
+
+    ahci_shutdown(ahci);
+}
+
 /**
  * Fragmented DMA test: Perform a standard 4K DMA read/write
  * test, but make sure the physical regions are fragmented to
@@ -2220,6 +2259,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/migrate/dma/halted", test_migrate_halted_dma);
 
     qtest_add_func("/ahci/max", test_max);
+    qtest_add_func("/ahci/specify", test_specify);
     qtest_add_func("/ahci/reset/simple", test_reset);
     qtest_add_func("/ahci/reset/pending_callback", test_reset_pending_callback);
 
-- 
2.53.0


