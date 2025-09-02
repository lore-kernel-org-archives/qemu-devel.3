Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86186CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzo-0006oF-ON; Mon, 01 Sep 2025 23:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzg-0006gP-5F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzd-0004R5-47
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RnIY012501
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CHO6wFHKiSo32iJDvpWRaIYtidx0GOpJkxmoT7M+VFc=; b=Jj29Mri/vcF9B6be
 DOtSJBQVAqUf1UT9HXVp9aRghewRN2ZlHCD8u//lQAYXzVGtfer41KUKR6SwCL2g
 qgJYzmu+0ujpc8H9V/Tgl+Rix1u3zRLiDa+WzbPK6dvSx0Loir2SmxVvwLevRY24
 NEQpEJsb32PnW0x7011WPVEXcWV7zpK1SnWBAzE7pHWQXe2es+eOpvY//1oTIOL6
 hQbnhNNlCz1AGqgpbX5oEaUiGYADEKXrWrw6ix5lJOB2d3nv8qc/zsgk7+qTuzbp
 gJEmVM6l6XxtbLCSeWsioimMdw6jKCC9vflMgn0cvkPL6y3di+bAV9Go0V15kULw
 hRKg4A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b49da7c3ff6so2859619a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784852; x=1757389652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHO6wFHKiSo32iJDvpWRaIYtidx0GOpJkxmoT7M+VFc=;
 b=fNfGDJ/bpbPQbo/MLnDg2SQTFc/7roG0tLmgqwwfjbdP7xOA+OkzcM7a3TgbWYIezD
 Bts0hAVpD0iPVKIDJx/8jp/K0AlJbCwij1vI4LGWUx8vCpBQIUP6QRiVymNGO82M3dF7
 l9UUgl2vYe9hgog4+zHOeAaos02nlzJ6q6ReC4MBUEEKtpx9CsGewLDgzXYdVia99zyp
 Mp52tM8+v9rwt/Ty6EcSmf7sl6eigoDut7iyLwTYumc7DujgGKqqxuAx29OcmZZjZX/R
 PSpYKq8DiM7kmfe+MMIOoc1TaZSGSwn9MONxsjQMTmABmqRsq8B/TsLQC1oMRP6WZd/k
 /pBw==
X-Gm-Message-State: AOJu0YytQAILn5cAAtwfdzXQqIcrfTJLDpqWVYQjMwvsqrz7uCRIzOv0
 5AttOGm//rJ6cWQNEo3ZsS7AlsIZnXEYKG7yAVv9e/FVe+TDBJIzRyCs3+YY+PYnmmEEkgXHDSX
 jeTJuutIfF3RzZ3+5gwAHXs7lqE/l/4P/J50AuDnsEuF9xpaBDX/lJuYGVl1DKA7rdoP2
X-Gm-Gg: ASbGncsrlimcUdXhp289IzZ2c0Whvfc6cO8US9lr2mkPLGocq5bNnICeo/DOhxOLSPD
 FcnrdufDvC0GL2iclAzETI9++BfxAdvL6CfeRchzaBaksiRNMUt6sRoExqSbXiXp3kpqbYW0nDt
 r8eiJGkGWUn03M/fEnazsm25tg52OkBA9o2lfIxLHb1CD+vBuPMEYIgHHtmtp3Bxp0NV2Z+uAYP
 dd3V/hWZ6scpvyZjpt6XmkMzb8krPxHWeDcz0qopurKd9brI4uVi+YGEkxiLj4S1lUC9b5PeIhg
 N0KSjQnCmsAPUFZTTf8A9/NkEBGjVcINzObf7c2vyRtWnrJJIJGSJYhq3cG8ckcN+eMDk0mmBg3
 ZOqxO8ZbJ68kx
X-Received: by 2002:a05:6a21:33a8:b0:243:78a:8269 with SMTP id
 adf61e73a8af0-243d6f433c9mr12587113637.47.1756784852558; 
 Mon, 01 Sep 2025 20:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ3/6B+TEDpXlBKJak93tml1wZaC8osCiqiMedEzSC68m84yiMcMBozRC5awtIxedu95PIKQ==
