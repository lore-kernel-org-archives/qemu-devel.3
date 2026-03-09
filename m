Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACC0F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbux-00013X-6l; Mon, 09 Mar 2026 10:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuV-0000qd-Lm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuT-0005Et-RW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EIpW2890710
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qkZ333qjKtqC1dNBPSEnSugI3JoDesMkwlzE3dO1PbA=; b=YNfVjgxmnaO5KzZX
 GUuJ71iwWekP1w4wo87Qh8+Y3xUDBtIfBX7MhQXLFdloxP/8aS8YPUtO7lFoBlmS
 oB1i1zptMbxS5bs04mvFUmkLU32RvLabsiOoBNRABOatCarvTwcr+AM+3InbJg8V
 EQ0D0c82OisORzsnlSMMU3e1sygmT9eXHRaCYVxuaTuGATOeBM8ShYHXHGBr/mdx
 6zOWSUG/tBbvAAYTLpRMx/+h3S1voAIhMjGLdgKctj4khGuJASZWO/3JotykdFKV
 lUp9vYJsdTS1OvyFgjYpLfb7twl91H7O20B+pKEiwVi3jwNMrVYUaMaMiptAXwro
 jLbU1w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv183tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdff07d8f4so12962007eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067720; x=1773672520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkZ333qjKtqC1dNBPSEnSugI3JoDesMkwlzE3dO1PbA=;
 b=YluiRsuRFxr6+ajuRoMPVFG/Iq45I1MUEwmJnVHc9W3LMmc5XKYX8KF5rvn4GTI0cO
 PFVBE8KF0b1qfporh8DpAX3fF5bTeWtjO0M51thHyUQmF4r5x8GqXJoh/xNxkzNN6p7Y
 ubMY9vf24TLtrKlZJFstb8ZchZGIHLPvIM0zSKzRVBgIzuMsaJaz7vIUXYAkPIm3DWTt
 UGWPClKMy30kSL/dMgsepZN1RTdWYh/AtVeXN4y+Zbx86B6Fr4d66a/0GjxfxjYXcd8B
 GSjy+kRuWTzo6LmS1mmFX1gbhYvCZp31kdKFZZXwLfB+E4n85otXXDoqKZaSRjshRElf
 6HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067720; x=1773672520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qkZ333qjKtqC1dNBPSEnSugI3JoDesMkwlzE3dO1PbA=;
 b=JVq25FhG61VSLRzijOlukD69Bnz9mOkAsXbpzH46Ut9Iwq0o6nk5BZ8QhUX1PYwEjt
 kCdXpdg+FEkp3CdJ3gQYPP1ZTxMU1tJ3nppDnN5oDnlfNMyHDPtn9M4XhRvceYxiRQ82
 X9TMjrkFWkKT988SWzztpY9qnNKZVSDALezyfR0f2nAgrwUWazt7dEXW+zklf1FXiUJ0
 8CB7XqRdigdLWxeItP65H2/dV8v5rr0ISD3y8oYtnHK3GMq+FaKxKsUzCwXPJhYdJjOe
 2ZCPKKwQYR9KwW0hqT+D/zMj6yCO2D/fMjuOJ0YghA8ic6pRXeCF9EcgILUIG4OiqB1L
 PD4w==
X-Gm-Message-State: AOJu0YwdleIm6x6ubAisBMwYyZrklL92H48T4PxFG+LI/iBUhhsd5beG
 5RMDoM2tkUugX8tSpzVk5Jqupo45brb4JPRS3biucl71/nLlCQsuvMHsNK6tSsBt4GVBT0l9CsR
 C7h4zjqrpLPnGh5LKewT1hs+IwgVhn9mMPQoC1atSNT6UuAtCS7X44znu6joySS78Jg==
