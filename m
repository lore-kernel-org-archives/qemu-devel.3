Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZWleb54P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gjYoUIBj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI1H-0001sN-Sb; Fri, 23 Oct 2026 12:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI18-0001hr-AA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI15-00031P-5k
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wNR2109216
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I2J52Enkq5xu0RqWRFdZ5GZ2gTsNoqTPQQHDSKZA688=; b=ZWleb54PO2wNUD5c
 4bXDf4jYgDj1kRP/9jzvRqZdyNWY3gxSBQhATrBb7mPZVZSwYxh7adbz5v3X5Fea
 mxRmbqfipGWv0U6hf6lpGxexOnxwtgEDWRJqXe9IAKg5a2+8xGqCQ8BunxaT2GGj
 g3HvNrEqaV0feSOmBa9cYr+2x5i7LbgmbOAVmn1uRRVtJicp95ZKVPYXheBFhaG2
 ZTnhaW1+SY8bE8JbO4S/KK5QMsTwjQLAuv44uLS0XgGQhdJRvkX736mgYerVyp1A
 L5i2Cx/92AyJoVJ0XeqL6HrkDOLqzrwII0TCXcitDcl8U/OWu38ntWJuOrOg4014
 ZxxHyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4gwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so215715985a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772470; x=1793377270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I2J52Enkq5xu0RqWRFdZ5GZ2gTsNoqTPQQHDSKZA688=;
 b=gjYoUIBjeCMxCnk8muDw44103igsPkZ3zAkQoo+Y8keHUwmSPctWTQSLXr9A4FASRV
 F//f1122Rx3GbX9j2cjf5310EYCTajzQviAVnsJft9grAiEtu9x0qOa2JyCnNGa0aXOJ
 TFdM8erLF4aCzMeY/K8JC/sOHWQZwriE5fseBtyCvL3Nvq3DHsCv9smCbnqviL4Pb7uV
 uuEbH9qazQIRYEH1N2luknuCL+ceI9FLRe4Az/vBOGVPZlFXqfo3a1Z+swTy+g9ePWAt
 Qd4DBCTf+xPJpQevdpJu2QI9Ml4AHR3WNpUbhBbeVKRNd7L/F/7FFbII16yI2maXaDpZ
 8aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772470; x=1793377270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I2J52Enkq5xu0RqWRFdZ5GZ2gTsNoqTPQQHDSKZA688=;
 b=FF0sUbQIDU9wa7FEA+gLeM0ScRWpW/e/OlLcPw+dFNZ2YCIETgN62yPTI8tIJkf/vs
 Wni/XRrN6LGv4hnOnYl7u1ib2FU0oCl4gH1BUrxPnBB3bcxNydIxkw4ZKeTFb5HP2tsb
 SFcxnadtA6SIXuTP1FK9KFV+goouOqDha91IacF2LVFj5TVRZLYriq3/ilfsMjkFFkXa
 gR9XNUsDPy/Vr7lb4O5dduekVsQZdSP2O8IuZFYQsJ/YpXNMzjFqh8rOm90PtilwdTQe
 FkSlWo7N15DPwO2xqIomSHTS5D5yNlADH7QyArbE7ViA9+jAhHP4wyYw5BBtlLR5aU+f
 5IZA==
X-Gm-Message-State: AFq9FYLI8sbrVoXrVOyfS2fIjzx50NOhdt7dE1WmBH7SRWIyfNS8xHzI
 e4T16wVYvwLxN58oeWjzV+2tbPs7HpYfw8zwORsUkZYMu5iz6VDS0wH2haZO7kjxmZY1mz/CBL8
 6HvUizC534DSWt4SnhEeWYJ+xhAfFKnXMge3YR8XwKYF40gVzcT2iH0Ete3/25C+qD4yr
