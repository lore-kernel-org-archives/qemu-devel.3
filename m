Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5301AC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbj-0002uz-Rj; Tue, 30 Jun 2026 18:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZK-0005J3-EJ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZD-0004RU-AS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDc3V2920057
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kxaj7fpgNv8IGwzoF4MRlr4aYlGXFkG9O6uvFK55Lmo=; b=G7liW+w/QBpZVtFW
 1recrgGQWkM1whaGtR975WZKz+mLXZuQwY9bDNza94u+d3V31rHUjQ9TcFgA11Ty
 9Yk1Hqmb+cLQfGSWNvpytSL7rX15X5odlFIJtRv+tu034xOgDPNEgz+dS8/lt/b9
 +r9e6mwKACXEZ03cXkTnzQ2MgASdba8qkVdYdkY857D0CG+nD45DUBYnnt5yJB7y
 3ybMZkxQftcygDJzx2WNueWXeU3Z6FIrqWYr7QAMGUIloI5lzWQxqeNNp8SHNpWo
 ktLga8vSbID7+wfYi7UYFtANT20PO/LXipHiI67h8fSC54dYzsfciHXMLIkznQpt
 Jd5EfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8uky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e52306621so445981085a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857060; x=1783461860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kxaj7fpgNv8IGwzoF4MRlr4aYlGXFkG9O6uvFK55Lmo=;
 b=Ci3qoMVPg8WHyeM9NItE7q+zWqCqyHdyZpEei0NLK2XINKvTZBxBsidmOC3Xv5YiyT
 gWVoU/fxTCWELJizKc0WdxnvsWrWkif6yUyatYrpdcBIZWGdFpx1gW+1i0aUgQqWMdOe
 9bOgQB0caCwUtN1k6JaMoVLi1lCdWf0My2AhAVh+aqjNQ85xAT8GcLiaJa9RjXwFLL1L
 7R14Z0i2v4wQyxXAZXrUMfovG59VK5rAs/FeiJnnI5MTU1JfuVw0SgIvoU1oJYVDqFJE
 wD4W+/SAeYV8CSRtUJYsyWuFXK0YbMMuniOPCuYkC4UXWune/rBSIJSpQDFsmDRo2O8W
 6TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857060; x=1783461860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kxaj7fpgNv8IGwzoF4MRlr4aYlGXFkG9O6uvFK55Lmo=;
 b=GnDYzTEQ9xT9ugAtYUcSlkYicSrJBXHSjVAvTd/wAWC5bg4qwsP164Q65NtZ6nWeSV
 7QTfu3rNUtZJ0EZtInjHwKjbFJIqVZ58wmjnXZra0ZE6Ozqatc8ueLNIZjX4E3thhdt7
 vGYMe1kWR/BKszKwwmJwhoPchIvzFnvFs27gBJKNFvgGJa2GBu8w+APSzFHhuHgJ5+ZU
 P4ixB1Oj2EAZ4xPU3D+29Sb9y6BcRsQ8npZtYtOXKS5DKC0VOUS5js8es0hYhA98mynk
 urKnyUja5M8Km9BxNn5LtyOwMAdSwsPACjawF21efX/XeOdn00f9BzQIGl+PevZapRaO
 0IKA==
X-Gm-Message-State: AOJu0YyXmMbeBn+gruJsil+o5IjXH/LBHrpWPRnebvxZWfQyP94H9J1/
 Y3I96dhcezMIRBdf3NkD3Lbf2k4e6kq8CRfnl0QI1OXQbqp+NDNX3stHaTvqgY/9Hz7L4XunyTu
 fZqERgTfF+FY/bsRc/jbBSAQE7CL6erdt+FgfV6yuss7pdLOIsZr5ciZuBHpdqkhwTQ==
X-Gm-Gg: AfdE7cn8/rCvGostyJUfSb+xmbqLqd3UQ3HeHOmYOBu03ef5WYAczkIcai+L+DMVZY/
 djxAfUCNpJ7FzCgsUUQqESZW/Md2G6R2iY51JKm/HmEF5YkH6E5psNrDSHjJeMlRSfXqwevPBSi
 oYYIUjmExUdXXzmw0WAVmyKePcwaBe3oL/jKAJvWIMx4jScNEoo25qiuiFr/EFc41bigvQKQQmx
 UDR/bVqG91CV1OJid9zrTYATfngaX6X1nDvrVXmZrDbvsJB54w5pdqYr7p2GZ+m51p/0K85afq1
 9Dgrte/uJw9hby7MXRivg3tR+Oba16aXqQAzJmpeEytGp19BRM/zJFsFJLohiSqS7angw+psSmQ
 kAhSuetAi+bJMWgvlGO2vLssVmjRpTZnFcyrSOMfhli0RzRZb0rG8wHJJNUzCppxv+SgP
