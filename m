Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78684CD484C
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdpB-0005ta-CL; Mon, 11 May 2026 23:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdp9-0005s8-LX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdp6-0000Y9-0X
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:23 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6pju2803821
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q8REKvSFtj4
 IRZPkQohA+tsKab0FLF08n8eyKxISp+k=; b=d7iL+qU0gu8vnqSUZjJAX3BUWpt
 ssWldfqwzobU3Gq1Puj/gaa9/rdoY/OYtMh618rPGS6w912sGBvp/vZIyIEGmj2o
 AwvMI2kW68enxKhArBKDc7kLb817+T5WHrCLN3a3Q67kg1AHNhBqbWn5pX9FdiXa
 4EQydjK4nPA4YhhxFYbbIjmLtD3kV6aewD2U0FhYRA7UZi+KdzCEu1l+mQe/uvJT
 5KXhMTyzaXq40xJdR+w020w9vgYlDaUECv+9E22l3gnd/DBYhQQq3sfudjjc1Xr2
 ruDjbihsnrQotzWL7vn47a6YTNVD1EznnPURImJqRshxNaP0l7bsoHF9HQA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv399p7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:30:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2efc342ef15so7054536eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556607; x=1779161407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8REKvSFtj4IRZPkQohA+tsKab0FLF08n8eyKxISp+k=;
 b=K57Y63jZ76RYZLWJI35HsGGDRhqXvoFKZ5JurM+D8fBOxWKbAF4T9AzrFoP9qmVwls
 KQF7DzN+EPNtQ1W+bPFAGArpjzW6S1g63UXII48/I8TTVesD1XMFlcJvjcpOx77agXdR
 kpzI+ou5RvTavJ2CELurgdCqT51a+H2tJuskFejKcbgovuTnn/D9DaP664qL1Z4x2ZwJ
 5WPoUMgVOtI/rAg1ZuQfJvGg21DuL3AspeHMh7pBvO8EFCA/IG7U1R2Vyg+bvRW1uLRF
 LMFqNN6mDMp8GyqrcHWztfb7MrU1p8AM2Z0nhgdLPUcdu6BE0pxOLUrTksVJjlqDIcQI
 uevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556607; x=1779161407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8REKvSFtj4IRZPkQohA+tsKab0FLF08n8eyKxISp+k=;
 b=lXDmLasjmBabkf6GwbiXHEV7+Cf/DuUYZcpvEAGGvhSzklaxrA4svPaapuxJZ7bRFq
 F/IUye1PYgaCi8k8AdASxTITI6FgXSG6yxOtYhD4drTknhYVbp3keFCDvmJ0dzka5CYs
 Tqm/nXmUgOkzLRirt58e+McAkc/2FAA5+tB4o+eGUAviOfIxY/Grs+A8Xf83vWtf9ocy
 hsf8j+BsutW2gGWLTFaSuw3INWn2fA5CS76k1nUlIqHWOOSNjXEFWdggakmrYn2ZrD+7
 S1CUvYKe5NHiWQ949MurmLLf6AytG5Ngg6BBhWsEmRxEXbMaIpbwfeKgZ74pWq9Qobsm
 aJkA==
X-Gm-Message-State: AOJu0Yxtvf9clhBOfb/t1CFLSWLVPnPc/4JzlelYGLZFJ7M/4d4S3916
 U84att+71KSwoP+i4LKtOjQyXSXUStzUpWKulyzeU+KiPo900RfGU2IN5R/3aaAj9YtT4zJvmp2
 rut3HyVsiNNdrfBUczK7m7AZhCKn3fTceBjZRQmBIg9xHhvDSqqgymttRtRSs1PQOMg==
