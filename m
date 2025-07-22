Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B921BC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 20:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueJNR-0001m4-7Z; Tue, 22 Jul 2025 16:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueJNO-0001im-5c
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:14:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueJNK-0001tL-Hn
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:14:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCHOF6005532
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 20:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3TAy4bvkTkR
 BBhKd22HZRG7VTf0KUcpbt2SkLKVIFfA=; b=ar7FP3DL2u9r5OrI0K76u+KpLIK
 PlTfcvRRGRSoLAuUl923x5MRJkKHB8vfrxdobuRFQbxhj1SIiZ5x31jD2cw+yFhL
 yMnQLVtLIUemGxWPiJlYeDRgFYftuVr7UdiJWCRQmcpnyTwhS8mkXGABBvlvPgZA
 3+XeHDJfdbFReKP5PDKQa/3udoz3SvKJWE2wVUkOZdXgoaF5Rb6Dbx3AK9c+1rb9
 PgpkbJyH1BQijOSNdPuX+LkQTmPXomY0ed04HCTl5lJ+yVRnesdk/eBkOk2EdyrW
 zBSyOS5vLpInxApC24spp1b/2Za0optLWoQp13uIwBzFvhfkietfKxo+XNg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qasuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 20:14:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b350d850677so4378512a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 13:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753215248; x=1753820048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TAy4bvkTkRBBhKd22HZRG7VTf0KUcpbt2SkLKVIFfA=;
 b=pDfh8WIGAJTzUMB4KrJ9DwlqLfwtExIRgbukQOV/KbnLm6JmE6WW+W888T2BSBI5X7
 CYGKlxGzlGNbCFnTeg8PRfnLL80VcPf2b+d6Ug4GigB/iAXOUO2Ffv5hEuhhvG/8cNSu
 n4k9sJpuke4tTLJBl3j8FyHk0tVK6fsL7U70pXGmVtXXJm96USTre7LUZRiVN9UZIgLC
 aJcdMm+xi5Y9N3ulKTTJ6IahVC5j8TnrfojXOpu3yxoyM3WoL9pIpjhb+wqw7ppnkfd9
 RrBHfomnSMkHb8bWtYD19PdT/0bos6Y39V2DMXQR7zd1hvyjl1mDQAv/vsXztqwAmv4d
 1P0g==
X-Gm-Message-State: AOJu0Yy2d1iU3eUd6iv4fTJWII2groxPywdxkA5H+1739VAiIAvyqwRB
 I70GUFAk69UMS0XTzBiwMnVSuG2yhFjyACIpi/ldUsTVET5FtGIxG0Uyp+Ti9Yy5LQ19/sLU/gL
 WKCYhETXTwAfX7+qA/jk1yzHv+qrjtmwXIY7N7ShsNTAAiHX9e/HQ0veG8Rno9j9ZK87q
X-Gm-Gg: ASbGncuU36twQfNaOqCFUx6c6B2fSWGt20EY1lQSRDIiKav9PPCglPKL92p2198Btn/
 HbMsVPKV9m3SJW/9fhW6SiCpoZ5Zz4pAeqTkB2MHXnfzKVpcwHdufLMMPlGnY0pgEpcPlKmmW29
 L3GaC2bypDsuh1ASFTDWavNstefQrp3ePRKbYy81X+uS7BzMqMmmTsVrLaUeXKMo53sAG2eg20t
 uYVYU15hJRU33IZ1FlcWhOfLqiqD4Ev2XKJAOgDMzeHGPobuKzQWi4NUEUsPCK8F0/HKcCmnnFI
 AaaahkeGxnQWfKpUgYaruJUPIplTMLp7iYYAHrazHZMIDs1WxBGkBvm1dyYJYdT3GsXji0GxwpK
 FBp66Okr4gegRHHE=
X-Received: by 2002:a17:903:b87:b0:235:f45f:ed2b with SMTP id
 d9443c01a7336-23f981619c9mr4146775ad.1.1753215247990; 
 Tue, 22 Jul 2025 13:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhgvBFqjglWRZ4YjWAwrRnOA+Bp1zqhdtqcB18cl6USAe8tf2ougFqjgVh66yTSdN+Eb9Cew==
X-Received: by 2002:a17:903:b87:b0:235:f45f:ed2b with SMTP id
 d9443c01a7336-23f981619c9mr4146545ad.1.1753215247614; 
 Tue, 22 Jul 2025 13:14:07 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4a9esm81917075ad.93.2025.07.22.13.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 13:14:07 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
Date: Tue, 22 Jul 2025 20:14:03 +0000
Message-Id: <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3NCBTYWx0ZWRfX/4D3u2Ce2AMj
 /Iwh0ntsJ7EJD9nDWfI58AFys6gSOh/2OqDuyM+w7oqpVXfUPYPuYotitR5WGvenIlNKkAbjd0j
 W07enQoUf+0shx8814hT1kFUAFXiYM1EuOffvFEBnQaQ0K2+UcP848wrFCSqAYXSMd1gXj4b14B
 E4DGEL6OzbVX33exHbev+vKRhNXxFDqghD6wdPXx6vGMNz4KLTYFi4GRBEjNHxpKW9xVLVTmQPr
 tBA/JLhI+iBjT5vcKMsWCgG9irjWiALUBDWSqf6ovJTRm+wGo9Tri1GJlfvz/yggdJyFuAOpiIH
 ljwuCXP3/HWIFGl64xeaxDLQgyUtzdccANSmq3MIR63eoP/9PrCiWey+4b0+5qjbApLZApHIEAR
 qGWBO6zkQfG5Fi4p+Kpma/LzuGeWzpsGfStaNTzSYPa8IWDG+al5HEhAKe10hQOQUoz+dFa0
X-Proofpoint-ORIG-GUID: xdethUtIXirSNW2kfIszmPxHlf1EMn2A
X-Proofpoint-GUID: xdethUtIXirSNW2kfIszmPxHlf1EMn2A
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687ff111 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=IPAH5rSrwdKhQ0QJRd4A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=951 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
131100 from 4096 to allow the GDBState.line_buf to be large enough
to accommodate the full contents of the SME ZA storage when the
vector length is maximal. This is in preparation for a related
patch that allows SME register visibility through remote GDB
debugging.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
Changes since v3:
- this patch was not present in version 3

 gdbstub/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index bf5a5c6302..b58a66c201 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -11,7 +11,7 @@
 
 #include "exec/cpu-common.h"
 
-#define MAX_PACKET_LENGTH 4096
+#define MAX_PACKET_LENGTH 131100
 
 /*
  * Shared structures and definitions
-- 
2.34.1


