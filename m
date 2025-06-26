Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1474EC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZ7-0003vC-7Y; Thu, 26 Jun 2025 01:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZ2-0003uI-Fu
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYy-00017C-T5
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8w/ncmOi3KgdTFUbx8It2WGGLW2JFyrfkvaspPXpDsA=;
 b=NJDWP3M7IMPiIYFy1HPFR9twfidRvqobbL/6nIgD779ff2wqRfuRn9YS/ushH53DnIOmNO
 i7XUnFM+CNM0RqtIt3fk3ucWQDld5MRdqH3kXtsPWJVfPD5OgMQQlpDdAfmUclec2uZ5+y
 u4fIJsI5tweND99t8qORz+G8jjUo0Ro=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-JyZydKiWOh-J1C0QLAsgfg-1; Thu,
 26 Jun 2025 01:54:14 -0400
X-MC-Unique: JyZydKiWOh-J1C0QLAsgfg-1
X-Mimecast-MFC-AGG-ID: JyZydKiWOh-J1C0QLAsgfg_1750917253
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6726819560BA; Thu, 26 Jun 2025 05:54:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D59819560A3; Thu, 26 Jun 2025 05:54:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 06/19] MAINTAINERS: add reviewers for some s390 areas
Date: Thu, 26 Jun 2025 07:53:37 +0200
Message-ID: <20250626055350.218271-7-thuth@redhat.com>
In-Reply-To: <20250626055350.218271-1-thuth@redhat.com>
References: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

To improve review coverage, assign additional people as reviewers for
multiple s390 sections.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Jared Rossi <jrossi@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Farhan Ali <alifm@linux.ibm.com>
Acked-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b8b314c8c6..ebb8af7d5b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -459,6 +459,8 @@ F: target/ppc/kvm.c
 S390 KVM CPUs
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Eric Farman <farman@linux.ibm.com>
+R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
 F: target/s390x/kvm/
 F: target/s390x/machine.c
@@ -1771,6 +1773,7 @@ S390 Virtio-ccw
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Eric Farman <farman@linux.ibm.com>
+R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
@@ -1782,6 +1785,8 @@ L: qemu-s390x@nongnu.org
 S390-ccw boot
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Thomas Huth <thuth@redhat.com>
+R: Jared Rossi <jrossi@linux.ibm.com>
+R: Zhuoying Cai <zycai@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
@@ -1802,6 +1807,7 @@ S390 channel subsystem
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Eric Farman <farman@linux.ibm.com>
+R: Farhan Ali <alifm@linux.ibm.com>
 S: Supported
 F: hw/s390x/ccw-device.[ch]
 F: hw/s390x/css.c
@@ -1822,6 +1828,7 @@ L: qemu-s390x@nongnu.org
 S390 SCLP-backed devices
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/event-facility.h
 F: include/hw/s390x/sclp.h
@@ -2809,6 +2816,7 @@ F: include/hw/timer/mips_gictimer.h
 S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Collin Walling <walling@linux.ibm.com>
 S: Odd fixes
 F: include/hw/s390x/3270-ccw.h
 F: hw/char/terminal3270.c
@@ -2818,6 +2826,7 @@ L: qemu-s390x@nongnu.org
 S390 diag 288 watchdog
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Collin Walling <walling@linux.ibm.com>
 S: Supported
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/watchdog/wdt_diag288.h
@@ -2826,6 +2835,7 @@ L: qemu-s390x@nongnu.org
 S390 storage key device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/storage-keys.h
 F: hw/s390x/s390-skeys*.c
@@ -2834,6 +2844,7 @@ L: qemu-s390x@nongnu.org
 S390 storage attribute device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/storage-attributes.h
 F: hw/s390x/s390-stattrib*.c
@@ -2843,6 +2854,7 @@ S390 floating interrupt controller
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: David Hildenbrand <david@redhat.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/intc/s390_flic*.c
 F: include/hw/s390x/s390_flic.h
-- 
2.50.0


