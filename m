Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0471CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1I-0001lb-SC; Mon, 01 Sep 2025 23:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1E-0001UE-T2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1C-0004bD-W6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SOtF025567
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2ouGzrqBjlzLoVPfIcGOlSh6v3C3SP6aJQwBy7KWm24=; b=kcY+Wds58xk30FJb
 Pwv8s9kvhbmzVcekT4JQmiR4DxyeslVK/0kn77hgCiBAdH6lXvns+WElauMpgB9F
 R2CNn0N/ctbEenjgvJAkiRQRzihUt8yNCyio8TZ5UVxVdyufgPq66TaMVGowF061
 OHOBPqYw81xNWRZbaA1tNmLq+ZrSlimMlF5E+vSP+5/zSwvlhiTROmAFPbXwZ0fd
 tyyp6Q3KVSuONUE9wo4xUqqelJyvM52J15nor0q88VspzX3ywzDLAhfqfBJXD7ZW
 8NU68VSPff0lUzWSYPiq4fYm8X5Le/4ypjajLW+Q3mkMkMbBkF+ZUOWSc0nSWM89
 u3z3JQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxe9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-248eec89618so49514785ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784942; x=1757389742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ouGzrqBjlzLoVPfIcGOlSh6v3C3SP6aJQwBy7KWm24=;
 b=NOHLJ8oYU+2r5G0UCMty72e7QB+AyMuaUj4zYsqohjHyl/xXGcLOzA3RjdS2eky+RG
 LUIcr36pt7M5yyuMIn+TTiIYmot7Gzo0YiXe89BIPcUohcMsnhjgrEcB6lP6r0zoNzbp
 Y4PmMnJOy60irxHwwORAqNB+ycu9KYcy+5uPOQ1vDW8txoPqHeDAANY90W6H5Q0q0f71
 UWGjTnbBjbiirZP1kaacwj5IP9OLeCbEAqmh+NQHjjd9n6SkiuoaM7s29cQKATYeQ9WI
 PNpsXpxxQYli4JFUdYnKh6A/A+wXQ7Kv9+vZJQecCdaGRJy8wAUJSakzKcEMyQEPDrSQ
 Xpgg==
X-Gm-Message-State: AOJu0YxdbIX6KoJgvwLVQ80tPJB2xcLQ+RCnDY8Rz+IzSLu5lVahHz20
 Ss5r4lIaJWrYMLYEcQreQdTYgSas6FdjNDzZLTwl7jiO9iQ+1XoZHWJuIfgKCM7Ir1BMN5n6AcS
 dGWCEqAam7Anygj3zDOKAgNIHKn7BUEsALQgyAqTKoYJAfIt8rbB9Mynu1W4GJrGLvClm
X-Gm-Gg: ASbGnctzmGbiNXwEWp72Bsw/SDXjhbuNpNdq7fIbaECb064fP2uKdsgkHKGWigIjbiP
 a5K+UuDaRynkOq9aL24TUbGkOyEaCZTH7glJPPt4a7q6qt0aTEj5UPtsNLWpGsB/6nm04E9xn9N
 DPkHlX6sHYXz6pKUNmdqs0FNl5mOTNDlkJ5yV9sTkDkLA+VF3T9Fdpxfog6IOPCbA2aHbw6WAt1
 deotm7v2GH/P60129KZJrxsC6VxMFZ2KFHvOkHy4Uhc8q0ZXidIHZsgkXfiBoMoouORqw/f8zxN
 6cfrqQpWHztjZuDQsNyPIsYeh0DrktP535dEURPwjnXiOgzY+116MmMWyN8MlXBp0x1idiKL7Jw
 H3kPCwjRHfSSP
X-Received: by 2002:a17:903:2301:b0:237:d734:5642 with SMTP id
 d9443c01a7336-24944ac6b51mr137041155ad.41.1756784942134; 
 Mon, 01 Sep 2025 20:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIhs+ZvA0TbaH38aZHuYWYmDObiwlYfS+K1MIHOiuzsNsGroCD4Q8TQg5CUlyeED7rtmJ5sg==
