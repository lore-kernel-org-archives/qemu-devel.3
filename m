Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A1606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=C7zq/Pn4;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=2Mq0ULAj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWXO-0006f6-Ks; Sun, 01 Nov 2026 09:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX7-0006aZ-AC
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:42 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX5-00083i-0K
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Z1alwFu
 ksQS8wW00vvKBJmXvnrqpJfpMA/UrTmQlhSBScxqGV+c2oKZ4YbLhW2sROG3sQDGDY6doz
 Aky4lyLhrXl+ZnndMLthXNhvYNU21dPFj2adKcdh46ulTA/vnY94Wrm/2NGekPdx+M5cIL
 svEhk7Izqk4AyG8QTNNahnGMwgN76PnaEkpGbRt7KW9nO0nY1aSo8nIn6cubVbAZbYikwt
 IQj54MabrjU7NI15dCcm9sYmsoUJa8P8+HP8RLVHDYPNwBJDAqAHWTX3+yPioZvAZO+FRG
 wAwHwMi0U3DRpS95fpJBhDuNX3cNhBfMoRQilJ/fb66FTPyn6v639kw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=o
 ZIhJ99tBnEm161PdQyhN93+GmDZtqEXkPIprVQL61k=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=XRfA9GWnIyQOQCBo+zP8KDBIAcPcbwkqDRLHtFXpBVFIn9Q5Dcwg+8ovxC6qicU7THit
 XuP47DRmcqF14w7bkX1j2QQXYPYI32uBwR9UbZv1TM0ntRYnHWNhc0aokJW+kxXFN/U2Xf
 ME7JDfg0414PnWzS+uK8ncalvvaw/SekIcKwOrhxOwL9QGgwblhuDzV4aYFODG54Za8xwi
 K1Jc6cMJwoWYRxbvZdcEAaXA00osiFRKiD1h7SeZEipdrWRdfx1oID92TKALvKqvO1W7Tl
 ga0my/sdHXCkZ4BXXjX+FpWhtYvWWX9NGtUL1njsKRc24N2/ftsBlsgRFmoY+/Cw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=C7zq/Pn4; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=2Mq0ULAj;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=oZIhJ99t
 BnEm161PdQyhN93+GmDZtqEXkPIprVQL61k=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=C7zq/Pn4z80/EE9GimqrsxvhXtoSu0HPqem
 LDBh5qD6NwgLhgxoZq4k05Jqr6IwKqO3rrFqYeGfnvfbM5A0rEjf5bgvQ7CSjNRnXMc8zg
 vkum0XoS1mhJXqxT074jj8I2LlM4hBJHn22ZlzufewkiXyt2aA19VDPAmQfuagH15qTmkN
 BaJHJMHcfZIft2ke6e0vGBTmAGV4xJYSzx54RXar5FjxeigZSt5J0T6d/1EEjaOhtEW8QB
 CoewFl9/mu9ZRclK9N4f2zxlOoRGLAJ1R4nheCeD7ONyIY8sfrGglMqg9olux1EkPIdg3J
 pFCWs6XmOXYBEwSofA17eCm1wog==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=oZIhJ99tBnEm161PdQyhN93+GmDZtqEXkPIprVQL61k=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=2Mq0ULAjx9nNmfoAUj
 396oID/8SqTdNQE38TpQT3JvDUGzgstC1x4CAA4d8SU5G9MSB0suKzEDLKUqGIIG/RAw==
Received: by mx1.catap.net (OpenSMTPD) id 77ae13d7;
 Sun, 1 Nov 2026 15:27:33 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 7b67073f;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 02/26] target/mips: fix MIPS64 segment access checks
Date: Sun,  1 Nov 2026 15:23:18 +0100
Message-ID: <20261101142723.41346-3-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

The xuseg and xsseg checks only tested UX and SX respectively; kernel
and supervisor accesses must instead use the mode bit that applies to
the current execution mode.

Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
allow kernel mode to use xsseg when KX is set.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/system/physaddr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 6f11e70ba8..69968022cd 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -144,7 +144,9 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
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
@@ -152,8 +154,8 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
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


