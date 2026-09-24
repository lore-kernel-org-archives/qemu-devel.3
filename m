Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CCCC98324
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKx-0003EB-Ev; Thu, 24 Sep 2026 11:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKo-0002m5-Hw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKl-0000Wf-Rr
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC57oK1430271
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FGi1ihUaFztgINnLFtdEKYkgg3z445qdDk6Oy7Vbmok=; b=e4sghe5Y0c69mxNR
 Qw//N2m4LQ4m0cnKXB/8mIa52SkvaCInckJ6Q/jx3IDi4X4QkUy3+MPwEUoVDKu8
 m/bkaitJ4bguPfmjosQCCRRw3h3jseX53Fmmlu5DnVg036QsGJm0C+BKG09rbd6Q
 bgdpBfcvGBjWHMVBXJspptJj4P/9Me6gEz34qeojyBs4EkYCRwZ2DC4dKp+5c/YP
 Rtw56LcG7ZHyl1gN1Ae/VdXDJynLtcrcE8AlXaWdOVoFQdUawehmHoIohcT3zSGc
 /FZ1gcGtOlU7JwnlGP1Q9w3tonDjVCbAWgrUVtPjkd8NSrAh7LamSN3J2tSujBHH
 PefPIQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvghasfc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:02 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7909e307799so1882070137.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263561; x=1790868361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FGi1ihUaFztgINnLFtdEKYkgg3z445qdDk6Oy7Vbmok=;
 b=P3Rpm4/0gy8OMiDOxZQ4os9Y65O6rY4eKKNuCOYkm/OPAdpN7Z1esHwJa9VJ/3Z4FF
 VlxbaPrvpRzB2wWmcmDdrvhVrm30OucdSIlmmv51hPbq3Hh0d3nuIE56mnG3/xcYquQ4
 LxaRKLiVhwrEmnKtee+YnvbS990w8CX6SFS1gtsdxzTIr59O60cKIQY4xf+tJFfb5tFa
 /fVrcPptc7Z/108DSCJyVKa/XoxbtinkdzYkijAaI5t1SSVqehhOCkKVj9bAdprAxL7h
 5/O/ixUZf/cdgFJc0bacEO5sejOao6qmnrPbITPTyuBENno+oqekYqoGccEO/9vhf5Uh
 8N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263561; x=1790868361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGi1ihUaFztgINnLFtdEKYkgg3z445qdDk6Oy7Vbmok=;
 b=aqLihhkJYtatTE9i3ZVDaO/OD/0d/yz+ZzYrZ3fXFGIwiZPaJ1TC+NTsWUICsW7a+e
 YorgGEYBNP+Ofd/VeMi1DuhdOldWqni0xk0wgTiuUGkwGSKDCpXMVHN43vnS7rb+S/6i
 Gk/cjqevBLsr9AKdSCIbvc7laR3BVmdnEfZo2gH68mI1DF3qUZrWWDBaeiA9+LbAgV+g
 bh65S7onrNJ/sfr6UW+K/VQtTWGkbApSN7n7D68f514SKGnDHrIrX9GfTAVSbKqk6yUV
 ZbsVBW5zyRPmaIuWKrTLZFw8ynvBdcNOvJsCHe9f0BwWTysA58T9kv69og6TyiF0WHJB
 cPYQ==
X-Gm-Message-State: AFuF++ntRFTRtcYTBJnlmiflxA2Fq5Lha00YshSgWQ20aw7QqcnqVMJB
 wwtpTGq2fcXFCbQEjdQCX/KhMqcweX+s4yRLlJluV7nLk/uf2XXXu3o2vo6romeVq/znyR23d7q
 qDdePRY/Y/QcADTqky02vZtGy/TayCxw+epRWGpqov85FNrDS1ZG9GXhMZ/+wLhG2Lw==
