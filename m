Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554D9CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1p-0004y3-Kc; Mon, 01 Sep 2025 23:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1m-0004iV-L6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1g-0004fp-B6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SDqP030680
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UeEE5ojvXNhEhfJpLxhMabI5sN4yc768WwV+45QkkrI=; b=frOEJLYoVEXt9lLF
 9wDypURcfyZ898yWsv5j08I5xlYMo3H2siEuQ2j25qk7ovh+2vAxtUvim066Nc++
 CpgX8y8UUloH/jdaBjKHSMrHOVtdcvo7YDUmfEP/MQNYQ/lNwNLGSvQFJZZ/j/QF
 XU3V/F8LZoUvih1GDB+gtDkajaLyNI1d+zGZymmdLBQWvDTjO4VS3ZFtcax/l448
 KHNcN0BmjzG5HQmbxFl9EeK1kRT1UJ9oAYjMjIuVEKT+lZj1q6GXjV2uxhFkTiEn
 sdvhorACsUKlIdKYTxmxctLac3CSLXbMxh9lCd3+a7oyfjNGq0sPcrSTK2nz3eio
 bC60ww==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4d48818a04so2708374a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784971; x=1757389771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeEE5ojvXNhEhfJpLxhMabI5sN4yc768WwV+45QkkrI=;
 b=N8oueAaWBytpjKSnuMcXK7C3SkvupYtWXbNV3J1wq23wztEWvDlfrBJ/fo9Go4YoLs
 euRDwwvdtFyP0f7yokUxf3a2SZeHjciv2OMeCyCyRpiEutB+IgeFbEz6CGZsvmWegGiW
 lg1tw0AYhY5xA9MY8avM5cDXaGF5t4wMZkCea5vK2ypqtrCSUOvuVnaWW/SjuMrQ3I45
 H0A2iEngQjhDgLyJWwBmgFEKkhtV6F0TRXsbQHy20fhWI6W7wrK4k/K4QwXGKFHfktaz
 Rz9/W6lzTpDA7QpBNOLGOF8iueCqwdvzseBBNeZoi0r0/IhrT3z+nop/YMHay8j+/aav
 LXxA==
X-Gm-Message-State: AOJu0YzF7OMZ7E6r+V/S9G5eCUiRCwjGaD/QziSXbnDsdeQPTBJKtEKP
 llR682ZFMDnohyMXXCApe1ZnA/WoqyPDi+QNhctJEdz0Gm1TE6ohj5igIwvISbsq8ahgvLqgc+a
 aNQJUjASNavKOvshOfi0abDjKmBCu66/Fcj276ThsHyNZbPkXuwYN0A7kZ3K4+11x48+L
X-Gm-Gg: ASbGncsrd/kOjVjvcP37lH+2r9+6yMIHdozSNskxYpEcpzRl+cH4iVk8NJCZoHKtTUW
 EqqxTi3U55JikrSiCBqD3HBozVRXaKVCVDcCPlhBA9e6HJS79dpo38XiWEedN1OkIwRHiOB8XSb
 qECUTxWscct8K0oXvKPbc2EiTGsmF6GKkJsOJhFImCj5BMQRhM8Zo5sy5vPlOwAj5+O3N05dWuF
 HjtQcuqK7WekNt0qC1FGvfJ6p90h3Q/09/5TubwG3boenHML95GftxBcgYm6Q0PvVcBTa3bJZMc
 bdVRLHd76pwXrpKqvm0RHqIiyZdlV9LBRmkuv580qNj28iKp55MJP284/+Lmzgl668fOTgoaU5I
 seZ9OybRa0AVZ
X-Received: by 2002:a05:6a20:3c8e:b0:23f:f712:411c with SMTP id
 adf61e73a8af0-243d6f02f4cmr15427905637.36.1756784971529; 
 Mon, 01 Sep 2025 20:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp70sfZcgMOaXe6om1awLqZVuc0WpEXMNsnLKlPPJawiKVSvQUK/ub3PJRzUzjBtyPMHqSZQ==
X-Received: by 2002:a05:6a20:3c8e:b0:23f:f712:411c with SMTP id
 adf61e73a8af0-243d6f02f4cmr15427882637.36.1756784971082; 
 Mon, 01 Sep 2025 20:49:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 32/39] target/hexagon: Define system, guest reg names
