Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893F8C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNY-0004wJ-UX; Thu, 27 Aug 2026 18:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNV-0004tg-AN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNT-00060Y-Hd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2Eg3848482
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=; b=Ic6NQU46Ld5agoLE
 Lietp9GZ3gDTUWkfM7jpZMxhTJPyDqjl3g2G6gRmPnDHm0MIya0p2sZ9BMTlIYWf
 BdoQJvRcVWQjPdo1g49YTdSG7kNkG5XU4hW3GAgmUtLRIPCt3veHWaFQL/t3hX1p
 /wuUvYs0TzcnNTH04ZCJXnTF0oUVtIA3Z7gJAJzr5OYRgGx98ZvFAVHc2KrNVqDw
 b1ImuEZvpSexKvL53QMHRBHs3Khn8+dep5909/7T8DtwJ/KmJrOeVzrjCMKs5r2q
 zSGL2T6zlFFKsvVY68iEv/CaV6BrCyty3RW6Rm84hafSk8oxYKwkTcuXLAW4JbEt
 p2p8/A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0tv4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84eee2147ffso252420b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868917; x=1788473717; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=;
 b=Ct1Jn7BSElnXIVaGh6dHUpUcW5N00DcKrX1G5gzyW3l/Np94/VFtBtAhzyP9PsOpXJ
 +x1YRMahQG+I/BBkE9GzkkKaQsxNW26TQk65uoKBalYS1ltm0q03pt3UWnmB648G2VL6
 fwAFTgq5QC79jg4A+KZknYk7H0mS4PRgIC/sYLWxz4HgWCvcrhJPobVSySjo+iBzogR7
 1aYrk4EjUWcYn5GlDL4l6avRoTX0UEmkpz/L575UrpJE3t4SrR9phCRWaEpb3bW8rq6X
 d4fG5B/uBZYkKdhiekpdKzSw3vmJw0CYrEaEhGkdW5l44A1x3iSPCAvq+NSGQn8qG2qX
 7W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868917; x=1788473717;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=;
 b=DzbyJQCusaKpIG57t+E+9ct4quSTz6NQUwyV6lbv2LqZ5aBayNOdRokYYVfVu6N8wP
 Tx+FAaBy2h5cyj1iMBXM4Uiz53SnCOQ2j3D/IjjfxlOxY/WDcNfCH4OBEaMYBip8KPaK
 TsZn+FcZ8ZhGk2I2781jlOkeHCUvKvKhDUhKAf5ptmjM0wCWAG0JdLchTpFaz1MuYbTX
 ofTawzWHc5Yfs1OMFKwstRqqvpowHW6zwox4oRlKvFhr3015V2NbSYOFPnFAN9hQ8Zzw
 u3QqvQxVaW/5ihJP/2g11VPKEk03VUkfChRbeYwgUei6JKzpjVAA3IFILCaPeLBHn6X/
 qhtw==
X-Gm-Message-State: AFuF++nwF83u2tBQm7uiYzN3xr1b0XlEkCLLLtcBJlHi0OoLMAsaGFgc
 GU7CPkP4rUQ95wholAH5FgCoGzvDlAkRN+4Ulin+yFepiij6kD0WEaipS4mrL6iHy4mKz7pbr7q
 GgT+M34iNG/As3UKmXDtcY7bFfpYMHYZxKgIIM6OsGwRkNhXP/1a9NuZAkxgFSEZj+A==
X-Gm-Gg: AR+sD12ZwOXCW0UvjVpD5zZbsXad5Qqq9Wf7oGVlwfSZzTW/RpVVbwL/KRhuR/uir3L
 tK/QLeOmL9s6SdGfvf09ehCZJBr1kpMCNCDPSN2grGY/BQ8GHTfhES3S10vIChqyBWoJtDLrr8q
 MOU1hBgkDGysWF0MgvbqAy9D5d9hbwEZXLT4T5AVQ0NVQNUPJ1Ck0vi5tvABfdydb7JKAh5LMzj
 GyLVRhxh3f8nS+V80vU1oBkTbNvM7T3DxGBM2ZU1/Tf2T8I0w+V1LGTfLr6f3+SSzGjuMgFNwKI
 sIjTGIwAlXEHekN8xV9WhOlbXNUuKsBte6dWKKLM7KizYKJLVKo39KUPMmlsLMzcdKrwRJpRHmV
 BHJu79fy780Oog6mIr77Cu6MqSJIsqNTTYAGttfmjSiVHnxhJkL6g79b3dEw=
