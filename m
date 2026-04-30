Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3BCCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITsi-0002rc-Tq; Thu, 30 Apr 2026 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrZ-0008AD-Ap
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrX-0007Gp-6L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777565018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkYxmbrCwBUm4h9tBZGzxIDYxBUQTYz73TS7PdYKhs8=;
 b=Kdo7n4ia8kgd5hZga2zUQPsEG7Xy9H3IV1k7ZVtzdyxfrFrPX6AOsU20Mxa2xj/Hpb89S9
 6qpJkgoCH97a0jsh5PfBx3wTJnhmZLUrM2ojhfC165Ed+x119OAZxYuSP4RJ6JpM7zuq04
 xgJwprLigqhQU8wPHMNefbktyuglzr8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-ocuA9cPUNjW4TAwr0s3VLg-1; Thu,
 30 Apr 2026 12:03:34 -0400
X-MC-Unique: ocuA9cPUNjW4TAwr0s3VLg-1
X-Mimecast-MFC-AGG-ID: ocuA9cPUNjW4TAwr0s3VLg_1777565013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CA781956057; Thu, 30 Apr 2026 16:03:33 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B4681800446; Thu, 30 Apr 2026 16:03:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 09/11] MAINTAINERS: Update s390 trees
Date: Thu, 30 Apr 2026 18:03:05 +0200
Message-ID: <20260430160307.634093-10-cohuck@redhat.com>
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Farman <farman@linux.ibm.com>

Move Cornelia's git tree from virtio-ccw to the overall
s390 architecture group, since all the subgroups funnel
up through that.

Remove Christian's tree from the subgroups, since they are
not specified consistently across areas but also haven't
been used in ~6 years.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260417152236.1305333-2-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e41f0eb92cfd..39618d89b6f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -126,6 +126,7 @@ F: docs/system/target-s390x.rst
 F: docs/system/s390x/
 F: tests/qtest/migration/s390x/
 K: ^Subject:.*(?i)s390x?
+T: git https://gitlab.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 MIPS general architecture support
@@ -500,7 +501,6 @@ F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
 F: gdbstub/gdb-xml/s390*.xml
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 X86 KVM CPUs
@@ -1863,7 +1863,6 @@ F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
 F: tests/functional/s390x
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 S390-ccw boot
@@ -1877,7 +1876,6 @@ F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
 F: tests/functional/s390x/test_pxelinux.py
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 S390 PCI
@@ -2464,8 +2462,6 @@ M: Eric Farman <farman@linux.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw*.[hc]
 F: hw/s390x/vhost-*-ccw.c
-T: git https://gitlab.com/cohuck/qemu.git s390-next
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 virtio-dmabuf
-- 
2.53.0


