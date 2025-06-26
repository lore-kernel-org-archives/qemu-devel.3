Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C9C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZl-0004L0-Sr; Thu, 26 Jun 2025 01:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZe-0004Gp-DT
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfZb-0001BA-MG
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epuSDnWoSk8fD/KDoEX7wu0ZNgpfY4ZXzswkXMB+aMc=;
 b=IeEJ7UOfoV5qUlfEphjjVqkVv67Ku8YStZuWcjjHJccr7rsr+4ur1Y69nesX8TCG2hsl5U
 aS/1PtOB8cxP5Xgkm+RU4G/tEXPo0d1G/EaOt8wjtHRTmELD5OfgRec60lHm+c/kshCS2J
 wXVDmKjK3v1HSzz33wYmPCZf3uuICxY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-vWqoZKfVMNWGu5x8laeHTQ-1; Thu,
 26 Jun 2025 01:54:53 -0400
X-MC-Unique: vWqoZKfVMNWGu5x8laeHTQ-1
X-Mimecast-MFC-AGG-ID: vWqoZKfVMNWGu5x8laeHTQ_1750917293
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D76071956094; Thu, 26 Jun 2025 05:54:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC30219560A3; Thu, 26 Jun 2025 05:54:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Sean Wei <me@sean.taipei>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PULL 19/19] target/i386/emulate: replace FSF postal address with
 licenses URL
Date: Thu, 26 Jun 2025 07:53:50 +0200
Message-ID: <20250626055350.218271-20-thuth@redhat.com>
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

Some of the LGPLv2.1 boiler-plate still contained the
obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250613.qemu.patch.12@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/emulate/x86_flags.h | 4 ++--
 target/i386/emulate/x86_emu.c   | 4 ++--
 target/i386/emulate/x86_flags.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
index 28b008e5771..a395c837a0e 100644
--- a/target/i386/emulate/x86_flags.h
+++ b/target/i386/emulate/x86_flags.h
@@ -14,8 +14,8 @@
 //  Lesser General Public License for more details.
 //
 //  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+//  License along with this library; if not, see
+//  <https://www.gnu.org/licenses/>.
 /////////////////////////////////////////////////////////////////////////
 /*
  * x86 eflags functions
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 4890e0a4e5e..db7a7f7437d 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -31,8 +31,8 @@
 //  Lesser General Public License for more details.
 //
 //  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+//  License along with this library; if not, see
+//  <https://www.gnu.org/licenses/>.
 /////////////////////////////////////////////////////////////////////////
 
 #include "qemu/osdep.h"
diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index cc138c77494..6592193b5e0 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -14,8 +14,8 @@
 //  Lesser General Public License for more details.
 //
 //  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+//  License along with this library; if not, see
+//  <https://www.gnu.org/licenses/>.
 /////////////////////////////////////////////////////////////////////////
 /*
  * flags functions
-- 
2.50.0