X-Received: by 2002:a17:903:2301:b0:237:d734:5642 with SMTP id
 d9443c01a7336-24944ac6b51mr137040975ad.41.1756784941686; 
 Mon, 01 Sep 2025 20:49:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 08/39] target/hexagon: Implement get_exe_mode()
Date: Mon,  1 Sep 2025 20:48:16 -0700
Message-Id: <20250902034847.1948010-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXylIXrx5m5E/k
 WQcIBIbwTQwfDZMiQbAybfAo2lud5MgT5xkft8Oz2669ynmz3iQ/Yb6b+UHGSS8fgHcpoAEtBbL
 jTulYDzeU1Y91qdf2kftny9rl6dnX7EmaYdzlcsdUbg3VWqguqHRb4B3Ydu8GKmxSuhpj22OImo
 X87XCcngn46tI+jarNoZnIn9ydnHlsNJBS+VOYrHXT4cVehJIAObT7Uzwqq2LvcQ7wUkLh2czTx
 eEp77yDILnZHyzPdiAv7J7gdfw/0dKvSn6uqyW47miHfAAcw6beuSwl4g0MpKSyyvz5EZUfYB+c
 RXYWgKITk7Kz5I28RpU8zOvc+AVVe9yNsIjRudgjmIt2t75b5ATskbubK0n+JX2lmTH6gDzw0iR
 kJztw3sl
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6692f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=xNtBLlBv4CHGg5Otw5oA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: R5SzR1D20swdjUQmZzS5XwBet3B6hgTL
X-Proofpoint-GUID: R5SzR1D20swdjUQmZzS5XwBet3B6hgTL
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/reg_fields_def.h.inc | 11 +++++++++++
 target/hexagon/cpu_helper.c         | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
index 9b112ccec6..d2c706d56b 100644
--- a/target/hexagon/reg_fields_def.h.inc
+++ b/target/hexagon/reg_fields_def.h.inc
@@ -135,3 +135,14 @@ DEF_REG_FIELD(CCR_GRE, 27, 1)
 DEF_REG_FIELD(CCR_VV1, 29, 1)
 DEF_REG_FIELD(CCR_VV2, 30, 1)
 DEF_REG_FIELD(CCR_VV3, 31, 1)
+
+/* ISDB ST fields */
+DEF_REG_FIELD(ISDBST_WAITRUN, 24, 8)
+DEF_REG_FIELD(ISDBST_ONOFF, 16, 8)
+DEF_REG_FIELD(ISDBST_DEBUGMODE, 8, 8)
+DEF_REG_FIELD(ISDBST_STUFFSTATUS, 5, 1)
+DEF_REG_FIELD(ISDBST_CMDSTATUS, 4, 1)
+DEF_REG_FIELD(ISDBST_PROCMODE, 3, 1)
+DEF_REG_FIELD(ISDBST_MBXINSTATUS, 2, 1)
+DEF_REG_FIELD(ISDBST_MBXOUTSTATUS, 1, 1)
+DEF_REG_FIELD(ISDBST_READY, 0, 1)
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 11a9dff522..1a1520214e 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -135,6 +135,29 @@ void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause)
 
 int get_exe_mode(CPUHexagonState *env)
 {
+    g_assert(bql_locked());
+
+    target_ulong modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    uint32_t thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
+    bool E_bit = thread_enabled_mask & (0x1 << env->threadId);
+    uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
+    bool W_bit = thread_wait_mask & (0x1 << env->threadId);
+    target_ulong isdbst = arch_get_system_reg(env, HEX_SREG_ISDBST);
+    uint32_t debugmode = GET_FIELD(ISDBST_DEBUGMODE, isdbst);
+    bool D_bit = debugmode & (0x1 << env->threadId);
+
+    if (!D_bit && !W_bit && !E_bit) {
+        return HEX_EXE_MODE_OFF;
+    }
+    if (!D_bit && !W_bit && E_bit) {
+        return HEX_EXE_MODE_RUN;
+    }
+    if (!D_bit && W_bit && E_bit) {
+        return HEX_EXE_MODE_WAIT;
+    }
+    if (D_bit && !W_bit && E_bit) {
+        return HEX_EXE_MODE_DEBUG;
+    }
     g_assert_not_reached();
 }
 
-- 
2.34.1


