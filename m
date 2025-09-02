Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545E8CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzk-0006kN-VP; Mon, 01 Sep 2025 23:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzi-0006hP-1w
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzg-0004SA-1g
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RoK5024999
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NgT1akKKFF6K3333BvEEjXOLGfnXf+7r3v3gx1JzEgk=; b=YUYwgjajRDxbZ7Wg
 V3HiGVoqJhqpFbnhSntioQmi3CmlLNuaoVJk0P/BGFNwylljlVpDem7XFkyDlN+5
 KkaXmgpaSaeVciFdyn+s9rJh+AelKNU8oiQnpk62Nz8kzo9m/q8Xrjouj+KfT5jW
 /tGyblfTk5GX3/NtB+Kleq2NX5M/fh+MvThF/KH4qIRNrZsHD/MlOWF/twgwcHF0
 bwmNf97Z1JdrEU9nSRaTXqfuonMJL3zuNeH5m4VGS0jmRwZb2IY9LUg7izCyHtKd
 dhOl0hcUdPV9OV05XM+6a+EiTlbt8VURDbkFaZ9HegtVLj1W2/K4+pMrAPFp4+hH
 VBhrRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxe6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3251961140bso4412294a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784857; x=1757389657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgT1akKKFF6K3333BvEEjXOLGfnXf+7r3v3gx1JzEgk=;
 b=GlCakWVRkVH9wNRYrtbOZJ8WgiX3RgaqJWYITCB92Oww7PeQ4GIjVJr1P7aOyyv14Q
 I/GhUl/wgt1rgocBDt1BedLiY1otjBUIqymvNRPuCLq+Jdh8cqbM6NUuCmAa94wzrQv2
 cBP4+X6xONOaQVWRfaEXGj9VVApyVOYWmEWka6VM4dpUe/qq9zR3C4uh4qkuZJfFhVjy
 z8U+eoxIbvp86aEUvKbDfkP45utjIVbaNGNRvpUI2M+ET/EcwRD6hhlz27YpAmMFnevh
 gb55k+KUuP0axfMgNSV/u7wIJzUK+iO5TXPF/L1QNCzk63HG+f8Qq0TcmRkvSBlHn3ps
 +Azw==
X-Gm-Message-State: AOJu0YzT0npv2eEbpoylMgic4Ms5ZOredWlg/l738f6iR2kIU0m9qvoG
 d54SNRKOpMjhd1ctk5nWdR3ddQRK88z+PvksRY+UktI56/TbfSHbhwsozm4OcrpW+i4CgrVQf/H
 XOoyQV7nyVzjqDvvYKyIle8wq8NDNvT5aMg/iWp5ZnzCAYy5ejrLc3a6YhpEgkuPujzec
X-Gm-Gg: ASbGnctkIQfU/yInXDmvH5tz3fcz11/dcbp4usz9/g4IgH+Tz/YqCZNRi/RhkRL0mfp
 lIjowxPE4Fcbi4a9YtCJm5UjzOEMbhgXvhCwTobI79cLbi4Rv/uorhbyfhcI7Ob1UxcHFGpzEdS
 SrWCm6jXvHp6l/MIkVgEP4bZRDy1bozQiUoRaChb6OVvJqFUfALd/J/rE7UEZDNLNEUjtrgQKTN
 nuRNaUWTI+u4ysyEHPkC9jw8Bozq/qYj3t3FTPo5jwkpVWDe1B8mA1u4lsAx1vGj6iukJCpvOHH
 df6VIgAZsABm00cOkzCRyRq2gPyJspu4z92559rAqOQjll0SNyIPL+2go6LBA/xw5QpHr3izZLI
 XQJ2j0eDDhwr6
X-Received: by 2002:a17:90b:35c6:b0:321:b7ed:75f2 with SMTP id
 98e67ed59e1d1-328156e0537mr12148147a91.32.1756784857359; 
 Mon, 01 Sep 2025 20:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoAGOq7fGJAr1dI/6CBCVCxMYqMROUINJreui/ZZUnyH+u5rByOouYZvPbL+LjNMy2HP+H2Q==
