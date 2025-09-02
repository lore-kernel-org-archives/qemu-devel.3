Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2273CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2t-0007j7-LD; Mon, 01 Sep 2025 23:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2N-0006b7-Ur
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2L-0004wC-2S
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9g6030176
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mAFIrWMBruvfJHq4yaW9qvutFMaGoHhoHMNbAZc19cw=; b=OiL/GRH5/ex7eY/R
 EBrGoTQrjmyMW7aY3L0eQAfr6Auq6InY3+rd2Web2rugw1o9WpcRsifnQSW0REXG
 GksQIOTTJEuPsSOwk1kYcVEEWSOP5cY25sWogRCIjesxGNh/UZ4WxmLzfw9fiJI3
 yjR4tz2VvjAN5at/GFe+/EW4GNXUucWXZiDQCn6UgP7PURYinCYZsieLvWw232hp
 NsqKHZda/+xjEPrzEvV983aK2elllJ8CaaS8DU1Qk1AI5mchi4b1QB3q64+MCUgy
 DfalgtTY+puwAmi2TZ6mVQsFWUmXKE7zJ7kEzRUGYKBUwIBs1fCbscayd1k4T4rV
 qoa+LQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3234811cab3so6085975a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785005; x=1757389805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAFIrWMBruvfJHq4yaW9qvutFMaGoHhoHMNbAZc19cw=;
 b=k3k/AoyYgiBA3MVGh0/V9F0P62niHKf7Y8DIqfFa5MWsJIXZisovkyRvt0L2yZIADa
 4pgzId2KejyfbW3LtOCHE8kZA/OOV+xLy0nz+PrbHWda5L+ed/lYlLDQNsCXaltpC/so
 QEgjPuyoloztkhz6ysnQJkFyxkvmxzJ48yPHlCzQxrXv70VnHm0CkYnFWVvvDW6k2ioT
 UrPBpjdI2TmZuDmm0oiG2Gd4RWkj5Omyqnp8CaOuBu7m088qvok4JlHAIx3WnOsRfZ/7
 59kJY0i8FCqSuscKIpJTRD8gWEJoMOjOKyPkfZayjU3Sm+pCv1Kym+AAIXCq+l+FK+nB
 H+Yg==
X-Gm-Message-State: AOJu0Yxf3Oeca1lyfBMOeVA8y2lhFc7Q4tTmevpJTZmp1D08Ty821U0/
 sqf8eKBAs8P4u0aech9uYctYvaeTIidkFm2O1XurhS356fzjk9qGjRSBJyr652Hh8hc7jKao/Ob
 5e0/sOfD4mPlyqivAvY/I6GxSiWQ64aGfQFgJXRv6PDJYmvjXdhVTTOR/Kc6kASnzECBO
X-Gm-Gg: ASbGncsEGDfMPQ5Ad7H49AO3i4uc0vyMnxBfOLAZgInFZeNsldfRQkLbUBg4LG/1qyw
 koSPxlCt/wS5KqWOe05H5HDSa1b9Ky+oyYLyVHjgjF6SjHBnf6v93svVTWa6Zzn0sseqHsKQrvi
 oQ0E9V5jUkvzWNykyxxC9xhkml2tWIraZtfnNo6RyjMaffqL6dqR4L09B/NpruYzCYKl83LJB51
 uJTPaYzfD4P0zoUaGGnmtvLPQm+4iZkTesCGTt0XE3qrYWNdy88iKx5BwRGDm0wppamAxF8fmLf
 Y/sutK4A2cnXJ41YhsE0IIvgEkadLNYqoc/0dSb2XjclPRbpkP4c54eq2ZrebDGTLdOGwWwdlPe
 V5bmhCE3JmBvZ
X-Received: by 2002:a17:90b:510b:b0:324:e682:f313 with SMTP id
 98e67ed59e1d1-328156b7cf9mr13741955a91.18.1756785004667; 
 Mon, 01 Sep 2025 20:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB+Xsscm8/QIrh1rTka8uCRvr6PmqKJta9CgVia5Qpbu0BRO5cycPvn3TIZ0VdHkeWCF4loQ==
