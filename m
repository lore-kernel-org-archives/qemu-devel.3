Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B99C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7rY-0001hW-F7; Wed, 12 Aug 2026 08:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rT-0001e1-MS
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:11 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rR-00088e-91
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso490345f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786536908; x=1787141708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sexA7hI5SCiJnZmgARR0bNPIdBe4DuWTRVCdN4vwtBI=;
 b=IHtZbdFd4kbJdLWCrHCCyOXogUfYoFg/PE8tj8PMpnu9aEQ4eTvtDZmagfjzdtQOwN
 6Fl+RB/iR6vPAmJ2xCWglx3hqzLeQmVkuonpFC/7I+L9RJOfWo2SKIEiUqWflxaot8ec
 FyPiHNcC9lz00n3DHmYCt6WU0AVsT7m0cwHuIe3sDe3T2FbqEMZiUAcH2zrZeKuJIlvy
 YbYrDCGEGYI5vM/8Y/tmGsgGKh2VbqXxbTEhWsV4RP5uST/HoImXuBtNyuhYEhbsgGNk
 2vAWSai3ZJzCpBWCBT+A1DkvUHDTpyqnT11w97adQosxDrDIxoPHxzvPk2RPAYiIMN8t
 8GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536908; x=1787141708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sexA7hI5SCiJnZmgARR0bNPIdBe4DuWTRVCdN4vwtBI=;
 b=G1doX76NYWfDYUEx26tqMbmFwNruM5m6zBIUjWDSjhGDQquD9H/LFMylosMato6+4/
 /BB7bLUF4oYH+fcSFW7VTR8yfuD7MV3E/Klay9A0KFptJ1eAvgaX9hPn+NZVIOU0EU2E
 HLOLaBw5ZGLD1xaQ23mR1nvyGoZd4NFV6xPy81+JgAFMTR/ROVKR+x/UmFuAGbJqEnsI
 elv3g9u0eQX+/F4hSnkouvim14kJzq3Dfn28hJwpQjcMpjVa7NF3oWPUVs0i4pXpGjMP
 GWqcdPXK/l96LNs3Y+mXuLzjhiJ+tsFA7X4+j92eRs8QruPGcspvLX1sMNv/kcGYHF5E
 DYpw==
X-Gm-Message-State: AOJu0Ywa42MjGWT98p2puo5xajKbz6cVacZTsOf546QS8+CrOPTdESqj
 BdnPW+36DeKmKtrkWIakEsOLOC6lZTlmfEXvxv1XM9TYyIYJ2sOriJ0/9im5/wuoZERuyEwxVEP
 WayfF
X-Gm-Gg: AR+sD10mZOwVND4L7Aa0rDXXBPbnzf2lkXHSsk3aUUvr99uEKOK1uKaxbIvqsrX9QL2
 psrFry5hVs24C7TzbRwedMbquqt4avfecKDeYV+Aw5sh5K5nG8JBPshcIVAaRSxW8zSwm951iPT
 WEKoAhPem7AK+Y79ApxvA3y713gmtIoB7mKKYPu8nTvWkv8SXcJ5x1cXoWEsSKUWq5pfJO0zZsL
 uDWqrY2jzdW8+zzInSHmxycep5dXhAV7gQok6GVbNGzomGhG9Sa4LkiGqxJ4edePgCPOHlW3XJp
 pGSduo/61bAxOEg9WIHeLLvuH0rJIk8BdmnW7STW0JEoYXf9vbSO6fKUo5vKqeaEZ41BeATb4GA
 VtvjN+IjC12jaC3MqOPVwJzeAcrVfwc8kl8/UsHMe+9ddtmZKC9IIMr1uCSCfiu76s12WSGrovw
 hlEntMLrN8xEwIObmic9GAdwRK9xvDRHLRkkfcF+K4w0F7fkwkqCrkddit6w==
X-Received: by 2002:a05:600c:c494:b0:499:7a36:88b with SMTP id
 5b1f17b1804b1-4997c0c4983mr49518955e9.5.1786536907481; 
 Wed, 12 Aug 2026 05:15:07 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad267c2sm49069945e9.0.2026.08.12.05.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:15:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 3/4] tests/qtest/virtio-scsi: cover a replacement that changes
 the size
