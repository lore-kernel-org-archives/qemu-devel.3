Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88018C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVW-0003B1-Hc; Thu, 27 Aug 2026 18:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVS-000398-L0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVQ-0000B1-4v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLkXR235843
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c2AaCDmP4t6
 W0JbAQFaB23LPy0Z1gk73QCKx3GL437g=; b=Jtho9oNVgQ78C28pV4OIr6nopG/
 fnQq4EkXmshVGkBmDPUAu/pPG1C53bmsCMgLfhF7XGZjJzrckcgIef4OEgZTSsEh
 w9ahJHz0vG0Zq4aLMn+XQ0vJBQ6zpSZx1Ldftv4LX+JZSFT3jLDBu+BSpg/IuX2I
 4Cov1713cRRW1wcR6w5xs704qK5Rv96clTFpEFJxe3uIavzVqvPe49B2e7uXgcXA
 ekrVwKqVI6tdWshEpzPvrR4+kLDJzQpe/qOwQ1QfEPCAk2GkH4lLTuzaAlEksQiV
 IPspBbcsW0NQpjtAWVmTS0NRiM5fHdAjB9U4gG8q3/m3Nykbz/1ol4BjPrw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjguh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cce14a21faso4130175ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869406; x=1788474206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c2AaCDmP4t6W0JbAQFaB23LPy0Z1gk73QCKx3GL437g=;
 b=Vl4cy+tx3HTEP8iNVSk0AFAj/q5CnkEUwcBbJYCaL8DNBlszjvavS/S7LDZWPzYHk1
 4XqaT8EHlQRzBzqeGUSs1uj6Vmc+aJRLVuNQ7m/D+K8I65dBE9tWD0sJEQK2vB28nF8u
 bVhrAvK1Tv3TDMoMzdNEuAW2Ibl6uINmFl8rOHG202mE8ISDlLJZoyF7qsbnVHqCg6wE
 BL0uK75IbnGhEynTU16Sy3reaHrm1dVoYjXUwLDUpu4DNSrkTx0i5P/ZFxV9JW9n7MjG
 XoChXRkrBPISZoGP2cm5dF0M/R008u5e8zPEUfgdHc2CMuYM7+5nlw9V60QeRUror+Bt
 cxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869406; x=1788474206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c2AaCDmP4t6W0JbAQFaB23LPy0Z1gk73QCKx3GL437g=;
 b=UnyNuTQxKm2wYXvzKw7JfqdNZHT23119DKRvzrdBdsoSsAZz54nL379fbluw71qiS0
 niack2fMAQpR8OlDuzho/JfRibPDn56ooo5ePIB5AD6vi6Ho9jyEVhUQfPEgxvGWdojS
 CjwGItA2qsDtf72g/scQrvvC7zroEcDTbQy4BO5fBwq0XqBEtbeu7qG1cfpCcuWk4iVG
 VT8EIv7hQbU9QWQOE+oyJzmgI/7FYFEkTcxaSCuUa6G3VKs0xF9+AFpdsf4fq83q9Lg2
 3i42kH9eVa8TujlHTCYSE8fJUhE7ClUnr8F/PH0aYP5MJLYSk4casdfKrf87prjxJf42
 lLog==
X-Gm-Message-State: AFuF++nkyAy9nRwknKflKXn5cX+n8Zi0k239CxJcDFXNB+53qVW//5I2
 4ZQnj2larmaJA6X/X1tI+ABmUPnNusb58BblnhDmP/oTqXRA8TYaLdPtTaPlG0Vtd15bszSIdsS
 xDTf5zb5BwWKJThwDFf1YBizFz1wq0AJ/Hdy8EO3NRRIx0CjEJ5O7X9EChJdbgHd5lA==
X-Gm-Gg: AR+sD12w5zub0CJLdcj8SgaKmX8+xRGxCJh006Fuv5DIAyB3L4YFKoMlqfscO5VMVL0
 EWpoNz2s0FmRr3TodZksBGFx1BO1Qc2L3J4wafil4Ey3UtObm2yk6Qpa8QL06gJQuvXO8WQhRc2
 2B+qNGnNPi7NIELcj5SqVWstHYdw413Q12W3oxK4jblfTMzIlOPSMsMpj0d61ftcL2PWoeQYdJg
 AlIvDQLHTctyPRDAceRKxQ1bWSAwZUrt3QhdLen/35qeEHJ8wBXZCVbxOr0CmwCJxROJeTEnbMj
 mN/iWkTIGJzMP/clqUSevJnJYQJTtwzTJmAdsCg3uUi3/WC02gIow22hdFEOMtOJMt9XMh2fUyB
 RowDq7wZ91i7KmhrV3JlDs0/pnk4AjIYejYdq3X3bKT7CFyS1ryxqovHQKsU=
