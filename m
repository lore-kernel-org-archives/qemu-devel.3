Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6570CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7m-000407-Hy; Mon, 15 Jun 2026 15:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0002P1-HF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-00017o-6b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:46 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ0q0p1453759
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a+wGGRZCsFu
 Dn55cNs+nSPMT4EkvcI/GYRZyjpLftws=; b=NMXDmRROs1ZjtC+K+IPLKp6U6DC
 S0+8OD0VrNev7HKBIUKVCOtqgN8MtiIxYOTmOKOuXRfpa/3RhNWsvEBZMcKj0I/q
 CPq9m23ngLmQYzRgnjXNPm01k3TRjHf2T7Z4+wJ1fkN/tmfSkt/X5nAZa/thgJoW
 qky7mS1tLNDAmHr+S/44phIYPR+aDygxA9PDIVFp4VCjNBVQLQb+FY7+RzNIi4gq
 0rc3MTChgMfkTyxWTIip6Ts8pdXCn0XvGbAs5ofrqODXS7q9bl2/TMMOh0jWePZ1
 6+PkCsWDDajcr6raECRv34OG5WO2JcxsxcWvdQxzXZHjy8s3wzffcpSb81Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2cb4be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304df51ff3eso7915016eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552131; x=1782156931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+wGGRZCsFuDn55cNs+nSPMT4EkvcI/GYRZyjpLftws=;
 b=GlN/25PPSbiYAQEZPPIHICpU0vLfx6guHYFFyppFSpLespv9jyXe6mPQ94vmvb1pZP
 9ZNhd24aE7kotnjxYyWlO2KB5YmE+3fEr/nSRtOWrPTMHriLZKQMD/+g7d2wABAL9sBf
 +xWDd3XYAtIQaiJrkxugmCVg1cqxscZQQjLKYkM06fKHbHANUphQMDQ8/Ilsr2sOUF+x
 TpB5OhJ/Kquz6eEVAfQ2PG8tvi7BAqX5uMiu85vAvYcB/FiTMRuo199wIouCyVhrfo4R
 WOO1aJ4BGNQZLN/jd/hXxSEL3s01be+K0IurEdj7uUItxPMnijN7dsITQlKSAW3apK0v
 MRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552131; x=1782156931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+wGGRZCsFuDn55cNs+nSPMT4EkvcI/GYRZyjpLftws=;
 b=mcHAccq76ZYF2D1YGjEx06xG3TZIhky7/78fKqXdbilxMzrKmHQ3tNOg/1+MGq4So0
 1WoXBtxBqCfdpXzwThKoSIFCf1XYTiiAPHjWar0VO1XNTnIGalG5NND1VYzWmtiKFnMT
 G47QyLwkcAYIaIJT+zTirhW97PfKV6Q3mgPIAPAEt/kiceu3i29SaQZbMqRVuE+NfYYn
 MMidMwmQpX2FMCX61dndeld8+Q6u5+Wci6M0K7mz8cB4Uw2Akg3FV0KL29tW+f5vqlhh
 0F77xlWpC0p6XssUQrc++Zfg8TpU+wDSijqkGhCU40z8eYGwDBDRgo7LGZlsm107D942
 4FqQ==
X-Gm-Message-State: AOJu0YxP3fb42bBhminRO0edYJIvkj8cnIHXzKXfKoN4A2hhIgx4OpLg
 4M86H8P0OZSU0SLdzbAnsjKL2pwZgoP7lAe0rz5uBMtw54MZ675MNfTt4MBJUvHQloUgW+Rt0+a
 QbFmzFI7htt3zEX/M9X3Gv1B42I0uSE3Z5FBRD2d8Grw3Z7P/mYA95CNJ7HPw5PiWrd6L
