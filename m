Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E9CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 12:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNVGE-0005C0-W8; Thu, 14 May 2026 08:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNVGD-0005BQ-3b
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:33:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNVGB-0004jq-3u
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:33:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBec3V1718027
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Wctl4BwUPge1tJQU3XWTCVR5iC55iDPZiBc
 +EacU26k=; b=PdEj0UvAQHZYYxqk2cp83ViAoFQm+gxvgtcqA8v+v2Ur91t3T5b
 k1wop0Ojwe2EUriFZbFSsUb3ARNekI7I/eFIishv9OBS8g+lLBx5+fU7OP2q1SXY
 lrZ+EPQ1OnyYLxdTYgDF2YMHORQfQaZv+xtSpR5T/MuEIVqo8JwMWrR6hdwwp/ph
 ys0EliR824/ewwRlZ6bh+JN7XGOUSQQ6FRq6yUEYvHZpxHHpYorEO9p+z1FScb1y
 KCvFU2t0FJi9+FtoHKi/yAhW4i1PqyFR8f3R7mDY3goQEe20tupwCfTr22YJaxgg
 QzW376AAJAiguMxHz3xOgJ/Hnm0mDbHB+Yg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7hf5q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:33:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ba8a1f3dd7so94638986d6.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778762028; x=1779366828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wctl4BwUPge1tJQU3XWTCVR5iC55iDPZiBc+EacU26k=;
 b=L4s3mdLi47qas8lxycYz5WHWu2//TglBdbbOQ+CLHiaGtosPzjweVeYdPXqBCtyQzO
 S02cC56Cq/1bFhnG3y+OxEW2mvOhKYpCuwWosxGSJdM6zS4sFlB87tdXyfARHqZnp3An
 /bgeKMeEls/yH1KBAkBOROsy+cMDBIkft2NjPBNjbc3MUkdlfmOzXPPzHgzWkxbJVS1Z
 4sE6wspLYzpRhmGex113aIvmlzuRKHk1GjOI97I0RR23mE56lptfOAn4rEjRi2Wbruj1
 YD6zZI+oJYM2MPLRF5PMWHIpstXn08MtYOo9p6yEOrh1uIDlt/JeX1zdtfq9Fa3zxFOS
 M40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762028; x=1779366828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wctl4BwUPge1tJQU3XWTCVR5iC55iDPZiBc+EacU26k=;
 b=cP9GERfo+ULRXWABHNl61lvILAzXd8HijwMOLM95a7Gych78nqsvg+6+3sKJMzhHAo
 IEKZJcykCwXkBqcdSqai0X2QseWaGwLebLv8etr8CK9R3LL6kcESxA4LIFJkgyfRpM9Q
 ZkP88hBtkKP3cT2qlzvjfnWiprXWOneqsChGvCYeLmbQnQ5/pIYXZA5rfLBZTQckTxcC
 W9gBIfvuE22OYZrWcf0VnNE5VLs2aPO5iZOU7PMrQ4PQXrzXtLDTLFQUQLPEJDFZXmDx
 wjtsxs8Pt/2ZRfP+6msPLK/NgCQ5wy1TAeucn3LCA6xuYTCosGgnDBqb//d7j03YGtdQ
 iscQ==
X-Gm-Message-State: AOJu0Yz0D8ntUIOJEEq+Jr3RKix6fSXrlHiUBNSVS9as1SX5zlGpG8E5
 dKlK6o/u29v2LzjOdJatFPr6LxKB1GhUO/Bmwaz+vsSo6oQvWap4ifrdSM34ChaYn49NOTPD1p/
 RRZsSAxj3KqSZt0umqCTmqeyLhz/iZ6HkPZg7L3zdgQlJdeQe1AMs4b14UCWk+Q4Qdg==
X-Gm-Gg: Acq92OFqSpXU94fz50FaZcTSF/8tYT0BKkTeTdvVIQL3DhAAQhY5lgm8YhK+rSpMwwc
 akQ3+SQJk5k8gRhkYKnBSoAMlplgW8WSKd7RtLoRFB+V5ld7S2JYM6kdK9D5KsbSQU1xSM0Y17A
 h81PcKLRmt7q3vP7yH/uXW+by5pspfiFv5ivK/mhrqDAoXFfoGn+/MfBtqzK5uze1oMOHkEn+Mp
 uwA10uND33fCUa4qGgkJCmMw66o/xFDAF7oyU1X9qCq3YmBEsxxoafQA7MgDjw7nKuqirPwEtKs
 Dwl/sD3ODeDU5kHSA4QcRilr3PoRMUBHD45HVDoCageEiblaAD31Hg3NQO18jYLXs4VNFjwFBiZ
 21Op+Eu292LNSligMsh2pGmL4ztVkzHWZDbDUSKqJArcdx9hz0MtUZbVVQWgNOxnqqSQKEWju6C
 Oa5GrQo3yGnVkZkiS/wULcKNQ=
