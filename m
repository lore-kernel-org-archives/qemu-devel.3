Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94517606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UTOyv6+Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PUS6HAzB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgH-00042E-2V; Sat, 24 Oct 2026 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg7-0003zY-3y
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg5-0008Ig-9a
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExwP0996544
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mTAxv20+QUe
 oEgF2oGDKmNgA3AAqEutEqXpWaEZVX5A=; b=UTOyv6+Q/meXHWhmvdUmPTXI6R3
 9cHSCo4hWjKvz0+cB09moGpJqX96CfAiDUhxRQJqnxuhwMmBI02OLxfVn7jx8gZQ
 CGK1w2RKRf33famd7b+ElXBW7EhSV0VZ4ofZ/GfSGGxfSIHxKBlUDkxd32xGvRT6
 IItVUROW2QJd7dF2djz4fZwNLnd4OD8+6EeLT91cMNxX3D0tolFs4VzPczq2MIm0
 nOEJpsXYPxZ9kUhlqZ9W0iK2Ie4HMXuow1tkvN5RnDIxhUgrYzUPX9PVwx/baQ4B
 DKuNwHOeKymOmJlgipidhvBji0cGQVHCpMuH2pRdkz9Xni+Bs2hc+iF6cUQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9sam4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adad90c894so2030060a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863427; x=1793468227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTAxv20+QUeoEgF2oGDKmNgA3AAqEutEqXpWaEZVX5A=;
 b=PUS6HAzBL2Phux4qxVqOyKbzOyNCCPzg/jnL6NXg2LLN/Vmc4wpFBLs5n0d7bm/wUT
 iYskLgDJtWi2e+3/5RUVTNnS5AsxwBZQqwZ9WtZww8YUA7P84DGogpALmCVWT/xnjxKU
 si7ivqgRsZXbhCZjJWVlcLHqnor8QQXRnoSrUla2fkX/lO9ySjJ3CxdeVzejocqyvGIA
 rHjzZRvz2WyPLvlja9MbnrfmVqFX0WMpm4TNUNIJDS/4GmL6Cq5VmPde6umPRJOONrJz
 ZBV4unc3poTZNx0GT1jL62Gtd1boe5qt8cmvo2YilFae6QxTYhUrTRpPR697KSescnP6
 +Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863427; x=1793468227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mTAxv20+QUeoEgF2oGDKmNgA3AAqEutEqXpWaEZVX5A=;
 b=jyOVymq2ICIhVwDFyVdFUrz+9AkLrNtrY/g3znWjWL/KFmTr3R3MBLyJOvddJu8SVT
 qQzm65mtdm3+p4SilcrGT//cg639kM6cJKNEUDk0gU3cTcIL61GyfeZMyT7RG3omu0O0
 eRCg5Ceykg0xLa2UyPKEIua+FmBOZ55jm6Xpou62v2SVAm595Stqrf3G93kwRj2M2NZr
 RT1e+D6t9yog721UTpKUYdNYwgp+O02XbMed3ZomkJfsYRMdtbcmxz5zarJM1FGG/oPA
 0iMknXpREyueeHmNiz3YNuhP37onB63bLlZJzYQMgFMcNf5b0a5Arpl1ahzFH09LKfLM
 ExqQ==
X-Gm-Message-State: AFq9FYImaozW2tHICezVPfNun+0J+6g+PLf27frwfGM1UQ31J3UQDXJi
 /vLr+0ORMSR2M+OunMMrqbMLDn8XmYXNRZy0iauK/JqengEZLm/ClQ0BSGiLRt+di1V2tE57czi
 qNF8J4jYQJZ6feBpM7peO+lDcoE9sCG4Es+DC/50ci1SSs9SVPz2YJN/wXDcpp4mMxw==
X-Gm-Gg: AYBFou1yVdiln9ZQNl80+0VE0MecymJM07zZmA8ARJg3SIynlsvZXn5gT0cZZ49X0YP
 sks+kx5Fe7jCRNcHQ8XMEcuK47bdGMOoRGWHp+x9KV7zBw+XmM7wQOVyCzIC2PTxNMZWwSwWPyD
 5U3bt4spfiZth00m5YU5D5NyLD9V9HNqG8jqKZ7GhME+ASYYzd83zJxftJ17+469UgaoQ6uPfhK
 a07dt9VIEuBO5CqPm3kr+qbK7mYd3fZ8cFWL+RLV2GqKh4ayWP/Qd45MyTlyf5KuL0UyU+58fdS
 xNipYXbrwHqxBuDV3bJrxl2s1n9asMuoLxzv+CCs0s8+b9usn474EAD33282xIEeWI2XgirwPpF
 yK2FzM82zZ5m6Dh5Ku+YNIIxKmrxi3DjKYjOBL6PFnLowROhV8lEyaBsi7YNN5CY=
X-Received: by 2002:a17:90a:d605:b0:3ab:2236:6b3d with SMTP id
 98e67ed59e1d1-3adead57d9cmr2303846a91.27.1792863427336; 
 Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
X-Received: by 2002:a17:90a:d605:b0:3ab:2236:6b3d with SMTP id
 98e67ed59e1d1-3adead57d9cmr2303833a91.27.1792863426867; 
 Sat, 24 Oct 2026 10:37:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/20] target-info: add target_base_riscv
Date: Sat, 24 Oct 2026 17:36:41 +0000
Message-ID: <20261024173649.7405-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5TaJnpOEciJeVwrj-wuEPigckDWh5LED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXxcAf6SHYF6+S
 zjfWORT6YgpBNXRwkl1qbTy5UbCp4MbehqP0v1bFxxNYTtw+KD/qdE6i33VD0K2nvhrNZgacR3E
 j7XCGj4FxPhTvfLgSNHR4KdDvoT/WKOxLgop4WrHgbktfb+nm17OjYhqarQbFPVfL/VRkePPe5r
 3GUlA0m3ffWpb2pCoem8fIEwANynGl6b7W5JbTy9d727EGPiYr+qb23qzn1OzF7afm5D+2UNAXl
 3VBnrS2GopXunTUVvoY5IaU5pz+ydvCPxGDXUOcVwpYhlyczKm7TPYhhHa31zZIheRaMPuIw9Rl
 da69w8BRUO4IVNw9SFsTxIUoU6TxPTL9alWCOMCNpQmYlr1fzTFbudbvQwV0+CudrtN2MDtqnRo
 wYMYiyk+MxmZPPJskEs0lI2wwnhxjKIgvqQjDFrgkiJxPryJqZjN2lvn3AXO9WS2CqHohuiWAXZ
 CsDTX/l/O3+yzkfVzNw==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adcecc3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=tnRFC3LkjjiXvWSh4a8A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: 5TaJnpOEciJeVwrj-wuEPigckDWh5LED
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXw2JftKI0H6KD
 jecHCuorxribvfgPdWmO0y1bn+d3578/E9I8JDVm+wHnGtEloUr1hhKowImNbvwt7/Tb5Tq4F/k
 NUCrQqEYrN3b6EIAF3vOTsc2Ftsfv6o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 923c00c917c..2cd4cc5671b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -120,6 +120,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index b8a4a7ebf7a..e67d7bed520 100644
--- a/target-info.c
+++ b/target-info.c
@@ -110,6 +110,17 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_base_riscv(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.43.0


