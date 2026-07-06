Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8754C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgX-0003o1-En; Mon, 06 Jul 2026 09:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgW-0003na-KD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgV-0006sq-3C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxL62218457
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f2XEj2PlllcBzQqnMQrbGx7gzvTWdi3R1nv6ZLolQOY=; b=fp7x5SXO9zdnp34X
 SNKs/0s3KtV8tz2FO7GjaJIPT8uiTCBolPbZ8C+uNTnkcvjgG7EXFqDJhHUFaaGb
 M97on/dDgWCNxLKIJiQyrWiG938rsBvElv6HuvgDhQ54n4DXmfqkjWN2ji92CCOJ
 f/yoxC9FgDrqN45+elJ3Aj1rRePjg8UqWzEsMhu3vqnPOnyhv13wi2gcXM99Hyu6
 Bwbsy3jphjYrpawP6DdIA0v5t1jjiOUmj19Te3i9YUc/Vqha/TYGt2DC46k7/N70
 J3lN8zc50FMNWDehe0RHYrig/u67gQpP7FEcbtOr1bTL39WGe+5excQsfSEKzTmb
 TFPYIQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs9cdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e55f0613cso238179585a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345709; x=1783950509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f2XEj2PlllcBzQqnMQrbGx7gzvTWdi3R1nv6ZLolQOY=;
 b=AKgPcxpIHSO0Da5UnE8uuvLS/yBaqh5BznDFoMu0SXqR5kBhVXRoKu1XLt2mNaW9yQ
 W0GBNxCt/npMRbynn+wMSNcoKNGW10TvDKUJd6wB/iGtJcXLXrlDZGEKZEaTr4rWajOj
 BOByhGRbCKJj2KOkSIEmQcuvyOKOvOmGdutqqQiaRsHBZEDc2rQ3bthWVr07dYC3a33c
 7cwGox0/ra6oi0uX7Bc1ai4mNHJXLgoLDxz6CR7htr5aip56Bg46oJ3AyQrQpjO/Yire
 7b3/X/7s9WXqKGXKCDJEIq6rrytAMTTZrNZUr1tkcqAhhnHrGaHn28SLVJWb+Imxw3/2
 c1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345709; x=1783950509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f2XEj2PlllcBzQqnMQrbGx7gzvTWdi3R1nv6ZLolQOY=;
 b=AVT/DZhnz/LtLMWRwKZT8bZ2va904SspxIE12oLlezYQK0Y7tM0VElVXU0QgetM8vO
 2Sx+gGhYCZg3ADluaiFNAPAkmsdbqDol4rdLbuLknqcAOEwhSPaOIVK5Vd65dUp/nfsd
 A68u3z3/31przLKLVEThNCeR57HETCvR1Tlvld5gmQ2vBp81sAtaKQkqzKteaIofiLOV
 EvWmDaRL2r8thL3OIaLNY0KN2MaG78tws8/piittagqItirCPABV8MvOmjb+ODK7XdEy
 dtT7hWq3kNPzmu2InuJGsiBgng9/C1DSLI2Y4yYN2mEdmFHfHpeEiS15ClBsidY9+zaa
 KlZA==
X-Gm-Message-State: AOJu0YwctG+6byQvxUcvZTdYp2qhjpmWM+O1qgao0l7PHiC8HD4hoHwm
 sdwVor6MrWdAC1vAZG023wMOL43zCjaWcuyXY+tqSCNgJqMYZ23IvkmxfCfSg0Z+jiUATDs6Nrj
 QE+nrLcizziLylXJ+wVQ1NOndLAp91IPIX0lUYTv7pCKd9jsF/PRcQiHkijvlbH8ePg==