X-Received: by 2002:a17:902:ebc4:b0:2d6:f80c:6ff1 with SMTP id
 d9443c01a7336-2d726784320mr116442915ad.9.1787869405699; 
 Thu, 27 Aug 2026 15:23:25 -0700 (PDT)
X-Received: by 2002:a17:902:ebc4:b0:2d6:f80c:6ff1 with SMTP id
 d9443c01a7336-2d726784320mr116442465ad.9.1787869405273; 
 Thu, 27 Aug 2026 15:23:25 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 085/105] tests/tcg/s390x/console.c: directly implement
 memcpy and memset
Date: Thu, 27 Aug 2026 22:14:46 +0000
Message-ID: <20260827221506.91574-86-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fg8M7abTcxVSArLR4IlSsB9EfS--eX_M
X-Proofpoint-ORIG-GUID: fg8M7abTcxVSArLR4IlSsB9EfS--eX_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX4oP65QuRI1Lo
 9O8WpCsQcW4z2wJQgQl8F3hKUc3p4Lptrr1lSb4T/oS10L9F9qAZa55dKbZxD/jQXowTQyaiG3k
 hTm0+MqeUxhs8vMjgP+PXx0rc3c9E4nvswdNZOQSDvSaYmqIG2DebeuJSJJLdyxxPwMCJ3nJoz2
 PJp9Xqjw+adUiq4ynMwllf31m1oIzfd7EUABZBP09TXwMsFyH2EZUQ+O29Hz8U2xyj9UJOKRJVJ
 HRprgJjRiTHXUsjEI4jGHq3lmkYPjHYffXHeUsiOCl/mCHXDQ7EAGM00gII0E90+CGHTPOQFHzq
 rv5Dnnd94y4lP3qtDNBTXXEUIxr/A9XcTNSFCfGJAru+1OaNPltdzRM9oMOljbYZrPgiq/K5/+6
 cf6MwWCUWHx1CuMKZdLjaeLQWWz3eGFKexAT01koFEUU8sYt2R3sR1p2jxwFB+3h8INAOePiM8u
 6Y6zipJvPHLujziMH3g==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b8de cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=-FtdqLbzwS2V55xVmDUA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXz78iUo+SQcI6
 a3GhZUmhfm8umhWdTEPRerguGgWs6d707ldP+a7O/mVB4aL2U7AMz3I8LF1B+1Hv6T+rKixlovG
 0+lOV1+FesamT91vlwQkoWwP4znemP4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

pc-bios/s390-ccw/sclp.c uses memcpy and memset.
pc-bios/s390-ccw is part of QEMU repository.
However roms/SLOF is only available if submodules have been
initialized, which is not not always the case.

To break this dependency, just copy their definition here, and remove
include to submodules files.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/console.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
index 6c26f04949f..061b9437d98 100644
--- a/tests/tcg/s390x/console.c
+++ b/tests/tcg/s390x/console.c
@@ -6,8 +6,34 @@
  */
 
 #include "../../../pc-bios/s390-ccw/sclp.c"
-#include "../../../roms/SLOF/lib/libc/string/memset.c"
-#include "../../../roms/SLOF/lib/libc/string/memcpy.c"
+#include "string.h"
+
+
+void *
+memcpy(void *dest, const void *src, size_t n)
+{
+    char *cdest;
+    const char *csrc = src;
+
+    cdest = dest;
+    while (n-- > 0) {
+        *cdest++ = *csrc++;
+    }
+
+    return dest;
+}
+
+void *
+memset(void *dest, int c, size_t size)
+{
+    unsigned char *d = (unsigned char *)dest;
+
+    while (size-- > 0) {
+        *d++ = (unsigned char)c;
+    }
+
+    return dest;
+}
 
 void __sys_outc(char c)
 {
-- 
2.43.0


