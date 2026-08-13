Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCDBC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuWEQ-0001uc-0H; Thu, 13 Aug 2026 10:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1wuVfa-0007sH-27
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:40:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1wuVfY-0006CB-B3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:40:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DCJhVc2359298
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 13:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7WQjczii0kmht1jrY9U/8fYerS6jcI4YNXV
 mdT1tbhY=; b=fHgLj7KxRFXEmEB0C5D3WsyE1vxghoyanDsCmnW6/4SJVi1GWmV
 Sg74O1v8Gt/WPOcLoQ4PvyJ+/cAyN5sJ2QFXcCabh8PZoPfEoW+JwBYNnfSwQiXm
 /7Q9yFTjYArYmE8zYlWdXf0lGsMXjQeQ8NtGGV2OEGJv9+Cnds9BiNQXwToPWOdE
 xAKS6nWKW/Lm99R9DfEl2UJdb7YYriLsuyM/BXcSSLaXBqtEJ3d7y0ra6lRseUdK
 p8+7ppQCTvsKVFG+TCiRNMvvPZYDIGw944QRUfb0NyHVGhgHIUrHjGkMALOO6ip4
 4jXVHuvmlKp5E8DY4ZNaZ82J21H5WXEt8QQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1cb5gpjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 13:40:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so1052436a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786628423; x=1787233223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7WQjczii0kmht1jrY9U/8fYerS6jcI4YNXVmdT1tbhY=;
 b=EZi15AJxLVHY4UpIXCvZDJkF0smvjJpwSGDew+uFkJWO5KN2bcCB4IQUsI9E+GyNAQ
 EXRD1zDDODr13gcrpU/V+NU+Nh9Dmty/EWRBVS/C1IJv66CLh1qxxeJiYVUcw3LsfvE0
 +fmp3spwUI8Hu3B6wYqqiyKsqPCJWOeVV8ibH8fW5b6El+IN368Gczcc8TeIWQb0ycHw
 FcVMp2xP1y7cDwlcHFVmwfRGq8RfJLDmBXeYGoEzHBkfjOK4tAhLKfQjV1CaeYuhwwJT
 42NSAD+FwvPkS5h2FSOukDaaS5mUPaegG5hIGbG55t7C4ZULbRlEyD/GPUvuBpsXHjo7
 wfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786628423; x=1787233223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7WQjczii0kmht1jrY9U/8fYerS6jcI4YNXVmdT1tbhY=;
 b=U+ac44ZLJfB+4YsUu5dx9Rb2EWJbsjens2tWUqofhdvsSEmdRc+UUGW7bs1fxutNy1
 bfd3fNfybOwI6Umcy+j8FyVRiOXn5fQJNidv8+2mShVqSuM4aT6ZqTMKEU6jnNqYpkd5
 D6k2Gt1evDbLRigenv3SKwx8lFx2hxMIAScZyN3XydNciOYbkq4aBBa8o7UtUf+XxFUA
 u2j5O/rFjrJB6jVHHpcd1bPhUkfqBTQdREIStTmS3flcdc/SPOGFPkqIxKTGSLj1cCNU
 pKIrRvoplH1fYYUhFRsn5Kfeal/ICjiGxmj0uBOBTVmvIIjQ4uAGluB3rniViWyZumJ3
 aMag==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqgj+E3YzMTpoKasFQkDqR/lZrfnSh63mmRaFp2aZf3C1cOFRvxIMoRqnlu14M15okPoGGSmCGKnvwx@nongnu.org
X-Gm-Message-State: AOJu0YwuEgir6Bk6UXJup5haVkXQXdTQuacQquX1J2iaUEgaG0/QY1Su
 egiRTkyc0x6zq4QxIKK0hw4X7m6jdjUc7ZX34wa2JfPvtFQmc83UkXkugD3Ezta5Rw8J4txjkoS
 6CZQ/hMh9TjwY3jhLL0Ejc/qUCJvXSc2hz4/MEv+gZB7xjwFJp+BEvj89gQ==
X-Gm-Gg: AR+sD10eOhXOf4/xDmWjEPGGYkl466flD56MHVIJ0i3gf+P8i/0mrhijtSU0KH25Dkt
 UCckANlLLXkLxncFQCXwYtpMrrME132T5dKOY3941fcUtpw72epOqC7t2qC4qtvNgLaigdCPnHQ
 cTY7vErprdytLu0CmrTe7D3h+8vskVPxCUWOwzP0lE4xeCODOEnt0S6Kn8tkLRbLjgXB1dAazru
 4kqF1qesyEQQb3lcVtQo1iego9tZmmDvor7Fq8cAQLCg9uFhTvBPBCGM2GYrnCThTclLrIM06J9
 JpHyLlpCDg1yNgiNyzRXzBwlIAqcMYVYHWAoXy5go/neFepRrOcMTu+qZZPG57RV45peAAEagau
 5l0rTFBkIQXaqUJf5HvSjgAXxxFQdkBSp8GCiQq7UlKaxh77ct/ZcUZarDXus8SY/NxxvtQmX/S
 lGalXNtHzpM00QBLQpfWLKZQJMDw==
