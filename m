Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBAAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetmz-0002cz-2r; Wed, 01 Jul 2026 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmw-0002Zi-Pw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmv-0002hH-5z
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8Wai744292
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 12:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yLWWWOvyZlq
 WJAuRBG/+LvQ8wsXWm7/p8iGepA5N0bs=; b=N8QlJKpUBHyZh1J8PfGddjaCru6
 HWD42fJ8iofNIQ4OGtOjOR9N3WdWK5nqniY2n0tjOhxSJfbOtQJt7bInPq5qejnm
 hJ9mkTFJUxLU4OEC0F8ZkAPCxE+XLZ/ClJIkc+8BEjVDkP+LNEcbwlFNRf1rPM2P
 US9gBTdI77ScE3OuqlyVBEz2lp8hEEAyPSbS2ZDKeOn+0TRkQYl8EKJyHK6LrYBN
 MvAjJyeeC80V8oiuE7y/H+GMyNiqtFFvd9ZNX0yLQPkq/EAWZQ7YA2r1XKbvQ641
 yQHsyVyrsMhxyYQCbHnBk4PPrSHk0NWul91bi3cCdemB7b62wOwV8k8xl0g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0thd1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 12:11:32 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso7501016d6.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782907891; x=1783512691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLWWWOvyZlqWJAuRBG/+LvQ8wsXWm7/p8iGepA5N0bs=;
 b=KZTUsu5xepxXNLj1AfEPiRY7gnU2R8LerhEHIxgOkxceYl6s9SLK2ilVD6OKe0I2do
 PwXS+70hrwueVlDNR5kqiNb85336QAJ5lXb1zZ9SrDMbRC1CNYKRrNMLThPmd92P0kRO
 bDOtYTzzYi8rdf8KmQDQSkaDzs9uH9byCEKIdbBRhbCIZWVL+4PiyXswRBTFg+jbaP9h
 eJhiGcLhz09wNFphGsmX7r8HWB9E48pcTNUXKn4Gnk4NDUH1sJeMlI5HD0YlMyYQU5sT
 VXJhW2v784I4HF4JzrDtvtwM844RGjTTEw23aiHD2MAsL2eZA+jj2xKyMgyZtNxFLm1Z
 viCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907891; x=1783512691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLWWWOvyZlqWJAuRBG/+LvQ8wsXWm7/p8iGepA5N0bs=;
 b=dAWENZ73BgMzZZ46vYahy4M8cn+rmX2RZFSSRI+cyMfnIRN2wtV9i44sbxr8nseLVa
 4/YEpyIIS0jOTKPukWNPf5hpsYKAI7kqRJaEUnUbkNdFyg0HijmAmwFfNFXhQd/b/ziv
 FannRy8TziwaERt8SwerEolCj0QgF9RWgMjzeYI1DSMz64i8o71XF8kxZkNFliqRcUhM
 Cn294VzjHkIYkaAj4zs4BjrXI/1V60oc+SN9uOFCPk5F3G9YTxYCnsb87gEHs8oC0HPe
 xr2Y5Lyq2c3TDIVAAEv3QXH1pPyausFzqFqxKnGrPLs4+SLGvIhmTymqV3mxjZ5creoj
 g8vQ==
X-Gm-Message-State: AOJu0Yy+6KWq91BkXmYDPy+dgXQrxG1C5RQSvmDLjsJ7KVi874Yv9tkI
 2eruuH0ZhPuTL7l94H/boq9w27uTXrUqVRnKA6/XAFIb5pfl7popXewNJdjxlbjpUZU8XrFGzcF
 +ieKnOqdeKVndOLMhUsNkeSJkFVlwTYZBwrbxirHY/yqjehJdD5ZRP/UE5HLVF3tjVQ==
X-Gm-Gg: AfdE7cmANrky9Ai+pUfuaAiu/CkGVv/yfU+QKCVk7/8cOA5Ynqt1T/rfPyA9BPsxE+p
 Abnpdd5NMt8VOV0pzZfJFApdUv3aYJw/pzrmYSngeOps/A65s+s97B45NyW6kpPDC10cdsYbREV
 +RNA2gTJZjWhuxD2xIAqoZigQs9SnCqCrbBPl3p+aJEzjM1H+yBJcihgtYai8AMFcoU1FSi0Zd7
 Spii5DbrQ2rT7avd8hbs0Q2Lc4U9c2zBLbIxVez0869b8K27iRbW/O0AAy48lm2McQuVrtIP8hL
 uXAUpaQZ3/JADy6g8zwn2M/0IWYRhnrZCqE3tHiVkGGwRqqTAsRVQZlwdqaNixuP7E5We9HmuRk
 WTA2UCIopywFWkecLaJQKose0TQ93jm2azppwDxtFmoY/pQ==
