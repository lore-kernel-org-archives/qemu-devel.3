Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB9C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtQjr-0001ur-JU; Mon, 10 Aug 2026 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtQjk-0001ty-6h
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtQjf-0001ow-5p
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786371133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Is0r0UP9o4Xzra0C4dJKu1O0Rj2YnrqiH6K8F5ob6Q8=;
 b=PvvMeRbWBItTgHW7CLFGhjqfUkSi2/1tfXPvK4d+ifeecdXymJfFzjZlhbMUme3ueTqGnc
 3An12sf5lM9S2qF0TTsr9mfeU0rNUgJLdsBdiYlXfBrta1hW2rmRfBl1gyc5iXhdSJxApL
 Lijx/s3XxJ5Y6M/xSYIRwcqzIPfi/Ng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-UroTlEOGMnyhe5OxUFb2TQ-1; Mon,
 10 Aug 2026 10:12:11 -0400
X-MC-Unique: UroTlEOGMnyhe5OxUFb2TQ-1
X-Mimecast-MFC-AGG-ID: UroTlEOGMnyhe5OxUFb2TQ_1786371130
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B29618009C6; Mon, 10 Aug 2026 14:12:10 +0000 (UTC)
Received: from berrange.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C510319560AB; Mon, 10 Aug 2026 14:12:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] iotests: remove unused 'owner=' variable assignment
Date: Mon, 10 Aug 2026 15:12:06 +0100
Message-ID: <20260810141206.525581-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Most, but not all, of the shell I/O tests assign an email address to
the 'owner' shell variable. This variable is never used for anything
so gets reported as a dead assignment by shellcheck. The same is also
not done for the python I/O tests, though some include owner= in a
comment.