X-Received: by 2002:a05:6a21:33a8:b0:243:78a:8269 with SMTP id
 adf61e73a8af0-243d6f433c9mr12587100637.47.1756784852140; 
 Mon, 01 Sep 2025 20:47:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 08/40] target/hexagon: Add system event, cause codes
Date: Mon,  1 Sep 2025 20:46:43 -0700
Message-Id: <20250902034715.1947718-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4nr1eF7nmNK-q0fj5JvnFQGnGFBqSarI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX4w0xlq0OVfw/
 6LEEgBjl9hhTtahXZO9UC75mgB2HWyREDPCRg8/NWX9FUT2UBztzydeZaA2EER86ss7pT8bYvgM
 pWzcm7dNzhChA6wEKt2vbT3TYeSCufFSYLkkRs4H4ZQH6Z3OZCaHC5fgpKv/aYJGLdVv2jC2nKe
 0IhA7mieEXNyqvfv0zSHl++PJjivtlPAZsJLH0NpP7lDaqr0pf5apMAiNe/tkilS72Ok1ZXDYHS
 FImPHTCq5L1JWrkxsPKjWZ9BXnfVCsHG3ZqG3WWk0sBTN61b+2KlL3J750yv6yDAtmpInz6zD6J
 mvdREkcrjJZtTtUBMENeIzklPkd9N9SKX3zVybTBQa07dWHuDNrM6zCJRGA8yPvaiSa9Ffc3sR+
 yp7P9KGm
X-Proofpoint-ORIG-GUID: 4nr1eF7nmNK-q0fj5JvnFQGnGFBqSarI
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b668d5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XVQBMALLqD4WjdKg770A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h      |  9 +++++
 target/hexagon/cpu_bits.h | 80 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 43a854f517..1fc4093176 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -44,6 +44,15 @@
 
 #define MMU_USER_IDX 0
 
