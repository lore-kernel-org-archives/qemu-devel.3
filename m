Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45745CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcj-0004Yl-Ku; Wed, 07 Oct 2026 12:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbT-000303-Rv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbL-0006Ml-V2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efr0EQwqaM7nIRbamALYx1igTTFZZhPon5osZVa27+c=;
 b=MfC1NwLXL55zQndMQQRELnr2PvqlRMm5MSh4SFGamLfodp42iT4OvOee64HfEr63hmE3aJ
 Uv1SgJpXEkMbzu9RIbSmbnkYNZycPLQ33W8o7XDKAMZS/Qxp2msjeC6GdLlT68d1TkktVY
 IXYWmoq50jEDXudK2tixjfrGP8gq65g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-1SJd7xzsNAS8rAwxk2fbAA-1; Wed,
 07 Oct 2026 12:34:39 -0400
X-MC-Unique: 1SJd7xzsNAS8rAwxk2fbAA-1
X-Mimecast-MFC-AGG-ID: 1SJd7xzsNAS8rAwxk2fbAA_1791390878
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6E23185FE58; Wed,  7 Oct 2026 16:34:38 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0565E1956087; Wed,  7 Oct 2026 16:34:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/21] iotests: remove unused 'owner=' variable assignment
Date: Wed,  7 Oct 2026 18:32:55 +0200
Message-ID: <20261007163302.332250-15-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Message-ID: <20260810141206.525581-1-berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
index 6f980fd34d6..d26c13ea034 100755
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
index 5ce16475312..865fa0626eb 100755
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
index 03f902a83cb..0594e24b0ec 100755
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
index e955579a671..5591717477b 100755
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
index ba377543b01..ddf72296b42 100755
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
index 936d3f14fba..dedee97181a 100755
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
index fa4990b5139..aee45f90cce 100755
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
index efa852bad30..b6abcf64633 100755
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
index 4ae9027b475..de4067fdb0a 100755
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
index 5c99ac987ff..30deccec5f9 100755
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
index 3a24d2ca8d2..6fda3de6b92 100755
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
index d39d0cd88b6..741292342be 100755
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
index 2d23469332c..edc628ba516 100755
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
index 40c23235a62..e715b596525 100755
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
index 2024b85e797..d26c76621cb 100755
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
index 6fcebbb40ec..7206ccc8735 100755
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
index fa4458fd27b..3f88b793cb2 100755
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
index 60c672e17b9..89acea62105 100755
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
index 0fc89df2fe8..14a24f533d4 100755
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
index d98d1ea90fe..d0974674792 100755
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
index d19d13ff5dc..655e2250e04 100755
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
index 10be2bd8452..48e1f157a9d 100755
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
index 5771ea9200c..233bad58e29 100755
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
index d37e266dade..f43a2bd55b3 100755
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
index 24c93627bb3..3c900da7b5f 100755
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
index 28f01439c52..e19b4a7ed63 100755
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
index 7f4849b97bf..d13e14c2d9c 100755
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
index ee587b1606f..5c825a12566 100755
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
index ebbe7cb0ba1..560af4929da 100755
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
index 4bc7a071bdf..3165e1a8d67 100755
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
index ac1af8f6464..29d12ea2b3c 100755
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
index 0c0c4fdd42f..19a38b51d96 100755
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
index 16a401985ca..584f38e29ff 100755
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
index 85b1015056e..5b56c5214cf 100755
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
index 65bf7a753e8..989335c4682 100755
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
index 94a8bfe754e..8fe677ce731 100755
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
index 411e54ae047..26c35e1430c 100755
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
index f8ce3288db4..5da6d6b607a 100755
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
index 0d84b5c1c75..2242fad455b 100755
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
index 8dd21e0a818..84bc71d6635 100755
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
index bf8e4bf5282..884b330b6b2 100755
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
index a1b922060db..4f41c50df2d 100755
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
index 1de01c312e2..934f6c91877 100755
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
index a722c0c1bc8..25dff9d4eaa 100755
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
index 2f23ac9b65a..8e76c05f47f 100755
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
index 9a2958d42dc..c89128094ce 100755
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
index ea147012c31..d3dd3fa88bb 100755
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
index ce35ff4ee0a..8102c01d5e4 100755
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
index 0634c7bd928..49c58ad05c3 100755
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
index 8d06f84df16..ccdc96b7f8b 100755
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
index b71ac097d14..fd7c3fa940b 100755
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
index 6a71bf14779..4d12b860c90 100755
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
index 3a44758053c..66f90ee518e 100755
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
index 21e25cf39f6..21b27ce88b5 100755
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
index 336d8565ddf..1b379c5faf2 100755
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
index 11b660a8b7c..0a1ce25d6ee 100755
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
index 6647e118613..a1da1ec3c79 100755
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
index edb71afbe37..28e2ba480e7 100755
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
index 83c4ce6314c..fc4eba8e180 100755
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
index 662ede961c4..e97f853f64d 100755
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
index 90afd420bdb..840d36ed696 100755
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
index ee73e636b2f..b3e9510b898 100755
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
index ca2ed2a05c4..f54727074ae 100755
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
index 1a8927d765d..e9069bccc11 100755
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
index fbb90d80361..adbd5db92d3 100755
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
index 0b48b7f137f..e4d2165f189 100755
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
index 793e1f9d08f..053df1c93d1 100755
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
index 33065006837..882161c1406 100755
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
index d9e729f674c..1d4682ec058 100755
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
index 021b9bef063..e1ff3575297 100755
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
index bc32b537b2b..d5906ea29ff 100755
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
index 1181cb7cd06..a397adc9a14 100755
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
index 3fb7b0b5c8c..3256791f249 100755
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
index c055e7bfe18..15606bc3f9b 100755
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
index d8e0e384cdf..815fe3370fd 100755
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
index e3102fe888b..30b08f2abe0 100755
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
index c68c5a66b9b..406cd61279d 100755
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
index 8f88eea9aa7..94052b3fb40 100755
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
index 626203d6fc9..dd590fc0902 100755
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
index bfa116d1919..577ac856797 100755
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
index 4766e9a4587..c1ea7e5bd6d 100755
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
index d1d347eb1fa..c4498f6e702 100755
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
index 93857f4fd02..d5072227605 100755
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
index e3eadb32962..6103579b47a 100755
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
index a5d2d309313..9a89ea85d0d 100755
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
index 4c4a8cea112..f1a8f5a6d9b 100755
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
index 5db8180d3bb..3f56229ab42 100755
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
index bb9fd6f650f..958431be148 100755
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
index 3ebb74cf6e0..20a5657ae48 100755
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
index b8f2029f622..9ae5fca8356 100755
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
index 55548439aad..770176b3742 100755
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
index 3fabff27916..c47e733acb9 100755
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
index bf808b35125..1de718188aa 100755
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
index 0fb580f9a59..a36366912e8 100755
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
index 91b15f7513c..50121ad08be 100755
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
index 382dbf06063..3adc9aab49c 100755
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
index a2ffc96e600..a58918e60d0 100755
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
index a3ad208fd78..ccd93ca8575 100755
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
index dccc71008b5..a040f958b30 100755
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
index 7a24070caad..5c8a12f85aa 100755
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
index 4f40fcb3d21..0e914f754e7 100755
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
index 5cc9433f4a6..7ef8f1fd1ca 100755
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
index ce1b62521f5..ae3cf52e0aa 100755
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
index e4ed87e1a70..f93b2069bb7 100755
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
index f0dd1d11145..cf262501736 100755
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
index be0f6b79e5d..7f84188f51d 100755
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
index 4d34a2ac49e..13e491a5478 100755
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
index 708e7c5ba21..59e63ad5e70 100755
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
index d8d2d654f24..1e6855c5ede 100755
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
index 7cc3ce1d78e..b912b0461b5 100755
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
index d75b1a451a0..1837ad0b8d3 100755
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
index 3d10aba2594..a53b024895c 100755
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
index 3119100e78a..6e183e52bd9 100755
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
index d997db16855..a57620040cb 100755
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
index cc1e35eb161..bf3ee4996dc 100755
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
index 71125719eeb..d00496efffd 100755
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
index 52ee1351840..13c16ea2316 100755
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
index 76628adab7c..1adc295fa63 100755
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
index d923b777e28..aa09a831799 100755
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
index 8538a727ac0..cae04068887 100755
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
index 92a081b79e9..fb12bfbfab6 100755
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
index d284a0e442d..70381a4fe1d 100755
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
index f61a50f6395..bbc3c34c192 100755
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
index f63291d0ffb..455ba1e17b5 100755
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
index fab0faa389c..8a5458944fa 100755
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
index def01d6f3ea..cf7f91d6b46 100755
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
index 24e29ae2ffe..b6ab0729453 100755
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
index a0e4d1ffd42..5a753f46535 100755
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
index 531dbd3122b..b8efdb21447 100755
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
index 8fc4e986532..5de3b3edc81 100755
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
index 4eb476d3a8e..409c0a4652a 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -19,7 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-owner=fullmanet@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 7984a9c6f7e..bab1c4ea474 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -19,7 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-owner=fullmanet@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index 8ca13926297..3c928885fbb 100755
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
index 94dae60d304..4f016118865 100755
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
index 41387e4d660..3a30c82dcc5 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -19,7 +19,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-owner=fullmanet@gmail.com
 
 seq="$(basename $0)"
 echo "QA output created by $seq"
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 87a8aa24d96..20f03c34738 100755
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
index a78e42ff0ad..e0a46155796 100755
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
index 217e55c1685..2a3f3045e56 100755
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
index d4cecb57566..b7e9ab6fa4c 100755
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
index bbbf550a5af..d433ceb47e7 100755
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
index a6a2a4cd44b..8901a83aa3a 100755
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
index 8d8745b29a6..f2aca83e245 100755
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
index 463c59a77f1..f4db4ba2ddf 100755
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
index 09447b56103..a7de5acf1a8 100755
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
index 458cb737f1c..f25392f6494 100755
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
index af5eeb599c1..ebfa76cd670 100755
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
index 9248b3265d8..55a4909a54d 100755
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
index bb577a9cc99..41d4551d067 100755
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
index 9a4215d28e9..538c5ac5e2d 100755
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
index 70b74b033c3..bed45050cc1 100755
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
index 2950b1dc31f..9714c7e8fd9 100755
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
index 008f73b07d0..cf1b567ff92 100755
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
index 7fb84473547..4bc027875b3 100755
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
index ce695b95c25..3465278f656 100755
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
index 6869bd17153..02142e1d2f1 100755
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
index f1df69079f5..1b0fe7eb7dd 100755
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
index 69849c800ed..3286250770c 100755
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
index 6ddeffddd2c..74e432b0bbf 100755
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
index f66c571d240..682bcdce9d2 100755
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
index ab68b6d75cf..8bda9164762 100755
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
index 8128d583d60..2e9ff4c26b5 100755
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
index 6a9adb4a0bc..2fd968a0dbe 100755
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
index eddaad679e2..02978bf2a07 100755
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
index aaa6996ce3a..21aaf707504 100755
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
index eddc8e9641d..ba17e9489c5 100755
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
index 1ee0aae481d..b07a346d75a 100755
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
index 55db5b3811f..f0ccdee4b2c 100755
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
index 3cf0de4043f..a10fea28024 100755
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
index 4f0037148d9..83061b7b2ea 100755
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
index 8bbb510120d..4394d3711ab 100755
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
index 2a98ad58f5d..a8af524c122 100755
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
index cee5131c3ce..7e1c96a8bcb 100755
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
index ace6dba052a..8fb72082c77 100755
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
index 1254bf94291..73c17343c0a 100755
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
index c0a0dbc0ff1..98b81cd217e 100755
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
index 794cad58b26..b90b3914de4 100755
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
index 522333cf1dc..29facfd2a60 100755
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
index 1a4c9c6885e..4a787d59086 100755
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
index 5e4dba02e76..ab542ac0b4e 100755
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
index 82f5de4b340..48eada5e7ef 100755
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
index 22b969d3108..f9fed94e1e2 100755
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
index 44fdada0d6f..ab2dea7627c 100755
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
index e14aeb1f18d..1ee76edec44 100755
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
index 9a8a5637603..444acf8b3cc 100755
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
index 59a6fafa2fa..26c6b078259 100755
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
index 722267486d0..f9268a0e9ce 100755
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
index 6414640b212..a22c185791e 100755
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
index 47aca6592a6..81c652c085e 100755
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
index 776b59de1bc..341a25f96b5 100755
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
index 73cbb9364ac..ef1b2881a5c 100755
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
index 37294487b11..47fef797429 100755
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
index 9059eb26b3b..3e34cb66eab 100755
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
index e980ec513f2..7c7a507ce52 100755
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
index 03c7c1cbe3c..99b25300107 100755
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
index 8b26156923d..798ced27654 100755
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
index 0d9ea09a31f..8dfb92a5baf 100755
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
index a75655b7ef0..675f6e4382e 100755
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
index 96d7b4d2581..91f222130eb 100755
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
index de00273e727..d9fa8629acd 100755
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
index 5eaf34e5a6b..ddf636239d7 100755
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
index 36e4598c621..d8de0831943 100755
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
index 455ddfa86fe..9a977e5a1bd 100755
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
index a2fb07206e5..6cf52a0aa92 100755
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
index ca89ed5d62c..eb0a32d636b 100755
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
index 95f6195ab86..e7d75042117 100755
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
index d301f0941b5..4ea382e88f7 100755
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
index 50bfb6cfa2a..91270fe6703 100755
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
index 9b843af6312..6bd5e81e761 100755
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
index ca264e93d61..5354c5fb0c1 100755
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
2.56.0


