Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D95606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m3FZKx0X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FR1t8vq9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwq-00009E-Cg; Fri, 23 Oct 2026 12:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwf-0008GW-Dt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwd-0002TH-Ky
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG41ik3812454
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rSufRW8IL9oHGgZz6rskBUHAejjjMBI5QxkbJDLqxfA=; b=m3FZKx0XSNv4dV7Y
 BlHk1nyImbpRiH1qKcZkCjHfmdpukiBzb+7kmOoUuR3G8KwAEwOOzdbdbtvsnSBO
 4L063iwPhdpHo6K0vqAQHhq0+m9Z46PMowBQck0K3/L+jpboSXx6Qbf+EcwLbJeY
 v8xL7m8VbWgymQZnLBQbo/5pAvbtMXB85e5qbnaP0JqqQ1IoboQAIRK6lRKC6Wl6
 MpKAkdbdaJwF7xAQxtDuMOQd9eyOx69x2bFKwRMiqNUfbHPQ2MLAQhisTQ8a3/8p
 hMJZllyXQdjVjs5Hhq9otycP+J3ChhLkCgB+SeY0R6XAH4HEgyo7XhohIoxhyBGo
 2332Qw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas881s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso166466485a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772198; x=1793376998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSufRW8IL9oHGgZz6rskBUHAejjjMBI5QxkbJDLqxfA=;
 b=FR1t8vq9qUE5ZeIJER6XEzgO+dPhEzftoAUm7n4kxWlj5YjylC9gTy1N+eyyUnkzeh
 RlutAqu3XVOxyv6409Td/DNhzn7gOBnIa5Os9F3apTJywdHSgKTqeLPajpuq9JLPV2Xl
 2XV4T9h++x+Bahp8Wxs/PAboDORRKlaxzhxRuL9Lf6NNt47a/Q9+h7ezDpf7Cbn0zIre
 iZpaDq29qvgSjkJc2Lt5y7Rtj//8oR8psPCRfbbuSyLqVJfAqejPnB9CA0onVa1MHqPO
 rrEgjQDBU+uclbdXuFI1yL3U0ad21D5jCUa84Rubyy0ZV4HoEdifIhAFnPvtrFvP7RAd
 fYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772198; x=1793376998;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rSufRW8IL9oHGgZz6rskBUHAejjjMBI5QxkbJDLqxfA=;
 b=AWXjN9KVZ8wWE3byLF0yteCsCPPggpfnHgc8ZbNaHbVpxVfegRtbLuB1H1xwDI7hva
 wr4DRlRlEippmFoob3gT6klBWwIf6G8AyCcvf3y9hcHsr39WfOZAItV1edTaR7gEUR0o
 bbsKFGr87Zta/hzH1ldcYg0OyhQbQJiQ+FwLEGBKIFNlpTnMvragVUHfR5ePslHv4W9R
 1nB/A6hCVc9bxhlBXS6ZoJiv2tBb/1GRMN7vfwsCEh2oTt50Fb1Jl6JEQsAVcZSiZm7R
 LV0JR6N/UBtK4S8DWAKI/baxPDjHA0IFX7IFaTqOLoHKQ+KHQ1xDP4kTplC1CROxlRdP
 v0Wg==
X-Gm-Message-State: AFq9FYLXZXWGW4+y6OXtQMMUY3hz1rQ7RQ4vClct2QYROnaWO0Esi2jy
 YsdpgDKzo1NP0FJhrf1L3ZlFfCzo4cibr4bOh+Xm7DcAqwc4SmkcydkMg401k9O4avB9Z9qn9bQ
 AEi7FbpdbBic6qaHARZe6GVIhNI9mHU6cRyirk2yLImLxr+xQq3A1nnrfSZQkNmcUBpRb
X-Gm-Gg: AYBFou3o7DD+/VaL6KKJ7V1wKGbq03CI4iP03vD9S8liNomgz3zUATJZRnmMt0x3M16
 dssSxWMiAFApMrhzbofG7j3ohmEe1eJkq2fLEzmsFIz3way0MYhdUFKNvi4fKpWK9KWzNObfJ6n
 iaD9U4NWKjLMeJ3KXuj0KD5oxhhMMPr/nfrXoBoG/PkQYEgHoNJ49AVcjMcylOI5Gz7UW9KyCK5
 GRFfNAMGIBRWEj3jq8GQbTl+cCc+xOvrwOh/+vaA55LVwqqwPh8/UJPTny6irA8UxUDB96hifcW
 FdGhpi9Z9YMk8rKmgKbpPX4X6yMiMTOUNoQvA+HoSjNmf2vZZMDhg5mwujSnxu+C5+BluOwcEIk
 IQ0JFBsip/DIymuc1xnb8njF/IFSYRtBzvgVbSm6x
