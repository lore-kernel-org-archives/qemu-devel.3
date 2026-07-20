Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C77BC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluEd-0001dr-Ea; Mon, 20 Jul 2026 16:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEW-0001YU-Jk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEU-00059Y-Jp
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTpwi3637881
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dlupJaF/qMa
 Fv5BO8vkl4bxKLu6Nx9N+zSn1gf9YIZk=; b=Eb4DnOk21FIF92tmkLi2t0rKQ7y
 R9wF7UvU5P/7n7wuujJrH5hymZcI3FKS6WoEv0y+GyWzF7RA9EPDvUc8vtgVTVuU
 j0yywH4rwUEHJM94IEvOfySyw9HlXMJmY6M5tchk2ID8mZ+tji/iUbS3gKZZZFIU
 y5ERVWVYFh5XndVSY1YiyINA1KbpC3CWVZKak0w2T80A8Jq+HlZtKLRZGQxi8Tje
 MBDsiu61GP1LoHSS1Z/0mqMGmTN/07Xfb+0C/ZLslPhKGmO+eRBQgEupt67+ZIiA
 SuI5BjJ3srMWY3HHN4rxEyVA3B0pxoYmADU/2rfMDhHeHUSqFSfo9A6E+Mg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhhgytmr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:04:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so2375621a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577896; x=1785182696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dlupJaF/qMaFv5BO8vkl4bxKLu6Nx9N+zSn1gf9YIZk=;
 b=b0tb5iLIKpkFsbCyjHiwhnCme/NtRgjKLDGIwDnP9/EWYrcUHEowhehx/ghf3iMTGh
 vmZWYasrPHRAOmsgDE0jWafL4/87otNZskXAWOpg5CHd/k0Bj8TueC4l/Tv/jG9nLesl
 T3yp/GN7D3ewV1/FBI1Qu9aBDzo+P2OUJMY/XU2q5rVRdxexXFFRyp2PjCLPQ1w4dbTU
 gOWqrGoNa+TN8R2uiuD4ZjZY+ik+jpb+YWyb0X2YBxgC0SFyq2WzFq4ZWAlgxQNyJjXN
 0bCUzYOp0B9mXhWG9fQAPpaxz3r3Gr/Ndm6KPyVUZbm1fOXEgDF3x+Rmhmo0RpIAC2fp
 Yxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577896; x=1785182696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dlupJaF/qMaFv5BO8vkl4bxKLu6Nx9N+zSn1gf9YIZk=;
 b=s01TDTQwGiq5/Z9IHVjvsAwVNlpORzPb5NeThLMlak3mF6ze5Z/fDL6n5CBK1wIJTb
 jZQo2gRCj1PpRxH55kY4aXvgjGewn3CcYUNS2j2IV9ZSjjC9WBGhUjIKqykDpQqIH4CJ
 lmp80cI0BV9Ch2WEE9ozNtikQiw8bJDZePI3iiiWyHrpY2gCjRJLkEeNAS6y142viYQW
 PU3YndMhtSBtjy+2R/CApfLC8lSQBCXLMqvneNQzFKMCk56/4XUPAALYRjbOhunr+brP
 02xb8tB/jN7zCsdIZGlLoXT1dPUJvKwvSm0XeJSbwx++EoHLOqmlAtQhu5tZT2mm5EUE
 NJ5A==
X-Gm-Message-State: AOJu0YxYaa/nIKPyd+qhbHBKqnuhf7p0MfMg13XMY6M5D7xNHCyGlVDr
 02ShBi8PqnP9mT/zTUs3RrhdcZ8PX3o5QxDpQIvty/yuayun4g4Xs6pRdgrnttFoQ4J5H6wXQcx
 /8X7GL0MTQvJOljAC3dluPXqzt6/ORmky8jvhU+Vo/CiokWpun3DZH2ZBCJkSkHiBCQ==