X-Gm-Gg: Acq92OFSgSmVfIpXyeVwAmnp8kG2mX0sWdML9NhBgfWtIubAyQ82dYK89Jhsb/mipN9
 r+b3ZKlHbVnf4UWcaGwLLFL8U0PMJS6HD4ldpi0GcvRqS+SqVvUZnQvJM0KepRdo/th0kSxQQwM
 aTCmhFZDHtVL8AtS8FIGd6AoBmKKclNaFD/9F6IuDglbNM/ZovDinGvwkzbN53e7W/zYHsiGYVe
 wc/4tyiANdasuTb6DMgJwTFf5GwaCCXKLSjyELn8QL8wChQvFA0I7oApW0rc89WqWRInVu1+KAy
 arc0Nkx6Pp7mbQi0UXVOjiNMflSA8r3K25GCnhYvPXKP4qf1nKhfe3O00hlQOgGTHssM6g1TH3f
 Ssc25V8IvAoZ8FaviVA9nvIHbw302hYLC7MjZt99SSX9l/f3GVwb80ieICIQG
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-2f54c587faemr13365213eec.15.1778556606539; 
 Mon, 11 May 2026 20:30:06 -0700 (PDT)
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-2f54c587faemr13365188eec.15.1778556605868; 
 Mon, 11 May 2026 20:30:05 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:30:05 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 14/14] target/riscv/cpu: remove riscv_cpu_* arrays
Date: Tue, 12 May 2026 00:29:26 -0300
Message-ID: <20260512032926.1978818-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfXwndfBQfIpKnv
 RYQyF6TVQ6k++ULSzeEMYX2DriBAZiCzEoMxQS00mDAs7MyPMEH/yBqCBKG5MVKDlR14we0sqsn
 2Ow2f+dHNK7+qivSAOZDBkwCbb/R9YF0SAjx87ekHp5GmObhF1o/tnbWd9dt15JEEZwwEQpu9M1
 ygB02kjkckKHnGLucmCjb5yGZ1GpYtWscrJFA+BhkdRFEAM7eITlJ6mXNIssuwDFyNraRwjc/Qv
 FRcOD4H6RUNNafO2qR9H9X7MQLDZrciT4xpubF+LWGmsEb0+qABfS7zflwgLQ4SLQux1FaTc2II
 642kMZ+dOIJtDqoNJraEh3VtfljGJJmryL9kS+rT94CWcvIcj3Uv4HQfp16ZKFe8jLWqaKaFlYo
 idecV2ztFZct1ioBghT6YehmKyzADWNkU70FEE6QUK5bi3L+XtUsFBqePtPsQVm1qLJ/hQW+U0x
 Dw8YXmQgH+FbdptGk/Q==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a029ebf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xkx7_DFI7zyQbJe41r0A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: LYaAhQM7H9ePsz-MeeqF2RG4SoFTaK1a
X-Proofpoint-GUID: LYaAhQM7H9ePsz-MeeqF2RG4SoFTaK1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

There is no more uses left for these arrays. isa_edata_arr[] is doing
everything we need, making our lives a little easier when adding new
extensions.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 159 ---------------------------------------------
 target/riscv/cpu.h |  10 ---
 2 files changed, 169 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6dd05597e8..67452bb964 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1248,165 +1248,6 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
     return val;
 }
 
