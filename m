Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39214606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BuXYLCvT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJHi/bow
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrIr-0004bh-Iq; Fri, 30 Oct 2026 14:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIq-0004ZW-0M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIn-0002NH-CW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu7ml373325
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xchSFkoLT7wQreEItSdHtwnzmQxPcqqOKW9v2LldNaY=; b=BuXYLCvThmdaxK/H
 yDWc+gpGhRXUjLT3Uzw4M7Dm73EaUJUgoiGa88NmH+dyrkfolkZwo6ZwyoLQ1bKS
 3cLVQuhE8c3d8r7/sLqAm735SBxMZrXR9FitO8E8qGN5f54VcT3YMjDzz8R0QOGL
 p9n8eK5Wm8AO5S5BStCxN5zMjaJAkdnZH9VrDp0MA+Ay3njShx3T6hiaFrJY67MB
 yeGcmsWFTK9HQfAMRdffvqWDYioSwJxLF6BKTyDbpllaLCpLU0j+8UhchGWpT8gQ
 gaELz1xZfBoJi1bRcKY/jRvdEDZRamJ9Gow/hDY1KcXw5Ic7A0ZBdc1JytNPBDQf
 RbecFQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmev1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:07 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7c0f07b4e97so770878137.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384767; x=1793989567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xchSFkoLT7wQreEItSdHtwnzmQxPcqqOKW9v2LldNaY=;
 b=TJHi/bow0QHf1YqGkMg0HocSOdq03e0DdgxXFLp3tIemAPi0O6neutKUUHaVow7CuT
 XM/K5BjQfL28LbzK14rLedXdOrPQlsuxxzmFGtJAsPAqlgMbtw+eJ2FMQpy4J2CvNoK8
 ZaifbgSHfMEkLnV831BGm1+sMv1wCOQ8gVdtSFDQ1e7gxMtdm1p1AI3zMYHyXOMlQFom
 EmZSE/8/UGIoQDguXzf80CX5frVYmkRHJH+xG8RWMTUZLRf3O29ij8GDF8kFpY9f6C5a
 O8YHbz3wFZOq07qbvmYPQ9WSqOsi1c97rBci13CTMxH/WBy6+rcvrMiGmDfthedM5OBg
 oWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384767; x=1793989567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xchSFkoLT7wQreEItSdHtwnzmQxPcqqOKW9v2LldNaY=;
 b=LQ/BVuvLJvCeiZFHEBCPk5so1oc5Wu6jS5ieCcYosz4XHtQ7TDYe1APuve8w+lY6q4
 FMOXg3TKvv1I7mvL0LNV87QIOdaLlB/ceuJbzPUZJ/nSH5XqFikJD9dZj/o1I2y/wMZA
 1sC1wEvT8s8ggd5KD6TL2u8o9F1d3/MDOqIVFwvQBz7xm8CKN9APQfxJNBTj5Jn91Nyq
 Hv39Lnf+Ck5emLbpT5jMS7vElDuXQ5q57Wjh7l4WWW6nvCUfe0bwnL+RjnqBBBuDaEbA
 tiH9hzgjjWXZYOA6kczAjCqgRfohNHTdeiveWFHBbiIYAX51cdKtegKyj16enytFSWxZ
 Uxsg==
X-Gm-Message-State: AFq9FYLLH457wFgyR3xdWigQySgFwuj+5WcPoL7mN/fkAg6XMe+1hgsF
 97ZKQ7WRn4SQm9nJ9KyqBhciC0iD+V48l8NlnRMQ/vU+hD7wnQBslX0CxSpywGC6vZ8ASILf3HM
 tEeaG1C1jUijRMgDBT06wIVML/6WOnAHgV0OMjZZMHbKuagGMx/2NpQg+eOATsE+a7W/o
X-Gm-Gg: AYBFou3Hxc9jw2mhnJPKBomkV/mdmVNpE9AVZhQJuVe1ptctW+0TJe3ddmV5wCy0n1I
 z1lDCptpSmmrzR4mzq/yhHuS3A+pefUXQsVz4QTu0KL8SzL+Q4SgdhONMg0KLyqhzPXmG+ObBMk
 oykCBf5+rOet5IZzup4qidQV7wnIK4SA55CDEnKdt4YitAdWmC8NM7FAUu0v3oOyeyGdt4rFO3g
 7JQW9AeWScvZtcwZHgxcfzQv/fUZv/3yh5juuFdSVW7ChliFprw5rqAkudiYJOuDMiHbhRPHh8Y
 jzIyUMoXL/SFL51140AttiNKeCmkAeAQJob6z9RG/wN2gNFsIh/U0MwFefWmaP5jkq0vton6XZk
 fTZ0kocmwDSkkq548+wcjnwshk41SwLFqf5NsOyK3uoAfC5nTYAxcN60YHOh/nvKoViCtKymCxq
 B0ngnzHD9s1C9AMYs=
