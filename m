Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC89C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZr-0004MQ-IU; Thu, 26 Jun 2025 01:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZZ-0004BL-Kk
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZX-0001Ac-PM
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aY3e4tmNQOvrCicbn7scvaRDyzRjkxhlz11A6mKFI+Q=;
 b=Qjsgx+tHw5ZY7D5jPyRB+wbBRgZuAOrkzIyfH/oXi1nnyzauPA3FVfdtdPd1wkB6KjzB61
 QlXymhTn0gp5uA8qgTccXep1iswe5wg7j/EnGe7t/cKJGlHPquiFckp94FScmGvVdDbF21
 zQEMDA2BAmNuu9QPfd7k+wgeOeItn74=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-xNBsYtbmNTqIvC7NF-0InA-1; Thu,
 26 Jun 2025 01:54:50 -0400
X-MC-Unique: xNBsYtbmNTqIvC7NF-0InA-1
X-Mimecast-MFC-AGG-ID: xNBsYtbmNTqIvC7NF-0InA_1750917289
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA24119560B5; Thu, 26 Jun 2025 05:54:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32DA219560A3; Thu, 26 Jun 2025 05:54:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Sean Wei <me@sean.taipei>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 18/19] target/xtensa: replace FSF postal address with licenses
 URL
Date: Thu, 26 Jun 2025 07:53:49 +0200
Message-ID: <20250626055350.218271-19-thuth@redhat.com>
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
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <20250613.qemu.patch.11@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/xtensa/core-dc232b/gdb-config.c.inc     | 5 ++---
 target/xtensa/core-dc232b/xtensa-modules.c.inc | 5 ++---
 target/xtensa/core-fsf/xtensa-modules.c.inc    | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/xtensa/core-dc232b/gdb-config.c.inc b/target/xtensa/core-dc232b/gdb-config.c.inc
index d87168628be..8c88caef59d 100644
--- a/target/xtensa/core-dc232b/gdb-config.c.inc
+++ b/target/xtensa/core-dc232b/gdb-config.c.inc
@@ -15,9 +15,8 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor,
-   Boston, MA 02110-1301, USA.  */
+   along with this program; if not, see
+   <https://www.gnu.org/licenses/>.  */
 
   XTREG(0,   0, 32, 4, 4, 0x0020, 0x0006, -2, 9, 0x0100, pc,
           0, 0, 0, 0, 0, 0)
diff --git a/target/xtensa/core-dc232b/xtensa-modules.c.inc b/target/xtensa/core-dc232b/xtensa-modules.c.inc
index 164df3b1a47..bb9ebd24b83 100644
--- a/target/xtensa/core-dc232b/xtensa-modules.c.inc
+++ b/target/xtensa/core-dc232b/xtensa-modules.c.inc
@@ -14,9 +14,8 @@
    General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with this program; if not, see
+   <https://www.gnu.org/licenses/>.  */
 
 #include "qemu/osdep.h"
 #include "xtensa-isa.h"
diff --git a/target/xtensa/core-fsf/xtensa-modules.c.inc b/target/xtensa/core-fsf/xtensa-modules.c.inc
index c32683ff77c..531f5e2b7e6 100644
--- a/target/xtensa/core-fsf/xtensa-modules.c.inc
+++ b/target/xtensa/core-fsf/xtensa-modules.c.inc
@@ -14,9 +14,8 @@
    General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with this program; if not, see
+   <https://www.gnu.org/licenses/>.  */
 
 #include "qemu/osdep.h"
 #include "xtensa-isa.h"
-- 
2.50.0


