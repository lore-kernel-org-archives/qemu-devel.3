Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29ACD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZJA-0004ub-7q; Tue, 16 Jun 2026 15:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIt-0004YV-CD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIr-00053W-SE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOe2E303370
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PzGuDivMFQvrcrfSgzBoX4ZsCu+rODkQK0sz1jfhVNQ=; b=mrnC8CZgYY+HmBOS
 8NVF5Zs5paI6r0D8g+7YwoiKTk7XgKmbzSSJV5d+C3k/floxXheh0PKJB3EWTIwr
 KaiktwgGoSyfuVZksSIb8AWIsaC4y4ov1gueHuukNSU/ARdcYbLaLAYFCurRP+Ea
 wzwY6SFf6ZWHogRzQrvRQNCfxkfkBMicsbPb/sMnq8pHM3jnSIqn0BpcnYkhjK8X
 V/se5A2TBRNrIvP4vGUW48mPNAc0S4z/K9atOtMAelfh288gfuIyVd+QOhdalAE2
 WsKIuoHkGc8KL36WsQ8zE49XQRRTt4csRTgXV6Bg1Ut1MS0tle43qpVQq0erg0lZ
 Z65p2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epbdff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915f7c37734so1055861885a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637508; x=1782242308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzGuDivMFQvrcrfSgzBoX4ZsCu+rODkQK0sz1jfhVNQ=;
 b=bo8GL/3jGhU23/t3wmzgI+L9nrXggGI46u9qrnr4YGu7uo4VcvKrdhDIJpWUhIoOd6
 tqrS7WGDj3HWi6KBxelCFpg/Oy0gKu3YUD/rkl5MTKKlBEAKdPnIo8+1PQ1ogJCEbvzO
 dGzLyhGp3K2pEvvyRXYxRz+yXTlLSsDcY5n6no8TAvs9gsMksks2ZoSAh3aHeYE+0NIq
 IsiLA3uerg5vlH/jMzBfMJEjtPukRTRbPR5Gmk1gbugRqOezjNj/cYc6XzGCPcjcmLTX
 Z5S2gKIUEnoDgbJMoN1Kbo5c4RDBI4S5GJbzOUNn4e6W6itffZbKWbmqYq54HPqkfD7t
 FLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637508; x=1782242308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PzGuDivMFQvrcrfSgzBoX4ZsCu+rODkQK0sz1jfhVNQ=;
 b=OXqpJGiCITSksY56n65wC2QvkFK0fHhy7LViPiyfMuEmxxD78AwK10DY2bz/MWFkg9
 DAeX0/QF0R5LSLXxazAnbhtNRzgdihqmj3Xpje1YvBApQV2Tt5NpthR/3HdFO16S9F5b
 axTgB2jiJsn/IS0YaygTjIrVA6+AfvEqn+FDQgGeE7dgAuJEEm/d9yo82SrugQsbVCyf
 nAN+KNeVWPgMABBFTWfxIsUi0o6RhilZYoREXFKgb6DKNSq4Y5W9pSCxYQ82T+xSTJva
 h3x3644KtWvndo6w9bJB6/dhkELf1E522Bg4KnMyByOd2Eh1rsrusKbAbpQYL6Bq3maz
 3LuQ==
X-Gm-Message-State: AOJu0YzKBbo//5PcSX8M0tNyreKIXWnZJvqpidskVe04a8KEl4G4q80U
 hVCLXiXn75VeTj3fHkZjk7W3hRGNdyQfo3CHJ23m+XQSuisU3TyM0tc/B0aEO3sDd7tyykLFaRk
 /fKsXnWysgdmqwQKJ3KJJadPE4nSxyKFgd14kGfYPlwUT7XKjQFkBhBjO8xLc+zsaow==
X-Gm-Gg: Acq92OEmPwQGpNwDSYve044J3XIzbys62kOplwkTPtdKNFx6BfqNS8U6FioyB63lg/G
 O7Zi3T9t+74Qe8Xb489lRrAc098rCNpzWnSYgZ4JOlw4S5kwo6VxD+5F2PYxJcOqHStOEDFJWIW
 GDB92g59teH0A7c/xrxYxXgLQ629g0FnsGfY/ZwQuLXo+YLVPyCzGgKiXCNyBnBKHIlMtGM6u7/
 cyRUxWmJu9u0/p5mVftp3MRQ9jWN3PfgYWwY1qxtzo2YwDoweApwPwwSoYIajXOmoyXxnl2IYtG
 JVBrlgienLEDb83YlCmcnnSU9Dmj02hRCNn9Tn/27/4afdvFEhmGAPjhMgwWlM/iU6kK4gNhLAu
 B87s6pgq8QYMi+RNV9Dn3smtu4vIqyWaxu1VB7tIwdP2tzROhnjBrCpehF/lO+YlVMVhXirjlTu
 OdqJc=