X-Gm-Gg: AfdE7ck/hzaONfLmqLE0sm0w/AMcyqyAKJUrXzAUlmYYTWLbv7EpEzulk6kohkglTY1
 MKL+G1/mHeuMm7XZq0X9DVNNkWGtp7+v9HGQ6neEUhF2FA5TA/6tK4xqDcs+s859ibPoAukXLgt
 wzNBv4gALS7j/jkS8oLOwf4wSZIz+e3eqfxqiauJrO4GjgCcrb5FwJvvntVM+YcM8RxS+LfrC67
 ySloJIjYcb6Gh6u1t5E2SBLdkI8YOHwHMThlDk+UAY21Bn/2aDlLyaA5zNutINgIiPhtKmiPzae
 8QzDrtn5HQsdP4/6EqYkTGYMSAihFr4YNgEZvFHSP+FiJJPkb60eEFEJ5kZPTanUIUSMTGn1K5G
 +qXCTvLW1cMHOgeuXqLmxKWFnBdZkC2HLi+U6DZ+PVn1pl5Uq01CzgOQo38lMpvypOiWjSCM=
X-Received: by 2002:a05:6300:614e:b0:3bf:b182:94b with SMTP id
 adf61e73a8af0-3c3ad66a462mr17787780637.6.1784577895623; 
 Mon, 20 Jul 2026 13:04:55 -0700 (PDT)
X-Received: by 2002:a05:6300:614e:b0:3bf:b182:94b with SMTP id
 adf61e73a8af0-3c3ad66a462mr17787746637.6.1784577895017; 
 Mon, 20 Jul 2026 13:04:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dd90fsm38487229eec.22.2026.07.20.13.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:04:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] contrib/plugins/dlcall: correct the syscall number claim,
 note the data model
Date: Mon, 20 Jul 2026 13:04:45 -0700
Message-ID: <20260720200447.2145622-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX0b20+fuTUgCl
 YUAl0wOMLkAKZmiy7+RmV1PLtKBcGvFn5Lng94Ym+xsk9i5o7eY7xQ2Id82slMxI2OlFBd+YLAA
 0inuDfUxdIX/sdjWYHSdvXncc61/TJQ=
X-Authority-Analysis: v=2.4 cv=LK9WhpW9 c=1 sm=1 tr=0 ts=6a5e7f68 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=6AWcqj6TRxFK8_drfj0A:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-ORIG-GUID: 7FT6qD5cv1JxJiYJVQFskzfFRL_Vm_Jj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX2lEEz+kdHvgo
 e2atMi/e/Y3MWMn5IHZkViqsBR20Ka6Jy0yVUHQ6hy7sZGsAAT9gW/hn7pCIKKlUiwohorjtXnb
 EQ3+7XaXDLCH56Lpe6YXAllA/BGgFniliFihRspo8K2+KrXAWfdQwbkRg7Ta31UqtQM81kGHI6P
 fpwgJKPesyXufGYesHY/Db/niCdBGMJ2Yx3aHf2OnT/sNjJQI0rqhcifbSn3hUieJ8XA6Qu592E
 NrT6AaYUqfma9kQjKM76EPh/nbGR37MvyogHLEyYIhIJ4cqm78YfXXfn2Lvn4jkAl60iIPQhacw
 P2oAWuwbXYBDhJpvOa6pdDVNFR4eaShTDeQt5k+cBEIhyrEv1WCUcVBxuRhC/2NMoNL8WqMhU/e
 3or/k7WpmeNDDxy7vimQNb6i80ju881C9/zwjFZ0GkPxqY797di8pFYH4KHAafoRjBkLmWjx4sK
 DcgmexLqC677UITTxEQ==
X-Proofpoint-GUID: 7FT6qD5cv1JxJiYJVQFskzfFRL_Vm_Jj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200219
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

The comment claimed every Linux ABI keeps its syscall numbers well below the
minimum, and that the minimum is all N has to satisfy. Neither holds.

MIPS O32 bases its numbering at 4000, so the default 4096 is its getpriority.
Raising N does not rescue it either, because O32 answers numbers its table does
not define with ENOSYS before the filter runs, which leaves no number that is
both free and reachable on that ABI. arm32 bounds N from above too, with ENOSYS
or SIGILL past ARM_NR_BASE. Say all of this, so the number can be chosen with
the target in mind.

