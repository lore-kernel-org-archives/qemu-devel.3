Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4410EC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7Sd-00015z-Ql; Fri, 13 Jun 2025 12:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7SV-00013h-5o
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:40:52 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7SS-0006Pi-02
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749832814;
 bh=lUjfuc/9B+wPnHu6dX37QdPQnF3KkhNmDPto/YmnO7o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d53Z4H+i/NPROsIcHyRC+9WjHaK3EhYmn41GbDd/H/XT9e2uZuhRwIAr9h2djKLVn
 4rMtOT6cqLFgX7TiCjZQu5C15mGty9PFlhAhrSrMESZvnaUibrsaf1rgQ0aOnCRdtv
 w8gpcYnrg6zSHEY+LRsyUMQpdKpFqkBZAdHdRPnrQJg6LnUorq70MlXJEmqPegmFlN
 W07cty6dwtQPHHYOtjx4MtFAbt9OOmw64vCr36trhbbA2+I/5zrxZMkk+k0rBoSwmB
 zbdTp2CDvkoaN/ulcWoIO+M55Z91uoNCOtDsnlZ8xOQ4q8N9ERhmfFETx0zToDI0Dy
 NdA5elmjy1mag==
Received: from localhost.localdomain (unknown [72.14.99.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 37B385522;
 Sat, 14 Jun 2025 00:40:12 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>
Subject: [PATCH 03/12] libdecnumber: replace FSF postal address with licenses
 URL
Date: Fri, 13 Jun 2025 12:39:50 -0400
Message-ID: <20250613.qemu.patch.03@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.patch@sean.taipei>
References: <20250613.qemu.patch@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some of the GPLv2 boiler-plate still contained the
obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 libdecnumber/decContext.c     | 5 ++---
 libdecnumber/decNumber.c      | 5 ++---
 libdecnumber/dpd/decimal128.c | 5 ++---
 libdecnumber/dpd/decimal32.c  | 5 ++---
 libdecnumber/dpd/decimal64.c  | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/libdecnumber/decContext.c b/libdecnumber/decContext.c
index 1956edf0a7..d99b08026c 100644
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
index 31282adafd..4b57d8a6fe 100644
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
index ca4764e547..1064fb25e0 100644
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
index 53f29789d7..34ff0fe959 100644
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
index 290dbe8177..11e0674fa7 100644
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
2.49.0


