Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADBB606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h6xDujrP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N4tp7f17
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmte-0001d5-Mw; Tue, 27 Oct 2026 15:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmsF-000199-Fr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmsD-0002mB-5J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHCp82087863
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pYFz2ET16ahR18lCzCSXFnEqciJrGqt1hPPiM19mu/o=; b=h6xDujrPCS5Z4fvC
 3WM/2b2D6meV06YeYHMO2C9UvxRAObbAC7yPoJzT1TZnR+4NhZLvO6EEWLqSTiaD
 BEEx2Qhu4j462IGoExSDo+dpAIOvm4D8NAcwrCpvrlTpIQ3MzbwpFZ5gvLL7oj6x
 Hx1yoe2y7vY4M1OKgIVzy/RkZOCVw7Z6ELRQo+yKRkiugMY1ucmtN1nOt+o9EbcS
 +alekfwF9mDP4DvXn44+RtXoWFi116SlatMqeNLdjHmPqFs5w2e5bb8GAvnQnnfN
 t2SHp2KQ6tkMka4t/W9BIMAPbzVdNLSk1NhYm5xgXatFWP/SJPXpf8tUfNr6M+OX
 W6pmwg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbbe6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c75523074so5466786d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129414; x=1793734214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pYFz2ET16ahR18lCzCSXFnEqciJrGqt1hPPiM19mu/o=;
 b=N4tp7f17zDOvYq7w0CpE6QgU2zKaAzJySQNU3u8a0IUdo0JyDuL3hEfP1YrqqCW1He
 wMxtnXIb3RZESwLnGGMAzjKV5wDXckFQ6oJTTLIbYD5IArIKQRzGkuxm0MZXk4TcANu0
 QF/Nr1lcYNvGPBdqDHOHP+CjbdHpgk6U52Fl73eWDONA3Tk6PlSdg+YkkvHFGoxb+acR
 MgYKzczZUsraZtiqh1ZQBz1yjYcZN3O2j4zG4ZzmDgcrVpaaQWmRni4pZcoQQAM3dYZA
 4sf9KJ7oT/mjy9BbwCPETdYd0gx5oKbvhbeePxBUrR1MYG5fhAjHOmm5v4zbHRW6VOIB
 hXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129414; x=1793734214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pYFz2ET16ahR18lCzCSXFnEqciJrGqt1hPPiM19mu/o=;
 b=OqPRknyPCHDtd+aTpD0DDOAAUTOcH23SgZ//Yxo+Eg+nkNQk5nTvvKl1F5CRHmoqA4
 am8R5MdSgmCK/mTw3rSGnju8x9xEnyTSdSW7vpLozXhk1uf5Qlpg9YBmSnQCo0cLt8lx
 qrMtjRQiKWYkdkah3xDS1KQBHhPMYCyPdpBAJbE9Sq5lsFa88sk1d6MIuG+QUX3d0X34
 09plKvGl7kSoEPiyvHmh07gZ4xr9tnTHs7B4H8H/mVZbfVHnt0pNMLiOFkaeH/Ps829A
 J7+goK5G3dMd6fD/h0KpunOfTRcWl2YRLqH15bsDPSIlOCvYch1n3PaoEHU4g0CBN8Tu
 Mc+Q==
X-Gm-Message-State: AFq9FYLv4vrBSzl28SznHg9Lgdp0MHlR1bcpbOK+v+gww1WB4sNSOxqN
 r6LxYZolhMV+cSnr2m2pOFK9+mXwQhWzkuCNrr4S6lpin0O1CUs6bfp92PSWJSABPeErbx8dDGk
 cX5mlp2YZXQbQCfydC21ZBj5k8eFoD+TkdeDGtvYQ58hj9ymOxS95RY/DLsgigu80nw==
X-Gm-Gg: AYBFou3f1knsRhaIu4Hi7CkqCKwy6d4YZjrd+a4ff9m80lQYLYez2ngmnTXRK//lPV6
 Ppmb3J4Ka6/qmdkNGgeUo5XkL6EkOoPo7RZQGBkfZfTy5uvltXMFzQ9xKO+nxgFD+ayiUnfWZna
 3ZoysheFh3YSPGtvEPRqaf2ROzOL4qyMFr5334RWK9+B96ikMu8mhEhxYLnf2iaWzQ6qPs1pTiQ
 s6jguXjxRM5Az0vZ+EUGDMQb8MrFP6ncTdxChh8iGZZB7S2YHVjU9MWDQUnNRM62eVGJ3u/M+oj
 c58KgleoNicTs8OVQrbWSafVzU2cm9uTg3gz0Sj//T0ji03lw5/m6I4CerFWoYMGSmsum1cQBFk
 ceBfR75RVGXsI25BWRyjYRvR5G2QYsF7Hq2mFTDiGKO5y4KMR/8+p9WMR3RDwPOy5HqIAED4MDT
 QM7ShwHymX3Ta4tN8Rm0FGqQ8tT0r+qA==
X-Received: by 2002:a05:620a:4542:b0:93f:19c2:da4 with SMTP id
 af79cd13be357-940ef94b224mr1501601885a.70.1793129414337; 
 Tue, 27 Oct 2026 12:30:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:93f:19c2:da4 with SMTP id
 af79cd13be357-940ef94b224mr1501596485a.70.1793129413724; 
 Tue, 27 Oct 2026 12:30:13 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8656sm2770205e9.10.2026.10.27.12.30.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:30:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/59] qemu/arch-defs: extract QEMU_ARCH_BIT for QEMU_ARCH_*
 enums
