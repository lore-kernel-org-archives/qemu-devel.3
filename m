Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B3AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPx-0007kW-U8; Tue, 18 Aug 2026 15:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPw-0007eo-S9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPv-0006jh-6X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHJG2W735618
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5UUE4uanT9y
 xXgmoQDvQv4fzgBZuh/eyAOA5L2GNToo=; b=hBFhRECklDcT2UjNhOllLZE43U3
 +N9lZt4RxTqj0EbzqGwkQqnkocm/PbmtV8bqtIhMHk6grUvwqwuWjdsOj7I4tuOB
 3345Fr8dUZn2iqTUJsNf++iop5wjUFWTXnR7PJmKIAqd5bZs6IJzEUC2QtEZ1zZK
 fGArOHO5uwPLsCpwbBNfEDzHkDn0cIQWNDlmDXzpfiA8jkgb4C50n9PhWCGvakI3
 Jcvhq6UyK/fVe4uawjmkoi6n4fP1bN2TkYJ2h/fl5I4FDALRnKUOYUuct2Fqt+Vt
 3fMKbXmkN30rt1fbRGIz2E+Wkyen6kv0tf0hjIUmi34zTqD10NO61YsTU4A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4reshkv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d54187d8b0so4164985ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081048; x=1787685848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5UUE4uanT9yxXgmoQDvQv4fzgBZuh/eyAOA5L2GNToo=;
 b=Ucpx2pRfpZ7O/qxHHWmkyWfoyzvfCQEXenBjlSXjkHsrIRJGmI3nF6QWGDJYEG3AQ+
 dTjn80VrnilRnLTb95VD+/7IzfcI0Kj40JWRAVX44d9hozFxRHK0vu/cN8pzprhnqIC2
 OEY0UQXBN0CqliijDiSLaw5A8qaTt8kbkO4YFPq44FoKdtFGS1SkclDYfM9Jnc251wor
 a6muYJONlrOFP2yCBhIcf6gaIFRhhLIZVin6qav8LyIurDwSPXehdjgqQzjtUNyIoDca
 QjLR4u8UodKNmm2m8znjMMrCV7M87YbNgHmLOqub/IrauAEVBNbWlGkFMA1qTZhH0ZcF
 vANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081048; x=1787685848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5UUE4uanT9yxXgmoQDvQv4fzgBZuh/eyAOA5L2GNToo=;
 b=L04zAtaWYuhML5WLtrhkQ0Vdv44Z4O2zoOycoZuCuwyzfMY5w8HvaidoxEwGwwDv5y
 Xf3cvu94N+Wq4jl0tgUSrmxY++emylbCPl1ioKGaZKNVWWsPhy3uvxMUUKbRoSovA8QP
 PoYfONIxDn9quZ9hQwAoKiEDfO3ysI6lO2Ec5k3FNV6Vxn6N9KahetDIJhrnf/FlohkC
 4epz/GKj3iu6sAYF5DKqlZC4yJJN9SbA1NxA/6zxIEI/o46k2M9EEBbtSDH/oeFwIbnQ
 oYy3F38v4jQr0E6z87fd00T1JpKHvW3nWVwMbNN9TSNTeBXAcoTPEjhXQ1TdAxsa5mjB
 tEHg==
X-Gm-Message-State: AOJu0Yxu82PhDQJumPVm20aPUP+fcyOv3rczxTc8/a3WCNclEvJEsH49
 nb9BwP9Sh7je3hQW4tmHPGZW4OmqECB0YYHvH80Toh6ke3QDIy+0gwQKQ+1Z41hUy4qi0MAnIR1
 iXrKdpmdwuFfoGz/XSBeeGmhNlee3JZDd0mCabzpIPOdD7B2D4x8JsZo7vQCLKRZDSg==
X-Gm-Gg: AR+sD10mbnnzuIDgz15JDpwD/TtQvPAY0/W7rWKqMyhStPYcuSVhNa86YonNz057+9f
 RqLoFKtwxfjE96enINHCRlERPBGdp4Bq1PqbpGDoX3bWNJBi+Oly+HUZ0jNJIRKtaSSLOoyiBl7
 MYQkJT1tGSjbDlleeFqSKXY7MHJQ8f1ZHsETZOkvhObSw7FNWX0dlc8ntoZ/wXfvj+7fR+j6Mlh
 jH1a+3WP8FGK/nOEQIYM/VBfQuQ+RG5fy6z8qTRxNEmcWCRjhvjse4StkMyinjbxONiNPVodvU1
 LSkjIjMRj3tfINKcgF0IZuliplJGgxokR35pcKvGxT4IBjRB+dlfeAJSDQyy9LAMW+/efLeWPol
 BYFss2+cOKhel+q6CAOhb2W6NCXgkWHcibljuHf+ACuwyIPHMimxE5ExloAM=
X-Received: by 2002:a17:903:35c6:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d5f6ba5ad1mr1622725ad.15.1787081048030; 
 Tue, 18 Aug 2026 12:24:08 -0700 (PDT)
X-Received: by 2002:a17:903:35c6:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d5f6ba5ad1mr1621855ad.15.1787081047567; 
 Tue, 18 Aug 2026 12:24:07 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 035/104] tests/tcg/multiarch/gdbstub/prot-none.py: detect
 if /proc/self/mem can be used to access PROT_NONE pages
Date: Tue, 18 Aug 2026 19:21:59 +0000
Message-ID: <20260818192309.22169-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a84b159 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=4nbiZS0JNneqsou3r1kA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: cS8bJCYBeptSjScnOXDN_pxaiicd_WYN
X-Proofpoint-ORIG-GUID: cS8bJCYBeptSjScnOXDN_pxaiicd_WYN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7t6gRFBZnAuJ
 bbMpHT9jmHMqGQFElcOoPiE+GiW8xFrO+NM0VBVXsfA4XrNtjiLSXRPj8ZVwuu8r+eRFC8aTZWp
 81vRZpQ13fYAl2OsPNq7LJnAzorx3+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8oThqLqzi4jt
 4p4J9z1YC7k2AZ2pipN9rA0pylCaXukoEhOrcbJ8h/M5IQrrA81v18K0gNMdar46uqdAxxV1qxJ
 qiRDh7kS9u2+c0by5uOvLpyRqZc/ILwA8YkDmP5sNjeflBp9M57p+oiTLq0nOKYiWygibHYvwzk
 s0G14BX+bZjuJlYY+/+LAcdMBTB10vOKlfzwuWGrZWmv/V9H0utZA049MYGqjYCqZMHWclMvOWq
 YVHyAzd2IzyJnCnMVUNhjI8Y/EMJw7li2Wxc9l8zUD1i/eiMpChVEsnrKKF0FZVc6qADN0w4sJ0
 fJUWhPgboHov/BBLpVu5LoraJqqq44mx6OLMtNatOCkGhb1Z73PQXW93Sd0gcZIR0SHXPrhKWC/
 yRkdijFwo/e6xeSw8McSoDCan26HxCIxH+snyC+NVvAEC7pE+fCCgrZ362lD7ecwad5j2NA1xAG
 d+osFl3IN+yDDw+g4FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


