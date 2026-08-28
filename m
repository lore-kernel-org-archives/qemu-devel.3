Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C34EC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05XZ-0008W2-05; Fri, 28 Aug 2026 18:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XX-0008VF-Dn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XU-0005iA-LS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMT5rB731504
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LdpFXWEHK5O
 ua2FJ27EcSYM8sHgdfUcVx7QyFPkX6RQ=; b=fVZXMDQ74Gy+gqY5g5Acw4znW+B
 kwzh0Qr8/IJqgQzmBZpmPGUPbHmKjNqQcXd4SMJ/y5X4xNtDmHiEfy/a4U8D43hS
 4RruzpO2OfpuDHxRS6IZGzHJqz6Z/IywKGo6j1pkSrKRaQatmJ3shrhMpOk0sVE0
 fdkoD6Uanz3g2a/QJNif0jSxCVMkOy1APfOAXLCVBrGtjxejEoSeX3bSAcBiieOb
 JZNukJnSpVbMdhYoXLXdmFLiUcrInqfTRYmXyQ59IqmqFNIBt7i8AJV33UtJ2rUr
 xWr6TA76f9JtYRa1sYM+wEofoDNyTnHccJ/Rk7J1LHVBXuKdWZM0vr7X40w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbhgtrbfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so2023704a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957946; x=1788562746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LdpFXWEHK5Oua2FJ27EcSYM8sHgdfUcVx7QyFPkX6RQ=;
 b=PnKzHKMJpNAXAkFtY6lLDHXhveHc0dESwGadyxXBUetE6HWnjjn/cxDHukCd7KI1Th
 wX/GBnzDrXAGpk/4+5pwHzIlKi57XOam/gSUoOZDVjAjNJrTQdzGFtY8UqovXKBjW/Dh
 ik0MbP3uNLGxD13eEEt8EmQiwdzQKeWXMQ6UOk2WJ4KHI9uwsaLWNqjZxVcUGUDk6Qcr
 u44oZhf+7tQaqG89+20Emj/i4HB/+JlbBSKUhbrvEZgGpepqOEDzdCsZLsq3+pCldcrV
 xmHFS7x6qAwegfj9P8XnxyHOzjJ+pActEwda7f6/JZkXOZe3nDOA6RgxxfE5D4oLDKG5
 gAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957946; x=1788562746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LdpFXWEHK5Oua2FJ27EcSYM8sHgdfUcVx7QyFPkX6RQ=;
 b=jKgTuGcwPTYRMyKY5tQc9Axo3ndAXEjw7sUVocKEtseWX1joftXnjLzJ5WAghHhgWF
 sEFHL2d7LBghw1ZoLhZwWkrsjhjnsXL19w9tzQACxtJeCsctXhrk9NSqX6bgAbOiiiJl
 Lyb71GKrE/3WyyMC84Dw1Rjqqac6rkbFku1ilFfzxNBDp4EdBbKF8Mnvi7Mb+hXiPAfu
 SFqJ0HlVvSP6poJlQmQLCJcBHtWMlwQoUaUDZq4vfJAb9g+4v6IWnIzQCcWHaZsXXSWm
 10qdFlRrvvwemIhdFYVIYwQXm0AxTEGQbLik2Zz/AQ+bVopbo5sZy05T4p+5yovvaK3i
 0GJA==
X-Gm-Message-State: AFuF++kI833PQEzA0oBXicLu/3zB+Rcn8uebszopYnPgVwYZJFIdpxuH
 yzoUgrAqSble63VFxSVrHs9i8/Z+SMYiL8g6/BJteJCXyRZXNf4Oq11qoMjO5ug49yndKFIU8rR
 ZT4z9Yz/n3w5TK3tpM62c30kVrrIcAkA9LVC53N41y4irOZbJTFv4Ug9VdYh45O0RQA==