Date: Tue, 27 Oct 2026 20:23:38 +0100
Message-ID: <20261027192341.9197-58-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0fbc7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=kAGlr9DBaqhD0l0nM9oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: naLFjf3Sjhjj0rmlkkPPYiV8fBkiTccv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3BCdU4lkGn0F
 FRJOXQphPiGv/NgHuor6W0wTy3vatYT0xrZOE8NmVWHTHLS/3a3NtDcKWLBg+xL6jlsE7cb82tg
 m+6sJPcKIaWMo4ad1tatuLPjaD8hZ88=
X-Proofpoint-ORIG-GUID: naLFjf3Sjhjj0rmlkkPPYiV8fBkiTccv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX18QqFyESz9EJ
 b2nhXMczkAy085IB0ZsG170NvxNP0ddamCHCJ84pBqJ1rrHk5zE6JjPJXgiak5Cxdq4sa+9Zv1U
 nsx+xwJWCZYU2cVjgADbHau1v2Z3dx2EdcJ8mnCYhnGdHe10bpGiRiH2cy4COq09mTi+VqFmwZS
 yzsZCR0CiwA4gSWj/bVjfZa3Lp0T0TBOC9cK0KNyXRQTjATdthNBDYO7rzqLUfnZDjhfbkmmMSf
 3g69eytYS8EUqZFDiYPcR2CUFN4yuE7xFJ3D9FD1VRKYPNLOrv1+9zDKV4ZOnDarixlFYnc9/oJ
 f+/Bsb39UR00e79jdWTXW7CB6p16nmdZFnnS4Nf/Ib6o2gynL9RhHyfwhvrIwP6VspJkhbWxpei
 3sADN1KzJ+PmZeItiX7Ipuv8Sh25ViPJYU9MYG72cKQr7RjlIBLMVcpLnWenS8N9Ch7Jjvk1ZVA
 PtT63TwVV+zf7zUHBXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261027061504.2213-2-luoyonggang@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/base-arch-defs.h | 60 ++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index f33465738c9c..806ad8094a41 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -9,36 +9,38 @@
 
 #include "qapi/qapi-types-machine.h"
 
+#define QEMU_ARCH_BIT(target) (1UL << (target))
+
 enum {
-    QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
-    QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
-                            (1UL << SYS_EMU_TARGET_AARCH64),
-    QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
-                            (1UL << SYS_EMU_TARGET_X86_64),
-    QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
-    QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE),
-    QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
-                            (1UL << SYS_EMU_TARGET_MIPSEL) |
-                            (1UL << SYS_EMU_TARGET_MIPS64) |
-                            (1UL << SYS_EMU_TARGET_MIPS64EL),
-    QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
-                            (1UL << SYS_EMU_TARGET_PPC64),
-    QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
-    QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
-                            (1UL << SYS_EMU_TARGET_SH4EB),
-    QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
-                            (1UL << SYS_EMU_TARGET_SPARC64),
-    QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
-                            (1UL << SYS_EMU_TARGET_XTENSAEB),
-    QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
-    QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
-    QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
-    QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
-                            (1UL << SYS_EMU_TARGET_RISCV64),
-    QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
-    QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
-    QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
-    QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
+    QEMU_ARCH_ALPHA =       QEMU_ARCH_BIT(SYS_EMU_TARGET_ALPHA),
+    QEMU_ARCH_ARM =         QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64),
+    QEMU_ARCH_I386 =        QEMU_ARCH_BIT(SYS_EMU_TARGET_I386) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_X86_64),
+    QEMU_ARCH_M68K =        QEMU_ARCH_BIT(SYS_EMU_TARGET_M68K),
+    QEMU_ARCH_MICROBLAZE =  QEMU_ARCH_BIT(SYS_EMU_TARGET_MICROBLAZE),
+    QEMU_ARCH_MIPS =        QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPSEL) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS64) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS64EL),
+    QEMU_ARCH_PPC =         QEMU_ARCH_BIT(SYS_EMU_TARGET_PPC) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_PPC64),
+    QEMU_ARCH_S390X =       QEMU_ARCH_BIT(SYS_EMU_TARGET_S390X),
+    QEMU_ARCH_SH4 =         QEMU_ARCH_BIT(SYS_EMU_TARGET_SH4) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_SH4EB),
+    QEMU_ARCH_SPARC =       QEMU_ARCH_BIT(SYS_EMU_TARGET_SPARC) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_SPARC64),
+    QEMU_ARCH_XTENSA =      QEMU_ARCH_BIT(SYS_EMU_TARGET_XTENSA) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_XTENSAEB),
+    QEMU_ARCH_OR1K =        QEMU_ARCH_BIT(SYS_EMU_TARGET_OR1K),
+    QEMU_ARCH_TRICORE =     QEMU_ARCH_BIT(SYS_EMU_TARGET_TRICORE),
+    QEMU_ARCH_HPPA =        QEMU_ARCH_BIT(SYS_EMU_TARGET_HPPA),
+    QEMU_ARCH_RISCV =       QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV32) |
+                            QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV64),
+    QEMU_ARCH_RX =          QEMU_ARCH_BIT(SYS_EMU_TARGET_RX),
+    QEMU_ARCH_AVR =         QEMU_ARCH_BIT(SYS_EMU_TARGET_AVR),
+    QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON),
+    QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(SYS_EMU_TARGET_LOONGARCH64),
     QEMU_ARCH_ALL =         UINT32_MAX,
 };
 
-- 
2.55.0


