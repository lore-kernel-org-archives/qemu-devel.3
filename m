Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19036C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHq7-0002pg-1V; Thu, 02 Jul 2026 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHq4-0002mS-Lv
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHq2-0008Ez-Vt
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0aW1539026
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XbPNXFloQM3
 dUvPD21224Iu0dG812ZdobBoG6oZrg1g=; b=fTCdW9h+vlzFjotbIcLfFQPzsNj
 sKIiTPqB44PXTSh7kt1dMcWNRGdmbvgTGN1uzc54TjulSq+E5YiuvkE7H+v8FgSk
 Qk5p9tkwSgo7UUImsmvyITo3D1kUqZ+rZnrp/9/+7j2RoX6VMEPIpWeCufEoYNcn
 kBUp/qbhlhIZHMV/4Z2iPav4j4pHmORr9dwwEuf7u89k/plhqAlHi/rtA1cxY3Fo
 mlDSJtRW+oqCrjmueA7fs3XkYCcGCdAKKqoExZleUO92yGJVQEJ6NR4kFN8hMF4x
 KMPSujJUZv35yiDj4Am5OqELFgxA2GPnn2Mey4/7lN11kmp9EvOjueb3vcA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvws4y6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:21 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6751db2792dso867125137.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000341; x=1783605141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbPNXFloQM3dUvPD21224Iu0dG812ZdobBoG6oZrg1g=;
 b=Pp4NlB3ok5eWYtSWZPkNg+PkEGxcL2dTvPOBNVzGBne++1lET2gd7Fpx1XRMdrB4n5
 I5vBIx5JNLdDOf0tz7LdCLb6bTYsEOAb/5zecd4+zF6EapiUp/JN5NtKJfyoSMRaq5Qk
 PDA6PQvU8G19kdQ1d8m96am1STRCaGm5rlEb8a7c6hewr4ZMPTZ56pEuBzzobY0fSxw8
 FuR3vuxBuwhahe9UB+5j8fuO9Imj2hnIk0SBa0GneAclm09wBxRsiruBgG+Xl6f2Es4L
 P67TgaWzdY1p2fWput+o5bXc3rm3HCGT+PFbbCZ0kpBT+VXYc5V8WWNlb65hA0bVciJz
 V2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000341; x=1783605141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XbPNXFloQM3dUvPD21224Iu0dG812ZdobBoG6oZrg1g=;
 b=jjbbgKPkP6FmZah3byu0/qOz/7tOOp4UH7B/ZgXbl9yW7cFccYF/ZaCdZrrcQZnPWl
 Vh+jHsuHQ8Bs28ySfYhDvmdva1O2X0EHCG/28evPpCOKyop5omk+6p5wbeACsp6Tshpa
 TXwSb3bjBVSjatbbb70S/SKFc4XcSgp3b8KC5JV3gjcFNH5nCErN9OTOvsHnBB+XGl8g
 HmVySVxZGjlQ2V7AfXAOU/c6FZdo56GUe/ciddTL2Y+LUDAiU1ecUlR02dEhfV+SRUzx
 TjNIkysWQTRuVd9YiILgCsasKp/XSnWTvcv5qMZOdgfy55cSGRExucwlvsu73f40O+xn
 Kl0w==
X-Gm-Message-State: AOJu0YxPeSRI8a9AQjcLi222IxDagWBco9l/HN0YNDr2hQqRyUKaOKgS
 bglbPAgEFVC8cY6vlwILpVtgQ5muHISCGVUbP1vS8tqMnxXfO/eKKM1r4N801ZS75rQtAJwXnDp
 G1U490kLweTf9MJim0eEcaEH+nAhO49v9/zYVkmxCibLa6ttfmzWesWuANp1HjkEftQ==
