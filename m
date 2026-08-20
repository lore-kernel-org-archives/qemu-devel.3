Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA78C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zE-0000Y3-MW; Thu, 20 Aug 2026 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zD-0000XG-MF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zA-00059K-TI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso10156875e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787236995; x=1787841795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0TnEHSu4TV5ed22Ma1QTV9Di4HsnlXd0KkLzkOy55/o=;
 b=EddOcT6LfOpWyIGvRqTDQzlQxWN2RTxfUYkYTmKLAks5RYF/cwzu6svWXKJneh/sW+
 gmUEjpeiG5frjwd/O4J0+sc1Y6lEAbDUr/RnPhtEzAq0eXqCtJ/X6QksN5Flcvi0gtPt
 3hnmbXuuALf5zgRz8Bstca+nmpgLxRpjoYMOCS/eOPkkHBzXP0x4XtD+hlszJ8zX2fwa
 6TWVgqoKYuOozBiRQD7fPgl8JIjstQC+KKJ/4M9SUW1svpeqe0bcnGZHIqYC7+G05CKj
 HESt5IybLCNlCL0T+NIiH0asIG7Un+qh6XNZRN5wVzzadQZxCl4lZiN8x7NVaAoruNkD
 fW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787236995; x=1787841795;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0TnEHSu4TV5ed22Ma1QTV9Di4HsnlXd0KkLzkOy55/o=;
 b=VJpbCdJ2tYrl96HphCR6ITs0VEV4WdIbWgF8EypJ0qnMXl7+9NYhGM12Aupuw4A4YJ
 IXsiRAzckkmemAFsI15bWKH3EIG3sODMzGX5YqVRd3z7XavckPPFBSksDP9L/bIazJkd
 GilrNehEltd6VsfuSJEm+5A/h3O9Y8iJ7TO9qXVbsQejnSrgTb2yNErl/zD8iRlfIna5
 H1GinsOu0P3Y/pz/WimEetJ+mdcteTsJfJ2ibI8fhW7xE1qiH2C1rPtgFHn84t5tta+M
 AXvCmjYkzukwXw3tNsSWbawAd7MvtlWoBNLj5VGm4R/l6B9aT1tJk/5Ou2LBlpdEYZnA
 T+Xg==
X-Gm-Message-State: AOJu0YzHZnIoKKcRhgo2GbK2HBMoxc6Q7Pt2fpCB+ZCsp3pgowfoW2/r
 dUFDLwOt1ftVbt9ezN4uh/45fj8hAYmU6JVFf+vw/o0DVbroGSOx0cFWlJKst2uvcgXuZ1YLED8
 m+LYE
X-Gm-Gg: AR+sD12fdjAxvlshgVYVhuS1QkDWcgLKfxRr5wWQvRfzbT5rhH90IXDJNw0DAQofVKn
 m2rNnm/CETD8/2eHJe3gFNJkh+riWMYOFkTQPmZw3jP/C2+VC6k51EHjE+h4UF7zSbqpnQAPSoj
 NIBtoz22sPxC2mwPgyAjjJwzT+OXK7EdD3yQR06ZQLmTuw2C4xgghZNa/BvoL6udWUrtk7oE1Rb
 s5j3z5YmLhpVx2xg1Uo9L3WKblk840Dqv18+pzBBX54j2h3YbghSHFtEvx3Sb1v7ey4/QUf1unI
 M8X/eOnrGMttMY4qF2UrhNR5A3VJsghqKThUHYF6woPNnTNcSa71ayzwvY0N4ZFdbAWLhpYz9Yv
 qBusV60kq/lHTVYHHgyPo4DOlQwBbYcJbH+owIqV/yfmuy8CkqqTNnGltv4IA1ROhnBMGVaqBmg
 2YoekhbPmp6t0VEt6ZWkKE1LLTnq6biFBrOsvL4rJ8NRfHCiFgRDGCXRD68UmnLe3Dbj7n
X-Received: by 2002:a05:600c:8b6e:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-499aa1a8bbcmr243513285e9.7.1787236995088; 
 Thu, 20 Aug 2026 07:43:15 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 02/11] tests/qtest/ide-test: cover the migrated PIO transfer
 window
Date: Thu, 20 Aug 2026 16:43:00 +0200
Message-ID: <20260820144309.835173-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
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

