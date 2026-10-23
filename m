Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67240606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dPWuEZR4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iOkXwqIL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI4c-0003qa-Ed; Fri, 23 Oct 2026 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKI4Z-0003Yv-93
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKI4X-0003FJ-5c
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792772687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+wDdcMQ8EY02wA42GqC3QO4nYriHJaInirxC5LhjcR8=;
 b=dPWuEZR48BBC++VxGZKyvpVQ8GoLgLHbe6Du6mXwkok+1SNsfJVQ9J83Xfy6354Z1hU7Mg
 tIykOgpOk269Qpsc2nOBqZcpm7eRNi7L/EiCkbJi2Dau6y+HIJikcTnkJNpFZH+OfR6+dE
 oMwAHmjsbkl+7FKkpWc9WLtKcRUnxJs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-qOcQzHGOPMaZxH1pLh5ENA-1; Fri, 23 Oct 2026 12:24:45 -0400
X-MC-Unique: qOcQzHGOPMaZxH1pLh5ENA-1
X-Mimecast-MFC-AGG-ID: qOcQzHGOPMaZxH1pLh5ENA_1792772685
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so913912f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792772684; x=1793377484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+wDdcMQ8EY02wA42GqC3QO4nYriHJaInirxC5LhjcR8=;
 b=iOkXwqILjRrF1Qip/en3zHM3RROjIttFVTB+pgkotioW3fmFhrSWx38x1xSG1hdepn
 3E0jsAVbfwYp1z1cV/wYJs7ru1hRtRZJb/a92HgxqZ4ToSFBj9+76Rh9dpRWBrCcR2Gd
 CC9LBkbk1roAGeOgJi7WX+PXf2/fZtseLGrgs6T3orBf75jwfIrWOTa3ch94fewpS77u
 IJor4WlF4ixz8VpuUUwI7o8j8+4vZN+e9Z5FzJWtMbudQ/Hm3/AgkB2X4ft/O2CHZtQF
 ptcNKNEidQqMHuounijlSZyuOvJq6AzNK/tRyyKTOv7Mg4kN7j2GjzI4qewKJoKKROo3
 2kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772684; x=1793377484;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+wDdcMQ8EY02wA42GqC3QO4nYriHJaInirxC5LhjcR8=;
 b=e7GuuGjrhDYxzSRJPdU/raMqdK2ymcDKF28yI4hqU2ugFQeKprPBqiHWIVofH/u4kS
 KfbEz2tLPDqMDXW8HT6z6vnFzu7gjmjSShp6JFbomiUb0Xg0aKfF1OwAUkJgz6kd4JvH
 J4a+uuD+4KJj660q/VLZX39O+WT2oIVhw7xIaAf9lx2gg3E8SFGyt0hFFjJn4lIMhXqB
 0lEvS+vVn0brdi/PWW7pG6gFEk40R0xPUAyVT3kdoebnUC8e1xSoOJOjttieril7inpg
 PW7xX1St2kUezt7H9HYXp931/rfohdOKl4a4+HeGwUWID/2GywavII1TleQbvEZhLk1Q
 p4TA==
X-Gm-Message-State: AFq9FYLJ00m8dJqod8KxL89cvPdbIsxTHjcRsj6jNn5DfAybwox3PyUY
 +VX21HlQqmhce1C26993hXe6mnTR9UsdRO6z39zHxT5scPQ8TgnhOsGNWapV22bE4aBSLutT2tp
 ynAoJ+6TQHybph2vGW4FW7k+Z3hKCg9IBkgAMMzY6fs253O7QcjFHk0UmaHGIL19EJfS6/EW9Of
 VU9il28Qk2mjnlBQcq4wQKBIy0OTSd79pnOMJUdZjR
