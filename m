Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1961CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZIp-0004Ra-4o; Tue, 16 Jun 2026 15:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIg-0003iN-RB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIf-0004wf-2E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOd0I3914063
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kipyd6hfI/Thn7Mt2xUvLhyrhjzSfp+Bw1snorWptjo=; b=OwFkTkkm05doCxF0
 /CCilL81rn5cnFGm1TjcMWvTyM80CQ7yLNvsnhqcKQWyFuoKpjl+6elYC7DpIP3g
 8Sl622JYyHkpIMMbQFkU58Ah3U67EGfB8jDLBz266u42aZU5797hJIv/Z8dIUOEK
 ARQ5scFzh7e7fFqG3seBSSm+g8YjMrfTKtHLBQG4uLKBthZ3cRJUlIxA8VpSao1U
 BaON/TPrgU/Sbcfwb3Mqiz2cqB6BMkoaCstYd3Huq0ZIwHxWMF+LUgbTN5hpEx0H
 FwR9TYZc7vvmILO6VSEK70qbcVvPFfrSJDKdbC+x0tj4jSfD+M+XzqC46WCzduPL
 C1xfGw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu0a7ury2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cce42a4e75so99912776d6.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637494; x=1782242294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kipyd6hfI/Thn7Mt2xUvLhyrhjzSfp+Bw1snorWptjo=;
 b=ELOahBi0XQVuW1/nB/U/mOzsnR4oFyVoDzQFjQO+usZ2BCEbQiK083Si6yNaQ5is0P
 p8txWfdj4MGLqGJksB9AQiNz63DdTCzKsChMGa68VtJyBh4/x9O2Y5LjrD4emcwavbSz
 Wok4eYU8h8cYTZTX+WlemxqLBuxstdoBxhE6sW/5cxk+vmGvbLirIRjzJ3BSLy+dcYvq
 6+qEzcQmmpViI8lE2wg2bKZV5XLadyea+7EaUC+hEtmU+RIkvwP2IAJAf4h/7oqmSWAB
 tTdBD2wg/pOWdUYS0bUSI3oySalip35kaZDtxgRdFR97jYXduxAPjUoFDr9kfLA1cxpy
 bbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637494; x=1782242294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kipyd6hfI/Thn7Mt2xUvLhyrhjzSfp+Bw1snorWptjo=;
 b=hoku0X1J4+htSKalrd5KLw1Fa/CHJ1fK81N2cRFI1QxZ4dro82AS0PV2SliBuzS+oF
 sJRPjvK8d2JwKcOmZQjuOm3KLBkyKv+pVahNOJtLfoc9OAt0QKHRxlFVB8PmW6uFwdQ1
 uSYndcOjv99ExrkRnOSEMqfT/GQpZrCN5mK9rXB4SMAFAtN5NMP8GaOZXKFQPRkTYYR7
 f7sKSG8FmHAoqCIaWc2Iy4ebmiVJmwUI1PZow8GgBAU2e3dbtcE7ROpTRrKpkIFBqsqg
 aEwuoEqp/xjmp1EvZ8n0UsQkDuZG0BtZtur1dZqDcbdtI0oHdkJjvaFTClZtnrDEX/bE
 7J6g==
X-Gm-Message-State: AOJu0YyG3S+eHz+P+mzuw8hFhZaw96PjLaew/rjtyyJupUNL2qPpDfB7
 GunOJigjOCz87zBbrsQCGdqQGP40TvihLW4wHF0ijoxRC9VcoHhDGyAR7vt70y+KkKs0nFISCzn
 oIUGVrf0qIBms/jcy6++P1UMSnMQKPbaIEq+bib7km41gqtW7heOplK5MCpfv3Qa4QQ==
X-Gm-Gg: Acq92OGbrD+B1zV5jxpISPMkR8AAKw+kA+TOL5xcl1jS8HDbjh3VbzQ1oz5YwoG3LgK
 o4DnYF6sJunHgJg8dX0xtQ1zZSe3zebh79Szx82ED+9+bTVAIvdY55sXubmtRCEFQzpBksAkWA6
 XqkrjgrXr80SIMLX+kNzO0TlSKnUE9/p726fHv8rqJj68izlAlcHoTP1ksIhpOujZl8Ny8PfMOz
 ChqlhDCjUIRbwABCC8mcQSxhf9KLS4C5HSxTrj+eZCidhT66ZVs/+nrPgyQSNE848laomrKymYQ
 gzHwAKFMmVPfKg0RipCQB5d4eKzVibtHMBs2pI0TuEK3lHn9dwebwz3JR2caVZEf5uuIuD4zgJu
 OTLNS/RvrUPdG3ff7io/yglD8XAmyJ5ux+Jt2BRShQ8DslU1OW7fD48NF3uMy5a+i7+QneMPt21
 /M/08=
