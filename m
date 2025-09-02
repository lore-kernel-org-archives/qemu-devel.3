Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B877CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1A-0001By-9w; Mon, 01 Sep 2025 23:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI15-0000rl-F3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI11-0004aw-Bb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6ZU025232
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2EuEdj8F79slxsvOjG7MIab7Mib7Zom4mw6cgvP1UA0=; b=DQBdGlE9KV9hkCBV
 OQkRBOp3oQ88noMbflcmR8KS7GO0ZyAg/qGmHLg6pxwkt4sCH8Kvix/gXBxNlWPC
 DF27DfgMqQjR/IBvMPgQmz49uE+Umoje6RzObf4AwOZi0CuJ++PBltZv5fEMxwKT
 RJI7SZmCR8IR3KENJWKFgiFd6ydLinefcAnZAiqvvZ/iwGhlXPkj8AgBFxTaGG5i
 XHuvUO3tMVdeccRWIrbKlINSY1pXd1e9MHmQpbsRdnzre3vZLsbQbk4kViwX9q/H
 40IeX3IRUNW4Wprj8VBjpr+9UXK3VpwBoJdy0Izdc+ywBSZqhfm4LrV8O+0etjN5
 qaoNaQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxe9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-325ce108e45so4742888a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784939; x=1757389739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EuEdj8F79slxsvOjG7MIab7Mib7Zom4mw6cgvP1UA0=;
 b=pTn2HLa3Lzlqyt6aPNLUAYe6gCf52TDba/LNFoseRii2peqQQspKIxekM2NJ+lX4UV
 KauoIYOlaj0noDfN/evH0IWaSVDHWhWwo7JPici/BZJX7a5dfgFu4RneSqw8KXSR/AeQ
 D8qskeDTaZJjIX9Q5++mMT6ccUk5VEG+ob5tiwW3nlBuQXYKP481MAtYofLzMyHzSE/Y
 /31CZolufyXzh8CIK3GRO/QNcrmM1DfjIZaQzfHjfiHcMQ6cv47cOczJKWrxw/9RMW/P
 vF17aa7qFO/aqPPGADgtiLOnR/kWfjZuFOQgatsGsBh74fr6AtBVHi78SSEEcb3mqd8G
 0waQ==
X-Gm-Message-State: AOJu0Yw68dRxmycEDIkGeWhPJKc1H2pOAvEf3Ntkvx+bKmBlBnyIzLQO
 80A1Utgn7Yl8Afmpy0uPwPGCw7e4h7QPFTVpzQZE86Rq2JulOI6e2TBFEYtZAC+xwLqYXb0o02V
 jHDr7QwGm+HzomoiPchRoQY5RHkNEFTClYQfoxL9k+RKnDZNJ4Ro9wHtNLzMCSEr9fCtW
X-Gm-Gg: ASbGncusF8OrT/MmMfSct/TWsSao7qs7kTqZ6nuZ5cWGUZI7VxUGPB1e0EiJVr8c0pu
 3MJa3OTrYvgBAURjwtRsLMDrZBU2i3ojceYNO3hyGEcoyZ7JluN5Wwo6Oh3SbR6xu8Fhwt/tqoL
 XEobiQZKDumzHJoNYpQxHhXyqUlXTGEl5z2Mt3aJfdcDQofRH8k+/6b9XSUbVNFawh+74G+etfP
 dmqweFnZ1OF82H/+axGxXF6KG1Xl1mYHmf0qizcE8rxiNJq1s5YxbE06fW5D7I6+rUF6pVJPRvp
 FKMgALAVTVqhYEPQkEMR3QU5ehLERoITdHrjxhnb2jb9xCrSfhHsQ/mSwaCcb9+n/8b7BscjFWW
 ABIoxdlYXfIRc
X-Received: by 2002:a17:90b:528f:b0:325:833e:98f0 with SMTP id
 98e67ed59e1d1-3280d2d9e79mr15374513a91.7.1756784938684; 
 Mon, 01 Sep 2025 20:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVvL42Iye1xOQhztrsWloU0NJ0PGGSqdDPALE6Np4X4Yhrk4fWix/qIiWP4tsW68GnN5j+Tg==
