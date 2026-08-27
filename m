Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC193C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFZ-0007A9-6T; Thu, 27 Aug 2026 18:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFV-000796-TL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFU-0003Cx-8U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM4JY654747
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=; b=A+o1VHQ7OdJBqNbB
 Z7dPfIgmMOljLaNMBOtoJnKQcDZFHEYKeGmvIRBoAQstRpRFpsw7D5rY2QE6pDFj
 YL1Yj7VdMfNiN4t8tDnRR6sY7nqVm3GIjjJfwai2VHVK6u63n6qoxWfxNLrobRlb
 obE6q5fHv4ciZ1ynLVUnk8LWq60bgI5/P9z/ozg1aVFcI73S1ngdSu0FajXesASC
 6mMDospOdnItway+B3+0DbjwqHclOMdGFxDW9RC7Zb8LRu7Zh1+aapyAP/brs4Da
 G1RE78rrEwFLf/EprWW+Yctw2fyq73LSJ0DLcLBuMCT5DL/rE5qHzfZKIlT8RtO1
 FcX4Hw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuj0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-853402198efso372799b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868422; x=1788473222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=;
 b=XiHxKOA9KXKkR/JR88hHwTkq9ne7a8iGrTKyXZO1rDfBWsZ7roiO7YzGV17LHN5uyy
 gsBr9Jbg3AXNGcRYbH+CylMqmGHIfq3S/Jg6izJQ1xNFVEIG+gdT+Z9E6cr8FdF/3uY9
 gxstKsntQH05D82LJwwa5sBHWO6PQ0uPJvRLIzCIzXmFsjA7toClF6laySFcUt/BL0un
 iqJm/2dgLO11mJHyKzBQIe8dOSKPRxzmEm7kzzRR4Z4OHotCBQ2SD91+txZjDRokY12m
 izQ99wugDuHysbcQ8JQSgbQzxgnzok1Ri/hxLX5f1Ha/iE6q+SNeyNESGh0+VDWuUbN0
 OJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868422; x=1788473222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=;
 b=XJhNQTyDU8dxkibM2aslvnKe+b1Usha0KiuE6QnottSOFMgGqcVRcWSCnK9oSfJdyi
 75sHUScQuyMtE1vcvl4rcWBOp0TyTyQwGD/884EZrpQkle3jRuFOmIllRochf9lIfJAG
 aDvBtIx8hw97NB0IbmZff6sxiEhKHV0WMffM3p3M3/blMqd2mvZUlx3TCy/LxQXrBRKQ
 qcARmiohOHzLg2p4WZjwLOKAeop5wf5v+LxYpfH6qVDSZ8nyilvKIeL3un3X2WpzGLKS
 AatUcH4Oi8khObu37Vb+bwfob72oIQTlrs00Za4pSfVGiDZozEPiwVigTvhixH8dJywq
 C+jQ==
X-Gm-Message-State: AFuF++niEK/LnbzJyn9hI/q/+nj3tbEbr8zLLCSUkuytCPdzzDa3bQGK
 HAEsp5gzvX1bY7o3FPmCB2syqbu0ERS8+9q/Z8J9AGLfNYsBdTUlj047jCZNJiKsGbmhQadyIR9
 g75V9/j+9Wo1wL/bkCOtlFkSH7m7BoKi2V/13lHqzkvSPnL3MdzygRRjEP/ckld8nmA==
X-Gm-Gg: AR+sD11dVvLikgVtzsLB7VBYWqoj5UuSmMxWPvt5m4aI8JqQzNJjfldmbrZerXG9WZ9
 l8hQjgX0rae40eU52U65jJyr0RquUMC+vUfJ7Ly8+0ZFtxL7c5XO294Gu3U8MwUyotWgNF0UkJw
 cL8K0odyofO9u71Onpz3MzwGrctrOnvv6p/IObaFb8KDx7/AS8HstiE7TFJ49ZJEZZ9errgYhWs
 WlV21gOXV9ktMlhdq5r97XAhkyvgKoeFx8uvStIKiOAHN7XKe3VS+cBJ7tb231CZG+ZjeTCcJa7
 v5WJ2ycNNYjbWplvCX9js3IxZdsIdAPLHQC7ju0Ptld/Ii+W7g6QOIicWcib1TlAgfjZ4c+vhRD
 C8uqFpSXx6R0W8ldu1uxyfit0bD4A7LTymqn+J57fww8TraPYRE60FgwdAUo=
X-Received: by 2002:a05:6a00:b46:b0:846:22ea:e171 with SMTP id
 d2e1a72fcca58-8562868b716mr4457936b3a.3.1787868422338; 
 Thu, 27 Aug 2026 15:07:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:b46:b0:846:22ea:e171 with SMTP id
 d2e1a72fcca58-8562868b716mr4457869b3a.3.1787868421922; 
 Thu, 27 Aug 2026 15:07:01 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 009/105] tests/tcg/meson.build: introduce qemu_args
Date: Thu, 27 Aug 2026 22:05:03 +0000
Message-ID: <20260827220641.84885-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DFLwdDUDQNwPTE9sFp7VnLdujfWGQf_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX69Gq0SD3mTCL
 g/pfFZgkpbxcECPVS8KtGC9OVvCAyKIhJZ6Q5z9XBSKQ6kcS7hHPmhsUduffGn0SVr7Tr7kA1pH
 9qFNapBNmw9M4dLP5QCvBGcX3J+hNgk7Wyir6z1865GKC2NOgDKtzEbmLyBFshpcVmaIn3h5zUH
 Gox/K2bFW1wR80RYQIOOdeAIby3ENXGLlDIQcijJrJIU9llSC//UZuPFzO4wkdhU5ghQW4szfnH
 nVDe9Gw50j+PEr1jTT9wt//wFNV2Or6v/ARh+GdNeTRykXpJug90/5w2gqVkckqLkwud5MW9Xtj
 Q3xhlCb4aCWSttl1lVCLuheZNWhudskDnMKKGDZFdVTwfx05NeaoNlXtiK29TtZWxW6CS3axIgj
 UL8KvRbo4sAcZMZ4VttYWkPLXLMH7hSqal2Ak8lU3ksuvgMtfJanIXz8fe5TzmOwbrsmDb9eNDy
 1EDm6vY+3l7IUOgwhBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7pXuOAzP7TZd
 MjmkBBHfnJVWR3kHlZh7Vda2UkCXNcSeIauGpGCg2vjIQablSj5ggYTmz4v6O9NkeZQpinqyTxd
 1nOBcaP0nJSxnuk0LkDt4/52RNW4DJE=
X-Proofpoint-GUID: DFLwdDUDQNwPTE9sFp7VnLdujfWGQf_5
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b507 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e8d8cfbcf88..a7699b7f62d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.43.0


