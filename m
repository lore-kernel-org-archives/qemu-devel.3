Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D31C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lC-0005z5-GG; Fri, 10 Jul 2026 02:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lA-0005y9-Gv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4l9-00073T-0k
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n33T3802158
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ttltpq9AoLz
 NbhdQrUO1BAGAkzuMshSeFMcmlK5+oLo=; b=A5lCbIlwZPw0tD/AdXWm0E77vGY
 orlL7+MH2kuHFAg2SNmXGb2sPVEiuaZqJmwKBe5id34PWE6X9diVcEE8hYxRsoSn
 /WaYgHALQCDy0SeNZGrw6Dko4yHQiKZYUvVaIfG4Af57qalrchpH6nJbmoPl5pgk
 LyBpCvWPJGI4F2extjIa4qWjfxnIlnzzS/crFs3FGn2XOBpq49wzPzg4pWiD3N1E
 3qBhp9pirGz57Qg1WGTKCFG9B+4eMvzGwWWky7mSyvW64icLwBS97FnoLPvZBdDY
 JQE/zDkfcpj4ROFuZ3+mkvdE52WDSv3xa72rIBEjr3CQNJ6rbffJYe+FMRw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkpck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8486389f71cso790318b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665049; x=1784269849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ttltpq9AoLzNbhdQrUO1BAGAkzuMshSeFMcmlK5+oLo=;
 b=AGmU+YUJlTnFald1gKebPZ09DWiP2U48ukF0D/AE8yqJVITTmjEXk/wVTrR+dE/A4q
 c38qzOSbM/wGDZHN4apUv/DwHMQdWythkm5th1nhX88xwKOWOwY4D1IdUCgBxJBJrxJn
 tOJIK93KWwBu60/ZeTdBH+95ersi5wszc7SSDugrCtF/ND8IAoDasgi6q7ylo8EoxPrN
 qjSHQuHSJBNp5n6gAotAgygANLgEB+gMwsQtUvKfZ3GEl/Yc8dLvbLMS8FBa+/OtDwKg
 9SDEQY5gJYGd+iuWdmpIh5Zl7BOE1UO+eV29gPxHKicDGiq1u1TltkFrfQP48k67g6ko
 2ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665049; x=1784269849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ttltpq9AoLzNbhdQrUO1BAGAkzuMshSeFMcmlK5+oLo=;
 b=Ga9pTiauRzAXmMZwqi95Qz+Xwpwaz3azg679/CufsutYqddjT2P0YYlzg5EDL8P950
 vSnm4DROp5mXHhyrT/dNaIJ/3TGvGdZjrQxcpTGEXZ5S5Zy3fCp67jk6m6tCDeqARxpN
 gH6RM0OE1tjgywQV4gdbotiwm3x5bH3YdhniGFHT/46mhZ3RgMUs9jqULPW+PXSlepjS
 GOjRMh20DDw8sdN8AbmmK3ovFxPNh1vukvmjwa/bCH6MtqXa/TdUozYloTgInenNp9FZ
 zcDY2ejWjNTfcqSYuGMYZq6qswwdTfyjgVu40jSXp7OBPa2zt2azDQWJP2NKt5fbjfwU
 AS5g==
X-Gm-Message-State: AOJu0Yytf47Dwq4fUlUWIAzgDeAhHZWLX1SS2FqlzLvKHsUkniACfvsk
 HEI3+AeIdLzsAgUjm8KXbhyQODkBUfOG+8A/H1Oa0rSy17s6ARTwGEtvRjqjN7dgu7MFd0p/yMZ
 C6MaDFtCzynSRzN/qGmZU0prR1Ek0dHYe4Vjx1RBP9VK5FEYc0gJR3xEnpjay3PsvTA==
X-Gm-Gg: AfdE7cmJM6k3nEH5Siwe0dlMmGYOmk4i560ISKOWZqpfmiw1s1MSdJhdvOwcp6ZxCXY
 fKrpjb62ODXFkSXQJeyLzF17bjyWMNF7JT96ae6oE102CS2L/QYrXXjWjS0fISfiUex/Hu9NJQz
 88T/zygZWvmHEj+HB4CV/HLqd0PJ6/FCp2cPkhIJA03DmBaS3E7VWxwbRCdse0oEPJDbfc/gFZ6
 P2SuazYbFHkZgjyBSmbYfB0waXwIS/BJJAoBO3vYB5UM+iuAdxLcibrCxrE034iKMj3uwLa5RsU
 BEmu+TUNPl5uMYay3JMQ6jv0etFDEwVEwt2CGl/QMDPi7JW/dRp6Ws3AMRf/pEvp02UjiRmbBO8
 zj0sCvE8YRMxfeMdIDwYbgTH4hs6J0uviOcXDM+nvnWWUpg3AxCbuRPEp2WcNB3kdWIwlSRodQR
 cuAHWVJA==
X-Received: by 2002:a05:6300:6713:b0:3bf:edfb:ef41 with SMTP id
 adf61e73a8af0-3c0bcbc03bamr13538282637.44.1783665048510; 
 Thu, 09 Jul 2026 23:30:48 -0700 (PDT)
X-Received: by 2002:a05:6300:6713:b0:3bf:edfb:ef41 with SMTP id
 adf61e73a8af0-3c0bcbc03bamr13538233637.44.1783665047821; 
 Thu, 09 Jul 2026 23:30:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:30:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 82/97] tests/tcg/s390x/console.c: directly implement memcpy
 and memset
Date: Thu,  9 Jul 2026 23:20:00 -0700
Message-ID: <20260710062016.1818125-83-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX8Wi13z43jFVm
 azCYLHcALxY2QgyrG4uWJUih0NnB2D8fTwIlEarIG//Vdmd9TzGMOFywSjgLYC4v1VMe/z64CKN
 206FVUUwLt169fRfE06J4HJ7Qv8jFcdrq/KhajkGb7uHaKPoXvufCBLGY9hl8OzHGIuka/myJZR
 OAD98RuQt7iAzTw+ybBx3Nt+QGpTklbokmRRfyZ78vckiOFBJrF1YBIrk2kzlN7EFkgTMS94rNi
 4l3MbbEF38AIOMn5wPNOvqODy7sDRRtMkPMR7lAl9vnBz+HbvIsJyJ9uHzouHDWH0Smwx1tJOJx
 Ovsiat+HsRzPwD/BWVhrTrfhM5yjJdGjt3U5LyqGvGX4te8PHMmBJgQS8cUuZG2KyyYRUoQcHa5
 zOn7CIwofEtBn2i4YfzBb4qDmNqJOO5daUhvgIryhQ5JdHvLsAk+RxCHRlAMoy6XRZpKeXfRprT
 EF3Zo/aCu7EB0WbI/Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX8R/QPKKzT4OH
 f/KiA8N3BT4Ovc7Rnw2J7lEdjUTlEzUfpduXFpzzaS8rDB6B8tKc0gFAbCwYz4kB5PyXjuq+9aN
 OudUKnc/3VNDHu6WUXLn8OKymDEkTB0=
X-Proofpoint-GUID: ApOEDW7CfwUPDOYWAuXLMdomIbt13d9V
X-Proofpoint-ORIG-GUID: ApOEDW7CfwUPDOYWAuXLMdomIbt13d9V
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a509199 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=-FtdqLbzwS2V55xVmDUA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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


