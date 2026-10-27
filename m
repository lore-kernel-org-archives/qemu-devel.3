Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EF606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pQdx4073;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JgZVlETV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlaN-00053H-LR; Tue, 27 Oct 2026 14:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlaE-00051Z-Bf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:07:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlaC-0002mI-Nu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:07:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH0fYM2827886
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+PFJ3ZQTqhVffKldgeG8v1KFVYhX7lrUEcl308Tz3Y=; b=pQdx4073H/QA+g7V
 6iILKXsbUD1m2jErY9qIkurs0r85u2qrk5spgqC9QLB0gpk+XncjJwt+NuJSUnpk
 TM1HB8PleKVhYrkxXij3v+qA3x5PpGUgU/ALERx8b0vYqj7JTPw6L0jENIDsNJFr
 P26JmbuGj6dB7WQZhn+uz22iHZcMTpZFSD+1JUHsiIXeN2ZYdntNDgVp1C1K7ZuJ
 I1ByvA0okz7ruWoX5woCDGby7wtLYGY9PpMx3DUypMWaG27JTpQz2PB5r1o82/X4
 ciKRJkvRa5KBtkK+pNQRVcPnp47clKydtRpCHnVV10bDJ9zUWAM5nstULarCoX+k
 lLLjCA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1j2g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:07:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so6299585a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793124443; x=1793729243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C+PFJ3ZQTqhVffKldgeG8v1KFVYhX7lrUEcl308Tz3Y=;
 b=JgZVlETVTUbTMRORRjs00R7hklZ7vzacSN0iqm+tFMPLZeoD3rh8UOs9jTo1U9hasZ
 kQc6S95dQaIKydUuOMK/jgVfWPPRM6vq38Qnr1YFElkTuLz7Lq9UOVu8jwX0i4Ly0rhT
 fz3GeeEDTcFV8q2IMGYygwi88OJMiZIuyu9SO4gB8uEleN5qfyr5SJSEe24XakYqDCMR
 s7WoDUzGAYmpuTgqybYB68HHfRhxeBczcl9LTXa2zWLsOINhCSjw7MZCDajxQHPM2S66
 wVedlzQfCDrhiCRTdm0L4Xdl8yBtGqW06JZ3J28zvMB5B7zoMEl8eeU0FUowxnV4N9ZF
 jjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124443; x=1793729243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+PFJ3ZQTqhVffKldgeG8v1KFVYhX7lrUEcl308Tz3Y=;
 b=xSH9tRgbDQcJWn8+Ji4a7jESvsEivitKpyakrUD7K/Undi5TpPMFGubIoaMMAePIYP
 L+OZJClTe1qzM2JvqpTWHT7SMBCFY7xx/rfi4qqnc0KWfIJyAU8pd+ldJ80jPhvHkcHa
 ndLaa2+NBm2dr1/EpbF5GByF4AtcbbVw+/ItQrSUBTFg4P9lZ9pKZOKpyq85FMMZTLzM
 9kT5IRH/LJiFT82V7oqO0KJ+h9INsq5RuqL8UIHpXZJXs0mnO0qO3NzDK4Tw6KAFQxRL
 dAOA4iq/5IKT9ZyI2qL/F+qhrzZeg75L9qcuUysNTgYCWreuAd5jqovL4uP/kk7Ctn0+
 S0Dw==
X-Gm-Message-State: AFq9FYJw+pBULu0Tu8+ynYF3USZG7N1G8QlmckcdiaUdHedf8q5Wo27A
 iy+6Q7CUiG8pjOei+CjeDnda/oZgtrukTkjPVciE5PGeE0Hq1+ylCbTOfOmfjrY0Tk7jSR7YGYN
 YObb+R9MLOALlxCWsKvLZJEqPbSVNntZ3vXb3DqwGwDjsWpBPDJZ6nFHP/4E5sr0WuA==
X-Gm-Gg: AYBFou1jmjAIqZajMCH6R2Bl4kmggHW0+7/yAf6Bwj2J85VkQ+h4B+r3MJ9rm8GSI/J
 3Rg0bo7t/YpC/D2WObagwittTLJFJ/UMcY0B0xoBsBAxwlDmSRZQlHboliaQ8AYrq1n6sRXycyr
 va6pCoEGT8HtYYj3CJc4cOSBfM5dxQHZTMh6GnCnho6X+HQQzaRlJPZO0zcOArSfOHTlGeUOtvy
 +4eWGXOdlzJiGEcH8Ohh/GAPQ2J0bc8dT6uHECvRStOoIDjrz2O0s96TWLz4/q7RBy9aSBQ1YN2
 4l9NYODn6z1bhNWxOIMIPtTKZuqv+GTd4p/FWixEvxxQlD2SDeiftSeW9cv/sfXhhZuWcIDNJXg
 K/sxGo+70OBDXqJchtWnfZe1bwfHGLw7vjRlcLTEm/+2nQ20nUtjIQVyi
