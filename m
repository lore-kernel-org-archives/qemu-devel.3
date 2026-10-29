Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEA606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=VoQJDyGK;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=95YKPLS4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU8d-0003Zy-Ef; Thu, 29 Oct 2026 13:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8Y-0003Yd-8L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:02 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8U-0003HB-89
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=o26LSxg
 vDTtBouwD4lBYO1+CDlyKOTLboEkqslumtE2hgg8IGKQ6w2G50EuYt+gj4EOxtdTmsErfM
 3VF0rt9ttny/JalS0ff1lcBURLNC9Sifmt/8A6tJRpR3O5v3sgbIe97m5C89zTgBJkf1cJ
 S7oagrlJ1XZjPZVC4AoUecMYkG0z6qjg37ufhQc9i4Dbf0KRQbLS9G8nBaT0N6r/ghGBfe
 AOdN1MBMKO9YApDSP4xuMPFu9UfmMbEe56DzQOZ6eBy80G7nVz0/DZKJfmSzwh4EqjeDg0
 IiCDAcJFRDKyTlqMM8ZZXuJ5Oh1P889ZuovbKpywN8WVqX3RYmDm26A==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=N
 so+m+B+gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=lnnE0psQA5To6D+/LLJsLIIZ0mXbGc4RLBXAj8ww95O4IeO21Pb+KiIjrRhbG4kCUG5M
 JgzBD+Nyfqv64W48MyIZxOAOovbSYaD5f5lcRwmHCbUueBP0cgZn5VEmODWGmHh5qH13GA
 Yi9WgSMNaZwJaQ/Y2Y2jCW1Ox3LnrpC1rdYX+72kLFdMji6wG01ml4QvQeSKNv4ajuoru8
 zxh+Vx75W13r5aGTxdrPFlnNehk+7P7ug+g0GNL01ZLPoivS46BizLITthnK3HYAKdpMVk
 sQgDxdSAYN9EoevTU8ewkAZyNKwc0yfCKjajqP04qu4yKbGh7DJXHr0y8W95OBag==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=VoQJDyGK; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=95YKPLS4;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Nso+m+B+
 gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=VoQJDyGKBsC9xv9hZppnFI4zF2uNbUHdS8P
 yVqDyxOQGhuYthUeWjVHvaBHB0VYWTEReUPY+bfo5zs7KiUvTtgeqZa3QWfGwDqrJS9G9P
 s++pPU6e0WnwMFOuxKpIpRXKGojCRMjcb4BW07o6fFV8/k1Hh24PAqBKt/+QYjr1IELLGF
 iqQaI2xdwcI4PvKlpBKR152ZwRyu8BX9lzD/NIUFOTFuUCQDzfvVygTdPILOTdC99NpHLd
 Fn8s9lYmHMbrsPmNhH4h37oVD+cP7EOoHLNOheUKr5pP8psQHssunHk26iFzFcD4JFFRss
 /1IGbagHsoz468+XvPC10JQl9mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Nso+m+B+gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=95YKPLS4zqHFos8Q7u
 i2g1IwQGA6e/GfJNCauJXbVc1S3CzppUF1Bgynidimyx0x9tTnQkDrCLOu/ffokYSPAg==
Received: by mx2.catap.net (OpenSMTPD) id 47e11d74;
 Thu, 29 Oct 2026 18:41:52 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 9062baa1;
 Thu, 29 Oct 2026 18:41:47 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 07/26] target/mips: accept Octeon PageMask encodings
Date: Thu, 29 Oct 2026 18:36:07 +0100
Message-ID: <20261029174139.44302-8-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174139.44302-1-kirill@korins.ky>
References: <20261029174139.44302-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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

Octeon firmware programs contiguous PageMask values that do not follow
the generic R4K even maskbits rule.

Keep the generic validation rule for other MIPS CPUs, while allowing
Octeon CPUs to use the contiguous masks accepted by hardware.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/system/cp0_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 3fc55314a8..9f7270d558 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -885,11 +885,17 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
 uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32(val, CP0PM_MASK, 16);
+    uint32_t mask = (env->insn_flags & INSN_OCTEON) ?
+                    val >> CP0PM_MASK : extract32(val, CP0PM_MASK, 16);
     int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero, and maskbits even. */
-    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+    /*
+     * Generic R4K PageMask values use two mask bits per size step.
+     * Octeon accepts contiguous byte masks such as 0x003fffff for
+     * two 2 MiB pages.
+     */
+    if ((mask & (mask + 1)) == 0 &&
+        ((env->insn_flags & INSN_OCTEON) || maskbits % 2 == 0)) {
         return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
-- 
2.56.0


