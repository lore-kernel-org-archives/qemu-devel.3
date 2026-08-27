Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B2C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOG-0006dW-NV; Thu, 27 Aug 2026 18:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOE-0006TV-Ap
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOC-0006Bq-Aw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMGDv1803885
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CtHOVh8M8I+QhOg3ToWiPEwD/PWXCo+DQ24/J3EvnJU=; b=hcQjqHzJ4fTJCIHc
 DOouWSRW8njfkbHmEBqN25W/9jtzn9b9Vq/8+9nI5GTbNJV6r2+bAeh9eq28F21j
 fBgbh+y1okC2nteBmsEe9b1+rSaO1tmtGPITetz+580BXjmrrv5w+Vmf5Ig96ZM9
 +DoCRGR3Gy1M8P17PyIr3izezTtcBvwUJ7o0/6LvnpoLGJBBMnG97XKGyDA6WVzm
 8ARyFsDVugIBmVSTxy9QtTybaZnIQVlihI6bjTC5I692DoW01MFUhF86Vif0Mw0U
 VxWNZQnIXGAxkEbDaAuPbcDJujDgWwTc9U/YGlqIk+s8HmW1saQp4fy+NTAh8xw7
 IxshDQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgv5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8485d853b08so629247b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868952; x=1788473752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CtHOVh8M8I+QhOg3ToWiPEwD/PWXCo+DQ24/J3EvnJU=;
 b=NzR4ZbVEdUGAycjrc54xbSKploHnfdp7Niygiw9Fhl5JC6b/YuJdrGXGCtQRM9+h3H
 Fgv3lG1RxLxipE0C2pNdpy8r1ptyBYtriqTvwakU2OSpgKMS2veAH0jaTNMWbHi0Y6w0
 Wqjtz6zHICX7k7j2/arUzaMUNkb6kpG7EN1rqDLORghBwQlFZ3SWNDpS6iMX58YUnVZ7
 Qqaq+Bu/zLxn3M/XivKiuyk1SMzNFAJd+/1XJ5u0kWsWDvSaZpM0EfF1r5gSi0XH8GoB
 MNkpifeUP9o2x53bgWOaimKrYlqp7LJeN0VxkpuxMCOYk2isXXTh4vX3lu+7Rrp7xVj8
 fBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868952; x=1788473752;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CtHOVh8M8I+QhOg3ToWiPEwD/PWXCo+DQ24/J3EvnJU=;
 b=Y3mT27jcxedHrqM6BxFpVvAzkFoGfTFEFKpJcPh1s1nP3urj3z27/Hnw8VO33hQ/eN
 uw8UuAVt4BmPy/Nv2VnR44RXCPXGbeNOxeX7+AbAEgIJ5tuzXOyrcDUth0bJUaUbsU3z
 JYAd1ruAduNsoYaqBDojj01tfC3N/UyRa+plGbMfhjPWyI1bF3KZti1pq2iIAbxUBFtg
 Db1pIcf7onLzjj/49VsuOKDiWu3OEveOrCQ/rYnsEi6QS6sZ3+8EIwQo8KMVdM+ZVcAx
 5Cdyc56VYqpkkb1MoKsPhX6f89TOdcEA7i3J32254BxevH5UKei4DC1Lo2r4wluIhdlb
 gltw==
X-Gm-Message-State: AFuF++kbOHZNXVUbCtCcvys3f0uv7miKelrzNRklLHUu8IstwJU2z2rv
 Yer9hs8E4UxcKfaJuCIe4+orRvlIPxqHB2O2V/o5X4BV10iEmdiBGid+9MPAablGpbk2uNEnbq3
 5fYjfkNh8HMfyUz+xd6RlGxVJ0XCuyk7v4GeVAs+gfhTMVaDJLtMJbcOxInrEuhBPPQ==
X-Gm-Gg: AR+sD11ooS7IEacfkdrWFUebrAHz/HW/jUw9zBekBb6+Gm05l4BbqH7HNS7AgBCJPoR
 X4Ms2WdOm2tx2V1IW/dBmMry/jsjynNBzQmTyPDBdR8T6jy9sNK4fT3XZnQ3IxW1LihaZhwxlsg
 HaAPvcvVfTdHMEvY2rqB344kjDIT5tQw05c5zuoGPf442vu4rD3d/DW9fCryTFhc+2E3IsCzGOP
 /bvkDVp9iHJta8UowU+ZC05YXANqIMMwbWOstnoKR0MWeyIiw+Di/iCfGC0awe8ilH9SYWMVjAF
 twYSHuPygup1iBuzDWqtGoop0IgRwSLb48RNLRUZnvSZkijt8gn4b+j0dRmu2zyZQ/ygaFdvZSL
 /3U5vyJErRz+7FDyOdqmglqUfxGGhWVtVHeH/IUyUobpLKuZX6BjjVd1OjRI=
X-Received: by 2002:a05:6a00:3319:b0:851:fb36:a701 with SMTP id
 d2e1a72fcca58-8562879115cmr5121513b3a.7.1787868952020; 
 Thu, 27 Aug 2026 15:15:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:3319:b0:851:fb36:a701 with SMTP id
 d2e1a72fcca58-8562879115cmr5121404b3a.7.1787868951563; 
 Thu, 27 Aug 2026 15:15:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:51 -0700 (PDT)
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
Subject: [PATCH v8 034/105] tests/tcg/multiarch/gdbstub/prot-none.py:
 deactivate on gitlab CI
Date: Thu, 27 Aug 2026 22:13:55 +0000
Message-ID: <20260827221506.91574-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b718 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3V-_cSConhulDen5wCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jJ8DlPWNLpCJiDZfMOAUOjfMvEZNN5pF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3jqVvkGEZMTN
 EgCmILP+jHtmC2ZqjN1geqhBB6NKvdRNQz8V2YO+GfnCYD+oroyioICVi9I/wNFWODZjNHQ0vMj
 1dmzFQ57Uf+mdT/35hwT3QK6sDBOvlGsJxlNoM54jf02UGG4FFFmwv4rtLskvZ/jFd2NJenZDmy
 orvwSGxRvtPVzh5B7TVlzvuKSJx+hgaQP34fLleamudhgNszcAwjNsNQ5JOVpDUzNyxPJk3kt2C
 xzz4u7j7l+WfltJCye2t9aoihmNhKwmPdaFm2nQaL3VR2Iz7aYr9nhsGhBg/j0oGkzhZCqR53CQ
 4HG+0h5GIQDwzmjOmkHuAXZgnG+n7w17D6d9vjMEPYvIQ5aGiEFmUtfLtKIqmypLkOdffrcDnT3
 ChjP51Fy7IKw+gDz91btKLzt1KSMrysxujAuF6cx6LBmiiuKbfVaaHRPPPQb42ri5K3S+vBUyFt
 vqKNsDkQObL0yFgjJmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzNZkco7quB7c
 aPkGPbNGDMQQINjmSII+Twe5mEdG7oIIiTIJicYYnH8NKEGRnhlG4ie3tScwYg0TgNwLZnZNmjA
 NObZnhCZ8+VubD/H4QktCBDbCcpCo2c=
X-Proofpoint-ORIG-GUID: jJ8DlPWNLpCJiDZfMOAUOjfMvEZNN5pF
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


