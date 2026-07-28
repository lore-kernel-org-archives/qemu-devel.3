Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391E7C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZgB-0006P7-UJ; Tue, 28 Jul 2026 00:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfg-0005Q7-Uk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZff-0001dh-0B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46Xpe1821214
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BGS3VTO2+0F
 49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=; b=RYAWdCHdyNQgfovOQdzc7AA8euu
 PApk3aXoXdu/LnhfOnA8fUhtDxbQnYx9P+294Cq8OLPuZVa7ZYI4pCPCrRdkKEkA
 meSHxZ72zrAm2PcCU5G2jSCvyuJ7FLnThwRP9+/5ggJMfguy4m87nkQxXBtppFXq
 tUBuhl+V6ejpGK4LJdPScRpV3cIncOXdTvOqhTjpNQq0axle4axcJTOIBIZL5D1e
 vtXk/D09YuDN/ypqvks9q7TACK3z6pgjkJHjMd4odxm7zDIyCDAaQg2lKZR33F+L
 K57FFjuCpWxYEilsLO/GlqT9JAmSYvMOE+mDjlrnVnBDxPg6c+TJW4O8eng==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y03gf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso73887025ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213831; x=1785818631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGS3VTO2+0F49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=;
 b=SWrIZ9clB8jRG9ky+J2sXMqd42Ty40QZJ07OpgUp2PNq5CCRXncvrF7v8a/3HHaShO
 2pW7yej8IlgDPT4pubxgdfP14n2tMZYtIp8OBZGdgfjyEdMNAFEaHIOI3mQhELoj45Jf
 1Ng3n1td4MNlU1wCo0gWPzonr6pz0ppXxYfljEVdKTXqZznO076RikNqm4wRrBTsH2vN
 eabWwKTCwuyaUYzGzHaS5cYYOlt4DDJDWfn4x2AnOkpZqW9EwWVn0oEdQ/PDR36fnumX
 Ul3NYF05SWXcFCmjSlJVo4l1GYmQ5A810qxFJGH3FtUG5U0pJvJFg2ThszXIszDGefzW
 skaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213831; x=1785818631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGS3VTO2+0F49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=;
 b=QCUAt3Cl01O8D1YZjyy86poGjhGt1uZnWgU04ZL3MUQC7NnGgQR77hLMfAgIjK2irK
 YmI/2oki4up7FHo6h+ENnnfbjgTD/xB1ObWod5wyI+lhKfScQs13H16A2aktxTNop4Qa
 oCDdnpIPWFyWKp0bCFa1si53o7CCXEonkGiEskzMecO1vAj84FjsBk2yZUdXaeMuDCWi
 fk8RsQNT8yYauA1IjaQHHBAmDLMV/1d3kdJah47zwhhIqC8dlfaWDjGAfvBRotVJxTEe
 4gCFBV4fktBC5VUW5Uu/tRHJ8l7YP2RTyt9qxfRnk+0iGM+nRE0cfu0CKag/RLnYc86U
 wlBA==
X-Gm-Message-State: AOJu0Yz6KVbvSYulDkJLEuUQ3GqV29WuRnbWmiJjl5rI+Cd46xnaUu1P
 a6EA87vwsQ+b2j/Xl2olkiQc3SuA96y0LNO5Hjta1UR6CbmGNgP9AwLbT5KF3nZaPSqF52kcCGP
 UFD86T5JEWD3Lpsr482yLJUXVEOfp4pZJFkrDxKctbO9ECKiQRlOIySyrZZ5c7XaBIQ==
X-Gm-Gg: AR+sD10ShiSTxbRSaJLPNRkcdO00FEsZNzx8JNt5N9VX512mJaVdGVwtloa8bZlxX8n
 j0igYn7qlUR2hzUoe9KyCDgsuO+tcfM550UIVTjdSXL4unB7arsFLX7Z/zKoByNdKOAgbmuoxrT
 9IcrKtl/XSwZwxANK5+iBjs4/cS73PgRSVtW3HAl0b0GvQvxxO7bcqz4ejUMR7ovuOEnHhK/Kk0
 Mwnm8CC3UvVGL5Es7oKFDWc16MxEgvienhK8OSVGV5G9g8eB5FEx2Ir4RjCRCDF96Y6XvteRpnF
 IHZ7t6jStJ2eyEP4sVcB+VQa1lbKbYLKmT37uKEEOiubt0G+4u1053T/dk3TgHXWNcE4WwM4gz+
 Q90aY6tPBJjt3P4azTn8XkBSWHe4psCxWgAha8ZMqpLMd50i9pg0nG/CrCKOdBoRsEiSpm4Y=
X-Received: by 2002:a17:903:2310:b0:2ce:ceef:661b with SMTP id
 d9443c01a7336-2d015c37be0mr8722915ad.29.1785213830934; 
 Mon, 27 Jul 2026 21:43:50 -0700 (PDT)
X-Received: by 2002:a17:903:2310:b0:2ce:ceef:661b with SMTP id
 d9443c01a7336-2d015c37be0mr8722525ad.29.1785213830431; 
 Mon, 27 Jul 2026 21:43:50 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 033/103] tests/tcg/multiarch/gdbstub/prot-none.py:
 deactivate on gitlab CI
Date: Mon, 27 Jul 2026 21:41:37 -0700
Message-ID: <20260728044248.137626-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a683387 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=3V-_cSConhulDen5wCkA:9 a=O8hF6Hzn-FEA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX8QE/RHSeY/jk
 eHGda0Edwi9gCEawkW+wXpz4evulqyggg122V4v/FyL80sjVCfa8RzPaqxWf0sOsoiCJPBR0G4K
 BPHFJjw11w3ryDBPCZyYkvFf+09voqQ=
X-Proofpoint-ORIG-GUID: _Y2vvM1xl1KxpXLIujJ-CcxP8YV6Zci9
X-Proofpoint-GUID: _Y2vvM1xl1KxpXLIujJ-CcxP8YV6Zci9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXxigtNVUXBl5g
 7yovguTVZV3MwZGnUY0q8+5DEQEYU1u8YKgA9jBCiu9u/Piew9DbTe7K0c9OGIRNrqYU4meX73y
 /2awBp1Ar2sQqIT+iEdideskTOHuCIplgyGsVgJ4BBGoA2rr9aPkAz4uOmZc46uN/tNMUaHux5w
 IqO8L0N0Acv5XE4nojcm30R2gLjBHwmu/BWJVJfQFpL7J/1Ex5C7uqcO0JD4wWEmlyy+e+RdZeG
 P61QYZrCmY5E2D64hHS6xS1R5t/O+o9/NIYU/AJ8QPAe3c9411gS5GVyJk8+Bigl48E9FKxhqPz
 iKVR7n0TGq89bmHvORbao37xvEHUWOf7p2PfGqEpqxPr6vfl8qQpe5l/kGtRn+BWvMHOgl81npU
 D/+lPtHfO13cZ8NuWjFpZT3CBoxTye1/eebVDZVuj7G6KfRhjQ2PSZDM3MiZoEPJt0GcdEWVyD8
 gGq21oqOjXiIb4lmZ3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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
2.47.3


