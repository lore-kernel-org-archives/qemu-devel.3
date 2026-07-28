Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D21CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZg5-00066b-6u; Tue, 28 Jul 2026 00:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfi-0005Ra-Tq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfg-0001ds-Dh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46fUk1821469
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QWhaTj75BVW
 3vGTWfMArrp2GrStnU9lWfnCaVb67Xsk=; b=WeGFaRRevoihOn86vYQ/KIwSV4p
 isRjow2HDisKAqxh9436lLwlwyHrbfqm0XAHn31v8iIsJTj6TSY8D5yHLeCGFuzO
 PZvz3LhM7bQFDqZlrZ/OwZJ+DZrvq7E2Jr3oPlaki6T+y2zzKGAla6N/ZBDdwyt7
 bRFheUtWyAg7ch7YsOgK+iKtyo2l07hSLfhrTc1H4WPYwt5VNJ0/pvU3yLwkFCbb
 WlUNyq6Z59Ok+Oz9aDMgXxXmR5bVhdfYQ7ANu2RVNFTy8K5aLlOvESC0VOLXfA8b
 rKqa2MSC7mgKixdkj+wAEA685gjZu0cQSFfDMKQzw94VLVfSaFO8QmMtW2g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y03gk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so2569017a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213832; x=1785818632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QWhaTj75BVW3vGTWfMArrp2GrStnU9lWfnCaVb67Xsk=;
 b=JvmbQdoeG5ObJ97nbJoB54WqAqAoIecHGyKxYZtYdqSojgYbh/qgf6ZFxZLnYNL9zF
 htDApcS9YhCEtmLLWpRYTeZuA78UzG/PnTjdJWzy0YlccKMcv+BJAfAhHmmHw6sbaazp
 8Nv26e3cbl3AUwZr8JAtVd3IbU+ovMwsYamU/jcJS9uIWecLNKHHc+EYaC2/PKrk2gPA
 M8LpcNpGiJjFRddZYzIUh30AB7fCL6Xzcy8YsymPe33hPh8JgZVw2Y2Du2wSztIX1Uup
 GKoZi8UXIEigX8zRHOZeYhQwmOrZ2kZW6VJV4183/KTAk0LxuhI4R65cGH6vh+UjTk8J
 8YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213832; x=1785818632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QWhaTj75BVW3vGTWfMArrp2GrStnU9lWfnCaVb67Xsk=;
 b=hUOxP72Q+HxbtY3fsMMV+C2bseNJxNup5u438MxMyrB7tfKPrs6N1aadApP/dfQS0G
 8WsRp4tHENtwWWBromtahIQ5Hi8ByzPL69RQ6puhr9YyQR+EbT2tFTnvKTmz53SBpD4Y
 FwV2UpgNplaLyekId2rqggvG1Joi0rQElFHDZALsSwmUvmwEqWSVpmmgTAquOW3UJ7iO
 9f/+hDhlIm93h3Lta6t+IoYHMJ7xyImdUndV0383tUaWE9jtYEjQFrI1dGwbLJ+Gr+sy
 cx5GYCELQUMuex/63WVEr/r8+q8oj1aJSAwVOvlcT5slSIfElxVaB7M7okhuOP2EZF8Z
 YeIw==
X-Gm-Message-State: AOJu0YwciB3k/yqdbrdnRvH9/Zt8Sk32E4UZSsx4197LOwboNPA7/r7t
 ayiSI6XCHA7PYhYQ9QzDwUm1k75TwJBgLg+78C05AagQOjnWVOhkZPgxK4ipf8yJK7Z3KKgH3uK
 K2oA41SQW0aD3hygKErdFPKuEOLqLLKnZQsdY7Pw6uco+wLyU62s79/mS4EPzJ5IlHA==
X-Gm-Gg: AR+sD12p9hBsVs2J0gkPLTBGs0v+xdkSM/sHYlzVhmV1bSjTocon61alou2fCObWp6l
 S8k0V+GUnt4HbZapckx6lgPR0i2HF1o04LQYzEGkBcM50cJaDWG7symo6rMMwN4Lhe8ZtM14GnU
 /8XfqVIsfVbX2E77F4kdZfTR8J7xM64EPbBy2Mbwxwh68AmPI4ZWAgNHQqCQqNM5uZvT0iiDU7I
 g6WwcpftYrsQj9eSeofmmDC7jRGC7uzK1VUiCWRKUMBQ1YcJcFDAgjPv4h0CIm1SB/eUf2Nc4lA
 UOh3ycj+cGwJvrFMrv9DjuPAxIDL2SGx9+bCEiWKY95xU5Eh3PsJCv/vqXdltLyzdbgp66F4WK8
 wZIv+MSuZU+46lCYlF7QLXyLRLbtO6YV4NXTiF0O5eEmqLnnWga7bB2cZ5AvoF97G3XSNBl8=
