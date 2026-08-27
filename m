Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB661C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFU-00078e-K2; Thu, 27 Aug 2026 18:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFT-000783-6H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFR-0003Bk-DL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2DB795306
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=; b=JjcThcla/S894+6W
 UcuiGIOzDkWRdjZufS+OcNAhp+vS33tjvGczPgD6IVrQA20pJpj+cpg0VJBxf8KH
 8jhMPPO707VsjIBn8RRK5xk+R0l33CoU17SXwbFQfAcPpNpRed5fAIZEvtb66YMs
 ny+F+7IHknsKzPg9LeXuWWDaOKMH0zRizrzehCAYGnTx0nWUUrqkDTclWY91/7VG
 AHqyXdhNsyT1pjclEo3TgXQXyvDmtaWs9PEAeZVGm/RTH3MjHj48D1VmHM7ZAHbD
 FfSyHbcWAZh/DA8VH3mJk59URF3BfRjFsYG7xd3znGXKXa1a94TWkejdbZ7sYVYW
 5dx7BA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjm4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso770422a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868419; x=1788473219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=;
 b=QkXuWh8u2qKyaCLaeaJ9IfKqvkFMWeRx6Zs1hEeBOdfBSuy/opCNT+9nrSjpKlQ6J2
 Mjo83Tbp5rao43GWD9VukzUcF4EIDs80DVoxO4OMzCkzYrEwv7N+GIgpUFaDKlCXxOvR
 gpR+d4yzJJoXSMcx6GHkRbgLdPFFNT7YWAV3wQRfmgIxIOsXIGxIj+JJXjZGwF0LtpMF
 e1KLeqUxPk1PuwUVpBFoAY4gI7AQtTFI1cEIiypgndF5O9Rc2pkWqbpB11LtxKevL+JH
 Yty1zuzVaSWBZZ6o6Z9SBwvq7wQ4pALVYqB+t8ZZw+YuERHMsyY/l+w9f6ZHSLbwM4/r
 Y0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868419; x=1788473219;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=;
 b=ONQnCeNmvktOu0f1M024WiQ8EHSs6AEGc++Dm4XCbf0pMj7TLB5j6yiXv6kKrfoNce
 IzI7Fd1PCW3assS/BEcSf1Eug7TsPyaknyt4AyzMa1LD3L5qI9dMVMQOiziyM4NBZlwo
 k/zMH65bBYijt9VV0dTPcU/dnoPdht/CtJsrC1DHQuoX+4cDJH6Oa9ifHj7T0l4174se
 4n2P78PTjMcAC4nLeWt7krE4als4n6zmWWEcaUjVFVzzPNJ60QMkhEnktB6f13Wq8ad+
 MZB0Frf+eC24Jaed/v7Le0E1t69gRwVH+XKKnGoKdbod5yFqMbPQ+OpNrSF4Tyxfu5aE
 by5w==
X-Gm-Message-State: AFuF++kQq3+z1lP6K/PA5AyoSgvFuHr1GxEVeFOqzohgsxeuEOqBMEHX
 v2Mk62/TbD8CPGoU+pjzURorsW6YcFhzhvvTMTrZ6h1SPAaFL12c7rCR/d5AoNejage2S3cmy/p
 SNMzGlftLliMXeMQrnemWnk8wPO5NrGJCFkh9BvTmba1/CVxIrBVppesGGkrj78JvCQ==
X-Gm-Gg: AR+sD11bWPF/LIpE5aofGeoyf8N6kvgA89OX0aEYCUYuopoMo9shp8ljZivQWpFOONy
 +I1deAQibWNz4hN9aAYAlCiMLOpSHSA8tDXpPvt82bAAKha0sLtNH1LbQ1qr0mLIRSlqb0Pf2vn
 GYh9SjuZRNSfeXPPVguA5qoPIKwE+0u0L/onAgVom4WpzD4SZ5DxPKdRz3V3bvlABidXFpepdL6
 /AwtH2ac1dOex+qPaEO+0kY/TkeMod2El47K795kvy+7B8vDVG0ywmgMRVTzQc1N07XhRqwldFp
 t4ZciDn9BVY8avLdKbEf/OFnO1mtM4atmJaIfDDpS+jIRw+4bfQiETDQArSnNAlpNoZ/iOn40Kq
 +adlmaGwqqhvYQo6x1m0dBy24Dr1QzUN4SoohFte+XvuyNX9OPBSEzJJZdkg=
X-Received: by 2002:a05:6a00:f0c:b0:852:5f99:1866 with SMTP id
 d2e1a72fcca58-8562514cfb6mr4716698b3a.0.1787868419467; 
 Thu, 27 Aug 2026 15:06:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:f0c:b0:852:5f99:1866 with SMTP id
 d2e1a72fcca58-8562514cfb6mr4716462b3a.0.1787868417977; 
 Thu, 27 Aug 2026 15:06:57 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:56 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 006/105] tests/tcg/meson.build: introduce exe_name
Date: Thu, 27 Aug 2026 22:05:00 +0000
Message-ID: <20260827220641.84885-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6NCs5w20dFBI
 P2KvsKSuy3jVPbyS5DIDqGRhFv8LI60LfFgOYeFxnSQ/dm4ZnVcmYS2JsNo4u2xQXWHdZp/YHj9
 EEoVPIK7OJ32lcc8C5+9Nxp5RE0LNO4=
X-Proofpoint-GUID: eKdbxfyN-ffMwlVvFmLkte_EvaA1mUxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxz7A+6heeOg1
 s4Vk4m/kZEakrGJ5vGtlaPKnw+tImVXQCwM5Eix+9cBP4z6qo+xG+gdHcmg7P4QISSPiZCPbZ4z
 z3ZdZZwahuBez4iSO+PiyeW1sWCGNi3igCvYn7kokzv+c3MR1qI3dCNxW6I9HTsYWBRLki1rap+
 O1tkTnkkNffKDjC13AawWAYnQP9z1JPEYrUFdujhMh7zPq1J4RIWrSPh0lAaEs3j3rF3+pY59Kx
 28qWGhtWJewDy3TMUR0OGg8i1OXlWBXsbxeZmtVjIvyLnyDB1VVDVc8WON5jJcGhitPBWkbewvZ
 OI9zXIDTwd3jUCymwL2CNmOR3e799jkp3BbODQ6VBbhHbp3eO1KVEIfEBL2khB+WQRSZGiGrI1+
 SrHzLQ2PNoJ2m+JqkpqS5C9HoUkMqkRN7CsyfBxcPe9Wi0Y7EwC7ToC3EungJXPz8tr2F+Fqa91
 PQWljvgfs1P4GE9Sx5w==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b504 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eKdbxfyN-ffMwlVvFmLkte_EvaA1mUxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5758c7cc0b7..697b826a382 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.43.0


