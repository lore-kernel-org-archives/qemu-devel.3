Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B79DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ9x-00021I-9B; Fri, 10 Jul 2026 17:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9k-0001eQ-Iz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9a-0006Kq-Ai
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3i0A1623600
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ttltpq9AoLz
 NbhdQrUO1BAGAkzuMshSeFMcmlK5+oLo=; b=YQhHB4VKNFA9fWlhnOHQDAnNLg2
 VrUvnHaXbAKG9GFr+EdqPv+M1roPG6SgK5qMsLZsxGTvbkYmHc3h+WyxOPvRlHOj
 Sgz9pHOeOHYNzV3yB+THPeDiGIlg6c73ChmYCJF7g5nMqV6Qmkz6r371Bj2wrdo7
 MTnEaZteA3/TU35KJH9FVrBLTUTaeOWJwUYf//mXBAjtK6TZbh20hgI/5sUkjrsr
 fmROGaO9SNq7j90mUS/4NAn7krNHHJsRyShSlQ+HpwAzE7pMBMGSJG/eqpZXAjyP
 LVC4jGuizSBvYw2dnzUf+hCpMAeGo+p3JKb1JnotOoVS2c0/xVpyTrFpzDA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8vhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:52:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38127ae6b99so1996998a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720379; x=1784325179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ttltpq9AoLzNbhdQrUO1BAGAkzuMshSeFMcmlK5+oLo=;
 b=R7F2WV9ownX7fGBkiUI+Of1zy6X8LblhawQkntHKopuJ+4o28xWjOic5m0n0aAcisa
 bnw7kb1mZG60q+cWssHs2zvIMP2Zv0SlkeGWXN+MYNmz7y1uqhf4kAxls6gmyPk1t+fe
 KwNYYiKcov+dzevHG3W1IZfaCJq9t0jZCHxMWbCwumgiXtaI3XMfPROJTZR1C1+tZFlX
 xom0f6tIxqcwJn5U4VZ+PBWXvDl4+RvyiR3WYlm9UXGtOq4pFFxkQN7uecKwqRwsE2Dt
 Iswf1fvxpIS9RS/zPl1OZKQH76IQRrAu3fTm3pbEbcDdt4eqdg8CvRLhhIdUcmHAzVoM
 jeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720379; x=1784325179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ttltpq9AoLzNbhdQrUO1BAGAkzuMshSeFMcmlK5+oLo=;
 b=dmgUwAgtR8PwOL3I8rCV8F+BMKNpO+0BXbjbNmdityoEIUaiasy7R1LvdnR4J2c35M
 hETDHYqKxfUHympcKfzIm2SrJsWLpKe7rwhqeCrXicbGnFltbxv8ybkaoRBUctxD52fd
 qy3ycgYpRNo/iT106SFhrz8hcq81QaGEvNS/Em7XzvN8YypibBv5Np9pDY4I8ir7WJZj
 tLk5KxdTPfbLeIVKTawmP/VbXZPHcckjVfhVFJb4JV/3wT/ZnnciOOvfYgDUSRFsiL3b
 ejiIxBFNzsExOBPMsMNdOuomuQt96F9P74wt7OIilsSwT6OHSANCZx20epWiT53xrR/x
 HNFA==
X-Gm-Message-State: AOJu0YxQllWYslfIHuLvUkZ9T4OyJT5/Dtvqig2VYOdjncAIQuK7MdXo
 wIRf2+G4FQ758n4lksVATLKwfthQsSAfNHhMSMlQUuzxJ/YNMMfxqf4PCuscxBv9lFxV+5TX0YG
 FvybA3wEy47O1jmOFheyL46dGzf1GzzBYyu0T8ZypTGylnfBfB6uMZ0oJyEBV6K0v1A==
X-Gm-Gg: AfdE7cn0uggzuA1hFw6n6L1I2lZnVIDNsL5uY2LWzRHPQndQ1SQfwM0hBK7MzcW4+42
 uAvrrCz3dtylpis6NHzjt6au66WfiCjx3OBIENCTPZODRYkG0v8VfIJlcgIcvUjnJbyWNi5/LEw
 Crk0eloUqwkvAVWJ9oSZ3oxUKnyJdJ5t2/me9uxv/UJvuPvT1uml8uggR7pGdPJbwWELbximwoH
 XUmD19dAy6j5IPN8b4iucZ0jwtn1F/WVnUGQ/OtOGXAUkcW8V/PSuNHrxB2gugJUo4YIS4Ito23
 7/HCePwz6iGtF6RKwhF/KFA7XMQ8UfMtF35hEy0Jp8td/8V2xssx+vx/rlBppcSu9aD7xUU658/
 +1Ehqamcxfqa9umLyEmQdK+9lrUVE8k6nTKclqceaBrv2RvHtfqPKaKxqgRxfNnpmauyJ18dKIq
 ieVGQ5Tg==
X-Received: by 2002:a17:90b:562b:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-38d1596cd89mr5372063a91.16.1783720379127; 
 Fri, 10 Jul 2026 14:52:59 -0700 (PDT)
X-Received: by 2002:a17:90b:562b:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-38d1596cd89mr5372038a91.16.1783720378648; 
 Fri, 10 Jul 2026 14:52:58 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:52:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 83/98] tests/tcg/s390x/console.c: directly implement memcpy
 and memset
Date: Fri, 10 Jul 2026 14:43:27 -0700
Message-ID: <20260710214343.2065491-84-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QhIXP_0YdvCRF8R_KmoBS7N1eBKTJIw9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX1UB/YDmzDkwK
 oWys2umaYfVb5xEC8WV8x9d7pLs348x7BF+ff3jArpa1wpXLxzfE4nJ1qLVBE4tTiI9LohueNVd
 xqswBYCflUvGJj5HwT08XrelyIYTwD/azEB05o1FyHRK0XZ52fNtI5sdPkJ1ADxnX1WAFGWjjY3
 IsE8DHaD1qjIGgA32/CL+SYXeaNWfYRRp/g3Lo8raeMacnRraTlm1mfkuDi8/fF7cQD4pV0uQiw
 fJ2kbzKUpcGxyvvis4rWTyd3IT3bBoRx6P/sRwqOowlP5VGcE7s7EGo7VKX1udSC5GArILcLhOD
 hzln+3yavvAGhSgjeS3+lz6ZAPJ9vWoKM6xNGEAgpgLxSm0ZpoVq5gbEFXxPAt0B8V1wWqndxv8
 C2rFnVA+zHg8O2IU9iSEgC3AtiQ8rzSST/bDEvDMAxquQgRxkKkuGno9xQlUVusGoiWXHbm/P+c
 U2q6xhAggGw6pJbcqZA==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5169bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=-FtdqLbzwS2V55xVmDUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: QhIXP_0YdvCRF8R_KmoBS7N1eBKTJIw9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8aQJCxebUqX0
 7mHFMxAnQJYgrSjlX0bvgLonCbDH1GL4pSEYKovOgs3YXq/1dbOSd3mzeR4eNlOpc4PqZjxEpZS
 JO4hxDMoc013cRuS/B29acKag7LCcjQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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
2.47.3