X-Received: by 2002:a05:6a21:38e:b0:3c3:92ba:c61f with SMTP id
 adf61e73a8af0-3cc54f46294mr8302218637.8.1786628422527; 
 Thu, 13 Aug 2026 06:40:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:38e:b0:3c3:92ba:c61f with SMTP id
 adf61e73a8af0-3cc54f46294mr8302152637.8.1786628422101; 
 Thu, 13 Aug 2026 06:40:22 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-31ebf732166sm13676384eec.18.2026.08.13.06.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:40:21 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: Fix LCOFI masking in sie/sip/mvip
Date: Thu, 13 Aug 2026 19:10:01 +0530
Message-ID: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3FY6Wt9ScHX9dhfjkJSOovsPNnb_H_b2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5NyBTYWx0ZWRfX8yZVh6zdHcHy
 O24IgakE5tfyl6pWOFU0bf6/U882W26FoRn49PfPjNeNvvJM3/r843b0xSLkVm7tdiA+ARwQ0R1
 FhZZgZO6SACGJcSx1NMfC12EljesMb0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5NyBTYWx0ZWRfX1W49md8Drndh
 /dAE3MF7ttrbhDqCtt72HAiz8ovWyyX03hlYnPJxf0hvOc5z+xo5m6fkeWx3B2barh7rPsdu2SB
 iVl5hbilBb8KfbTd4HIeeG8IhNCD+BIY3KkSIJCYHiykoaab5eQ1sn2Vo2RrLYiJw00Aq3ks7Dh
 2VS51V7S7NTx35JlJxze2TAsJSolzlgkk/b2dcvJEvEzd757fAGYeATf+Wc4RBe413ari2Z1yW7
 YFHkxzpTN9taz9sSig9EJ6sgEVwnRwa6NGAG/LTuti+ZV46oRyEM4Qk8UdG5DudEhWZex1fDxEx
 Xv6spCTfoWjUAflM76kYkd7KEpK2AffJHRoEWF7RQ2Waa102BKxW/dWlaxLwJuJ6LSvoCbUA5RE
 2W9Ob167tZKmLNxoHE812xWUyIk/imXndp2wmXXwVb0q31ChGG+6D5K76RrXmrTNY0MyeSHpdIv
 CBxzA6quYBO55aoR6eQ==
X-Authority-Analysis: v=2.4 cv=GoNyPE1C c=1 sm=1 tr=0 ts=6a7dc947 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=aWkNX-pSukNysjBq-6IA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 3FY6Wt9ScHX9dhfjkJSOovsPNnb_H_b2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Aug 2026 10:16:28 -0400
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

Commit 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
dropped bit 13 (MIP_LCOFIP) from the supervisor-visible interrupt masks.
As a result, with Sscofpmf enabled and LCOFIP delegated to S-mode, the
overflow interrupt would be raised in mip but never delivered and hence
perf sampling stopped receiving overflow interrupts.

Re-add MIP_LCOFIP to all_ints, sip_writable_mask, mvip_writable_mask
to allow it to be writable again.

Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index c05c8ee076..ca68c1f5f1 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1890,7 +1890,8 @@ static const uint64_t delegable_ints =
 static const uint64_t vs_delegable_ints =
     (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
-                                     HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
+                                     HS_MODE_INTERRUPTS | MIP_LCOFIP |
+                                     LOCAL_INTERRUPTS;
 #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
                          (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
@@ -1936,11 +1937,12 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
 
 /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
 static const uint64_t mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
-                                    LOCAL_INTERRUPTS;
+                                    MIP_LCOFIP | LOCAL_INTERRUPTS;
 static const uint64_t mvien_writable_mask = MIP_SSIP | MIP_SEIP |
                                     LOCAL_INTERRUPTS;
 
-static const uint64_t sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
+static const uint64_t sip_writable_mask = SIP_SSIP | SIP_LCOFIP |
+                                          LOCAL_INTERRUPTS;
 static const uint64_t hip_writable_mask = MIP_VSSIP;
 static const uint64_t hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
                                     MIP_VSEIP | LOCAL_INTERRUPTS;
@@ -3953,9 +3955,9 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
      *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
      *  that come from hvip.
      */
-    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t alias_mask = ((S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
         (env->mideleg | ~env->mvien)) | MIP_STIP;
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
     uint64_t wr_mask_mvip;
     uint64_t wr_mask_mip;
@@ -4188,9 +4190,10 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
-    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
+    uint64_t alias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
+        env->mideleg;
     uint64_t sie_mask = wr_mask & nalias_mask;
     RISCVException ret;
 
-- 
2.43.0


