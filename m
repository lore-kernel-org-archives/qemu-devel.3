Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CC2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4ue-0001Ge-0i; Tue, 07 Jul 2026 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wh4uc-0001G7-29
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:28:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wh4uZ-00074g-Aj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:28:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8tEb3542157
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 12:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=x+eM7xyVn3Gaa3cXI4PRrw
 a8AFuCO71E6Az4+JzqQYo=; b=ZDWazmXEyPcu1S/FSIDIg5qi5kMwtx6LRZ3Q0C
 KJnBmy5M1MU+5c2MXd7EFXy2mI74oCD3rlNJR8+qKCB4eANh4MCeuzFvasr5nXGt
 S78t2N+E+sooPQC1m19hpDUDb5weExW5iCq4PHG72jsVFKZ+8hrr2f9f05A1ODWD
 iFiUQH92yO10OSs1B/ZG+S7/pB7AcyHnahJs7hft0ZfTvEEQ0249WpyZRRC4ElgX
 ReqyQ9VkUiEChDdxY+Kl2jpG6mGIiMxBYAR9BfTN9cAEJm7H+hgS+vM/mVEJwsVT
 SQrSAJWKA9E3kme+r13DRJwT+9L7YEPM5E7E9I/bKiu4NiOw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su71wht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 12:28:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec45d9628aso94013326d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783427303; x=1784032103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x+eM7xyVn3Gaa3cXI4PRrwa8AFuCO71E6Az4+JzqQYo=;
 b=hC6GsfiosScPr6uvxePqpTjsk4/WIcIVa+s7cAPNAqOuRpGGI2r5MSqCYJumtf4x9G
 9ra/cO4btw4UPyqre3Ketr/+wgaPXdVBIA4j4SbTw4kIJVFKtM22n+GhJnTDBcxrUzQq
 pDWvKG7+BGZZk2MuaWx4km7uqKAljj298FZ/YXiecbDwXsJxiH+tBKLhZH+Nh2ZF02MN
 J7ybbYGPSCZEm9aD/TrtyLwpoUimcMElZznxjBOovInWSqt2AwyZ77ztzj6IAy1lXOlD
 p3mHuOjUafVrF2dv456YnD5pdTPD/xIDAnZVHgduy2xxsNJ04Jxd28xZPGVoKB9hJQWB
 X6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783427303; x=1784032103;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x+eM7xyVn3Gaa3cXI4PRrwa8AFuCO71E6Az4+JzqQYo=;
 b=Zq2CKVu5CR7JVUAaoh99+MtvgAhEYXsbBsXFy6KN7QXUX2xghftaaW4W2Ns9ZaOf58
 +XoQFbOFUzmDmRB2FLEDQ1UWttPvqRe1geaeQWhzEEFLJBlS9zCk3k+0D2dnWAj/yuI1
 l7rYoncIUIvufP3zxcGzVVJc1P83DeG1RA9PDx9+iFqf7D1FZgebL7FVEPMvRiYIZDz4
 DLQn8qLXiMQlXSCfb3TK/MxFPNecfZxI9gSicLe+ApmNXQ2Xlwb7h73bpoUGP90rxQLv
 c4i3AWeLxUaeVU3WOXgTfQcXyUY6eUxz74u99jzPODrGeRWqvjw5/sU/nGUyBcVANAe7
 nu0A==
X-Gm-Message-State: AOJu0Yx0eMXoGBGasdRx53fP4ER8sKpAcjhhg+91/j0+x9SuaiKARwn8
 B+PGe3eyCzGIcPh2SioPfJdsmoy3VOj6Q1zb8eZ2G1Y1vGXRM9tdEYdHRi53F4YYBu8xTOps4LN
 pQz3XBA4+sRRnh68l9y0TDbvGp2mNbX3AuvIMn4Z0WoJvaTgw2jAb4t+2xY7G7lV1Gg==
