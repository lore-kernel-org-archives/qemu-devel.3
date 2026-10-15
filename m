Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1539CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSa-00031W-1r; Thu, 15 Oct 2026 08:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSV-0002xO-E6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKST-0005Jb-0M
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ullyBOj+y1vs0B10Sd7EyoQboW4UT4qycjBWYkvViCY=;
 b=MGiQs9j4Nhewuelx+/7DiZQ4HxIxkgJ5p9AWoJMv85q5sNfITpuRMVsK+eoK4WZ2UKbJgI
 9VLWXqCKnDQryABKnGIvJx99WwpBhv8EY1eZZcUFsO+9n/3yuj0gofVnVrPJPtcnYlRpaR
 sJETcuxytJ3tpqbDXIfjoLBGgxyFn8s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325--t5hOsYAPHqeJsIuV6ETGQ-1; Thu,
 15 Oct 2026 12:21:13 +0000
X-MC-Unique: -t5hOsYAPHqeJsIuV6ETGQ-1
X-Mimecast-MFC-AGG-ID: -t5hOsYAPHqeJsIuV6ETGQ_1792066872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4566D1800628; Thu, 15 Oct 2026 12:21:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4A5318002B6; Thu, 15 Oct 2026 12:21:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yuan Wang <yuan1.wang@intel.com>, Bosheng Xue <bosheng.xue@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 7/8] vfio/igd: Update igd-assign.txt for Intel MTL and newer
 platforms
Date: Thu, 15 Oct 2026 14:20:54 +0200
Message-ID: <20261015122055.888209-8-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Yuan Wang <yuan1.wang@intel.com>

Update the igd-assign.txt documentation to reflect the addition of
the 0006 patch in the ECI repository. This patch is required to
enable support for Meteor Lake (MTL) and subsequent Intel platforms.

Starting from MTL, the hardware-accessible BDSM (Base of Data Stolen
Memory) register in the PCI configuration space has been removed.
Instead, IGD devices now access stolen memory via MMIO BAR2 (LMEMBAR).
Consequently, guest firmware no longer needs to program the legacy
BDSM register.

Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260928084226.3537126-1-yuan1.wang@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/igd-assign.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index e54040335ba72dc971babb4d776e46d94f342f70..b9abfdbac3503f7e0e187a15fd0787d2bfef77f1 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -263,6 +263,6 @@ Footnotes
 [2] # echo "vfio-pci" > /sys/bus/pci/devices/0000:00:02.0/driver_override
 [3] https://web.archive.org/web/20240827012422/https://bugzilla.tianocore.org/show_bug.cgi?id=935
     Tianocore bugzilla was down since Jan 2025 :(
-[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004
+[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004, 0006
 [5] https://github.com/tomitamoeko/VfioIgdPkg
 [6] https://winraid.level1techs.com/t/tool-guide-news-uefi-bios-updater-ubu/30357
-- 
2.56.0


