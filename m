Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1E606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nnSvFUkd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hB3PA0Wb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0Y-00015C-RK; Fri, 23 Oct 2026 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0O-0000Ou-61
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0M-0002wu-2p
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vNb4072851
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7OTaslLjMUl6opt5MVd7zI/TFoC/bM7dDwz3gIXPm34=; b=nnSvFUkdp9GKWnEo
 etx99u6zHQTCvD9VaS7BOmiskaMhybDiD4EQFRysZBlin4+gtJLiDORXlyMIi6Vh
 O9ImdSjPwbIlkiD756ylY7U85ul6dv2/pQfF3TCIVG2nXqKtqHb6R4tOSb85dcDv
 cn6M0PP+Atf2TFD0JmcBWOObayfLBvEaZtOJAfkI8KXgUIOwGdFTJkgxIMefML7c
 fdZ6seMWsSWqFkWs1zZ6uk+Fxi2zIEK9Xq/rAVR11RlaQN2YdHcHVeS8fks5JLmy
 miyADVG9+2JbP6Yni9ByfcmUVDYj4WuxMlR6feoNIz3hNRtyhWNuV/E3qfffIKB9
 CjlZgA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0xgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb98809caso182477985a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772427; x=1793377227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7OTaslLjMUl6opt5MVd7zI/TFoC/bM7dDwz3gIXPm34=;
 b=hB3PA0Wb8bTnI3blaehEyFzneDpkFZuDiOgwptkzyoDRonntbZnuMb/claN30S7E4Q
 SL8JtQl5ApZy3HT3JEhfP65Qsg8lBBd9Mcfg54CTAGZZ6qCGsza8TqPoqQsdviiJlpoK
 tmhtfDBmeLUwftzay0YQsya2hk5fuG6aBCz6/OMLrIdDjlkL9gZeOTRjTUBHFFY0NJB+
 O52kNDhnEd7gGyq6n1BKskwHwqzjQgUrMEPLXqYcX+4sppjdvCeSttadToETFPcglGdw
 Uw44vHHuaQascUNJqhA7iT0O7bTVkBr0ZY8xckiI4sKHNvUN2oaZB2ze6u0npo3QLaRU
 xYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772427; x=1793377227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7OTaslLjMUl6opt5MVd7zI/TFoC/bM7dDwz3gIXPm34=;
 b=T5hFPdIepsCwSzygaOrF+CzvzU1medPP3ycXaAAi3sKgx/4i8Yz3KxJHvgSy1iOVjm
 ChZmCqBvbTVf7mYHVopESGrIi/Nl/9ZoqWhFFvKHos3eaQcZoeE+JOJ7CgXJ9YB+lW6s
 b0j0AlNf09k8Y5ayCqlIUiA2Z6nhv2DDNLHTm1j97uZpth1NHSSWdJZNm4am0I+G3kQB
 dw80qXZb493nvQLIRBGZIjUNMwo1VhlEG5q2DhGXkyvxAhPXCcnaMNcbnboslTky8aJ9
 PUHbp4h/DdalPgaXYu57G0XcUlMKdt0e06vneDXmw41Qe386K0N91vFbLKGZ1+TOSQqt
 1HYw==
X-Gm-Message-State: AFq9FYK8ZLmbIUrj7sMvU7mu9PQfwOoqRlKJA3KR0sux+fM2tUMFz+/s
 WzDguiIRtrpGLHhMf8KZ465q/ssN8HZ22fJQzLgbnWbG9NbSHMrdyhU3+GyzjRQZIDc2ztFae7I
 wCrp8X9PWSBvfcDnCIISO+5rZn5LWx7VBuNSTuJtib9nBDdWEzDG4FN8n/QQto7e8XHNI