X-Received: by 2002:a05:6a20:3c8d:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3c8ba5b6246mr1111170637.46.1785213832371; 
 Mon, 27 Jul 2026 21:43:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c8d:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3c8ba5b6246mr1111146637.46.1785213831912; 
 Mon, 27 Jul 2026 21:43:51 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:51 -0700 (PDT)
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
Subject: [PATCH v6 034/103] tests/tcg/multiarch/gdbstub/prot-none.py: detect
 if /proc/self/mem can be used to access PROT_NONE pages
Date: Mon, 27 Jul 2026 21:41:38 -0700
Message-ID: <20260728044248.137626-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a683389 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=4nbiZS0JNneqsou3r1kA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX0kZopn5frt1k
 4yYDuv+ycUwSgPACDEBzBpxG5KsYaYHU0Ri8j4qwIcx8CziXbx3jlkAMfmt5yXEfe2ClM4Um0Mu
 HV0H5kVJF6XtA+u4kpk82XSET5gx9JU=
X-Proofpoint-ORIG-GUID: mV72YzkTb5NwEF5YvZ8xWOmmSgO7lP-g
X-Proofpoint-GUID: mV72YzkTb5NwEF5YvZ8xWOmmSgO7lP-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6zG0YNutLU8Q
 TNXMv9/nEv6VxE/maNZLdXBqTWUV8G5SY48niRjaTCiSlWFuhBw1FtarLrDNTXgCeNSP5jzehGS
 ZxbmBtmBBbI+efNs/AhhkLdDiX/aNlDqs17bVaFDRU5/Vbt3EkPFDwBol/oMIPC0T30dbEoEr3u
 tPCWKwYUhlIXuW+yeSHuOch9dl0rvFrJIoAYJwL+54KCi3MGQ1vwnH/v4ABC0Rv76iUTb/OLvXS
 kKvoSshsBQye8tU2eNPOWza6LGlZqWbNfWPv24YnRRzqeSEWllXyc1R8JCb0rbvGi3wMQXN/D3F
 672HrgFdffGQfXreLRjH5ysJBk/utBNFP4S4FQuRTSewjDX85Ixv9WCybwWn+h2MZqgwbVXUHaW
 SJ/EH8X2DB6AIsVd8Y83rHqXwhCT+ZeK4UrS833f1L3jbc8N6Mt2hJQ/jQPsq//BNPQ2GK0HEXU
 IubsJHZ6N6k8Svave2g==
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

Recently (July 2026), this issue became reproducible on debian stable
with kernel (7.1.3) from backports. I suspect it's a default hardening
of kernel related to recent CVEs.

By tracking error reported, we can see that /proc/self/mem pread from
cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
(Input/Output error).

Detect this situation directly from our gdb python script, by trying the
same thing from current process. If this operation fails, we can
gracefully skip the test.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3329
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 35 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index e653bc697f6..393626a9798 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,6 +5,8 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
+import ctypes.util
+import mmap
 import os
 from test_gdbstub import gdb_exit, main, report
 
@@ -18,6 +20,34 @@ def probe_proc_self_mem():
     except OSError:
         return False
 
+def probe_proc_self_mem_access_prot_none():
+    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
+    libc.mmap.restype = ctypes.c_void_p
+    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int,
+                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
+    size = os.sysconf("SC_PAGESIZE")
+    # mmap a PROT_NONE page
+    PROT_NONE = 0
+    addr = libc.mmap(None, size, PROT_NONE,
+                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
+    assert addr != ctypes.c_void_p(-1).value
+    fd = os.open("/proc/self/mem", os.O_RDWR)
+    try:
+        # read it through /proc/self/mem
+        data = os.pread(fd, size, addr)
+    except Exception as e:
+        print("/proc/self/mem pread error: " + str(e))
+        return False
+
+    try:
+        # write it through /proc/self/mem
+        os.pwrite(fd, data, addr)
+    except Exception as e:
+        print("/proc/self/mem pwrite error: " + str(e))
+        return False
+
+    return True
+
 
 def run_test():
     """Run through the tests one by one"""
@@ -26,10 +56,9 @@ def run_test():
         print("SKIP: /proc/self/mem is not usable")
         print("----------------------------------")
         gdb_exit(77)
-    if "GITLAB_CI" in os.environ:
+    if not probe_proc_self_mem_access_prot_none():
         print("----------------------------------")
-        print("SKIP: fail on gitlab - " +
-              "https://gitlab.com/qemu-project/qemu/-/issues/3329")
+        print("SKIP: /proc/self/mem can't be used to access PROT_NONE page")
         print("----------------------------------")
         gdb_exit(77)
     gdb.Breakpoint("break_here")
-- 
2.47.3