X-Received: by 2002:a0c:e7c3:0:b0:8ef:549b:794c with SMTP id
 6a1803df08f44-8f3c85466bbmr11746116d6.29.1782907890232; 
 Wed, 01 Jul 2026 05:11:30 -0700 (PDT)
X-Received: by 2002:a0c:e7c3:0:b0:8ef:549b:794c with SMTP id
 6a1803df08f44-8f3c85466bbmr11744106d6.29.1782907886359; 
 Wed, 01 Jul 2026 05:11:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f3611df020sm19794706d6.30.2026.07.01.05.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:11:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/3] hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv
 access
Date: Wed,  1 Jul 2026 09:11:10 -0300
Message-ID: <20260701121111.537654-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r7iv_WJeQsvLzf0XsVMlm4DBJJyDuOCO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfX+pndpdS64giS
 b1ISo8NLkJW+H0kp+FklFN1IdWQG6tiiuXLQHNy8OgLtKlg/0l6VbqFFqlEJEWzdAHlrXqBwrYh
 hi9Yy8lGCkzaVEIUlxIWQuGpV4iCo9U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfX+If3XKLuTqHX
 W+NlgojNFOKIXn6GvHCko1ew9r6tvlwMT2ZsVxFDcRCynfEBVZmg0PToDHPapveuxxZgaCos0GK
 DNJlkzgZXjLavQp5+KEYBI2pG7rbl55Y4WbNYKUT+OBQEFe++hyGDHhvvp0EqaE+WrxPSuxKmRJ
 3bTg1p5CRJtXbuhfqtP3kRTTPMTW0RNNoUQbgZrDRu4rGd95tumSZyDHWKj2gwNPcabDCnYWDKb
 8gG0V4oEQkU7mWK2+R5I3oCqUArOkh3roiYp3c5N4TXeJbBjVzh4Q9QWWqAmrLB70SceV+Gh+KA
 II7nrOou9UIbhLUEXXwGxDdDGbERMAV2zUmwASKCmoSV695LeidyfuOJ1whkpxNvy4yRs8uD3m0
 JukmxrTO6JW+EyBLh/g7u1VZAJrwm4zBH9uBLovkYnj4MFHkpFME53qzjepMzGv3WhJ6cksh+Sx
 JlNJ8fQA+QZnG1Pl8Wg==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a4503f4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=pGLkceISAAAA:8 a=mpH3L83ql8VJAxoKzUcA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: r7iv_WJeQsvLzf0XsVMlm4DBJJyDuOCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

All IOMMU accesses are assumed to be user mode unless told otherwise,
i.e. we have a process_id.  In case we have a non-user mode leaf PTE
(PTE_U isn't set) and we are running in user mode, we need to throw a
fault.

This also reflects on qos-riscv-iommu tests: the tests always run in
user mode so our PTEs must have PTE_U (bit 0x10) set.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3553
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/riscv-iommu.c               | 8 ++++++++
 tests/qtest/libqos/qos-riscv-iommu.h | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 2c2273e1d2..3b165348ca 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -297,6 +297,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         G_STAGE = 1,
     } pass;
     MemTxResult ret;
+    bool pv = !!ctx->process_id;
 
     satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
     gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
@@ -470,6 +471,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Invalid PTE */
         } else if (pte & PTE_RESERVED(false)) {
             break;                /* Reserved PTE bits set */
+        } else if (!(pte & PTE_U) && !pv) {
+            /*
+             * All accesses are assumed to be User mode unless
+             * process_id is valid (pv).  In case we have a
+             * non-user mode PTE and !pv we need to fault.
+             */
+            break;
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
index 90e69a5d73..c218e9d66d 100644
--- a/tests/qtest/libqos/qos-riscv-iommu.h
+++ b/tests/qtest/libqos/qos-riscv-iommu.h
@@ -54,8 +54,8 @@
  * PTE masks for RISC-V IOMMU page tables.
  * Values match PTE_V, PTE_R, PTE_W, PTE_A, PTE_D in target/riscv/cpu_bits.h
  */
-#define QRIOMMU_NON_LEAF_PTE_MASK   0x001  /* PTE_V */
-#define QRIOMMU_LEAF_PTE_RW_MASK    0x0c7  /* V|R|W|A|D */
+#define QRIOMMU_NON_LEAF_PTE_MASK   0x011  /* PTE_V | PTE_U */
+#define QRIOMMU_LEAF_PTE_RW_MASK    0x0d7  /* V | R | W | A | D | PTE_U */
 #define QRIOMMU_PTE_PPN_MASK        0x003ffffffffffc00ull
 
 /* Address-space base offset for test tables */
-- 
2.43.0


