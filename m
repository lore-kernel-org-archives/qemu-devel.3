Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870A0C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24uz-0006qA-A6; Thu, 03 Sep 2026 06:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ux-0006p7-Ra
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uw-000718-9y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHJDU055336
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EAUhIK1JkAGqLZ5TD60PsAmyu+TeqQmuqksGcGfIMK8=; b=S2dBhCvQiG8wzrLt
 3pyEpzoRB3VzqhPu6RSTHGLLUvGt3/EOFiAKSKo3QhQKgrEmDHb6c8GZsz6v08qF
 dScVBaEQ8jcQfJZLQKcSlqLvFRN7mq+sYjGVy3POH6mgxv2/mZHYdus4eSYFllQp
 FNcq/4Sp2cv6CFJ8TDHcjCEFv+Hw1VdvCPh7Lz8N8M44mRZyeCx+ZCviVEUQRclQ
 AQ6p4cxOwUyL2PKA4RfTtCjVtktEz2DPbOrUwszSM6ux5Gg76EGbxTEDbQCIPvz7
 gdj6C0Zwr5ZsWGk3y6vxhz58T5jYSypj5EyoS3Af7lnCt31IDXHuwddkWpX0p5U4
 AwNTxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so409694985a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432217; x=1789037017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAUhIK1JkAGqLZ5TD60PsAmyu+TeqQmuqksGcGfIMK8=;
 b=XGFkquHeoy5BaObGKD9e0Rlw+MZsq6muDN9b2tOuDqRFnAtWdO7RTO5Mn6epdcWSE7
 vSRCAUTvyarDfnmqkaAEFAXFa4bZ8iz3tRBVbtOunDkafMNho6aY9+Sam2fvL5dCfI3V
 44LvTre3QUT618Bx1qL86rxMv+iIpmReVXKRripYZFEk3ZkXdhOckaaYdYQax9oK3OkV
 4q8Kvvw6EjVY20PmoAa1qRklUKZXMvvXLNJ4SMJ5QVDhGmLNaT+dHMf582QsaFTkES1o
 Lg6BEPPbzn2Fy8JyxZF7tbNzhxbTGW8/BUiESWwgUOup+MS8dvZ+3vOBRW9cjWDRv9MW
 p0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432217; x=1789037017;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAUhIK1JkAGqLZ5TD60PsAmyu+TeqQmuqksGcGfIMK8=;
 b=sRV8NHz9tuuv09wiHpghc3eskpTk360HKiKZeiWwltQ3Y1D/JquQ/vDsjmhH3M7PdS
 VjGjKsl15JEZCt+4SOOlmoZ/2r5cfQ45bFOoDr7YzwZ7T6b7kSNKdeQYAaKq5Da5OmYq
 ZfK5NFH0NApPcoCgDHsDwBet+HHbWyG7gus3GFuMY6DW3V2s5LMsCNBi39nYpwPtLhn2
 FcwZYZyVhA0N9NlSutge2C+Ix1RKYEPzgeZO8E/2RdMhM33Hk86pwu0/f4iucujFA1fi
 Q0353x/ILQo6ZnQIg375hGOXo6Hqdb+Gt2uu65ftYSY3mA5/M4x5ilNt8gqM2OYADrkT
 CCMw==
X-Gm-Message-State: AFuF++kYCzI6PSgRPn7Wii88BaTzSdXCeo6XS6T4rZk/gbkG9qmoiUUq
 AjZ9fPMteNic/eUPfAB0/fWwM0SOQp4Zqf80rdDx0MIanY4rLwb5IlutZHT78qM/8Wrjtl3ASnn
 rPjdR0V0D7/rrcMefuSvF0rb1wfgfck4ts8UPUAolpsC6WidUl+O4RTL465JJfMwwxA==
