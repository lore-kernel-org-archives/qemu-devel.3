Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FE5C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7RU-0000X6-BD; Fri, 13 Jun 2025 12:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7RS-0000WM-Sd
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:39:46 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7RR-000680-51
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749832752;
 bh=w9Yu4hxd5YkZTczKQMfEZj+pbo8vVb2woEIq4gGi6j0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1Wof1JWRGWjAKc/k0msM7mx/gYCYnHzg4PId9jLI7kEaRmRBGdkD29mH5yeVaZZAX
 CaNyGBcJIE9ftbPg12dlFZjHoCQKXCMZRVMpzuvLtDr7Zqlce7EiOtSWD686ldT7iZ
 twe8JIY/sWhYoWAW2XzSW2CIqJAUQ0redAkIXikzyEoavjaj4PmT4PquxIALQYQsim
 kp3LhYlUW/WfuvTY5xf54uxuaRwCytI5buJtZCnhJvh8pMOlYiVG7t42FbyF2hXpKA
 7aqlUHVdYIOsjNV4n/znLsmvPcslnlNglD4sUjUlESdWsMHmApXSTgWTxvw8DzVlys
 OQezUDnJr+WuQ==
Received: from localhost.localdomain (unknown [72.14.99.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 0DD0354F1;
 Sat, 14 Jun 2025 00:39:08 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [PATCH 02/12] linux-headers: replace FSF postal address with licenses
 URL
Date: Fri, 13 Jun 2025 12:38:48 -0400
Message-ID: <20250613.qemu.patch.02@sean.taipei>
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

The GPLv2 boiler-plate in asm-arm/kvm.h and asm-powerpc/kvm.h still
contained the obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 linux-headers/asm-arm/kvm.h     | 4 ++--
 linux-headers/asm-powerpc/kvm.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 0db5644e27..a8bb1aa42a 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -13,8 +13,8 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ * along with this program; if not, see
+ * <https://www.gnu.org/licenses/>.
  */
 
 #ifndef __ARM_KVM_H__
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index eaeda00178..83faa7fae3 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -10,8 +10,8 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ * along with this program; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * Copyright IBM Corp. 2007
  *
-- 
2.49.0


