Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA062C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG7-0007YH-E1; Thu, 27 Aug 2026 18:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG4-0007WG-C0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG2-0003bz-Ei
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMMqw1804239
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 enCOXayZkn5/qU9M70ClmI69maUIj0dh8aEAXv/QMu8=; b=iZ+9o3hCA1Toh06O
 QjPkSuy62aOzI+Oo3T3VyT5dXT+zk5gccBtcmI6FkBd+BQGlHq6P5UTbFCDCCzIi
 xSIIQDij5njKsMdJCq5KYc6e54nwcmOEAHL8zVN7GDx/LBwadxYDYaFffS4i95ul
 mnS+LZ884wOjCdfJF7CczvEGv/cWMhroxDG10kK9+z5mU+7PdMiPvkPT2ydOUK9a
 mJKUsjVjSlwdoBB+0D8w/fERlxGFJhcHUJghGvSMhCBNxCwMBy0kS4kQ7CLwa7ud
 ipclCqbkuRpGEWfXV7io35rZHTKgFEPpheWzk3OoAMsPaBpNqdDIi99q8hRkZuoR
 VKbNtA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgu77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e375d9736so406657b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868456; x=1788473256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=enCOXayZkn5/qU9M70ClmI69maUIj0dh8aEAXv/QMu8=;
 b=eMyZorPeW2T9XvuTMgU1A+ml/ZVvILHrkYVZAI8NkJs/kOZykS7dsLhUHCOVlxfnZK
 Z3g037wYWgaHwe4U3SIi420mjo9Tl0pOtkpVMXUp42/k/JfkbbesBhCEGCjpdqOmXVav
 RYhsoY7jdpRHBHWa3lXjc92XbJx8O+2C7AmOh6Ah/IIWnhnkSTVmzrinq+frsQz+BEmO
 nxk79catavO2UPqeVbCqfwCQN9TcaiHRaDrkPzeepfnUllnRZiUfIeYknl7KaPn6qdiB
 /GJ5r+yV1Fy4vX9GfhY0wlg2SZXfvGq96+sdTTvtcJuBT9RONuciEnyUnG4LBm1pU1lz
 xwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868456; x=1788473256;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=enCOXayZkn5/qU9M70ClmI69maUIj0dh8aEAXv/QMu8=;
 b=Ky3tEQHBJZIau31jv4p2dNq26G7QZwCydZ3/IuIDFVppuUYItD+ntVizKUXr69LmPP
 Glz6cbuuTQuoTO4gFgLQIqLCF08Y/oL+rVZEDQWS5NYL3qM0QZXwXLdy3+ZZFLPVi/HH
 VED6C4xWQ8Ysy9+vNV8m7o+yPi+nYuoZtHvy9CWWT014l2Fx8TPxtK3ARRQz/2By19e2
 Wy6HuR9Ryhp8QBQlYO7yZ4cORRcLfjWWxDi3h1b+yWVtWd485ZvvN7mO+OhZc8fYRO1X
 cJrOPbnDKbRfVqaOITzvkYqe6lStoaotXrbp+9hl7H+ELABB3jddeR+cPHEFfnnZLMSf
 S2pQ==
X-Gm-Message-State: AFuF++mUI09AEq6wWWuaqNbcOUb777I2dF7EKWjOIzCNXT9D59JDAQnJ
 THCBKo6TJGNQZZbAM9sFC9iLQ8Ht1raodoLbDx5zSYrw9ayU64kmB1ySz7emggFxo6O0Z522FkO
 Z380mH5M7/pL3Ucr4I1QFA5+cgm9NKW/tDHv6LWK2mWWi5XARpPKEMk8umCxCNRCJJQ==
