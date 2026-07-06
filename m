Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5387BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgk-0004PI-FX; Mon, 06 Jul 2026 09:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgh-0004Ix-3U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgf-0006vD-0p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax69V391044
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A0O3Do8cLpQEuezC0KActk8gus15oyWkrKJ8LmcCGs0=; b=UffN+pnuyXoiHHYp
 c67xVt2Xsx4jiSBYYGDTetQxkkaUt6000ggAYhhX3d9L+1nSZjvPBtpb7GzvabTM
 Oj77BO6rWBz92l63Qrj+8Yyv6z9Vv7p4xEZguvNg8pkXi7yZHDK6V4Dh9V7+Z3pz
 QuZvhMhK00+HRn/1YTrrgA/+GYxak4clr9PJnR4r40lhlkCEzCl/NCfwlP0YX1Lx
 elO/9REVhu9cjQesxMlupUhqq85VsV8hJoYcXdHQ4ZUmtWAESpdUqS1xPRPhgx/P
 Le52eCvCxUBGC1yL8TSFoRRPc4U/0HP9vYnseya/+aiEPhK1Ao5beBm2JV52MK9x
 rlN6QA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs1hq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e59b0e0f4so229854985a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345719; x=1783950519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A0O3Do8cLpQEuezC0KActk8gus15oyWkrKJ8LmcCGs0=;
 b=N7KxekliJZhADTtfCw1axQ/iviODIaOshcECPdeS445UzyEmasJ/RT6SCUv8ezwwxo
 v+9G+N4W/zshMT6cLHP5HfHC5c2oz8/En2JTP9pyUJvPUmtcjArbX1tn/5wALPDigjKX
 iH53Pq6Bsn+0bRkLQeCbhvp+KDdks+VFi02kHyOwrg7/8QMXQDbhBu6THVClcDMfHKT0
 YGPBOiUsm/Xj2g0bm8N0MdMnkJZ0Ksgj6rOFYbS9rqx3UCWoZGCVybiBqbkvjS6lMLJH
 9NHsHu3BIyZDJ27rNMfU0PP4pFvUSFIU5ePDO8AfzDUHpPVgHO/4AbjpiapagYiPn1Xb
 jVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345719; x=1783950519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A0O3Do8cLpQEuezC0KActk8gus15oyWkrKJ8LmcCGs0=;
 b=eLS1F4z87e4dAcojQ1p2F+vfeZmBJHuShIC1nDx9OLEj43hFXu36ZhLeWSDuA6+Xm0
 wnV5AvHay+BUuH6B6MpuM8ZEoXgTHpLf7zfgZV1p5HXD8p3aBs6gIPbizJ9Pzw1zLiu5
 /JcvmVP5m5UHbsS54KYXGR9/e+jvLt+KCLtj2TxahhpxQK2r+xAU3eFL67AJO29VXKtt
 KULTmkGq7GmX3aHFMH1RkcvB9t9v/9VPxAvAdGl/9idjzMPEHPjXlsTNCr8aE4EVdq4Y
 VPRyW6LcY62KwMyPBcBaIjveBDoDFLDThn60wQCLVz81ImmF6HZ+9rm/Y4XT081CIyOp
 L2YQ==
X-Gm-Message-State: AOJu0Yw1/05uKf+57CTcW4UFFix+k+XHNDgtESirmHKrqrlIaIo53yiY
 9NFhJQSC362EXHyW98fW4j6xvm76F0fhjiw5LAT0FmmpSDYAQYIGxk0c6JRcIU3DzTfw7BxTmxX
 fGUoYUQ85n20BdTYLKCST01sy5/plP8P2CETg1Gjil12/JgQoH6pKNv6++1M/U/sGvA==
X-Gm-Gg: AfdE7clYub2HWoS7v/jbpNkehuDKZE+S2jpdf/v1PuOWayv+7UWxgICTq35p7GwTGLk
 2VLHmbdFsOw/HAq/7PvKM1hjfttdQr5UFsVVWECXKMRxG3lM2TDriChRV16/1aKDKaK9VGgeeh+
 zfK+8YiOh7epulsM79E5GcblIOsH5lftOgD7WSHW09kLyOIxGrmLa6+osGynuu8E8m9TegJXdw/
 X7wQ4nAEH9lD1wsMaw85Ji1D9On5TuJlE2JUz4Lj3tHWIy06LPrlFQCBhfp6Eh4tJGIxcW7BXdK
 WSIKyl0geELYOmaxc8GYgtP9IkDAhLA3HPaXp/QXrYUVzSjXV5+LAduOvCWDckedexhcoD+8ETu
 BrlN3a0NztQvRlt3wHBZh69J6Nz7zZZtHvJEFQXgqAYByRdnwnjU3Z41bag==
