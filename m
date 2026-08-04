Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06368C55ABF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIVO-000097-JA; Tue, 04 Aug 2026 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIVM-00008B-Uf
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIVL-0000jO-5w
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso25416f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785862838; x=1786467638; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OtCL941QaxVDzOMEP5QDrXt6XcRnskNWRDsBxWp3Og4=;
 b=fIFR4kIifoU2rIk8QgWCK3emgPTEvv6nl4PWWrv3+QcklJPalGObZAcrwv0uPaV400
 HwU48RprDZNYDzIQHjeofZYSpn0vxpWd9JxxEUHr/VIkJtJVqUB8tMV9h9MdOgAHeH59
 R5RT4oyLvwopFFFbTEa9QuHSXEYSczkKPXxHC5ZOsxxLATEsLn56mkSdqp2gNIR6hlNJ
 m9gXnpogUL2JHCFDlfvRs/3eLkt14pH1BbUrtF2bxEPG2W550AnLR3+MAYFpJ3i5nPrx
 PiruEb60JTn42hbGOz2hevsA504BPmbkxf3uEDfIhwp7uwIy3SCFLG6NPV/V4HcaYMuP
 tUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785862838; x=1786467638;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtCL941QaxVDzOMEP5QDrXt6XcRnskNWRDsBxWp3Og4=;
 b=sEaCQSjiJLRDd+HCoGlDNYg4l/jGaAeWadHVQz/aICb5m6c9uQuLW/mNdlfq1y9sY7
 DlpclYRtuXQHc+JNvaMFYNvsKEf85vqAsE2qCnPa/DjsAHvavrWtyhRvKyuS45eOQB5D
 S00v/3vrNoZsHEsazU4k78a9sfHkRFArl6ISLeAZ30poIva4e6qWerTMjnqVmvEzd7fN
 U8/73M1ifh0ymIcQjtUoroIZK2PUhWZpb3TNvrkrqLy7z9nw6+rnBBz8KhrTwW8Zxvm1
 cHK5feJ1yvjZqOZZq/0NFLt2lRyzihwgUyIxV5iJA7rhezCLZy+TipiZWxbCBITo9nk1
 PQsQ==
X-Gm-Message-State: AOJu0YyDv1MvbmKPDQKrUdV1HygQWhC2sLlVvJUPLOMN/8STujyLiSF4
 Nj7JTa95X0YXErpbSvmilB2YFbOx1f3n+mqx1F06uVQFc7WzGhuSRN3AIUL3OLE7iDs4scLQ8EA
 5D9Jc
X-Gm-Gg: AR+sD11vLSMOTX4ZfCSmtcOhly661zrycgvMioF4iBsIteTratbRPOjkNzAhm6yHXcU
 oon6SH7IOpWSFNflVzVimDbSYQzTf8HPIljoU/IcsYIOcb1DRtu6FIOW7TwBTZewhlQ3ZNSpq8K
 jE+9tlfdkYY0iCXdYohldvhmF4yt0xMVuV5ptunu+cvS9rZOdHeUynlbGW1ppXZ3tSNrSFC3jLp
 cNtfYs+QsOADGbS1PHUfuAxCGVshMvgZ3mLUBMGUxcRruDF5TCx/VN6Ji1SwD1xEfuMKlTA7S+2
 PKDtpfknUXR0INRZJ8hi2auRvlgWWQq2xtg4hT5hKx0y1Wzm+ao3rD0KLXOX5cRvRSYWKD8qKEU
 nVi84zPWp2R2rhTA4s3L9ke9kNbPUo9XR1RRGyVoYJM2rq/8PeIxcjvSVW4IzHpM6NrzRnpbBuW
 1yPxy3vw9iGLaKgtiKqOas1Z4+vwM0d4hyhinbL5MRzDOUtw==