X-Gm-Gg: ATEYQzw+35+3Xy7HfBGDcPrgJuVXNmolOYtb5cSFvOB0QVYzQDs5FQ2XP0Y0LCWiTs2
 urAwzQGzyhsRjaQRksksWoG16PpJ10Jt//5sElxtrgKCdwFuAYRl9DAbnliwsH3PVJCmwcINixn
 YEYDMPooxOcsyXh9TJ7K4pqzyIzCAguWBEbpRkypWdtXnGa1aRAd4vff4rY2xbmXqvzwdLrVcSH
 dG5g+GU0zERSyE5vxYH+Y4S5BglGwadnxbWy0DgIYCoxU81w4r7imkM46sr5I1P52YLxWDussEc
 +R93ZNtzARe6E2cIhoYdNPZvgLZXErn3GjTr7K+SO9KbvV4oY2Z6K7XfFfHgGlg8r/PJlkSiEa3
 wEQR8Anh+6Jlujjbqs4Lgu6yDlcW5g/7GcoqUHvLai9yNiu/PLV2ah2iFjOklQgVw6Zxwow==
X-Received: by 2002:a05:7300:2156:b0:2b7:da62:a5f9 with SMTP id
 5a478bee46e88-2be4e08f9f8mr4345424eec.18.1773067719444; 
 Mon, 09 Mar 2026 07:48:39 -0700 (PDT)
X-Received: by 2002:a05:7300:2156:b0:2b7:da62:a5f9 with SMTP id
 5a478bee46e88-2be4e08f9f8mr4345393eec.18.1773067718869; 
 Mon, 09 Mar 2026 07:48:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 11/35] target/hexagon: Add guest, system reg number defs
Date: Mon,  9 Mar 2026 07:47:58 -0700
Message-Id: <20260309144822.877695-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7jpsVQZUf9erQu8y1IzN0tRm9WGfwbgP
X-Proofpoint-ORIG-GUID: 7jpsVQZUf9erQu8y1IzN0tRm9WGfwbgP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX3iSv0JS/JH3Z
 m3FBDir0O/R8EA5f1+A8ViyKHyPPjgOaWtS/9vilf5d4ut4xuAwtuyIUEXxsEeIbW67HPEyL9IJ
 MTWvsRbPlbpoByRf3ML1TKAbm+n6J+IjMrcz/hceRjBwc017Zmv0kDhwhc7R/k+7Tq/X6GPKWjh
 IgILhEgok2kDBH4/eGI4JdByyfPxQFmg9hwvQqx7m9hHxgAD9f3vACfS44qPPzK9CpUD66eDDbH
 6DDnaoh2vAv6qb5gZ31jWTpiNj6HUX/iR5yg5vHbksXmEWh1roWDlJXRJvgi7fSTtz0n2D1UwSb
 1knuhtdb/JTGffToHnr1eFg4xs65ZiN0T2nekYnZpaTXfZhXBC7f6oPyQhaNskkS1Q9gDVizupf
 QfuFFhNazonkQlbwt4hM/USHi23UOwgqsZxCPBO3c40UlDtU/lHFUOW5LPpY9v+Bemwr7qA2g9M
 heYTMg0u0HaHlcm3hSw==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69aeddc8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pUoahe-fvFp-T0RBf7EA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h      |   7 +++
 target/hexagon/hex_regs.h | 117 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 937194e460e..3825de43ee7 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -20,6 +20,13 @@
 
 #include "fpu/softfloat-types.h"
 
+#ifndef CONFIG_USER_ONLY
+#define NUM_GREGS 32
+#define GREG_WRITES_MAX 2
+#define NUM_SREGS 64
+#define SREG_WRITES_MAX 2
+#endif
+
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
diff --git a/target/hexagon/hex_regs.h b/target/hexagon/hex_regs.h
index bddfc28021c..214b7b8fde8 100644
--- a/target/hexagon/hex_regs.h
+++ b/target/hexagon/hex_regs.h
@@ -81,4 +81,121 @@ enum {
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
+#ifndef CONFIG_USER_ONLY
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
+#endif /* !CONFIG_USER_ONLY */
+
 #endif
-- 
2.34.1


