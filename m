Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B1CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQha-00019U-UH; Mon, 11 May 2026 09:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhX-00017C-6J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhU-0007fh-O1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9IQoc652833
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SLbv6MDUf+4
 G2Kgsyl41mILD1CKeErPTGKb/n1tKYdU=; b=Zd3oWNfB89qAudl6Kxd725cy+Bo
 k+sx2YC+yfQW3cltlnzTte8SUdCNerTT2i3jaCDPWAdl/zqjtcwuz2ZjbtqnURSG
 sCarJjmYDxRIcry35LGeDMyd+d5VADPzb9KGMss31v3aZw2TfGOxRWrKKAM/dr5k
 b4Neie2a6CiMmTPjnZ353SuqYl2fdUzBs4azLK1H27hcxpwsiuUSF1uYvbmPpWo8
 IlSp0/XyydfMjeZPwTtohlffH0ONgjxerBAzjQrsBFMAE8ffV3EExqd0rPBaYLJY
 zi5auHCJhwwVHLy52Jrbs6W5mzyFd7gr6BanvrnDcx25p9nQchfeZSgAHUg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xu9vng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:35 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6333021c63fso1391617137.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506175; x=1779110975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLbv6MDUf+4G2Kgsyl41mILD1CKeErPTGKb/n1tKYdU=;
 b=WLo6hVoTkEX5dZKyXw60CrDsiPMGB59ORqHxGRvDusk1CepoTOpUbkW5mEGTsIaOfk
 F6fiJGIFUAKB7HEsdDLMDCqDPnr3CQL7mBtofbvnyjTGa/qKmKxCV7MyR69eESxmpnWN
 lLAlCCxMSDE/eD4TAWHo9j1wkgiRucZu9oeXP05TgLf9pgr5caGy2mOJ76e7lBxgQa9t
 I2PBvZXG5QirEN3nGxtXhrN3Jq5aDXg7vOp522YVtNC7+3Fx6ABqYn5qwtqYiHU1rRub
 CRwISB53AakITZMUqCUuOoJuHw2YiIUSzCT3avgpY1lM25ZjXc98nDfA/xrY5iHXjqry
 In0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506175; x=1779110975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLbv6MDUf+4G2Kgsyl41mILD1CKeErPTGKb/n1tKYdU=;
 b=ZkJriPWA5wYqL68zDCwpiQQUNzaTC1/JTJWK29aCW/Gt7IAnnn1TvnWbW/G8V/wkHZ
 beui+Mz+AF/Lm8dukmULJtlNalLSdFb9ywgqs8vq/B9BsBGrVmFclVlYLDSNW8XP7/r2
 cB1zjJ0UZvfkzWxcqVr1FIP/McwIkg+AM8yVbyUNo7R0JX4IkDLvz85LyDjxmqXlAJse
 C8LrxNyL5AbxNSIOktQIU4lEpbJrM0eODMn2d2FdORvDo682YJ87K5IPIcqeifpYp6vL
 U4D8ahzZZcqSpjxjc/2DU6cOyP7x/fFqqG326hTudDMf5hTswb5+vVDMMLf40fYX1Liz
 v5Xg==
X-Gm-Message-State: AOJu0YwpAcWlMLadgmx0nqU7tJQCOVL0tp1XnvZGTCxLcf28q53lrCcZ
 AfjOjOFqO++gqxJbaJ1K9UxRkusHLwy1eMg+nSbEt2BEMPy6AnDrO/Bx2ckzy4Sjg58ogsXYLi+
 PPJZtUFoDkuVu30BL5p50lWlxYu8ultPOcUbPeeCZYLalQT2RgaMS7fPMwNN8MXzFSQ==
X-Gm-Gg: Acq92OGVOf+khbOPaKMQGMArUpcxhIRvF8a8yB2GiyB0HDuxeMKE8zvJG+ys3eZKgfs
 Id4csFvRuwbfFKenPwdL7P1PT3g8HIblBqzRKe+APW1IE9/3Ok9V297nml2zHgIAuZbbzsJR8/o
 nqxC5561uOAoVP44GNZXBlhM0QAYr3O4uziMwT1y5PldQNWZKlaM6WJrqihcZPmk7qDzZqGiAuv
 rMTbz6wqGmnkVwCL971MSJfUcGn1xlbzj1efXWtJgEIxIegvidBGA/G2/rEou60dwZJI6W11lrI
 1yLgigHaF8JY/5I9BqqfXA75RiEd5fpXTj3ZdmZSEDaiNrWTuN4bD3LpGlmIt1qOlNqRHynWwy4
 ho56w5lh0gG1bRH8SB77gxfcYArUL3LT0+izkkRNTNXomP2SGriNqPrTYD6SU
X-Received: by 2002:a05:6102:2ad5:b0:631:4580:6a4c with SMTP id
 ada2fe7eead31-63145807548mr5831612137.14.1778506174718; 
 Mon, 11 May 2026 06:29:34 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad5:b0:631:4580:6a4c with SMTP id
 ada2fe7eead31-63145807548mr5831598137.14.1778506174326; 
 Mon, 11 May 2026 06:29:34 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:33 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 09/13] target/riscv/tcg: use isa_edata_arr[] to enable max exts
Date: Mon, 11 May 2026 10:29:06 -0300
Message-ID: <20260511132910.1738069-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EcL4hvmC c=1 sm=1 tr=0 ts=6a01d9bf cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=GeI1Fvk0TT0tVSHP69sA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX5QGQjdj2/8tC
 AA6g1h+G3PgUCCD0qKd2ygv0OLFA00b10jq4xW4aGHk6xPBDnMA4rR/FPtUSmX+ItkddWEBOWB8
 KGz+5UyqqGcVmn8OiJbuXimoih7aZlFAfXPUqhGkeU+7qxCawfFwcgYklAgyi/oJjfpotpXAioU
 KHG7FcT7NTINOuMBMmxJIoJdqU6Ge4WEYIK0S6FYtW+Oh+k2wLo1q5GHTkBfXaBGrhlgYQ/NC9X
 lxaQj+xQsX28nGKkdwaeRY+fy0iXiOOomh7oR8nA/W0I3U9WK0Tzy+z4NSHK6U3wmkA2HgqQIuP
 PeV2ADCiizEwC4Ua7lgFXvxg1XJvLQpw0TZBecxdsc6XW/60BsKzBuWRf9YczRu2fFMticbkT+U
 etPvqdRxhHBfuewwPEtIuoQ4MLAVDUDGqEo/LtrpEuFWokb+CKSYQPsNHwHnVwDm/ZX9F7SuM5J
 I7cp2x6CcvUZiahv8kA==
X-Proofpoint-ORIG-GUID: UWtPH-QmvNwVYp9XB_377lBaInIZQ9-A
X-Proofpoint-GUID: UWtPH-QmvNwVYp9XB_377lBaInIZQ9-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
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

Use isa_edata_arr[] to enable all feasible extensions.  Filter
experimental and vendor extensions by checking if the riscv,isa or the
prop name starts with 'x'.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e17203dbb0..12c28f5b7a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1559,13 +1559,18 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    const RISCVCPUMultiExtConfig *prop;
+    const RISCVIsaExtData *edata;
 
     /* Enable RVG and RVV that are disabled by default */
     riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVV);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        isa_ext_update_enabled(cpu, prop->offset, true);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->name[0] == 'x'
+            || (edata->prop_name && edata->prop_name[0] == 'x')) {
+            continue;
+        }
+
+        isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
     }
 
     /*
-- 
2.43.0


