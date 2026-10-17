Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1039CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI8PS-000261-Du; Sat, 17 Oct 2026 13:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8PQ-00025U-Vn
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:41:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8PO-0004t7-U5
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:41:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HGA6Zq2598935
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ti02Ok6gQKB
 ofcY7zi1eTsrw6AJ2jDAJ9RymwcdpwGo=; b=lSD5qZaUPoXpev+l16U8sSStlNa
 DA1SedXnYOgQ5aOOoqMBXxLLIuLRVSEyraifCN/orW8KFCKViu0Vj1VrhhqvErdS
 52fEHcAsi2q6j18Vh5qhU6X6j0Dxu0GGJ1mDFxeeSG25CXAnB9RnRTVc+bb6pI7o
 UN5BriIeOWwidu8DJKDkSIFc496K8A6XxL4gIrfkS/JhOWc/oNIUnZkGPrGEBcD7
 E/knYm9IZuD4mpfsOGLA/+9kGb8+SV90ahPbXActYssGBqHer6ODBxQLcRAS23x1
 +BPHrlBizWkZj1ThfJRpQA6FTWJOSpSL6aS1ONBbF+ZTTHW+7fzmsPJr2Dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfss5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:41:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3aaf955db5fso1358658a91.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792258884; x=1792863684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ti02Ok6gQKBofcY7zi1eTsrw6AJ2jDAJ9RymwcdpwGo=;
 b=CH7xAz31estCl0IVLSwO6a/lzznuq8xnXOgcLgi36lMTxv7eZ0/GPZIrstPpXxG7j+
 bU7KmjHFjbBF4CbDf154dT7HosAD5k1QarKQ5rOGWFqEMizC4UsTWarX9t7jVtHiPhaD
 uBzVP2fv8C5seSd5YpFJvDwjwbAz3W3kb5avCuJyj8fT38pQJ3lQEqmbY1kiSkWiotDo
 KQUvl4vp5zyyQ5IOxv+lSWDFM0SoKdradE3DC8Qd/w+emunmfUET8bYOGOdPnp8/GEk8
 pZi4ERboq9pxC89MxIejlyzBwRa194aKWoHv0gQ1gKes5oITdAvV9en9jDM11OwmvQIm
 lHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792258884; x=1792863684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ti02Ok6gQKBofcY7zi1eTsrw6AJ2jDAJ9RymwcdpwGo=;
 b=RERy+JJQLefm/NDPGj/sguhi+L4UlAUgzit4ISe2d9ci6zM0R1Qj+yj4LEf+/IacyK
 +u3G2nHWvsS7bcadBx/kz8x+I2YOYRYjNPone1ZMoW4JiZXnbAzN+Z3FbZa3izF/LmkQ
 z2KS2n45Zx736ebLtAqempYmsY4X+QW1pWVAezAZUp+/XR6bu/Efr8/NpXTl3sjYYYA7
 hsh7I3DEUDHSlHRcKOLnC8Ez75rsjuevuq5vcYYY0t3jo5XJHljr6S3tds2sHfpOVDQ5
 SNT0FmdXf80H7fq93I5uke/k0wOWO2Xha1EFSDS+9uXuLDQHw1sqVbtBhMU48QPdPE2r
 uOLQ==
X-Gm-Message-State: AFq9FYKlU/GEcCRmGYk563ClpFt+lYDDnPvW/kC+ikccKH4/iYQQdVUs
 mo3ZmADiAkSaBHCYAsw76c7mEj9rnnUl2XXqzvxgD2kJZJGUdsOX8ppZkbOsS0k4QrFbuTUeatf
 QyXHf7TybBbhF1CU/sZyKhhzP5wIqEMBZBkf6VWab7UolKA70lWIUQxGPlCXl1tPczQ==
X-Gm-Gg: AYBFou3QyMY3Q7T6fXWGZwBro9I1NVWNlKeh/o+ZS2qOGEREe8oD9+i5KrChHHFyeG8
 noKhVzpxJo891oSiPEywXWUzFHEioSCMx56lebFD8WdjdBxy8v41qPyfk0xl9bUEhgc7hYGQ+ad
 8N6VU0HlIrX3TjnxeVdj30IdUkGfE8JcSxw6ndHakqmWwYM3OlG5PPMKgISkfHS2lBEdqDIryiT
 l4fVd9iCFKUSVy2aWWNcKIye7lnwC7tHC9YNNZK7lNj95A0OrXFhF0tx5BSrfedu+a++LF+uBOK
 hY+Xj3OiOXS5i2c880q3Wz4igczPANKu2rR4FFMjLXjw7kLGuduk41rQFrO6sDuujLGwzGFPUCA
 SxalZZkAgVOU30YNuRgoK2ZvW7zYb8qcFzRgbrilUeHXcb/yumY1AK5udqdlhziw=