X-Gm-Gg: AfdE7cm3nXcNVrZxQkUjOcC/Hlqn2R1UYebhPhRHDusZH9CZ4Q+koZj3+fYAfoZhxFS
 mFORst960IrbR1/BdLhP2xndOYc8IpqQhYLfqEypKA34VOESI9kgAawjErGEFOOSM2jbL/0PeTm
 Kq4eZFw6ho8ounLXuzJu0qImrsvkehRg6vVQ+mgjPjbx+NrZdEoEz+qWYHj7iW+BYCD6jUjEYBH
 lP7TxfpXYkxBs+cMT8V2CbQY9dHDsqUtJUDI3vRGB2k/LvgS4uN8pqLJY/0RoGo/MGowVh0AAaU
 +WzYlw4UUSr4uiPWOJvdTUeKVxsyGLBiIn08ohvn8KALOaxGVheEmoneIgjxTZNfO6KCGepOsVN
 3QlZhZUn162+SSKwjCOoHkmKZTXwjF28TAIeuNOC0jq6z/9s=
X-Received: by 2002:a05:622a:1183:b0:51c:22c5:daf5 with SMTP id
 d75a77b69052e-51c7487fed2mr50746261cf.38.1783427302606; 
 Tue, 07 Jul 2026 05:28:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1183:b0:51c:22c5:daf5 with SMTP id
 d75a77b69052e-51c7487fed2mr50745961cf.38.1783427302055; 
 Tue, 07 Jul 2026 05:28:22 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41b281c9sm113321691cf.9.2026.07.07.05.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 05:28:21 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, daniel.barboza@oss.qualcomm.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] tcg/x86_64: declare MO_ATOM_WITHIN16 host atomicity support
Date: Tue,  7 Jul 2026 14:28:19 +0200
Message-ID: <20260707122819.114105-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyMCBTYWx0ZWRfX0amsNsLLkHzD
 kekMxj15KS6ZC0NAtDNfyIgSrhACPr5r1V1FjJ8ZEiAi519spKSLlgbKTgbBTowkzQO/r2r1xb+
 TRqYpZ2o2wua12zxGPxIs2h8fAF23x5sZDOhQF3mamteQlSA6GLbBPaDWdnF65bS6WNuWXAApnA
 s5+7lXuPLVUC9nzIgZCDgl/LLAH+7+kec5/QgzN3fnRWq0SfjLqDzmrHSKg5fuwDjR18i/MWjeN
 cuEAlpe3qi2YB/BSAHzpwMZeRWg9NdC6numBE4oA0Gp2UKhaffwhJBH80sMhqdtDGUYD0Ux/plV
 JLpUCW9nZnl9g+UwF4zP8G1h6CSwMHaevxs60A7FtcnLse5ic1eF6CSjlhkh2sHzPciebXSLW6Q
 vIXp4vYOt51vNCMgbpN7/hgtssvKL3sROx3YTadALuIlAGaznju+KFoCC3qEDa22abe+H4x6Z5W
 kjh4GCERXnUUxg5awmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyMCBTYWx0ZWRfX/FnEXftcePaU
 xmWWaE7ZkgLlSzOCPgAG7/Qa6faw2I5R8N6bku3vdNmWYIMsmnMaegP8cC3gSWqBZPsdTrMkXGg
 FhDlIYmJllhrim2qyeMa7a9K3SyAoZY=
X-Proofpoint-GUID: -LpChSPuDERXq_bYAQB5DOPVUh8snhb1
X-Proofpoint-ORIG-GUID: -LpChSPuDERXq_bYAQB5DOPVUh8snhb1
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cf0e7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=KYt7obfHf2zODsdViWAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070120
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Just like aarch64's prepare_host_addr(), x86_64 should use
MO_ATOM_WITHIN16 for the memop when it's capable. Unlike aarch64,
which needs to check a CPU feature, x86 has been capable since P6
family processors and newer (see Intel SDM Vol. 3 §11.1.1).

Since a 16-byte aligned region always fits within a 16-byte multiple
sized cache line (x86_64 implementations always have cache lines of
at least 64 bytes), then this enables riscv cpu models with Zama16b
to use the fast path, just as cpu models without Zama16b do.

Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 tcg/x86_64/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 92251f832738..99b6559eed88 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -1934,7 +1934,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         *h = x86_guest_base;
     }
     h->base = addr;
-    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
     if (tcg_use_softmmu) {
-- 
2.43.0


