Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC2CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvgc6-00082p-Qo; Mon, 08 Sep 2025 14:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbw-0007zo-HP
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:29:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbg-0001As-3C
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:29:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588H8QQX012487
 for <qemu-devel@nongnu.org>; Mon, 8 Sep 2025 18:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hYcRMIyLWQv
 lXfcTsmqq0jOfVzmmK99eaBq5EKBXMsg=; b=hijIuGx9tP+JirEsEZ7WOiRQ8k4
 yh8xAfcfybS1rWwoxak4aGE9qCfcCYVR9z8yfdfuc/6Pj1dFE1L2IzBMOeS+sN6r
 RAweA8k7NvwYISgyg3G5w3E4F0TZWzTXT2uhkDr1GbJU7fOfytZ0gud+Pn+Ay9OL
 iIc5wygJgx+0CfXEorp+oAfKJ+hpio4NRf2HlYnR8S7+7t5VA3P8AyPK6u2ZsV9D
 yafqE7Z+iaZDHRfuzKzWWMRsEj6VO9DDxP3JrFLmNEODgr3iNprQKctFRWpNSinC
 7zYELPVqYTGavo2OxfS+ktjSPvZQhSR9VaVOqIO+qRm0y/rzfYsJi4U502A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8wpph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 18:28:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b47630f9aa7so3786815a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 11:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757356118; x=1757960918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYcRMIyLWQvlXfcTsmqq0jOfVzmmK99eaBq5EKBXMsg=;
 b=w4rhOicOZ+gEwpLBoTnKO4ZBNQQMcNCvz2pOot7zDtd5wEqyG9Jpk6IynX8DFuxZfC
 JzERXkOle6My0xvgN0d5NVEaWBimbO4JaBI0kqrbc8JnSBomKQLH4dRblOxL32kmOCjR
 GqIaPngIZG+OVZ9k5mOnV3ZQg3fSJhZxmtCk0NoZhUpslFuTDaOMe8OtzMM7T0J0GveZ
 YLL/gqR0tEH2f1W9UYvGUYTRdAyWfV+QMweNbOQ9lBhMP1odHWTsAcoDCrmHjIB1aOVJ
 jT7ZTpbHnhJ2T7f6DOxqtfupva29s6a1TdrY1BT/QkBNLW/N/noXV0vshymDJDn4SgGs
 T74g==
X-Gm-Message-State: AOJu0Yx11+MloZnKgt65F2QPefLx9/6p8PGYPlSJFwZxYAOv8m/ZZWtQ
 5oBVSGtg0QExqKd+Uon+t+LBiyY5wKZ2AZUvMCiTOItn5x3DQO2j2yXiP5thK451+Yp9Se9wXh3
 WTcnl2ri2l6IG088hSbRnmCV2TKc7xTvAmYymqKjcI0I2ktdCud3eIqxYioankOIWH+PF
X-Gm-Gg: ASbGncvQdoUQHDVs10a/cjwttrpNUcxWCB+3oZbfyt3znPL81ZlULC0vTaXuqIoj1ju
 3qgUi0AStfbO3wi+DGpEZiEyv8QEOMeJ0d/HiZe/TT+xlsn0LQhMPD1wnJbH9sA6DPvn5zc5Gbp
 AmOOoe9B0nLmjXP/4PP176HagKPmAxwZEUcJ/kdmHlC7HRIbcV3YK/X2uAyRz3wFPyqpLnwlquG
 ZTV00wjaqIj7f+Kclh5zmHjxcQW59+AJpgCcke8bHB8kEc/TWvZrnE6uQMF3RcTapkLdFtB69XW
 I3qaZrcm0R1eYjdCPPPf2JWcGWIYAqcIy6zJsIaf23XJNwSXx5zC7z6BdTPIBQQjZlsjcKaWUsB
 BxoDvhGRsDJKFDtU=
X-Received: by 2002:a17:90b:48cc:b0:32b:d79e:58ac with SMTP id
 98e67ed59e1d1-32d43f70faemr11329227a91.31.1757356117389; 
 Mon, 08 Sep 2025 11:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0tXNFx/lYlzA94gjiwydyD5BAk071KUchH4SJmXhdh+jUXu3XSmD3OX4wbFdpN4TydNnuZQ==
X-Received: by 2002:a17:90b:48cc:b0:32b:d79e:58ac with SMTP id
 98e67ed59e1d1-32d43f70faemr11329197a91.31.1757356116862; 
 Mon, 08 Sep 2025 11:28:36 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4f9c35f391sm15480164a12.25.2025.09.08.11.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 11:28:36 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v7 1/3] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
Date: Mon,  8 Sep 2025 18:28:32 +0000
Message-Id: <20250908182834.2476277-2-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bf2057 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=XJBTR8SIO4LSYOdVysIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ul9cdbp4aOFLsgKbc677:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WEoxvGcAU1vsK2wa-JBGA6BRe6-ODnM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXwR1GDdeo8l7+
 aOcHfFYgkbBfasc7w3uRjyF+/re6xkHNYEQ0UW3MlYiSVEtELd0zptg+1eh3AAIz9AyFW+FDzhT
 sNvKBJfNaURdh81yj9dNX2OrhSlHI3yCLYSOqFuBncaiB/mJUelvY///5x3himkS+yH/oAXbqBt
 Q2mn1OVT1cYmBFVVF9lmT0xLGqR2qNhtF/cA6ypfKwcb9Gum2qLJ4A8x9mHbbuAb7QtKrbvDjcu
 P9Jcio7EOrqno0u3nK+BI15rpFL18btNf14nqJBiA5o6hcQcMQA5h4oLVcgHDg/ZX6AKXU4xbxc
 bz69zo1pK90Cz9CKw6ua5P5hiHNQBWvk34iHsdo+N04qMqt00crjA7irtGtIcFvWIW+WdRzLRjX
 VPCNNNsR
X-Proofpoint-ORIG-GUID: WEoxvGcAU1vsK2wa-JBGA6BRe6-ODnM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


