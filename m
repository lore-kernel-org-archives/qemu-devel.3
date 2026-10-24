Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECC606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ChGM8uvf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JpcycdED
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgD-00040u-IV; Sat, 24 Oct 2026 13:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg3-0003yD-Bi
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKffz-0008H4-5S
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExnpR996398
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vAdYAi43xpUovS4YOqs2Qx2PqnUEKIciVzLpIcDpZHk=; b=ChGM8uvfj/deR99R
 QRTC81D2Uv6/retBGt05QoKFH978rf5LNiherrOwSog675MMdoDzk+p+YHgundJY
 KRHvvqYhWLuJ6n2E41VwZKOZOKGqI5fx+Cuq+ZOV7riK6hO87fgLhUHTOvzWA6HH
 0p3U01KLyRfhnC89FtX00RRiIR042pgrjU3/pxFL4VEy3HLGruIa+h5c6zDPEUX6
 GIPNnTyQ2v8DaTrNdxlgKXe7Ob89jjN8t0Ic2HoJxKh8+eFZIGWdgt8aMNU3dgJ+
 JTLJEQlgLi0ouB+sm1Ji7rywp47lwEUosRVUuZ+yF3ALi/NU216L+dwlAwHHJ17l
 BI/ntw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9sakq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so1923506a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863420; x=1793468220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vAdYAi43xpUovS4YOqs2Qx2PqnUEKIciVzLpIcDpZHk=;
 b=JpcycdEDeEHPuFHpmuSs8neawtG39q62+7zWhCRB87LClX/fo3ynUQwHj3K1tC1qtC
 pgvPUb8GFX1wAqQNvtd9YXryDFE+AW2t/BAutzspq9cAGcjXT0TAOfiuIT98tidXJ5t7
 /UKnRywNC3vAeBWy+dxLgRPPRYZXLJAkyOmuiH6PE7ZEqvWJCh39gSpL0DIv8YauOMEh
 TSP2jFu3KPsCL6NYtHINNaV6AHCRKBNYKQMWyPKxUuMxBq+CT33yu+5RSLhBNwo6Fh+z
 +293pgr4n/2e15cFqNsXNNTUPgh87ROcqvPC1MFhfiK6ibl7/OF/Nz11SBg0+PC0Cu/n
 h03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863420; x=1793468220;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vAdYAi43xpUovS4YOqs2Qx2PqnUEKIciVzLpIcDpZHk=;
 b=alDguYEKX4JYwxIS8iNoF/KqaQMJrD3fZJbrLfnYZd1hmxqiq5ojsCdc1sp47N77X0
 upNSK6mzkqejW5vS75Zy2NIKcxpdpPv8V0j08IJLH9ZloyfintSCq0OwlHpH9dAW8aiP
 iM/y2BqcR4uB7Xa4yi793qfBmx3AF57nzFQ6Mv3IxRCjERqHHnk9p1eZCMkJTpYH3KBU
 q1oN2Kqs0uC24bPl/D4oHI5eE7dRSC6JwD/nWaVzvsZcX76uKfcoZSE95GSCQpqH+mqe
 cKOxy2qOkAci9j1SIodoAlWQnQiovGWpBe/qT9TW/qnHaFyXjDoDOsPrGWYKhgxUK8wX
 QI0w==
X-Gm-Message-State: AFq9FYIkdkFLB0sUuIKkMwlfbZIjD3BLQlqIshAtw9wda/sS9UQ3Dz7o
 7aS5UY/ZLKnUN5QBqzXNyaGT7aQXR3ojL6wO3czcQHKmf+F2G05KQM1zRcapn9wWG+2tZEJDtnu
 C19uAAFpwcwPGZnowgBimgn9zw1V+Yov7ndbBTrKqZQDEybJAee6E3S5cnD/3Wz8nQA==
X-Gm-Gg: AYBFou3phscGmo87yIQbL6Vp+OxPYpieaczwHlbKD93LfiAVNHMkx5eo8xO8uSW7JSV
 mNBhyurqd7wlJLHtPDlJq3wqsB7tWEklJyRRJ6BFcy8brNonDdya0+NxEokXzhYruNrAvkYHS8W
 lDd5IxPTfbQbSXf1GmdYINRtmoTtfuzA62LPLC2FGAbFLR8AFYNzXaB68DqUIOkbtBJDA0bY1rV
 8vLHBMqltwGKR9QrHKlC5ZVbM9xegWpHNwXkRJ2DnLyaQC1D+/OGGP5TdN1z1Oo+SqteK7lVzWP
 7walr1sOd+NluJnD08Q3GWUw43OTpLpRZZXdhbqIqlxtjlWZMdeePaKnECCW1k+k150lMhn43uD
 zCfvTz8nA2YzMxqbdDSPlc2NJzrWReu0UQkhh/v4vBA5Y3KKA6WX1YOHWpFCBFJc=