-#define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
-    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
-     .enabled = _defval}
-
-const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
-    /* Defaults for standard extensions */
-    MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
-    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
-    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
-    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
-    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
-    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
-    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
-    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
-    MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
-    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
-    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
-    MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
-    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
-    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
-    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
-    MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
-    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
-    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
-    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
-    MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, false),
-    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
-    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
-    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
-    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
-    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
-    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
-    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
-    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
-    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
-    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
-    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
-    MULTI_EXT_CFG_BOOL("zvfbfa", ext_zvfbfa, false),
-    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
-    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
-    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
-    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
-    MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
-    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
-    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
-    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
-
-    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
-    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
-    MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
-    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
-    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
-    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
-    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
-    MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
-    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-    MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
-    MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-    MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
-    MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
-    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
-    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
-
-    MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
-    MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
-    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
-
-    MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
-    MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
-    MULTI_EXT_CFG_BOOL("zbc", ext_zbc, true),
-    MULTI_EXT_CFG_BOOL("zbkb", ext_zbkb, false),
-    MULTI_EXT_CFG_BOOL("zbkc", ext_zbkc, false),
-    MULTI_EXT_CFG_BOOL("zbkx", ext_zbkx, false),
-    MULTI_EXT_CFG_BOOL("zbs", ext_zbs, true),
-    MULTI_EXT_CFG_BOOL("zk", ext_zk, false),
-    MULTI_EXT_CFG_BOOL("zkn", ext_zkn, false),
-    MULTI_EXT_CFG_BOOL("zknd", ext_zknd, false),
-    MULTI_EXT_CFG_BOOL("zkne", ext_zkne, false),
-    MULTI_EXT_CFG_BOOL("zknh", ext_zknh, false),
-    MULTI_EXT_CFG_BOOL("zkr", ext_zkr, false),
-    MULTI_EXT_CFG_BOOL("zks", ext_zks, false),
-    MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
-    MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
-    MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
-    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
-
-    MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
-    MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
-    MULTI_EXT_CFG_BOOL("zhinx", ext_zhinx, false),
-    MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
-
-    MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
-    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
-    MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
-
-    MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
-
-    MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
-    MULTI_EXT_CFG_BOOL("zcb", ext_zcb, false),
-    MULTI_EXT_CFG_BOOL("zcd", ext_zcd, false),
-    MULTI_EXT_CFG_BOOL("zce", ext_zce, false),
-    MULTI_EXT_CFG_BOOL("zcf", ext_zcf, false),
-    MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
-    MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
-    MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
-    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
-
-    /* Vector cryptography extensions */
-    MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
-    MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
-    MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
-    MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
-    MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-    MULTI_EXT_CFG_BOOL("zvknhb", ext_zvknhb, false),
-    MULTI_EXT_CFG_BOOL("zvksed", ext_zvksed, false),
-    MULTI_EXT_CFG_BOOL("zvksh", ext_zvksh, false),
-    MULTI_EXT_CFG_BOOL("zvkt", ext_zvkt, false),
-    MULTI_EXT_CFG_BOOL("zvkn", ext_zvkn, false),
-    MULTI_EXT_CFG_BOOL("zvknc", ext_zvknc, false),
-    MULTI_EXT_CFG_BOOL("zvkng", ext_zvkng, false),
-    MULTI_EXT_CFG_BOOL("zvks", ext_zvks, false),
-    MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
-    MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
-
-    { },
-};
-
-const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
-    MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
-    MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
-    MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
-    MULTI_EXT_CFG_BOOL("xtheadcmo", ext_xtheadcmo, false),
-    MULTI_EXT_CFG_BOOL("xtheadcondmov", ext_xtheadcondmov, false),
-    MULTI_EXT_CFG_BOOL("xtheadfmemidx", ext_xtheadfmemidx, false),
-    MULTI_EXT_CFG_BOOL("xtheadfmv", ext_xtheadfmv, false),
-    MULTI_EXT_CFG_BOOL("xtheadmac", ext_xtheadmac, false),
-    MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
-    MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
-    MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
-    MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
-    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
-    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
-    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
-    MULTI_EXT_CFG_BOOL("xlrbr", ext_xlrbr, false),
-
-    { },
-};
-
-/* These are experimental so mark with 'x-' */
-const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 46bc29d307..3a91fe5f91 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -983,16 +983,6 @@ bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 bool riscv_cpu_is_vendor(Object *cpu_obj);
 
-typedef struct RISCVCPUMultiExtConfig {
-    const char *name;
-    uint32_t offset;
-    bool enabled;
-} RISCVCPUMultiExtConfig;
-
-extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
-
 typedef struct isa_ext_data {
     const char *name;
     const char *prop_name;
-- 
2.43.0


