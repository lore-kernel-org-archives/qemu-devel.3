Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F74C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmwWs-0002lX-2u; Thu, 23 Jul 2026 12:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wmwWi-0002kR-RQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:44:05 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wmwWh-0005Bm-Eb
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:44:04 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a375ba035eso442345eaf.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784825039; x=1785429839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZkscVaxdQvVhxUJyZVSsi7S1C4lss52kon2LTZOK+hA=;
 b=YtoTy2eGweVIRI8alnZe6A0QLdmJTN7uDDMqC5G5Jq57Db8vJsGmG3qhVZmQEP1rh5
 EtbVIr64uJEqHjItZiF8pstepyCXURv12DCljJFybXKvmoOV08I02YPr5DrZmEBT4sqY
 oukJj3pTXRlf+JMMnyUswlhu8ghuDUzTb8ds9xCGeGRRnlKwuVidN66G2sENtJ1giErK
 UVv9g1+kubwlIpvwDav9F45FleCPd3NCnu8f/MHBcSAvSNnVmhJuXRBDIy6pR3VKbCYd
 jzAWFCxEWSGidCTnXMkhSJJgwFqa3Fo3vEYqeQQdQOHKx/hN/CBx9aSLqAkqIR1qOMXV
 37lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784825039; x=1785429839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZkscVaxdQvVhxUJyZVSsi7S1C4lss52kon2LTZOK+hA=;
 b=qpyMpFK/WQp+s3I1eEWNOXI7n1W13pFT+lgkhYgmWtfambEihIExFsMczCiP5z17Qd
 jZzAyVPxP1vUDWNkh+vYu8ul8q7KwPkDXUJr9L5ebg1zBe+AmEh5Rr8SZkN0zvYHA8U4
 eQW21P3u8lRn1giyOpeKt3b11hRzoOlUFxd0ikbKBDYZ2+zjCH0y+5cKIE3HZ+6vNWYz
 8pQm436nmGUWBuGeqUDGIYv2nvaFk5Da5OCoUo9RTvXrOcYsqmEbUGs7aYm2CWxoBOp8
 5b8dZUcVAcupgVs/ep4LWlf6i+rQjcLAFi640+p+xYdOVKiHsnVdqsJM0WEU2bUgVocg
 tj/g==
X-Gm-Message-State: AOJu0YwBxmWesKUz6Srlqu97uFHXZ9dGN7b2dN+CgkKSlp/k42aF+oDJ
 QoyKjVBIhT6Vz394eePvUk0r4eTn5pn7MFBhOO67E7vGrgel00q7YQqACbGDGXoW
X-Gm-Gg: AR+sD13jb1vehwlUQoE/Q0agEotr6w7jx40FE02fZDT6/xTPde/LF24vHM/7XUQvUsb
 qMM3NxN0g3U2rgexgP14UZdc+9jn0SsePmBXdh22fx9mL3zU4La+iOY+jwq3Ad2bHmxyCU9Qt1S
 3ZODmaGuZJslA3Ge+d8pljtpNArYO0FxEX6+E2uqZCKP3axXfqHkH0s+shzDOz7r8B0rCPmrAcW
 t3fn3dtqs7abGXTDTnYtvN1chkfkKB3P0LnsiKaoLeme+/+m+RDU8Eu4fHFhZIMXO2GAmGAwZ74
 wumPaEs/f7JgF9DBlG57crHXscsuPh2W4GclzM/k4SndQP1+NpY56/Sd3QROsYB9SU7gkuVvCEZ
 b88OdapsNkxCw1Kb+OJUBWy378ZbzyA0ReQkinvRJaIUyeiurNV+qZqm7pgulaCSLpi/4HzBkNz
 NTwfhW03sMI75g3FpqucjE2Q9JZJytXbuQrg==
X-Received: by 2002:a05:6820:1628:b0:6a3:c6f8:4ca4 with SMTP id
 006d021491bc7-6aad3f90df4mr1639787eaf.6.1784825039198; 
 Thu, 23 Jul 2026 09:43:59 -0700 (PDT)
Received: from HPE-2MQ6131DV6.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29db2830sm3884183a34.2.2026.07.23.09.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:43:58 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH] hw/misc/mps2-scc.c: fix scc_partno() and cfg7 write
Date: Thu, 23 Jul 2026 11:43:57 -0500
Message-Id: <20260723164357.1462-1-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Increase the extract32 length from 8 to 12. The Primary part number is
defined as bits[15:4] by the "SSE-310 with M85 and U55 FPGA"
documentation. For example for the mps3-an547, 0x547 is 12 bits but we
only return 8 bits right now.

Change the CFG7 write function to modify the correct variable.

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/misc/mps2-scc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 7877b31479..554b504c72 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -57,7 +57,7 @@ REG32(ID, 0xFFC)
 static int scc_partno(MPS2SCC *s)
 {
     /* Return the partno field of the SCC_ID (0x524, 0x511, etc) */
-    return extract32(s->id, 4, 8);
+    return extract32(s->id, 4, 12);
 }
 
 /* Is CFG_REG2 present? */
@@ -299,7 +299,7 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
             goto bad_offset;
         }
         /* AN536: Core 1 vector table base address */
-        s->cfg6 = value;
+        s->cfg7 = value;
         break;
     case A_CFGDATA_OUT:
         s->cfgdata_out = value;
-- 
2.34.1