X-Gm-Gg: AYBFou11nWBZS0X4wWmKeiw0QJMA/pVRNNJiNQVFUYNK4PiQHMGM1dxsH4wXdNsDoTl
 NBeYre8W0dQpMHou49vViKxbECH1bbGI9U2N8jUofy2WbU1NAe0W5YItM2e3cBKB4HzCwpDX3df
 6uZ+erA1nG13tUVfBCotV4Kn2evmAwAc2xeUhjbz0mOIGJtHFBpuhjLzOEKoNW7q9zcPzvLWQpv
 jUaEVcGUw/Wzo6AAFqau34XadYF2JQXiLKYoH47gjhs5wPAaMb5DIFQO0E1SGxt2W7T9L5iE/Et
 a41E2ncYNSnAJMxnTQdGz4gx1XxbDCq/In8nma6CBmP3XGcLZFZsRjG0WKqUWKASnx6rnvZe0IK
 goCg2Imy9JDczePETdSwlb7HmtiLc081AauM4wEsKBER1XwcLmEY3wg0avy4=
X-Received: by 2002:a17:90b:3c83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-3989bd54c84mr4221632a91.18.1787957945848; 
 Fri, 28 Aug 2026 15:59:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3c83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-3989bd54c84mr4221588a91.18.1787957945296; 
 Fri, 28 Aug 2026 15:59:05 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/47] target/arm: Move -cpu max stuff out of cpu32.c
Date: Fri, 28 Aug 2026 22:58:15 +0000
Message-ID: <20260828225901.367438-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1cvWMKD93b69
 GZtZnhXnGjD4TkM91XDZwsImo9a+Fc+PAEuhC/2s0j6I5Mn65OvFJU1QrZRO3AChePgb+LsUk4g
 g6X54UAXgKQp92OZPHUzzw1Y+OAbvvY=
X-Proofpoint-GUID: cvDMtrOd3NcaIOUxAuZNhuy7vGmPnQzp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX0Gm1RmonPWvs
 Loivv44EUOx7jkoZoTLaIZJbRhCA6AQ6oXtxCv3u4BgVQIK/EaY0mBNJyo8k+mhsN47fsa6W0qO
 B6trEEJHlHNIA56YDYYFKeTXj/Hz0pEedHahyLf/cPut3hh/i0WvQol82wXASZJPYGyZAuGRE+Y
 IC2edYDMpmxehZYtZ0+2b7t6ZIJafseGGeCBYQSG8+4wwZOT1NnAR0zYjBMT38Ds0iuNdaSj/h/
 tltSLALA42jyVy5TJYLnoPO+RjPvIoqkCJYL6yqmwZIsHBA9SCSDEZL3KhHK9p8fMaQ7G5xfN25
 IdR0nWFu0LYa9q9fJPUFzx4gSmHXJ+TA710HvDdMLSZcKsdqWUEZ41NCJdZCPGzMPA7D6wxtJFR
 cVuix8RTjGF7K22KrB7+ygP1Z7Ptqiq2VqdHOiO2NZ5K11zyA1CAY5cQ6vIi+yCNyueWEYndbmP
 xa0aGV1XaAoMOyMU93w==
X-Proofpoint-ORIG-GUID: cvDMtrOd3NcaIOUxAuZNhuy7vGmPnQzp
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a9212ba cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=y0VUJ5lvzVb6jNY-9B8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/tcg/cpu-max-v8.c | 117 ++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c      | 111 ----------------------------------
 target/arm/tcg/meson.build  |   1 +
 3 files changed, 118 insertions(+), 111 deletions(-)
 create mode 100644 target/arm/tcg/cpu-max-v8.c

diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
new file mode 100644
index 00000000000..5c0ba28edf8
--- /dev/null
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+
+
+/* Share AArch32 -cpu max features with AArch64. */
+void aa32_max_features(ARMCPU *cpu)
+{
+    uint32_t t;
+    ARMISARegisters *isar = &cpu->isar;
+
+    /* Add additional features supported by QEMU */
+    t = GET_IDREG(isar, ID_ISAR5);
+    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
+    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
+    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
+    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
+    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
+    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
+    SET_IDREG(isar, ID_ISAR5, t);
+
+    t = GET_IDREG(isar, ID_ISAR6);
+    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
+    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
+    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
+    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
+    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
+    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
+    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
+    SET_IDREG(isar, ID_ISAR6, t);
+
+    t = cpu->isar.mvfr1;
+    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
+    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
+    cpu->isar.mvfr1 = t;
+
+    t = cpu->isar.mvfr2;
+    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
+    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
+    cpu->isar.mvfr2 = t;
+
+    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
+
+    t = GET_IDREG(isar, ID_MMFR4);
+    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
+    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
+    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
+    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
+    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT2 */
+    SET_IDREG(isar, ID_MMFR4, t);
+
+    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
+
+    t = GET_IDREG(isar, ID_PFR0);
+    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
+    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
+    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
+    SET_IDREG(isar, ID_PFR0, t);
+
+    t = GET_IDREG(isar, ID_PFR2);
+    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
+    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
+    SET_IDREG(isar, ID_PFR2, t);
+
+    t = GET_IDREG(isar, ID_DFR0);
+    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
+    SET_IDREG(isar, ID_DFR0, t);
+
+    /* Debug ID registers. */
+
+    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
+    t = 0x00008000;
+    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
+    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
+    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
+    cpu->isar.dbgdidr = t;
+
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
+    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
+    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
+    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
+    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
+    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
+    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
+    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
+    cpu->isar.dbgdevid = t;
+
+    /* Bits[31:4] are RES0. */
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
+    cpu->isar.dbgdevid1 = t;
+
+    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
+}
+
+void aarch32_max_tcg_init(ARMCPU *cpu)
+{
+    aarch64_aa32_a57_init(cpu, false);
+    aa32_max_features(cpu);
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Break with true ARMv8 and add back old-style VFP short-vector
+     * support. Only do this for user-mode, where -cpu max is the default,
+     * so that older v6 and v7 programs are more likely to work without
+     * adjustment.
+     */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+#endif
+}
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bc07e33877a..34436ad6ec4 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -758,114 +758,3 @@ static void arm_tcg_cpu_register_types(void)
 type_init(arm_tcg_cpu_register_types)
 
 #endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
-
-/* Share AArch32 -cpu max features with AArch64. */
-void aa32_max_features(ARMCPU *cpu)
-{
-    uint32_t t;
-    ARMISARegisters *isar = &cpu->isar;
-
-    /* Add additional features supported by QEMU */
-    t = GET_IDREG(isar, ID_ISAR5);
-    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
-    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
-    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
-    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
-    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
-    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
-    SET_IDREG(isar, ID_ISAR5, t);
-
-    t = GET_IDREG(isar, ID_ISAR6);
-    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
-    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
-    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
-    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
-    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
-    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
-    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
-    SET_IDREG(isar, ID_ISAR6, t);
-
-    t = cpu->isar.mvfr1;
-    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
-    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
-    cpu->isar.mvfr1 = t;
-
-    t = cpu->isar.mvfr2;
-    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
-    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
-    cpu->isar.mvfr2 = t;
-
-    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
-
-    t = GET_IDREG(isar, ID_MMFR4);
-    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
-    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
-    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
-    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
-    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT2 */
-    SET_IDREG(isar, ID_MMFR4, t);
-
-    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-
-    t = GET_IDREG(isar, ID_PFR0);
-    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
-    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
-    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
-    SET_IDREG(isar, ID_PFR0, t);
-
-    t = GET_IDREG(isar, ID_PFR2);
-    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
-    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
-    SET_IDREG(isar, ID_PFR2, t);
-
-    t = GET_IDREG(isar, ID_DFR0);
-    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
-    SET_IDREG(isar, ID_DFR0, t);
-
-    /* Debug ID registers. */
-
-    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
-    t = 0x00008000;
-    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
-    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
-    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
-    cpu->isar.dbgdidr = t;
-
-    t = 0;
-    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
-    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
-    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
-    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
-    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
-    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
-    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
-    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
-    cpu->isar.dbgdevid = t;
-
-    /* Bits[31:4] are RES0. */
-    t = 0;
-    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
-    cpu->isar.dbgdevid1 = t;
-
-    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
-}
-
-void aarch32_max_tcg_init(ARMCPU *cpu)
-{
-    aarch64_aa32_a57_init(cpu, false);
-    aa32_max_features(cpu);
-#ifdef CONFIG_USER_ONLY
-    /*
-     * Break with true ARMv8 and add back old-style VFP short-vector
-     * support. Only do this for user-mode, where -cpu max is the default,
-     * so that older v6 and v7 programs are more likely to work without
-     * adjustment.
-     */
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-#endif
-}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index cbfac0036e7..35e70b004d9 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -65,6 +65,7 @@ arm_common_user_system_ss.add(
   translate32_d,
   vfp_d,
   files(
+  'cpu-max-v8.c',
   'debug.c',
   'gengvec.c',
   'hflags.c',
-- 
2.43.0


