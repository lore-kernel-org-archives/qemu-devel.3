Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8E3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Kp-0006kT-23; Mon, 17 Aug 2026 16:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KT-0006aV-0n
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KR-0006kF-3m
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so46061735e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999984; x=1787604784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHXpzZRkIeCsmDYCvmaEnMukQmAiI91OuLyzWCMD7vo=;
 b=Ce7ODTsZ2FxDurKM0kSEnF4isiVcWeCNYpjYucPxIPUD3AiAgEgqi0n1X2hkTMJujO
 Bsp3iwFRVQmNlPSX+1IgSa2ExnwjLbovrmHJCZ6rNe5xJrf+d4eYayzeMiII5r0xeAKy
 dXDSy2RrHxkXHjrsx2jToLBQQ2fj8cRJJQWozQoWHeoL80vtfSEn8pk38mZgzHQDjUJ/
 xh/8RcTEYD7a9iec/eNHoGTGC0GECLL7I43e7cD2x5hO05SpxlOaG/8DFC2OYz6wdCTT
 Yj0GY88ryRJnAvm5m4iLn/ZHXXwpDCxDFbhPAjygssHzPGEsE/Cc5sijlgAEhdlJy2/f
 MNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999984; x=1787604784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHXpzZRkIeCsmDYCvmaEnMukQmAiI91OuLyzWCMD7vo=;
 b=S1x64GsJBv1B3azYc93oKaRSBrVHKd2xaeo4aK5h/ndacrr4Ej0yfilWuFaMVCVbTf
 QGS1AUy3iNCTlNbXnyQxs1iR1NbVDVF4qQu1No2mwSb2sKjJlr/dTm2mEaytiOfoUH/Q
 X6jycwuWVAsB1z5ke5dDopOWMtjYMgNmB75mPJ17oJ+TluAU1N9DJ/OgKzDl3stt6frD
 BrwVOVqOdXPU43zvXf8xa2TxFOpwx0AwrnO/XumhDMYJ8VoBxeOwXSZLqC5sg95nnUdk
 426AYsiZeTa2hr6nI8NkkxCVTu6Vmf8YuJaEkRg2MLIXPlQ5x6alDN1WqMG29wTs0Icw
 EVpg==
X-Gm-Message-State: AOJu0YyQglJ1sLBn6NsGhNAn3YsPAjSVnzuJFHMr451ugpauADNOTnRj
 FiYOEUOMCXkHGKdW0vCT12q4KYMwYCoKm8t00EeNhkmZ7qxSHYypLz7U+oay0Qjc8uMkr5MYxUb
 dKR5w
X-Gm-Gg: AR+sD12gLD7cUiLhJYwh3NssJbcbD0dhm7OQLGkemonuI7+8ZOABrvEorCV5DrkFE7e
 +fIUSq9M7hYcshBuvoqZn0qUOINtqbe0NqPCStRd5286yCoN/qw8umGTeQlCZ1eRCrLN1LXLtkx
 JLf0Q8jFAzOCu9qTTAuDfNdn93C3vg+qTMtsfBfq5M2LVCwt2x6ZN8khgfUOROd56nrQgrQi6cr
 5Yt9pvi1nmPPpybYqbyfLcztYviHWbpZcBeZgGye6PA/JvmlsFA8+f3wvB1KuE3Nzn6R1If1VhW
 EWN0tjdPPNcJpF9VzCp/zy1VGf07bjQsLFxbhG/wEZFpYFtC+caN8MdS2OsFmiYfm/OSvfcWlky
 IozpFvzTnrw4qvjjrG0HirR9LVR/ikuw9usVxuTx8Fbt0Gf1srCBl7sZ+ByZR0KCFP7mLjLrP26
 4vjIm6A9vKnTTdtQ4iAGihhTCNE1oeNMvu8PTspZkJ5WKPG3xgeyPCScyJt9sy
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-499878ca13bmr499428345e9.0.1786999984527; 
 Mon, 17 Aug 2026 13:53:04 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:53:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 14/15] tests/qtest/ide-test: cover the CHS translation across
 resets
Date: Mon, 17 Aug 2026 22:52:41 +0200
Message-ID: <20260817205242.1199851-15-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
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

A translation the guest selected has to survive a software reset and not a
hardware one, and the two arrive at the same ide_reset(), so a fix for
either direction can break the other. Select a translation, put the drive
through a software reset and then through a machine reset, and name the
sector each translation picks along the way.

The marker read says which translation the device is addressing the disk
with, while IDENTIFY DEVICE words 55 and 56 say which one it reports. The
machine reset leaves the PCI command register cleared, so the device has
to be enabled again before the ports answer.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index e7a56e0710..f14a0851f0 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1639,6 +1639,51 @@ static void test_specify_identify_default(void)
     ide_test_quit(qts);
 }
 
+/* A hardware reset reverts the translation (ATA-5 9.1), SRST does not (9.2) */
+static void test_specify_reset(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar, ide_bar2;
+    uint16_t buf[256];
+    char marker[9];
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+    ide_bar2 = qpci_legacy_iomap(dev, IDE_BASE2);
+
+    ide_prepare_markers(qts, dev, ide_bar);
+    ide_set_translation(dev, ide_bar, 8, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    qpci_io_writeb(dev, ide_bar2, 0, IDE_CTRL_RESET);
+    qpci_io_writeb(dev, ide_bar2, 0, 0);
+    ide_wait_clear(qts, BSY);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[55], ==, 8);
+    g_assert_cmpint(buf[56], ==, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    qtest_qmp_assert_success(qts, "{ 'execute': 'system_reset' }");
+    qtest_qmp_eventwait(qts, "RESET");
+    qpci_device_enable(dev);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[55], ==, 16);
+    g_assert_cmpint(buf[56], ==, 63);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1714,6 +1759,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/specify/identify", test_specify_identify);
     qtest_add_func("/ide/specify/identify_default",
                    test_specify_identify_default);
+    qtest_add_func("/ide/specify/reset", test_specify_reset);
     qtest_add_func("/ide/migration/chs_translation",
                    test_migrate_chs_translation);
     qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
-- 
2.53.0


