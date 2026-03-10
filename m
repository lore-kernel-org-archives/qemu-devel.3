Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18EAFCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4s-00076P-F6; Tue, 10 Mar 2026 01:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4m-0006xY-Bv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4k-0006GJ-JI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxNM4HxmyRO4tl1AAMVyqRynDOBYCCwt8hKcbfgbSwA=;
 b=R37F4SxAjzGBxFh+LeCwce48I9ApEZIczZsuRkvQ9usQghgrtSG6kWIiz72boJwfOOzoPx
 ZK0Kr18pIn52oxztM0gs8GrUcj0FLcX7pl11in03ClakCcUK93EE6t7wmiQEMDzkIYTFkR
 q9MC8FsdAHxVCMiBju5nMS/sD3sO9RQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-YVYWn2JpNgm4SiCmA_K8Tw-1; Tue,
 10 Mar 2026 01:56:10 -0400
X-MC-Unique: YVYWn2JpNgm4SiCmA_K8Tw-1
X-Mimecast-MFC-AGG-ID: YVYWn2JpNgm4SiCmA_K8Tw_1773122169
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B5A18005B2; Tue, 10 Mar 2026 05:56:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A37A21956095; Tue, 10 Mar 2026 05:56:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 09/25] pc-bios/s390-ccw: Fix misattributed function prototypes
Date: Tue, 10 Mar 2026 06:55:14 +0100
Message-ID: <20260310055530.8893-10-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio-blkdev functions are incorrectly listed in s390-ccw.h as belonging to
virtio.c.  Additionally, virtio_load_direct() has an unused subchan_id argument.

Remove the unused argument and move the prototypes to virtio.h so that they are
independent from the CCW bus.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-2-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h      | 4 ----
 pc-bios/s390-ccw/virtio.h        | 7 +++++++
 pc-bios/s390-ccw/bootmap.c       | 2 +-
 pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b1dc35cdedf..47ea66bd4d1 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -67,11 +67,7 @@ void sclp_get_loadparm_ascii(char *loadparm);
 int sclp_read(char *str, size_t count);
 
 /* virtio.c */
-unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
-                                 unsigned long subchan_id, void *load_addr);
 bool virtio_is_supported(SubChannelId schid);
-int virtio_blk_setup_device(SubChannelId schid);
-int virtio_read(unsigned long sector, void *load_addr);
 
 /* bootmap.c */
 void zipl_load(void);
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 5c5e808a500..597bd423586 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -277,7 +277,14 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 int virtio_reset(VDev *vdev);
 int virtio_setup_ccw(VDev *vdev);
 
+/* virtio-net.c */
 int virtio_net_init(void *mac_addr);
 void virtio_net_deinit(void);
 
+/* virtio-blkdev.c */
+int virtio_blk_setup_device(SubChannelId schid);
+int virtio_read(unsigned long sector, void *load_addr);
+unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
+                                 void *load_addr);
+
 #endif /* VIRTIO_H */
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 0f8baa01985..420ee32eff8 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -662,7 +662,7 @@ static int zipl_load_segment(ComponentEntry *entry)
                  */
                 break;
             }
-            address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
+            address = virtio_load_direct(cur_desc[0], cur_desc[1],
                                          (void *)address);
             if (!address) {
                 puts("zIPL load segment failed");
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 7b2d1e20f4d..4b819dd80fb 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -64,7 +64,7 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
 }
 
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
-                                 unsigned long subchan_id, void *load_addr)
+                                 void *load_addr)
 {
     u8 status;
     int sec = rec_list1;
-- 
2.53.0


