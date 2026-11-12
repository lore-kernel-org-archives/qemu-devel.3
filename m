Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFC606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A7IEuLMM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kDNLgKKI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZGF-0001mH-M6; Thu, 12 Nov 2026 13:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFB-0000qA-Hj
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZF9-00061M-TM
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:53 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFaPEE1593542
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6fKbMKn68ezBHC8ou3dOXWEvUPDMjx21gRkA5jMNGU8=; b=A7IEuLMMOGCDV1pP
 adeEcdWrWzS5FGSA/VAEII2kcyOH8ioUdObVaWp9YGrMqhKSMUBn5m9VblT3exbT
 F4KHu+xwU3xUSISHWxV/JqYy//I6WcTolTK20kyIew5KAo+Uux+ky/qp1cu1VvH5
 tUBgkQUj8xkLlfEWQ83JbcfbzVutxMpb8X2kiaF5Hp7Ftv6lMoCjvTwkyp7pLym5
 wC3io2ZmUyxJLm3dT2hCH1xS5oZsDEY2UdYhEeqXizurtpZorMCaV3RMjPBpBBSy
 MDoXLTKpj6UKdbIMWuP0Uu3nkiakJOsfyrtc4/zbZfCFsWAeXa8UNLaECcVZu9G2
 I77V2w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8m4rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:50 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99063f4065eso49115241.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506989; x=1795111789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6fKbMKn68ezBHC8ou3dOXWEvUPDMjx21gRkA5jMNGU8=;
 b=kDNLgKKIWf3Q9pLhqtEL9tlAWlnJ25YnkDWclDtMmGZpomhf5Q1+Y2Py9IPVOkpJhf
 LBuKnzLs1tMdlS7aGZ2D9XdAsH+AzxxGjh1c6lMGttGTtdYr0S8ZHu9Jh/0CEJ0KkzWz
 DLRdvq6JhppUroAmotTyTjvIkHkmD94UxhHXRCFsYFxkICop4LYy404LQjWGqIqE8vVx
 51Z/46/vDUnEUGKjGbjodtaQscLWmfT8XqUqaJmwzeXqF9v+CFEx/q4iRFzvhPlDil9x
 wYnzLT+fy6M+mYxshRsiEhzvr/jxCzzHThQ2ltL6X+tttokwBjbmwTHoQ6r098iMjZoM
 37hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506989; x=1795111789;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6fKbMKn68ezBHC8ou3dOXWEvUPDMjx21gRkA5jMNGU8=;
 b=m2RBcSgInQCnOSQljYBQWG4wDi/e3Tz8oHtHJeNyltCsS3vTi466X0KNcwhYeYpecV
 JYlFNoBm+YEYq3jUa0CA6qz36DPK3rB8j7ft3nTe0PM91NXt9NCdb5Af0S1veFbGTpMA
 rKLMJH4j525U0ei810QS5ih6t82Mu4HTEime5gesvKPsAC4/3YMAF3SB+kk0FmeXstnf
 9ieP4UaOlnv9PaoZwv8CSrBscgnenBmsU3rWwWyXzJqyTAMviebr7qz2+KSia4cQ/E4z
 YlBzx/i4wo3l4KzbqFmWyfboUp6K8mqkeLzmyLDo4dvYW++yN9M4htcl8zgGC7CAwUfR
 oNDA==
X-Gm-Message-State: APuU4Z/xFzR2xAF5+AxF7wqKQwmv3BAGu+sFcvrtoYt19khqFv8Gkbk5
 1parcPcaQVg4H6EICAfSHc3bilL2E1ln4k5wG3wrIFra7D/PCLW8Ts9TdQ4iFIs/8z4L8Ng1zNu
 l86exu8zDpEjKAncDt96DyNkOtyQStvJLQbCz96lZd82BUTwQie77XQEVFmt0yEG9Gtmi
X-Gm-Gg: AYBFou0tPDerPaKalpxpsSUmi9m3KCu0i0SfRNcizLpMfgAUXqF+KML4RmrkO2p/UoZ
 4T3QdUtvxjKDqHUO6Uphb9YCdQd+isM02EhYD31Xk7/KuP+40+wlhZMyRxY8DYpIwLf7cRmt7vL
 Hh3cXWblIPyPOPTWjYAGOWGZYD6sXeesvTpzA5NTq3RjOZvL3c05MA9h8hIhCL0BK3yJab1pNst
 9RF6G2/yu1SGOU8ycYe4bdiCuF/dLvyuK5IE+chovu6mhz0zS/NGD19t/5u9GtZIcH5vvvasMWG
 8ROwFFbpo1JAi/TswJ66LfbrL9eOJavbv1OMfByg131iP2svb4EAPfaDrgSjOOOr/HfGnUWTF9h
 Q+gKrsVkvn9ZOLUM+j64BqxMbY30e7dfwiVzTu0pkA/HEkT7qH9gUY6yyO/QGj4igu5Yn09SAiL
 fAsdMSAg7TL84Dnw==
