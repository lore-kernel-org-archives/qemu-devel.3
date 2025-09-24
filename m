Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7228CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 05:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Htf-0004hV-4H; Wed, 24 Sep 2025 01:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1v1Htc-0004gl-Rs
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 01:18:28 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1v1HtY-0002rG-N8
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 01:18:28 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cWlVV1GCfz5PM3K;
 Wed, 24 Sep 2025 13:18:10 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl2.zte.com.cn with SMTP id 58O5I2rP027082;
 Wed, 24 Sep 2025 13:18:02 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Wed, 24 Sep 2025 13:18:03 +0800 (CST)
Date: Wed, 24 Sep 2025 13:18:03 +0800 (CST)
X-Zmail-TransId: 2afb68d37f0b0b0-4ec0b
X-Mailer: Zmail v1.0
Message-ID: <20250924131803656Yqt9ZJKfevWkInaGppFdE@zte.com.cn>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <richard.henderson@linaro.org>, <pbonzini@redhat.com>, <david@redhat.com>, 
 <peter.maydell@linaro.org>, <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSBxZW11L29zZGVwOiBhbGlnbiBtZW1vcnkgYWxsb2NhdGlvbnMgdG8gMk0gb24gUklTQy1W?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 58O5I2rP027082
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 24 Sep 2025 13:18:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D37F12.000/4cWlVV1GCfz5PM3K
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Similar to other architectures (e.g., x86_64, aarch64), utilizing THP on RISC-V
KVM requires 2MiB-aligned memory blocks.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1b38cb7e45..6de6c0c4e5 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -561,7 +561,7 @@ int madvise(char *, size_t, int);

 #if defined(__linux__) && \
     (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
-     || defined(__powerpc64__))
+     || defined(__powerpc64__) || defined(__riscv))
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
       Valgrind does not support alignments larger than 1 MiB,
       therefore we need special code which handles running on Valgrind. */
-- 
2.27.0