X-Received: by 2002:a05:620a:2556:b0:93e:c12c:9dcc with SMTP id
 af79cd13be357-93f6fa004b0mr478462185a.76.1792772197947; 
 Fri, 23 Oct 2026 09:16:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2556:b0:93e:c12c:9dcc with SMTP id
 af79cd13be357-93f6fa004b0mr478457185a.76.1792772197361; 
 Fri, 23 Oct 2026 09:16:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312fd9574sm4115155e9.4.2026.10.23.09.16.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/83] target/alpha: Use a static table in
 alpha_exception_name()
Date: Fri, 23 Oct 2026 18:12:33 +0200
Message-ID: <20261023161332.60153-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX0DwwD3bu4HdM
 6pxONy++O+UyCp4IRUdVCIUm1yXUp6nN6yAXfXLHCus+KdQCk5sXwgpyyde5Fy31l4nWmqHpOZf
 ERmFQNQltlHnrgBBE8869LyvDqrXmqc=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb8866 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-Zoeorw8py2zlXck_4IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX01xhVpdRYv2C
 3YRSwp0jU1JAEd4NYRB3AtlJVq5ClOmkB1Cy67rNGSLRj6zEPyOK/kEH/4rVMwORBRxa5cAM7LV
 lLNL+gJCNhdFqg1gZA4sCoxU19rvvINEwKr9q7kwlKsuh9wEZogMCP3s6+i0ffHgGyH5blfivfl
 /2gCH6JcWCcngYqV9Rx0vbHrtnWinlajMj74Vq57R1D1+mJy2BufRJSDitXM4YKs6ebZgZVq+KN
 WWMr+nSDbDW8swBu37EZOoV6LeEPNttx7PDh+drzBZIc/D+Ogc7juD4TmD49YPn3rZDypl2h2UO
 4djHuPGRlRpIqm6xgGUNDR3AWaCKgk9P2FKRKeAIJmaxgbpluRPXUdz4kuxmtWlXGudLDlpML4r
 z5eYivqZ7dOBxFEyDJzsEL4ujC8ADXDLttM6emMr2QeQ4VvO8vYErxyP4Hi+WzzUUzgdcNSnnGM
 Jt7P+eBChkrxrl72kag==
X-Proofpoint-GUID: ra1xMEaD1_pTKA6CqhUgRW9fNUn74pcm
X-Proofpoint-ORIG-GUID: ra1xMEaD1_pTKA6CqhUgRW9fNUn74pcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the switch statement with a static lookup table.

With '-d int', unlisted exception codes are now logged as
"unknown" instead of "<unknown>".

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-7-philmd@oss.qualcomm.com>
---
 target/alpha/helper.c | 55 ++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index cedb0006892..84997ef3a99 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
@@ -37,47 +38,21 @@
 
 const char *alpha_exception_name(int excp)
 {
-    const char *name;
+    static const char * const excp_names[] = {
+        [EXCP_RESET]            = "reset",
+        [EXCP_MCHK]             = "mchk",
+        [EXCP_SMP_INTERRUPT]    = "smp_interrupt",
+        [EXCP_CLK_INTERRUPT]    = "clk_interrupt",
+        [EXCP_DEV_INTERRUPT]    = "dev_interrupt",
+        [EXCP_MMFAULT]          = "mmfault",
+        [EXCP_UNALIGN]          = "unalign",
+        [EXCP_OPCDEC]           = "opcdec",
+        [EXCP_ARITH]            = "arith",
+        [EXCP_FEN]              = "fen",
+        [EXCP_CALL_PAL]         = "call_pal",
+    };
 
-    switch (excp) {
-    case EXCP_RESET:
-        name = "reset";
-        break;
-    case EXCP_MCHK:
-        name = "mchk";
-        break;
-    case EXCP_SMP_INTERRUPT:
-        name = "smp_interrupt";
-        break;
-    case EXCP_CLK_INTERRUPT:
-        name = "clk_interrupt";
-        break;
-    case EXCP_DEV_INTERRUPT:
-        name = "dev_interrupt";
-        break;
-    case EXCP_MMFAULT:
-        name = "mmfault";
-        break;
-    case EXCP_UNALIGN:
-        name = "unalign";
-        break;
-    case EXCP_OPCDEC:
-        name = "opcdec";
-        break;
-    case EXCP_ARITH:
-        name = "arith";
-        break;
-    case EXCP_FEN:
-        name = "fen";
-        break;
-    case EXCP_CALL_PAL:
-        name = "call_pal";
-        break;
-    default:
-        name = "<unknown>";
-        break;
-    }
-    return name;
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
-- 
2.55.0


