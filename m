Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50102CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYKs-0007FL-K7; Mon, 11 Aug 2025 15:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKd-0007D5-RI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKR-0003r2-Bk
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBJE7s008171
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bBQY3JDfi5s
 Isqu5HUp7kVZ6LoWCvvo+zOI9FAcYnaE=; b=oSkdoQPxebT128j1Hp84fj9kWRH
 sCAOgWRjax9wIRHLgOy9mZUoADSvzU9EC3Qh81Q5GtngbbK7y81SU6GfbUTTHe2P
 LLzI3ganok2QKx2Tv2TAoCdcO3FV3YHRue88a9ORwyaJ+mNYbiygxK1UEYwTMeWD
 PbVRK08RaUcdWbYuKyTmRvrruPce5NleJZBapapBDh3jXXybktsehT0FjilWhOIq
 6Vm6jeL6HaerYlWXY92eqqN6UhsUo+GlGW0e9shuAGIzyLIwmUegMxpnmpqh0WkA
 Ero3h5bZozCY1clzTxTJHvj+9q3lHvqUFbHres6ngxfmrWDqaPXKolEMQxw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjhev9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:36:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-76c47324232so2932710b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941018; x=1755545818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBQY3JDfi5sIsqu5HUp7kVZ6LoWCvvo+zOI9FAcYnaE=;
 b=j2zx/JMHRlUTfLtdAN08XfCuQ4tXXfCUQs2KI2X20o/VbhSY64K6B1BzIXNAp8GUcB
 L+KbgW9D5P2NRwaem1U44VvO+cmuf4cMh0Ck9Joh2K64DOt2Ewsb6ZKi2TAzZaYSB/GH
 RYv4BgyZtsyW0K/TNkoEjhokXdjXzj/n5yiO2ZfLBjZGdgSqWBRjnQmmN6vZtxy2+pz5
 hEdkhBQiChL6Q6iz6sNLxSPp0cpgzO90ygSj1mYEhIGOHxqzyDXnoZJcAHaAPcVmocuF
 LcOfV/NPwFedRIMx9wFkcnCGVOJsMD2Ev8Y5hOgQjK8LB7/YTajm0zaO930kFkt1QJrU
 OCkw==
X-Gm-Message-State: AOJu0YxjainrpTNNZheB5yusKtDvg3Cwr94aOSdS0t4dShHhOG5GmPYM
 CMN5157Ns5gMHSJNmynvjX7+L4qgEk9G3rKbOSzWtB+mNS4WLaOdlSnW5fkSbTvqGNii1l71Bzl
 eZJogEvhAcyh1mHeHvqWss/UL8ifMAcyCM/dYQxmsduUWjhn0we7BeEZGFOx0Qxu+NREE
X-Gm-Gg: ASbGncswn9/huGMpuN9Ms9PmMgvVoPkaWcvJZnDTeBU3Npi4vUXP7Y44S3oq8zOYozl
 /EkiqaZMXQAaQDEYR+JyJV6ms11I2vFQG7VvHciTfPVk1VMp4fFkSnCfEE1Yf26a0i6PmzirDVV
 LVvYYq/HArieP691at2hLFRJ4KR13FSc0uPoiPvR+1jUASQi9PpYIofXh645xC7z/LzLFa6d//q
 ttdSIHvSS6iXnRrDUteb6asx59Z7Mnt10Gt25NCokqd4vA15Uj5m3sF+8qNc3cXrlS/MFFZSQsu
 fWMrIGDEuQwgXp8S+JzdyOcK8Czs4/i0Nm96oYuQTORGnPewCjG+Ig1lOwBpRrYQIwjMxIdKgB+
 d8ougyvtf5CsFnSU=
X-Received: by 2002:a05:6a21:32a3:b0:23d:de52:a5f0 with SMTP id
 adf61e73a8af0-24055204322mr22839558637.42.1754941018391; 
 Mon, 11 Aug 2025 12:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmle9vBKoxLagh8sWB8D2Zda0I8i/qcY6cxkD+vXIumb/y1I90opfpv8KW4iHC2k2pDa8ENg==
X-Received: by 2002:a05:6a21:32a3:b0:23d:de52:a5f0 with SMTP id
 adf61e73a8af0-24055204322mr22839523637.42.1754941017984; 
 Mon, 11 Aug 2025 12:36:57 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcef6sm27677171b3a.85.2025.08.11.12.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:36:57 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v5 1/4] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
Date: Mon, 11 Aug 2025 19:36:51 +0000
Message-Id: <20250811193654.4012878-2-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX0WDIuWJa/Sls
 tJ9r2uQqIQNuNFwklz6NhaiPBIQLfCZ2vfJh4BtkZr0ne1GD1CuuT/C2bT44H+WgDhnPbooo3EA
 6zfk9GYNod6OD1/70S55f5nGqmTcsYtyK475NXMOp2LS3h0bVq3zcza6JnRQ7ujxey3haxn7Cts
 o1kJpzDmihhPRIRMkSGLL76R+jJLn1aY2r3lb3E9UpJnhBHZ6MeqbdMZpv7qBUzGfauP1SoFbdQ
 yapcn3kT4l9xG9jTrABOynBRcB49g8MHGvM8lYIxy4Do3A4p3CD58aWUm75Phi1s1mqP4uKX+Pc
 5+6vYGXWfyMfSVTnQoVf/CScuZIT3mqQewFENzlYd+xEWCzuWwB5EF8JA+Nl7j00+ILVPUy/BJr
 /YHF3oX/
X-Proofpoint-GUID: o7uqJhVgJkB5Hv_lbkCkCbUGv3PoGeXl
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689a465b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=XJBTR8SIO4LSYOdVysIA:9
 a=IoOABgeZipijB_acs4fv:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-ORIG-GUID: o7uqJhVgJkB5Hv_lbkCkCbUGv3PoGeXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This patch increases the value of the MAX_PACKET_LEGNTH to
131104 from 4096 to allow the GDBState.line_buf to be large enough
to accommodate the full contents of the SME ZA storage when the
vector length is maximal. This is in preparation for a related
patch that allows SME register visibility through remote GDB
debugging.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
Changes since v4:
- the value for MAX_PACKET_LENGTH is changed from 131100 to
131104 to align with a similar update made to gdbserver
---
 gdbstub/internals.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index bf5a5c6302..87f64b6318 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -11,7 +11,27 @@
 
 #include "exec/cpu-common.h"
 
-#define MAX_PACKET_LENGTH 4096
+/*
+* Most "large" transfers (e.g. memory reads, feature XML
+* transfer) have mechanisms in the gdb protocol for splitting
+* them. However, register values in particular cannot currently
+* be split. This packet size must therefore be at least big enough
+* for the worst-case register size. Currently that is Arm SME
+* ZA storage with a 256x256 byte value. We also must account
+* for the conversion from raw data to hex in gdb_memtohex(),
+* which writes 2 * size bytes, and for other protocol overhead
+* including command, register number and checksum which add
+* another 4 bytes of overhead. However, to be consistent with
+* the changes made in gdbserver to address this same requirement,
+* we add a total of 32 bytes to account for protocol overhead
+* (unclear why specifically 32 bytes), bringing the value of 
+* MAX_PACKET_LENGTH to 2 * 256 * 256 + 32 = 131104.
+*
+* The commit making this change for gdbserver can be found here:
+* https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=
+* b816042e88583f280ad186ff124ab84d31fb592b
+*/
+#define MAX_PACKET_LENGTH 131104
 
 /*
  * Shared structures and definitions
-- 
2.34.1


