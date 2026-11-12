Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=skZrpkbL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUxe-0002i8-Qt; Thu, 12 Nov 2026 08:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xRUxE-0001ns-6y
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:35:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xRUxA-00006g-C3
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:35:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so45763215e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794490498; x=1795095298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iKFzyWxCcdNGNtIspRvDpYD08/r3l4C/LJ45N2+JdDk=;
 b=skZrpkbLiHSFPSsRmBmhPQ7rnjqC+EDQbhotvw9zB4KiwonOHhHUXMZPzUo82T0pNr
 MPAbzjOAHo7QY9Pq1yL+r/y25IXRuyxpG61FNBoFzF+CFNGA/TRJ3l+iCl2o7MefWs0Y
 9hXZLq0rJz9oZ2ynoR0Zuwe6kgPoecRtThBAa4zFnx9u3KgrdmH24Q8pFLVrbrDJ8MRU
 K0EPecLlCy1R00eQFlhTmDZXth6hIYE9Mv4na09ZkBn4lSM8nGIhL9WFNBkvetRDRSHJ
 ObkZzGK8W+Mf+82Ln6dPTZnWN+Mb+XSbyG4obk5w7wu+3fk+k1Jle9GR0nBWicsq9z8c
 Ea/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490498; x=1795095298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iKFzyWxCcdNGNtIspRvDpYD08/r3l4C/LJ45N2+JdDk=;
 b=fIoOCaaIh/dvWUPepmSGqkLyXjxA4T8TaLz7T2cE0I2cKIoEQKuCWJuNkwCxeAvPVO
 VLlzdm2MaM6jFAu4wSdd6LuOrVG8N9rufAhTRcIVdtR0YidmMW4S4lo3mpCLWSrciFeN
 fiwNkadIc9FH2IqDdWMZlwRD1rRE5dDE8zV7QEp4xH8YVsi4c0dkcGw4bd+EIUHNstmk
 1L0IfbfdfDlU84DUSsaBuf4DxFihbU/XwXKFSvstUjkfrjwpmfOv0IOXz6DSV2EcVacC
 LNxO/2UaPrGXFO0wNLwk382PEnkP3KCGwkJEyYLD6NACBli7rgKDSD1UlHqqI9QZ76R4
 QIkA==
X-Gm-Message-State: APuU4Z88EqjLs4WbfJrYze7z4dtTBUWpqL3g1Mc0ul/chs5E21GqiX3H
 AiPKq2DL39ariVNHHUjQoSuyUkBPSX2hFasJMGN6BzDw8Uo/gm0Cu/iNwbH7sjtotwj7es9KS/w
 vuBCd
X-Gm-Gg: AYBFou0R+My4u0WYZTcIlAjblt4h2I2V+2Vl9+XXfiREF2SHjrxrRyriP+M5hPib84V
 EH31wJTTCASWm2cZvU1EskI/vJg4QzLXh1S4xX2PQcfDRlfqOmWZn+H+NrROZJSJjRLpNQ6vKJK
 CBq/MAExJ59eLp1tBVx4/6WMzBju8m7mjPa2vUzLrMNK3NC+4IZs3EOsCm+CZCOrqrrisSydTqT
 DxVQPdNQqXIeICjrxCoflhoAxygZnQ0bzg76fpI4rb6lpygvMEWW9kEDkG24P1BF3X7JX9SZ2ya
 dW59jXY7momkbOywzhXNoqnvo6bvazUMtYOVLhJckOTk1VTq6m55CUhQyxddyTQMnYB5ovkr5xE
 XHED11CKHke6PVLsnKCB/nki1QUyWzHuzzUiHOO8dQYHQ5YCmon8iVCxPXV+iMbvxPTYlI0a67c
 PefemX5SBdFPaePAEsoeZgjB08r9tM+k0qNEsFGscPsDSgBwm1tzGixiZ3T/9qAvwtvfCdNy8+J
 7fH1EVDf0rtg71WMNBa4aQe/lcxWrAN0ahzr9RCrqzsrm6tH55ZsJuczeQBzBF4CMYn2L/ntmbZ
 +ghGoQUe+JMmqPE5gDDDZ5l96g==
