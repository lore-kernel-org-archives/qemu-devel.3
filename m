Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB01CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBwT-0003ox-HB; Thu, 18 Jun 2026 08:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwR-0003j0-PN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwP-0001as-Sb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:55 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArhpT936405
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DC3BSaFtFB6SAIxW6IFL5cbKK0McN8PDE54PlOkMhbk=; b=FBJbTG430qBM8bDB
 A7zGCtjXc2bKn9kkw9eMEB/OEpXQsaFtzmtV6uYTluq8zRQcYH/nmzFTxSCQtRAN
 4lNMIl6q5KSo8UPSpwHCGPhXkkKY3C0ZjvdBheO9c1oM941AoxG7BOutOQ9eT0ZM
 8JkF/I3nUPcKHPv/pynMhFIFb+iPRrhl28b3pj1APUOzBSakmpCvWMtCPdCajhe4
 Jl2fygkXPsNR1z+ep3vrYp4FoRCmEe2vaPpASH6Wqchs+4mILe/5/tyvzdo5AvQQ
 uCU9ecdJeFcb7+m03T9Pc6jQySR6BPsgIhDm1xyHQmaswRGM9KVrgxuniP/k6vbs
 UFi1UQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt546qf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9181f3cc5ecso414189985a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786031; x=1782390831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DC3BSaFtFB6SAIxW6IFL5cbKK0McN8PDE54PlOkMhbk=;
 b=XhOhwZE0/I5TMxUFhHTqWaUDxFfhvhnJTTtVGuFU8TbGr8d0xuDZCBLSeahVyABc/q
 TJKmkqS+DrOW9oQ2Irf1vxU6eie7DC6C9mibV1K6OvVEVHcH8sIy87Oj5FGMD3QJZDby
 zawr99kniOdM+lPDtVe6rJI4AQQK9c0ok/pS7r24MVqBYRDcdoLd0s4Gvnu+1fndMUW8
 1SAFwnrE1teZ6oGmEF9dsX2p2DPjrWW+53HcdkFi2DSCgFMYqyHVlercizzw/zrrVqIS
 TVMAIlXLkogAQ+CnQLgvMdfMklA23Z9jndULWitHYHIGpQ/vtDS9RE0vic47aZXqycw5
 6rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786031; x=1782390831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DC3BSaFtFB6SAIxW6IFL5cbKK0McN8PDE54PlOkMhbk=;
 b=PykdYnB28vyhosQOnbkPB8LEdhQ8Xq4DfKTRGhQPUxe+N3ms1WZ77BJK4+4KT1ufaq
 1p3urdBOGGqAbKZJqOmGI9yMBM/pxXJePIvUs94odgaeKFKnHJPsqKjyJR53Kfgd9dyv
 /N++/iEEwBRQZH5QEScxnmdIug5xse3fLNExfEk/4xIbcZnPv+LY0Wcx6zPTpnVURCSf
 PqeZ+X7+0In33wqRlawJ6zo58v+AgsqsWXooMRbQ32HLkqe4cV1K/PtCSyhV4GsPyPDR
 8FmgxKdpwDxIvG7ITi7TY9s+8LC0WVV9uPspg3ptnrmY5+6B3UQ4opfeO5+L8Idas9eB
 CAVg==
X-Gm-Message-State: AOJu0YwlTQ2TZZf72ye8cIN+eCCJwVOlNsKgpwnh6yxJZisfWEglkJbc
 yax2LLfUOICdz+BE7/ffQRouOm5GlXynw7StLjsDy3kb3DAt0Q7+RTR/llXhrXcqvsCB/+E07Za
 8miXeHv/Df+PhCY0AuCI5K7GqvC7rSFYnQF7TZOKgKqnX/yYiMVpO7FcHsYc6odsvVw==
X-Gm-Gg: AfdE7ckW3LZaFPK6oLb9VPYnH9ihEpSM7BYs1vhCGcEeojwUonj02jMq0InyLMXmNsI
 tjn//Dhk1RQgy2UtirpbbS598vKa/ZTQiY9m095K/yUZiagS4WUAHMYckEiylP6J1YVz1LxDRqr
 j5JTqpOUW+G/zlB8Yyi81i/Hqle0qRewQlzbgZh0xS25PUXkjYXXGfbrbEwV/EegU4l2cwsZtnd
 4pUNlCHIMizLHGVeajuRPMYeGg7B9t9KBJzNtg4yuUXnmGHqLaAkT2WlyK7O+ILWoUvLM8j/v3o
 Wb83+8OdLvKplm5ktI56b1EB5hDyzcLaX2BvHzOYev/mV3ppT+qOnon7P9pnH6/LfqRSvZJlyUc
 PNCR75r2a2zTxpvmXIAHkk9qxUpZKZXawYIRbM+vUp1m+M/RLd0LC6MCPEplqt/q7by6H