X-Received: by 2002:a05:620a:4109:b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-91d8afcb0bemr175607685a.33.1781637508208; 
 Tue, 16 Jun 2026 12:18:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-91d8afcb0bemr175602885a.33.1781637507777; 
 Tue, 16 Jun 2026 12:18:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa8b423sm99732205e9.11.2026.06.16.12.18.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:18:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 10/10] accel/tcg: Restrict headers being TCG specific
Date: Tue, 16 Jun 2026 21:17:16 +0200
Message-ID: <20260616191716.12932-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31a184 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RUGg7TPni0CDwnB1NisA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NyBTYWx0ZWRfX6SSoSdQaXR/W
 UMlSda++fd6AkUvGBfLDXnhwAYexbzVl8VTbUtwd7tJq+jaia6rYMGchN8I3MzoA37KYoQFXRMM
 BFYCeWh9dVdtwGE7YGDgz+n9nkQnqlU=
X-Proofpoint-ORIG-GUID: hK7pkhBD4nXL3Ik2KShxMfcTWL0IXrSR
X-Proofpoint-GUID: hK7pkhBD4nXL3Ik2KShxMfcTWL0IXrSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NyBTYWx0ZWRfX9AI6VyoSwNr4
 S+yGePXLED6MPYGK4X862xVCdkSf3UjW4aw+sIrszUr/hQwEMs8HOP4jS8wrJg8QlSqBSrYCSNG
 4jdI58ISsuSClH/+7oUpw+IpLHkGseecMnExY3HgGGvgK6ne9BTDOuOJbV3rvEfaZcXMbdiWbQX
 PZNiMnLICMVG3YVp8wOrB715If/Ih1WK1UVhfedxpi2sHCyxYkJt+I5ubijAAp9bf+2SefPnfov
 YFTVv7tEiBoM3+lwMxjSl/adSFhz70D+O1orezCsQujRcj6+IK3lpexJFn+1VR2CpChmm8cIUKB
 ffv/4dvhhTXVdKcIGOqNiId3tb4GjQctd6eNaD12nBNOp5UbDdg9JXIKheqKZ5SlTOrYOqKJy7N
 7/yn/uEjYhWxPzUvMX3zg82goC82FMqGOpoghVjckKxZZ5enCF3EeqknOwkTz9qWUsjIjrfF3qi
 o1OKbxQxixDs9dAZH2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160197
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

Forbid including TCG-specific headers in non-TCG builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-mmu-index.h  | 4 ++++
 include/accel/tcg/cpu-ops.h        | 4 ++++
 include/accel/tcg/getpc.h          | 4 ++++
 include/accel/tcg/helper-retaddr.h | 4 ++++
 include/accel/tcg/probe.h          | 4 ++++
 include/accel/tcg/tb-cpu-state.h   | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index e681a90844c..e0fb6ef91c8 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -9,6 +9,10 @@
 #ifndef ACCEL_TCG_CPU_MMU_INDEX_H
 #define ACCEL_TCG_CPU_MMU_INDEX_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..710da12b828 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -10,6 +10,10 @@
 #ifndef TCG_CPU_OPS_H
 #define TCG_CPU_OPS_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 0fc08addcf3..8a97ce34e76 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -8,6 +8,10 @@
 #ifndef ACCEL_TCG_GETPC_H
 #define ACCEL_TCG_GETPC_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #ifdef CONFIG_TCG_INTERPRETER
 extern __thread uintptr_t tci_tb_ptr;
diff --git a/include/accel/tcg/helper-retaddr.h b/include/accel/tcg/helper-retaddr.h
index 037fda2b83d..ebdc8b378d4 100644
--- a/include/accel/tcg/helper-retaddr.h
+++ b/include/accel/tcg/helper-retaddr.h
@@ -6,6 +6,10 @@
 #ifndef ACCEL_TCG_HELPER_RETADDR_H
 #define ACCEL_TCG_HELPER_RETADDR_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 /*
  * For user-only, helpers that use guest to host address translation
  * must protect the actual host memory access by recording 'retaddr'
diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index dd9ecbbdf11..0b788901ba0 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -7,6 +7,10 @@
 #ifndef ACCEL_TCG_PROBE_H
 #define ACCEL_TCG_PROBE_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
 
diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
index 8f912900ca6..1903af4c2a2 100644
--- a/include/accel/tcg/tb-cpu-state.h
+++ b/include/accel/tcg/tb-cpu-state.h
@@ -6,6 +6,10 @@
 #ifndef EXEC_TB_CPU_STATE_H
 #define EXEC_TB_CPU_STATE_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/vaddr.h"
 
 typedef struct TCGTBCPUState {
-- 
2.53.0