X-Received: by 2002:a17:90a:da85:b0:3ab:c370:3684 with SMTP id
 98e67ed59e1d1-3adead45d61mr2156322a91.30.1792863420160; 
 Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
X-Received: by 2002:a17:90a:da85:b0:3ab:c370:3684 with SMTP id
 98e67ed59e1d1-3adead45d61mr2156316a91.30.1792863419677; 
 Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/20] tcg: introduce HELPER_INFO macro
Date: Sat, 24 Oct 2026 17:36:31 +0000
Message-ID: <20261024173649.7405-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PcEDweQ6mtFxXfjiN3V9AnO1j_chbDqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX82qwHYHMIOTV
 z2Qz1LKmL0c1tqgUTmcM8rtITfLJ9lTY3AFrXQA/eQ48jhtQm/yjkVe0C3600YYgS3CQjx0XWtp
 VxGFMyeYzXW5G7kRYRh0s6QX2Uu4f3DxtXGjKDU50qorVJgZc3O8urb3i1CuVMqex5drbRQ6xQJ
 u+wnzEeyBgXhfqqiFin5/eCy056rcvrdv8cjGJScJkKPAJoS9MWIbt5htIQmIXugirBi85B5Mg1
 8qNfORDYqPUF4u81fdHUCxXblhjOobo4IEiVllazUiF5/CtjJvnCfv2s1MUcsmuqFVk8vvKqdZM
 ZYnsk8FUOiI9VaQZbNXA7NiB8o73ZjIcl6//51+mWPukwT9F33IJ6dqQ9XHOni22EC8pdOF3Xnz
 UAO/BzZt7ihlatgjL5fl1c0QF73WAe1LHyHDiqiyPT1n7ZDvTtgJh9k3LMDkO4/sD4T4GcAv9ia
 cmjdsMIIpK7bKZBBKVA==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adcecbc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ighA3CKJURImTjC3cZkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: PcEDweQ6mtFxXfjiN3V9AnO1j_chbDqH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX0TpUxVj5Lih5
 TBrftAsQYv6mDGav0qU5IoNg3Lqaxljh/JV6JyDGz/2OEBVP4B4C0ANhAnAqtAdJ/wf7QJihCGH
 dlttNKqsvcA+O2w9Qss+28InwVTJk9Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In next commit, we'll prefix all helpers and helper_info with target
base architecture. Make sure helper_info symbol name is defined in a
single place before that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/exec/helper-gen.h.inc  | 48 +++++++++++++++++-----------------
 include/exec/helper-head.h.inc |  1 +
 include/exec/helper-info.c.inc | 16 ++++++------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index dabe138e205..95715bde1ef 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -11,88 +11,88 @@
 #include "exec/helper-head.h.inc"
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_call0(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret));            \
+    tcg_gen_call0(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret));                  \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    tcg_gen_call1(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call1(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1));                                       \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    tcg_gen_call2(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call2(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    tcg_gen_call3(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call3(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-    tcg_gen_call4(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call4(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2),                         \
                   dh_arg(t3, 3), dh_arg(t4, 4));                        \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-    tcg_gen_call5(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call5(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5));                        \
 }
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-    tcg_gen_call6(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call6(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
 }
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-    tcg_gen_call7(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call7(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
                   dh_arg(t7, 7));                                       \
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 7dec5f5b067..be1d79cf017 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -9,6 +9,7 @@
 #include "fpu/softfloat-types.h"
 
 #define HELPER(name) glue(helper_, name)
+#define HELPER_INFO(name) glue(helper_info_, name)
 
 /* Some types that make sense in C, but not for TCG.  */
 #define dh_alias_i32 i32
diff --git a/include/exec/helper-info.c.inc b/include/exec/helper-info.c.inc
index c551736d49f..4e1ab61e5ce 100644
--- a/include/exec/helper-info.c.inc
+++ b/include/exec/helper-info.c.inc
@@ -16,21 +16,21 @@
 #define str(s) #s
 
 #define DEF_HELPER_FLAGS_0(NAME, FLAGS, RET)                            \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0)                                 \
     };
 
 #define DEF_HELPER_FLAGS_1(NAME, FLAGS, RET, T1)                        \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
     };
 
 #define DEF_HELPER_FLAGS_2(NAME, FLAGS, RET, T1, T2)                    \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -38,7 +38,7 @@
     };
 
 #define DEF_HELPER_FLAGS_3(NAME, FLAGS, RET, T1, T2, T3)                \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -46,7 +46,7 @@
     };
 
 #define DEF_HELPER_FLAGS_4(NAME, FLAGS, RET, T1, T2, T3, T4)            \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -55,7 +55,7 @@
     };
 
 #define DEF_HELPER_FLAGS_5(NAME, FLAGS, RET, T1, T2, T3, T4, T5)        \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -64,7 +64,7 @@
     };
 
 #define DEF_HELPER_FLAGS_6(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6)    \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -74,7 +74,7 @@
     };
 
 #define DEF_HELPER_FLAGS_7(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6, T7) \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
-- 
2.43.0


