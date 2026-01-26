Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C896D1951B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkVAs-00049B-HV; Mon, 26 Jan 2026 17:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vkVAr-00047E-7o
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:35:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vkVAp-0005Ho-Oc
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:35:08 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QKi0Ql3387170
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=iSEf8o8q9iPjVwgM+QvjtfNuwWwxOlF0rxM
 G95GijoQ=; b=MMX9VQDYUpLZa42/fO66yVxG3qVwGZCfBiUUQRq8oMnCudQTixi
 +WgNK1fUpI3j/OedypmWfS/3BozoMtJqt4ctrwO65Vj6dHIsC4Q5iesm4N9qYb+1
 xi7hvCHXirY90s8lQZkUppGukMvwUs3xwQjbYPWzIHUfhcIJwkvCGufU0L8V/dws
 BZY/ZvEqsgjPlo6kn7MFV5WKpFeN3x6aTYXPE+1vfokJrpUy2Onc4OyJUx0VM2wU
 rLcO36LHp58rwn23w0sACvx0XFsxuwrskFhQQJnAHrLG9vaBNIuMeKVc3mKFDxgV
 X7J0IeiJArQ8Y/uLWr0LqbfhBsV6v6A2Ilg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a0aft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:35:06 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-40450320b4fso8284949fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769466905; x=1770071705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iSEf8o8q9iPjVwgM+QvjtfNuwWwxOlF0rxMG95GijoQ=;
 b=COCG6J6iefFh2dGVHWZO4jBRGHN6J0k2ZBUUMWI43idFyDCovRqUjN9oGY+5Pln3Bl
 Bos8iQA04IOjMAB5DRizbdeJrXMG0fIK7GxWciqJGf16BzuNa55S4VstS256THJ2zy1i
 Zz6TN15Dru+SimG4IttlbGLZN8gWaP9JuDa+yqslYKwpEaNpLSV82Y6zuidnxm3g9des
 fxX7/SlcniJfWKwaKDuDRECSk7FGyqZN5bmiBwLf1afsv489Bd/j1dB4umwkWg1SCaT1
 U+juvd64uEQStG7Fp9i67QloD6V5lGKIJvQYYvQ86vrw+rMxutr1eKglLY+guLaL4/5J
 /tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769466905; x=1770071705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSEf8o8q9iPjVwgM+QvjtfNuwWwxOlF0rxMG95GijoQ=;
 b=MqCxEU/PNm2FNDC2HbArBiBCMFQyiM2rL/Tr3Rxp0x4Sjp2RFM+SyaviUA7k9sLhCP
 PkCHfTRIzioR1B5vkolR9grM5yknvaLFXYFGEu8yGaGhVQdzpxGsSmnCUFEYZT0UAVv3
 OHWAOrLiN0VePl1Gja2a5uvinOL5nPNYiivbhZwyjgaoB2uW2y0XpHRKFGsGBXKLFF9R
 cLKZKXs7SXukkBSE4n4qpUamSZnkS4iF5EBUamHIH/iGdyxe/4DlcHfYlrsk8+LxdyEM
 it9Kjn8p8Fv6fFjRDmCHOgoq9pvP8BTo41wNhvULuj67WnSjKEfO/xvGHzD5R6CEnfyO
 /ZJg==
X-Gm-Message-State: AOJu0YzqKHhPxZ4urDUxoex1L0awupU/xButMtPwOJZed7b+vr5Qd094
 JRq4e49V+p/pvMfqSz7lzXnD4ICXT7kqsmS8birgdvtwmyW9a9s9X6VlktEEJTaCEzma4YruuCi
 QBH/0agZCze+B9IZjmtRJKZeqRss9w5YAGCE/itKHj6+wZzA//LojyhNp5CKMBMkofmmS
