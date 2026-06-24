Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F4CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9j-0007wZ-TQ; Tue, 23 Jun 2026 20:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9f-0007ln-CF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9d-0003KA-QZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK01wF1189854
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=smrgu7dCfi0
 trFw7Vp+kVKVNvhdzaDa2myQuk8ZtXAw=; b=pHSue+xyCeblrL+HwkixVy4y0y7
 BaD7qZhTTbVhh/4n0PkwSETcmp6tAIQMS18Ni6dJCFGrkNu5Hnj/MMxkifyntK0I
 uHbMLQFAUvTBCDMEZRs2sh8DZZJfolZS9iw6p9eLetstF9b/kX3xFXWh+5l8X3zV
 BkqFWedhciJXaib8mGLiGd8SbgSBJH1Jddm61sF09Cwszp6D1FooL4oUSb4R6GlN
 IM8aeLKfk2Os4156eH01b2YbjW4xnktAkzTzi01fUM5w+y9L5op5NtFCU5PXx7Rs
 AzJXygIFep7ZeqbCB7577VNLzNSe6Grg4UGzqfu0FP2ul9FUnR2HBaLmqjQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh2ex2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8deb27fb80eso7660596d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259654; x=1782864454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smrgu7dCfi0trFw7Vp+kVKVNvhdzaDa2myQuk8ZtXAw=;
 b=Anq5oyllJS3z2CtkRNX6eTIkb6i17d7xi+QlhVUsBEkTWWf4g2YuyU13SrjavREmPR
 aUKP2Z/DXOCsjspHFyFkA+qH+No9EwceOOA0u8yFiINcrIR8i03psNh/H/KupKF8Tcw8
 GqoHN4XYpDNJNdS0hzO+LuUerZwwaU7g9jgwm5q9C38u0fTRIppzXf0jvhAv2TwwmjWH
 RDRfbagSUXZlR8CNRWsFBMNiUwPcVBACVpY6kHwY1eVSDeUgZ4w8iYILmTWSOXD8kNFe
 CKSW64ACEp7VtLcAPndBabIbFZVBEBXz57uSTGiTBLtf4nwFD1M720b4e2Nfhek0hGiJ
 HMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259654; x=1782864454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=smrgu7dCfi0trFw7Vp+kVKVNvhdzaDa2myQuk8ZtXAw=;
 b=pSzB46HpNqnvWXAJc1bHebvftPCMeFNicSbfZr1n4mL13ZYPFB1vQTBOQrAblDT4EQ
 rx3rXxoihJapTsaW+sqWgUsVrZ5jNhVKPwyICT55EEhjYOr7nQj7FWAmVLODEPHgPVe9
 oVwY6+JJqyYMh1s1Yvnpbd7aXhWHz4GFEVl1Ulk8xFHZcO2roD6olKc55+EYfhTgS1JM
 Hft7g/ssl3DvCcpVN1tvZr/qJ36igHSxVJJTmWx7jCqRZK6iEl0BOB4NJ7Q0wFho1Ceo
 qSAfjH8gOD151YJUKN+44ML+BQyCl5Zg54IEbzIWvpOm7wnlYQArGIs3yl941jiiqoKZ
 zq/A==
X-Gm-Message-State: AOJu0Yw9xngAdBJ14D8Tb/sg9HPlsQITcMjc4ssrpwIjDwShVrlqAHMt
 d1uMjAUkYqniaxeRAcyR/BLDw13Fottzmvggcu+IYOhod0p6PyYe6Fa5uw371hPSQbc/UKMrlV1
 zYjLuVYppKw5tjGDPcFoa9xbpdNvYFolxTaSG2srD/B93QCtmm7E1TBN/rl3OVsR0FA==
X-Gm-Gg: AfdE7cnEpfpKk6haDCegUCZqJ2Ra0CbYT1oz+JwaZubCWECbmo7ryoOw4A8KSev7bDi
 ACUX4tsXE1cmuVdF9ai/2sHbp8jrWKMkWfROn8Uq7/daBFm7Z1DxA9rWnTY9MbMijdaTBZ6TQrl
 /E8PqJOzR1cr1hw+/MJgOESZEEPz3k3GnJs+3v+a7AAoiRaSMDWfOv19aLOPt6Ijnlb72Uq5bT1
 Tgw19SVU1OpNejaj9sFLpK/XS65Yb0a7KvE3Bvs4XSDGTkTW949/Lij14N4pbp4FWluWSGr+ZWe
 xy6f1o+E3slQQaYFV72HMPdHA2FkMPduKds8Ob4JLZUrliXRA7cXqcwQ2YH+4GRISOSEHWb9oFc
 r7Oxk+2uPrJvJmPVQ75PvnrZ3ai3kSJPwxa0a5a4fIdj88w==
X-Received: by 2002:a05:6214:4019:b0:8ca:256b:8741 with SMTP id
 6a1803df08f44-8e53543c244mr24782726d6.27.1782259654081; 
 Tue, 23 Jun 2026 17:07:34 -0700 (PDT)
X-Received: by 2002:a05:6214:4019:b0:8ca:256b:8741 with SMTP id
 6a1803df08f44-8e53543c244mr24782096d6.27.1782259653651; 
 Tue, 23 Jun 2026 17:07:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:33 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 18/24] hw/riscv/riscv_hart.c isolate tcg only bits
Date: Tue, 23 Jun 2026 21:06:25 -0300
Message-ID: <20260624000632.2149359-19-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX0InhrrXQprS/
 Ywhsdh2QjCDyh1M2Rov0PD4rWGZbYpWWLf0xRPuTSbnSqXvKyWI3So5Ig7MbgqdMclcD11SNDnl
 q/8t5nfMDGCCp/PCn1YoyhKl5BmXky+iTga0PMf5rvWN4ux0Ur9XvJbUWYpXPzZt6wY4wmSVjCz
 Q80guE0x4Wp+9DqRnHMiHIhl7/nQ+8qPbD2PTrJPoMuuFXDozB8DfUOlis4wmW8LS/BLwuSskv1
 qYT9xXYeV1cf0wF5oV1Bxh9gnDkGRaj//kop1OhhUGiIQMXU83FBgw8Y7anz1IOESgxCkhhwi9U
 lNGXjO2bE2vQEQvS+2M/Byqu0yz0RvCxLb0PNapVBEHhvjM6kJopLSr7CNgyF8qivi4EEAp36JW
 Nus4pFt68W2rlOMtBsqoVF8DNtGwhxNyX9iWMI2IV/k5fNlDOaV7kmiMXU8eOyu1GBh+vBYEM/h
 TLike8Mh28+GSZJ/VuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX0g55rHRN1w62
 2YfGOPMQndV6/sJMRqI/f5B/OPbBFbdFNaF4bf2cGg/mngQ/LfC5GjCL6kEZf4hKyxCes9Blrsb
 V1UvyELd9JPutSVliWwYYvvTvhvp7ZQ=
X-Proofpoint-GUID: l21mtn-Ub4011kdL2-VuByrs1Gx0lS0q
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3b1fc6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=0nQI16K_ZF54athspwIA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: l21mtn-Ub4011kdL2-VuByrs1Gx0lS0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
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

riscv_cpu_register_csr_qtest_callback(), vcsr_call() and
csr_qtest_callback() are all TCG only and are not available in
--disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


