Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F8CC77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZF-0003yE-T6; Thu, 26 Jun 2025 01:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZD-0003xa-Tt
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZB-00018e-JZ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDWIHEiP1sQbutEa58hyRA2SGs1VabpAIbVg4iKjdI8=;
 b=goUdDitlCIwmOAe/E+TBOOd6QPTyTK8XB4XPJcIjJTjOVqHLIvN857Ces5AF3yNBp/rmQ7
 zcKMja0HHh3h3nSZcc6susmpHByGnef6QRZrHYNAKlVzgG58gXjhLT4h59MY254fJQ+Lxf
 OWv2MnGXPba7lRoPaekm/mzbTZP+JrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-0512HApkNc6k_iF6yPdgiA-1; Thu,
 26 Jun 2025 01:54:29 -0400
X-MC-Unique: 0512HApkNc6k_iF6yPdgiA-1
X-Mimecast-MFC-AGG-ID: 0512HApkNc6k_iF6yPdgiA_1750917269
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EBF718089B6; Thu, 26 Jun 2025 05:54:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCABE19560A3; Thu, 26 Jun 2025 05:54:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 11/19] include/libdecnumber: replace FSF postal address with
 licenses URL
Date: Thu, 26 Jun 2025 07:53:42 +0200
Message-ID: <20250626055350.218271-12-thuth@redhat.com>
In-Reply-To: <20250626055350.218271-1-thuth@redhat.com>
References: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Message-ID: <20250613.qemu.patch.04@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/libdecnumber/dconfig.h             | 5 ++---
 include/libdecnumber/decContext.h          | 5 ++---
 include/libdecnumber/decDPD.h              | 5 ++---
 include/libdecnumber/decNumber.h           | 5 ++---
 include/libdecnumber/decNumberLocal.h      | 5 ++---
 include/libdecnumber/dpd/decimal128.h      | 5 ++---
 include/libdecnumber/dpd/decimal128Local.h | 5 ++---
 include/libdecnumber/dpd/decimal32.h       | 5 ++---
 include/libdecnumber/dpd/decimal64.h       | 5 ++---
 9 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/include/libdecnumber/dconfig.h b/include/libdecnumber/dconfig.h
index 2bc0ba7f144..e67ecc1b5f6 100644
--- a/include/libdecnumber/dconfig.h
+++ b/include/libdecnumber/dconfig.h
@@ -23,9 +23,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 
 #if HOST_BIG_ENDIAN
diff --git a/include/libdecnumber/decContext.h b/include/libdecnumber/decContext.h
index cea6e4279ec..5bb64e13325 100644
--- a/include/libdecnumber/decContext.h
+++ b/include/libdecnumber/decContext.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal Context module header				      */
diff --git a/include/libdecnumber/decDPD.h b/include/libdecnumber/decDPD.h
index 26a21ec8ed9..8eb455277be 100644
--- a/include/libdecnumber/decDPD.h
+++ b/include/libdecnumber/decDPD.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------------ */
 /* Binary Coded Decimal and Densely Packed Decimal conversion lookup tables */
diff --git a/include/libdecnumber/decNumber.h b/include/libdecnumber/decNumber.h
index 41bc2a0d36f..bf37af83e6b 100644
--- a/include/libdecnumber/decNumber.h
+++ b/include/libdecnumber/decNumber.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal Number arithmetic module header			      */
diff --git a/include/libdecnumber/decNumberLocal.h b/include/libdecnumber/decNumberLocal.h
index 6198ca85930..0959f6606bb 100644
--- a/include/libdecnumber/decNumberLocal.h
+++ b/include/libdecnumber/decNumberLocal.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* decNumber package local type, tuning, and macro definitions	      */
diff --git a/include/libdecnumber/dpd/decimal128.h b/include/libdecnumber/dpd/decimal128.h
index aff261e5566..c57180baf8b 100644
--- a/include/libdecnumber/dpd/decimal128.h
+++ b/include/libdecnumber/dpd/decimal128.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal 128-bit format module header				      */
diff --git a/include/libdecnumber/dpd/decimal128Local.h b/include/libdecnumber/dpd/decimal128Local.h
index 97654277193..2948ab2534e 100644
--- a/include/libdecnumber/dpd/decimal128Local.h
+++ b/include/libdecnumber/dpd/decimal128Local.h
@@ -23,9 +23,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 #if !defined(DECIMAL128LOCAL)
 
diff --git a/include/libdecnumber/dpd/decimal32.h b/include/libdecnumber/dpd/decimal32.h
index 6cb9e436204..9a179334975 100644
--- a/include/libdecnumber/dpd/decimal32.h
+++ b/include/libdecnumber/dpd/decimal32.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal 32-bit format module header				      */
diff --git a/include/libdecnumber/dpd/decimal64.h b/include/libdecnumber/dpd/decimal64.h
index f29e57064d7..5c3d0bb43cf 100644
--- a/include/libdecnumber/dpd/decimal64.h
+++ b/include/libdecnumber/dpd/decimal64.h
@@ -24,9 +24,8 @@
    for more details.
 
    You should have received a copy of the GNU General Public License
-   along with GCC; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with GCC; see the file COPYING.  If not, see
+   <https://www.gnu.org/licenses/>.  */
 
 /* ------------------------------------------------------------------ */
 /* Decimal 64-bit format module header				      */
-- 
2.50.0


