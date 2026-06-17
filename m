Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE2CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrg-0000YB-Bc; Wed, 17 Jun 2026 13:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrN-0000Tu-0k
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrL-0006wU-3h
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoXOE083400
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ulJUzi3X4qrPHf09McK6t5ZuFBWvi0xGnqqU2jl+eZY=; b=SVzRARq2z4RS37da
 /Xnmwk6C+y7PXIh7sFp4fNeWrEoximcYBv0s4svfJdSaIZeCo4Im7Ng+VCJqQS7+
 20djliKhL7/nNcfcT2ItcQF417MZTAdhW1G6KbHCmTupzBq4/dCjovkH5hm1BG2g
 Jkgkpq9E1plOv6+Sma8ijv8K+JMvj5wVLaiCrjW40Lt2KexS1Mggs5dNPprLgY4p
 mBpwBPfI+c6SURNLGBimcubo+MNlLK5FukQqVxegYU1cvKOOZeZqbTiCa3GI/2lq
 38mVIMq6LkpoKShYMdehHslixmKIJgTq7mjTUvjXgW/s4SaDKkO2vbPQBaIJDZeB
 k5su3g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vh15q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-966c4d68d91so733885241.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716525; x=1782321325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulJUzi3X4qrPHf09McK6t5ZuFBWvi0xGnqqU2jl+eZY=;
 b=Yl2yXzyOm0wglepL2Hb+WhqrcMsM7DyA9V4UPdwpBDQPCXRDu3zMu+tvk6Eq1TIqFr
 zJcnEVjpX7oC/0ewfvjCJUcrcpOhTU784qiwsZNDImbBIsSdRLhyi2D28SyGaQSbDWnY
 5vemBfSsb1Bu0kV46HkedxqcgdgGccXslz4I911+MLvdNNJZL4IZqO4dAcI/AayP+C+6
 K80bPEmyaub8lYLs79AJmvDTjjz9QZxQu6iNUdvZXA+IOaAO3ZEd1vv5D9bHAwxZOuuw
 eiB3ohcCKN7HbyCyLn3ghq5H7ClnjFuePbigZimckctu4f5TuRtKIM/FlltV54ofiiXg
 ku4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716525; x=1782321325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulJUzi3X4qrPHf09McK6t5ZuFBWvi0xGnqqU2jl+eZY=;
 b=VINeXU4v+37AQgv/S9yL4KabkdHpi6Dt5WVuTbZbRe7eEp4nQrKe/Y0hLaPenOezOI
 6MPEvcovSoF0ynKEYCaQ8zEuxlmi28McGGkJnkaOG/hHnyP2/GnbXkyVrERqU5pFUxlx
 9F8/d5+TJFata7WI68opeZvWdvWiYQtD+TTorJ2QcjBHsH99i4Pkppwa4pYJB+nxi3kT
 pWfhvZmSpaabHQOCc37aaon+qg1t5DPHSOpKUY41yAz6vSWjvYEmw7G/kru0xaTvE/rT
 aYvmDRpPz9CCgVR+kRKwUOXbkxOosVgPLML8i+zWBSUkIpzDb/UAecZLVo9FAQIoLyBF
 Cbhg==
X-Gm-Message-State: AOJu0YwWV5erzXm1SN/qaBeTADUTQWH5S05kvrgVQcrHsho+FrbMxRoB
 YUyIGHDdGHcO5JLW81im+enWNrorh1XkefnMoYuJrcI/rQctG4RP2h2I54TcIftANDJmsWE8FK5
 Iznwyc5Vn5xHFvRRZfjaJAjTix39rqpvajZml5DBtNEUdFXCQx5HKjVOjxaKtl+Pt4Q==
X-Gm-Gg: AfdE7ckaYcWBwU6kaPedJNf0owHED43invy989kO2PEuU9L/0dbLFT8b0D66nYLH+3i
 UXpPj2zI1y9oMyn2512/joqFxUJpHsPkgKHsPiDMMeo9jafXQOVjJmpDl0Nd69TQf5QQW0Z1TEA
 IFvnSQe2Lv7q7BAYROF/sZkd7SqVDftpIC8VMa8Ap+NSoDOX1709x4LGNdbm58qSI2W0vJj+Zih
 XdW15M3S8zcPymTKjUGmUSDEhJT+Jht+0AXezT2RJZMlOxErh6VdzO5CnG8EhRUfhRY/wC6cSoj
 KRneJYzLB7ceKah/WG3+w91Z6Odhw7QOkCgi56H8GL0bVE6IvIOKaz82+pBa+qXDfk0+kh+tkIx
 0EwpWyTYNgJiXUJm4LT2Q4sk/maCRdzCND8uTiODO2G0nBUXzdUP84AnY++gh3z5elKxx
X-Received: by 2002:a05:6102:510b:b0:604:f849:462e with SMTP id
 ada2fe7eead31-7246d5319d9mr2908380137.25.1781716524632; 
 Wed, 17 Jun 2026 10:15:24 -0700 (PDT)
X-Received: by 2002:a05:6102:510b:b0:604:f849:462e with SMTP id
 ada2fe7eead31-7246d5319d9mr2908210137.25.1781716522140; 
 Wed, 17 Jun 2026 10:15:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm58463909f8f.36.2026.06.17.10.15.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/11] accel/tcg: Move cpu_unwind_state_data() out of
 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:33 +0200
Message-ID: <20260617171438.75914-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hOAaj0AEWY2C0lGRSV8qMMeFqcpBvWYc
X-Proofpoint-GUID: hOAaj0AEWY2C0lGRSV8qMMeFqcpBvWYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX+egVhXI2rO0t
 zv8o3XjKzA4WrWCNYeMutWWjD1DP8L7qtPdAjta8P19eN9FjTs1+YWiW9/d5WS3GkQKIhEGkZPk
 ugZuSrAXKuuiax+0X8hppkezixZjpnPZLMREJbKtDgaiB3oFpMiKor4PowPhDYqmhpgk+099ggT
 VHUX94q4HO6KMyc0UopV3whhkAV3AnuhZ56tm2VWLK+8qvhZK0wdxQUcKIotMZ5NYBunGH2F3Nj
 uYnCd0TVE6lmBMzHAA2BLARntTN4LnBRxAnyTfq/SfW5yFseQEqcVjeVCZ6Q/voUekrBqmJAQ+v
 exb22VkmAPz2Xudaywbv03gv6EH9JX1zbvrWR22Hi5s/5qa67iuq/4RZ/Z3ygIIZPtbor4svN4M
 xJNYUwYjYhm/87ujpP2Q6BnZ5QLn3ZYNR3HWSF86/0QPpbYb74bQnBk2BYnUPiDzSowkylX0VVY
 o+HSqSSW9EkTefkZnUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX7o3s1W/q39ia
 5WcAfZBvTLw+6SfnzL3M4SbeYV5IccEXAcJ7mu1NjhBr7w43vWHOTqoifR9stZAHKIDYq1MoRyW
 MlNvIS2jmRRJ0QNQPoicsD3LLM8Qj+k=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a32d62d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yZywUPRysb3OgPdCrAMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=TOPH6uDL9cOC6tEoww4z:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
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


