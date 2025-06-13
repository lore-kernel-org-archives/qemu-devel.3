Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A72C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7YF-0004Gb-Sl; Fri, 13 Jun 2025 12:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7YD-0004ED-4N
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:46:45 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7YB-00070J-AC
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:46:44 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei B106E5601
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833200;
 cv=none;
 b=E0bUuLcp8vnYrufHd6ht7ib7LfM0a9nWAjtq/bGWp7JgyoDlygdsOt4icxD9F1XCvtMPmN51VgMCSIp9o/al5aiAmXTQ5+fHazBHCHVmfEjWu2JJSPPBEEqky0RpXTtmnHOBKc7XTlZnC0pX8CT2RqWzl196wry01RKxnOifDnvz/5aTe5dz4Vl4n6s6bi6sGCI9j3gUUEoc3hL9OnluP2HCJq5V+G9YoImrpYUKbvu93c59BXVi92ZKUr6iZhsxSA8OtIlYxVviI3Tfg4d6UzRABXhXRJ88oRbwHPlRsGMuRzg/QIgSQr/RAj4BNsrypUD5dDXMoZP5SEDl+AApdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833200; c=relaxed/simple;
 bh=ZuGg3bOlRrFTlg+eL0U+GO2hNi0CxeaZIo7H8YYO2WQ=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=bpVOc9vM4zQ2E8yeLXzCrFQ9TwBbaU44tT/mANiIGdBF6CMoDkT2s5NiheDeqjp2BjBgbaW0K0+L1HgRTCV2FxdQ1MWKgWi+xFplrL6QAVPgq6FnqGHbo9Oq3vub2zuHHZPdaGjDZ09BARhm0UWKWmssKHEfws/swMhw7pYwpPYhfEUVQ41MD3EpouX0FzHNvuJVNO16E7kCQ3cV2fa3INR5jQ5YFD8MyesPBSJ9NcrajmPtT+HBKmL4osIxlpoR1ka9W2tz3N0ztW7U9uObabsV2wVKoJhx/mkcMHm/ELdylmqCtjVkQiVvsgeq+sMZr4roEtYPfjWUmRKJ01E/Ww==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833200;
 bh=ZuGg3bOlRrFTlg+eL0U+GO2hNi0CxeaZIo7H8YYO2WQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SLnuLlV1uoWnfNQNbGl0DkEWz1QiyA6CxbwQighs7Oz7+3Rw/3x8f4izm6/VH1VoU
 197uhaiCwVCzaoOlzkDgAl/JwtxT3WD+988VGTOQI263svMYlAxx07HOJ9rflcI4ai
 Xsayaad27erQort13WPJe66SYOeO6nqK0KH7Af4aGULaeL3CbyNE9LDQYUymj7oBob
 eEQNSVKTmYXMjyViPhV16sKuRarsYld4Z6qEw2bpwycNQFSvfuoRZD0lzrhD/CeFh/
 sX0z5AfNDYIAYzD4A5pt3H6nz2SxTPjDDT/va+KUoOI9nknn+AMDgRW3OrwPaY9dZ9
 MMWhM7NTi4WAw==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id B106E5601;
 Sat, 14 Jun 2025 00:46:38 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/12] include/qemu: replace FSF postal address with licenses
 URL
Date: Fri, 13 Jun 2025 12:46:15 -0400
Message-ID: <20250613.qemu.patch.06@sean.taipei>
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

The LGPLv2.1 boiler-plate in rcu.h and rcu_queue.h still
contained the obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 include/qemu/rcu.h       | 4 ++--
 include/qemu/rcu_queue.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index fea058aa9f..020dbe4d8b 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -17,8 +17,8 @@
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * License along with this library; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * IBM's contributions to this file may be relicensed under LGPLv2 or later.
  */
diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index 4e6298d473..bfd5900fda 100644
--- a/include/qemu/rcu_queue.h
+++ b/include/qemu/rcu_queue.h
@@ -17,8 +17,8 @@
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * License along with this library; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * Copyright (c) 2013 Mike D. Day, IBM Corporation.
  *
-- 
2.49.0