X-Received: by 2002:a17:90b:35c6:b0:321:b7ed:75f2 with SMTP id
 98e67ed59e1d1-328156e0537mr12148115a91.32.1756784856806; 
 Mon, 01 Sep 2025 20:47:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 12/40] target/hexagon: Add guest, system reg number defs
Date: Mon,  1 Sep 2025 20:46:47 -0700
Message-Id: <20250902034715.1947718-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX8sh9RjdlGGrw
 4NB0Ei3skc4JuXIiqYLITpd02Mh+xXtjs1SgSnAw16VPFovQbC35BOm41o+lnmxPoDHktRxT6k/
 QG6lHDTVD/Lnd1VB/i/qkqTy1VTVfhTYZ+phCnBvJWR8tA8QJtV7fR0kVNau6JuKzitP0s6PzAM
 Fg7p0AS2E/skxinL9Y5Ts4n/DYF8pnajigdMxYRFxvVTdnbJL72gEA4ntGGR9Cm3lsjkvcrqpAT
 VTd26mb7tWYJsW4Xo8nIylaBFAVPm69P/Fud2gm2ZEIuHlVAhQu+VjRacXMgusUpAU3Aqs9mup0
 JI6IusM32qE0f8V6YwPAa8nhFe11CxYGRrqCFsZGq79o65HkXsyfRAJtLZ372oxNJ+dmxv3xBLe
 HmbMhHj6
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b668da cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=tCkOjFGBvLAhDY2OQcYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: obGlOoIVrfM2B52oA8D8XFgyQCMND9pB
X-Proofpoint-GUID: obGlOoIVrfM2B52oA8D8XFgyQCMND9pB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h      |   5 ++
 target/hexagon/hex_regs.h | 115 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index df1f2b569c..46e0dc9d0b 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -20,6 +20,11 @@
 
 #include "fpu/softfloat-types.h"
 
+#define NUM_GREGS 32
+#define GREG_WRITES_MAX 2
+#define NUM_SREGS 64
+#define SREG_WRITES_MAX 2
+
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
diff --git a/target/hexagon/hex_regs.h b/target/hexagon/hex_regs.h
index bddfc28021..ea8c62eba9 100644
--- a/target/hexagon/hex_regs.h
+++ b/target/hexagon/hex_regs.h
@@ -81,4 +81,119 @@ enum {
     HEX_REG_UTIMERHI          = 63,
 };
 
