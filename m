Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C51C61DD5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOI-0006pQ-TA; Thu, 27 Aug 2026 18:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOF-0006ZK-PX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOD-0006CJ-QP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLcYA124892
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 enCOXayZkn5/qU9M70ClmI69maUIj0dh8aEAXv/QMu8=; b=T6iwk91HAgBM/Vsx
 W40b7ylKmKPCcvViyq4I598l3tRQdP1HpMRTNYloJCJLQ/ETj1VXNl5dOFsMGzOG
 dmc7P24UrOFSZOhENoFoWiH+8qXNg5LfCrwGPiUhJ5/VUJAJfEMZx0Gz53f7yPrW
 QVPiB5zkjFCdPzBcetdIij1LjEd/clr/HigeJOGL+cwJxn/vb/ooTRyLCjw/MUpp
 Pw3p5LmPZnPS473QTRhOg3h3N02wEijM1oqw+xMADYcz2LbEo7smDlIB38QvFRn+
 YUxveB8xwCSslHJORDlYjFNO1xNfKYvFBW5/M9XcE2Onx0GWuLL0LLXWYrKEOuBf
 yaQXqA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7tvt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84a67b16217so319346b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868954; x=1788473754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=enCOXayZkn5/qU9M70ClmI69maUIj0dh8aEAXv/QMu8=;
 b=UUBgK2VL9bpPaVVa118tyuEnNYopgZUiYsZdLUL7fwg3zYPPjCr+yCvu6zrfGdVLto
 hsF16QCoH9tTDTWL4Z53LinvscTzQc+dEwl2I4wBaIOCK4UEyOElAreLZTG3QbRl4zS0
 lR+ElakRzO0JYAUo+ZI2n6h/elwZYi2YcJP/+y3xIhvK9t4P5l5qftPQMPXGb1cZpy3M
 qd/KoJTvbVu49CFbdINjv2srC61mtH4+uKKbPf3P13rEnEswoWPlKs7WWIZZTov2vVHu
 q/ViCl0GnfeEE5KD3ENujhLMzw6npHr4/171+FwEkadPIlLqyoH1eWeYVDdWgoQun22z
 fv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868954; x=1788473754;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=enCOXayZkn5/qU9M70ClmI69maUIj0dh8aEAXv/QMu8=;
 b=Wx7K88dBRTDCAByVPi6hnXNmCNXzT4jho9ftLVDm/aBfnnoLtrYH58hpOPwyQ+8Ng6
 VUvR1TOv6W1lKmrCI5egVyPkIieVZ7HZ8xaMaXZ+D/jp6FVIe4Q0uwbFuOoEK0ZSJ87e
 F9yzQIzkmJjMA3NJIbvsJtz1dewchU7GEs5aUI1vcNZtdKHDpCqCsDU8N8llG9pnsDXY
 ozFEY9T5aK1gOR4hGb9mny15+H8uKW3xk6ZKp9oV/QYQxurZyvAx5o0hPzlzY0KZnzDS
 lvP/tkv38pQuOylJi4mHbfsXAdpFv+yxMq+DIzfmm/Lw3yW4Hyn8QMz7sci8KxJ9xL+o
 cvjw==
X-Gm-Message-State: AFuF++llff0j4ABq1ZqEtYEZ82J/i5lGvlLcqJfGebD4J13Pyvxp65qD
 0GPEzFAj7PhBLS/v6INZAqf9wu2Y7mqTL0ocOzlNj9+EzuRdDcPpi03tPcqaAldVkRPl1S3D8VW
 vgtPl+BOJbiUz+CTdCMP9UaQYt39qoJ1CVoPoxIIqd3y/kXxvtwTSF2wTZpeZYtVIYw==
X-Gm-Gg: AR+sD103t9nqwcEmLhn0zopCxjbSkV+nXU7j9jKHy1sGQmKsCYL3vj0+/8cIhkmQfx1
 7r234WfRszM6N1JJoriBcccwPBURTW1xFUzL6A0Ttx1QB1UWm2uFRNX7qupCKpupxgwCD/bwkxx
 XUTW6j1iJbkdgcy6vV72TBl27iJkzZudYmvzZ/kNQn6Ck+ePAodw125A43jxX7J83uQ+y3y6VYc
 TrZ8IUDzPpoouc6oqP33yl+YghqSdz+7V9SxkrqsOwrXeT28LVaDnx967SE8r6YjKQnSYPm8S6l
 U568kIkRgM0J4upKHsh3W3iGpHx6m587O42iBI7MPckOfKd+l+fge84a6OhIEXDUP6NhLKTY9e8
 z+qFniL9pDmCHovv3qQdgJQcFc+HbQD4HrKVRJ2aRN0cOAxhKwaAPtX+I5+Q=
X-Received: by 2002:a05:6a00:44c5:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-856274ef244mr4683171b3a.6.1787868953544; 
 Thu, 27 Aug 2026 15:15:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:44c5:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-856274ef244mr4683021b3a.6.1787868952993; 
 Thu, 27 Aug 2026 15:15:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:52 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 035/105] tests/tcg/multiarch/gdbstub/prot-none.py: detect
 if /proc/self/mem can be used to access PROT_NONE pages
Date: Thu, 27 Aug 2026 22:13:56 +0000
Message-ID: <20260827221506.91574-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX23h/jn1zOoBb
 eZ/O73eb0UWMR6fxUFHbQJmqruuzOgwh0MX5xl63P8XmJBgo5K+yeeXjXIcKS+o+DPvHBez7lXe
 o2yurRL9SCjhKD9S+7YpMKyC1YbffqXLhZt7iFQvxKS+jc7w30Zo8vLD+bgE4uYhalaivI1/OOx
 vv54tn2/YN0OgbudkqS0rUPWXvXAfoKStQEgFLAs1SNbDcDNm9tmhBsHfOxNA1SxQU6MC+nUdQE
 r6sY5MzkrhYvMv9SxscJ/3q9tlBffhdhP/gurtnkK72ROrcSFSJs50PVUmJU5cALnm3lDdkHFhD
 tyz3WKrv1Hz2ms2EGu4vtBWL4L/tgNJgxSOTu/kyhnTXTs1Eo4Z9VP0esOlvCxkll2S9Z6Sbai0
 LiliqAqAAYAwfuJg3lbrS1o+Cfggo89WpwFypxEegUC7zDn4sJ1RVaICb6OrfL+6+/vj/tGSDKQ
 l536ZcqRFpXSZu1zqQQ==
X-Proofpoint-GUID: MUlFUBB0_o2Qhg8OvpzPUjdghpjsuJM7
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b71a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=H7RxQNMATbdHwL3mqUcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MUlFUBB0_o2Qhg8OvpzPUjdghpjsuJM7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXy+6khbsGpCZY
 H0FQKLpHC2wW/bgURWAYIzcHdNnT0SG3b4ATzXqpd603I7I8R/b57K1zxO5e9HyxivugWFja9IU
 GzfPQc0OjWvG6WMVrUIwvVUPY39iK6A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
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


