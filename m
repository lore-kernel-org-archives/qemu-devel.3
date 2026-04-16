Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E59F8E48C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVvN-0000l1-Ir; Thu, 16 Apr 2026 19:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVvM-0000kZ-1N
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:15:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVvK-0004M8-1a
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:15:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GFd4TK701110
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nneprPU48Kty3t2AUZqCtTvrhPijeE/UzuUrahuDA7E=; b=frWiWjM1qOI1lVPd
 Sv6GVNeSGmbEIh/ZiRmCuKdphdPhkBEd8TAodNrzHooUmzI9KnC0HwO51y1F2Ejl
 3uGI42Mmt5FvqznaxBMZy4RmjK4HYlj35v5jogjeJkUnL/uyq1I//7poK2wJ3cCa
 5XzwJkfjFc1ldc5Y7L67XM8cuEwG6KFa5arBv3j60+PyejBMijEAF7d0yGPWjBAo
 Mj2XaLh3RyHifF9/y0G21DP97v1a3egPI9EeDpnvtvlooQMdVsnVoSp1O/mKmVki
 3752wkSj9vWnifixVWppFMj7RgZoZzs4+IeF3P/r5pXvrWHZKexDyvFoHRHLiWoP
 zy+/Cw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2kn9j5t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:15:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4530a90fdso1176885ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776381299; x=1776986099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nneprPU48Kty3t2AUZqCtTvrhPijeE/UzuUrahuDA7E=;
 b=B1oggTPDqyROGB/Cex68Y4t1tSIkNdjRbYx6slxmeNlNUGsBmVUFRJdhx6RI732bqF
 zHfhMxqapNzT0NamN5/BOQ6zxU1VdgeCfE5n9O4lEO8VQmJS20b5w9PUwnfVEeat92oD
 Ii1v1JfxnG1GptiLDW6eIfd53HTaADk78Orgl8AhzfbgGI8nwUGQ87he7iUEuqAkT5eX
 X/ZW9DWN/niigzwFpT5HvQz7kuQak+HMtbxKPRMxzgH6q7deRRhN2Cgi7ww4wjnjliYI
 BScIYO9JUnyjyxFWlnGvgEqZ/aCO82nWTp1BNUA7UbC858qlnLPrL78+s6u1YB6dOhbr
 5Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381299; x=1776986099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nneprPU48Kty3t2AUZqCtTvrhPijeE/UzuUrahuDA7E=;
 b=A/7Xeh+jcvAh0r5NDnlq8ij5aqNG5iz2VOjHnNcavHKnUKXcEP3UcZzcgCHxX3QnrP
 HYUQx+M+qaOYrVEBp4uCe1LFehDYg39iDoVMTD0UUul7X0fPTPpf8RJ3SWtf8JBp43+M
 KYcdMs6aP2OheGKsys5Qt9nN3Seuy6IrDbBitU6XLG4ht1NKfnbeZjSdo+qvnbAyywp8
 WPBxPfOFngeE6Z9PY+njJ4oX7SnFvpVZRYjp9cuxsOBsgHf6tMV9WfbpCGxpHXhy2/U/
 fkP3XgUEr88aB4Es0B0FGtc/MpSCpwAujaPIv2WK2yJdIe8HAOd/xgnhg48ZDOD+FCcG
 yyfA==
X-Gm-Message-State: AOJu0YxGuzWYcTqlz3qtptYnrHLxq2jGY5nagWqlUqaWsIXflgYohwCl
 +EkVdoFyMvRt8qtNGI9yWcEVIwfoMqOlCvBV1+bKf1e7te+VXmnx2G3YXjiS1aTMRs2/dnTdNeJ
 vp+O05t08YcuuLT1M6iZKzVQibawAE5rZ1luDb/O6jfu5jWtfVGlng+MCOuPMl/1zmw==
X-Gm-Gg: AeBDiev0fMYYL21rPqdHAjDG9pvX7NZ5vNluXboz8Lzlm42+Ggdq4CrdpFelFVonHDy
 iOsTLepT+9fmQSQpCW3u+iBDHOgF9KP80+VLE6TrHO0dLfkcBWeRzrhfiyk7D02yhnTcHyHf8EI
 YuZjunhYvGd3oaTMOSW3x+kXWdCC2QNIp04hOVacbIVJETkCb0B+YJrqIqEv6yDC8bFNHuZ86QK
 i7an0rlJ8gPrrNeHHAvWsjutfRyofhwKFKrdKUj97/5kn3h7QlHb+Z+Vh+tVJyeNbGk/XXuoRei
 0EFEMbCeMu6Tk2l+rxsZFfpmOmTd+LH2RD8S0zv2afApkvFaIjuyh4nlg6HmOfYrG1U7Wf6zf4C
 +8qKB7uQrHOVHgtjwCqgiCXOcqddtaRlMOsdylmwLTTjElWldS0g2GuWD+5YKU0/0kgjV3yb7xm
 n/qUxJXtaeF/5gwojrMQ==
