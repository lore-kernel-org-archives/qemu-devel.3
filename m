Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A05C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 06:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZE-0003xt-NE; Thu, 26 Jun 2025 01:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZA-0003wq-9S
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZ8-00018G-KI
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7osfbKkBSE9Tfbt17TtAApj5p+1C6n2XEcC60fhTwU=;
 b=gJF483W6e2Ny7E3IoC8JZWb9M68ysxRy1vPP7piB9jTs6s4VTAkT3lfVlFSGKz+C1EPRBT
 xTG7yiAm+OYudKay4lhJoN/rmjfkBBFrWnBk5vlMQKZ6YBfG916a5gYru0QURmrH3iI2/z
 91iP4KO/Hv5qCG0jDOq27FJvB2b9rcU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-Xe5IP6cqP6iGkT01D-oClA-1; Thu,
 26 Jun 2025 01:54:27 -0400
X-MC-Unique: Xe5IP6cqP6iGkT01D-oClA-1
X-Mimecast-MFC-AGG-ID: Xe5IP6cqP6iGkT01D-oClA_1750917266
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40D0519560A3; Thu, 26 Jun 2025 05:54:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B0FC19560AF; Thu, 26 Jun 2025 05:54:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 10/19] libdecnumber: replace FSF postal address with licenses
 URL
Date: Thu, 26 Jun 2025 07:53:41 +0200
Message-ID: <20250626055350.218271-11-thuth@redhat.com>
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

Some of the GPLv2 boiler-plate still contained the
obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250613.qemu.patch.03@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 libdecnumber/decContext.c     | 5 ++---
 libdecnumber/decNumber.c      | 5 ++---
 libdecnumber/dpd/decimal128.c | 5 ++---
 libdecnumber/dpd/decimal32.c  | 5 ++---
 libdecnumber/dpd/decimal64.c  | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/libdecnumber/decContext.c b/libdecnumber/decContext.c
index 1956edf0a7a..d99b08026c2 100644
--- a/libdecnumber/decContext.c
+++ b/libdecnumber/decContext.c
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal Context module					      */
diff --git a/libdecnumber/decNumber.c b/libdecnumber/decNumber.c
index 31282adafdc..4b57d8a6fe2 100644
--- a/libdecnumber/decNumber.c
+++ b/libdecnumber/decNumber.c
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal Number arithmetic module				      */
diff --git a/libdecnumber/dpd/decimal128.c b/libdecnumber/dpd/decimal128.c
index ca4764e5471..1064fb25e01 100644
--- a/libdecnumber/dpd/decimal128.c
+++ b/libdecnumber/dpd/decimal128.c
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal 128-bit format module				      */
diff --git a/libdecnumber/dpd/decimal32.c b/libdecnumber/dpd/decimal32.c
index 53f29789d75..34ff0fe9599 100644
--- a/libdecnumber/dpd/decimal32.c
+++ b/libdecnumber/dpd/decimal32.c
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal 32-bit format module					      */
diff --git a/libdecnumber/dpd/decimal64.c b/libdecnumber/dpd/decimal64.c
index 290dbe81771..11e0674fa7c 100644
--- a/libdecnumber/dpd/decimal64.c
+++ b/libdecnumber/dpd/decimal64.c
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal 64-bit format module					      */
-- 
2.50.0


