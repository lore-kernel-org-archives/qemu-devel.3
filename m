Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC90C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1NDv-0001wB-Jb; Tue, 01 Sep 2026 08:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x1NDu-0001w2-CA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x1NDt-00071t-1V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788264255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nl5WoyTpJvABJd28BYMkIJTV/gurT6ais6kK1GnNVYQ=;
 b=P3v5g6X8hQSu6Rf6Bo2Ehnz1VczS3CWkck1/M0QUdlLuspHaqlhgq0QjsITgQcJBD4Pxim
 pP4qO2HqPksQG3d+oUMV7EqdqBNikYnEHWN0A2bk3W0u9358BI6NTVoKmIeA5rwjMpNV03
 AlkgVIUiWVrWW6633q5SlEy7Lxe/QM4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-oYf4DGMfPnG1FYCkSBcVqg-1; Tue,
 01 Sept 2026 08:04:13 -0400
X-MC-Unique: oYf4DGMfPnG1FYCkSBcVqg-1
X-Mimecast-MFC-AGG-ID: oYf4DGMfPnG1FYCkSBcVqg_1788264252
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FFE2195423B; Tue,  1 Sep 2026 12:04:12 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44E0E1955F01; Tue,  1 Sep 2026 12:04:10 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 01 Sep 2026 14:04:04 +0200
Subject: [PATCH v2 1/3] linux-headers: add VIRTIO_ID_MEDIA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-virtio-media-v2-1-bd3cc9347ab9@redhat.com>
References: <20260901-virtio-media-v2-0-bd3cc9347ab9@redhat.com>
In-Reply-To: <20260901-virtio-media-v2-0-bd3cc9347ab9@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, manos.pitsidianakis@linaro.org, 
 alex.bennee@linaro.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264246; l=767;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=13a+ZK858Se7JrWgikDune+f94SBxk/pnOnvvFCPAeA=;
 b=CPjS8VzUHrmhf0vvCmmGWmW5IoqCNUtGlchr5o8+s3lJ498nCiwJfyEHQGKWxyEBJxqM57YDZ
 FtfJ+esIPkmAXLVMmKow9Gfq6/DByOpmguEgncVEzeXocydd8/RGoFC
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The ID was added in Linux commit 2187be212179 ("virtio: Add ID for
virtio media") and is included in v7.3-rc1.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6c12db16fa..f9056af0c6 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -69,6 +69,7 @@
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
+#define VIRTIO_ID_MEDIA			48 /* virtio media */
 
 /*
  * Virtio Transitional IDs

-- 
2.55.0