X-Gm-Gg: AR+sD13mA+AZsk1cLMRYqTBtqVbf6wlu11VVQas4q/GDk4m6CnXn4pDRyBEwu3qWloH
 VLIstD7d/NTqNjlUMh0N3dwdMVK3Wteh7njjpXe+RV12qpw1QK6QAYQI9i9CY3iEurJbXx9j498
 MC5Nh8/XuKLIyuM+aLLLsGeL2qLHZ8CfZAHdCCTOLl1uyawNvAGilZt75Mbsfbt7bu2PWqxMwWu
 vDCWvZG82Mp1WJLl2i3fHDj3c1vgRRdzvFxpDWCFmzlQlisjoV56UlEKCgWTaUIyqhMukaFPBHW
 nBN7Ef63zXMnZlNJWDrYCxyUaUjMxWEoF5ysc3Yt/Hc1RaPzOb5pQrvOPcCAIjWtmeEN/2RZR0B
 TQ+vxdaKnR4OdW/Q9wEwCyU/tdL3axrYE39uD1yjOBCI/CFQM97rIGzgxpIc=
X-Received: by 2002:a05:6a00:17a5:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-85628d75e0amr4338035b3a.7.1787868456200; 
 Thu, 27 Aug 2026 15:07:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a5:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-85628d75e0amr4337928b3a.7.1787868455769; 
 Thu, 27 Aug 2026 15:07:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:35 -0700 (PDT)
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
Subject: [PATCH v8 035/105] tests/tcg/multiarch/gdbstub/prot-none.py: detect
 if /proc/self/mem can be used to access PROT_NONE pages
Date: Thu, 27 Aug 2026 22:05:29 +0000
Message-ID: <20260827220641.84885-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b528 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=H7RxQNMATbdHwL3mqUcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: s3jNW4l6B4hUAF9D3bn7J_8kAxxWHwuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6KVx8OpzvHMw
 dICD28jKMbdGE3Sed6xxDTgcPQrhxwwQ8E+Xp3hytlQCxouDYDq6v4TOfTiL7xtocN/6XBYQ73b
 WKUVP5Gfy0uD1dXIGKeD0HP5sV9uGXhVnhLqjbxdMz++sI8F4bsAqakd2EYg5+gPJR/nNqTGAoE
 9hloCamFmXYNQq+txWO3oZIk6DaO9EuvUTm/2BEsfc22n4Pb0zJ6s3GS+ZZw4v8hdf53SKCXuqW
 IK8xkDMUDipWMJfOJJziZ+PYh7aRCE3J/qZfth80UHxWgofroIANrsA9jGZr8IbPj6sDON15W/M
 bERVGzxQWuZCsfuwBc4A2xu/Opc6GaQqDH/KzYZMC/hagjpNJtmBbgmz5F0DwPkM5c9unqRqtb8
 MZYZQscUi4GewkbP6NfuHK6UsI98BkSRRsUry8CUb4oCF1OPzcZkREaQGTzw2tvhoODIam0djw4
 Ds+dJOyokio+nZAYJ5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2HUlUPQwwZFs
 iYVW5yXBghnhoUgNVDtqoRGeCjYuop1XF72GpoKZEirjr7tDtD1YVdqMVBVXkNgCYa1cVaps/ta
 nnFNOMueD8GVM4JRfMFZx99rOKMO0gk=
X-Proofpoint-ORIG-GUID: s3jNW4l6B4hUAF9D3bn7J_8kAxxWHwuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

Recently (July 2026), this issue became reproducible on debian stable
with kernel (7.1.3) from backports. I suspect it's a default hardening
of kernel related to recent CVEs.

By tracking error reported, we can see that /proc/self/mem pread from
cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
(Input/Output error).

Detect this situation directly from our gdb python script, by trying the
same thing from current process. If this operation fails, we can
gracefully skip the test.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 37 ++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index e653bc697f6..e59ba58af86 100644
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
 
@@ -18,6 +20,36 @@ def probe_proc_self_mem():
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
+        # this is the fallback in cpu_memory_rw_debug
+        data = os.pread(fd, size, addr)
+    except Exception as e:
+        print("/proc/self/mem pread error: " + str(e))
+        return False
+
+    try:
+        # write it through /proc/self/mem
+        # this is the fallback in cpu_memory_rw_debug
+        os.pwrite(fd, data, addr)
+    except Exception as e:
+        print("/proc/self/mem pwrite error: " + str(e))
+        return False
+
+    return True
+
 
 def run_test():
     """Run through the tests one by one"""
@@ -26,10 +58,9 @@ def run_test():
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
2.43.0