X-Received: by 2002:a05:600c:4704:b0:4b3:8529:eb27 with SMTP id
 5b1f17b1804b1-4ba09389f82mr107376115e9.27.1794490498054; 
 Thu, 12 Nov 2026 05:34:58 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4137:317f:4748:6f80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2acf81sm66382275e9.14.2026.11.12.05.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:34:57 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31
Date: Thu, 12 Nov 2026 14:34:55 +0100
Message-ID: <20261112133455.604657-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

cmd_read() and cmd_read_cd() check the 32-bit LBA from the CDB against
the medium size, then pass it to ide_atapi_cmd_read() as an int. On a
medium larger than 4 TiB, a read at LBA 2^31 or above passes the range
check, turns negative and trips the assertion:

  hw/ide/atapi.c:315: ide_atapi_cmd_read_pio: Assertion
  `0 <= lba && lba < (s->nb_sectors >> 2)' failed.

Reading the last sector is enough, e.g. a UDF anchor probe, so the
guest aborts QEMU just by looking at the disc.

Pass the LBA as uint32_t, which is what the CDB carries, and widen
IDEState.lba to int64_t so it holds every valid LBA and keeps -1 as
the "not a sector read" marker. The field is not migrated.

Fixes: b8d7f1bc5927 ("ide: atapi: check logical block address and read size (CVE-2020-29443)")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
---
 hw/ide/atapi.c           | 18 +++++++++---------
 hw/ide/macio.c           |  2 +-
 hw/ide/trace-events      |  8 ++++----
 include/hw/ide/ide-dev.h |  2 +-
 tests/qtest/ahci-test.c  | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 0ea149ad8c6..2c928de8db8 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -47,7 +47,7 @@ static void padstr8(uint8_t *buf, int buf_size, const char *src)
     }
 }
 
-static void lba_to_msf(uint8_t *buf, int lba)
+static void lba_to_msf(uint8_t *buf, int64_t lba)
 {
     lba += 150;
     buf[0] = (lba / 75) / 60;
@@ -71,7 +71,7 @@ static inline int media_is_cd(IDEState *s)
     return (media_present(s) && s->nb_sectors <= CD_MAX_SECTORS);
 }
 
-static void cd_data_to_raw(uint8_t *buf, int lba)
+static void cd_data_to_raw(uint8_t *buf, int64_t lba)
 {
     /* sync bytes */
     buf[0] = 0x00;
@@ -309,10 +309,10 @@ static void ide_atapi_cmd_reply(IDEState *s, int size, int max_size)
 }
 
 /* start a CD-ROM read command */
-static void ide_atapi_cmd_read_pio(IDEState *s, int lba, int nb_sectors,
-                                   int sector_size)
+static void ide_atapi_cmd_read_pio(IDEState *s, uint32_t lba,
+                                   int nb_sectors, int sector_size)
 {
-    assert(0 <= lba && lba < (s->nb_sectors >> 2));
+    assert(lba < (s->nb_sectors >> 2));
 
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
@@ -409,10 +409,10 @@ eot:
 
 /* start a CD-ROM read command with DMA */
 /* XXX: test if DMA is available */
-static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
-                                   int sector_size)
+static void ide_atapi_cmd_read_dma(IDEState *s, uint32_t lba,
+                                   int nb_sectors, int sector_size)
 {
-    assert(0 <= lba && lba < (s->nb_sectors >> 2));
+    assert(lba < (s->nb_sectors >> 2));
 
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
@@ -427,7 +427,7 @@ static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
     ide_start_dma(s, ide_atapi_cmd_read_dma_cb);
 }
 
-static void ide_atapi_cmd_read(IDEState *s, int lba, int nb_sectors,
+static void ide_atapi_cmd_read(IDEState *s, uint32_t lba, int nb_sectors,
                                int sector_size)
 {
     trace_ide_atapi_cmd_read(s, s->atapi_dma ? "dma" : "pio",
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index a95e68083f4..6f62d018849 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -396,7 +396,7 @@ static void ide_dbdma_start(const IDEDMA *dma, IDEState *s,
     MACIO_DPRINTF("\n\n------------ IDE transfer\n");
     MACIO_DPRINTF("buffer_size: %x   buffer_index: %x\n",
                   s->io_buffer_size, s->io_buffer_index);
-    MACIO_DPRINTF("lba: %x    size: %x\n", s->lba, s->io_buffer_size);
+    MACIO_DPRINTF("lba: %" PRIx64 "    size: %x\n", s->lba, s->io_buffer_size);
     MACIO_DPRINTF("-------------------------\n");
 
     m->dma_active = true;
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index c44eec6c585..dc34b09c613 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -52,17 +52,17 @@ bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"
 
 # atapi.c
 cd_read_sector_sync(int lba) "lba=%d"
-cd_read_sector_cb(int lba, int ret) "lba=%d ret=%d"
-cd_read_sector(int lba) "lba=%d"
+cd_read_sector_cb(int64_t lba, int ret) "lba=%"PRId64" ret=%d"
+cd_read_sector(int64_t lba) "lba=%"PRId64
 ide_atapi_cmd_error(void *s, int sense_key, int asc) "IDEState: %p; sense=0x%x asc=0x%x"
 ide_atapi_cmd_reply_end(void *s, int tx_size, int elem_tx_size, int32_t index) "IDEState %p; reply: tx_size=%d elem_tx_size=%d index=%"PRId32
 ide_atapi_cmd_reply_end_eot(void *s, int status) "IDEState: %p; end of transfer, status=0x%x"
 ide_atapi_cmd_reply_end_bcl(void *s, int bcl) "IDEState: %p; byte_count_limit=%d"
 ide_atapi_cmd_reply_end_new(void *s, int status) "IDEState: %p; new transfer started, status=0x%x"
 ide_atapi_cmd_check_status(void *s) "IDEState: %p"
-ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors) "IDEState: %p; read %s: LBA=%d nb_sectors=%d"
+ide_atapi_cmd_read(void *s, const char *method, uint32_t lba, int nb_sectors) "IDEState: %p; read %s: LBA=%"PRIu32" nb_sectors=%d"
 ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
-ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; aio read: lba=%d n=%d"
+ide_atapi_cmd_read_dma_cb_aio(void *s, int64_t lba, int n) "IDEState: %p; aio read: lba=%"PRId64" n=%d"
 # Warning: Verbose
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
 
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index f5eaaf68e65..c6fd8d7eb1f 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -101,7 +101,7 @@ struct IDEState {
     int packet_transfer_size;
     int elementary_transfer_size;
     int32_t io_buffer_index;
-    int lba;
+    int64_t lba;
     int cd_sector_size;
     int atapi_dma; /* true if dma is requested for the packet cmd */
     BlockAcctCookie acct;
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 291f29e762c..37f6dee0a7f 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1737,6 +1737,40 @@ static void test_cdrom_pio_raw(void)
     ahci_test_cdrom_raw(3, false);
 }
 
+/* Regression test: read the last sector of a medium over 4 TiB. */
+static void ahci_test_cdrom_high_lba(bool dma)
+{
+    AHCIQState *ahci;
+    g_autofree unsigned char *tx = g_malloc0(ATAPI_SECTOR_SIZE);
+    uint64_t lba = (uint64_t)INT32_MAX + 1;
+    AHCIOpts opts = {
+        .size = ATAPI_SECTOR_SIZE,
+        .lba = lba,
+        .atapi = true,
+        .atapi_dma = dma,
+        .post_cb = ahci_cb_cmp_buff,
+        .opaque = tx,
+    };
+
+    ahci = ahci_boot_and_enable("-blockdev driver=null-co,node-name=cd0,"
+                                "read-only=on,read-zeroes=on,size=%" PRIu64 " "
+                                "-M q35 "
+                                "-device ide-cd,drive=cd0 ",
+                                (lba + 1) * ATAPI_SECTOR_SIZE);
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_10, &opts);
+    ahci_shutdown(ahci);
+}
+
+static void test_cdrom_dma_high_lba(void)
+{
+    ahci_test_cdrom_high_lba(true);
+}
+
+static void test_cdrom_pio_high_lba(void)
+{
+    ahci_test_cdrom_high_lba(false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2427,6 +2461,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
     qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
+    qtest_add_func("/ahci/cdrom/dma/high_lba", test_cdrom_dma_high_lba);
+    qtest_add_func("/ahci/cdrom/pio/high_lba", test_cdrom_pio_high_lba);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
-- 
2.53.0


