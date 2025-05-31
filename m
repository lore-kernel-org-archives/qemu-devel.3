Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57AC5B555
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 13:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLLz3-0006cH-C5; Sat, 31 May 2025 09:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLGDE-00078S-Vg
 for qemu-devel@nongnu.org; Sat, 31 May 2025 03:01:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLGDB-00040i-FM
 for qemu-devel@nongnu.org; Sat, 31 May 2025 03:01:00 -0400
Received: from [10.100.116.185] ([157.82.128.1]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 54V70S8v047873
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 May 2025 16:00:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WLPKfFbJjojhSsArpvORO5cSn5OPIHdRIvnxHihlj/U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1748674839; v=1;
 b=SrGF+Y7q33ukpuiJ77r/75DPGeVx5f7F7pZxi08nejemAorIMhIPmStvbArawLx/
 oIhsfPvzAk6n//OwiYDdKlVzuY5Tqsww/juekQkLdZ5vaMCdb16QTrE5a8xzXjxE
 lVQIkVss5IpH8dwKfsVNmWTl8rCtpoPNjDPo0rBUTyl2cpkotim5C+eKsr928Xon
 oApRuArY6nZlKZGx7S6ozh5Humacy2TfK1Eo/onu690mftMw+QwNljtj4QmeXwNo
 JqYQpEZESlIlnClbT0qI2TNxF6IaJAD4odFik0ty5+4TpbS+nLTS9WMsn9qt1Nq0
 pyutrfZyM/9O7Y+2saFchw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 31 May 2025 16:00:25 +0900
Subject: [PATCH] MAINTAINERS: Update Akihiko Odaki's affiliation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250531-rsg-v1-1-e0bae1e1d90e@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAipOmgC/3WMwQ6CMBAFf4X0bJtuoSCc/A/DAcsWVhNKWiQSw
 r9biInx4HFe3szKAnrCwKpkZR5nCuSGCHBKmOmboUNObWSmpNJSp5L70HEDhUJryzzVhsXn6NH
 S66hc68g9hcn55YjOsK+//gwcuAZpU5XbVpvsEldhSJB48sk9FicaI+7j3v6I8BVVBsUts3hWZ
 flPrLdtewOofFiQ3AAAAA==
X-Change-ID: 20250530-rsg-c172eff9635c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, devel@daynix.com,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 May 2025 09:10:43 -0400
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

My contract with Daynix Computing Ltd. will expire by the end of May,
2025. As I may contribute to QEMU for my research, use my email address
at the lab.

As I'm the only maintainer of igb and no longer financially supported to
maintain it, change its status to Odd Fixes until someone steps up.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
My email address at Daynix will remain active at least for the next
month.

I added the submitter of the patches I recently reviewed to Cc. Please
Cc my new email address for future reviews.

I have a number of patches that are not pulled yet. Colleagues at Daynix
will take over the patches which are interests of the company. I will
keep working on some patches that are my personal interests.

In particular, I intend to continue my work for Mac, Arm, graphics, and
other trivial/generic improvements of QEMU. I will repost the patches I
intend to continue upsreaming but are unlikely to be pulled soon with my
new email address by the end of the next month.

It was a great experience to contribute to QEMU as part of my job at
Daynix. I hope others did/will find my contributions useful (and,
ideally, not troubling).

Please feeel free to ask if you have any question. And just in case: I
intend to focus on my research and am not interested in a job
opportunity for now.
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/qemu-devel/20250531-rsg-v1-1-2417b4fe8299@rsg.ci.i.u-tokyo.ac.jp
---
 MAINTAINERS | 16 ++++++++--------
 .mailmap    |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7060cf49b986..4b26189749d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2518,7 +2518,7 @@ F: tests/qtest/fuzz-megasas-test.c
 
 Network packet abstractions
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: include/net/eth.h
 F: net/eth.c
@@ -2548,13 +2548,13 @@ F: docs/specs/rocker.rst
 
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
@@ -2562,9 +2562,9 @@ F: tests/qtest/e1000e-test.c
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
@@ -2909,7 +2909,7 @@ Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: audio/coreaudio.m
 
@@ -3200,7 +3200,7 @@ F: tests/functional/test_vnc.py
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
 
@@ -3727,7 +3727,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
-R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Maintained
 F: contrib/elf2dmp/
 
diff --git a/.mailmap b/.mailmap
index 33fe75400fe3..e7271852dc6a 100644
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

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250530-rsg-c172eff9635c

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


