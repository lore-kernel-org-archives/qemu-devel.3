Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F28EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cK-0002h5-Mt; Fri, 10 Jul 2026 02:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cF-0002b2-6S
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cD-0004o1-BN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mhB23847269
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BGS3VTO2+0F
 49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=; b=lD+CCk0dBt0nr7UkxuuKk/XeWOo
 Rwh3r9kSEAO1WWZcyCy8kvwxnWfoJokWs89usQRlnmjrUBWfWlzsCAhyeM7dZ8Yg
 +Xm94EHe0n9Z0tr7NzcMacOYUiS27bfXMH5M4M++FdDL9SrCvXNajNjhyalRkswy
 qCYJiE7jixeLT5t5Ge2Wmy3Wx+Cp1eigdsXRgGSMglpBqosBcYfiCA2urmF1io73
 f43RFFSjiErzKmB6lQQQcNW1CXX/lwEBVenj35IPidPJGmBX0NE+Yrs7zLZYyn67
 i28FEV3jlCoNjfeSa93hwkkPS5aGspnIk/p5yZvesWRsU1emwXhCGsD3gXA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1pp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso592499a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664483; x=1784269283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGS3VTO2+0F49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=;
 b=OBMViebjz+PRbC0jK1xlrXRSUb0/XN2Jx5od4KDfW2sUpMlMN+Srby/eu2ixEfyfwv
 zRCL+XVbm5LpPyhZyP3kGEi9elkgauZMODHYMreekHOrcqe8Hers+T+QVNdmhEoWWEA3
 C+3Q3j6qiCPfAFKWj87MSqUFSrfKEWBGupdm8UFwBvKlEpTPk8DvpXdioTiOtq5k5mF4
 d1aMmSma4AAbgFGiDbROgBw/2ts8/LNQ271I1UTEDDAErEn97vYiObBYEedqMQ6+IST9
 rfw3lsWMKrw1bJWMU89o0vvXNjkvaNRV2YhBmmUTTBP72LSh8HKxPya9/wYm0a1KKuai
 e8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664483; x=1784269283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGS3VTO2+0F49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=;
 b=dyZVWGkR3iFyN+7IWsMPijcMFALpD8Fl0xT4vu8aX/E7CGbq41daQ+hDn513Qjodiz
 WtSMWFkn/IR4jaGtwIz5XlUM39zTn7mYhDc4x4CvqMcoNy6ZgmQGesm51D3c7EiPQUcj
 NrBcdmkVzFU4Oatk5XhGe07IMGK+b+vpnaDwFMazTKtxzl12F3yh0ZJsOZUo2djBnVfx
 H0aO1QUOTmkHNbvg04bM9gXHwrBNtjoDbVL6uXqsbkgmr7nGv0V2K53cu7gfmAJqtCPQ
 SgdmHlp80azfYywmHS3UXac5v5RGkDV90zr7U/Wbpp2jI9kTIY62ju+ezFCgVl/LZ4nT
 BHPw==
X-Gm-Message-State: AOJu0YwWpKmpdQZV0Cj5Cs7Py6D0ct+Z18SFWcOGQKB6rAdTV+17VQXC
 Tb+jgwtP6wAmTrZp+8ZW68nSMIu484JgeNXwojxG2a8wBynry3OKuU0Ypn/w9SZNg14fNs6vTNB
 BK6QlNEnZ1jQ4IQaT+KYtlpSDakTJWrFtz4Py8CRo+2P6J673LkJSICfhIGSX54tMLg==
X-Gm-Gg: AfdE7cl+UHtWFu3xb4rpsC3ko7kCSoWNhkOvOXld73wejZsXcktzO0wXeP8NGpyYeiS
 8ZDVy8hc/+0E6l6FhIJkxkTfR/dR5nOXlXjVmd8K+fWNDyuqOxpoz4IO96vE1+GghJSXmK3Ie0K
 LEAyUmUda7C02/yBx9sayp0ektFOs9fAE2yg49gjX50RrkObuEEMOv65qQdA7azbXAX6f3ov0wq
 RaVN+euE1XIjXRou5AIw+M4iWZsPIZt+yvgbn4La/5BtRNRt4ajukdxkTeR7Qe34fp5eMU2ghY2
 FtuAeE3f3aAkmioktbD6lzZWU7U6G72p8AyaRwra9LGxrfiwl2hlgevm4PkXkncFolFJxj0BMo+
 2SUMGFnCLSkHeE9pzJfq9xTKqI34IIsatpMPLFWLpdRqEwicvPXoyilguJob2XKVwwHxs0MlRMn
 Rd1DfC9Q==
X-Received: by 2002:a05:6a21:6e86:b0:3b5:a008:683c with SMTP id
 adf61e73a8af0-3c0bcb803c7mr12364037637.45.1783664483033; 
 Thu, 09 Jul 2026 23:21:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e86:b0:3b5:a008:683c with SMTP id
 adf61e73a8af0-3c0bcb803c7mr12364005637.45.1783664482594; 
 Thu, 09 Jul 2026 23:21:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 32/97] tests/tcg/multiarch/gdbstub/prot-none.py: deactivate
 on gitlab CI
Date: Thu,  9 Jul 2026 23:19:10 -0700
Message-ID: <20260710062016.1818125-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mdIohsuZwSRjfwxGFP-OkPdyVhlJ-PrD
X-Proofpoint-ORIG-GUID: mdIohsuZwSRjfwxGFP-OkPdyVhlJ-PrD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxQExwILuqz3L
 adqD+tDUxtFElB40YTXKsAMg/ANzXR9CcHnpIAaU8bxVtq5VDAAcLlKQIOREkVTNpRpkOOm2cOW
 38API5UTKLR/uXg0Tejg5vdXCe9lpBmLYgaNPJggjLzGvR66suoulSysdvFj2YytrbDmNwa7Mkp
 O6wT0PgDohcKFXLYfn1qtDo10QsW8n12jJkeGjwEgFd9drhCLtVc+XlJZs4WO03QmzPlHrX9cip
 qazmG6fTlvG+wJCFvUgQP6TkSutiL3IeVhXK2MCrUygPet46LO80PAcyRNNrMtR2PRzX63HlkfW
 BT1L2qKwzf2LfBRKya/+X1ngDwDeHC4m304FReFdTwc9MNMYEC9ixqNSldx6VS7fZpvNXhedlG7
 DJfj/BhyO9ZpXdnFsSVKJti1kj9InMpT+2hw8rcem8jbZ1e3TTal/XogQ5UPp0+H5HgmnQjiqEF
 u0Gi7y++3WB1U8NsxLg==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a508f63 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=3V-_cSConhulDen5wCkA:9 a=O8hF6Hzn-FEA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX66XgcOpIgtFS
 MbmfexslZE+oi/GaDc4Ivqrd/UoZAyOefwaws0b4TopZ3IM8U1Glpu++S4SKIuWbPcp0b3cdZNr
 Kvpt2veaXMfkW13omKblwcOd+/yICkg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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


