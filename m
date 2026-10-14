Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12CCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ae-0001O2-0x; Wed, 14 Oct 2026 17:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ac-0001NF-PR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ab-0000i0-5I
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb3IL1013191
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y4GHL/xAzbe
 dMZBqfABuxyT4McuWVL2XE4VYwvVyO/E=; b=EncATOYIpq2JeJU6HjHfJ3wzMMc
 4ldEKXVw+yXV6ZnJsrfX0xD85t4miyIXpPBnlfWvczzL8TnghOyfKxSAbRMKODtP
 ODqigWVsGZxaqSsF6ZRpcXPXZu9t4plaIGccTOMGPseAXBK9mZAeqvidaHajNE7L
 rcUdwPvJUYQjPvrPs7v8cir6URopiu96r/7UEpbDH+ovfG0LhsQAt0xqhf8j441X
 0G5KpWDLE9/QO8FmtW+MdKCAvcRBIm2rxqequfGNvlP8hJTLlVDDQlJvgbIORpYe
 Os+JWIcOTWc5RQD7amGECpGk+CgUO6gk9o5UtB8yLDuF8jQvJIPJdm9So8A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ctdw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515266f6eeso2561266eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011951; x=1792616751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y4GHL/xAzbedMZBqfABuxyT4McuWVL2XE4VYwvVyO/E=;
 b=R1NtIMeNELTAd7scEFyMq6GcCGnY7PF1ibcCKI061AGCmIXHJKgfaVesD5/8Fz2sGa
 3sYCsyRmPpxHjp8cuUejSnTcBqCpb4KkOghcY7F6FwTzl4bzhcU0frjRvd2bhTSkkzSp
 CJTM5gvObsFFcAxoY4w5Cfy//y7f9hr4EPgBBgcuSkhdBWsWGIT1ava3G425vqazsGQc
 v1J6cFyGQzg1UVJ+YbTpefpzCPE7Gd6yggmJGJlIldr+ubSyBTp73Qzjrm/fKo7FV/8b
 jobwbWPCo6zQKNXbNw6JxPb2YcJCI13KV/kHQozFrBOawTi3Xm2k2svUu4ArRWNFlAyA
 UMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011951; x=1792616751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y4GHL/xAzbedMZBqfABuxyT4McuWVL2XE4VYwvVyO/E=;
 b=wjRoAo3o82CrWGk0+RxNu4sDnXZY+g/RrvDaFCQS6sRxNTn0pZHlz38CsCbhnetSDB
 RIGDvKypJ5NeYzKXj+Cq7t86f4YzDGsD1gmmtE6/hnw1gjrNH6ozRXZ6dbhUTUe/DiJG
 GYQKPPbcCmNFtWezEgnjPxH5AJq/lSW10KabwpYbc4QiB8FAICq3Pfev2CfZZhcouc3H
 iAzdQAnoHgIAjJu6JllIRK+N1qpOmFFRsqRpoVByLHFDzvBcPZXmvtsleA7ey7FLuLcK
 r3gl1VMPhp7sgoVMeyx1h4X75bycWv6vdZJfrc1BW/aOTqCva1bKKsK7JKVDimILVToP
 KrUw==
X-Gm-Message-State: AFq9FYIq/oQaScZ6/NHN3q5v1xA0E78agJj7y0/3luuvQHm1G7kH5ZZR
 qSuiSQJV9gcv9T3LhUXimLq619ddHOozUJvl65o76sjh/pv137yuGeTTBl9QibaxVKoasDdfUKx
 LyVXZfFQ/j3q3lL2UyMl7IGoKLRssVXMjtAFrbu0bJu6dv1tykA0gcjOniYVCX8tj+A==
X-Gm-Gg: AYBFou105AZ+oi3w6O5r0zLky/XAc1sMxaDiM19Y+mJVz41p8OAgxDAIbVtpM+GTB2w
 Z49xVrWJjVtxmI4m4uwf7Fve2g6vZR4Z7Pi5VcCf1VuPmwpw9Oad+Kk1v3uPtkqJQ8pl5pFSs/8
 HqDodU0awzdul+dkb5SUJcNNfYnSdA0ur/xM9YFk/fyfRysYlEHVbvwIfe+GWI6QEgJ0wAruY9D
 GE6k/FPWl82nR0CKsN2/I9LGXlFMDIU39W/Xzw/o9xzQHO31Undc5feASNmWkx4WnFvtgrDWAq0
 KtTTw8eOWT5AZJYH2saT9IXYFVNW7jk3oKXFD8z/pMS8PSVTXHYF+emRMPx2m8Zq74CyKyRiHTC
 zQ1jPVcynvi1jrnl+a/suX1GrM26Nbe4yECOlub3F5eY7zg5VlJi4XGxeE6kT
X-Received: by 2002:a05:7301:b13:b0:35d:a0cd:e4e9 with SMTP id
 5a478bee46e88-35da0ce0d9bmr4668987eec.17.1792011951278; 
 Wed, 14 Oct 2026 14:05:51 -0700 (PDT)
X-Received: by 2002:a05:7301:b13:b0:35d:a0cd:e4e9 with SMTP id
 5a478bee46e88-35da0ce0d9bmr4668953eec.17.1792011950478; 
 Wed, 14 Oct 2026 14:05:50 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Date: Wed, 14 Oct 2026 21:05:20 +0000
Message-ID: <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX7ajx5ZW0+O29
 lxVuZno+DJIFusGOaLsKgtEYc0I69QcRKtWIiAX1HBp+IbqcrFjTyGIF0AW89RWsCY7/lRtl0vm
 OPJ7IgXQ7jVu560/tFLAA1C7W7PKOt0=
X-Proofpoint-GUID: -wOlh-s6mC6Nm14eelTFASoeiPYQy1wn
X-Proofpoint-ORIG-GUID: -wOlh-s6mC6Nm14eelTFASoeiPYQy1wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX+NipvZIA6Nt9
 3t2v3s50d22M31JJ9hUG6Rq0FORXy1iLDiVDOkZp9qpJ1VoXxFS7BgNq8+f9uIP+xY2DkTbTkI5
 VSxXzciepKmUaw0/ET6LnTPb945AKOGpyG6nDy6yCo23Yq12iO5NOUcpu3NWhxxOl1rke45igKi
 FEdHWEWcT3haOfHZ/pIvh7a63iLgQOlGIL5BxyXqg18sFawti9O4HhrEinPZaL19v1gGkkhRpPC
 yEB91BmnUZyIsBk3h8SqEdaOfu85CndVTsiHIXVSa9ZCnerVeR0fDLXiF6qO/wlcvhU33ToNusI
 zfAGy8bfNnzlaEYpRCNK/SDolppCTSLs4GQGasuocQmcDyeZvoqYZzmy+c2gCb0JxyvV7OFnpgm
 TaldReDbJoVDbTZHDvU3TmnrJvYkSMqd6kb/tYMIAyVuOPK0jD2scEgLaOACF7IHfy4e8LrbIan
 J+zGWPc3fRPYRx3D+yQ==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acfeeb0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=1_sf4qHvRHQ7HlRkUqsA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd8..00650a66dcb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
 {
     return env->misa_mxl;
 }
-- 
2.43.0


