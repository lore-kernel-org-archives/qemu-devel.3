Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0FACC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ad-0001Na-FO; Wed, 14 Oct 2026 17:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ab-0001Mo-8q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AZ-0000hp-Sy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb0Nk905401
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rTiBfTBP7CBpYvU/NsJ6T5uh47voN7ZBXy59b9czJCM=; b=LBm3nLS3tXQhRU3W
 VGSxwi/yoxJnaWfPHi3X/sLNy/o4b5kdc6rBG3rlhiO0dz3GCI7ECTEk/fjhg+CL
 kwmzKlXQ9Wpt+GiZ51itj+ZDE/MEQ2LonfKhwlnQb23WUawsKCmOQEqEefgxV9Ya
 Sh5xrT4ImZU/Xq36BmyDgILFrHPtkAZ+bp1v7VKOHlaOukOdaRCgiiS2UuXfKXNZ
 hWctpL97SyY90tXnzFcLpAsLRT4AN1u/yLCuUnFsRqCzFTTm7mvrdA9DNQPdD1Bn
 vg0ozQr4aRGUUTKFCnu/90ZDWpzx2ALboMZXUHyCxdhAAc94NasscWiCw07COr4q
 cmErCg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p3jds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso7347526eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011950; x=1792616750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rTiBfTBP7CBpYvU/NsJ6T5uh47voN7ZBXy59b9czJCM=;
 b=Ar74/M/XXWb8BuVgBemjlkjQzvrp6fnZ7vJNZintM8hZnc/zrR1CjpFeSZhqeqGt0C
 JZRzOc2IQnyKH/IGF8rGNMC9lmB0j0lH1xXMwAHOJIPv0vQqvoEXU15D++Z0ia8qzFHC
 6SiBwa9kUzDMVHoHLURq/imHJXQ07OApABvrYPvtihP/B5ES/aKGjtI9fZsV2RoKVy0C
 RabSK1CPcJ9evOhn+wosnh7KdvbEEJem/TY39kb0IUCw8saKxb5k7E0rzErPZxBzfJtm
 b3HDIPhms2HFmv0EQSelZB+Ek8R2ZCHpBUtHhcwsAnIPkbwb1WAxBTundO/PHuOfgPf6
 eIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011950; x=1792616750;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rTiBfTBP7CBpYvU/NsJ6T5uh47voN7ZBXy59b9czJCM=;
 b=l84OPG5DqM8Dt2VKwZw/0x5RUjWgXCsS5lpc9PIRnAmkIeSI79qalbaskTQYsIkb5b
 YlvzL5cpQ1g6Zr+hCYlbESdYPQJKs3aKMl7N1QcaNBRsrQurIF1baHhh+zt18jjv1y1M
 5NG3bzNq6SmRAmGzJ9fJKDqbKejqG3IMjgeZuy8vKazoppllJ/HwtcPyv1lS90KQFhkO
 3voGyk6kL9SZAZW+9RWJq31oXwLNE2yip7PqvTRTRP8Z39KF2MPIbOFam8tFe0dE/7Ar
 TLPknw0FmWSaFis/nXKkpJzVyy+MhSdDzCzt2RP4qQBqiUVY8LOnrt6doBjYxdc9cL+S
 GweQ==
X-Gm-Message-State: AFq9FYITITcDhtwWFiS9ySdCNyeLeqjC7Ao//+UcirEVZu2Bad24woVE
 zLVBC7FvlBygY4ES/lnl/8CSdDMDQ23RjKrKCdm+p0TjR6Vi8SdK6CBuvttcdnJN/8930uZrt0r
 O+3nOmT6m/FyTiknlwA61YsHOHom92rSCP81UXAMP5Zq4b5DKssSICyLo9APnTDeK6g==
X-Gm-Gg: AYBFou0C3sAR1ujlHm/zehKQwyQ10PrGUC9ewEsmwRqFFbYbl/rIeAKCfxN+fejL0SR
 lPUBthXC3nsQiYxN68O3SU0W9BjE7YaW2IQKw/o7hnvIjoYKLXuG5NvE5HRJv8NiRX3b+dtid9r
 XUwewCTvbqphHKdQZzOOvrmo6xByJ9I9hqFPflSURnDs593qfFCMCEM6HuwZdQCRx11HFZSRHHN
 1H6N2cnH2xop18sBktqDRtpdAb+stylIai6t4MTOSj+MM/6UFU+l+ALel/5hunXClJcFmDO/0ZA
 u3Z22V+prH7WY/gEArwk8lCukTnJ9vAG4SaZFfOpIi1y3puoUFBgaY6f7Mf1INMbDIEfxQnvhur
 ZshIRPjd4IRUPswmLm622vLRejtfqfYXoBMf4t+ik/TzWWE1tokcd13T8l0in
X-Received: by 2002:a05:7301:2d2e:b0:35c:2261:8119 with SMTP id
 5a478bee46e88-35c226199dcmr8811592eec.6.1792011949622; 
 Wed, 14 Oct 2026 14:05:49 -0700 (PDT)
X-Received: by 2002:a05:7301:2d2e:b0:35c:2261:8119 with SMTP id
 5a478bee46e88-35c226199dcmr8811520eec.6.1792011947717; 
 Wed, 14 Oct 2026 14:05:47 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 04/12] hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
Date: Wed, 14 Oct 2026 21:05:18 +0000
Message-ID: <20261014210526.104215-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX+GqC8vzhVu1t
 WJlp0/VNe5EeI2ae3rgFVydzZhcwv+C7ikCHOPCs80xrqJhwGiNUnfo9HGwYWGSaQK9htQQfs4D
 ohvR8iYMFSDqvuD2oVPR5u5cw+R/I7A=
X-Proofpoint-ORIG-GUID: 3xlxYg6-VkI8CaHA7xVS0um162_q6TWX
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfeeae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=m6vfh2jtweNnR3fUmdIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX9a3+zQ1sBVM4
 scawZHdAjyGx/Ydhkc4LnfhBMm7qVqYCLOQF2VLoCMIJNnVXL1brvDCf3gHCJPPhyDAdCEAINsn
 5g2Evh8h+ThsNzN9TJv8OAlS4zy7oqa8XlYMvYXdRScBL/UkyaxvnuSL4S6TsGNtns8HVtWKjzX
 lP9+WBSwHDLPMlkI0tqXywG1s0+oFFnzzZkNk4s8MipKs6fMaiQNdIMZt3+8iHn7/U8aarKtQay
 5/9j4wk61Ok+vOckuPaU4IDIaJRDYC/zeq2tiXiX+PW0P9DXqTZ60fJ6h8p4ZPVTwXMi0PjKuC2
 SSlNk0/FFIKOrGnEY9TxoK6uhelR3FDIv/tnTaCe3ezAHUaOVJ76vKeklMBCxlbbJ8+ZHafR2Ip
 l1VVWFkw8htDYDVClce7yAKvxV+R9aDB2tQE9ez66+0iiZegzusz8zFLdJDbKbqsnCgRb8lTwkI
 EU1K6JtyXsZTtKuHg3w==
X-Proofpoint-GUID: 3xlxYg6-VkI8CaHA7xVS0um162_q6TWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

We introduce this since upcoming semihosting ops will be in the same
ifdef.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ae66f5e33e3..76801444a16 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -183,8 +183,10 @@ struct CPUClass {
     /* when system emulation is not available, this pointer is NULL */
     const struct SysemuCPUOps *sysemu_ops;
 
+#ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+#endif
 
     /*
      * Keep non-pointer data at the end to minimize holes.
-- 
2.43.0


