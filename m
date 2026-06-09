Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E98CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JD-0006x0-S6; Tue, 09 Jun 2026 17:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Ix-0006gG-P4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iw-00084c-02
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4q5M3266493
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=deUn6wLqpr2
 xGWtdEzVNdGG7qxVt8rPS4faBh+zYGEE=; b=h7axax5GGVM2N0DJK+BfNiGhACZ
 ZHJf+NTWAY550ZdYDrD/StzQhhurlDXj1FmgB9G3bN0oLbVzEVnmUWYi62mFWvts
 s3Sn9f9PEwg20nW/GV3K1cQfvWklkJlze6abxrpmqkiUdAQKdCVQocuj3IrBdtT7
 O3mie9/k+bs6+xARLPXA8NJzwU5boAq7DljIX3a8RDGvuXDk94vCQrnI44FNlbhm
 qEWimrZi5wF4D9l5lTx0jXyPaUs/M4UAgUVttdbLiMcJKlZmnMW94mNvLdGZcgSV
 vKlCF/N6hzERJSLdOMNxVesmP8+S/PlPBrMwublBkMsqCMH1gF+Yj4dOieg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jujjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:02 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fe4a3640so8865771c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041682; x=1781646482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deUn6wLqpr2xGWtdEzVNdGG7qxVt8rPS4faBh+zYGEE=;
 b=FBGUTgvfYsrD4ASDwR2p4Xh9Vj+nNbJsKCZLptt2dC8jJmwZlhe/Oz8IL+1xvDO4WT
 bxp4GqUuV4vpwe4sNoHCWBKlrKAaF7TSA5Op/5QW0pcu54u2Hdy61U9p/AyyyhwMBdUF
 NiZnds6v4cCXQc0p0yH9JztBMyPviqPOVavqoc5d62iVZN7dqVpQsdH+DHUrbuupuJ4K
 YP9MesGwdTQqXKSVqQDA3VJsbU5X7hyNUwPuad3DDmMaXq/PMpwwq8D8y03kdbqO/bTJ
 a7rlV2EBxV0mDNHmz30cu4vrMBAUQyXgWkBkqY6lg24XtxX9V5w4T1aOHdYGsjcEeq11
 mG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041682; x=1781646482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=deUn6wLqpr2xGWtdEzVNdGG7qxVt8rPS4faBh+zYGEE=;
 b=Cx+jy7UaXfOruThf9RiPvGyY41Rd8uf8LQv+oA4+0Fk5QkBnHD8moRamz38m1qC+oG
 5HQOInVBFatM42r3SkJuBDxq4JVkcgHtElsC9RB22JGvgjZLbL6xOShjKZwLPjSbk+bG
 Wh9Sx3QT12SRXpaYApYn+phSVRKMeCQEdAxXPIVyaMajzFj3Wlkl4xGW+KdDfivWLXHT
 1tCs7OoKYPywuwlmz4tci4VKVrSW7WdotnAW1uSRnF+wZzcpQ6o9iZJmK/ZNXe6pxZcz
 PSk5LcgDowhaPiY+38+p1JibFsrAfbMc3CNQuK9+QmC2B2gPOZmurU00b/SmIeSyB3qp
 QNbQ==
X-Gm-Message-State: AOJu0Yyo1e5CNEJz2yqbETtSLWpLzN59wZLKwosDy/ElnNpF3OtV70KK
 Pcux1QiCyuNwTcpT6Gi8pREcuQM4tP1UUPhIEGE/g7d2HEuWeWjPmdo5eTGfmUotQ+/FaFAwbed
 L06Aw3y3oNPeyYG68yJMaZ1jwJ3BmWaAIASA+/HSMdkPP1LfS5YrXvKKfJAXQAllC2dyt
X-Gm-Gg: Acq92OEeASvCQj3KcquE//Yx23YK79myYvBohFHjD69NKLYIbFLbs/TAPI1G75i5DCi
 Z3ExAd9p8RwFTEcCeeWc7RyBB3LZ34UzxO3Op/5gIBfl2HWQaKEUxN4BBB3AnlRjbXqmpBzqDp/
 f4slDuXFLmR+77jeoGGeTgjwHcmW24zNQOpvMr79sV0aAjYrvN6q/GW8/11UI1AAm9y4CMrLoRm
 Sl50NLWe54GejkGaRfvews/RtD3H4wW9fLd6gMZXJXES6gGiLd0y9qBybv0F7TVrHwHgnlVsk6o
 HpEp5PZnO77ZMBiTMBBFzRrVN55slwt/87YwJSpU4s/4vZ/bvKM6EQ20L+TGjSo5iFUNJp1SWhZ
 TtoXMcS9iagIuWuUPkIT/aP9HD0bD0LlDJYjYeWHCEvJwOSxZl5I/Gxx8bKw1gBAgPskc5c1lMK
 Zhs8FO0TAcZNBtiKmZ
X-Received: by 2002:a05:7022:32b:b0:138:136b:6154 with SMTP id
 a92af1059eb24-138136b620fmr11083098c88.28.1781041681948; 
 Tue, 09 Jun 2026 14:48:01 -0700 (PDT)
X-Received: by 2002:a05:7022:32b:b0:138:136b:6154 with SMTP id
 a92af1059eb24-138136b620fmr11083069c88.28.1781041681383; 
 Tue, 09 Jun 2026 14:48:01 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 09/27] tests/tcg/meson.build: introduce env_var
Date: Tue,  9 Jun 2026 14:47:27 -0700
Message-ID: <20260609214745.772536-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n1E9qkMARcGWtdxms2GFP9GQF19yS8nY
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a288a12 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=gbQ6B9eDvqgx0y-0Ix8A:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfX8+Z6FRu4wstY
 xIsJ36GBnG8UygoXM92fqtwnDPZwvuv55USLXBoTeFcVxIOLXDWSPXBYPq4GEz7wsHRl6z63FTr
 KEDnZp3si0MHoJs4Kui+8tIfA3kQQmk81MpbJh+KTUIOySrXSyUPomO1AHwgCgHq5+piEabhWuF
 h9SdRdL06L1w9aEBvIam7+LSklu41Ww63Y7qMjnjzv2X/WxhsToR+XPKNMWo2WfEunsxlbMHjO5
 ZPi/E7SLLTTzcKoAMqEbScfmLPIrNB5rkRigC/RLfToW1pRWncHdjqi7nHaMFWi2lTR+zWi/swy
 Y8TJ6DnHPOBCrWrh3U2S6TZYJb7rdYtR7dc9wcvWWcSMWyHWUEZXvqt+QSG1s6nJ1aetEchaPap
 FTieqYeC+QPHI2xlugG08soBPV5BnuPURHpHTTSEPSEeCa/D26TU6RzL/a2vUmcSgczs2Ayif/6
 mtW8DCeHEhsAmMqxCIA==
X-Proofpoint-ORIG-GUID: n1E9qkMARcGWtdxms2GFP9GQF19yS8nY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090204
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 28a7e529c7e..b6a375e9eee 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -55,7 +56,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user mispell a setup entry
       foreach key, _ : setup
         if key not in ['cflags', 'qemu_args',
-                       'exe_name', 'test_name',
+                       'exe_name', 'test_name', 'env_var',
                        ]
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
         endif
@@ -120,6 +121,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            suite: ['tcg', 'tcg-' + target])
-- 
2.43.0


