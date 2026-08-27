Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336F7C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcFV-0006Id-PQ; Thu, 27 Aug 2026 11:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFT-0006HY-Mc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:39 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFR-00019R-UL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=FmkDJCO
 jCreomgjEBvgcmCIdxqZjt3ix6yrwzUAGq8UIMODmyIvEbhZWb6ZYYsblClbnp4dC8Icwu
 PNFFM6P0YmI+oZczh0n2Z4SPtoKseDoG4zqXGzJhGlRdAj4pYPxz7Kv33UqqW27XB6MfkU
 KKl1nUNz1nNSr8NdWDschGovpzhdpYUz8HqIWf+qcXtrLbIYMYFHQ6ljnd3xpXkyZ3r6vU
 ckNE2FOC0vyVIN/dazyO1mtS7Ln/fJPDXly+qDpB3jJKKKxfEXJ3YpS+Iw0FrDMszjWayI
 EN/8Wbod7RdTNHGhDB3r6iPPneQNmPPmTos1u0IS94ijUjRuZgA9Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=k
 oHFNGi4Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=IRqt/tgbBStPP42QtReprU0wvL34SqEtizTqVwCSbSAdBKcKd/lk6We3rKq6MeZe9i6o
 49kbJAvsIWFbPYTfzSW18+RkTKjLk9AffSK89pzqOotince31IMQDdem9eNtj3n7c4Zq6h
 rzghkCIYxVjv5bOA7AjcflrJNiI4shYdJW/iJJFrSmWPi2OlZ/bDjaA5sTZfoD5VQEQzUE
 OOLOTV63Hy1/ejy6mobfkCCr9PSU4s/km4eegOaKzD5XP9f57ldOcjqZ7AdhfUUCUJuezO
 drLKuYAHrtRMBJQesQWUbW5z0xAu+fmtYRI9S5p5HEY5Juqy1FrBun52DCdShcNg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=moP4t6VS; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=fRxt189Q;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=koHFNGi4
 Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=moP4t6VS4cBMqrIKfxbm2XH49+BPjKTMSV/
 JpXVwjc+4Z98Zo8WzpXKSgeh/4V6X0a+u4zmY4Blh29Whuj+KFxUynSzedIa46ZDrtS6gJ
 otBiYGjzKDbX9s10sqeHTNbOlX3lVPsvN4kdl3Dx5AYXAOShFn3iTD9/FetgaMI7W0wQtS
 vPDl6AZEMQbBV0H7N+a8tS7oxNWHRqWwg/ZL0Vuqr7OE5USqVxF/lVj6Zz8OJe8ZvuPpLT
 QIQrS3ftx0QHDEkifJQF7ff8JYZi/Hl3aYpk8RN49T0HKc2TBj7wiLEda/D8QrlaabkIjK
 h8y3AccatbItMg0UU6mARhWXxeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=koHFNGi4Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=fRxt189QLy/OZMnToR
 9RdyWwSteHfqp5c/PY9dYoczqgYCiwm/IR1u1r2ioQDEak+Zn0wTkdDNsuxFvRyuYjBw==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id a418d2a4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:42:33 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id d6a2e407;
 Thu, 27 Aug 2026 17:42:32 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 3/5] cuda: Include command in successful ADB replies
Date: Thu, 27 Aug 2026 17:41:15 +0200
Message-ID: <20260827154220.84845-4-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827154220.84845-1-kirill@korins.ky>
References: <20260827154220.84845-1-kirill@korins.ky>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

OpenBSD and Linux expect the ADB command between the CUDA status and
reply data. QEMU omits it on success, so guests consume the first data
byte as the command and lose it from the reply.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/misc/macio/cuda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 312dde242b..ccb3e1d74b 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -431,11 +431,12 @@ static void cuda_receive_packet_from_host(CUDAState *s,
         {
             uint8_t obuf[ADB_MAX_OUT_LEN + 3];
             int olen;
-            olen = adb_request(&s->adb_bus, obuf + 2, data + 1, len - 1);
+            olen = adb_request(&s->adb_bus, obuf + 3, data + 1, len - 1);
             if (olen > 0) {
                 obuf[0] = ADB_PACKET;
                 obuf[1] = 0x00;
-                cuda_send_packet_to_host(s, obuf, olen + 2);
+                obuf[2] = data[1];
+                cuda_send_packet_to_host(s, obuf, olen + 3);
             } else {
                 /* error */
                 obuf[0] = ADB_PACKET;
-- 
2.55.0