Mostly the 'owner=' variable seems to be an alternative to expressing
an "Author: NAME <EMAIL>" comment, but without the NAME. While they
could be converted to Author comments, this does not have a benefit
over using Git history and are not widely used in QEMU source code.
Git records activity over time so is more representative than the
initial author. Meanwhile the MAINTAINERS file, also expresses a
notion of ownership over the maint of files.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/001                                | 2 --
 tests/qemu-iotests/002                                | 2 --
 tests/qemu-iotests/003                                | 2 --
 tests/qemu-iotests/004                                | 2 --
 tests/qemu-iotests/005                                | 2 --
 tests/qemu-iotests/007                                | 2 --
 tests/qemu-iotests/008                                | 2 --
 tests/qemu-iotests/009                                | 2 --
 tests/qemu-iotests/010                                | 2 --
 tests/qemu-iotests/011                                | 2 --
 tests/qemu-iotests/012                                | 2 --
 tests/qemu-iotests/013                                | 2 --
 tests/qemu-iotests/014                                | 2 --
 tests/qemu-iotests/015                                | 2 --
 tests/qemu-iotests/017                                | 2 --
 tests/qemu-iotests/018                                | 2 --
 tests/qemu-iotests/019                                | 2 --
 tests/qemu-iotests/020                                | 2 --
 tests/qemu-iotests/021                                | 2 --
 tests/qemu-iotests/022                                | 2 --
 tests/qemu-iotests/023                                | 2 --
 tests/qemu-iotests/024                                | 2 --
 tests/qemu-iotests/025                                | 2 --
 tests/qemu-iotests/026                                | 2 --
 tests/qemu-iotests/027                                | 2 --
 tests/qemu-iotests/028                                | 2 --
 tests/qemu-iotests/029                                | 2 --
 tests/qemu-iotests/031                                | 2 --
 tests/qemu-iotests/032                                | 2 --
 tests/qemu-iotests/033                                | 2 --
 tests/qemu-iotests/034                                | 2 --
 tests/qemu-iotests/035                                | 2 --
 tests/qemu-iotests/036                                | 2 --
 tests/qemu-iotests/037                                | 2 --
 tests/qemu-iotests/038                                | 2 --
 tests/qemu-iotests/039                                | 2 --
 tests/qemu-iotests/042                                | 2 --
 tests/qemu-iotests/043                                | 2 --
 tests/qemu-iotests/046                                | 2 --
 tests/qemu-iotests/047                                | 2 --
 tests/qemu-iotests/048                                | 2 --
 tests/qemu-iotests/049                                | 2 --
 tests/qemu-iotests/050                                | 2 --
 tests/qemu-iotests/051                                | 2 --
 tests/qemu-iotests/052                                | 2 --
 tests/qemu-iotests/053                                | 2 --
 tests/qemu-iotests/054                                | 2 --
 tests/qemu-iotests/058                                | 2 --
 tests/qemu-iotests/059                                | 2 --
 tests/qemu-iotests/060                                | 2 --
 tests/qemu-iotests/061                                | 2 --
 tests/qemu-iotests/062                                | 2 --
 tests/qemu-iotests/063                                | 2 --
 tests/qemu-iotests/064                                | 2 --
 tests/qemu-iotests/066                                | 2 --
 tests/qemu-iotests/068                                | 2 --
 tests/qemu-iotests/069                                | 2 --
 tests/qemu-iotests/070                                | 2 --
 tests/qemu-iotests/071                                | 2 --
 tests/qemu-iotests/072                                | 2 --
 tests/qemu-iotests/073                                | 2 --
 tests/qemu-iotests/074                                | 2 --
 tests/qemu-iotests/075                                | 2 --
 tests/qemu-iotests/076                                | 2 --
 tests/qemu-iotests/077                                | 2 --
 tests/qemu-iotests/078                                | 2 --
 tests/qemu-iotests/079                                | 2 --
 tests/qemu-iotests/080                                | 2 --
 tests/qemu-iotests/081                                | 2 --
 tests/qemu-iotests/082                                | 2 --
 tests/qemu-iotests/083                                | 2 --
 tests/qemu-iotests/084                                | 2 --
 tests/qemu-iotests/085                                | 2 --
 tests/qemu-iotests/086                                | 2 --
 tests/qemu-iotests/087                                | 2 --
 tests/qemu-iotests/088                                | 2 --
 tests/qemu-iotests/089                                | 2 --
 tests/qemu-iotests/090                                | 2 --
 tests/qemu-iotests/091                                | 2 --
 tests/qemu-iotests/092                                | 2 --
 tests/qemu-iotests/094                                | 2 --
 tests/qemu-iotests/095                                | 2 --
 tests/qemu-iotests/097                                | 2 --
 tests/qemu-iotests/098                                | 2 --
 tests/qemu-iotests/099                                | 2 --
 tests/qemu-iotests/101                                | 2 --
 tests/qemu-iotests/102                                | 2 --
 tests/qemu-iotests/103                                | 2 --
 tests/qemu-iotests/104                                | 2 --
 tests/qemu-iotests/105                                | 2 --
 tests/qemu-iotests/106                                | 2 --
 tests/qemu-iotests/107                                | 2 --
 tests/qemu-iotests/108                                | 2 --
 tests/qemu-iotests/109                                | 2 --
 tests/qemu-iotests/110                                | 2 --
 tests/qemu-iotests/111                                | 2 --
 tests/qemu-iotests/112                                | 2 --
 tests/qemu-iotests/113                                | 2 --
 tests/qemu-iotests/114                                | 2 --
 tests/qemu-iotests/115                                | 2 --
 tests/qemu-iotests/116                                | 2 --
 tests/qemu-iotests/117                                | 2 --
 tests/qemu-iotests/119                                | 2 --
 tests/qemu-iotests/120                                | 2 --
 tests/qemu-iotests/121                                | 2 --
 tests/qemu-iotests/122                                | 2 --
 tests/qemu-iotests/123                                | 2 --
 tests/qemu-iotests/125                                | 2 --
 tests/qemu-iotests/126                                | 2 --
 tests/qemu-iotests/127                                | 2 --
 tests/qemu-iotests/128                                | 2 --
 tests/qemu-iotests/130                                | 2 --
 tests/qemu-iotests/131                                | 2 --
 tests/qemu-iotests/133                                | 2 --
 tests/qemu-iotests/134                                | 2 --
 tests/qemu-iotests/135                                | 2 --
 tests/qemu-iotests/137                                | 2 --
 tests/qemu-iotests/138                                | 2 --
 tests/qemu-iotests/140                                | 2 --
 tests/qemu-iotests/142                                | 2 --
 tests/qemu-iotests/143                                | 2 --
 tests/qemu-iotests/144                                | 2 --
 tests/qemu-iotests/145                                | 2 --
 tests/qemu-iotests/146                                | 2 --
 tests/qemu-iotests/150                                | 2 --
 tests/qemu-iotests/153                                | 2 --
 tests/qemu-iotests/154                                | 2 --
 tests/qemu-iotests/156                                | 2 --
 tests/qemu-iotests/157                                | 2 --
 tests/qemu-iotests/158                                | 2 --
 tests/qemu-iotests/159                                | 1 -
 tests/qemu-iotests/160                                | 1 -
 tests/qemu-iotests/161                                | 2 --
 tests/qemu-iotests/162                                | 2 --
 tests/qemu-iotests/170                                | 1 -
 tests/qemu-iotests/171                                | 2 --
 tests/qemu-iotests/172                                | 2 --
 tests/qemu-iotests/173                                | 2 --
 tests/qemu-iotests/174                                | 2 --
 tests/qemu-iotests/175                                | 2 --
 tests/qemu-iotests/176                                | 2 --
 tests/qemu-iotests/177                                | 2 --
 tests/qemu-iotests/178                                | 2 --
 tests/qemu-iotests/179                                | 2 --
 tests/qemu-iotests/181                                | 2 --
 tests/qemu-iotests/182                                | 2 --
 tests/qemu-iotests/184                                | 2 --
 tests/qemu-iotests/185                                | 2 --
 tests/qemu-iotests/186                                | 2 --
 tests/qemu-iotests/187                                | 2 --
 tests/qemu-iotests/188                                | 2 --
 tests/qemu-iotests/189                                | 2 --
 tests/qemu-iotests/190                                | 2 --
 tests/qemu-iotests/191                                | 2 --
 tests/qemu-iotests/192                                | 2 --
 tests/qemu-iotests/195                                | 2 --
 tests/qemu-iotests/197                                | 2 --
 tests/qemu-iotests/198                                | 2 --
 tests/qemu-iotests/200                                | 2 --
 tests/qemu-iotests/204                                | 2 --
 tests/qemu-iotests/225                                | 2 --
 tests/qemu-iotests/226                                | 2 --
 tests/qemu-iotests/227                                | 2 --
 tests/qemu-iotests/229                                | 2 --
 tests/qemu-iotests/231                                | 2 --
 tests/qemu-iotests/232                                | 2 --
 tests/qemu-iotests/233                                | 2 --
 tests/qemu-iotests/236                                | 1 -
 tests/qemu-iotests/239                                | 2 --
 tests/qemu-iotests/243                                | 2 --
 tests/qemu-iotests/244                                | 2 --
 tests/qemu-iotests/246                                | 1 -
 tests/qemu-iotests/247                                | 2 --
 tests/qemu-iotests/249                                | 2 --
 tests/qemu-iotests/250                                | 2 --
 tests/qemu-iotests/251                                | 2 --
 tests/qemu-iotests/252                                | 2 --
 tests/qemu-iotests/256                                | 1 -
 tests/qemu-iotests/257                                | 1 -
 tests/qemu-iotests/259                                | 2 --
 tests/qemu-iotests/261                                | 2 --
 tests/qemu-iotests/263                                | 2 --
 tests/qemu-iotests/267                                | 2 --
 tests/qemu-iotests/268                                | 2 --
 tests/qemu-iotests/271                                | 2 --
 tests/qemu-iotests/284                                | 2 --
 tests/qemu-iotests/287                                | 2 --
 tests/qemu-iotests/288                                | 2 --
 tests/qemu-iotests/290                                | 2 --
 tests/qemu-iotests/292                                | 2 --
 tests/qemu-iotests/293                                | 2 --
 tests/qemu-iotests/294                                | 2 --
 tests/qemu-iotests/302                                | 1 -
 tests/qemu-iotests/304                                | 1 -
 tests/qemu-iotests/305                                | 2 --
 tests/qemu-iotests/312                                | 2 --
 tests/qemu-iotests/313                                | 2 --
 tests/qemu-iotests/314                                | 2 --
 tests/qemu-iotests/tests/commit-zero-blocks           | 2 --
 tests/qemu-iotests/tests/detect-zeroes-registered-buf | 2 --
 tests/qemu-iotests/tests/iothreads-resize             | 2 --
 tests/qemu-iotests/tests/nbd-in-qcow2-chain           | 2 --
 tests/qemu-iotests/tests/nbd-tls-iothread             | 2 --
 tests/qemu-iotests/tests/parallels-checks             | 2 --
 tests/qemu-iotests/tests/qcow2-encryption             | 2 --
 tests/qemu-iotests/tests/qcow2-internal-snapshots     | 2 --
 tests/qemu-iotests/tests/qemu-img-close-errors        | 2 --
 tests/qemu-iotests/tests/qsd-jobs                     | 2 --
 tests/qemu-iotests/tests/regression-vhdx-log          | 2 --
 209 files changed, 409 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 6f980fd34d..d26c13ea03 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 5ce1647531..865fa0626e 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 03f902a83c..0594e24b0e 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index e955579a67..5591717477 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index ba377543b0..ddf72296b4 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -22,8 +22,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 936d3f14fb..dedee97181 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index fa4990b513..aee45f90cc 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index efa852bad3..b6abcf6463 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 4ae9027b47..de4067fdb0 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 5c99ac987f..30deccec5f 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 3a24d2ca8d..6fda3de6b9 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d39d0cd88b..741292342b 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 2d23469332..edc628ba51 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index 40c23235a6..e715b59652 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 2024b85e79..d26c76621c 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 6fcebbb40e..7206ccc873 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index fa4458fd27..3f88b793cb 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 60c672e17b..89acea6210 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 0fc89df2fe..14a24f533d 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hch@lst.de
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index d98d1ea90f..d097467479 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -19,8 +19,6 @@
 # along with this program. If not, see <https://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index d19d13ff5d..655e2250e0 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 10be2bd845..48e1f157a9 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index 5771ea9200..233bad58e2 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index d37e266dad..f43a2bd55b 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 24c93627bb..3c900da7b5 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 2b232c4614..bd11d70c4b 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -22,8 +22,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 7f4849b97b..d13e14c2d9 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index ee587b1606..5c825a1256 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index ebbe7cb0ba..560af4929d 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 4bc7a071bd..3165e1a8d6 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=pbonzini@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index ac1af8f646..29d12ea2b3 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 0c0c4fdd42..19a38b51d9 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 16a401985c..584f38e29f 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -22,8 +22,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 85b1015056..5b56c5214c 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 65bf7a753e..989335c468 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index e43e7026ce..fc150c37c4 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -22,8 +22,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index 411e54ae04..26c35e1430 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index f8ce3288db..5da6d6b607 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 0d84b5c1c7..2242fad455 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 8dd21e0a81..84bc71d663 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index bf8e4bf528..884b330b6b 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -20,8 +20,6 @@
 ## along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ##
 #
