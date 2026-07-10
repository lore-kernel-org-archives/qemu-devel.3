Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271ECC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ26-00067x-9m; Fri, 10 Jul 2026 17:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1n-0005bg-EW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1k-0003XR-VH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKsLej1947659
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RENocWfeGiq
 Phcea7l9hD/WefChNKrDnhHN+Miuw0nw=; b=P4WJvnRR2WLSzFHLFz8YIv7QWYc
 kmMNAEzyzy531kfyYjzSxAs7VJ48BWM9jJsqev1PXb/SMbkmGMsQC76l+VAi/Y8B
 WbUm61gdBL84aPcfweEkuJDj1Dhc7fegSiNFmC2dJ8IPjAGf0Bw4B4bDvxmebHrZ
 F9FizEp5S2y/0bFTjfwklDuOtVcrXNg6lfRgTWBXhyUhA6adfYfbYiwT7WxvDa3m
 j3bchq3WiRJ2moYm2NwH8BithP+6sP9X0fL6QT0DwdrpBmyEIzke1vEVO1qkQBVB
 O8f1rDoOvnxMhy57em+NxRZYj9F2vP+HF8bNj8nXUmDsxHMmHK4DqdU46AQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg46s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so1580956a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719885; x=1784324685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RENocWfeGiqPhcea7l9hD/WefChNKrDnhHN+Miuw0nw=;
 b=GatZNvrahFgQ9D+/C0vwJEwwo/VM/dtnvxry5KTomG9DU8QNarvJOLLIHjT0JuVUrz
 PYGOsGE4zI6R8DO4WG3LqEaplKaVtzrAsY9C31tkfQlNU7oem78OMdmAMVY4Do+TtKtZ
 nnfwQoCfb+oPxulQ1FfMrUSPnTdqrs7+E0O6ZvBWdyw0uiCEb4Ogg4/3oM+i1h74LDAX
 h6OvGjU1bwa+fiDuU519dapqDswZuyeZC2O/nuPSNfZ9lq0eIdffGXMAD2uISUdTU4P1
 +PVt2cX2ZjrmuAn3CD9U9bMtluEjCTYOpo4yKaIIkxj3FbMIm/zRT/wEezcfggTeM1R+
 a+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719885; x=1784324685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RENocWfeGiqPhcea7l9hD/WefChNKrDnhHN+Miuw0nw=;
 b=VBzVhyhY9mvs3H13WTeAvsoSZCZ550EZNQRFNie7d/dNkOGtrR+o72M9zX3sP12kmY
 Pan2TJLsWAdbPMhe7O4tHdqDZm+ndJtUtrfm+Ry6c+8kCrKKDPRAfVvAMDp5fFjhNW/0
 ZCySmu2z3CrGT7WHICPZIik4ZsVN2QfnS98tnFD7B8JxRTzEWQ7QtXc4cpoh/auNUaXq
 Gmv06BiSf2Vhm+i1/MulCANg2zv55/zoZyDyFh0lGIWbfdNc2Th33QkLZjbL4CMO7dIh
 nGc+s0qTtSUahTqc92xjSO7OVvgMBO1KTMFeVcRj2VCsUhybBOmNT2HYWvhuifPHp7RC
 1xBA==
X-Gm-Message-State: AOJu0YzssAZqas1Zdsbt+xzzjElXlBr5VEd5wb2xg7iY///U3Zax2LJK
 9zyqo0P3O4l7NtAyfVqJgfJ/S1H7AUtMl9oEnNORDu4kSRijrBbO4InMiJ02UxHHr+rETZANoNV
 CljjhklJleMRj+h0/Kx2jF353irWwRXiisRCbvSxQoAwpC4+dgzveptHVgg7HxWy8Gg==
X-Gm-Gg: AfdE7cnc3YTxCVv/2nIo4UMC0QkPYPl6MEDK2qukR3hzrZ7impzTfNuHY+7OahkxMPQ
 DqsNISIflPsgdE6x6PumxqaK5Iuy8qLz3utcP7BshrU5JImEjrbNdSKwW1GIMass8gAI6tWYrdm
 KRIIm1a+LhhxQpPCV74WUjh4tT/sXZbWHwnsNLbYMuibIzTZ06Zh3f/xGvj2lV+HA7axLKNitoQ
 I42HvaL+YD9BQiZ671PABSVkHATaLQ+qkuEVK8GUEEiAH3fSaNCMGYW5i+ZgzLJA+G1WxX7kh/v
 dLaw9MlsMH4jh5KjXPthW0tzkdD2r09tyksfMu6wzy1BZMAU1BRXj8lkziwmYkjhsAd2n8/xtUV
 3sKtMuPqpKXR2YX+IVu7LWnUkxy5mXYTLxtSuapmOMpZ8rhyTN2FKQwCfHkeD/O4+vczq5MnKqD
 iCAnkpPg==
X-Received: by 2002:a05:6a21:9216:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c110ad2ec5mr683244637.37.1783719884989; 
 Fri, 10 Jul 2026 14:44:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:9216:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c110ad2ec5mr683198637.37.1783719884519; 
 Fri, 10 Jul 2026 14:44:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 29/98] tests/tcg/meson.build: check host cross cc is working
Date: Fri, 10 Jul 2026 14:42:33 -0700
Message-ID: <20260710214343.2065491-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxC6b3TCrxWP6
 SpSi88WgiQm5qHqMZlQakfONJqgr3/r3eFUmjrIOIJO2T1mhHjyo6M3KFEDqm75rm9wh0rztHi3
 3aRq/R1UGbWDup+lVpMJ57Hk+SOZxB7ah+lltUY6i27p2lT/Q4dKzBdT3bKHmw68Jk26uXrNRez
 6GhPJxvIS4Ab6rseAkJqEx5mFpEGIhGl5XGC5NaGDWGCKJTzkTJmUVH2/Tha1HW4xLWRwiDElMU
 lAOgyAZ24RRC9XH78+AI7TfJ4apLeLxMkJb4zQbFhlLMvn0O9PPOQRYsnSS3gDVcn772OlRzUma
 VC/ebxtYgkpGRO+PUcTLeXB9UtN62MuAW290Hjmn4ncv3ICVDPaKu77v6dcLnAu0MzI9H6PegtK
 WZGYU9y9sFejvI5JQ2msfNziFOsuv/fKmI25KqujdJTDw+C0SSSFOA/Q2/r1iTRKrqaG7Fc6pfh
 iJkKkmDmgTsPJutFMMA==
X-Proofpoint-ORIG-GUID: 34S5KZcbYsD-Us9HrXAG4Z7uNElNmaCK
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a5167cd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=McKURmclKALMm-e9WygA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX3222KMFXaUAX
 3K1Y2BNkD6hK2DkXD16xXkCRD7ruycmf7/N4pwf2cUgus7F5vK5cRRswlgNdov6q1NTzJXUf4dO
 jOGIwcjnszvw0CIuEVWoLgZ3OHJl9hs=
X-Proofpoint-GUID: 34S5KZcbYsD-Us9HrXAG4Z7uNElNmaCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 13 +++++++++++++
 tests/tcg/test_cc.c   |  7 +++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tests/tcg/test_cc.c

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9db0692685f..6fd6f5bd187 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -106,6 +106,19 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    avail = cmd.returncode() == 0
+    cc_from_system = has_cc
+    has_cc = avail
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..b8a0dae6c8a
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+
+int main(void)
+{
+}
-- 
2.47.3