X-Received: by 2002:a05:6a00:21ce:b0:84f:a7bf:8fb9 with SMTP id
 d2e1a72fcca58-85626e0fdc8mr4578340b3a.3.1787868917115; 
 Thu, 27 Aug 2026 15:15:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:21ce:b0:84f:a7bf:8fb9 with SMTP id
 d2e1a72fcca58-85626e0fdc8mr4578244b3a.3.1787868916638; 
 Thu, 27 Aug 2026 15:15:16 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 007/105] tests/tcg/meson.build: introduce test_name
Date: Thu, 27 Aug 2026 22:13:28 +0000
Message-ID: <20260827221506.91574-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX9f+LyN++Q1le
 nz2xY0wfj7YY4bxwhAqOk+tN7N6fDbySKxPMqCdOFRAXJf8eT/Wl/4EOiInpuNX/rsWq4UDteeS
 nEoAL9CJyEJRQUryJeavnDy5s4Ky5DEFW19LpBvQVyq5KvSYEXP+BnvpZPupXn1cyuqRlN2qXmZ
 u1zU3QpEgTdNBXYwj0//1YPKz8AHKXOJPsokaWOn7xLziSYKIQnfdNY/RJIphowSQIQCRqbDji3
 EodcizrEgGZALqeJnFOyjzaianr5b6XBNvKNnEAztHQimqvY28UeSswq2iFDdOJZMpmgYw6xfDv
 DHEOBBvE94FCRIjPkeTjmYaSYB78Ic3PKpudEMRT/2du4GwoNRHBVUSqAwDtxlLQj6/cWSiQb8H
 TC3fJMI+kWxmlW8dSRuuuzEUVelEKQfGKlmJB/gFk83p9qUzBP8mKIi9CDajRs8tpGN+MfwwVv7
 VM9E5NW2qkzRR5z0xeQ==
X-Proofpoint-ORIG-GUID: A9zQ8_-CIB4leAgNXjcRfFwTL-7FYDkA
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b6f5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX//QxIjb94ggU
 RgSip0wVbxeJy3Lj5oes9YtnJyXM42FWTWmm87YoLc8YSYxBAN/SGLcvN9xx03gnFQ3o5vI67p6
 lLgzL0hpX7T3xu5XVUbVCOz+BLVbk90=
X-Proofpoint-GUID: A9zQ8_-CIB4leAgNXjcRfFwTL-7FYDkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 697b826a382..ae7ec998f63 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -12,6 +12,7 @@ tcg_tests = {}
 #       {
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
+#           'test_name': ['provide an alternative test name'],
 #         }
 #       },
 #       ...
@@ -21,8 +22,9 @@ tcg_tests = {}
 #
 # Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
-# is guaranteed to be unique also.
-# Default name is derived from src if 'exe_name' is omitted.
+# is guaranteed to be unique also. Several tests for the same executable can
+# declared using 'test_name'.
+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -52,7 +54,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name']
+        allowed = ['exe_name', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -67,8 +69,13 @@ foreach target, plan: tcg_tests
         exe_name = setup['exe_name']
       endif
 
-      exe_name = target + '-' + exe_name
       test_name = exe_name
+      if 'test_name' in setup
+        test_name = setup['test_name']
+      endif
+
+      exe_name = target + '-' + exe_name
+      test_name = target + '-' + test_name
 
       if test_name in added_tests
         error('test ' + test_name + ' was already added: ' +
-- 
2.43.0


