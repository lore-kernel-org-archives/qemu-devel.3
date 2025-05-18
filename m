Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9196DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 17:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGiF4-0003Vo-D4; Sun, 18 May 2025 13:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1uGiF2-0003VV-Oy
 for qemu-devel@nongnu.org; Sun, 18 May 2025 13:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1uGiF1-0006hb-3B
 for qemu-devel@nongnu.org; Sun, 18 May 2025 13:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747590961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O4twe7epOgmimplOrVuvhvGZc9nmEUIphwqF4WBpYK0=;
 b=jM3ZVnhTwiqFa0k3WK6OQ2qIxnXz9nUqxXjV/URf6UzsvTGcTybQZCnZVnRkAB9pf1E54J
 uljhI5TA6/y2qLCUtn4hw4/6nFtIvalkO+TPOISNcjtw4MHLnj1mWYZif0WvQO6io2Y8aW
 rSRQkSSuHienkxzLTkuFwPdxO9GjoDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-cCHCKOxwOd2BZIl3zkH_aQ-1; Sun,
 18 May 2025 13:54:36 -0400
X-MC-Unique: cCHCKOxwOd2BZIl3zkH_aQ-1
X-Mimecast-MFC-AGG-ID: cCHCKOxwOd2BZIl3zkH_aQ_1747590875
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025C519560AE; Sun, 18 May 2025 17:54:35 +0000 (UTC)
Received: from worklaptop.redhat.com (unknown [10.22.88.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11250180049D; Sun, 18 May 2025 17:54:33 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Cole Robinson <crobinso@redhat.com>
Subject: [PATCH] roms: re-remove execute bit from hppa-firmware*
Date: Sun, 18 May 2025 13:54:20 -0400
Message-ID: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEXHASH_WORD=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This was fixed in c9d77526bddba0803a1fa982fb59ec98057150f9 for
9.2.0 but regressed in db34be329162cf6b06192703065e6c1010dbe3c5 in
10.0.0

When the bit is present, rpmbuild complains about missing ELF build-id

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 pc-bios/hppa-firmware.img   | Bin
 pc-bios/hppa-firmware64.img | Bin
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 pc-bios/hppa-firmware.img
 mode change 100755 => 100644 pc-bios/hppa-firmware64.img

diff --git a/pc-bios/hppa-firmware.img b/pc-bios/hppa-firmware.img
old mode 100755
new mode 100644
diff --git a/pc-bios/hppa-firmware64.img b/pc-bios/hppa-firmware64.img
old mode 100755
new mode 100644
-- 
2.49.0