X-Gm-Gg: Acq92OGz2pW40Lx9eTEkfYo0gsnF7OusVaG+ON+1PHT/Ks1rF4CbIEZwlxbhA0NwBlH
 obL8RN6/uFKWEsYc6lBdYEXCoiR8EMaJCUJAErIdXpBdR+LheMKWstnctuMd+zzmcG1K1aXovy/
 M5BdSoR+56EMaQxslD0wTMiD17nVJrugGRze8/Lbc6ZSdGTfsbxLUOzjY8oxwR5oOjZ/bFgvbLN
 yElEEo2Fo0Je9BGnIEvjoTtYcFSypXB726FXQUGCgDXy/YKeD216KaRvt1ppOEJ+nlX99cC6Rk2
 glnSSyqq6UWDRfQAiOh8vZBC1LB8kXdp2+xiryO27FxiX3v898Afwo1xW3zZBW7A50QAr/ziOCw
 IkuLJq+nMn0p3boK86MM/efsLdxYuOVp5cq5tAkY5qe4n+FdMjoK5o8aBYSRdhyYvPYwWkrus6g
 TEkV6GCg==
X-Received: by 2002:a05:7023:b16:b0:138:2c88:b3d6 with SMTP id
 a92af1059eb24-1384bb69a3emr6280662c88.18.1781552130673; 
 Mon, 15 Jun 2026 12:35:30 -0700 (PDT)
X-Received: by 2002:a05:7023:b16:b0:138:2c88:b3d6 with SMTP id
 a92af1059eb24-1384bb69a3emr6280646c88.18.1781552130101; 
 Mon, 15 Jun 2026 12:35:30 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 01/26] plugins: bump version
Date: Mon, 15 Jun 2026 12:35:00 -0700
Message-ID: <20260615193526.2883349-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX2Q9FdqB9qkdm
 omdJ0F6bINj1PwYkQh3sV21qM+SFLO7wQAu/843qulih0muhjXD0NI5quUw0wPHQupkq9pMaJHd
 12GH/JqjDQagVqcGCUt9y5hHXigdx8hE0zurAGRNPBBjjg2HMR1IOZoQ5KN0S4UA4oiFU23oZYJ
 KSQJheXRFm817iIZEdEwrQacCOstBRxPQTSRb7NLVtPkppuqFyvpG4dqGmkNWMxERDn1EaHXq3L
 yGjIKGY+C5nt0BN+FFIZ0sH66OaXbtJkvHrgCqklLYNNTVmvPwoGeWrab+0UG8EYvYNlCFKdhFi
 VfhQJ4DHC+2e0sX1P8Ax2BS5rWshKrIxbmHN9VJxG7Y5h7SmzsZSkcej6IOwsRdv6xmh7V9rCd4
 St6mLfCbCyoy7vaeNEXO3QHTY1dzfOtFWs/oVscaONzUAGoMhiW2O72NnhgXnkf2ShSE9lYz8GQ
 j11t29sxXelskdDkM6A==
X-Proofpoint-ORIG-GUID: 9wpuMvhaqecdCIWaLEXgzAtHoVvXxpST
X-Proofpoint-GUID: 9wpuMvhaqecdCIWaLEXgzAtHoVvXxpST
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXwkVsZc7w7zDs
 d2GzBk7R518uoYtK3ekFyBoFAwyOVVkS3jHHGl2PAUUBiLm+vE/hO77PE1Y7bHa7IJTIbHSujkP
 GoiRcbph2w8cFOLY2qEtk2pQCq55kNA=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a305403 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=A7FZhrvmqJkW37y3txMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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

Next commits will be breaking changes, so bump min version and version
accordingly.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 6 +++++-
 plugins/plugin.h              | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 4eb1d2cd85c..435a14f5a00 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -80,11 +80,15 @@ typedef uint64_t qemu_plugin_id_t;
  * - added disconinuity callback API (for interrupts, exceptions, host calls)
  * - added syscall filter callback API, which allows skipping syscalls and
  *   setting custom syscall return values
+ *
+ * version 7:
+ * - add userdata to all plugin callbacks, allowing maintenance of state
+ *   externally, and easing interfacing with other languages.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 6
+#define QEMU_PLUGIN_VERSION 7
 
 /**
  * struct qemu_info_t - system information for plugins
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 6fbc443b96c..9179da43851 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -16,7 +16,7 @@
 #include "qemu/queue.h"
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 2
+#define QEMU_PLUGIN_MIN_VERSION 7
 
 /* global state */
 struct qemu_plugin_state {
-- 
2.43.0