+#define HEXAGON_CPU_IRQ_0 0
+#define HEXAGON_CPU_IRQ_1 1
+#define HEXAGON_CPU_IRQ_2 2
+#define HEXAGON_CPU_IRQ_3 3
+#define HEXAGON_CPU_IRQ_4 4
+#define HEXAGON_CPU_IRQ_5 5
+#define HEXAGON_CPU_IRQ_6 6
+#define HEXAGON_CPU_IRQ_7 7
+
 typedef struct {
     target_ulong va;
     uint8_t width;
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index ff596e2a94..b118761e05 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -24,19 +24,81 @@
 #define PCALIGN_MASK (PCALIGN - 1)
 
 enum hex_event {
-    HEX_EVENT_NONE           = -1,
-    HEX_EVENT_TRAP0          =  0x008,
+    HEX_EVENT_NONE = -1,
+    HEX_EVENT_RESET = 0x0,
+    HEX_EVENT_IMPRECISE = 0x1,
+    HEX_EVENT_PRECISE = 0x2,
+    HEX_EVENT_TLB_MISS_X = 0x4,
+    HEX_EVENT_TLB_MISS_RW = 0x6,
+    HEX_EVENT_TRAP0 = 0x8,
+    HEX_EVENT_TRAP1 = 0x9,
+    HEX_EVENT_FPTRAP = 0xb,
+    HEX_EVENT_DEBUG = 0xc,
+    HEX_EVENT_INT0 = 0x10,
+    HEX_EVENT_INT1 = 0x11,
+    HEX_EVENT_INT2 = 0x12,
+    HEX_EVENT_INT3 = 0x13,
+    HEX_EVENT_INT4 = 0x14,
+    HEX_EVENT_INT5 = 0x15,
+    HEX_EVENT_INT6 = 0x16,
+    HEX_EVENT_INT7 = 0x17,
+    HEX_EVENT_INT8 = 0x18,
+    HEX_EVENT_INT9 = 0x19,
+    HEX_EVENT_INTA = 0x1a,
+    HEX_EVENT_INTB = 0x1b,
+    HEX_EVENT_INTC = 0x1c,
+    HEX_EVENT_INTD = 0x1d,
+    HEX_EVENT_INTE = 0x1e,
+    HEX_EVENT_INTF = 0x1f,
 };
 
 enum hex_cause {
     HEX_CAUSE_NONE = -1,
-    HEX_CAUSE_TRAP0 = 0x172,
-    HEX_CAUSE_FETCH_NO_UPAGE =  0x012,
-    HEX_CAUSE_INVALID_PACKET =  0x015,
-    HEX_CAUSE_INVALID_OPCODE =  0x015,
-    HEX_CAUSE_PC_NOT_ALIGNED =  0x01e,
-    HEX_CAUSE_PRIV_NO_UREAD  =  0x024,
-    HEX_CAUSE_PRIV_NO_UWRITE =  0x025,
+    HEX_CAUSE_RESET = 0x000,
+    HEX_CAUSE_BIU_PRECISE = 0x001,
+    HEX_CAUSE_UNSUPORTED_HVX_64B = 0x002, /* QEMU-specific */
+    HEX_CAUSE_DOUBLE_EXCEPT = 0x003,
+    HEX_CAUSE_TRAP0 = 0x008,
+    HEX_CAUSE_TRAP1 = 0x009,
+    HEX_CAUSE_FETCH_NO_XPAGE = 0x011,
+    HEX_CAUSE_FETCH_NO_UPAGE = 0x012,
+    HEX_CAUSE_INVALID_PACKET = 0x015,
+    HEX_CAUSE_INVALID_OPCODE = 0x015,
+    HEX_CAUSE_NO_COPROC_ENABLE = 0x016,
+    HEX_CAUSE_NO_COPROC2_ENABLE = 0x018,
+    HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
+    HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
+    HEX_CAUSE_REG_WRITE_CONFLICT = 0x01d,
+    HEX_CAUSE_PC_NOT_ALIGNED = 0x01e,
+    HEX_CAUSE_MISALIGNED_LOAD = 0x020,
+    HEX_CAUSE_MISALIGNED_STORE = 0x021,
+    HEX_CAUSE_PRIV_NO_READ = 0x022,
+    HEX_CAUSE_PRIV_NO_WRITE = 0x023,
+    HEX_CAUSE_PRIV_NO_UREAD = 0x024,
+    HEX_CAUSE_PRIV_NO_UWRITE = 0x025,
+    HEX_CAUSE_COPROC_LDST = 0x026,
+    HEX_CAUSE_STACK_LIMIT = 0x027,
+    HEX_CAUSE_VWCTRL_WINDOW_MISS = 0x029,
+    HEX_CAUSE_IMPRECISE_NMI = 0x043,
+    HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH = 0x044,
+    HEX_CAUSE_TLBMISSX_CAUSE_NORMAL = 0x060,
+    HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE = 0x061,
+    HEX_CAUSE_TLBMISSRW_CAUSE_READ = 0x070,
+    HEX_CAUSE_TLBMISSRW_CAUSE_WRITE = 0x071,
+    HEX_CAUSE_DEBUG_SINGLESTEP = 0x80,
+    HEX_CAUSE_FPTRAP_CAUSE_BADFLOAT = 0x0bf,
+    HEX_CAUSE_INT0 = 0x0c0,
+    HEX_CAUSE_INT1 = 0x0c1,
+    HEX_CAUSE_INT2 = 0x0c2,
+    HEX_CAUSE_INT3 = 0x0c3,
+    HEX_CAUSE_INT4 = 0x0c4,
+    HEX_CAUSE_INT5 = 0x0c5,
+    HEX_CAUSE_INT6 = 0x0c6,
+    HEX_CAUSE_INT7 = 0x0c7,
+    HEX_CAUSE_VIC0 = 0x0c2,
+    HEX_CAUSE_VIC1 = 0x0c3,
+    HEX_CAUSE_VIC2 = 0x0c4,
+    HEX_CAUSE_VIC3 = 0x0c5,
 };
 
 #define PACKET_WORDS_MAX         4
-- 
2.34.1


