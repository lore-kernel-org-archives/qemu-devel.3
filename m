Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9286AC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdU-0005Sn-0E; Tue, 15 Sep 2026 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdG-0005Ov-EQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:46 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdE-0003Ug-Mv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:46 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso487652f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492063; x=1790096863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RDP3r7WeFvBfusadg3H1XPE6z2aDMAqweiepZ0CeGqM=;
 b=Ij8bbaDxZ6Qm1WcEl2idR5mzwzgmEXsHEdTkTf53BX3SuZ23wQLI8WeUdCW6h7z3uP
 VUPemHH2d3TFumWcLZfnVV7cYJ+5bKE2B0UoRhyZnM8AldBWg8BqY/vvyZ4u6i1HgBwp
 4NhJy25uijQBFvI9YY1xqhOArFVZ3OHmMi809hu/bk6gtLwlpuTnQJo+Q4cH2WKNYmKF
 PIWOGAVn/l04BFCFw9Jb4pye3LymWcgEuMHxH/ZmWr5IapAhKdsCxPYVyZEUzFuOsD3H
 gT6HGiwYphoinQ/ieXD/tRnLdtiXTarqTCObsFHuXHn+X8mRGgR2F6zmCut7dmgWN4pS
 dllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492063; x=1790096863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RDP3r7WeFvBfusadg3H1XPE6z2aDMAqweiepZ0CeGqM=;
 b=fPa1HN1rdaMtvH7SWrdtkWiBsx4/T0VvR1DsZNz5IS0bjsVxnpguo8stEkg7s9sJOo
 QoqbUbX14tC90un7Lcix86LF6Qihtln3PAHnJm+gMAOG8vFL2E/5JOI6tYPKIp+79Mwz
 jE9Yc3eCateJD8HySktyvSCn6kV1PfjWzm4G7zr9N6yKSQxxUCk+1E1l9s4sY9BqQqRA
 9LUlTe/Dz4r1fSuDrsFRv0DcbQgcZ/KR/syXIBIoqHVlvloEt/dATIVTU6mWfW43Uw48
 fLvZvKPDDDfbs0xRVH2oNuJW9GKPe1HW5lk2EXDxpRGI7uUohLrzZ/hTvah0vDzXM/OL
 pV+w==
X-Gm-Message-State: AFuF++mbX4T6U5q+sRXGx923r+yqO324gso+D/njx4fLifI5xVGt6JLX
 iYlwZxyHlFHRDWSHPuZHv+fg7STaKp/SiI/7Ckg9bGANpFgnm4V8hdUAUJP8GF95lIPd1VwB8Fx
 augpc+Ts=
X-Gm-Gg: AYBFou3feAiCBXYcxdchF5ZLiWEUSA2gmRCeoYZzeZZdcF/ozxFoJL7AsldkcDoc3W3
 wSQg2ninCi3f19L5ubGh1a/Zlf/BhleOHMH05JEob2zoBeR3KI5E360V20PYSDb9CAWk4wrMQ8a
 sw+A7kVpvV+XXzUXDiE1esIl3qB1e9DDArRuY8QDiHYvpT/L5YANAE89Z875PQk9vJY/Kw0fj4Y
 GDrFit6M393mhlGYo7Mbs1FIwZ3tA4/iHrWlIHU1k4mEYxOi4lLiHe1uEAKM38Yi3HL7y6hxLn9
 6G1deXrNERVgA2Pz0F1QfjM2P016mDAOS7KEyckwD/aQxUfkKnGkABuwH/AigtFQF/3eOcv0OtP
 9FhsudGeFz6CbofZTAxmohwHy4ATKZ60F16t3FaVyNDKDV+CyCiAaEn5G1Q9gI0PK7qTGv/3kPd
 ra2lXVe59ew713QvMH9TBorP8flf+A53BEVjT3yVB9ED4cNz63YAS/e3lrfgnmadI6LUPwI0MOP
 nnLvjE2i7whWAIdM5odqXKKIW8f4ojPK9LL0SlQxOyetepPrsVaFpVt8ovw61XWV2OxC3TDAjea
 9koX
X-Received: by 2002:a5d:5f87:0:b0:486:e949:532c with SMTP id
 ffacd0b85a97d-4870a9dd24cmr2098228f8f.43.1789492063298; 
 Tue, 15 Sep 2026 10:07:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] sbsa-gwdt: reduce code indent
Date: Tue, 15 Sep 2026 18:07:20 +0100
Message-ID: <20260915170735.425445-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260902122646.2848464-2-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 330a74798a2..7cc5609b83f 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -105,25 +105,27 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
 
     timer_del(s->timer);
 
-    if (s->wcs & SBSA_GWDT_WCS_EN) {
-        /*
-         * Extract the upper 16 bits from woru & 32 bits from worl
-         * registers to construct the 48 bit offset value
-         */
-        timeout = s->woru;
-        timeout <<= 32;
-        timeout |= s->worl;
-        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
-        timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
-                (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
-            /* store the current timeout value into compare registers */
-            s->wcvu = timeout >> 32;
-            s->wcvl = timeout;
-        }
-        timer_mod(s->timer, timeout);
+    if (!(s->wcs & SBSA_GWDT_WCS_EN)) {
+        return;
     }
+
+    /*
+     * Extract the upper 16 bits from woru & 32 bits from worl
+     * registers to construct the 48 bit offset value
+     */
+    timeout = s->woru;
+    timeout <<= 32;
+    timeout |= s->worl;
+    timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
+    timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
+            (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
+        /* store the current timeout value into compare registers */
+        s->wcvu = timeout >> 32;
+        s->wcvl = timeout;
+    }
+    timer_mod(s->timer, timeout);
 }
 
 static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
-- 
2.43.0