X-Received: by 2002:a05:620a:40c3:b0:927:620f:d0b0 with SMTP id
 af79cd13be357-92ebb5680camr90861885a.22.1783345718447; 
 Mon, 06 Jul 2026 06:48:38 -0700 (PDT)
X-Received: by 2002:a05:620a:40c3:b0:927:620f:d0b0 with SMTP id
 af79cd13be357-92ebb5680camr90856785a.22.1783345717837; 
 Mon, 06 Jul 2026 06:48:37 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm25734267f8f.18.2026.07.06.06.48.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:48:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] cpu: Move BREAKPOINT definitions to 'exec/breakpoint.h'
Date: Mon,  6 Jul 2026 15:45:15 +0200
Message-ID: <20260706134527.84808-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ndwHoT8t69LHJY4Y9UqVe8STfqSNwuS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX1ICSwMUNm/vd
 64laNS47kAvh/k1bT00sY+XDd7TNfclHQ1nqAJlOw153IGnm/Rm1TlvkUPINfinf906igpA3XX4
 GrWgzpubLjATfcwYyEv+97sA0NQ5v6WOugGhFNnoLyNhEwfmAZJ7BFligIh4QRjCLNL88H1J32X
 kKyoYbcLgEcUeGfMV6rN5z7CF/wjYCmyhb9zdpGtD/OctZPGCUmhfQgrPBTaISdvjicYoVpCwxO
 1iTPeFX0X1ktcMWme0Dbh67nZIizd+aeYNuml6j2SvnBAjv1Z+CgAiuewHGn9g7K3t1kfrmqrhE
 SQghXtLkQeCyJ9zFj80XGnLCJ8fptK2Kh/OU5K+waj2ugKDWzL9Dv640Ldmg2PSNerFx5mxIvR/
 uLZFwe+SGVE+8H3h/3ZxpcHNuLuiUgimqDJ3ld+nrvNZCfkqqmphmSRZloeom8Sq9IfDrY55GcL
 IvoCboBF7T05iVwL6gg==
X-Proofpoint-ORIG-GUID: ndwHoT8t69LHJY4Y9UqVe8STfqSNwuS6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX0SUbrgA6Jpw3
 64zEMSbD0Yey6vSr7Z0v0DiJxi5ymLOD6m144MEXVCoh39U0TIfA1/qk6VQwFyAZEXJq3REa9v0
 +gLV2AnynvDDFY2ULUY4SiybCfEp3mk=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb237 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yZPQLu4l72ctXTxYlJYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-20-philmd@oss.qualcomm.com>
---
 include/exec/breakpoint.h | 14 ++++++++++++++
 include/hw/core/cpu.h     | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95f0482e6d0..cc6fedd09fe 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -12,6 +12,20 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
+/* Breakpoint/watchpoint flags */
+#define BP_MEM_READ           0x01
+#define BP_MEM_WRITE          0x02
+#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
+#define BP_STOP_BEFORE_ACCESS 0x04
+/* 0x08 currently unused */
+#define BP_GDB                0x10
+#define BP_CPU                0x20
+#define BP_ANY                (BP_GDB | BP_CPU)
+#define BP_HIT_SHIFT          6
+#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
+
 typedef struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 31753f331fb..e5b68bced3d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,20 +1138,6 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
-/* Breakpoint/watchpoint flags */
-#define BP_MEM_READ           0x01
-#define BP_MEM_WRITE          0x02
-#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
-#define BP_STOP_BEFORE_ACCESS 0x04
-/* 0x08 currently unused */
-#define BP_GDB                0x10
-#define BP_CPU                0x20
-#define BP_ANY                (BP_GDB | BP_CPU)
-#define BP_HIT_SHIFT          6
-#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
-
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint);
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
-- 
2.53.0