X-Gm-Gg: AfdE7cnCjjcZaS2qQCZJoZtSkC1HfbCeGEq1CMg8a7lmAIf5EBgtkQhqQnp5MobMXeo
 DCDc4QaVLlr3lgDm4eebMbztQonwkTvPUY3quo/0lCYggrEddT/scjQDYP0/nOHVwNZsEtajZF1
 g8ibWH4jduqPYXkSQ12m9I13OiYouNoe50Ivt23SJVMVzBz30tDAR+iajUsg8pA3j4p00jRqCmM
 ITWdF9txBXO+a8+aU40kfb92TMXik4iitbaALvo+aKiC8Q7dEh/apywucOVcnsVBgkOAsHThBtp
 5Q/H5mDr/YexjdxOAwBfAUawNH+K/FfqAyjQdVxzZecUzqWvbtMFohC/Bugq0Jw/wR1Wpo+MpnK
 TuD/IOjoNgPpGW+LtoFz2sZpsla5nhw3gqZ3XR2jW6x+445IfvPr/reUjbw==
X-Received: by 2002:a05:620a:701a:b0:92e:6858:2ed1 with SMTP id
 af79cd13be357-92ebb58ecf8mr86669385a.53.1783345709384; 
 Mon, 06 Jul 2026 06:48:29 -0700 (PDT)
X-Received: by 2002:a05:620a:701a:b0:92e:6858:2ed1 with SMTP id
 af79cd13be357-92ebb58ecf8mr86663585a.53.1783345708632; 
 Mon, 06 Jul 2026 06:48:28 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdb566csm273752335e9.7.2026.07.06.06.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] cpu: Move cpu_breakpoint_test out of line
Date: Mon,  6 Jul 2026 15:45:14 +0200
Message-ID: <20260706134527.84808-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r0B5-wJf75JVIpplbeoZ2HQtDRHEOC7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5dkmkygSKyaD
 KahXRzQa0uHop3gsLSS76bKDB95SZtGkGqOGBoN8qqKTZfubcvSEZ312VJpVC/rwfisk70KxbPQ
 pMD5rLsic/3iewKPeKzXi11BJPAz3pqSfPlf4LAwB9ZWe8H9xxU7FiCreN9972HYsG3ruuUB9+e
 Am/NkCbKAKN/K162L47HH3z0qCslglexPxZcFUFrcAmIIDtn/gYBW9xsNQR93OE4kXTa3fjs4Y3
 dPrs9tDKyauopCcsv8rCZJ84YvLCqqe7Q34rKIf3BCJhzzJXRiFTt4VBMTdINYhnXnmKpRnh7yq
 5clhVP7sBfIE9dOZBX5naVqg73HUBmV2VQAFn7SKJWNsFd7Eb+GZTsgcQGYDjm2T39InZXt0FM9
 acOaL5WbvzrZ/2ne6KaHbAf/SX7AAJasV09Os1kVcgsOH9aTeEfI2JQnlDS1xtN2u5gb185aos9
 uHVsxMHtXQb1O10STKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8dtPaIqYiB+T
 VBRP1nMtG9Airc7Wl85kMSBwKOqHQPDfpY+oYhwqB4bnIVZwzEroSN+mgldWhrOsK8UG6v5x6yR
 7FYsZvXUEF7iXB5Sty8E3Zk6t67AR58=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bb22e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f0gnTpezwqI1Ju9rGxMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: r0B5-wJf75JVIpplbeoZ2HQtDRHEOC7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the function to cpu-common.c, with the other
breakpoint functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260705215729.62196-19-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 16 +---------------
 cpu-common.c          | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60a23d6f38b..31753f331fb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1157,21 +1157,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
-
-/* Return true if PC matches an installed breakpoint.  */
-static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
-{
-    CPUBreakpoint *bp;
-
-    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
-                return true;
-            }
-        }
-    }
-    return false;
-}
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
 
 /**
  * cpu_get_address_space:
diff --git a/cpu-common.c b/cpu-common.c
index 988d057d844..adb76b3a786 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -388,6 +388,21 @@ void process_queued_cpu_work(CPUState *cpu)
     qemu_cond_broadcast(&qemu_work_cond);
 }
 
+/* Return true if PC matches an installed breakpoint.  */
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
+{
+    CPUBreakpoint *bp;
+
+    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+            if (bp->pc == pc && (bp->flags & mask)) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint)
-- 
2.53.0