X-Gm-Gg: AYBFou2lfJDQT7PpOt4OS58+aZL4J7b9f8SuygNaUO4s2eOR+DYCV1XC1QQFBeTcbN7
 fkvFh/RbNckODnIWTt+5Fa8twQeWudWG/x/U74SKzNUctmPdhEUNVSa6CeexZnSeY4THRtrOlWn
 nmR1jQFm75pPc4FRGsdsm1OYIcTEwGqUOKnYOdKSq1811cr3H0XLFQQo7R+lAM/fTx7ZKIRa/RQ
 eKJhUUheTZ70yuwF/pRu1RB7N6YB7TndDJP7oCv+ur8xK1JBYA8YCuXifmfJpObEkWpS9enhCDs
 OCDi7hIswjxJJy5EE6Y1wJUGMS8aRyEalWSxL/mu0gngYIDF6EnYB/ZgmPCIsmkscZ+DpyK7lD2
 6UmsAWw79ud79zr3dMhpQuQoFkbdz5OEbG9ArDML6
X-Received: by 2002:a05:620a:3c97:b0:939:6dfa:db9d with SMTP id
 af79cd13be357-9396dfadf02mr424665585a.50.1788432216623; 
 Thu, 03 Sep 2026 03:43:36 -0700 (PDT)
X-Received: by 2002:a05:620a:3c97:b0:939:6dfa:db9d with SMTP id
 af79cd13be357-9396dfadf02mr424663285a.50.1788432216136; 
 Thu, 03 Sep 2026 03:43:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72df2sm13697179f8f.1.2026.09.03.03.43.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/51] target/sparc: Constify CPUSPARCState for various cpu_*()
 getters
Date: Thu,  3 Sep 2026 12:39:16 +0200
Message-ID: <20260903103936.62355-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994f59 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: cuj5w2Vbm_w-ah7WHGDY9oNuyzCdRgLp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2rqrfI4QNMr7
 7z8ZfidHqIykLn9L+kVMnO14judXVLcvPCPUQVAchvb40JWSjoAT8qALs0fyW5/DridrOBwruMs
 sFt9/qsNQqmd1fQELuw/zRNp3bjQbBP6/etINROIInt3y33DbSWL/DaUA8p7P7d52WJoDkAiAat
 DlLo5nUeZbOaVBD2179inpE5zV4nQrJTFl4FxANNw74JMdrYfcwgCrJzTWdmbRhhjJe/5DKrxy5
 6W1sqsvJY1CbLniLBAwVE3goDuJEhdGOvfYzDjhJOt1IaT3M3yCGWp99hRbe9tDnfpkkL9yOEi0
 tmMvtFnMeDm3agicRGiDtbsF9NVYT9zmRsQE4e73kNuajo+nS8661LiAXPuUsfB0Sd2Tj6jveni
 dIWwwp3guXgpmbeqeAcTitBvEBhBF5KOUGEFFy91UauDhwp3U2Fz7mUT1qOA4+YPVkE+Zg5R+eX
 imXY3OgIv9wNfBDOXxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX38cFwiGEMOpB
 yv8emJkPnIMtRWPNZtFpuLZmfsOBDPpJXm10kj8o7sSMIs8UxuCvhLO9gXbBMtRamkgMxK9IZhn
 B9vj7p76aHbqTZu5iyDuUfN81bN9NhI=
X-Proofpoint-ORIG-GUID: cuj5w2Vbm_w-ah7WHGDY9oNuyzCdRgLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the const qualifier to CPUSPARCState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260901095229.72018-18-philmd@oss.qualcomm.com>
---
 target/sparc/cpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de2..31a16c2af03 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -680,28 +680,28 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 
 #if defined (TARGET_SPARC64)
-static inline int cpu_has_hypervisor(CPUSPARCState *env1)
+static inline int cpu_has_hypervisor(const CPUSPARCState *env1)
 {
     return env1->def.features & CPU_FEATURE_HYPV;
 }
 
-static inline int cpu_hypervisor_mode(CPUSPARCState *env1)
+static inline int cpu_hypervisor_mode(const CPUSPARCState *env1)
 {
     return cpu_has_hypervisor(env1) && (env1->hpstate & HS_PRIV);
 }
 
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->pstate & PS_PRIV;
 }
 #else
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->psrs;
 }
 #endif
 
-static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
+static inline int cpu_interrupts_enabled(const CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
     if (env1->psret != 0)
@@ -715,7 +715,7 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
     return 0;
 }
 
-static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
+static inline int cpu_pil_allowed(const CPUSPARCState *env1, int pil)
 {
 #if !defined(TARGET_SPARC64)
     /* level 15 is non-maskable on sparc v8 */
-- 
2.53.0