X-Received: by 2002:a05:620a:294f:b0:918:7e9e:de74 with SMTP id
 af79cd13be357-91f083f7790mr505349185a.17.1781786031400; 
 Thu, 18 Jun 2026 05:33:51 -0700 (PDT)
X-Received: by 2002:a05:620a:294f:b0:918:7e9e:de74 with SMTP id
 af79cd13be357-91f083f7790mr505342085a.17.1781786030854; 
 Thu, 18 Jun 2026 05:33:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d9d87sm33602025e9.2.2026.06.18.05.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/48] accel/tcg: Move cpu_unwind_state_data() out of
 'exec/cpu-common.h'
Date: Thu, 18 Jun 2026 14:28:21 +0200
Message-ID: <20260618122825.90331-45-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PyIyScZKnnfZJiYp_3WLYx2MOZMWwNjY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX0GvYWnYfd36M
 SG/kOG0i+/LqRWQgPQEkeLZaljLntc4S3YmrQr+clm3rpUVcPxh5U2dXmTj33J2oGv2DMr9VEDZ
 ur6quvw72IVsc0Rr2H9VjTCOoJ9dAtA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX96vgnt3W8krw
 6Y1HKdtr7PneJHCEu/ebsQ0wwJZBkD8mTCx1nge1qgxIBuKgxbItzQKiG8SZ7J2LSbCjQlbveXN
 r4dzogTEddppyVVzl9x0g79vhU7cK/AO3Rogu9VkIZnoV99HlZo0UnnApO4UUOPUPNw7A9U3izB
 v/eCTovDo8sAmwU01C8hcxOMBSqm9bMEZpixaLJBGGWO/+gqt8qZzO9xypMwhNd7O/dCQ4lfgDR
 aXC2Uy3V2JxfEOn+Il6dnKYTBVT35c/DLuLUuftB/iswURomjAYb2IbXsUqsOrRI6h0JHQ5hkPC
 y1Rf2acOkQ+ee8ZKGXKWM8a4YaIsY3v1DtW5RTWQaDJbvOg0RrynxvYQR5kP0jXWDR5ot19D9F/
 X8RTprnk3cXg2Gj/es5qZWUkt6UPtN6DOYUmspL8pR8+qGHhEAb7uoiqghvqr7HrYAmWfMsJAzX
 wSWCdvpcdfDVf6H/7Eg==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a33e5b0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yZywUPRysb3OgPdCrAMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PyIyScZKnnfZJiYp_3WLYx2MOZMWwNjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TCG-specific cpu_unwind_state_data() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-7-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-loop.h | 13 +++++++++++++
 include/exec/cpu-common.h    | 13 -------------
 accel/tcg/translate-all.c    |  1 +
 target/i386/helper.c         |  1 +
 target/or1k/sys_helper.c     |  1 +
 target/riscv/csr.c           |  1 +
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index 94e91eb9a36..88333d39200 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -20,4 +20,17 @@ int cpu_exec(CPUState *cpu);
 
 void cpu_exec_step_atomic(CPUState *cpu);
 
+/**
+ * cpu_unwind_state_data:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @data: output data
+ *
+ * Attempt to load the unwind state for a host pc occurring in
+ * translated code.  If @host_pc is not in translated code, the
+ * function returns false; otherwise @data is loaded.
+ * This is the same unwind info as given to restore_state_to_opc.
+ */
+bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a97bb6faf42..7c9631efb06 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -61,19 +61,6 @@ void list_cpus(void);
 #ifdef CONFIG_TCG
 #include "qemu/atomic.h"
 
-/**
- * cpu_unwind_state_data:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @data: output data
- *
- * Attempt to load the unwind state for a host pc occurring in
- * translated code.  If @host_pc is not in translated code, the
- * function returns false; otherwise @data is loaded.
- * This is the same unwind info as given to restore_state_to_opc.
- */
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
-
 /**
  * cpu_restore_state:
  * @cpu: the cpu context
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5235c73bc26..3f1a3a28438 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -29,6 +29,7 @@
 #include "qemu/target-info.h"
 #include "exec/log.h"
 #include "exec/icount.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c3cba04e142..68362141621 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -32,6 +32,7 @@
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/insn-start-words.h"
 #endif
 
diff --git a/target/or1k/sys_helper.c b/target/or1k/sys_helper.c
index ca627bd7194..8ffa31b84fd 100644
--- a/target/or1k/sys_helper.c
+++ b/target/or1k/sys_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exception.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/boards.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ec931a8c3dd..dd9726fcf4c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -27,6 +27,7 @@
 #include "time_helper.h"
 #include "exec/cputlb.h"
 #include "exec/icount.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-- 
2.53.0