X-Gm-Gg: AYBFou2YHqSfDn66DrK+adut/ZQfnbCLw01SFQ1mT6vMc5/D/QZl6Ihf6WYdUWHp5co
 ncP62N1KCRtNoe3rhncZLsxtROzb/70w8FUBE74uNWRxa9UyBP2OmISDQOCGWYw4DdBPIpYr/Jt
 LeMCmY0CQ6FqwdLxW9hcleRt3voqUq3b6vvX750eZ45eAFXWNm4OHadxvPaL4NUCDu5B3gRt41J
 xcBvKo84tfJzDficTrgmzbDBy4lyBc2DC0bzQtKi+/lTdLNPxad6lczZ238I056BV4viCL+DKSe
 wAXj2HEYW1+fvCo6hqHooSkGMCbDTYBsVd1dYCpr63L1oXB80sCcLml5zfgkqo2jgUl9M4gG+hn
 kXHnxax8gOgHQqeHvpTJrE1Tsmw==
X-Received: by 2002:a05:620a:270d:b0:939:5d22:d1f0 with SMTP id
 af79cd13be357-93f624b1fa5mr941884885a.2.1792772469619; 
 Fri, 23 Oct 2026 09:21:09 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:939:5d22:d1f0 with SMTP id
 af79cd13be357-93f624b1fa5mr941881285a.2.1792772468942; 
 Fri, 23 Oct 2026 09:21:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a9062d50sm16323835e9.2.2026.10.23.09.21.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:21:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 63/83] target/hppa: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:11 +0200
Message-ID: <20261023161332.60153-64-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXxynKBzpuity/
 EBugzRCQtDNPVPwJidiTF+giS8iXkOQDswXAVGLI7LRq1gPgEziMJWk5ygVvitd4De3eH5Q1WwL
 UUcEk7JK4V7TzYEe6uQR/So5ATeQBAnq1FGugUkgH6Rqly3LmYteC8DT8u7LgOhAO6SzJwICuQf
 LiGj83fB4IyqPK22/RQjVlO99o3pmCXTtLUIT2OyZ6he1MBtn9NcLJaOq/Chz+XKmLrd6KFDVN/
 4WaQpNYg+YyDmhxlUBryNgmstXS2ObmUQGY+eeoKwuIDz1DTmOTdeRk56vO4xv0X9zYTg4Xzwqz
 nI/GGkJKg1YHA6mC7XCWs3ST8U4Pvf9NcUxwBrOvs7jVJt/9BJf03OK3+oZpESFvzMN/SzvaPNv
 V/Y22LtB2cOqx6YmfH/cyN/gEx4ejaF1c8Qb8YOMfhzC3mFX4dvd/TCrKkRU9TZB+wXCrSKMSrh
 IKvnDwBOVqFGQnD+UMg==
X-Proofpoint-GUID: penE1aCsSIOPiTzktdqnf6pm_yWbY68I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX2sBSbQtXsSDI
 gCboHBHNdou5vgdlsnzZrBBRIHKWa1XNTgJz5GtAElC2ebZk9irKPc++svLW25rToYqGpAYsn4G
 g1iV/f12LrW0QXNfkUTkigbrMDTEzSU=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb8977 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ya3Pk_hNRNhBRN_1oewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: penE1aCsSIOPiTzktdqnf6pm_yWbY68I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-5-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hppa/fpu_helper.c | 2 +-
 target/hppa/op_helper.c  | 2 +-
 target/hppa/sys_helper.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index cdbebcfeb3a..a0c8c91ee54 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -82,7 +82,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
 {
-    helper_loaded_fr0(env);
+    HELPER(loaded_fr0)(env);
 }
 
 #define CONVERT_BIT(X, SRC, DST)        \
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 3542c275663..ea0680aa9eb 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -341,7 +341,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        helper_hppa_excp(env, excp);
+        HELPER(hppa_excp)(env, excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index f7fd80b5830..ccfc2b48816 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -51,13 +51,13 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
 void HELPER(hppa_halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    helper_hppa_excp(env, EXCP_HLT);
+    HELPER(hppa_excp)(env, EXCP_HLT);
 }
 
 void HELPER(hppa_reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    helper_hppa_excp(env, EXCP_HLT);
+    HELPER(hppa_excp)(env, EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
@@ -120,7 +120,7 @@ static void getshadowregs(CPUHPPAState *env)
 void HELPER(rfi_r)(CPUHPPAState *env)
 {
     getshadowregs(env);
-    helper_rfi(env);
+    HELPER(rfi)(env);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.55.0


