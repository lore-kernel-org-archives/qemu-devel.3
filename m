Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0471CC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0r8-0003gR-8B; Wed, 02 Jul 2025 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qt-0003em-Px
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qs-0003Zk-AZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncCykjeChiswa3Gb/EUwJFVOhIEKzsn4AdcvFPEWqn4=;
 b=SdqcOQALzCXtLJ04MV1J+s5h3VW5xNYseszpPxMWYREkEIgVJd6vJGRxVp1zZIj4JDXwKV
 dMc3o1ZSjKNHzAd4Ik8OwwNX7G3pVdgzFYjEkde7Qx4aSbKBxJT/1beqP/R/R9ax5gFj1d
 1b8eShtUeG88mBJasyhVnCedUMh5Jvs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-vx8M41-OPKmgbOPvnMh9IQ-1; Wed,
 02 Jul 2025 13:02:26 -0400
X-MC-Unique: vx8M41-OPKmgbOPvnMh9IQ-1
X-Mimecast-MFC-AGG-ID: vx8M41-OPKmgbOPvnMh9IQ_1751475744
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72DC31913317; Wed,  2 Jul 2025 17:02:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DD0419AC0FC; Wed,  2 Jul 2025 17:02:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 3/9] MAINTAINERS: fix VMware filename typo (vwm -> vmw)
Date: Wed,  2 Jul 2025 19:01:58 +0200
Message-ID: <20250702170206.212303-4-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sean Wei <me@sean.taipei>

The entry for the VMware PVSCSI spec uses "vwm" instead of "vmw",
which does not match any file in the tree.

Correct the path so scripts/get_maintainer.pl can match the file.

Signed-off-by: Sean Wei <me@sean.taipei>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250616.qemu.relocated.04@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 585f08e709e..8aa0fd33b7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2549,7 +2549,7 @@ F: pc-bios/efi-vmxnet3.rom
 F: pc-bios/vgabios-vmware.bin
 F: roms/config.vga-vmware
 F: tests/qtest/vmxnet3-test.c
-F: docs/specs/vwm_pvscsi-spec.rst
+F: docs/specs/vmw_pvscsi-spec.rst
 
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
-- 
2.50.0


