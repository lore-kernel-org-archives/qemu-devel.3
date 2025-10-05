Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44661CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFf-0003ZY-Lj; Sun, 05 Oct 2025 15:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFK-0002ER-Ge
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UF7-0006Zx-Nd
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ac5t+5JamsSWpgaQ7u9WqC+NkNvtLKNGeD6nXQRzw8=;
 b=E2CiT5nmAxrVEBh57CCt0vMk0lLJzy8KhO6BI1e+sdeH8Xy1c90cp0qR3hd0IwA/9b7tEy
 SNOrxrQk4KNaQXHHO83vZ6y6dK965fgmMTE1oxqEKYibHifLwAjp7GHjI12tM2wf4j58S/
 nLOCH5HLtWiB6UuGgwUBufaO6tLZ1Mo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-N8_govmGP9iWREAWctUTMw-1; Sun, 05 Oct 2025 15:17:51 -0400
X-MC-Unique: N8_govmGP9iWREAWctUTMw-1
X-Mimecast-MFC-AGG-ID: N8_govmGP9iWREAWctUTMw_1759691871
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so2278353f8f.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691870; x=1760296670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ac5t+5JamsSWpgaQ7u9WqC+NkNvtLKNGeD6nXQRzw8=;
 b=GybXkun7YWV+9atMZg3ci3t1HTrZ2IBjYF8TmUuhBhxFkpaaagqPrcyWc6TxhtfNOt
 lGOPGMdX/Tud3WYO0Sg1Du06/PKhlCvh1l2cSIBeMGsnD2dptirIf+r8OOPHWuQ5tJ6S
 bQtGdJydg1IT7WHHShW73LYvMhj0Gbzde2FfInSPCi+tzd6AEvKKlDZhUgTkUXggC0ZJ
 4EY+R4gK1CJO194XhJ+4FpbTKb/zfnSbT4FEfVUKmYzrzhv9PLD9JVBeky2KJn/lYik2
 htfGotvwsNgV3KVLwhfBJ3mvVNu4z0F3aV669NkbtwRLmvgm2AzYX4mnMVl/LkYeqX32
 b9qA==
X-Gm-Message-State: AOJu0YwDME7PjgJTplHdgJKruxLIH1VDUPaWdCJiZmzwclO0NUuKput4
 XtfC6LYNJNOzIy7ElseFyz2zWGbzzB0WtM7PhsTB3KeT8u/BawN9M4hSFf3UBVzeyxOkEM4O/AK
 IuMimnM+9anVORPJSxk2yYgjS241ttnSbHdTJkYVcOaoIROwp6Gp4xTIfkoRsjzxnFrlcnDuHTt
 OxZfiw0rnAcNJ3Yz0LjrQ/curJXi07mHRGXw==
X-Gm-Gg: ASbGncs4b+CSIyvZOZlmWI8qin09ZfBF2gIsha9ueheg/f8ct/fPMbd6uNA1IHOS5ZV
 TZ/QBBuisZX5jtEESzIb5ROdZcsVqaBKjplfbwk+yx5nc05WTcTbb+smp3bbpVOUg7cPSrn4sxQ
 uQECe0V2az+2/i+BRbvkuaHbyO7Gy9L9NvcikH+c7S3TZhpiyx1OGSqcsCizKehpGtQOFuNC7Af
 /3Bfsg+3yB6i+5hKtwWdOAz11xFpgZUghpT/YJr7qYFoxujRzwPmkptSzQuNWnKRPMgXI40ERsO
 5Y1EEGAVa2Oh/miywhAC7pojv9N76DfCSPhH9qY=
X-Received: by 2002:a05:6000:402a:b0:3f3:c137:680e with SMTP id
 ffacd0b85a97d-4256719354fmr5656793f8f.43.1759691870344; 
 Sun, 05 Oct 2025 12:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1KeyiuZfKkYNFK4IKbC0ym6867jjDbIELzz9isSUNo4h97AFbIkPHNpAYD239sW3kK4owRQ==
X-Received: by 2002:a05:6000:402a:b0:3f3:c137:680e with SMTP id
 ffacd0b85a97d-4256719354fmr5656778f8f.43.1759691869745; 
 Sun, 05 Oct 2025 12:17:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm17489436f8f.26.2025.10.05.12.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:49 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 47/75] tests/virtio-scsi: add a virtio_error() IOThread test
Message-ID: <acaa3be3f7f73d9aafeb2454c01fe50eb8b4a807.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Now that virtio_error() calls should work in an IOThread, add a
virtio-scsi IOThread test cases that triggers virtio_error().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250922220149.498967-6-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/virtio-scsi-test.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index db10d572d0..e2350c52f6 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -311,6 +311,31 @@ fail:
     unlink(tmp_path);
 }
 
+static void test_iothread_virtio_error(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
+{
+    QVirtioSCSIPCI *scsi_pci = obj;
+    QVirtioSCSI *scsi = &scsi_pci->scsi;
+    QVirtioSCSIQueues *vs;
+    QVirtQueue *vq;
+
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi->vdev);
+    vq = vs->vq[2];
+
+    /* Move avail.idx out of bounds to trigger virtio_error() */
+    qvirtqueue_set_avail_idx(global_qtest, scsi->vdev, vq, vq->size * 2);
+    scsi->vdev->bus->virtqueue_kick(scsi->vdev, vq);
+
+    /*
+     * Reset the device out of the error state. If QEMU hangs or crashes then
+     * this will fail.
+     */
+    qvirtio_reset(scsi->vdev);
+
+    qvirtio_scsi_pci_free(vs);
+}
+
 static void *virtio_scsi_hotplug_setup(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
@@ -383,6 +408,13 @@ static void register_virtio_scsi_test(void)
     };
     qos_add_test("iothread-attach-node", "virtio-scsi-pci",
                  test_iothread_attach_node, &opts);
+
+    opts.before = virtio_scsi_setup_iothread;
+    opts.edge = (QOSGraphEdgeOptions) {
+        .extra_device_opts = "iothread=thread0",
+    };
+    qos_add_test("iothread-virtio-error", "virtio-scsi-pci",
+                 test_iothread_virtio_error, &opts);
 }
 
 libqos_init(register_virtio_scsi_test);
-- 
MST


