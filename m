Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072FCCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjeB-0007if-4G; Tue, 29 Sep 2026 22:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje5-0007fG-LB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje3-00037T-Sn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPrmF1352973
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Uyi9K1Yr5qx
 +EtAnm1nQBRmF8X2hesVJ9eiErS/pGWs=; b=MBrOE2yqSADIvKZ3AQd9qye77RE
 xoDawhEEJp3synbjmx1l92V3DoldP2Qw+bo7e/WY8Lbw++VVult9+1uttDqEtuHV
 h4U/IiL6/aH7DL8K/NcNWSU5kCo4lWcw1eRtmhPovUV4anceBraMmoU+bEYlqacS
 YBbthkLOIxLANEy75/d+vFhI3LIEtXHxYsBuZfvvH1yKqnCQyhPUzXfIuCcAdi+p
 F+Ku3WQWGtRL+lfuDiDYN1EYuRp+L8/FaDlw3FuxLSjda0vBKh8uZlJd3kY5ccby
 twYrcIqpDPMlycBXMl9exasH/55yno3q99UaAMIA5SSehlTzEtwUB3ojaPQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0eswjs1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342a0e1d8c4so5194483eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733726; x=1791338526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uyi9K1Yr5qx+EtAnm1nQBRmF8X2hesVJ9eiErS/pGWs=;
 b=YuIm/2BXPBMlfQJgVD1RObO9ATrcqgU6mdLbUSvfJfR5tDVy2ea0CBeXRppfbx94Bn
 pYTMdbd0r5PSUqOFX/hA0DVsdgwe8cYcqg4OBEMoBPCwNsAyXNbjWf0wXZy4nly2S5R1
 rrCe+z0WCEjQc6GiYmF4nPoW3vUYHT0A0o+oOITJ1ICWF4pUoW4FqKdsyS0DbiBnAkiW
 Su+JMRmm1+p9xRQTm2chQvHoGADr7FLZOPznkSzuxNRt6kMnyY+DZlMmuWko0wXVpFp8
 bk832rUikdg5Sm56eCCSC3zmres2aMMgXpPfRlh1cdhzoMKdzB3kYaMeFOl5dyyAVjBF
 fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733726; x=1791338526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uyi9K1Yr5qx+EtAnm1nQBRmF8X2hesVJ9eiErS/pGWs=;
 b=JcIOUa4O6+OuwO+ymxTEz3kRNCXwNVlMse7AjzzEKIRdoVBtY/Q+GGFNQYIPBcS/x3
 sfuScBL1qSQK2meM6z1W3X2ezX1pAeG5nHNL7ZZnDMUdPAvrQTnLi6fnhg3bgmrEljoV
 L0lgHxjdKr1M67Q0X3U0ErIA/i57WVwO5hzMUFwWe87GiWD6RV14mgUMe2lOxi1u09DV
 br+B4eQeOq7i0fv/qWuDFk6vKSxRfrZnR7fk9r5tpeSY2sC1/7p+iSQ6dhQJObchBebZ
 22o+/8aSzPlPFmAre7YTKMlwBK29CDj5906jdnbKFpANIGXOW6wcIm1brPe16Ri9qfWo
 eHCw==
X-Gm-Message-State: AFuF++kg7DSqZIU75igb/8SJug+wlLeTPaqkxlawZoGduGHhHoT+SaDv
 h5aY6qJqj6Jxp1Xwonqy0wNBhv1cqMk1aTvUeRSdK/T0Yce81vhwlzo1vSZduWIyn4kN3eEA7dd
 hMWZmsKwA6fmvRFO/1Ed/KgATUHUuzjNa5Va/oWJYyG0N4IsXieTAPLggy9aeaCgKOg==
