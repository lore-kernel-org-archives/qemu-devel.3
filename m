Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76825C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwu7-0002ZC-KD; Thu, 25 Apr 2024 07:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzwtp-00010I-Sa
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzwtn-0000Rj-TF
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714043058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0/jA1fXfH2t1wTTUgmoVuke/9Re+MG3phXbAKQBwtj0=;
 b=d2XAjbtFnTCbRsIq4dIGeoWdsFCN2mj25vHAWjqt+56Czx5O/+m4Aw/els49BDu4WiDro2
 dHn8L/xdJdFG8SHMvPottk2ntKk9VAOBFEKOGFZTgC/S9ly7t58vcRNDcIWoTefOobvvm7
 V3ptDz6hYy/XBTzRPHVDQBP3aN9VhTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-phtnW38fPFKG7sgY_AbJmQ-1; Thu, 25 Apr 2024 07:04:17 -0400
X-MC-Unique: phtnW38fPFKG7sgY_AbJmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB3E918065B1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 11:04:16 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A6B200AE7F;
 Thu, 25 Apr 2024 11:04:15 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] stubs: Add missing qga stubs
Date: Thu, 25 Apr 2024 14:04:14 +0300
Message-ID: <20240425110414.36977-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Compilation QGA without system and user fails
./configure --disable-system --disable-user --enable-guest-agent

Fixes: 3a15604900c4f433c970cc6294520a98f201287e

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 stubs/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 8ee1fd5753..3b9d42023c 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -21,12 +21,12 @@ if have_block
   stub_ss.add(files('migr-blocker.c'))
   stub_ss.add(files('physmem.c'))
   stub_ss.add(files('ram-block.c'))
-  stub_ss.add(files('replay-tools.c'))
   stub_ss.add(files('runstate-check.c'))
   stub_ss.add(files('uuid.c'))
 endif
 
 if have_block or have_ga
+  stub_ss.add(files('replay-tools.c'))
   # stubs for hooks in util/main-loop.c, util/async.c etc.
   stub_ss.add(files('cpus-get-virtual-clock.c'))
   stub_ss.add(files('icount.c'))
@@ -45,6 +45,10 @@ if have_block or have_ga
   stub_ss.add(files('qmp-quit.c'))
 endif
 
+if have_ga
+  stub_ss.add(files('error-printf.c'))
+endif
+
 if have_block or have_user
   stub_ss.add(files('qtest.c'))
   stub_ss.add(files('vm-stop.c'))
-- 
2.44.0


