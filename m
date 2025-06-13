Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110DFC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7WG-0002sg-IF; Fri, 13 Jun 2025 12:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7WA-0002s7-7i
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:44:38 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7W7-0006cY-2t
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:44:37 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 6BE7F54F1
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833042;
 cv=none;
 b=th9Ddb3Tsis9sbgzQjpYl39oh12Iyu/s+lZ521FmQOrJYBfBVUNW8oDpTMHzWEjt2i18uPuzxN36o0485qYmCD0NycvTbDw3xPJIUU32XeIGObLbXWW/op6XyUmG+lo89jYfaY79ntbqPVBz3Ie/K3kooJmnyEIYwrd331o6qsKXxZXMzUhBNGOS1HBBCnj2C7I6fpgq0EyFFLcLhHxu5sNGVH3zNdVxgt1NM3u/uwNq42MM/kt1uxoXQLRbrJDd6hfX9WNhuSz77G/wcW8GbLrjezN04Kvl5GNqMtbJMIScxqqfWkAIozwm/2EWc7cOfMDTuLTBQtYHH5hA8BgQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833042; c=relaxed/simple;
 bh=eB5EC681F6G6rO8/wSr9Ao3tgUW4PfxwbevEOju4O3g=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=DMI06JOuxnl/GtTU4pVIomLio8ddvt4eZKwOJoQHkw2C0wHXuXgTwyCFd5St4H30nscJXqNdKSzu/w9ru0vd5mFAAvK2AIRRKEWuyxTQafYkvi+UR/0mUAyNJf6JGZmclIYDpYKREGWI4zpMoUDLzdynXXRoPOYLsjocsFHHZ+I/Cae9jqqRMoSArjefd6ctuGEs+2S/htQ1vWbnjgxyZcX6r7xJYAeUVxvenLMnyPMxxeYSUZ6jG3hCY2W3GV2kMwj1GNekD+qRdS3Kdy0EhICWRq523CBAQ3w5wTl4+zXKnVGff8fj8spkGgTFENledhpsnUO0dowqfCfyl89UpA==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833041;
 bh=eB5EC681F6G6rO8/wSr9Ao3tgUW4PfxwbevEOju4O3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tJ4MWQLV1NEqJCNCml7+rRfLd0ouRvu34RcsvkFPsMIXxP3lAFZj9yZUEV4yfsSTz
 CMiKkA17RTP+C4MW5GV8wLqNMBNCYYPNBbqqLDoKn68eTuctcW4ZoU9haEmjeLXzUo
 qggwh3DDXVypIsqzZC+L9VoUuQ+W3tGuVhgmU5zQXyOVGYnspe8NWuXyjWRjC/lqw+
 jbLFUQDnTE/gkPW2DPqrMD3dEUDvyAXr4u43b8lKhK+a2TB4CMZaZo1DZO+v5Vla4C
 RAWXGbznk0Q69mDPPCgWPcJq0i+mazAqwIrlLofadsgLf44oXV8lKA48oOF2pwOHXK
 NGjpuIv/tHBdA==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 6BE7F54F1;
 Sat, 14 Jun 2025 00:44:00 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>
Subject: [PATCH 04/12] include/libdecnumber: replace FSF postal address with
 licenses URL
Date: Fri, 13 Jun 2025 12:43:40 -0400
Message-ID: <20250613.qemu.patch.04@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.patch@sean.taipei>
References: <20250613.qemu.patch@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
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
index 2bc0ba7f14..e67ecc1b5f 100644
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
index cea6e4279e..5bb64e1332 100644
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
index 26a21ec8ed..8eb455277b 100644
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
index 41bc2a0d36..bf37af83e6 100644
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
index 6198ca8593..0959f6606b 100644
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
index aff261e556..c57180baf8 100644
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
index 9765427719..2948ab2534 100644
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
index 6cb9e43620..9a17933497 100644
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
index f29e57064d..5c3d0bb43c 100644
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
2.49.0


