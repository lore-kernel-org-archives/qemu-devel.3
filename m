Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B3EC77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZD-0003xS-TB; Thu, 26 Jun 2025 01:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZ9-0003wI-Ev
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZ7-00018A-FY
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZ9QICknluBmUezrPCElYQwYs2ViKwqLAcd4ByFmfAg=;
 b=b1BWloetYAeaZHWrjyfMg70Xjsm4aOSFRKPZEaYbCKpitmvBoNIa0+L8Aq3pV2EvTgiN5B
 z1oa/mcnF1LmwuVvOkN9qDlEByY2izsGftAKRaQ3CGVXe/8pjlIwGOQU5jLP3y5IxcVX/k
 B6adrqqt3uGbSpJSAI/c7z70qE6oLkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-rfChUDFTNoSsDBZtRFAq2Q-1; Thu,
 26 Jun 2025 01:54:24 -0400
X-MC-Unique: rfChUDFTNoSsDBZtRFAq2Q-1
X-Mimecast-MFC-AGG-ID: rfChUDFTNoSsDBZtRFAq2Q_1750917263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5776519560BA; Thu, 26 Jun 2025 05:54:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2011B19560A3; Thu, 26 Jun 2025 05:54:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 09/19] COPYING: replace FSF postal address with licenses URL
Date: Thu, 26 Jun 2025 07:53:40 +0200
Message-ID: <20250626055350.218271-10-thuth@redhat.com>
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

From: Sean Wei <me@sean.taipei>

The license text in COPYING (GPLv2), COPYING.LIB (LGPLv2.1),
and the linux-headers/LICENSES/preferred/GPL-2.0 file are
referenced to the obsolete FSF postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
Message-ID: <20250613.qemu.patch.01@sean.taipei>
[thuth: dropped the changes to the linux-headers folder]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 COPYING     | 5 ++---
 COPYING.LIB | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/COPYING b/COPYING
index 00ccfbb6288..8095135d50d 100644
--- a/COPYING
+++ b/COPYING
@@ -2,7 +2,7 @@
 		       Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -304,8 +304,7 @@ the "copyright" line and a pointer to where the full notice is found.
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+    with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
diff --git a/COPYING.LIB b/COPYING.LIB
index 4362b49151d..99f47575b5b 100644
--- a/COPYING.LIB
+++ b/COPYING.LIB
@@ -2,7 +2,7 @@
                        Version 2.1, February 1999
 
  Copyright (C) 1991, 1999 Free Software Foundation, Inc.
- 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -484,8 +484,7 @@ convey the exclusion of warranty; and each file should have at least the
     Lesser General Public License for more details.
 
     You should have received a copy of the GNU Lesser General Public
-    License along with this library; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+    License along with this library; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
-- 
2.50.0


