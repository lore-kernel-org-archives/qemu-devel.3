Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385A4E63F19
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEQ-0005Yr-G2; Sun, 15 Feb 2026 17:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEK-0005XR-Ib
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:41 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEI-00053L-Be
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:39 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45ee8823e2aso1569988b6e.0
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193077; x=1771797877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPGnHVzXgj2fdKy4LYV1thowyCOxSvdIUm2/cRgvu/o=;
 b=FgIf4sGyQT1LxCydcIBQU4DnqA9cvYbonD1hxrX80kkibSlsDwcB55ZD+v+9Z20ZcS
 fhqZQu7Rs1QIghUP34MrFldJ/lYlMAf9n9UIEpbSJm5P/ukIhgydr18QkXdHGS71DY0z
 fKvDGBRMywTb6qDbURvqGNpDzILhZPPzb0rdVh7AEsFwnbCaMLdkcnar324Y6N+ZQcw6
 A+H3MNGLTiO88Csdv/nP835kull6Likru+vXxztE86Zc0pkevxKDVAG0ofbIX+iFipxP
 lBxhH6qLSfpQy+bsl6ajgiewPQHpQw0CJzcH0r1xqA9YvK304ot6UmxnMwdQXor0H9GT
 n1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193077; x=1771797877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cPGnHVzXgj2fdKy4LYV1thowyCOxSvdIUm2/cRgvu/o=;
 b=a5Cc9z+AUYIKZMN/6S0Hm1YefDRVAkgKPSihVrhnD/6/R1lSkvSktArlJgMrmMtoRE
 Fj6ipJRd69C8e2iUMrfvBXB/ao00LHwqZASfiv5h/DNtooQmIXuU4kzDlwwCvbTHtSAd
 He6YQu5PxkPfKORDdTKIwQMNLXcXZk4ODAU8Kqq7KCwcsTJ2NFm2GvZkFgmWRoiqdQNg
 h3/2qs3Q/6N+MN0Jq70hd2QY2N1rQEAuv6qMeM5tbf7GhZsWZnd+3ilaL73l4mmvnceP
 BoKzqPUPsdRT/BJ1ka4g+AUdBDZNZm6rdwhNIw5C3dJ/jykPxlf+c58uApnm9XxYgX5g
 nhiQ==
X-Gm-Message-State: AOJu0Yxj0fPE6IpRTq8tz4XEo+iBd4XonsRLVdgui6lc8/9nF3M9Q+Eq
 L1EcJ1mUL3pAbqoA19VmtM6J29/KWytIbW8XSn62xe/ZPEr9FGLHXvcpueoLNw==
X-Gm-Gg: AZuq6aLVPKAHFZ2pwyINi+oBhujf7HZpr96z+BCiIo0wtH+lsE0nMZHfF5diqyCU7iA
 Vno3dh5aMgOK1lpzFDo1mhdSYRtqv3TcTSu7G8Pm6Y/MC12DPxnwMA12na6iiBSVD/cjDSvjiwq
 BSKud7ZisAdIZWSs+R0bcxXGzStj8TBvahC457g212kDmsfNit62z52FORcRqqHKCBXFVvC8jSO
 N5XL1BKaEe8ouKmyomVEfnYl0dXKrZ14BvI3j415d+o4HYxOtWPG6lVn1QpPlmfqAFvdVi1b8rL
 Yh+g8ZbQ5vu5AgELjbeIoZvNreXhlQ6rS5zVUH7eVxXsrlHJTst3GZXBVTECNqcm5PTm1E1bsVs
 4Af5NP53AGg1rOUcMFbCSmz6RRH9l78ywDOZSf4jY6iPTbvUsNHarvuxHIzYbFTDLuon6fKF6NN
 bww2bNqYRW1k1oJLYCtzRsVWevNOWW5m7pLoBenxuxuI2NgG87y30H+7AeGogKA6GX0Nm590Icv
 xMvHPKMkPWxSRZS
X-Received: by 2002:a05:6820:8186:b0:676:e126:e7b4 with SMTP id
 006d021491bc7-67723709956mr4964218eaf.78.1771193076683; 
 Sun, 15 Feb 2026 14:04:36 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:36 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 8/8] Hexagon (target/hexagon) Remove snprint_a_pkt_debug
Date: Sun, 15 Feb 2026 15:04:22 -0700
Message-ID: <20260215220422.212249-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Function is not used

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/printinsn.h |  1 -
 target/hexagon/printinsn.c | 31 -------------------------------
 2 files changed, 32 deletions(-)

diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
index d437d35005..db61ea1055 100644
--- a/target/hexagon/printinsn.h
+++ b/target/hexagon/printinsn.h
@@ -23,6 +23,5 @@
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
                          target_ulong pc, HexagonVersion hex_version);
-void snprint_a_pkt_debug(GString *buf, Packet *pkt);
 
 #endif
diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index 99f8020d5d..a442e853b2 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -118,34 +118,3 @@ void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
         g_string_append(buf, "  :endloop01");
     }
 }
-
-void snprint_a_pkt_debug(GString *buf, Packet *pkt)
-{
-    int slot, opcode;
-
-    if (pkt->num_insns > 1) {
-        g_string_append(buf, "\n{\n");
-    }
-
-    for (int i = 0; i < pkt->num_insns; i++) {
-        if (pkt->insn[i].part1) {
-            continue;
-        }
-        g_string_append(buf, "\t");
-        snprintinsn(buf, &(pkt->insn[i]));
-
-        if (GET_ATTRIB(pkt->insn[i].opcode, A_SUBINSN)) {
-            g_string_append(buf, " //subinsn");
-        }
-        if (pkt->insn[i].extension_valid) {
-            g_string_append(buf, " //constant extended");
-        }
-        slot = pkt->insn[i].slot;
-        opcode = pkt->insn[i].opcode;
-        g_string_append_printf(buf, " //slot=%d:tag=%s\n",
-                               slot, opcode_names[opcode]);
-    }
-    if (pkt->num_insns > 1) {
-        g_string_append(buf, "}\n");
-    }
-}
-- 
2.43.0