/ide/migration/pio_state_rejected leaves a drive in DRQ so the source
streams ide_drive/pio_state, rewrites cur_io_buffer_offset to the end of
the io_buffer, and expects the destination to refuse the load.

It asserts the window the source wrote before overwriting it, so a wrong
guess at the stream layout fails the test rather than passing it for the
wrong reason.

Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index f14a0851f0..a3109da908 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1571,6 +1571,83 @@ static void test_migrate_chs_rejected(void)
     unlink(path);
 }
 
+/* A PIO transfer window reaching past the io_buffer has to be refused */
+static void test_migrate_pio_state_rejected(void)
+{
+    const char *name = "ide_drive/pio_state";
+    /* IDE_DMA_BUF_SECTORS * 512 + 4, the length of the streamed io_buffer */
+    const gsize io_buffer_len = 256 * 512 + 4;
+    /* cur_io_buffer_offset and cur_io_buffer_len, big endian */
+    const uint8_t in_bounds[8] = { 0, 0, 0, 0, 0, 0, 0x02, 0 };
+    const uint8_t past_the_end[8] = { 0, 0x02, 0, 0x04, 0, 0, 0x10, 0 };
+    QTestState *src, *dst;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    g_autofree char *path = NULL;
+    g_autofree char *uri = NULL;
+    g_autofree char *dst_args = NULL;
+    g_autofree char *stream = NULL;
+    char *window;
+    gsize len;
+    int fd;
+
+    fd = g_file_open_tmp("qtest-ide-stream.XXXXXX", &path, NULL);
+    g_assert(fd >= 0);
+    close(fd);
+    uri = g_strdup_printf("file:%s", path);
+
+    src = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(src, &bmdma_bar, &ide_bar);
+
+    /* WRITE SECTOR(S) waits in DRQ for the data, so pio_state is streamed */
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_low, 0);
+    qpci_io_writeb(dev, ide_bar, reg_lba_middle, 0);
+    qpci_io_writeb(dev, ide_bar, reg_lba_high, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, LBA);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_WRITE);
+    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), DRQ);
+
+    qtest_qmp_assert_success(src, "{ 'execute': 'migrate',"
+                             " 'arguments': { 'uri': %s } }", uri);
+    qtest_qmp_eventwait(src, "STOP");
+    ide_migration_wait(src, "completed");
+    free_pci_device(dev);
+    ide_test_quit(src);
+
+    /*
+     * Behind the name come the version and req_nb_sectors as big endian 32
+     * bit, then the io_buffer array, then the transfer window this rewrites.
+     * Asserting the window the source streamed keeps that arithmetic honest.
+     */
+    g_assert(g_file_get_contents(path, &stream, &len, NULL));
+    window = ide_stream_find(stream, len, name);
+    g_assert(window);
+    window += strlen(name) + 8 + io_buffer_len;
+    g_assert_cmpint(window - stream + sizeof(past_the_end), <=, len);
+    g_assert_cmpint(memcmp(window, in_bounds, sizeof(in_bounds)), ==, 0);
+    memcpy(window, past_the_end, sizeof(past_the_end));
+    g_assert(g_file_set_contents(path, stream, len, NULL));
+
+    dst_args = g_strdup_printf(
+        "-machine pc "
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 -incoming defer",
+        tmp_path[0]);
+    dst = qtest_init(dst_args);
+
+    qtest_qmp_assert_success(dst, "{ 'execute': 'migrate-incoming',"
+                             " 'arguments': { 'uri': %s,"
+                             " 'exit-on-error': false } }", uri);
+    ide_migration_wait(dst, "failed");
+
+    qtest_quit(dst);
+    unlink(path);
+}
+
 /* Words 54 to 58 follow the translation even when the data was cached first */
 static void test_specify_identify(void)
 {
@@ -1764,6 +1841,8 @@ int main(int argc, char **argv)
                    test_migrate_chs_translation);
     qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
     qtest_add_func("/ide/migration/chs_rejected", test_migrate_chs_rejected);
+    qtest_add_func("/ide/migration/pio_state_rejected",
+                   test_migrate_pio_state_rejected);
 
     qtest_add_func("/ide/identify", test_identify);
 
-- 
2.53.0