+#ifndef CONFIG_USER_ONLY
+
+#define HEX_GREG_VALUES \
+  DECL_HEX_GREG(G0,         0) \
+  DECL_HEX_GREG(GELR,       0) \
+  DECL_HEX_GREG(G1,         1) \
+  DECL_HEX_GREG(GSR,        1) \
+  DECL_HEX_GREG(G2,         2) \
+  DECL_HEX_GREG(GOSP,       2) \
+  DECL_HEX_GREG(G3,         3) \
+  DECL_HEX_GREG(GBADVA,     3) \
+  DECL_HEX_GREG(GCYCLE_1T,  10) \
+  DECL_HEX_GREG(GCYCLE_2T,  11) \
+  DECL_HEX_GREG(GCYCLE_3T,  12) \
+  DECL_HEX_GREG(GCYCLE_4T,  13) \
+  DECL_HEX_GREG(GCYCLE_5T,  14) \
+  DECL_HEX_GREG(GCYCLE_6T,  15) \
+  DECL_HEX_GREG(GPMUCNT4,   16) \
+  DECL_HEX_GREG(GPMUCNT5,   17) \
+  DECL_HEX_GREG(GPMUCNT6,   18) \
+  DECL_HEX_GREG(GPMUCNT7,   19) \
+  DECL_HEX_GREG(GPCYCLELO,  24) \
+  DECL_HEX_GREG(GPCYCLEHI,  25) \
+  DECL_HEX_GREG(GPMUCNT0,   26) \
+  DECL_HEX_GREG(GPMUCNT1,   27) \
+  DECL_HEX_GREG(GPMUCNT2,   28) \
+  DECL_HEX_GREG(GPMUCNT3,   29) \
+  DECL_HEX_GREG_DONE
+
+#define DECL_HEX_GREG_DONE
+#define DECL_HEX_GREG(name, val) HEX_GREG_ ##name = val,
+enum hex_greg {
+    HEX_GREG_VALUES
+};
+#undef DECL_HEX_GREG
+#undef DECL_HEX_GREG_DONE
+
+#define DECL_HEX_GREG_DONE 0
+#define DECL_HEX_GREG(_, val) (1 << val) |
+static inline bool greg_implemented(enum hex_greg greg)
+{
+#if NUM_GREGS > 32
+#error "NUM_GREGS too large for greg_implemented(): update `impl_bitmap`"
+#endif
+    static int32_t impl_bitmap = HEX_GREG_VALUES;
+    return impl_bitmap & (1 << greg);
+}
+#undef DECL_HEX_GREG
+#undef DECL_HEX_GREG_DONE
+
+#endif /* CONFIG_USER_ONLY */
+
+enum {
+    HEX_SREG_SGP0 = 0,
+    HEX_SREG_SGP1 = 1,
+    HEX_SREG_STID = 2,
+    HEX_SREG_ELR = 3,
+    HEX_SREG_BADVA0 = 4,
+    HEX_SREG_BADVA1 = 5,
+    HEX_SREG_SSR = 6,
+    HEX_SREG_CCR = 7,
+    HEX_SREG_HTID = 8,
+    HEX_SREG_BADVA = 9,
+    HEX_SREG_IMASK = 10,
+    HEX_SREG_GEVB  = 11,
+    HEX_SREG_GLB_START = 16,
+    HEX_SREG_EVB = 16,
+    HEX_SREG_MODECTL = 17,
+    HEX_SREG_SYSCFG = 18,
+    HEX_SREG_IPENDAD = 20,
+    HEX_SREG_VID = 21,
+    HEX_SREG_VID1 = 22,
+    HEX_SREG_BESTWAIT = 23,
+    HEX_SREG_IEL = 24,
+    HEX_SREG_SCHEDCFG = 25,
+    HEX_SREG_IAHL = 26,
+    HEX_SREG_CFGBASE = 27,
+    HEX_SREG_DIAG = 28,
+    HEX_SREG_REV = 29,
+    HEX_SREG_PCYCLELO = 30,
+    HEX_SREG_PCYCLEHI = 31,
+    HEX_SREG_ISDBST = 32,
+    HEX_SREG_ISDBCFG0 = 33,
+    HEX_SREG_ISDBCFG1 = 34,
+    HEX_SREG_LIVELOCK = 35,
+    HEX_SREG_BRKPTPC0 = 36,
+    HEX_SREG_BRKPTCFG0 = 37,
+    HEX_SREG_BRKPTPC1 = 38,
+    HEX_SREG_BRKPTCFG1 = 39,
+    HEX_SREG_ISDBMBXIN = 40,
+    HEX_SREG_ISDBMBXOUT = 41,
+    HEX_SREG_ISDBEN = 42,
+    HEX_SREG_ISDBGPR = 43,
+    HEX_SREG_PMUCNT4 = 44,
+    HEX_SREG_PMUCNT5 = 45,
+    HEX_SREG_PMUCNT6 = 46,
+    HEX_SREG_PMUCNT7 = 47,
+    HEX_SREG_PMUCNT0 = 48,
+    HEX_SREG_PMUCNT1 = 49,
+    HEX_SREG_PMUCNT2 = 50,
+    HEX_SREG_PMUCNT3 = 51,
+    HEX_SREG_PMUEVTCFG = 52,
+    HEX_SREG_PMUSTID0 = 53,
+    HEX_SREG_PMUEVTCFG1 = 54,
+    HEX_SREG_PMUSTID1 = 55,
+    HEX_SREG_TIMERLO = 56,
+    HEX_SREG_TIMERHI = 57,
+    HEX_SREG_PMUCFG = 58,
+    HEX_SREG_S59 = 59,
+    HEX_SREG_S60 = 60,
+    HEX_SREG_S61 = 61,
+    HEX_SREG_S62 = 62,
+    HEX_SREG_S63 = 63,
+};
+
 #endif
-- 
2.34.1


