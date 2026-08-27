Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E575C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziGE-0007eA-B6; Thu, 27 Aug 2026 18:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziGC-0007cs-Qd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziGB-0003bb-1a
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM0hv653931
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CtHOVh8M8I+QhOg3ToWiPEwD/PWXCo+DQ24/J3EvnJU=; b=W9pPiyt3RU5KSxWL
 rqUDQhsE/MCrGmZoGFiGrAHbJRS0Sqm+fuSawmYC99uxAEyJ9QMuaKH5iazt8tfk
 EY4iExmeoc4zB+ak5Ms7GzS6cB/wfCc8lDLP6Gqtf5q5QriUFUgkbUauHxi3tfhb
 B5wnTYfma3pgQPvGjLBtVzPN5Gc9xNyqwKOHVJcLu7l8BRqPWFN7bGlotMeQRvG8
 DJzPliZkoH0mUZ0ajJy29ARhTPQ8RfKvIGa+QVXEHxvceyxqKRCFDQ+rmG1fe5Q4
 OcINcjC52lh9LUv2qHHsnPQdZZDL6p3QgdWRVut5GQVmWQvF3ZlsQE0EKXiMxEC2
 t/Kesw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuj32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84c4cd31b51so2030248b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868455; x=1788473255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CtHOVh8M8I+QhOg3ToWiPEwD/PWXCo+DQ24/J3EvnJU=;
 b=fkyu9rut3bo2+H3n9en07equQoht84KuQHc5svc0ilKiw9LfOCWPlc9qyoM83tN8Cg
 MgV3PG68mZGx1DSCnjF9DeDAgu5kFc6MfwHuSosvkJpi5h2hWDX0/vqQHBEtkT/ZyjJO
 ApsLvwW0CcPyvbILwy7Lfre4RNJOAuV0PhVlVDjiysvpDyVW/pqy0XGt8kLqqgoZS8sv
 YwqeGbvZixnCKysxo7lhHc8QKeaOTIqQL/T7TNSitGjQUToeThiRn1/3e56AAvoQuF3W
 EjOfYs3bep7G+CLkNAMBnCZecrJwKCELQ+qmLB2yGg5z2U0KFdvBIBy3vz0PR/SJMqAg
 7vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868455; x=1788473255;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CtHOVh8M8I+QhOg3ToWiPEwD/PWXCo+DQ24/J3EvnJU=;
 b=ay6+/32G1k716n+OBiXFPGSZWSPwB6ALgNvH4Wx+s4mRsGIqn0bEKudyB0XNAn4PQo
 SrrTJxJhOQ7Da+OkyNTU6fYRq/4SPwb2PLG9jpPWHA+nf0pX8EZ95ub/Rg47INMFdZL+
 0ODSV6QoDjuAwMFunLQc2kRDmNgNqmRscOFLQyWAzN6b0saRPCPAlkOiJAVR/nhkNgWZ
 QYE3ytW0Zgle5Gh4DIsMHK2q0bjfH0+jB/r5/sxn3NM4Rx3ymb7vhW3oWiEL14QAkSRG
 irnShpMicmTg6MtezX5gpihsTBUiztL9oy6PMEP4rYGD8y1A2zsQohFF7nPlwAkYmy7t
 335g==
X-Gm-Message-State: AFuF++mSm7Oe2j0MJ/xuJmQyXy45arDpGXibIiDOhw2eWToGvEL9p+KJ
 bZy7h2T5lxjojxCIsO5bFhwSdPTYrCVcV3gR+DLXf2IdzNTUrG2iLh15N0d+GL5yPMPKATJ/im7
 ewl6NgQRNvCmKzzU0tu8LUnKmfdaKatL5BmsyExhEox3jiWvBAcoBln8wIHX+DDy3XA==