X-Received: by 2002:a05:620a:880f:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-91d8b7b0e6amr170277085a.16.1781637494521; 
 Tue, 16 Jun 2026 12:18:14 -0700 (PDT)
X-Received: by 2002:a05:620a:880f:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-91d8b7b0e6amr170273185a.16.1781637494095; 
 Tue, 16 Jun 2026 12:18:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47da9sm122857995e9.5.2026.06.16.12.18.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:18:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/10] accel/tcg: Have cpu_loop_exit_requested() take const
 cpu and un-inline
Date: Tue, 16 Jun 2026 21:17:14 +0200
Message-ID: <20260616191716.12932-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NyBTYWx0ZWRfX+/+Z/CnV9SbK
 VgxCAIFZQMC5MTzxF2AzyNFASNwJsJSMrAKF31iwpUzwcHzpGyhoSjE+DcGNdYyOMqgTaBEOzBE
 OSHLk50sy0QB2Dihj6dzBnSKawMXMBZanhMHzvcRjsPxvwJZ00EBuqcxwWmz3sEclqvI6hcq7rC
 wK4xpKbRR9XCiGBtT63FzOmQyl2OHvxkk11HSQArUGgot1YraIVWfAaUyo+oVDmmyCPRYLNknep
 J1vfmdkGR9jYoSWP9HoyQ8E9v77298MWzLb3A8DgQeUsSRS1dWPCBC9GbcBWyHAVr8KZHEcydEi
 nnLjRMMztOVOBw+Ns67R/lB9uSgS4yxt5CY0oDWmAfZw2RPuDQ3KwUG2o/XU8bWYA6C+NEk5gP+
 gtuYFuYZurjVTidWIgYU/+HIaqtk8MB/KeG2Jo1PjLG5tOjF08tnzTURKDUYrLor8Ww9OkbRgbK
 fe34FDYzNSw4aZu3HEQ==
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a31a177 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EN0NE8wA606m7JOjE_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: X6GqwntUPzuigiCkAMQ2PZYpr5U5a9hg
X-Proofpoint-GUID: X6GqwntUPzuigiCkAMQ2PZYpr5U5a9hg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NyBTYWx0ZWRfX05Mc7AHmvMSz
 9E56l1a1aPOEr8QI6izG+wXa2M0bDh3K2DNwq4kr8NvP8GP7xP5InUaVcl+f5Lg7mWERE+kV5pB
 RPJgUiLtCqwwOCtKDF6bqbjlj9enq0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160197
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

Of the 5 calls in our codebase, 4 are unlikely(), so not worth
inlining in header. Since the CPUState is simply read-only
accessed, make the argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h   | 6 +-----
 accel/tcg/cpu-exec-common.c | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3757ab15967..664e21e0b6c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -62,7 +62,6 @@ void cpu_destroy_address_spaces(CPUState *cpu);
 void list_cpus(void);
 
 #ifdef CONFIG_TCG
-#include "qemu/atomic.h"
 
 /**
  * cpu_loop_exit_requested:
@@ -76,10 +75,7 @@ void list_cpus(void);
  * call can be used to check if it makes sense to return to the main loop
  * or to continue executing the interruptible instruction.
  */
-static inline bool cpu_loop_exit_requested(CPUState *cpu)
-{
-    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
-}
+bool cpu_loop_exit_requested(const CPUState *cpu);
 
 G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index c5c513f1e4a..b571488be9e 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "exec/log.h"
 #include "system/tcg.h"
+#include "qemu/atomic.h"
 #include "qemu/plugin.h"
 #include "internal-common.h"
 
@@ -88,3 +89,8 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     cpu->exception_index = EXCP_ATOMIC;
     cpu_loop_exit_restore(cpu, pc);
 }
+
+bool cpu_loop_exit_requested(const CPUState *cpu)
+{
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
+}
-- 
2.53.0


