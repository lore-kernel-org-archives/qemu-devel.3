Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40013606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GhaTWSdH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d125U5Pf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3f-0004bV-9E; Sat, 24 Oct 2026 02:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3a-0004a7-M3
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3Z-0004Zo-6E
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2BlQq820226
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1DstwApy2Tx
 /NahK3NB4T6fKZZPdZHO5YLWgAb0VPOs=; b=GhaTWSdHXeadFjsgWbv2xI+JfqC
 3Z2zGONl+HSWnGQ/5PNLLC0hVr00UGnRjLDRy+c/sIXcrneHo8QZ/xVXHJzMjzjM
 R82gdO/vz0XHj3+E5Tr9HQl6hgOg2YqDhuAYuC+gK6PphakAE6VrsOol3meYJGUS
 zKG2Fs7O1ahvjFAoH0ZiSfNvsObLajGcOleqagiG+TOwEnZWkofhTGSm8PQbl9U4
 ZTa1yqpgB1dnnTurWRme87XuAS6233nmSUEKq4FUo1Yrr7CjwZVdZHrPoHmqSSQh
 WdIvxcrofiqBqEbvGRBAEYUroYvSN07SQ0InRdZE6SbcQQiKSiQnfUgyPZg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6geka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd67e98f68fso2033576a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822598; x=1793427398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1DstwApy2Tx/NahK3NB4T6fKZZPdZHO5YLWgAb0VPOs=;
 b=d125U5PfHo49bbcCSyT6U+elvF6l0TAY72ZeCDPTP1cX38YzpYx/0hyoLR8Tk7KXgu
 XlCuA9zYOTncdKGOkkesStZhG96rLdIENvryptXu6EPiCiQu92pMVAMEU3YArabgHLhF
 NOvzsjx5HHB8IGah3nkk3G8wpyG5Xrc7mydGHkmHbQjFOkJIKP1iZT2OGxlHSi2QZXMe
 lVF5Tw6vs0DccG4oXNuKikfj1TWLfHmAvgzq1hkC7s8VKIyXay5OIb0eCLvoFMFL8zUm
 M+3lZLiv54/YBzSY6XCKLd206JJ7WBT5rTwwBudAjk1+oSPyS9T18WxG7ZHWbZbLRN3q
 tsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822598; x=1793427398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1DstwApy2Tx/NahK3NB4T6fKZZPdZHO5YLWgAb0VPOs=;
 b=FLOT4ewS0cvPpTRVNSv3Ck+VODSW2KV8QefLEp8/HztS4GSLuN53ezl5cJVDsGjt4Y
 AvWDIBHeum0MdPxp2SFH9tM85m2B9PoSHTTOO7mwCb73LKs4Wt+2ZUAT6UmxcmLqORRS
 /NqrNEmPtvqKVQa7Bq0Nj3xu7MWyOPBK9MrdE4dmURBg1ax6pD7A4LGfyYyB2sxm9Q3n
 drXZBSiEAueuUnVoenYCr3Kgl+zAHAU3Aum+fS9v6mY7uxxiaRwMyzAROxfBZmCY0Ltf
 /r+Py280MewlCWfi2ezQk8JPEoa2l8pkF5BBo9MX6OyCqaYDpDHhCkmRnxcR9MXNRwHH
 Sqdw==
X-Gm-Message-State: AFq9FYJ4NGYqo7VmIEsOsVIU0YBWJYJ61Mw7qroU//DU1PrUWli7/UNx
 k26VqIPDX4cQKuEcTJIOadaD88zyUr6EEB/9fBLeo7H4DHYvxr5/K4mvtNno7ET+Tv/G9fNbOV7
 MuzRRe5qt5rn51ArYOB1NVkzC/PV0KviEdaUxgbWxUtmoyo2MhKgQOj3EuazrKJdOgQ==
X-Gm-Gg: AYBFou3Hqo67NqCMFzN0Iic6Y8Vr9j8jHul19wzPXPdtchnvKEM1n3Ksg4h7Paa/jDE
 qXUqxveN6giIAIwmUcR5iiAT2xz4dVLrXB+TNVeCmLj3hOjAzTiY+LQAo3pGxmEyXADX0QRJR8U
 /FAwGVxFs4tn7R0CzYOg+N2PrFRyR2BqhJzSw+j4xgq1Op4h7J+4uG+Pp6+/T/MdcqXl5WVI1mK
 CrMH+OtEMeWJVBwTjiTcp5IpYnn6dUt7Pz6+1hI6UJczyOUzKD5JNIZ7MPKHAz+ge9HK8uFrXrG
 aUiLhmJnNQvmbc6SbrmgzR+8jz2a7CFc+2+D8dvhtxetX+fUipxhuf94zVekGZcguycnZoIBN/a
 iQpPnTHpXpxViQ8CXSTbIzjKAnld+/NvpC5eQpepBpgdirTAm7owBsux2E+/3gLY=
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id
 98e67ed59e1d1-3ade9b2ee97mr1285379a91.1.1792822598110; 
 Fri, 23 Oct 2026 23:16:38 -0700 (PDT)
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id
 98e67ed59e1d1-3ade9b2ee97mr1285366a91.1.1792822597628; 
 Fri, 23 Oct 2026 23:16:37 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 1/9] target-info: add target_base_riscv
Date: Sat, 24 Oct 2026 06:16:07 +0000
Message-ID: <20261024061616.27381-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GaQB2tneoUR9Dr8JhaVOyWElMuHirLji
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX9prg7V3alLUP
 FkAoXLY8PgxRC2Uvo3HgIC4iKZpGKA+LKqxrj2eajeBvtJL3/isStm1GnoI3/el036Rm3rWEZAV
 AImhs6H+0UK+aGeLIzGh4UHUA6LqTGA=
X-Proofpoint-GUID: GaQB2tneoUR9Dr8JhaVOyWElMuHirLji
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adc4d47 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=c0-CPzg3BUJMhFZVEvIA:9 a=x9snwWr2DeNwDh03kgHS:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX64SBTEeE2oU3
 4qG1zkR1ZebEiymMNjtr+gaADrc8C+3i2g2kiu3dX/HMcLyQh6Bol1+oCEDowM1ZmykUWfMJpfU
 EVboriq3vdxkRdnNntaOks37kn8IzmNrFq+oQl+cIAytFFpmiF1VrTpmW1EOyDHIpUiLx3ARdjl
 LoyLuhur4Yz0X4DhjVnfzN12fHVZKxldDWOObnB8f9RRho+n7quxBSWG9Iw8ttscZLPcIegUj/x
 TJhwZMoPXEkgbxqIEd20YS5W9ruu7UsVN9qu1Uy962Os8lmw8jYU6+9qAq7GOdIHxmmngex/vdZ
 ktbqop6nB92UpSWNpLdQHtPRXfhX6auRFAQ6aoqNhpBk3hFYSge3xaD5N5tkFDZJ5HB5mIWqJac
 S/XE+AkgQOzacRKJJFZUNt0+3KfGOmXBWWkIgNjvUIiKDo+0Dcfjr58QBsfhX7s+F+G0WlPNaQ1
 7rGyovDjFy8JwAyFk2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240024
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 923c00c917c..2cd4cc5671b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -120,6 +120,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index b8a4a7ebf7a..e67d7bed520 100644
--- a/target-info.c
+++ b/target-info.c
@@ -110,6 +110,17 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_base_riscv(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.43.0