X-Gm-Gg: AYBFou0DVeCa19hkbv6RByXHkFkZuI1VwVavb7/yrB+Woun1KR1XTvw06xQxTtgSWlE
 eCnBPPAHLtpJG4w/1QRMbUdzkVO03eBliUWXgcboFjeqEOIafI0nKezsGfTnIIpqnfPRP81lQJT
 1D7mbNY1ZGfZPTN/X0XGpn5wq1wQKuwx79ehVK4vFzzZWmf/PAQx+9k3tRxTt5Vv0yC6QDj3dk6
 xysiMbiwr+74evGSioEEfzE8zRbEEgSeRC7Wuc8+/C2JrvFntA4XJ62jJh7AEofatCUO4iB1I0K
 PwmH4VCBhKcD57/jQTjtGwpbyC7lq+tkyrcMID10RVBS9rCHx5aqWS7WoriRI5f26eyqbV/o19o
 vU4gcSmaS4kjW+P3n28Wiwa+3USkD1sY+SCy4GUjb
X-Received: by 2002:a05:6102:3e01:b0:7a2:1f78:c6fc with SMTP id
 ada2fe7eead31-7af1d09ddeamr1452865137.14.1790263561293; 
 Thu, 24 Sep 2026 08:26:01 -0700 (PDT)
X-Received: by 2002:a05:6102:3e01:b0:7a2:1f78:c6fc with SMTP id
 ada2fe7eead31-7af1d09ddeamr1452844137.14.1790263560682; 
 Thu, 24 Sep 2026 08:26:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889409sm12783015f8f.35.2026.09.24.08.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] target/s390x: Access S390CpuState atomically
Date: Thu, 24 Sep 2026 17:23:48 +0200
Message-ID: <20260924152353.36209-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab5410a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=jkZ4ftcXAbePN3d4lLkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: z6Qu4ZfP-xZOkk467HiPSQ1udvYEUdVG
X-Proofpoint-ORIG-GUID: z6Qu4ZfP-xZOkk467HiPSQ1udvYEUdVG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXzhz6UHom51aF
 pgp6M0hX7D6YB91Dj6+tL7XlYRcCKg4ZgNxSWoqj7zEkLFtUl+v8i32NtfouQQa3do/bkAeN1Cv
 12l8hVoKSxEkuspDLnL/sJi4JoGqmG4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXyGzzU8MV1cAx
 U2+XrQ0C9HWgtEblNmqNbItRTbvW3/WUWPyhWajWf/3W3eC+4Iv5gR5BrzAHZrWr5P7NlvLblal
 ljiV5mVpkRtgkm/LVosGOQ8cPjxUW9WCPNMp6pN1bdHNeaF4V3GDN9taMRSxsAgwFMcKnszn2Hz
 EAiqr9263VQzW77DMRynHEop26norTHrD0cxFThNEYt2hy0u5h2UU+Cx6j2O31nosWzXCHq7D0U
 jS+XKkX8VKHYtryCCqAiEDaVUyWJiqMSBVxd1kBYZ776G988uDz1leDRwp771XdYGhb4maaBYCr
 SPohCGOefCw9RzQc2yE+2M8itINZU3nxA5mqXREI8tNfyXLVapybOjHZhV+QqEtn/uMxfNdGGMq
 alYRPGjSN+ECtJLg4XUSro/BqVjbsI+XF3y3pKrw1J8VtJvcbVuiQN4g6yre6kPfeXZQ5oXOnID
 GLP/0SCaM9pFct18cQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240063
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use qatomic_read/set() in the S390 CPU state accessors.
This avoids non-atomic reads in s390_cpu_has_work().

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260923171116.31276-6-philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h        | 2 +-
 target/s390x/cpu-system.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index bf9f6ed1de2..ef73b15218e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -855,7 +855,7 @@ static inline void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
 #endif /* CONFIG_USER_ONLY */
 static inline S390CpuState s390_cpu_get_state(const S390CPU *cpu)
 {
-    return cpu->env.cpu_state;
+    return qatomic_read(&cpu->env.cpu_state);
 }
 
 
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index e15775875f2..d963d9e940e 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -276,7 +276,7 @@ void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
     if (kvm_enabled() && s390_cpu_get_state(cpu) != cpu_state) {
         kvm_s390_set_cpu_state(cpu, cpu_state);
     }
-    cpu->env.cpu_state = cpu_state;
+    qatomic_set(&cpu->env.cpu_state, cpu_state);
 }
 
 void s390_cmma_reset(void)
-- 
2.53.0


