Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bfYjXRQN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G3NK5JjN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIun9-0001bR-PD; Mon, 19 Oct 2026 17:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun7-0001af-Fw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun4-0005fp-RQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKI6u4190068
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GUoXuknmqQG
 vLg8BaRNLo1bJpgP08k/FekAUU2k4A5A=; b=bfYjXRQNweR5Rilmx1DmCntP6RQ
 TVmGuj05nq9NiAO8C1KQr4RbFUEST5wuj4CL+X99L54AKdikYqP/UWDWnRIEhDo4
 Q99Vl0U3netV44O3OU7Ogst/RCLZFNx31C88CkGb9AnrhLLtPTEBhyXJl8VeTjU/
 IPfcobOL2dl9/ux8o7ufYWEFnxv73aqFk2ME0FqV4tPLHbcWxj5uXPTHd7Av7bnu
 IlOzS+Et3xxTo+CRzvZfmuDk8EVpjDVBgLrM4/EKqz9kBSBMLKBnezc2WqNcfQzA
 U39NJIbGSGq4u+DuaM4fUF1pTJKm9aRQIfUcxBBV+qrG6Ymeag2C5gBxIlA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48k91q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a4aa263a4aso2384635a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444865; x=1793049665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GUoXuknmqQGvLg8BaRNLo1bJpgP08k/FekAUU2k4A5A=;
 b=G3NK5JjNibSLAu3AR3au31wzV/r28SPRb/8onahwQ7gDJQBii+D2/WVZnjlQzh8Mfx
 4qzYWDlpjDJLFLSg5w1cbGE0KbrhSx4MD2jhQiVHaWHI4n2tkRhDEs5n/zPUR4uldgwM
 V9KvFp+aMxHQkMkb5N19DBbp4hceb4931r3Jq5QUYppMkCF985dPirwqfIPdeTSP5Di3
 obw+ylIeNma2t7VEtzd4hN7ZnTrY2ESIEchZjsVz6DCwjVCcPyGPI6ghfb/2+M5lBzFA
 8gT8AlyY/kXLqxqLhkD6OQzTzi37pyuVdGfi2bR4howNz9aFtyUOTyLVAzdxNjw3Uw7P
 hRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444865; x=1793049665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GUoXuknmqQGvLg8BaRNLo1bJpgP08k/FekAUU2k4A5A=;
 b=B1zhESVl/WE7IHyFu7HhJzdNGiB90ZsvtESb0KF3WYgpL+DGcgezOzrXpetL24GTGA
 nn8+RDU6jPtZ5ChkgLwRAfA6Xe9scAVvVbZe9iVcVAzwbwkxlPHL3F2H3K1Jr2Jxdqtl
 8IgV6VFVVC7uObUrhud5mhoftF+LZwG+ZM5FDhpBLCjmGOAyf9ix3n/6Pw9j4Oj2GXbh
 drYxR+3bcctN1QIIQgsjBV4+FjOwRL8y3muS8xivN9C/aAy7aQqZ+DqwM5CJAXJwmnpu
 MgJMdgqiZueXuxrGG6WEY1qr8UuECC4rYg1JH4QWRia3e3e2dLYB0Cnnxgd6/iDXuhjU
 NePA==
X-Gm-Message-State: AFq9FYL8+F6QYYJD/RTdY/mxuPHznzmYo/5PMxTXHECs/5cu4L/i1DUQ
 bOmyO/t+l8XGv5brNivIfMn2VLNOmH3Y5nx75tCECUysS4nX/qMVZcRzcNYEn1oZKpeTEabqeCW
 o0GY2wCMMHNp0Jvs5Oi7jzFkEGSsgvs/iQDompnT0IJYylUKOkRzVd8uZ5/aUAQJ1Tg==