X-Received: by 2002:a05:6000:46d0:b0:47f:83ee:e56f with SMTP id
 ffacd0b85a97d-47fec634c42mr822651f8f.18.1785862837688; 
 Tue, 04 Aug 2026 10:00:37 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ec3asm1234116f8f.31.2026.08.04.10.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:00:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 7/7] tests/qtest/ahci: regression test for ATAPI read vs.
 drain
Date: Tue,  4 Aug 2026 19:00:14 +0200
Message-ID: <20260804170015.3128363-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
References: <20260804170015.3128363-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
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

Add /ahci/cdrom/drain/{pio,dma}: issue a multi-sector ATAPI read whose
byte-count limit spans two sectors so the device must rebuffer in the
middle of the DRQ burst, hold the backend read in flight with a
blkdebug delay, and fire x-blockdev-set-iothread -- which runs
bdrv_drain_all_begin() exactly like a guest reset does through
virtio_blk_stop_ioeventfd().

On the unfixed PIO path the nested sector fetch is queued behind the
drain and the main loop wedges, so the test hangs. The DMA variant
never rebuffers and serves as a sanity twin.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ahci-test.c | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 58bc04b3ef..71d23fe56a 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1754,6 +1754,70 @@ static void test_atapi_engine_restart_dma(void)
     test_atapi_engine_restart_in_flight(true);
 }
 
+/*
+ * Regression test: a multi-sector ATAPI read fetches its later sectors from
+ * inside the first read's completion; a concurrent drain (as a guest reset
+ * triggers via bdrv_drain_all_begin) must not wedge on that nested read.
+ * blkdebug keeps the read in flight across x-blockdev-set-iothread.
+ */
+static void test_atapi_drain_in_flight(bool dma)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    uint8_t port;
+    uint64_t buffer;
+    uint16_t bcl = ATAPI_SECTOR_SIZE * 2;
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * 3;
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+
+    /* 1s read delay: a wide margin so the drain starts before it completes */
+    ahci = ahci_boot_and_enable(
+        "-blockdev driver=file,node-name=file0,filename=%s,read-only=on "
+        "-blockdev driver=blkdebug,node-name=cd0,image=file0,read-only=on,"
+        "inject-error.0.event=none,inject-error.0.iotype=read,"
+        "inject-error.0.errno=0,inject-error.0.delay-ns=1000000000 "
+        "-M q35 "
+        "-device ide-cd,drive=cd0 ", iso);
+    port = ahci_port_select(ahci);
+
+    buffer = ahci_alloc(ahci, bcl);
+    qtest_memset(ahci->parent->qts, buffer, 0x00, bcl);
+
+    cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, bcl, dma);
+    ahci_command_adjust(cmd, 0, buffer, bcl, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Drain (all nodes) while the delayed read is still in flight. */
+    qtest_qmp_assert_success(ahci->parent->qts,
+        "{ 'execute': 'x-blockdev-set-iothread',"
+        "  'arguments': { 'node-name': 'cd0', 'iothread': null,"
+        "                 'force': true } }");
+
+    /* Round-trip through the device to confirm qemu is still alive. */
+    ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, buffer);
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_atapi_drain_pio(void)
+{
+    test_atapi_drain_in_flight(false);
+}
+
+static void test_atapi_drain_dma(void)
+{
+    test_atapi_drain_in_flight(true);
+}
+
 /* Regression test: Test that a READ_CD command with a BCL of 0 but a size of 0
  * completes as a NOP instead of erroring out. */
 static void test_atapi_bcl(void)
@@ -2177,6 +2241,8 @@ int main(int argc, char **argv)
                    test_atapi_engine_restart_pio);
     qtest_add_func("/ahci/cdrom/engine_restart/dma",
                    test_atapi_engine_restart_dma);
+    qtest_add_func("/ahci/cdrom/drain/pio", test_atapi_drain_pio);
+    qtest_add_func("/ahci/cdrom/drain/dma", test_atapi_drain_dma);
 
     ret = g_test_run();
 
-- 
2.53.0