guest_base == 0 is not the only requirement either. Host pointers are written
back through the caller's out pointers, so the guest must match the host's
pointer width and endianness. Fold that into the existing warning.

Also assert the two out pointers that lacked it, and point at Lorelei for
argument marshalling, callbacks and variadic functions.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260719074730.1520517-2-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/dlcall.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/dlcall.c b/contrib/plugins/dlcall.c
index 9d2230b2d1a..b624735e62c 100644
--- a/contrib/plugins/dlcall.c
+++ b/contrib/plugins/dlcall.c
@@ -10,7 +10,8 @@
  * nothing about how a library is thunked. Any toolchain can implement the
  * userspace side. Lorelei is one end-to-end implementation (guest/host
  * runtimes plus a thunk compiler that generates thunks from a library's
- * headers):
+ * headers), and how it handles argument marshalling, callbacks and variadic
+ * functions can serve as a reference:
  * https://github.com/rover2024/lorelei
  *
  * See docs/about/emulation.rst|Dynamic Linking Call for details and examples.
@@ -20,12 +21,13 @@
  * execution in the QEMU host process. It is NOT a sandbox and provides no
  * isolation; only load it for guests you fully trust.
  *
- * WARNING: requires guest_base == 0, which is qemu-user's default. Pointer
- * operands are dereferenced as host addresses directly, and the invoked host
- * functions dereference guest pointers with no address translation, so guest
- * and host must share a single address space. A non-zero guest_base (e.g. set
- * via -B/-R) would make every pointer off by guest_base and hit unrelated
- * host memory.
+ * WARNING: requires guest_base == 0, which is qemu-user's default, and a
+ * guest whose pointer width and endianness match the host's. Pointer operands
+ * are dereferenced as host addresses directly, and the invoked host functions
+ * dereference guest pointers with no address translation, so guest and host
+ * must share a single address space and agree on how a pointer is stored. A
+ * non-zero guest_base (e.g. set via -B/-R) would make every pointer off by
+ * guest_base and hit unrelated host memory.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -46,8 +48,18 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  *
  * It defaults to DLCALL_SYSCALL_DEFAULT and can be overridden at load time
  * with the "syscall_num=N" argument. To avoid hijacking a real syscall the
- * guest might issue, N must be at least DLCALL_SYSCALL_MIN: every Linux ABI
- * keeps its syscall numbers well below this; numbers from here up are free.
+ * guest might issue, N must be at least DLCALL_SYSCALL_MIN, which most Linux
+ * ABIs keep their syscall numbers well below.
+ *
+ * N also has to reach the filter at all, which bounds it from above in a
+ * target specific way: arm32 answers anything past ARM_NR_BASE (0xf0000) with
+ * ENOSYS or SIGILL before do_syscall() runs, while aarch64 has no such bound.
+ *
+ * MIPS O32 bases its numbering at 4000, so the default is a real syscall there
+ * (getpriority). Raising N does not help either, because O32 rejects numbers
+ * its table does not define, again before the filter runs, which leaves no
+ * number that is both free and reachable on that ABI. Its N32 and N64 ABIs
+ * base at 6000 and 5000 and have no such gate, so they are unaffected.
  */
 enum {
     DLCALL_SYSCALL_DEFAULT = 4096,
@@ -168,6 +180,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
         case DLCALL_ID_FREE_LIBRARY: {
             void *handle = (void *) a2;
             int *ret_ptr = (int *) a3;
+            assert(ret_ptr);
             *ret_ptr = dlclose(handle);
             *sysret = 0;
             break;
@@ -176,6 +189,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
         /* Get the last error message for a library event. */
         case DLCALL_ID_GET_LIBRARY_ERROR: {
             const char **error_ptr = (const char **) a2;
+            assert(error_ptr);
             *error_ptr = dlerror();
             *sysret = 0;
             break;
-- 
2.47.3