X-Gm-Gg: AfdE7clMUu0QQSvwdZawr9g4fAa/cMpkK4k0TioV7+J8O/gyc+q0l5Hde0GAvzUYfVk
 ZgeqCsogMWNFn4JykFiJY76IWX1TynDEOpzHmrYnasWT1E8MqI1N0X8TOFMmWmVl5f/u2ZixxWv
 rn5quLFfC2rx6vLqTOLUtcmBsvu0Zduxko10i+g38l+wzy9QmKZI7fOo7FXrzijvdrldufnUjoV
 r5NoBo/1KJmW6xtBYw5dt62xAbG7cMhMLfCP/g8wCPjFOxhiyeG62oEuI1anYeqxdZoyehMBFsU
 YbYjHOlaxVavTiMMS0JVlLnhXdRsiaxtA/1ApNV0hWvh1LGHcVxLRzzc63t0B12SwLjvJipu5+X
 vOj1pObw6/AFY4VXH3CURAeVg9J1HBrg8UhWh1X65MCeVFQ==
X-Received: by 2002:a05:6102:5a8a:b0:738:9c79:7506 with SMTP id
 ada2fe7eead31-73da7f097f4mr2264258137.7.1783000340584; 
 Thu, 02 Jul 2026 06:52:20 -0700 (PDT)
X-Received: by 2002:a05:6102:5a8a:b0:738:9c79:7506 with SMTP id
 ada2fe7eead31-73da7f097f4mr2264244137.7.1783000340185; 
 Thu, 02 Jul 2026 06:52:20 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:19 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 18/24] hw/riscv/riscv_hart.c isolate tcg only bits
Date: Thu,  2 Jul 2026 10:51:20 -0300
Message-ID: <20260702135128.1188021-19-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EWtn_D0ZvoOVAxCTM5ghewv8gjE_X-PY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX9bJ3GiuCrqbj
 eyLCzQymXhrpSlY0zuQOJwcFZTHIDj0aenfDsGHEV546AVtDXM+sNLOwFmrry1JCSGeKqv6yKGt
 bFbTpb9kUsC+sLdDDZ3Xb4oZYH2Bsy1rsnw6nad2AmMtvrlVzBw/JZVPGzP+FYfs2eLvpeG28Hl
 NIbnKUooJ1lbuuxvUsWjky4Vhs3uj5/mgnEoIX4EYYHCVL46l6iIWutwsiQw8Wj74mM493R5Y9d
 aquMpV0C+vaElkQMpdJJoNJ4Hc0fTyM1QdaGOd2eCyZzAEm//mAUdMiyKyDybME6eBISAP5i3xA
 ypU9reO0goWk/WNYjmHi/9vLEILHic7c1uOUOC8rTyz+zS+CUtlw67HVhm6zuA1LlqFsrxbgliJ
 Zr2eO9fg87iyci9BqeilS3Fn5Kib5TdGtQQY0soq2j8Z6s1OKOFN/aIXeB4TT1wPPxw6l3EmWgT
 /8f6wzDKIu+yD849OqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX3vsGJC7zm6+t
 1vEMPd54V761r6sW1QgDl6QVkjEPsjNGTBJnCa1Yv22gDUyMYrC4/az69slO0Er7KygpbvKS5k4
 wN65MuexKffu0h4yhRoykfHq4D4GKKk=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a466d15 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=0nQI16K_ZF54athspwIA:9 a=crWF4MFLhNY0qMRaF8an:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: EWtn_D0ZvoOVAxCTM5ghewv8gjE_X-PY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
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

riscv_cpu_register_csr_qtest_callback(), vcsr_call() and
csr_qtest_callback() are all TCG only and are not available in
--disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv_hart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index d1c7188369..747754be61 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -61,7 +61,7 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
@@ -151,8 +151,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
-#ifndef CONFIG_USER_ONLY
-    riscv_cpu_register_csr_qtest_callback();
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    if (qtest_enabled()) {
+        riscv_cpu_register_csr_qtest_callback();
+    }
 #endif
 
     for (n = 0; n < s->num_harts; n++) {
-- 
2.43.0