X-Gm-Gg: AYBFou2nKvc4tgRBSDDl7hyuliZ3BYMXpsds+iUTEYnadPoIh5gPNlTH0Q77409ffU7
 pULkcB0VAy9r2laRDyhlZxcAtLRcaP5Q/TopKsbNCD29C5pwEv7R1Rn/UQmcbKopT7lUUXH9vn1
 Uwb/SA6WQ5qMSBA3WJSmCOSTkyV5QE8N2PRZ4r+RCQ+aoq5gZQKGNeqalaspF6groTHaxEFeg1y
 TNKY5ZH1UhUO3a18+HTH3NAnytjPssspwSEh+9RkrUary/0dy+B6njWwoEzbl4qJq5YvyijIJtQ
 JPBIwqWWWvBWMWaBNtiETMmIzRJgufEB/0HbTHlGzY/OgYdsCi2Vy2e5b5yqGwQLTYcCQUp+BK5
 lGmy9Ky2etM+80dR9xb1tIWY/ACdn0EDc0s+OdXgLqVxRtF2ZeI9TMti4dxsi
X-Received: by 2002:a05:7300:b507:b0:340:9d9f:a5c with SMTP id
 5a478bee46e88-34cdd6907admr135606eec.36.1790733725832; 
 Tue, 29 Sep 2026 19:02:05 -0700 (PDT)
X-Received: by 2002:a05:7300:b507:b0:340:9d9f:a5c with SMTP id
 5a478bee46e88-34cdd6907admr135574eec.36.1790733725288; 
 Tue, 29 Sep 2026 19:02:05 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:02:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 18/21] target-info: add target_or1k
Date: Wed, 30 Sep 2026 02:01:05 +0000
Message-ID: <20260930020108.217892-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXwrQQGu3UDc/n
 cPGJ27JO9AKH6/AwAZADTXCjc1TJkyQYdpRpZXPkcpxXUeUomuleBINFFcnvYRVDQubBb4MZC1i
 CC3KuQZaFGoDxE7dv2S+2pGflaj7koMCEW2Uq+oHrwKvxK55gp8urjsO2Wh2Tacp3Xi8jobYtv9
 cBE9UxFqDQqFlMB+7IxAtjfaN6vdMG5DtBSrCfQTW/qkW4yr/e5vU4fAM/vWJJZ+xx8tODtWTRb
 MaCf4ifl8UVlIyK8WIEoRDx3OGM+gmRHMzL/6sqQIM+8AZltMF+SSjTfeadBdP7effK+Oil2Vk8
 bNTFD56mD5AlXyn+T9zMqnqIEskH/4qeQFa0DuOe0abCqkcyvVg19UWOgtSmMXZ3GBbt/+wLV9x
 3A8xv0Lhr2m9e4a2FNxVDdSgSe4yMFW+ioon5aSSmBH67AFndqAZVNr3v+LM9JLExxnHZZ2Q2zh
 0ehcd04jXHenUYAXZXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX+aoeq0Nhw/LG
 HskHkSwZmvEDL4rZ4vl5dZ10/C64mhsVMzbY46SWoAEXKmgzeTrpRoF4eWaOpXT4jetz/74Oxdn
 VegT0myJXNwuas6iAYaJjQ2SU1fcG0g=
X-Authority-Analysis: v=2.4 cv=LaWpeTfi c=1 sm=1 tr=0 ts=6abc6d9e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=upjuZsUD9oIM7hwv7PIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: vxGhkcpM-T-vxBc2j28Bk-buyF4slxnN
X-Proofpoint-ORIG-GUID: vxGhkcpM-T-vxBc2j28Bk-buyF4slxnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index c7b3fda3b22..adda363ac39 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -70,6 +70,13 @@ bool target_aarch64(void);
  */
 bool target_m68k(void);
 
+/**
+ * target_or1k:
+ *
+ * Returns whether the target architecture is OpenRISC 1000.
+ */
+bool target_or1k(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index f3d98998ebb..ab43c9f802c 100644
--- a/target-info.c
+++ b/target-info.c
@@ -68,6 +68,11 @@ bool target_m68k(void)
     return target_arch() == SYS_EMU_TARGET_M68K;
 }
 
+bool target_or1k(void)
+{
+    return target_arch() == SYS_EMU_TARGET_OR1K;
+}
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.43.0