Date: Wed, 12 Aug 2026 14:14:59 +0200
Message-ID: <20260812121500.1034178-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
References: <20260812121500.1034178-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
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

Realize a scsi-hd on a 1 MiB node, replace it with a 128 MiB one using
qom-set, and check that the device reports CAPACITY DATA HAS CHANGED and
then serves a read which only fits in the new node.

Both halves regress on their own. Without the notification from
bdrv_replace_child_bs() the first command after the replacement fails with
ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF RANGE instead of the unit
attention. Without the refresh in scsi_disk_resize_cb() the read after it
is refused the same way, since nothing here issues READ CAPACITY.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/virtio-scsi-test.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index e2350c52f6..f82b7e5de9 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -236,6 +236,53 @@ static void test_unmap_large_lba(void *obj, void *data,
     qvirtio_scsi_pci_free(vs);
 }
 
+/* Test replacing the backing node with one of a different size */
+static void test_replaced_node_size(void *obj, void *data,
+                                    QGuestAllocator *t_alloc)
+{
+    QVirtioSCSI *scsi = obj;
+    QVirtioSCSIQueues *vs;
+    uint8_t buf[512] = { 0 };
+    /* READ(10), LBA 0, transfer length 1 */
+    const uint8_t read_low_cdb[VIRTIO_SCSI_CDB_SIZE] = {
+        0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    /* READ(10), LBA 0x1000 (2 MiB), transfer length 1 */
+    const uint8_t read_high_cdb[VIRTIO_SCSI_CDB_SIZE] = {
+        0x28, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    struct virtio_scsi_cmd_resp resp;
+
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi->vdev);
+
+    /* LBA 0 is inside the 1 MiB node the device was realized with */
+    virtio_scsi_do_command(vs, read_low_cdb, buf, sizeof(buf), NULL, 0, &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, GOOD);
+
+    /* Swap in a 128 MiB node; the device is not reset by this */
+    qtest_qmp_assert_success(global_qtest,
+                             "{'execute': 'qom-set', 'arguments': {"
+                             "  'path': '/machine/peripheral/scsi-hd0',"
+                             "  'property': 'drive', 'value': 'big'}}");
+
+    /* The guest has to be told that the capacity it knows is stale */
+    virtio_scsi_do_command(vs, read_high_cdb, buf, sizeof(buf), NULL, 0, &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, CHECK_CONDITION);
+    g_assert_cmphex(resp.sense[2], ==, UNIT_ATTENTION);
+    g_assert_cmphex(resp.sense[12], ==, 0x2a);
+    g_assert_cmphex(resp.sense[13], ==, 0x09); /* CAPACITY DATA HAS CHANGED */
+
+    /* LBA 0x1000 is past the old node but well inside the new one */
+    virtio_scsi_do_command(vs, read_high_cdb, buf, sizeof(buf), NULL, 0, &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, GOOD);
+
+    qvirtio_scsi_pci_free(vs);
+}
+
 static void test_write_to_cdrom(void *obj, void *data,
                                 QGuestAllocator *t_alloc)
 {
@@ -365,6 +412,18 @@ static void *virtio_scsi_setup_4k(GString *cmd_line, void *arg)
     return arg;
 }
 
+static void *virtio_scsi_setup_replace(GString *cmd_line, void *arg)
+{
+    g_string_append(cmd_line,
+                    " -blockdev driver=null-co,read-zeroes=on,"
+                    "size=1048576,node-name=small"
+                    " -blockdev driver=null-co,read-zeroes=on,"
+                    "size=134217728,node-name=big"
+                    " -device scsi-hd,id=scsi-hd0,drive=small,"
+                    "lun=0,scsi-id=1");
+    return arg;
+}
+
 static void *virtio_scsi_setup_cd(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
@@ -399,6 +458,10 @@ static void register_virtio_scsi_test(void)
     qos_add_test("large-lba-unmap", "virtio-scsi",
                  test_unmap_large_lba, &opts);
 
+    opts.before = virtio_scsi_setup_replace;
+    qos_add_test("replaced-node-size", "virtio-scsi",
+                 test_replaced_node_size, &opts);
+
     opts.before = virtio_scsi_setup_cd;
     qos_add_test("write-to-cdrom", "virtio-scsi", test_write_to_cdrom, &opts);
 
-- 
2.53.0