X-Received: by 2002:a17:90b:4c0b:b0:3a8:59d3:5317 with SMTP id
 98e67ed59e1d1-3aceebfb121mr2846190a91.32.1792258884348; 
 Sat, 17 Oct 2026 10:41:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0b:b0:3a8:59d3:5317 with SMTP id
 98e67ed59e1d1-3aceebfb121mr2846175a91.32.1792258883878; 
 Sat, 17 Oct 2026 10:41:23 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f19d9sm8838862a91.11.2026.10.17.10.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:41:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] tcg/tests: add an alias for all TCG tests of a target
Date: Sat, 17 Oct 2026 17:41:05 +0000
Message-ID: <20261017174105.25814-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX8hCnRhoBtQsD
 q4o1QWAXUQFwXoG0ytbRt1vmWhlrtfVt+zcTfztDmHCbc2SRo1EOQ19FThDRPWZk8z2ndAYMwRI
 6Ya4WoCL4fxe4gjNDd1oFplYvhYu6Og=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX7ibfPmWmeIIN
 hmdjQonAqnEVrt8QLqCYP5fmtTCgGEvnKxrPHq5MG/chU53ODAUI8O3YqeKAC3mc2N3gmuOQYZt
 kOsKHj62iXnrju/ET5y6YTRv/GU3IYn89Zp7TCEygjN/GysFQgDKT34B0X58kKl8UzJxc8wGCHZ
 dhxWbpIzGWFEqTLf8SeKFdvJnPh024IP1BnRGT/IjPWSxt4IlC5cRxoiG9nYKEMf9iziB1seLPr
 LdQEsL+R0LBZmuC4vA1DXp13gGg5qiNfJAxQqxXtWc0IJ5Fe7VG8IZUP5/Ds/ceG84S3rJnpqqg
 3+RPMLzy8howsKQioREoOyNL3NKJ7XNzxg5sdTqX7xAnpVyJDbpqErmt2M1T3KrHWhm851YY/mr
 PjEvUEQG9wfLRI4rOMh9iulHzdAknAuW+uK15U/XkeN+95KCHQ8dMjIba8HkmazU6hKgUYdwAZ8
 2vMgSG/NQymxOJgrEMw==
X-Proofpoint-ORIG-GUID: 33O5upwf2P9VWhA4W2IoTPmwyCqqLxYo
X-Proofpoint-GUID: 33O5upwf2P9VWhA4W2IoTPmwyCqqLxYo
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad3b345 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=8qsUK3cBa2MkJvFa:21 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0KgTr8bgyB_iJYTNZf8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170070
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

From: Paolo Bonzini <pbonzini@redhat.com>

Allow building (without running) all the TCG tests that are available
for a target, so that they can be run manually.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261017073952.1346449-1-pbonzini@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/testing/main.rst | 6 ++++--
 tests/tcg/meson.build       | 8 +++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index fadb376eaf0..b0ca37fe2ba 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -1035,12 +1035,14 @@ See :ref:`container-ref` for more details.
 Running subset of tests
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-You can build the tcg tests using::
+You can build and run the TCG tests using respectively::
 
   make tcg-tests
+  make check-tcg-$TARGET
 
-And run them for one target with::
+Or for a single target::
 
+  make tcg-tests-$TARGET
   make check-tcg-$TARGET
 
 Adding ``V=1`` to the invocation will show the details of how to
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a0719600af4..1cd2d421cea 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -198,6 +198,7 @@ image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
+  target_exe_targets = []
   if target.startswith('multiarch-')
     # those tests are included by architecture files if needed
     continue
@@ -452,7 +453,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
-        exe_targets += exe
+        target_exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -539,6 +540,11 @@ foreach target, plan: tcg_tests
       added_tests += {test_name: true}
     endforeach
   endforeach
+  if target_exe_targets.length() > 0
+    # finally create a top level target to rebuild all tests for this target
+    alias_target('tcg-tests-' + target, target_exe_targets)
+  endif
+  exe_targets += target_exe_targets
 endforeach
 
 if exe_targets.length() > 0
-- 
2.43.0


