Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD88CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1F-0001Vw-CM; Mon, 01 Sep 2025 23:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1C-0001Kp-Le
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI18-0004cK-Fl
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkRi016546
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sBQQre50aOiB7vIhrSM03mlP7zl+XdQuOhi8uZVOGJY=; b=dB+wgAMYE3n7Zy8z
 C/dFQQ29XxF4PwUI7LtIfNlTp27r2Csv8qS3jBJ+uz3UQk3a3eQE5zmhsvAH4vNw
 BF6Dd/ZVdk6O2c9H2DL+KUBchkMAIzfZ0sKVHqcN4fhTHEq9U7qVDhG3S2wz9wzz
 YH5cd8SPQ7FqIWWypY2Gv1kD+ekVjJ8cb+7NFcxRLduKdwVMHs+nzeCAVtB0naV9
 VOu+NbA/BY+WjRYbhheLNpIKPzoqLhj1RoBgcIpjMhKe6+n1yQJrHi9qAt7Q15FZ
 hKthjoNn4jdkVJvEnj7SdQOxlc5mW1VfVJfDeITlsnEa2E/mTzXMc/TmEA+z7NpC
 xDV+MA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x89c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329745d6b89so4038080a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784948; x=1757389748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBQQre50aOiB7vIhrSM03mlP7zl+XdQuOhi8uZVOGJY=;
 b=JK+S3PYqIOlLBwj9JnItbmtTrVh/0mf6nZq1fEBWDVOKtmPuFKChTmMdxXrpjjtZYe
 mPmXGHtjJcjI9vj5C7kUYBUPev6RgoPnL4XodJzb7gzm4/qSWvKiGNxA3LKt9RONmKVR
 8p/osHBQ3fIKJox6+BLH+ure9CkBou0Kk/YmqdW3JKm+URTOmx5mwVMCThGkdoc5UgRi
 WdejibNeMcQZmNyoqqauJUK6f5l8qP+zVgADdT6lMeEYg49Qzo2bRBwGhI+3xSB8A4cT
 sQiNmckxLeTg7Sbnezw5vD/1RhY6gDfcO9kGxejQOe7YUZ4H2a/qVvBpwuJhluWPedV6
 SwGA==
X-Gm-Message-State: AOJu0YxWMC3Fw5usfLjTxffwir9VTaEtiDzyxLZD2L3yMOxnWc2Mwrdk
 SW4mdxLqVupYa/IHqIsIyCRGyiVzV6sX/NetaNf5DRkwlh9AkpUBgPND0kYDA/jSdcbztwMyg7H
 6Ij8MiZqPbQQfDHicxfG3Ba24KbZQw509a6UQfNiFOYxZ8BiKZ26Fhp3roBdXcECTN4Pu
X-Gm-Gg: ASbGncuMEhV1voJUxp+Bhh0/w/essRuXGnWdV839DdW1DhlFAXdtXCq24I+U54HQtRP
 ELUPe9gJLbYIq5r80YP7yrwaGiZgk2Ls0/v3oCz90XLsc8IT2dhapN8qhXw7g7FXGdVGV2Y2bxI
 kLc9Zi0JQpeEtj/tl5+qDrS1ErfntHwOlDANfhvimu34hie0fcs/hrDKgIlp1k/VAA+9LfDsSfl
 yGTHTMApxdzuS6cwDPANZ4YMNBROgmVOWd0CA5kJNEotJRbQUPu2GtQDZVv/THUh9YoJkz2LOMB
 c99j8IjY3O46sa+84M0PzkT8EsvpHL1HYuWbpvdjB5OlLib64dMawPbnI0SXHfhs7AZl+y2rTnY
 rP+m/Bko0gSQw
X-Received: by 2002:a17:90b:48c1:b0:325:42ad:29d2 with SMTP id
 98e67ed59e1d1-328156e3815mr11234311a91.31.1756784948039; 
 Mon, 01 Sep 2025 20:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+v8UicN8WFYzSYE3EA74AcJHrvV2ZVJWd3c+53FSzblSTJQb1FsyEU5JQJ6ruez+0z5/cig==