X-Received: by 2002:a05:6102:5244:b0:7c3:e156:da3c with SMTP id
 ada2fe7eead31-7d072c3bcedmr1884733137.15.1793384766909; 
 Fri, 30 Oct 2026 11:26:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5244:b0:7c3:e156:da3c with SMTP id
 ada2fe7eead31-7d072c3bcedmr1884717137.15.1793384766449; 
 Fri, 30 Oct 2026 11:26:06 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b81c74sm4457451f8f.36.2026.10.30.11.26.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 02/12] meson: Add the tcg_tests_cross_cc/cflags options for
 mips32r6el
Date: Fri, 30 Oct 2026 19:25:35 +0100
Message-ID: <20261030182546.2508-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXx7UmvzvlDUoD
 O7CNGV16pJjp02cY6QuYCa/Iarj9OxksKLV5DigHjuWVsbEXtaeQbWlZ67Oma7nPPaQdachNSP7
 vIzB0tezfLpNufCVt5rzRDCqGxcJWzouZACC3Vnx/xB2O/JR/+EebEhi2TMX3ETYp0NUWzedHwm
 e2x7hFac6xB9IT4pmto4Jp41ZqbomkuKgYQk77k8p9m7h/mdPSTmogTzPE2B9VFZcxL57vAlSw3
 mZdbWJRjg+kMpADglHiz+B/QekK+J8kyT5A2k4LBFb/cRPF4QC775Eo3Ep1lvlNtkPf8xQ58wkN
 rBnrEuBrpSUzlUAHd5XU8BN+s5TOqGzpscnq08IGWX+yWnUbXaIEt8SXfbFZBr9Q/UokMs9qtbw
 f+taU7KcnKUtcSXN8QTHitokjDxFwy0YFLhi6IeAj0qvmljbvXZUKTjgQpeiyp6YbUSzOhhf8xR
 iIBM+pb5SGlaVPTFULA==
X-Proofpoint-ORIG-GUID: Zaiye1QA_X5gjGCp20eJ82PrM6vOqaPX
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4e13f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ClBwLX5JVu_AAdhY8JwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX8FzN+h5++4Hv
 oXwjOWsZuJu+hI1Ig63Kf0/FgamnjeJ5bPxKR2ackq/7zr40Ab0E6K4NeCMiz1Qxw7Cdp671Xt6
 IuXvzuwbJeprSCIMbcWZvuE3buZWAdg=
X-Proofpoint-GUID: Zaiye1QA_X5gjGCp20eJ82PrM6vOqaPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add meson tcg_tests_cross_cc/cflags options for mips32r6el,
similarly of the previous mips32r5el commit c7b1a7bc9d33
("tests/tcg/mipsel/mips32r5el: add msa tests"). This allows
compiling TCG tests for the mips32r6el-linux-user targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson_options.txt             | 4 ++++
 scripts/meson-buildoptions.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index 895c6e63c28a..9ae8e44ab54e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -461,6 +461,10 @@ option('tcg_tests_cross_cc_mips32r5el', type: 'string',
        description: 'cc for mips32r5el tcg tests')
 option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
        description: 'cflags for mips32r5el tcg tests')
+option('tcg_tests_cross_cc_mips32r6el', type: 'string',
+       description: 'cc for mips32r6el tcg tests')
+option('tcg_tests_cross_cflags_mips32r6el', type: 'string',
+       description: 'cflags for mips32r6el tcg tests')
 option('tcg_tests_cross_cc_or1k', type: 'string',
        description: 'cc for or1k tcg tests')
 option('tcg_tests_cross_cflags_or1k', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 14990966d31d..0f8b56bd7f8c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -539,6 +539,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
     --tcg-tests-cross-cc-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r5el=$2" ;;
+    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r6el=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
     --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
@@ -566,6 +567,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
     --tcg-tests-cross-cflags-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
+    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r6el=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
     --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
-- 
2.55.0


