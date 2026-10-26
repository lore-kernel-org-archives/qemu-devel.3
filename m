Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E1606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLAfc-0006bo-Px; Sun, 25 Oct 2026 22:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfY-0006bD-Mc; Sun, 25 Oct 2026 22:42:40 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfW-0002O0-BT; Sun, 25 Oct 2026 22:42:40 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jCdFg0tqyz5BNRf;
 Mon, 26 Oct 2026 10:42:31 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 69Q2gNgV086522;
 Mon, 26 Oct 2026 10:42:23 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Mon, 26 Oct 2026 10:42:24 +0800
X-Zmail-TransId: 3e816adebe0f027-00c97
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
Subject: [PATCH v5 3/4] include/qemu/bitops: Move BITS_TO_U64S to bitops.h
Date: Mon, 26 Oct 2026 10:40:42 +0800
Message-ID: <20261026024048.630015-4-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69Q2gNgV086522
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 26 Oct 2026 10:42:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADEBE17.000/4jCdFg0tqyz5BNRf
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BITS_TO_U64S was a private macro in migration/vmstate-types.c,
defining the number of 64-bit words used on the wire for bitmaps.
Move it to include/qemu/bitops.h alongside the existing
BITS_TO_U32S so it can be shared with other code.

While moving it, express the divisor with sizeof(uint64_t) instead
of the hardcoded 64, keeping it consistent with BITS_TO_U32S. This
is semantically equivalent.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 include/qemu/bitops.h     | 1 +
 migration/vmstate-types.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index f7363a5479..383648fe59 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -20,6 +20,7 @@
 #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint32_t))
+#define BITS_TO_U64S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint64_t))
 
 #define BIT(nr)                 (1UL << (nr))
 #define BIT_ULL(nr)             (1ULL << (nr))
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index c2d4645f31..8094d76f1b 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -16,6 +16,7 @@
 #include "migration.h"
 #include "migration/vmstate.h"
 #include "migration/client-options.h"
+#include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "trace.h"
@@ -596,8 +597,6 @@ const VMStateInfo vmstate_info_tmp = {
  * bit words with the bits in big endian order. The in-memory format
  * is an array of 'unsigned long', which may be either 32 or 64 bits.
  */
-/* This is the number of 64 bit words sent over the wire */
-#define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
 static bool load_bitmap(QEMUFile *f, void *pv, size_t size,
                         const VMStateField *field, Error **errp)
 {
-- 
2.27.0


