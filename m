Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84D606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=LIg09aPE;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=3hu4jsGp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRz9f-00084o-L4; Fri, 13 Nov 2026 16:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9a-00081V-7X
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:50 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9Y-0005Cz-EQ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=BeJWwNb
 AVUXS72yGrvbWttJUQ9ir4KZvz2nmUhu0X//O5UIYhi0IwNmHxpWbhNfi93fBfBCEb10u/
 F+3Ad2O6vXl6p4O9mC4GP26t0SaNGkq2mx/aTAKNczQQfGJYi9f1glmF2aak+OzMddTh2U
 eVFDkWAko+oja7rQMwN43ZgYYXpEDHJCdnnuhB0voHaHn8s8kOkJxhYpfo+eQ8KXl9j8cj
 gHJqh7+OZQGHUEFND8+sPM9mNGguskOCKSYerxsStpheYbtZ/ZtYqh+o5ul5kCoK2yiHkD
 q5Sofn1SzpvKHi3RDUwf8memNjxMCzFzQvrKLBE224pVsNqbck6+Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=i
 p+05HQUtpyNAF9Y8Zc9TEjOA31v/XNdzRO8hUjPYzU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=zBhDmlBRymzrXl2K9hb3bEm0lNw8SBSQDEnBIsFDLot7XxmzEdCYksVnvFIWZby+0UgR
 DZKPTbSrAzDL0Z5vOCHuXOmo7t3p7ESDkjL6gXqpXSYb7u6BBooF4SE9QIkfrhw2rMTAQ1
 Rzn4VwlR1ioLtQ734hDnJa/91kh/yAhkW5CYS4sG2n9hUjeZMu0XdKhs2q27XnJVSyYc5D
 1yeUuHh9hdB6P4WOvYUIaQpM+Kdi4IXyvqeapl6TK5Svpw39K1V5JQgzShSvYkn1omJHxo
 VLUNSOuVQIOqVleuUZKqa4IM48GbLOsbYmePTNEDDuExS+pGOgQBF8N/o6/BKgEQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=LIg09aPE; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=3hu4jsGp;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ip+05HQU
 tpyNAF9Y8Zc9TEjOA31v/XNdzRO8hUjPYzU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=LIg09aPEbp0Mdjt7zAX/5VrhuxeZQbK/uCM
 zW0TyoLxqSdeUFYNjyy/H7Ipv3qWcGZaCKRjHMHoO32WiAckNs4pFV2hLnZYY4uwhPEwuF
 kezE8tFTj7aH/XK0KaRjsMSm7itsx9y05sFgU03uk/7CfdX+Of+pD9sHUkWwvMyAR8f/Eb
 t4sIKbWoHPBnvKCgAn/sTFCcpmwPfneRI6Q+nGatWXK9lM41roIvEn08p3WFWa3YH8AoVS
 30g0d4YT73pcp5dgdQ+nSS3tELKqHrIrlJU2JUylCssf3z6gx7nGtyNr8hsSXP+wzKAoYW
 NhGOtCw5/DzDKwBkOzGuOrC+tgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ip+05HQUtpyNAF9Y8Zc9TEjOA31v/XNdzRO8hUjPYzU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=3hu4jsGpDv4aSK+qhO
 1gO9WYXKo9pJAFLW6MQ3YxZQfHa0Q+OKoEhE0S7EwTUtJk5qY9qwQPL0VtDHwB+TF1Aw==
Received: by mx1.catap.net (OpenSMTPD) id 0977b18f;
 Fri, 13 Nov 2026 22:49:45 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id cbcdd08e;
 Fri, 13 Nov 2026 22:49:32 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v8 02/26] target/mips: fix MIPS64 segment access checks
Date: Fri, 13 Nov 2026 22:45:16 +0100
Message-ID: <20261113214926.98536-3-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

The xuseg and xsseg checks only tested UX and SX respectively; kernel
and supervisor accesses must instead use the mode bit that applies to
the current execution mode.

Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
allow kernel mode to use xsseg when KX is set.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/system/physaddr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 523197f020..b9f44c27bc 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -145,7 +145,9 @@ int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
 #if defined(TARGET_MIPS64)
     } else if (address < 0x4000000000000000ULL) {
         /* xuseg */
-        if (UX && address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
+        if (((user_mode && UX) || (supervisor_mode && SX) ||
+             (kernel_mode && KX)) &&
+            address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
             ret = env->tlb->map_address(env, physical, prot,
                                         real_address, access_type);
         } else {
@@ -153,8 +155,8 @@ int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
         }
     } else if (address < 0x8000000000000000ULL) {
         /* xsseg */
-        if ((supervisor_mode || kernel_mode) &&
-            SX && address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
+        if (((supervisor_mode && SX) || (kernel_mode && KX)) &&
+            address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
             ret = env->tlb->map_address(env, physical, prot,
                                         real_address, access_type);
         } else {
-- 
2.56.0