Date: Mon,  1 Sep 2025 20:48:40 -0700
Message-Id: <20250902034847.1948010-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7Sy9waknEeqobfZ-I6BrS76d4LFHOT8c
X-Proofpoint-GUID: 7Sy9waknEeqobfZ-I6BrS76d4LFHOT8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXx4Mtzl4omSz9
 oaJGyXOcVV62+FiOnw28NbyRbfdA3w6kmx/dZxQEoKPC0igWcHhCkVIyjZNY8yDNyJHH+rfP5jA
 bKH4hn2FDUVmyMw57et8h3qZqar1YZ63JXlq2zY1Jy9CDJo+nn/ShGF78tXqIqhrNFbtxv7n13b
 iRg9ewkoyvZqLxVhDhl4IQ3ij3ycZM3aTGtDTaYUp0Nn1Fjtdw52AbBGvRphZGOz+EPBy0o0B4X
 jHf7Ju776UzRBtXdbkbbF4A7s87DVYe0qt1qy942sjmMZ9y3kS+8DqPLeylZJaTkUL51bBCVVLh
 /j9Gw40vCRZiFT3HcDUftxbEdO3FZs1rKzYrlLVy5jWqKSp2oKWSWQrMd4mq50RiuZ6nyjNYp2X
 TOBvjGZQ
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6694c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Y3CEZXcnQwYgoNz55sMA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/internal.h |  2 ++
 target/hexagon/cpu.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 94e5e502a9..a9eb5645f1 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -34,6 +34,8 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
 void hexagon_debug(CPUHexagonState *env);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
+extern const char * const hexagon_sregnames[];
+extern const char * const hexagon_gregnames[];
 
 void G_NORETURN do_raise_exception(CPUHexagonState *env,
         uint32_t exception,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 6d2013ce89..122761e657 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -88,6 +88,35 @@ const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] = {
   "c24", "c25", "c26", "c27", "c28",  "c29", "c30", "c31",
 };
 
+#ifndef CONFIG_USER_ONLY
+const char * const hexagon_sregnames[] = {
+    "sgp0",       "sgp1",       "stid",       "elr",        "badva0",
+    "badva1",     "ssr",        "ccr",        "htid",       "badva",
+    "imask",      "gevb",       "vwctrl",     "s13",        "s14",
+    "s15",        "evb",        "modectl",    "syscfg",     "segment",
+    "ipendad",    "vid",        "vid1",       "bestwait",   "s24",
+    "schedcfg",   "s26",        "cfgbase",    "diag",       "rev",
+    "pcyclelo",   "pcyclehi",   "isdbst",     "isdbcfg0",   "isdbcfg1",
+    "livelock",   "brkptpc0",   "brkptcfg0",  "brkptpc1",   "brkptcfg1",
+    "isdbmbxin",  "isdbmbxout", "isdben",     "isdbgpr",    "pmucnt4",
+    "pmucnt5",    "pmucnt6",    "pmucnt7",    "pmucnt0",    "pmucnt1",
+    "pmucnt2",    "pmucnt3",    "pmuevtcfg",  "pmustid0",   "pmuevtcfg1",
+    "pmustid1",   "timerlo",    "timerhi",    "pmucfg",     "rgdr2",
+    "rgdr",       "turkey",     "duck",       "chicken",
+};
+
+G_STATIC_ASSERT(NUM_SREGS == ARRAY_SIZE(hexagon_sregnames));
+
+const char * const hexagon_gregnames[] = {
+    "gelr",       "gsr",       "gosp",      "gbadva",    "gcommit1t",
+    "gcommit2t",  "gcommit3t", "gcommit4t", "gcommit5t", "gcommit6t",
+    "gpcycle1t",  "gpcycle2t", "gpcycle3t", "gpcycle4t", "gpcycle5t",
+    "gpcycle6t",  "gpmucnt4",  "gpmucnt5",  "gpmucnt6",  "gpmucnt7",
+    "gcommit7t",  "gcommit8t", "gpcycle7t", "gpcycle8t", "gpcyclelo",
+    "gpcyclehi",  "gpmucnt0",  "gpmucnt1",  "gpmucnt2",  "gpmucnt3",
+    "g30",        "g31",
+};
+#endif
 /*
  * One of the main debugging techniques is to use "-d cpu" and compare against
  * LLDB output when single stepping.  However, the target and qemu put the
-- 
2.34.1