X-Received: by 2002:a17:90b:510b:b0:324:e682:f313 with SMTP id
 98e67ed59e1d1-328156b7cf9mr13741932a91.18.1756785004139; 
 Mon, 01 Sep 2025 20:50:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 02/11] hw/hexagon: Add global register tracing
Date: Mon,  1 Sep 2025 20:49:42 -0700
Message-Id: <20250902034951.1948194-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b66976 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=w7TcP5jS4fsjDEBSHpAA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: DCZJ38LlGq-VEx7eXpLBbf8mGuqOdp_F
X-Proofpoint-ORIG-GUID: DCZJ38LlGq-VEx7eXpLBbf8mGuqOdp_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX55DsRUpG94hy
 3z4CUZco+9nRSFxKbPtSO2/53I2Z/SBuxAJe6wkWhEpBVi1rsBj37HhEOpLkmusXts7XdsRiB7T
 PqyaAGuMHHFdg1WtVKbxCoqosMJB5e17IJ1hC2yx6mFOcZDwFnmKcIqTbHxJGFpSeNW4NIzZj5d
 6IWIInG1QAU/UpglN8n36sBafb/RzDC/LyZgprdGzu/rSIb8YBef8e0rWA2yQJdZioWOHftrQ66
 +qFIJDMmEEdG759fISmXVpqaeGvS6dlqFqbcvyzHVBS+mv9kvO6PJUYte1PvCVIFTI9QbC9Qn/7
 SrzFOcdmis5Qn11PqHNbZMk2DRvIb5DKuZgoPaPSunIjVWFe+UzAKDWMlixdtly8I6XnPDTFI00
 PwNtouq0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 meson.build                    |  1 +
 hw/hexagon/hexagon_globalreg.c | 73 ++++++++++++++++++++++++++++++++++
 hw/hexagon/trace-events        |  3 ++
 3 files changed, 77 insertions(+)
 create mode 100644 hw/hexagon/trace-events

diff --git a/meson.build b/meson.build
index 0d42de61ae..d7e6149ab5 100644
--- a/meson.build
+++ b/meson.build
@@ -3669,6 +3669,7 @@ if have_system
     'hw/display',
     'hw/dma',
     'hw/fsi',
+    'hw/hexagon',
     'hw/hyperv',
     'hw/i2c',
     'hw/i386',
diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
index da943f7261..fcbf2ae4b2 100644
--- a/hw/hexagon/hexagon_globalreg.c
+++ b/hw/hexagon/hexagon_globalreg.c
@@ -16,11 +16,82 @@
 #include "target/hexagon/cpu.h"
 #include "target/hexagon/hex_regs.h"
 #include "qemu/log.h"
+#include "trace/trace-hw_hexagon.h"
 #include "qapi/error.h"
 
 #define IMMUTABLE (~0)
 #define INVALID_REG_VAL 0xdeadbeef
 
