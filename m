Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2E6C5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY5-0003EK-Jj; Tue, 18 Aug 2026 15:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXw-0002zP-3z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXt-0000Fs-60
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1Pn1872769
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c2AaCDmP4t6
 W0JbAQFaB23LPy0Z1gk73QCKx3GL437g=; b=APv77ztTSabGRZPuOyuECTIx1fm
 V+jeOC6T9hAz/ohxGxQY+xdFC+PYCg/twhlDio/sBSpjxnRmnc8buE8Bc91KTJc6
 Rxb3yV5t2fMqUQT33ncZ1ehIYDxG2bZTIF49ZK6ouspFk54BvlnbOAL//SXAeUmg
 UDo75BiErfJgoyAMKde2JIWo0fDhAO/H2LR58RMVuxQXhi5/Hzf8I4A6Yf3Fx3tl
 0/WsC3BCRnstGbJIISadE8jpQxS/GVtAFU5CVO7f0eZ2Z39RxfkY2cRM5QaJZ1v+
 V+nwXfgl9gU4AjPmmVmVuEGS86srOXw4gONjizX32mWX1f6yYpH1MeWkKIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1ah7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso221203a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081543; x=1787686343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c2AaCDmP4t6W0JbAQFaB23LPy0Z1gk73QCKx3GL437g=;
 b=QFFQZlGMHbnFPPKCGBsLPzwPYyMdsAZo1xv+vKABbrePiT9sMrZuVIIMDtTp/QNaql
 YLKkJgePnzXvWpFEprh5MioJlZ5zgwJZhii5olTtYIzVum7CBmMdkme3IiNIPwHtDnEH
 oLcz7KwSPOiDX4dEUr28dlap/AifbRTxwASawMx+iEQYOKeD5f/T7Vmf99DEKB1HSBjt
 TFxmNDZ+dvOK9g3YRnSkDufUgNFFd8ewXz4J2KWF3xNvp3lVFNhDkYvmp2o5dy6JZOzd
 ssIK8r5SFnm5FR7N8F8TIyCwJ41kl6/xi3qSRD/wF12IehDVTp9/G4gVzPgWZe2fnQUE
 EfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081543; x=1787686343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c2AaCDmP4t6W0JbAQFaB23LPy0Z1gk73QCKx3GL437g=;
 b=izwAaYzpd9uWk8FVZmpYpvzRW8Nr3upid6euRA8OeHxa6/5m5wlABZ6/xlz/cniDCk
 fXEksNNmbMVEbI0hclNtOtjpDTCNh38MpnF+cWObL2uB33vOIZ2c3D8lIEjX41eXIvVg
 KPTGCedbX53akTcbJsJhwviFXTs3j0fDGa/4ORLERE1ofqC1Rsxnj+8dyZpVY7dL7Ldb
 Vo2HTWzjYYtoB47MXaUdDiKVYxvI+AWP6rAKtCyQg5xr5w/Wd6PkSPtZ9+vzz9aIclxy
 R/c8k+w86iApEsv+o1tEh2Xq7CL50X5ZeRLZys4yr6tXrZafqgat/x7/i9GaOQIjoPGX
 fx1g==
X-Gm-Message-State: AOJu0YxEnxgjgHyEQT0b30jTrYRLxzfEpUlEy0WsHH82uUiRrmn4Xa6c
 v9zvv3hwFA/W39G3FheWQv/QNbYFwOEHZk6XQXUQqrYM8gapJM9wymku1h4uiVS2/kzjaONIgwx
 4qN8x/akFzP9XWV/+VFCG7KGb4yI+DuHaGUxm00CfzseTPsDgSp3pSYQimLYPoLe8dg==
X-Gm-Gg: AR+sD12lEE7eTHdIu8STiKR/WbjNJNQqiToT8GWtxyfLB4zOoVRRAxGTnmJUpLrUugx
 9ahzW0lJ9n5GPJKONhZeWIxSu0KgpXXeH0eSSgwDjBDqLHAFqpRP4XI4yN5tx4LfEGwRlP2CUX8
 QNrSOgBT1z+m0lmuxgaRRuZBg7iNhI44zS9mXH1d0nvyTbKULenq72lHcVF+qB3FaO6/s9jnuef
 ftFogNMUTyc0YpvZrFwWQ4S7KUvE0vDdDQIif0VcCXTqokJAPF+FK4i6bsF+ykOICpuPJziMqrO
 xOKO55cueqYuQo4/t0WoS1ANahsYO6s75eNMPG2oKkckKwleoGepi0xBeuQGVnxPa+r6WmUWCgO
 AgPyg5vdYSnvp5oH+GZH24go+DNiUbXU1Z5RK3Ic6a51v9AO8xK0PEoP3A5Y=
X-Received: by 2002:a05:6a20:9c86:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3ccff62d2e1mr109046637.10.1787081543050; 
 Tue, 18 Aug 2026 12:32:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c86:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3ccff62d2e1mr108954637.10.1787081542621; 
 Tue, 18 Aug 2026 12:32:22 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 085/104] tests/tcg/s390x/console.c: directly implement
 memcpy and memset
Date: Tue, 18 Aug 2026 19:22:49 +0000
Message-ID: <20260818192309.22169-86-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX87fP60IjKwK2
 wxaCrTn8tJlksP8E1okzokaVYwgOCHqbLunDppGg+72CEjdQL67uT+r/6HtZg2lQSgfBXenPg9Z
 ts1Q90omQVDI1GjWSfxkNIFmWbwPgVll09XbLZ5BEdtZQlcXGq20Detth9gciLK6WWKexFmJoh+
 x5pf5f1tnr6A/I00xdM/IywfBzkCqcKWuOegnqiweR5EQuTeOja6OMDnj9Wt9Gj6M0PY2zqWfDy
 vzo5/yPS9koyTgPf8J2r6jq++SXzlU4CjDBLwIwOTSfWziuSjlp4+71vDHOF+PihKRCD6E5lKZA
 0lr+5PMwH7Lkd1LG2pvOmevzfTLBh3A/dKLfNbz11r2C72khXeXhdSW0G+m99lP9DdKAm+vC0Ya
 qk+ERiAu7OfMPE0oK8FUA4cez0xXKTvQa7iuGElrkKLzA+F/8sKsjtmzRMFMFAnxYA2u5zN2FLU
 zdHksLbrKIbsFKA90OA==
X-Proofpoint-GUID: kleknBvCn9hDLFrmthIdQjbbH5Zdwo4K
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b348 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=-FtdqLbzwS2V55xVmDUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: kleknBvCn9hDLFrmthIdQjbbH5Zdwo4K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/MQxBarOo8g4
 BisEhBRCOmY+51qJFyGyJHx3+NU86gghLEvNyDJaLXrZy8ld5lzAmRDQMhjLTyhrXhEFfDVTrLE
 8+xJKWsRA0AwLTI1VDhTbd/HNq6KPyM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