X-Gm-Gg: AYBFou2ek7n6EP6EHb4oNuqND40+2Z5GuErqKWgBbX1ZmoJ0ezRWGBboOwv/heWVtv9
 eoUn02tnatafonvLH3Arxd/odaJwCF/swNw1ZVSJ73avqeScNzSLdm+3nF4AQaQny6thjfoUIGi
 CyqPEe9eC3NHLu3ouh5DzTuqmHzH6hkVtmSFeAoJOrl2awAkMyzb0L1RdjmMngtfe9hrswEHW6F
 LViFDzBgDlDItZjqOuE5MQ2erf4btjEeNC5djodQ54v2OREdEJKDsMT8AINLtUIGc/wjZQ/xZtN
 +jfA6B8hcNuTLH901F7wM5U51H9jWl/+Qgvdmrg3/J44nm7XPnD9c3nFG+r/p2VZ75sUomNfcMO
 TdLDWCg==
X-Received: by 2002:a05:6000:4006:b0:48e:824:f0b9 with SMTP id
 ffacd0b85a97d-48e385ba51amr5083064f8f.45.1792772684541; 
 Fri, 23 Oct 2026 09:24:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4006:b0:48e:824:f0b9 with SMTP id
 ffacd0b85a97d-48e385ba51amr5083013f8f.45.1792772683885; 
 Fri, 23 Oct 2026 09:24:43 -0700 (PDT)
Received: from stex1.redhat.corp ([94.32.46.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3eefacsm923877f8f.9.2026.10.23.09.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:24:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorinda Bassey <dbassey@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 vhost-user@lists.linux.dev
Subject: [PATCH] vhost-user: add dedicated mailing list
Date: Fri, 23 Oct 2026 18:24:40 +0200
Message-ID: <20261023162441.89450-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

During the "Virtio and Vhost-User Ecosystem for Production and
Automotive Systems" BoF at LPC 2026 [1] we discussed and agreed on
creating a new vhost-user mailing list, mainly for changes to the
specification and discussions around the protocol.

The main reason is that the vhost-user specification is also used
by other VMMs and implemented by several back-ends outside the QEMU
repository, whose developers often do not follow qemu-devel.

Add a paragraph in the specification about the new mailing list and
a dedicated MAINTAINERS entry for the vhost-user protocol, covering
the specification, the QEMU front-end and libvhost-user (back-end
library).

[1] https://lpc.events/event/20/contributions/2365/

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS                 | 12 ++++++++++--
 docs/interop/vhost-user.rst |  6 ++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f..dcdb65d8cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2532,19 +2532,27 @@ M: Michael S. Tsirkin <mst@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
-F: docs/interop/vhost-user*
 F: docs/system/devices/virtio/vhost-user*
 F: contrib/vhost-user-*/
 F: backends/*vhost*
 F: include/system/vhost-user-backend.h
 F: include/hw/virtio/vhost*
 F: include/*/vhost*
-F: subprojects/libvhost-user/
 F: block/export/vhost-user*
 F: util/vhost-user-server.c
 F: net/vhost*
 F: tests/functional/x86_64/test_vhost_user_bridge.py
 
+vhost-user protocol
+M: Michael S. Tsirkin <mst@redhat.com>
+R: Stefano Garzarella <sgarzare@redhat.com>
+L: vhost-user@lists.linux.dev
+S: Supported
+F: docs/interop/vhost-user*
+F: hw/virtio/vhost-user.c
+F: include/hw/virtio/vhost-user.h
+F: subprojects/libvhost-user/
+
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
 F: hw/virtio/vhost-shadow-virtqueue.*
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c1e02ff7e9..198ad30f5c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -38,6 +38,12 @@ conventions <backend_conventions>`.
 The *front-end* and *back-end* can be either a client (i.e. connecting) or
 server (listening) in the socket communication.
 
+The protocol is developed and discussed on the `vhost-user mailing list
+<mailto:vhost-user@lists.linux.dev>`_, archived at
+https://lore.kernel.org/vhost-user/. Until October 2026, when this list
+was created, discussions took place on the qemu-devel mailing list,
+archived at https://lore.kernel.org/qemu-devel/.
+
 Support for platforms other than Linux
 --------------------------------------
 
-- 
2.56.0