X-Received: by 2002:a05:6214:27ca:b0:8a5:104b:e37b with SMTP id
 6a1803df08f44-8c7bc43c53fmr125848836d6.42.1778762027839; 
 Thu, 14 May 2026 05:33:47 -0700 (PDT)
X-Received: by 2002:a05:6214:27ca:b0:8a5:104b:e37b with SMTP id
 6a1803df08f44-8c7bc43c53fmr125848196d6.42.1778762027347; 
 Thu, 14 May 2026 05:33:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (177.206.20.52.dynamic.adsl.gvt.net.br. [177.206.20.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90bb82a92sm22162326d6.36.2026.05.14.05.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 05:33:46 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
Date: Thu, 14 May 2026 09:33:42 -0300
Message-ID: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kKC4cIdRvv9DvhyRrzJjNBlQ06VTNP25
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a05c12c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C35wqYyY/cHT4Uyl1WiZ6A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=aJVLpm4QXBLpFYt03AsA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: kKC4cIdRvv9DvhyRrzJjNBlQ06VTNP25
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNSBTYWx0ZWRfX2oRXEeDD088K
 zdXGDwPX8lsxcd0q1pZQDfJMb2erE2BSFmlrXyiSC2+V7DRU3FVLKl668WvtxiWdNIQp0xZWOVc
 mzYPrBOlYfSrt8/1H9xTVH6wZijuScNvAhjTDFkGd3GQ/FcTKCIS/v/JTTHmzGX+1skXn823/n2
 d0aPRL3Vu59aMHSr4cVcXpUF43hGDKZ1qn2IMfcYxPMzNM6MQIBULhQl0083YEJFYlGooCTAvJP
 VJ46DaZVcVpxMXHKYw9LUNLCFI8asxwylSFw7gbaYw7FCq0+k+fk57wDDn3mu2NOlUXLIXb+S/Y
 HPva8giEhXX0VAKFpzEersJkDSD7GBQqni6XycT5u9VYENO212os5bUpugM4ZIWAWauSVR+CXr7
 1lYHT8YJ3oRxq2laNS45uZsJZbXDANDhNP/OACXCMifGfKYf5XFPkHLOUxlV4JK0FEuPngH8owx
 oyrP9QEitSsMq3sSR4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The priv spec defines, for RV64, that the upper 10 bits of
pmpaddr0-pmpaddr63 are WARL and are supposed to be cleared.

After this patch, using the bug reproducer in [1], writing
ffffffffffffffff in pmpaddr0 and reading it back now results in
003fffffffffffff.  Here's the 'diff -cp' dump before and after
this change:

*************** IN:
*** 5272,5278 ****
   pmpcfg10 0000000000000000
   pmpcfg12 0000000000000000
   pmpcfg14 0000000000000000
!  pmpaddr0 ffffffffffffffff
   pmpaddr1 0000000000000000
   pmpaddr2 0000000000000000
   pmpaddr3 0000000000000000
--- 5545,5551 ----
   pmpcfg10 0000000000000000
   pmpcfg12 0000000000000000
   pmpcfg14 0000000000000000
!  pmpaddr0 003fffffffffffff
   pmpaddr1 0000000000000000
   pmpaddr2 0000000000000000
   pmpaddr3 0000000000000000

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3362

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3362
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/csr.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1cd4a299c..476a620035 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5362,6 +5362,23 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
     *val = pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
+
+    /*
+     * For RV64, bits 54-63 of the address registers
+     * PMPAADDR(0-63) is a WARL zero field (priv spec,
+     * section "Physical Memory Protection CSRs").
+     *
+     * We'll have to add an annoying TARGET_RISCV64 gate
+     * here to avoid complaints about masking bits 0-53
+     * of a potential 32 bit target_ulong '*var'.
+     */
+#ifdef TARGET_RISCV64
+    if (env->misa_mxl == MXL_RV64
+        && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
+        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
+        *val &= read_mask;
+    }
+#endif
     return RISCV_EXCP_NONE;
 }
 
-- 
2.43.0