+static const char *hex_sreg_names[] = {
+    [HEX_SREG_SGP0] = "sgp0",
+    [HEX_SREG_SGP1] = "sgp1",
+    [HEX_SREG_STID] = "stid",
+    [HEX_SREG_ELR] = "elr",
+    [HEX_SREG_BADVA0] = "badva0",
+    [HEX_SREG_BADVA1] = "badva1",
+    [HEX_SREG_SSR] = "ssr",
+    [HEX_SREG_CCR] = "ccr",
+    [HEX_SREG_HTID] = "htid",
+    [HEX_SREG_BADVA] = "badva",
+    [HEX_SREG_IMASK] = "imask",
+    [HEX_SREG_GEVB] = "gevb",
+    [HEX_SREG_EVB] = "evb",
+    [HEX_SREG_MODECTL] = "modectl",
+    [HEX_SREG_SYSCFG] = "syscfg",
+    [HEX_SREG_IPENDAD] = "ipendad",
+    [HEX_SREG_VID] = "vid",
+    [HEX_SREG_VID1] = "vid1",
+    [HEX_SREG_BESTWAIT] = "bestwait",
+    [HEX_SREG_IEL] = "iel",
+    [HEX_SREG_SCHEDCFG] = "schedcfg",
+    [HEX_SREG_IAHL] = "iahl",
+    [HEX_SREG_CFGBASE] = "cfgbase",
+    [HEX_SREG_DIAG] = "diag",
+    [HEX_SREG_REV] = "rev",
+    [HEX_SREG_PCYCLELO] = "pcyclelo",
+    [HEX_SREG_PCYCLEHI] = "pcyclehi",
+    [HEX_SREG_ISDBST] = "isdbst",
+    [HEX_SREG_ISDBCFG0] = "isdbcfg0",
+    [HEX_SREG_ISDBCFG1] = "isdbcfg1",
+    [HEX_SREG_LIVELOCK] = "livelock",
+    [HEX_SREG_BRKPTPC0] = "brkptpc0",
+    [HEX_SREG_BRKPTCFG0] = "brkptcfg0",
+    [HEX_SREG_BRKPTPC1] = "brkptpc1",
+    [HEX_SREG_BRKPTCFG1] = "brkptcfg1",
+    [HEX_SREG_ISDBMBXIN] = "isdbmbxin",
+    [HEX_SREG_ISDBMBXOUT] = "isdbmbxout",
+    [HEX_SREG_ISDBEN] = "isdben",
+    [HEX_SREG_ISDBGPR] = "isdbgpr",
+    [HEX_SREG_PMUCNT4] = "pmucnt4",
+    [HEX_SREG_PMUCNT5] = "pmucnt5",
+    [HEX_SREG_PMUCNT6] = "pmucnt6",
+    [HEX_SREG_PMUCNT7] = "pmucnt7",
+    [HEX_SREG_PMUCNT0] = "pmucnt0",
+    [HEX_SREG_PMUCNT1] = "pmucnt1",
+    [HEX_SREG_PMUCNT2] = "pmucnt2",
+    [HEX_SREG_PMUCNT3] = "pmucnt3",
+    [HEX_SREG_PMUEVTCFG] = "pmuevtcfg",
+    [HEX_SREG_PMUSTID0] = "pmustid0",
+    [HEX_SREG_PMUEVTCFG1] = "pmuevtcfg1",
+    [HEX_SREG_PMUSTID1] = "pmustid1",
+    [HEX_SREG_TIMERLO] = "timerlo",
+    [HEX_SREG_TIMERHI] = "timerhi",
+    [HEX_SREG_PMUCFG] = "pmucfg",
+    [HEX_SREG_S59] = "s59",
+    [HEX_SREG_S60] = "s60",
+    [HEX_SREG_S61] = "s61",
+    [HEX_SREG_S62] = "s62",
+    [HEX_SREG_S63] = "s63",
+};
+
+static const char *get_sreg_name(uint32_t reg)
+{
+    if (reg < ARRAY_SIZE(hex_sreg_names) && hex_sreg_names[reg]) {
+        return hex_sreg_names[reg];
+    }
+    return "UNKNOWN";
+}
+
 /* Global system register mutability masks */
 static const uint32_t global_sreg_immut_masks[NUM_SREGS] = {
     [HEX_SREG_EVB] = 0x000000ff,
@@ -88,6 +159,7 @@ uint32_t hexagon_globalreg_read(HexagonCPU *cpu, uint32_t reg)
         value = s->regs[reg];
     }
 
+    trace_hexagon_globalreg_read(get_sreg_name(reg), value);
     return value;
 }
 
@@ -99,6 +171,7 @@ void hexagon_globalreg_write(HexagonCPU *cpu, uint32_t reg,
     g_assert(reg < NUM_SREGS);
     g_assert(reg >= HEX_SREG_GLB_START);
     s->regs[reg] = value;
+    trace_hexagon_globalreg_write(get_sreg_name(reg), value);
 }
 
 uint32_t hexagon_globalreg_masked_value(HexagonCPU *cpu, uint32_t reg,
diff --git a/hw/hexagon/trace-events b/hw/hexagon/trace-events
new file mode 100644
index 0000000000..6ef88d9e05
--- /dev/null
+++ b/hw/hexagon/trace-events
@@ -0,0 +1,3 @@
+# Hexagon global register access
+hexagon_globalreg_read(const char *reg_name, uint32_t value) "reg=%s value=0x%x"
+hexagon_globalreg_write(const char *reg_name, uint32_t value) "reg=%s value=0x%x"
-- 
2.34.1


