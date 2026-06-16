Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D45CCD98EF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZIW-0002e6-5Y; Tue, 16 Jun 2026 15:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIT-0002Ll-L6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIR-0004pr-JB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOKk51376137
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VptE4oZJvr8TC2P8IEMdtdrX8C5LfG/QPGq6pGa9UsQ=; b=ZvaLeZJ6vMK4hhkX
 acHEeOvfEXnWOiApuxftMmv80YWQkWkalD85gb+Ufzcv3hzOA4X+WLEGhQD5v2GV
 C/WRe6nPFcI6rgH7Okb9eb3mKPszrsEeJboFlyFJ1wttkRb+FNYzDGixygvTDCHm
 XcXLY2EXOMm1DU4omcGe3WBAy3jyetAUMYa4iL1yt89iN+vA7sDFPjVmFxkF2VfZ
 SlhUngvEWCi/flDwhU/4I0g+nAxaXkPS+qzwM+lUaTsG6YrQXQ9ThZq7PFY6JSb8
 Fw3/Bnk4WVsiTkClho1W2wufQ7F2xxuDHt0RDKBSAtCanu2dO9AubN5QV3qtdzW6
 XR9eZw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu2xsb2k2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915f7bd027eso1280641985a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637481; x=1782242281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VptE4oZJvr8TC2P8IEMdtdrX8C5LfG/QPGq6pGa9UsQ=;
 b=WSFwUdzvbzKKpbiU5o1PEKjUO9HXrW0U7zuzrXrgld1LdLYOm4q6qkVG7BYfEholSd
 VqQfqcK8k+d08IbAZ97gpNsD8vpTQCQv9RuOlcZa34OXGtU5mITjBp7Lzd+auubGUMOc
 4sunz2TQCmSFG8Cg6s9VDc6Y8TFzTgy5uFXZjj+Hn7pdgRLmuWtlLLx1kdqiG5JETBdT
 uc1ivkXe/W39zvnFP6yY84iLfjIYHBtKhNMN7pBNW3j7b2tkjwolWjOT6UTvZjgFMcNC
 renkQNEb2red6zJ78akXLnX6gUaL8Fec0oicJdBhjuBv3gkkysu9SVpUVZY8H9vlJSzy
 SHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637481; x=1782242281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VptE4oZJvr8TC2P8IEMdtdrX8C5LfG/QPGq6pGa9UsQ=;
 b=TF/b+/+i1ezWMtBHdsjTsm7hnHLh9vaovIP8vpsaWzyC0kOWWp3KTh903sLD74i+iq
 yJ2wqTUzOCUGAJp/jPbv23HR54NjeEgq4BIsqoENpOfYNp5dXnsN8oVGaBhLVInaXBkd
 vYONM4DkklnjOCDg1l6H83BrKYRqbxYCReG1kIwbKtJaz443iRedV7dfjFLBJZ5cUNfh
 YgIGW/GaPicEDm0tHlqbdRgGT2w0iPHDVHimuhTOJzJyDjcq5rtFJIz8+2DpQoNntjge
 9BOQJPHWDAOwKNrngSL4E0W+CtEwlWXD/yybA5b/y4zebtKUYOh36tS8mCbRDPCIWMls
 k9UQ==
X-Gm-Message-State: AOJu0YxVkURkHzi6GjPmRaW1NKiXeg2gvuSU1R508lsGS5NM7JqjbA0m
 XH+1knge0i1zf3HXJy74KOlHno+pQNMQrjQo8d4F/qz9FcXE+VI9xaeqwmTHzj+4UQDWcN4PFnS
 BURvGnLzJmUvt3aP4l9rKE/tAO+bG36Hjwjs7koHvLpZYurF77R9tko33HuHF3wfLhA==