X-Received: by 2002:a17:902:6bc7:b0:2b4:5ddf:24f with SMTP id
 d9443c01a7336-2b5f9ed21f1mr2661425ad.10.1776381299129; 
 Thu, 16 Apr 2026 16:14:59 -0700 (PDT)
X-Received: by 2002:a17:902:6bc7:b0:2b4:5ddf:24f with SMTP id
 d9443c01a7336-2b5f9ed21f1mr2661175ad.10.1776381298641; 
 Thu, 16 Apr 2026 16:14:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff8d6sm11615ad.1.2026.04.16.16.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:14:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 manos.pitsidianakis@linaro.org, Mark Burton <mburton@qti.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/2] MAINTAINERS: update address
Date: Thu, 16 Apr 2026 16:14:53 -0700
Message-ID: <20260416231455.346504-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260416231455.346504-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OwVP8cSHquwfQpANj0oaavvnQz2g1WsA
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e16d74 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=cplnpDx6AAAA:8 a=dGsWvjqBAAAA:8 a=pGLkceISAAAA:8 a=SqMvC5kiAAAA:8
 a=VwQbUJbxAAAA:8 a=FyogFE7hAAAA:8 a=Ixn1CAxRAAAA:8 a=20KFwNOVAAAA:8
 a=ciZXtekWAAAA:8 a=lB0dNpNiAAAA:8 a=-c9VzbpeAAAA:8 a=0FD05c-RAAAA:8
 a=TMBx9dqlAAAA:8 a=QktKnYkmAAAA:8 a=uYLkEQlkUP3FWBz33VgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
 a=bHwCOBSOUrNypjIvOSWD:22 a=EwAE0RQWx3bH85eTCWcH:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
 a=p2WyBLmlf5vdw_nX_QRo:22 a=_0vDLAJOulx5KDpLVjVP:22 a=GnyklBnmId1nB8FO2ck3:22
 a=c-ZiYqmG3AbHTdtsH08C:22 a=WAq88MDkwfy8HpmZFCM0:22 a=l1rpMCqCXRGZwUSuRcM3:22
 a=hD-SeztmQn9HBm-AZg8e:22 a=XkBopB_elf-j1KJO54R-:22
X-Proofpoint-ORIG-GUID: OwVP8cSHquwfQpANj0oaavvnQz2g1WsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyMCBTYWx0ZWRfX3B4FTez5RgeV
 qsoZT02u2iZQebx7YHCJuh3QnwP0z/P4ocx34YL9i+vOm4BFgsSHJP9Za7Ct4vE+HGjVCy4h9Mp
 wN6x5hmOOlQRG5IWmpcOZ8Fq4V3bT8KiXC5KPy+iKDSxZdrHG2vyFbLuoRonVOa7C4djz/euUVN
 4X6REZQRfiVceYlcxqqGyusoTeXmXPfsSGLXML8Vo+IsEjsaCWnuq9vA7CJJ+sH0sNTeVe15/st
 nOBq354sZxa46cH16TZwJnM2xXbpwoA7nuTHZEMkiZmpBVOfSPh7HGVlRN9cFkYBO9phxIaB7I/
 bGuPGjq6LgXOyE7KVP2cRHn8C+K8jjlNgp4z6pBXm0I7y6D951R81R7NZOBTtLAQBZk1Tytyluv
 mZt5gFFwUvzzTu9on2M6D9+DYJ+lfV6jhoedvW4s0PYLllgt37F5FxQ57kQDxFoUbbCTtnHhpCL
 G3g9Bq63s2qsiGsPsog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160220
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++----
 .mailmap    | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84..14bd822ddbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2038,7 +2038,7 @@ F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 
 TargetInfo API
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
@@ -4075,7 +4075,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
-R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Odd Fixes
 F: linux-user/
 F: configs/targets/*linux-user.mak
@@ -4094,7 +4094,7 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
@@ -4556,7 +4556,7 @@ L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 General Documentation
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
diff --git a/.mailmap b/.mailmap
index 383948400a2..ce569d83f4a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -107,6 +107,7 @@ Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
-- 
2.47.3