X-Received: by 2002:a17:90b:528f:b0:325:833e:98f0 with SMTP id
 98e67ed59e1d1-3280d2d9e79mr15374479a91.7.1756784938178; 
 Mon, 01 Sep 2025 20:48:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 05/39] target/hexagon: Implement modify SSR
Date: Mon,  1 Sep 2025 20:48:13 -0700
Message-Id: <20250902034847.1948010-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX2QwSMr1i0ps/
 lklj1sE7SxlnmF/tqFTsWI7D1xpHbtvwacjJt+fcZNKxZZ5FOZ5Nz97kO/o4tUM8yQUnUQFuSo7
 +tFCgQvWZ1P/QxZsVvhyAEm4HAgWhqwj6lzZ1wuUOCqqHD5V+oNHl3aoaYEUKUaz5+/PW8FuHdV
 U7IiDpL8y6WdgokrPpjhVPXd3S9Bjd5GoSMjjIMIrGPCy/n2xMg6JGccTxFa4gomeiTShn+MI//
 U6EVqdmSIW3pH3utknqGVoxZ9sudjchwvaoLQvGOdc8O6Lo0G7tC+K7KTqUwJaKLqDQdveKjq3W
 5v7nyxatY/97Yj2xJoiDjzJresVMVfS4hr7MB2kw+5G0S3I0rADYGm0DpSVJ1SAMHLtY8fWmefR
 bQ6tzNkD
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6692c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=pGsuWRCw0nJDj9UV2E4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ENdshJDeK67V-v2yQClH1bvCpH_e3xTl
X-Proofpoint-GUID: ENdshJDeK67V-v2yQClH1bvCpH_e3xTl
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

From: Brian Cain <bcain@quicinc.com>

The per-vCPU System Status Register controls many modal behaviors of the
system architecture.  When the SSR is updated, we trigger the necessary
effects for interrupts, privilege/MMU, and HVX context mapping.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 74ce59adf4..11a9dff522 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -14,6 +14,9 @@
 #else
 #include "hw/boards.h"
 #include "hw/hexagon/hexagon.h"
+#include "hw/hexagon/hexagon_globalreg.h"
+#include "hex_interrupts.h"
+#include "hex_mmu.h"
 #endif
 #include "exec/cpu-interrupt.h"
 #include "exec/target_page.h"
@@ -73,7 +76,35 @@ void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
 
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
 {
-    g_assert_not_reached();
+    g_assert(bql_locked());
+
+    bool old_EX = GET_SSR_FIELD(SSR_EX, old);
+    bool old_UM = GET_SSR_FIELD(SSR_UM, old);
+    bool old_GM = GET_SSR_FIELD(SSR_GM, old);
+    bool old_IE = GET_SSR_FIELD(SSR_IE, old);
+    bool new_EX = GET_SSR_FIELD(SSR_EX, new);
+    bool new_UM = GET_SSR_FIELD(SSR_UM, new);
+    bool new_GM = GET_SSR_FIELD(SSR_GM, new);
+    bool new_IE = GET_SSR_FIELD(SSR_IE, new);
+
+    if ((old_EX != new_EX) ||
+        (old_UM != new_UM) ||
+        (old_GM != new_GM)) {
+        hex_mmu_mode_change(env);
+    }
+
+    uint8_t old_asid = GET_SSR_FIELD(SSR_ASID, old);
+    uint8_t new_asid = GET_SSR_FIELD(SSR_ASID, new);
+    if (new_asid != old_asid) {
+        CPUState *cs = env_cpu(env);
+        tlb_flush(cs);
+    }
+
+    /* See if the interrupts have been enabled or we have exited EX mode */
+    if ((new_IE && !old_IE) ||
+        (!new_EX && old_EX)) {
+        hex_interrupt_update(env);
+    }
 }
 
 void clear_wait_mode(CPUHexagonState *env)
-- 
2.34.1


