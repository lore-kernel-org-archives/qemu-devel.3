Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0459C71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL34-0003Ny-Cs; Wed, 11 Jun 2025 08:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL32-0003NW-Gj
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2w-0004Pg-Fo
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8PyLdoYHi547tWJvqHCG88KlPYKZjEwQO5cMWqBboo=;
 b=Sw8FjDblEfB651VcIxVTKpIMaOWTUocPMgs7VMtYdURLTS5SRpTaT0T7dEW8ZVfC5P4G8X
 p7gOoDolnalL/LJ6dgOs7im1xCMTpObmifJMCJsoOHbuqvb4+9b84ge3FAYDhBfFSccCH4
 wT9TqPiZ78sVvh8LBCLR4g2dcUcQnwU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-jD5UomSYNWqqafRvFfmYew-1; Wed,
 11 Jun 2025 08:59:12 -0400
X-MC-Unique: jD5UomSYNWqqafRvFfmYew-1
X-Mimecast-MFC-AGG-ID: jD5UomSYNWqqafRvFfmYew_1749646751
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE4D1800290; Wed, 11 Jun 2025 12:59:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 810A519560A3; Wed, 11 Jun 2025 12:59:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] MAINTAINERS: Update Akihiko Odaki's affiliation
Date: Wed, 11 Jun 2025 14:58:45 +0200
Message-ID: <20250611125846.125918-10-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

My contract with Daynix Computing Ltd. will expire by the end of May,
2025. As I may contribute to QEMU for my research, use my email address
at the lab.

As I'm the only maintainer of igb and no longer financially supported to
maintain it, change its status to Odd Fixes until someone steps up.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250531-rsg-v1-1-e0bae1e1d90e@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 16 ++++++++--------
 .mailmap    |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb2b338fb11..8d2fd4d57d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2519,7 +2519,7 @@ F: tests/qtest/fuzz-megasas-test.c
 
 Network packet abstractions
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: include/net/eth.h
 F: net/eth.c
@@ -2549,13 +2549,13 @@ F: docs/specs/rocker.rst
 
 e1000x
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: hw/net/e1000x*
 
 e1000e
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: hw/net/e1000e*
 F: tests/qtest/fuzz-e1000e-test.c
@@ -2563,9 +2563,9 @@ F: tests/qtest/e1000e-test.c
 F: tests/qtest/libqos/e1000e.*
 
 igb
-M: Akihiko Odaki <akihiko.odaki@daynix.com>
+M: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
-S: Maintained
+S: Odd Fixes
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
 F: tests/functional/test_netdev_ethtool.py
@@ -2910,7 +2910,7 @@ Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: audio/coreaudio.m
 
@@ -3211,7 +3211,7 @@ F: tests/functional/test_vnc.py
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
 
@@ -3738,7 +3738,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: contrib/elf2dmp/
 
diff --git a/.mailmap b/.mailmap
index 33fe75400fe..e7271852dc6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -67,7 +67,8 @@ Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-blo
 BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
 
 # Next, replace old addresses by a more recent one.
-Akihiko Odaki <akihiko.odaki@daynix.com> <akihiko.odaki@gmail.com>
+Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@daynix.com>
+Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@gmail.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
-- 
2.49.0


