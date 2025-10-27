Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0665CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDHtx-0004dt-70; Mon, 27 Oct 2025 03:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDHtv-0004dC-6v
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDHtr-0001Gr-NR
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761551058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kg5uQg9myEskdPvmIxz8+X4YEaLDIpzowXlvSiolGvc=;
 b=GVn6fFsVy/u3lm7frx1civbTr9kmvGKb27JTdlHNWq8q/NuSTGtGToCc+r8pKdM0e0M/Ch
 sJeU4Ejc2+BuY2/LD8Wl7SprudULLgV1T9PAWzI1w+ZQEkoFjNAoIhXL+ITsfII24pjOPS
 WMc+4b/lIM0aMOWvT77SNJIZEUcDa3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-eHIXYyK1NGWVGgbn0TDzuw-1; Mon,
 27 Oct 2025 03:44:14 -0400
X-MC-Unique: eHIXYyK1NGWVGgbn0TDzuw-1
X-Mimecast-MFC-AGG-ID: eHIXYyK1NGWVGgbn0TDzuw_1761551053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D330918001E4; Mon, 27 Oct 2025 07:44:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.57])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3E3D1955F01; Mon, 27 Oct 2025 07:44:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PULL SUBSYSTEM qemu-pseries 1/1] pseries: Update SLOF firmware image
 to release 20251027
Date: Mon, 27 Oct 2025 08:44:04 +0100
Message-ID: <20251027074404.25758-2-thuth@redhat.com>
In-Reply-To: <20251027074404.25758-1-thuth@redhat.com>
References: <20251027074404.25758-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

- Fix some measurements in the TPM code
- Fix for compiling with GCC in C23 mode
- Silence some initializer-string warnings with recent GCC

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 996184 -> 994176 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/README b/pc-bios/README
index d009c378953..4818272968d 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -14,7 +14,7 @@
 - SLOF (Slimline Open Firmware) is a free IEEE 1275 Open Firmware
   implementation for certain IBM POWER hardware.  The sources are at
   https://gitlab.com/slof/slof, and the image currently in qemu is
-  built from git tag qemu-slof-20241106.
+  built from git tag qemu-slof-20251026.
 
 - VOF (Virtual Open Firmware) is a minimalistic firmware to work with
   -machine pseries,x-vof=on. When enabled, the firmware acts as a slim shim and
diff --git a/pc-bios/slof.bin b/pc-bios/slof.bin
index 4314e17b9dd..39b92489674 100644
Binary files a/pc-bios/slof.bin and b/pc-bios/slof.bin differ
diff --git a/roms/SLOF b/roms/SLOF
index 3a259df2449..b7f755248e2 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
+Subproject commit b7f755248e2dcc56c02634d288e1c0ff7e0ce1c7
-- 
2.51.0