X-Received: by 2002:a05:620a:4411:b0:92e:6c8a:2a1a with SMTP id
 af79cd13be357-92e6c8a3c36mr434431985a.7.1782857059415; 
 Tue, 30 Jun 2026 15:04:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4411:b0:92e:6c8a:2a1a with SMTP id
 af79cd13be357-92e6c8a3c36mr434427285a.7.1782857058967; 
 Tue, 30 Jun 2026 15:04:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe616f5sm4295345e9.1.2026.06.30.15.04.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 26/33] target/xtensa: Move watchpoints handling to
 check_hw_watchpoints()
Date: Wed,  1 Jul 2026 00:00:53 +0200
Message-ID: <20260630220100.1289-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BV3ybp878TcUvF1RjYLWA51fybFskwTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX397g+OVj+KCn
 Pd4Mf8T3nUwNv9rmwda+rKL7f/tGmtKDzWyZsTGtxYEdX5Q9Kpbjro4ZXVzDN4cnghoi9eHx1Jl
 VQHV84xhpxOBtHAx+GAEvqUdVocczBc=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a443d64 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=OabgTiWiKDF5Aaswr54A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: BV3ybp878TcUvF1RjYLWA51fybFskwTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX1G20Z8xPwbSm
 5s/xu5sCF1jLqbAek1Sb2t44RQQ6z6U1eYrQ0Gm+VkioEI7ZJSfcebOetcTNvPdZ6t3GFjNz46n
 UmouIMTXaDDWzxuXMX2aZrvgPm50DjkGraVTzR1trOI9rSoRttU+/ELDzcrjizJzyLTvrTDvoCN
 9Wa9M/I/KGP1UaTWTKU1kSm99HwP9I6SJM42vnCWsIHWcl9K3qG3X7Ca7JQgAWzAOfF6pMQcZpM
 m1bhCVfIXS6Dyt6vnBfPTJwbI34G8ObJJaQz1cSIhi+Kw3MqwpAy8NYauNvkRuFPMldVvazJ1GU
 eEy2Ar0FwKsfUlQHAr/1Vbd+kWxAjtlFH0UqOMOGAhn2d8hXRexXCVLfDcLECn7wKxxqHy8HaPd
 NkEajiZq5ue8NVljOfdamfJZPhr5V3K6G5EsIcUP3/KacELXBr96vewdpAngqSJ9SZF+BfdzJc+
 YbLcg4y2bIdsRNoWIFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300215
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rewrite check_hw_watchpoints() by moving related code from
xtensa_breakpoint_handler() to it. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/xtensa/helper.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5a0e8655146..7674a7c1d55 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "exec/watchpoint.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-loop.h"
@@ -205,35 +206,36 @@ void xtensa_register_core(XtensaConfigList *node)
     g_free((gpointer)type.name);
 }
 
-static uint32_t check_hw_breakpoints(CPUXtensaState *env)
+static bool check_hw_watchpoints(CPUState *cs)
 {
-    unsigned i;
+    CPUXtensaState *env = cpu_env(cs);
+    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
 
-    for (i = 0; i < env->config->ndbreak; ++i) {
+    if (!wp_hit || !(wp_hit->flags & BP_CPU)) {
+        return false;
+    }
+    cs->watchpoint_hit = NULL;
+    for (int i = 0; i < env->config->ndbreak; ++i) {
         if (env->cpu_watchpoint[i] &&
                 env->cpu_watchpoint[i]->flags & BP_WATCHPOINT_HIT) {
-            return DEBUGCAUSE_DB | (i << DEBUGCAUSE_DBNUM_SHIFT);
+
+            uint32_t cause = DEBUGCAUSE_DB | (i << DEBUGCAUSE_DBNUM_SHIFT);
+            if (cause) {
+                debug_exception_env(env, cause);
+                break;
+            }
         }
     }
-    return 0;
+    cpu_loop_exit_noexc(cs);
+
+    return true;
 }
 
 void xtensa_breakpoint_handler(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
 
-    if (cs->watchpoint_hit) {
-        if (cs->watchpoint_hit->flags & BP_CPU) {
-            uint32_t cause;
-
-            cs->watchpoint_hit = NULL;
-            cause = check_hw_breakpoints(env);
-            if (cause) {
-                debug_exception_env(env, cause);
-            }
-            cpu_loop_exit_noexc(cs);
-        }
-    } else {
+    if (!check_hw_watchpoints(cs)) {
         if (cpu_breakpoint_test(cs, env->pc, BP_GDB)
             || !cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
             return;
-- 
2.53.0