X-Gm-Gg: AR+sD10+6jvYnrjTbVmQ4N8mfURyLmgkHx2KcATORZRjhufHl2RX+bmOa3WfW4wcM9n
 pzUini/3v2MUYM7+ykKOnqHVCtXft/Vft0Wb9We1vLBWOHWRtakrsNVjXeAP9Hek1m4dJBLCpe1
 ZoysROzTX9il4SgjE4LWSbciWFQGuZHwQKrC4Z1cdJooCNPur5UGe20cXvA1lJ6yVhFjXb13ESV
 N99giZTuDRcoTHdShgJY4h+Rxzlo2wq3qbedETuJGY1WCgWyNVhLOtJDAXoGvaqno8nn9k0s0R3
 a+xsThxMtjJQF6IEyNxdzuIFcMYAh0zf1yslXNOFd6vZT8JR9ExXV4OVEmpkLAsVhmOgIZJ1Kbr
 BHVfBoIDbUwGR0gWOC4Z8jKjeBTenEcfXYoOVua2bb/JeeKjC2oBxrHzfmCY=
X-Received: by 2002:a05:6a00:a585:b0:853:90fb:aa6c with SMTP id
 d2e1a72fcca58-854c6485748mr13461428b3a.2.1787868454960; 
 Thu, 27 Aug 2026 15:07:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:a585:b0:853:90fb:aa6c with SMTP id
 d2e1a72fcca58-854c6485748mr13461338b3a.2.1787868454326; 
 Thu, 27 Aug 2026 15:07:34 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:33 -0700 (PDT)
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
Subject: [PATCH v8 034/105] tests/tcg/multiarch/gdbstub/prot-none.py:
 deactivate on gitlab CI
Date: Thu, 27 Aug 2026 22:05:28 +0000
Message-ID: <20260827220641.84885-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EQF3waR3tbwKnya_MV3bUuNoiGoqOvgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4wJd7iWWVFO0
 6YGBJo4o8Hpg2h/kxNNJogV+ROnJ2Y0Ek16BInV5sBMLtU9MEFgxD3x8bQ32hYUXYjQlbTbIB5W
 zZJeqSYkYcKGje9U4wRZYtdASMyY6ra0r4fe4GDUKZlh9fsD22TsiYsqBHgsM+qyzHWViN+bY9Q
 2YhyJGuGmlP65k2W1NEHCDjGnrFIbCApfc6kjWrYezN7qxGWFxvXjoV5ro3m4uom35/RoPuoVZC
 01kGr7OxAYC1vKjY9Wtrx+X6pMRKUfo+Nqx73WpOWXTrvJHzBAT53IF4v7yIloxh1DeUJngZcOQ
 t/HU6/3eh3jYxqne/5q2jvrGZ0ZVd6qiYUXcENQ8A5wBYJCUKKZvdacFILc77OlkV2gGcDEufDX
 5KMay8lgm5jvlGQO7iMD0wA+lgqyoozzvvSPGHpfouSd01ySFJpthvK91/sRAgyQSY4h9Q9JxP7
 ax374NfUHwxAbsJhyfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3nThncIrJUbc
 5+GzJrhKvKuuT5oow3BQ0rc1DN6dn6LhrBgVJ/GnG2mDYECssoZxV/oxo5QAsgvpbQ5XLXdu5Nv
 ESQi/brHm487SOA05UtqpfvqtZ0qbZ4=
X-Proofpoint-GUID: EQF3waR3tbwKnya_MV3bUuNoiGoqOvgE
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b527 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3V-_cSConhulDen5wCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
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

This test was disabled on Gitlab CI.
Tracked in https://gitlab.com/qemu-project/qemu/-/issues/3329.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index 51082a30e40..e653bc697f6 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,6 +5,7 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
+import os
 from test_gdbstub import gdb_exit, main, report
 
 
@@ -21,8 +22,16 @@ def probe_proc_self_mem():
 def run_test():
     """Run through the tests one by one"""
     if not probe_proc_self_mem():
+        print("----------------------------------")
         print("SKIP: /proc/self/mem is not usable")
-        gdb_exit(0)
+        print("----------------------------------")
+        gdb_exit(77)
+    if "GITLAB_CI" in os.environ:
+        print("----------------------------------")
+        print("SKIP: fail on gitlab - " +
+              "https://gitlab.com/qemu-project/qemu/-/issues/3329")
+        print("----------------------------------")
+        gdb_exit(77)
     gdb.Breakpoint("break_here")
     gdb.execute("continue")
     val = gdb.parse_and_eval("*(char[2] *)q").string()
-- 
2.43.0


