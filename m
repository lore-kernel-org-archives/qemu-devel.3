Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=j2fNMNH5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOie-0004yt-Rf; Mon, 26 Oct 2026 13:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiR-0004j4-4k
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiO-0001ZB-EK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1800137f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793036550; x=1793641350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Alg/vYLqLfwkGDQOiDDSdhoe903yH8cFTvhjI7EQ/DQ=;
 b=j2fNMNH5ShvjWh9ADzlBarb9DXWNpLRhQHv6ufs+/mNtlLjgMupGAHl/8U1beffv3T
 Dt5HyxsBlt1fevPemMd/n1fPBMTHAt8g3RUQp5Jhry60NYTPQQaUHLbU5hWAA7b6CBIG
 /lNzsXaXhyhrDJjwVEBTbpTeI0mFZefowAu5y6EMhQqvrYsAoSzKXk7p+jS0Q9FmM8un
 ucxuSR0ILtc6jpRCa4fXI5/eWPORQNF8d9c2OhF26lLo9PqZ0v6d/sRr2bxwt+NY2vfA
 Q3InVibvPKGlrS70/tYwpYkqEQAbetf9njE6dNafScwhdUVPmra0Zsu/eu7oXIc3FxZT
 vj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036550; x=1793641350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Alg/vYLqLfwkGDQOiDDSdhoe903yH8cFTvhjI7EQ/DQ=;
 b=cLhTZKEtwjSOp328Caov26GFl9OFxuR+En66C0meRD2cpOi4oJAXI+Kd08xftDWx9d
 f9UnR1CXLkjQzYsUesV5w2Bx0Tfknq0tOtKjMKuskAzvJCj6wcmTV1+RC3gMKkop/qNu
 dWfn9vamFE0PEcbZ0GZdoSnXelL9XgO7FFz1o3HN9NgXqgcUZqthDlFD/+YylLowGvCH
 yW0slU6ClxNq4GaPNQurnCt8Zse9G4U1DtW0ryPLfBFW4sZbLHHLOMhp65N/q/dFZOFY
 IZHlG3EzdS7HLQaaT//yiL5Li92oYkJIHycW9maIV0xMBbHoHDXWHgpeZuUY5Gao4rdL
 n87g==
X-Gm-Message-State: AFq9FYIfSo4JuJM/rKgULOM7dMWrsWvK/it2m94BcJd608CT4uz/G38k
 7N7XumQWqJqtzT/+XwI9QK8VhV4oYOL6w2odsksWaTQixJievt0ExfOD0Hp7OE5HScrsb0uG9E3
 2t6ds
X-Gm-Gg: AYBFou2XAilIKpPRJVhzCNjmKSDqVWZUqfy6I31UERBE/Dq4vTuoJNDxa1CljVlhd9w
 vSFhvcD1dVCcjJAQJ7Q/pQaeLpbSRoEcfF36fZerurmCNx3t9dROBd/62KDEYz0vAJ4hgCuqov3
 FqO+nkKNOm80iMOWlTlUytnUGiDu2hGOqgSBSYffk1X4y5Jv6iK6ifUEHE/DDoeIhBJwk6kSKd+
 XIPbStNen29OKaBrB0RidVpj2OwzRJTw+pLmfPi3MzYkSZkbqkG70q6/kAj4t7v974cSfVZ6tLG
 SWQR8km5kzII+wPtsCBpLUxFfl3ikFxhOqXJ7mb0ctZKlPk43ABkj8SW/85hZLXzpTfRzI5LREB
 iCvnLooAzsOYxuKZ8kn/maWBhIL/6YIVHFfnodjMIWKJO3uYrQaDSrom93FbaFU7GcLg+G0yuPU
 b04PjNz+9ir4nMfntFR6zBzyqb5/TyLdqCCKGBRZHg+i+YHCEeVWLcbZs5PHEH6whyQpfdSe91v
 6vCb+4/xg2W4JTL1l/tfbKz4O/dpiRMYVsgV/4BQFuojbFla8U=
X-Received: by 2002:a5d:4282:0:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48e3eb89d0cmr9387729f8f.24.1793036550094; 
 Mon, 26 Oct 2026 10:42:30 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1a6:7f7f:f573:ba9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm16169111f8f.22.2026.10.26.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:42:29 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 5/5] virtio-scsi-test: test UNMAP and WRITE SAME during
 inactivation