X-Gm-Gg: AYBFou1roEd4QlpgeQ0Ce9a21wrV/nUk9MqFNQNStzoCNz7kqnbBydhw84YbTEDJZD+
 YcMCHeG+YdY9GD5skGrSG4et9y1Sr0kxfYsC8xO/wnv2ornXX5YNVp3vATQXcaDf5COqCgOjg5s
 V4cA84xHrVNn5/qCAM++8+Ccr+oBe60urs4o4+T/huwul388eCJ7GJg64UUtcL06aLV25pi/bFK
 K24YOt+YdQUwfVUcMUw1dQuGb8xSO94px04pY6lq7MNwXldtpS9hoyWsLJnMA2VsAultEYtWe4Q
 /WvsKvMboAE2eRmFRvJ5A/PfC5GenaZA6M/YAgpTInIFrF5C6KTKYSUdGjX/2HS4U7hKkUZ6NDR
 7DEJQgPPuwig3ESGH9mELLUsaaoxHo3PoQh0yJ5UH
X-Received: by 2002:a05:620a:198a:b0:93c:735c:2477 with SMTP id
 af79cd13be357-93f6f78718amr497437885a.21.1792772426580; 
 Fri, 23 Oct 2026 09:20:26 -0700 (PDT)
X-Received: by 2002:a05:620a:198a:b0:93c:735c:2477 with SMTP id
 af79cd13be357-93f6f78718amr497431985a.21.1792772425983; 
 Fri, 23 Oct 2026 09:20:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee6b2sm641212f8f.13.2026.10.23.09.20.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/83] target/tricore: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:05 +0200
Message-ID: <20261023161332.60153-58-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S6q-Sla3y9IIriJG8-N0BUNZL3TIeuBC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX6qAp/o4VFo/0
 w15x7ZlK+hIuyHEXDuR62sikQXzFAe4/RcVzaYoGAJexnLNQBuLuCdnZBqJFsWJ+9wD+vJq7zP0
 rM2H8i65a9L49/buLXQG+ALrLMDmZDo=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb894b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RLtJ85U6kMftc6pV0xwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: S6q-Sla3y9IIriJG8-N0BUNZL3TIeuBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX2iRpoPg1pOh7
 JonYnfwOpgg0acyKitBN3VkFwgIQDEFz5El1woblumKdxZJ5id1pAuRsS6557Y4ItJhuho+NYZX
 zuXR1gvGOh15MukGLZ+frKYoDdoXt2OZKk+YKqzuguUrQ3CHFWT+KGcmb95uAWLs4xV3QvhUTdn
 +Bvofs41tKwavmnbSeDJMAd63PrKHSYz7OV2aNA7WucNk0dQCHRAsHNqrXwVljl25HEMX7FugBx
 S+fz4nnKz3KfMG7qY0ZUstCcuOHwVfDhVxkVguHw3Y6/vxMoO2XybHGCzWuiBoEWt3eEqdeho0L
 MgFhBx5tWm3rVwFrqkK3iWr9L/qfPwA+OmB6uq00MDmEpjNts4gXfPhtOYSeliLlG4zVH70Uhlb
 g4xWUVu+cTA1ykcU96TtnTn9refdfqmuMk8JJa7a0GU8kKJ/ugI2Arkvg+YLWvuVzYQwdD3uTj7
 XBbkYgZosvkAFEuphBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert tricore to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261020122752.3651914-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/tricore/cpu.h    |  3 ++-
 target/tricore/cpu.c    |  2 +-
 target/tricore/helper.c | 13 ++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 12e497d2a7a..17e3d1fe804 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -79,7 +79,8 @@ struct TriCoreCPUClass {
     ResettablePhases parent_phases;
 };
 
-hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool tricore_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                     TranslateForDebugResult *result);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 FIELD(PCXI, PCPN_13, 24, 8)
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 82b56c3cd56..fa782f82f00 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -207,7 +207,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
     .has_work = tricore_cpu_has_work,
-    .get_phys_addr_debug = tricore_cpu_get_phys_addr_debug,
+    .translate_for_debug = tricore_cpu_translate_for_debug,
 };
 
 static const TCGCPUOps tricore_tcg_ops = {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 273713a1473..9cc80b14c8c 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -47,7 +47,8 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
     return ret;
 }
 
-hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool tricore_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                     TranslateForDebugResult *result)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     hwaddr phys_addr;
@@ -56,9 +57,15 @@ hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(&cpu->env, &phys_addr, &prot, addr,
                              MMU_DATA_LOAD, mmu_idx)) {
-        return -1;
+        return false;
     }
-    return phys_addr;
+
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 /* TODO: Add exception support */
-- 
2.55.0