-# creator
-owner=mrezanin@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index a1b922060d..4f41c50df2 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 1de01c312e..934f6c9187 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=pbonzini@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 4c079b11e3..64fbe8bbfe 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 2f23ac9b65..8e76c05f47 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 9a2958d42d..c89128094c 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index ea147012c3..d3dd3fa88b 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index ce35ff4ee0..8102c01d5e 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=xiawenc@linux.vnet.ibm.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 0634c7bd92..49c58ad05c 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=fam@euphon.net
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 5cd21a6f68..4a22eb72d8 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index b71ac097d1..fd7c3fa940 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 6a71bf1477..4d12b860c9 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 3a44758053..66f90ee518 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=alex@alex.org.uk
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 21e25cf39f..21b27ce88b 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 336d8565dd..1b379c5faf 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 7ecd247409..baecc769a6 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 6647e11861..a1da1ec3c7 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index edb71afbe3..28e2ba480e 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 331f8cfddc..90ab86cfbf 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 662ede961c..e97f853f64 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 90afd420bd..840d36ed69 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index ee73e636b2..b3e9510b89 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -20,8 +20,6 @@
 ## along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ##
 #
-# creator
-owner=fam@euphon.net
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index ca2ed2a05c..f54727074a 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index 1a8927d765..e9069bccc1 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index fbb90d8036..adbd5db92d 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index 0b48b7f137..e4d2165f18 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 793e1f9d08..053df1c93d 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hutao@cn.fujitsu.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 3306500683..882161c140 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 1ac66f197e..ed814dc233 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=benoit@irqsave.net
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 021b9bef06..e1ff357529 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index bc32b537b2..d5906ea29f 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 1181cb7cd0..a397adc9a1 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 3fb7b0b5c8..3256791f24 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -24,8 +24,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index c055e7bfe1..15606bc3f9 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index d8e0e384cd..815fe3370f 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index e3102fe888..30b08f2abe 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index c68c5a66b9..406cd61279 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 8f88eea9aa..94052b3fb4 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index e396748a91..5fdfc78736 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index bfa116d191..577ac85679 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 4766e9a458..c1ea7e5bd6 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index d1d347eb1f..c4498f6e70 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -22,8 +22,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 93857f4fd0..d507222760 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index e3eadb3296..6103579b47 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index a5d2d30931..9a89ea85d0 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index 4c4a8cea11..f1a8f5a6d9 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 141bfe1e90..94961fd80a 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index bb9fd6f650..958431be14 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 3ebb74cf6e..20a5657ae4 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hutao@cn.fujitsu.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index b8f2029f62..9ae5fca835 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=fam@euphon.net
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 55548439aa..770176b374 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 3fabff2791..c47e733acb 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index bf808b3512..1de718188a 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 0fb580f9a5..a36366912e 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 91b15f7513..50121ad08b 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 382dbf0606..3adc9aab49 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index a2ffc96e60..a58918e60d 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index a3ad208fd7..ccd93ca857 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index dccc71008b..a040f958b3 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 7a24070caa..5c8a12f85a 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index 4f40fcb3d2..0e914f754e 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -22,8 +22,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6081473584..f49bf0d7ad 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 6cac8793ba..bd8aa76210 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index ac7bd8c4e3..7fe961da28 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index f0dd1d1114..cf26250173 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index be0f6b79e5..7f84188f51 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index 4d34a2ac49..13e491a547 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 708e7c5ba2..59e63ad5e7 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index d8d2d654f2..1e6855c5ed 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 7cc3ce1d78..b912b0461b 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index d75b1a451a..1837ad0b8d 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 7af85d20a8..24211a1a07 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 3119100e78..6e183e52bd 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=den@openvz.org
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index d997db1685..a57620040c 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index cc1e35eb16..bf3ee4996d 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index 71125719ee..d00496efff 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 52ee135184..13c16ea231 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 76628adab7..1adc295fa6 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index d923b777e2..aa09a83179 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -23,8 +23,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 86d65a2d1a..ccdc6ff95a 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -18,8 +18,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 92a081b79e..fb12bfbfab 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index d284a0e442..70381a4fe1 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index a2ce92516d..03ebeb5cb5 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 661a9d2625..528c62336f 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index fab0faa389..8a5458944f 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 1e02f6a6e3..a5a741cccd 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=fam@euphon.net
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 24e29ae2ff..b6ab072945 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 97c2d86ce5..c8637d0bf9 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -27,8 +27,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index aa2ebbfb4b..2c64c1b504 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 8fc4e98653..5de3b3edc8 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 4eb476d3a8..409c0a4652 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -19,7 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-owner=fullmanet@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 7984a9c6f7..bab1c4ea47 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -19,7 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-owner=fullmanet@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f25effab93..d9fb87610d 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 94dae60d30..4f01611886 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 41387e4d66..3a30c82dcc 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -19,7 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-owner=fullmanet@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index d1d77f7013..e1c03a0c41 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=tgolembi@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 4da0e0f2e2..afb0ab06e8 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 217e55c168..2a3f3045e5 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -19,8 +19,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index d4cecb5756..b7e9ab6fa4 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=nirsof@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index bbbf550a5a..d433ceb47e 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=nirsof@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index a6a2a4cd44..8901a83aa3 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -24,8 +24,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 8d8745b29a..f2aca83e24 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=eblake@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 463c59a77f..f4db4ba2dd 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 09447b5610..a7de5acf1a 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=eblake@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index b904e8ce01..7e69a05b31 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index af5eeb599c..ebfa76cd67 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=fam@euphon.net
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 9248b3265d..55a4909a54 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner="Manos Pitsidianakis"
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index a62ae8d329..eafaeede5b 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index eaf13c7a33..05f7272bd3 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 70b74b033c..bed45050cc 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 2950b1dc31..9714c7e8fd 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 008f73b07d..cf1b567ff9 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 7fb8447354..4bc027875b 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=eblake@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ce695b95c2..3465278f65 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index e66e1a4f06..52563af545 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=fam@euphon.net
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index f1df69079f..1b0fe7eb7d 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 69849c800e..3286250770 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=eblake@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 6ddeffddd2..74e432b0bb 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index f66c571d24..682bcdce9d 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index ab68b6d75c..8bda916476 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=eblake@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index b5949fcb58..4f52182979 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 6a9adb4a0b..2fd968a0db 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=jsnow@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index eddaad679e..02978bf2a0 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index aaa6996ce3..21aaf70750 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index eddc8e9641..ba17e9489c 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=codyprime@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index b30faaa218..483cf0687c 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 55db5b3811..f0ccdee4b2 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 20419bbb9e..ea11b7ed7e 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# owner=jsnow@redhat.com
 
 import iotests
 from iotests import log
diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
index 4f0037148d..83061b7b2e 100755
--- a/tests/qemu-iotests/239
+++ b/tests/qemu-iotests/239
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=npes87184@gmail.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index 8bbb510120..4394d3711a 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 2a98ad58f5..a8af524c12 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index b009a78397..d039549463 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# owner=jsnow@redhat.com
 
 import iotests
 from iotests import log
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index ace6dba052..8fb72082c7 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 28bffd4d57..d6a6fc7cf8 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index c0a0dbc0ff..98b81cd217 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=v.sementsov-og@mail.ru
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/251 b/tests/qemu-iotests/251
index 794cad58b2..b90b3914de 100755
--- a/tests/qemu-iotests/251
+++ b/tests/qemu-iotests/251
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
index 522333cf1d..29facfd2a6 100755
--- a/tests/qemu-iotests/252
+++ b/tests/qemu-iotests/252
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..22d04a0b36 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# owner=jsnow@redhat.com
 
 import os
 import iotests
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index cd0468aaa1..6e83d26e1f 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# owner=jsnow@redhat.com
 
 import math
 import os
diff --git a/tests/qemu-iotests/259 b/tests/qemu-iotests/259
index 82f5de4b34..48eada5e7e 100755
--- a/tests/qemu-iotests/259
+++ b/tests/qemu-iotests/259
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
index 22b969d310..f9fed94e1e 100755
--- a/tests/qemu-iotests/261
+++ b/tests/qemu-iotests/261
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
 
 seq=$(basename $0)
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
index 44fdada0d6..ab2dea7627 100755
--- a/tests/qemu-iotests/263
+++ b/tests/qemu-iotests/263
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=mlevitsk@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 2e2afdad9c..c751e1f570 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
index 9a8a563760..444acf8b3c 100755
--- a/tests/qemu-iotests/268
+++ b/tests/qemu-iotests/268
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index 59a6fafa2f..26c6b07825 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
index 722267486d..f9268a0e9c 100755
--- a/tests/qemu-iotests/284
+++ b/tests/qemu-iotests/284
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berrange@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
index 6414640b21..a22c185791 100755
--- a/tests/qemu-iotests/287
+++ b/tests/qemu-iotests/287
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=dplotnikov@virtuozzo.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/288 b/tests/qemu-iotests/288
index 47aca6592a..81c652c085 100755
--- a/tests/qemu-iotests/288
+++ b/tests/qemu-iotests/288
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 776b59de1b..341a25f96b 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/292 b/tests/qemu-iotests/292
index 73cbb9364a..ef1b2881a5 100755
--- a/tests/qemu-iotests/292
+++ b/tests/qemu-iotests/292
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/293 b/tests/qemu-iotests/293
index 37294487b1..47fef79742 100755
--- a/tests/qemu-iotests/293
+++ b/tests/qemu-iotests/293
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=mlevitsk@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/294 b/tests/qemu-iotests/294
index 9059eb26b3..3e34cb66ea 100755
--- a/tests/qemu-iotests/294
+++ b/tests/qemu-iotests/294
@@ -17,8 +17,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=mlevitsk@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
index e980ec513f..7c7a507ce5 100755
--- a/tests/qemu-iotests/302
+++ b/tests/qemu-iotests/302
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# owner=nirsof@gmail.com
 
 import io
 import tarfile
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 198f282087..7bf9d6cfaa 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# owner=s.reiter@proxmox.com
 
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
diff --git a/tests/qemu-iotests/305 b/tests/qemu-iotests/305
index 8b26156923..798ced2765 100755
--- a/tests/qemu-iotests/305
+++ b/tests/qemu-iotests/305
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/312 b/tests/qemu-iotests/312
index 0d9ea09a31..8dfb92a5ba 100755
--- a/tests/qemu-iotests/312
+++ b/tests/qemu-iotests/312
@@ -25,8 +25,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/313 b/tests/qemu-iotests/313
index a75655b7ef..675f6e4382 100755
--- a/tests/qemu-iotests/313
+++ b/tests/qemu-iotests/313
@@ -21,8 +21,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=berto@igalia.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/314 b/tests/qemu-iotests/314
index 96d7b4d258..91f222130e 100755
--- a/tests/qemu-iotests/314
+++ b/tests/qemu-iotests/314
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=andrey.drobyshev@virtuozzo.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/commit-zero-blocks b/tests/qemu-iotests/tests/commit-zero-blocks
index de00273e72..d9fa8629ac 100755
--- a/tests/qemu-iotests/tests/commit-zero-blocks
+++ b/tests/qemu-iotests/tests/commit-zero-blocks
@@ -23,8 +23,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-# creator
-owner=libvirt-e6954efa@volkihar.be
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/detect-zeroes-registered-buf b/tests/qemu-iotests/tests/detect-zeroes-registered-buf
index 5eaf34e5a6..ddf636239d 100755
--- a/tests/qemu-iotests/tests/detect-zeroes-registered-buf
+++ b/tests/qemu-iotests/tests/detect-zeroes-registered-buf
@@ -22,8 +22,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=stefanha@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/iothreads-resize b/tests/qemu-iotests/tests/iothreads-resize
index 36e4598c62..d8de083194 100755
--- a/tests/qemu-iotests/tests/iothreads-resize
+++ b/tests/qemu-iotests/tests/iothreads-resize
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
index 455ddfa86f..9a977e5a1b 100755
--- a/tests/qemu-iotests/tests/nbd-in-qcow2-chain
+++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
@@ -7,8 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-# creator
-owner=eblake@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread b/tests/qemu-iotests/tests/nbd-tls-iothread
index a2fb07206e..6cf52a0aa9 100755
--- a/tests/qemu-iotests/tests/nbd-tls-iothread
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=eblake@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index d2a08049d9..0cb31e8369 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=alexander.ivanov@virtuozzo.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/qcow2-encryption b/tests/qemu-iotests/tests/qcow2-encryption
index 95f6195ab8..e7d7504211 100755
--- a/tests/qemu-iotests/tests/qcow2-encryption
+++ b/tests/qemu-iotests/tests/qcow2-encryption
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots b/tests/qemu-iotests/tests/qcow2-internal-snapshots
index 9f83aa8903..6f293aa61c 100755
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/qemu-img-close-errors b/tests/qemu-iotests/tests/qemu-img-close-errors
index 50bfb6cfa2..91270fe670 100755
--- a/tests/qemu-iotests/tests/qemu-img-close-errors
+++ b/tests/qemu-iotests/tests/qemu-img-close-errors
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/qsd-jobs b/tests/qemu-iotests/tests/qsd-jobs
index 9b843af631..6bd5e81e76 100755
--- a/tests/qemu-iotests/tests/qsd-jobs
+++ b/tests/qemu-iotests/tests/qsd-jobs
@@ -19,8 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/tests/regression-vhdx-log b/tests/qemu-iotests/tests/regression-vhdx-log
index ca264e93d6..5354c5fb0c 100755
--- a/tests/qemu-iotests/tests/regression-vhdx-log
+++ b/tests/qemu-iotests/tests/regression-vhdx-log
@@ -20,8 +20,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
 
 seq=`basename $0`
 echo "QA output created by $seq"
-- 
2.55.0