X-Received: by 2002:a05:6102:5086:b0:7cc:174b:f7bc with SMTP id
 ada2fe7eead31-7d64d784ec5mr995137.15.1794506989257; 
 Thu, 12 Nov 2026 10:09:49 -0800 (PST)
X-Received: by 2002:a05:6102:5086:b0:7cc:174b:f7bc with SMTP id
 ada2fe7eead31-7d64d784ec5mr978137.15.1794506988651; 
 Thu, 12 Nov 2026 10:09:48 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm532900f8f.35.2026.11.12.10.09.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 06/12] linux-user/arm: Move CPU endian checks to
 runtime
Date: Thu, 12 Nov 2026 19:08:52 +0100
Message-ID: <20261112180859.85380-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX0+pknCJEcGDi
 J1pAXLEOMKqrUjnQ7wMs15WYXnH4CSdDJh7PcThVf1i/7N6hZw0RusDCIvKNY9Lo9uo9ZsguCy5
 8EezDGb1Ny7ZO8fEvzj1BIcpQ2PDVuw=
X-Proofpoint-GUID: wF43lN3G88EpgXpWlDrPbfv0GznPhCmJ
X-Proofpoint-ORIG-GUID: wF43lN3G88EpgXpWlDrPbfv0GznPhCmJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX5zlnaHtflt6x
 qnGBa4VGda4U8thrbFNaE0Gp35zwiIJiRy/foY+7bHFWPHD2TtjE7vvg31z6WA7a/79mFGxFqlc
 LElTNxLC3WSsfimmKWwb2TKkDRaAW5DnMy96upwBmTvmyKk/T99ZvSc20dlKrYi4IR8YUdAW6va
 xj/bqnfgzweuVKAufy75HAluPaXnZiC+oqoKuMvFafUCQLB9kM66BtmxFqEsdNsdWgweucvU83K
 BVPzc3iee421a9f/GvAVGWdvUpC7HPz97nIQDo/5iHo6Go1AEZLJa1sYmQw0axlBVC4v06lFuO0
 zzoMP8Uu67ZGmurhJ8da0uM6zKJfwzquDC4zfWWYb0c7kqQWjFsgMcqct5TjGPp6HZQLljkm6Lm
 bChzVIVuaMwiQJXs0sMXCsC2IKyOVpDxYR2ngF7u6r5NN2+i7XdR/6KWlZHECoHKSfe04PhpliR
 qB6lLulVm627aowAVdQ==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af600ee cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iFU7bGKKkzA5f0XaDRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use target_big_endian() for BE8 code-order handling.

Preserve the behavior of the existing fixed-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.h          | 10 ++++++++--
 linux-user/arm/cpu_loop.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2f393f50184..7fb1726e8744 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -22,6 +22,7 @@
 
 #include "kvm-consts.h"
 #include "qemu/cpu-float.h"
+#include "qemu/target-info.h"
 #include "hw/core/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
@@ -2660,11 +2661,16 @@ static inline int sme_vq(CPUARMState *env)
 static inline bool bswap_code(bool sctlr_b)
 {
 #ifdef CONFIG_USER_ONLY
-    /* BE8 (SCTLR.B = 0, TARGET_BIG_ENDIAN = 1) is mixed endian.
-     * The invalid combination SCTLR.B=1/CPSR.E=1/TARGET_BIG_ENDIAN=0
+    /*
+     * BE8 (SCTLR.B = 0, big-endian target) is mixed endian.
+     * The invalid combination SCTLR.B=1/CPSR.E=1/little-endian target
      * would also end up as a mixed-endian mode with BE code, LE data.
      */
+#ifdef TARGET_RUNTIME_ENDIAN
+    return target_big_endian() ^ sctlr_b;
+#else
     return TARGET_BIG_ENDIAN ^ sctlr_b;
+#endif
 #else
     /* All code access in ARM is little endian, and there are no loaders
      * doing swaps that need to be reversed
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 262ab5cc416d..6d19a9a8a070 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -505,7 +505,7 @@ void init_main_thread(CPUState *cs, struct image_info *info)
         }
     }
 
-    if (TARGET_BIG_ENDIAN) {
+    if (target_big_endian()) {
         /* Enable BE8.  */
         if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
             && (info->elf_flags & EF_ARM_BE8)) {
-- 
2.55.0