X-Received: by 2002:a17:90b:48c1:b0:325:42ad:29d2 with SMTP id
 98e67ed59e1d1-328156e3815mr11234274a91.31.1756784947369; 
 Mon, 01 Sep 2025 20:49:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 13/39] target/hexagon: Implement modify_syscfg()
Date: Mon,  1 Sep 2025 20:48:21 -0700
Message-Id: <20250902034847.1948010-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gjs5jccxCXztUAnFtCMm6KO3yjmJUZ27
X-Proofpoint-ORIG-GUID: gjs5jccxCXztUAnFtCMm6KO3yjmJUZ27
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b66935 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HvbDY8S8NUK629Yy7K4A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX3N9n9T2MGWip
 7TdIequtclLEx1aqyep8OK/xnH+Jg5Qbb8ZA7s+UKY/p1HJZ0/isvguCFd8cudnhcDvrYTDTIif
 fYZQxD6dfX7iAAuOuriw1v2FzpeeNHew3V/9H8hBTa1xeGBMgDeIG5fMYKFNLgoQzwYC3ksFx9v
 GYhhMe5yJfDruqp4Q9WC9PnECvPMctVsrXF3Si53nCm9gBdjQKWeUP0pFEGvAX7yl7hiY8dAM+F
 c1CnmF+EEbuj3kL7Dj8GUs5hY2Vi6JfULtldQbAy516Jz2y28CwqCYZLCjLnxZINOG+VoI86rZg
 OLq5qaqgSvAgfHlBVdLXQPPfeRbi+aSsRoHsZzbFJ7wN3QMbPGTCdwaNXyOTaF/IdLwA0LIC4nB
 kAu5QpEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 47 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index a8b44a73bd..53bf0591ec 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1531,7 +1531,52 @@ static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
 
 static void modify_syscfg(CPUHexagonState *env, uint32_t val)
 {
-    g_assert_not_reached();
+    g_assert(bql_locked());
+
+    uint32_t syscfg_read_only_mask = 0x80001c00;
+    uint32_t old = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+    uint8_t old_en = GET_SYSCFG_FIELD(SYSCFG_PCYCLEEN, old);
+    uint8_t old_gie = GET_SYSCFG_FIELD(SYSCFG_GIE, old);
+    uint8_t new_en = GET_SYSCFG_FIELD(SYSCFG_PCYCLEEN, val);
+    uint8_t new_gie = GET_SYSCFG_FIELD(SYSCFG_GIE, val);
+    CPUState *cs;
+    target_ulong old_mmu_enable = GET_SYSCFG_FIELD(SYSCFG_MMUEN, old);
+    target_ulong new_mmu_enable =
+        GET_SYSCFG_FIELD(SYSCFG_MMUEN, val);
+
+    /* clear read-only bits if they are set in the new value. */
+    val &= ~syscfg_read_only_mask;
+    /* if read-only are currently set in syscfg keep them set. */
+    val |= (old & syscfg_read_only_mask);
+
+    arch_set_system_reg(env, HEX_SREG_SYSCFG, val);
+
+    /* Check for change in MMU enable */
+    if (new_mmu_enable && !old_mmu_enable) {
+        hex_mmu_on(env);
+    } else if (!new_mmu_enable && old_mmu_enable) {
+        hex_mmu_off(env);
+    }
+
+    /* Changing pcycle enable from 0 to 1 resets the counters */
+    if (old_en == 0 && new_en == 1) {
+        CPU_FOREACH(cs) {
+            cpu_env(cs)->t_cycle_count = 0;
+        }
+    }
+
+    /* See if global interrupts are turned on */
+    if (!old_gie && new_gie) {
+        qemu_log_mask(CPU_LOG_INT, "%s: global interrupts enabled\n", __func__);
+        hex_interrupt_update(env);
+    }
+
+    if (qemu_loglevel_mask(LOG_UNIMP)) {
+        int new_v2x = GET_SYSCFG_FIELD(SYSCFG_V2X, val);
+        if (!new_v2x) {
+            qemu_log("HVX: 64 byte vector length is unsupported\n");
+        }
+    }
 }
 
 static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
-- 
2.34.1