X-Gm-Gg: Acq92OEQFbb6S1E0v15bjyEoy2Tc3eSdUGmq3Qe9TZMq3kQfbj8BZWWu9DYwhLdy4rZ
 2MF8PepPEOgnxv23C8xuUHBWp4iZ4M75YTmoFWfiL0d3+hrZk1P0h+E2tITvBDykqRV938GnPzK
 8AUBzbcgtMV/ogrLrdn9eqaA7ztWQWycYJCQ/HTR2dE/DRqv3tCCdpRk4PsaYXZhWHLttFx9Zy2
 90TNSRwcc48wbxFgTcco0UwQvAKjT+R97Xfi4MtEWc+6yDs6ZGHNcwVRzjxDIxkto9jejUUP33U
 xjwPpkbD9UK4g78HnKLMKmeGY9mgTO4WHJBsqpmRp018ED+vVhY15lW+zwn64v+AKtOv0EoEMqG
 /zs6L0x5GaslwdukXrAfLMddvqlHNabslrZlSc9kLORCW1UPjvcbhqDh9yKxBxWJAIjn1XtN2Sg
 oOwxw=
X-Received: by 2002:a05:620a:1a07:b0:915:c7ad:8bd2 with SMTP id
 af79cd13be357-91d8acdb52fmr172598185a.30.1781637480769; 
 Tue, 16 Jun 2026 12:18:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:915:c7ad:8bd2 with SMTP id
 af79cd13be357-91d8acdb52fmr172594385a.30.1781637480268; 
 Tue, 16 Jun 2026 12:18:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm49769277f8f.36.2026.06.16.12.17.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 06/10] accel/tcg: Move cpu_unwind_state_data() out of
 'exec/cpu-common.h'
Date: Tue, 16 Jun 2026 21:17:12 +0200
Message-ID: <20260616191716.12932-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ji1DEsGhEoh0h4eg8pRYH5jasMzRrAOK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfXypcaduoojj3E
 sAc7vwsHREfwux7RLmNzhmddKUhroflb47rdMCkKI6VHm0JfvhL2/KCCNHQMZoBkPtLaGYP1lZj
 2amll7IdZrbU/xxZM8DI0c6WToVYFp9nGmVlJEARC8EA4yY5z4s8Gg8hokC5HZoPY1d5BzX04Oj
 WUc2NCTCL9429cTcgmGHE/A5y9jogRScpOzJ84VxAzlQeHV5nQS02gcIRrhPqR9B+zUdJbrvfWK
 ObPRZERTa1IrGUd9d+nMNxUGHkgp9r2+zMvnjWK4YPo2pySE7KVHxy1PajKn40jgPBtUUCt+zXJ
 7yfWaYZBbVUMgldSl3nUnJNMdeJvfSyqS/+WqhbKg1FuhEi3yYytZZz4q2hDEogYK7OVlNoccY+
 57ecbz3nuXQbKwBDxWRnLJNN4cXuMv3vftqdiGIxp1WJ0LcRKoqJmaqCGtkaHmN6Qp965BZqhyj
 qa3dBAf2iXf6NtrIHHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX0c9QefFVk0Gb
 X9k/nClEif2Ww3mA141aUbDVLTdCG5Z6Ut+Aum8tSufS4YvqC4C1HGEy3mbz8ntVaN0kVG+z2gE
 xFR2KhlwvjPsG9hkOWP8A7N3loIJ3no=
X-Authority-Analysis: v=2.4 cv=MdJcfZ/f c=1 sm=1 tr=0 ts=6a31a169 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yZywUPRysb3OgPdCrAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ji1DEsGhEoh0h4eg8pRYH5jasMzRrAOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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
---
 include/accel/tcg/cpu-loop.h | 13 +++++++++++++
 include/exec/cpu-common.h    | 13 -------------
 accel/tcg/translate-all.c    |  1 +
 target/i386/helper.c         |  1 +
 target/or1k/sys_helper.c     |  1 +
 target/riscv/csr.c           |  1 +
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index d8a5f98f9cf..f328aaa0377 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -15,4 +15,17 @@ int cpu_exec(CPUState *cpu);
 
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
index ea9a49a1435..ba98304c5fa 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -64,19 +64,6 @@ void list_cpus(void);
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
index 05d9ce512a4..78c560c7980 100644
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
index 5514e0f455f..de583396f29 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -26,6 +26,7 @@
 #include "time_helper.h"
 #include "exec/cputlb.h"
 #include "exec/icount.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-- 
2.53.0