X-Gm-Gg: AZuq6aIRTD5NY0KM+hL6aADD8Zssp/RCpyN8b9MhAzipZAFDnCBw2tvuJUb8MQ3Ed8o
 D0qIbY8s6ewi5eaeSCnmfpkSsf1x7eXZp17yELX9SH9GRrMYP5PAeXokWoXB1kY6+MTHjNq7uqg
 2k8BND4kGoc8CSgYjqMmQJCtWq8kK9JBBzUzzeAgg1vkLzzC7IBIXwbES6tRhGYwNIpWAPNeKCg
 EZBxJd9NX5VOKHAAKLwvvP7+aczDynJVAYz1ze0pZG4sK+WPWoXygG/3vC8yj4m7dpfQhx4QozD
 wdX0Zmjt6BqE+D11HM3tbddpeKPVxAlXolkD/y55pDa2E3TZeiQEsDYa/QvxXPMCS00qmPTRJ8i
 U3PfApoxBHTiORPb2QbB60+CyyprpgrhpTOuJYAQozrXBjw1b8IkXZnoJWowP/7hHb2PC
X-Received: by 2002:a05:6870:17a2:b0:3e3:6b75:6c14 with SMTP id
 586e51a60fabf-408f8211aaemr2964062fac.29.1769466904950; 
 Mon, 26 Jan 2026 14:35:04 -0800 (PST)
X-Received: by 2002:a05:6870:17a2:b0:3e3:6b75:6c14 with SMTP id
 586e51a60fabf-408f8211aaemr2964050fac.29.1769466904500; 
 Mon, 26 Jan 2026 14:35:04 -0800 (PST)
Received: from localhost.localdomain (65-36-8-206.dyn.grandenetworks.net.
 [65.36.8.206]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408af49b115sm8047754fac.0.2026.01.26.14.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 14:35:04 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, brian.cain@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: Remove unused is_finite()
Date: Mon, 26 Jan 2026 16:34:34 -0600
Message-ID: <20260126223439.46974-2-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MyBTYWx0ZWRfX//0x8srqidI8
 hpEkb6k8ORBwZZiG3nSo8H389G0w9W5g6UvlpU/AZBeupx5PJqS1t4n3aMgUKAQSZxefwPAnjEb
 s8FHB84RqmUQFy7DOeO1RzkYZZKnemLK6dE9YMZ2TYNytLxmwxtPMJo6MteDMUA2IGq9oCaLim4
 4jm0exdiuNpL/7JmRvjLKaTWjzAr2XXSbZvdWtjAwbtX6OnTicKwDOMzxSvLJK938eSLkDR7bv7
 R9JhI3yT5mWvwSdP+gYFErjRLw8W88mREz56RzhD5DDEUZzs9eckqIBPlaG/JM1N5nAHe1Yt2Fh
 4I8cIU+gul1Hus8JR5IUU/bHF/X4U1nYRCaRCvC3cyb03ciijT5vANTilsE6dg/Os9fgrR0nAxI
 kK2BWDfBiYyIFmeviehPIE/dzkxDXVuvrKH9qSRkXuV9a4yef5t7Yb6Yxdx2RjPRrHF/or12nvr
 SPS1mMFtdK3J1NqfWYA==
X-Proofpoint-ORIG-GUID: WBYlKQQg3oE6TzIIfVEbhcMfznPeJmPw
X-Proofpoint-GUID: WBYlKQQg3oE6TzIIfVEbhcMfznPeJmPw
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6977ec1a cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=EC6cRb6ShDIsswujv3MNkw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3MbPwEZUIfkocZ0tF-YA:9 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

is_finite() is defined but never called anywhere in the codebase.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/fma_emu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
index fed054b609..910530fff8 100644
--- a/target/hexagon/fma_emu.h
+++ b/target/hexagon/fma_emu.h
@@ -18,11 +18,6 @@
 #ifndef HEXAGON_FMA_EMU_H
 #define HEXAGON_FMA_EMU_H
 
-static inline bool is_finite(float64 x)
-{
-    return !float64_is_any_nan(x) && !float64_is_infinity(x);
-}
-
 int32_t float64_getexp(float64 f64);
 static inline uint32_t float32_getexp_raw(float32 f32)
 {
-- 
2.43.0