Date: Mon, 26 Oct 2026 18:42:19 +0100
Message-ID: <20261026174220.674460-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
References: <20261026174220.674460-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inactivate all nodes while a multi-descriptor UNMAP, or a WRITE SAME
spanning several chunks, is in flight on a slow node and check that the
command completes. QEMU used to abort when the drain in
bdrv_inactivate_all() ended and resumed the request queued for the next
descriptor or chunk on an inactive node.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
---
 tests/qtest/virtio-scsi-test.c | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index 40f1d569d8..e30b7f2440 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -269,6 +269,68 @@ static void test_unmap_large_lba(void *obj, void *data,
     qvirtio_scsi_pci_free(vs);
 }
 
+static void inactivate_during_command(QVirtioSCSIPCI *scsi_pci,
+                                      QGuestAllocator *t_alloc,
+                                      const uint8_t *cdb,
+                                      uint8_t *data_out, size_t data_out_len)
+{
+    QVirtioSCSIQueues *vs;
+    VirtioSCSICmd cmd;
+    struct virtio_scsi_cmd_resp resp;
+
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi_pci->scsi.vdev);
+
+    virtio_scsi_submit_command(vs, cdb, NULL, 0, data_out, data_out_len,
+                               &cmd);
+    qtest_qmp_assert_success(scsi_pci->pci_vdev.pdev->bus->qts,
+                             "{'execute': 'blockdev-set-active',"
+                             " 'arguments': {'active': false}}");
+
+    /* The drain must have waited for the whole command */
+    virtio_scsi_wait_command(vs, &cmd, &resp, 0);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, ==, GOOD);
+
+    qvirtio_scsi_pci_free(vs);
+}
+
+static void test_unmap_inactivate(void *obj, void *data,
+                                  QGuestAllocator *t_alloc)
+{
+    const uint8_t unmap[VIRTIO_SCSI_CDB_SIZE] = {
+        0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x00
+    };
+    uint8_t unmap_params[0x48] = {
+        0x00, 0x46, /* unmap data length */
+        0x00, 0x40, /* unmap block descriptor data length */
+    };
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        uint8_t *desc = &unmap_params[8 + i * 16];
+
+        desc[7] = i * 8;    /* LBA */
+        desc[11] = 1;       /* sector count */
+    }
+
+    inactivate_during_command(obj, t_alloc, unmap, unmap_params,
+                              sizeof(unmap_params));
+}
+
+static void test_write_same_inactivate(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
+{
+    /* 2 MiB of non-zero data is written in 512 KiB chunks */
+    const uint8_t write_same[VIRTIO_SCSI_CDB_SIZE] = {
+        0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00
+    };
+    uint8_t buf[512];
+
+    memset(buf, 0xa5, sizeof(buf));
+    inactivate_during_command(obj, t_alloc, write_same, buf, sizeof(buf));
+}
+
 static void test_write_to_cdrom(void *obj, void *data,
                                 QGuestAllocator *t_alloc)
 {
@@ -398,6 +460,20 @@ static void *virtio_scsi_setup_4k(GString *cmd_line, void *arg)
     return arg;
 }
 
+/* Each request must outlast the kick-to-QMP round trip on a loaded host */
+static void *virtio_scsi_setup_slow(GString *cmd_line, void *arg)
+{
+    g_string_append_printf(cmd_line,
+                           " -blockdev null-co,node-name=null0,read-zeroes=on"
+                           " -blockdev blkdebug,image=null0,node-name=dbg,"
+                           "discard=unmap,inject-error.0.event=none,"
+                           "inject-error.0.iotype=%s,inject-error.0.errno=0,"
+                           "inject-error.0.delay-ns=100000000"
+                           " -device scsi-hd,drive=dbg,lun=0,scsi-id=1",
+                           (const char *)arg);
+    return arg;
+}
+
 static void *virtio_scsi_setup_cd(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
@@ -435,6 +511,18 @@ static void register_virtio_scsi_test(void)
     opts.before = virtio_scsi_setup_cd;
     qos_add_test("write-to-cdrom", "virtio-scsi", test_write_to_cdrom, &opts);
 
+    /* ioeventfd=off starts the command before the kick returns */
+    opts.before = virtio_scsi_setup_slow;
+    opts.edge = (QOSGraphEdgeOptions) {
+        .extra_device_opts = "ioeventfd=off",
+    };
+    opts.arg = (void *)"discard";
+    qos_add_test("unmap-inactivate", "virtio-scsi-pci",
+                 test_unmap_inactivate, &opts);
+    opts.arg = (void *)"write";
+    qos_add_test("write-same-inactivate", "virtio-scsi-pci",
+                 test_write_same_inactivate, &opts);
+
     opts.before = virtio_scsi_setup_iothread;
     opts.edge = (QOSGraphEdgeOptions) {
         .extra_device_opts = "iothread=thread0",
-- 
2.53.0