X-Received: by 2002:a05:620a:444e:b0:93c:6534:d04d with SMTP id
 af79cd13be357-940ef93faf8mr1608718085a.35.1793124443515; 
 Tue, 27 Oct 2026 11:07:23 -0700 (PDT)
X-Received: by 2002:a05:620a:444e:b0:93c:6534:d04d with SMTP id
 af79cd13be357-940ef93faf8mr1608710585a.35.1793124442973; 
 Tue, 27 Oct 2026 11:07:22 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f248sm23628440f8f.6.2026.10.27.11.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 11:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] accel/tcg: Extract icount_cpu_reset() helper
Date: Tue, 27 Oct 2026 19:07:12 +0100
Message-ID: <20261027180713.2386-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027180713.2386-1-philmd@oss.qualcomm.com>
References: <20261027180713.2386-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0e85c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jYs2RP2CEQKANlrhWQYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lFqW5RgNVc69KZXam1CyO5NMxK7UAPNb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX9daHbtXJsOV2
 T32uShKVJujYbreJvQR/zkwg3z8p7gjHtIC2CvvSn3Ofpw+V4TRZfLSOo1Wfo4ZXRLNFwxsvwOI
 cXq2zcScG2Y+ZsAREA8Bdl5wrjgTdos=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfXyjpvgznaGQlj
 a5eq1/i2eKf2Gc8mTzdKJrg2DClPmsFpLyYCP3/sF9MuXXhlBK7jFL6kBWiL6vjHaNKGuevkbuX
 6NGQuTpmDlTlbguTXDgSj0vKnHKnx3N4Q+dCc/FclXWpnJL7AZCMdN0oMxxtvLINScrdYMnnPPH
 RylKQkFKxOQmoBNYwcYl3AZ0K3EoppVpyVRKhnuGq5IAuZt/15fAOovtSQoR4OZgGLOxaJdsJ4V
 cqkc7qM6GUBkpDBskEiUephbXqxGoLGeypa4TX6WadQ6vkZ1TkoupbEiEsSKOajZx98gKaHfgLL
 W1wTRgR8WWbBVcw8TOo14jPY2vODmER2RpWhTXLp6PMBZpBtdrihamX8ZARTs/9Avq86HbRRARq
 zxk22wJqECpyHfoTlK+ZMc7TsLvuJVl1fwDTHZ2zPSCL4RA+72BC1amC+iaaXRKfVCCMIDYRxP7
 utX6X5FyoHyBuY6nNeQ==
X-Proofpoint-GUID: lFqW5RgNVc69KZXam1CyO5NMxK7UAPNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Move the icount system-emulation reset code out of
cpu_common_reset_hold(). Add stub for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/icount.h     | 2 ++
 accel/tcg/icount-common.c | 6 ++++++
 hw/core/cpu-common.c      | 4 ++--
 stubs/icount.c            | 3 +++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/exec/icount.h b/include/exec/icount.h
index 7a26b40084db..e97cc4e7a426 100644
--- a/include/exec/icount.h
+++ b/include/exec/icount.h
@@ -43,6 +43,8 @@ extern ICountMode use_icount;
  */
 void icount_update(CPUState *cpu);
 
+void icount_cpu_reset(CPUState *cpu);
+
 /* get raw icount value */
 int64_t icount_get_raw(void);
 
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index b1b6c005fe71..4c8ceafc112b 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -104,6 +104,12 @@ void icount_update(CPUState *cpu)
                          &timers_state.vm_clock_lock);
 }
 
+void icount_cpu_reset(CPUState *cpu)
+{
+    cpu->icount_extra = 0;
+    qatomic_set(&cpu->neg.icount_decr.u32, 0);
+}
+
 static int64_t icount_get_raw_locked(void)
 {
     CPUState *cpu = current_cpu;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 4f4c87f33a09..a18f05d26bda 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/icount.h"
 #include "exec/cpu-common.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
@@ -110,11 +111,10 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cpu = CPU(obj);
 
+    icount_cpu_reset(cpu);
     cpu->interrupt_request = 0;
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
-    cpu->icount_extra = 0;
-    qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->neg.can_do_io = true;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
diff --git a/stubs/icount.c b/stubs/icount.c
index ceb73b4fc2ce..1d28bcf7e2bb 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -30,3 +30,6 @@ void icount_notify_exit(void)
 {
     abort();
 }
+void icount_cpu_reset(CPUState *cpu)
+{
+}
-- 
2.55.0


