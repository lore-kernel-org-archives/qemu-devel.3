Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DB6C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfN-0004Wo-H5; Wed, 26 Aug 2026 07:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfL-0004Ri-Kk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:35 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfJ-0005jT-Ay
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so943462a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743171; x=1788347971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0TnEHSu4TV5ed22Ma1QTV9Di4HsnlXd0KkLzkOy55/o=;
 b=OWOyjlKt/ag4vpPeKG2bhFMzN3/7hphsDRJgJAPFQ50eQlSptLOvZMI6lu7S7xYHn9
 HugV9bELR0uSd2AfdRQsK6U3UZ8SdDDNzIm2oFA29xwRLTjw3e2kRdqhucH8B1yBW0FY
 ycGKFJL7pS+zE1TPgQO6daLWE0uexEwhwuJxEtJ/zsuDKyLmKSKp46EAKBosg73OJ53Q
 nN4xgAHdauWdWkw0KGP9a4Veo9iiIAbeKYjQEDELl4cA2oD0pj7mf7XP0nQLqURc+idF
 R5XeX9quqS21QO++w2sXdlWafiLnila/VKoHgio6JMQwqFJa/5b8YjS4oOR6EIx+BSLn
 Ea9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743171; x=1788347971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0TnEHSu4TV5ed22Ma1QTV9Di4HsnlXd0KkLzkOy55/o=;
 b=V6CYdqwdIAfq4fkowXEQMwyG9fKzDUmGS0x7ZPSDD5I8oj5Lb8ZcTP1dtNeNu1ig7o
 A2qBkf05Xd26nF7jJwDPozFiywpYYm/7YrSg1Wt9dzNgAcZH9IKwrvXy743y7Tt8uDTK
 spAl6D7wNi1YUWbEUtUtofloC+sdOrS372KjQOP2cfWpK6C7CA2SjSZ2sYlfp1HDgPqS
 tAbE0+cekme25roaB/syTLlowaBKxR+1hkWhEfNbkg2hOQHvDSJ/v0tOXJuOZVW1zaHj
 1+FtRGprPrT89ccA7ysvyvTcU6CsOZ9xlNuI30a6stUDfCo6lmcORfFaJW27oRAwWPP0
 pKlA==
X-Gm-Message-State: AFuF++mmIZkosZitAR1F8t0zDG4IjcQMchpqbd6zS29/CJ/1oC6QsTiB
 y7c8giGDDNugnVu8wkDXedz+A9z1diVLWEZXbZghyyweBtrZNR0uMiOzuQs9hnwEopaGascUlQb
 bEExW
X-Gm-Gg: AR+sD10bsuDy0k20fD1vknCxz/DCndzhArTATFdiyKjKYWaCuAHy35aqNftPIfu67Bl
 98Gmgf1VnVpTWRCsEBrolYvb3mrIkEvc/nmHLtMF5R2WZWx70x5bo0VQvkjnwDEHBSu0a5d+WfW
 LTl0+JlcNTWv4iWTpk+vPU+ihSX59GS5Dh1Pl2DjQgZtHSKGl4ldZZSjMW01OTMy8t9yAs74Uvm
 2uDdZiRDD2yrJPnxcN7+vQOcrsADFyv6/fdyicFYJbmuY34XcCA1YazBp3dTc/x5uQ6TuipolqS
 6FHIMtSrzuROq6jyxpcacOq0aj8zcQbgVAO6KZRO1VqwCqbW+zHHm59F9132TJlEDNeYt7OPKHL
 f4lYY3RUCuoF0HURrKs3NL32DErJUmpuSdwdNEtBdrlwSbdWOZ20hxEMcYZwqPlLzSzAHLq4521
 TSobVgsjhM35LYgMUaTRD/oiyLU2Z9ijlMX+W80YaFJ36F/OKp
X-Received: by 2002:a05:6402:458a:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-6a5df62b3b2mr8965166a12.10.1787743171232; 
 Wed, 26 Aug 2026 04:19:31 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 19/28] tests/qtest/ide-test: cover the migrated PIO transfer
 window
Date: Wed, 26 Aug 2026 13:19:06 +0200
Message-ID: <20260826111915.3387926-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=den@openvz.org; helo=mail-ed1-x52f.google.com
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