X-Gm-Gg: AYBFou3GiePLkp0b8WkPk/urvr/FXa5c9o9zTAJtQ2A7SXIibKQ2bUK2c+tveVCvb6u
 Mve/toK30S28Soid8YELqpT7G+fRjuf7W4X7QnwJvI1qdnT0aGV6dxup568/EFDkQwER9OgL6XS
 y7JEj9Zh2q6Rw90lAKD7vMDcRo2zP390HEMQNlLSTJO+ARrFsGxbuZxSj339ecfI8PlKdRXGYh2
 M21f7r5mHQc7XhSfEfMJHvyNIme/0+vssYELpb/i/AhYW2r4HfdTJE71eq33EUtSgxc9Z+xg4mh
 MG04Vd+z8XDsa6moVT38EyR3bzrr6NS4DUcNUb6/JaKQ7Lf96cWW/fvuMFcwus5PFzQO/nFSsC3
 AO45VWb6pgeCDzHLNh31Zl6TRMbYqKo1H+XRRbEuY3MT+XSyUePkBpc+E4boupBM=
X-Received: by 2002:a17:90b:5610:b0:3ab:189b:6985 with SMTP id
 98e67ed59e1d1-3acef4fb852mr6964759a91.35.1792444864932; 
 Mon, 19 Oct 2026 14:21:04 -0700 (PDT)
X-Received: by 2002:a17:90b:5610:b0:3ab:189b:6985 with SMTP id
 98e67ed59e1d1-3acef4fb852mr6964746a91.35.1792444864476; 
 Mon, 19 Oct 2026 14:21:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/26] target/hppa: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:23 +0000
Message-ID: <20261019212046.149572-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX2AYzik8BVSfd
 J5V9J0FCDxwpHvNFUY+3fK9LQkAmx/VPi8dcrHwpAM8KhDmnYHPtMZxuLKhaegu8s4s/ocrcq4U
 ZJLJ1bSIsjG0/6Hn8SaJSrdEtDzbvcknfoQZ8Fpz9QR0zBBkg/Ht4v+a+V/7BNkjzJVzspFNuKa
 QzcIW3gapkabH14RVGrY28IQvxCf2lm8as8n+k2Hwyl3MF15UlCh7M+2mj0Rh2VGi6OxqCmeiUG
 DocFrxK59vLgXJtHRDYzt5HDuumKeGaP9yoQd2O45w2+B1EIF+uVhSnesdGrPfMaQEz1gs4J5Bu
 rHQYupQnkUcrIRASnTwt0OeTMD/a5FbEUcsRyYNXHvpFzxGv+MSxDPrf5l878j2AenH85EcQ+tG
 m611UMpbDumEzwxmpYwJ+MakrrSX3YAVvHMDPXRTRpztSBcz8jkfo/N8oP8QUldqdQLEza4oE3s
 JkZmiENf5BaiofJhE8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXwgbY8OjjL3Er
 IkttgaSsan3auw9iD+ky2vilUyBwuQehsvltp8bExvsUeaqVV6IZthP+11BwXc2SrUJFkwvCGzL
 FAQ+QrumwN3RzOwIRBUBaHddyY3L/co=
X-Proofpoint-ORIG-GUID: G2JmFJpoPjhHyQDs8ZEjtWZP_b7UJKIw
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad689c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ya3Pk_hNRNhBRN_1oewA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: G2JmFJpoPjhHyQDs8ZEjtWZP_b7UJKIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hppa/fpu_helper.c | 2 +-
 target/hppa/op_helper.c  | 2 +-
 target/hppa/sys_helper.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index cdbebcfeb3a..a0c8c91ee54 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -82,7 +82,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
 {
-    helper_loaded_fr0(env);
+    HELPER(loaded_fr0)(env);
 }
 
 #define CONVERT_BIT(X, SRC, DST)        \
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 3542c275663..ea0680aa9eb 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -341,7 +341,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        helper_hppa_excp(env, excp);
+        HELPER(hppa_excp)(env, excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index f7fd80b5830..ccfc2b48816 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -51,13 +51,13 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
 void HELPER(hppa_halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    helper_hppa_excp(env, EXCP_HLT);
+    HELPER(hppa_excp)(env, EXCP_HLT);
 }
 
 void HELPER(hppa_reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    helper_hppa_excp(env, EXCP_HLT);
+    HELPER(hppa_excp)(env, EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
@@ -120,7 +120,7 @@ static void getshadowregs(CPUHPPAState *env)
 void HELPER(rfi_r)(CPUHPPAState *env)
 {
     getshadowregs(env);
-    helper_rfi(env);
+    HELPER(rfi)(env);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.43.0


