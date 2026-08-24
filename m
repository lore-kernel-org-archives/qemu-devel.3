Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798F3C61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySiM-0006Gg-Kd; Mon, 24 Aug 2026 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySiK-00067a-OD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySiH-00067e-AP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99cH72572093
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fvBIYCS8kU8+XY5bs75QoBPYP88ZzMJVKYNZ4wSfBZ8=; b=D8ej8BqNZtAoHC+A
 o+uwvXZNNwzIE2MsV2Bk6gAvWcJHZMa4fVSfZDwuwu1we8+VInmEyRmDsEL2tbpN
 o04AqoN3OFvTJE2NDT7estHDNenWmVkuN0i244JIEVdl5VKtP8bXfaLZe5k2gNAQ
 db99G9GfgLm9Uz2LZLaFciqugWcbncHk+5eEjQAuljvE4Z57g0X2fSv0uWQw4I92
 Z0HBEy2/Bj/eWV43s8Nb5IcbwuBuvvGwayMg69YeU3K0nBnyvCCZ3oP0ztQ183/M
 C7SiKUJpoIWc2+xTAx/gb6M/AY2vWdBf0WQy8Ji5yiYeJzZqLGJHcbsB4MnZymqg
 qKF8HQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr25uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9778b29c71fso3250418241.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570375; x=1788175175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fvBIYCS8kU8+XY5bs75QoBPYP88ZzMJVKYNZ4wSfBZ8=;
 b=BzW8nc/8le+FkWAWGCMzlUbZX1O+wnz+zHRk+wyofrtmnMxTrHNiZReE/5MFWkYwPI
 Xjk/pE+hMk9ATfCMdgeC1grYLOIOTV5fG3qIdE4VBMqa0ySM0yvOyYWJMtqRZApiT2Y4
 OtoJwHXUdC9xUi+1WX92Hz1vs6iRI5xluVTQv2Y/zqloFj3DWlGYwdP7Xpd8gMEWgu+6
 MPoRugff2ez/92L91OCqhGNPUXRvu0mxxOSX/27Mah/V9vD8mrTeUIGzLKDvJZ0GKoBz
 ngjzr5HY8EBgnSqYXaHXfDLFJvUErk/4ph7PjxjIUfwmjFI/ViTYBEx3SsHRfFwZ+Cao
 o/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570375; x=1788175175;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvBIYCS8kU8+XY5bs75QoBPYP88ZzMJVKYNZ4wSfBZ8=;
 b=kSBiVSLKSMH0ZGEjYNJ4rrZdDphmFA+gLilo4DuWBDrBFYIhoGEgp0zB+ag+Tp5uaP
 5o87zKIe7MJncTXry7+J7HFWDGuK8ivHDM+1a3L0YRrLcEdGJlMumbvGdtBHmpKikSVT
 eAPdTeyQJShrz+7bg48ndrdD32UIms9D0h+v1FPDTTtt8HBRnadU4tg3zTpaDvk1RcmQ
 Ljf8wTxAZNOAJtpniKqiMmp3vpvL0GZ1KQ55RlSGZ8+N6v7JfFXiD6gtjGOnZl8nYOga
 rFKqnYhl/GAp1F03ZB8wyQQ2Ryd47A4Cm+9V/CMhxXjbN7OOKgNnXOdghGJPPaVJbeX/
 DWwQ==
X-Gm-Message-State: AFuF++moMXm4rSQuHprVJR00zQ0uzC/mvkuNN5x2aaaTI6qIvGG14m1i
 CvRJbq9ZVfVJptvlJYVB/shDU+p+Rjf6PwfJJXPn5deuSnGhAfQdJdjvA8C/KkfjpnJO9t9BvHW
 GLZmineD3D6PdPpyeLwqkXpC2kZP+99BGRZOQnwqgCgpa1/gI4EasNyGb0yEhDqt74A==
X-Gm-Gg: AR+sD13Hwq2VtVAknsKnKUcdIkwszAj6zmPC5raTio8ANZpFBcykhA+NeriRkegiGrL
 q6IAwQPg2pTHy8XvpsV0zmhfN2uiikEQAaoSKF7Gkve7kIOSHARep+IDM9/vu40JUykpxVXDcHq
 /827EDwxng7Vw7/v5pnih9xow01wHObkdydYJl16royKYRNj2K6a0ro8KXRGAklZtC0AK2eDCN0
 lN7NZfocNePxSscbUnonCeqBnoO1dk3JvAMxONYlQpxu3sQNbj+cWiDB1MSdM3wy6f/DRoLsaP8
 xIHN8+INgzZu/YIRjAcbE3IV9/dUY44/gcxTP/2CDsQ2Z6RIVauvNJrz2s8xlNQPCkMpg5qzC/T
 gDbRWxKXkacjvE+pvlCseTB/mU2LFkNCVNQHAue+X/NRjGKdsNQ==
X-Received: by 2002:a05:6102:f8c:b0:77a:7cd:8473 with SMTP id
 ada2fe7eead31-77a62847969mr10938773137.4.1787570375589; 
 Mon, 24 Aug 2026 04:19:35 -0700 (PDT)
X-Received: by 2002:a05:6102:f8c:b0:77a:7cd:8473 with SMTP id
 ada2fe7eead31-77a62847969mr10938752137.4.1787570375247; 
 Mon, 24 Aug 2026 04:19:35 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1ccf69sm8666438a12.25.2026.08.24.04.19.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:19:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v4 13/20] target/s390x: Constify S390CPU for cpu_has_*()
 getters
Date: Mon, 24 Aug 2026 13:17:02 +0200
Message-ID: <20260824111711.26297-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX30Rm36FeOBWG
 NpP16psEIyDNiqfjbpDkDj4dtj4cEbsXUZp0ZIYyfFcE7pX+p8T1HIzcnNGBgmMdFQQ2twSbMe9
 7lVJjKEhjf8zueK4HK1OKisLSFq1b6IwUVk2KJUOxqWuKbcLPXz87pRjyUV3TXCl4BSQeozWPAV
 rfCjmMVHgy1kRnmDpQIMPm84U4/xRS2zDgXy4IETbBuuESWsf3izHmYSZRGTh9ggcPCEb8v1fn9
 CTbdThQTyRbTnr55yRomC7SJTJKZwY0maVuAPMuG3JwOYk131MnJ7higeFYaDUfRtDVIwjxz8hK
 oM/3ljbUAI0xJO6jCMfqS+ddhrydqTNAbrooH7mXCdCBx/Nty8uiWuRvy1tVONmZhvlK3OPwQW5
 3cAO5w6EBPzwP/h0TgY+zPHQR9915ZszA46mvsAeq6addGxJl4AdbAiSQzz9uSltnsMY7z67ceF
 O+mucHOSMAhMD4yOqMw==
X-Proofpoint-GUID: oTyJ5k5_Lmdj64ZekswgdBPWXjOBztko
X-Proofpoint-ORIG-GUID: oTyJ5k5_Lmdj64ZekswgdBPWXjOBztko
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXxuVWD7nF9K3n
 y5YiotyNttaZkuGGj+prumH44FpmCO8egqCo9vMZ2Qf11qgYitPlLCK3g+f5vi6kZmbp0UppScG
 xJ3qIwjX5/AIQV+CyNXOBeFMo/rxrXk=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c28c8 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=mU8mmpTTODwToQi1tsoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
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

Add the const qualifier to S390CPU when the argument
is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/cpu.h            |  2 +-
 target/s390x/s390x-internal.h | 12 ++++++------
 target/s390x/interrupt.c      | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f55b79ef8ac..998bbb0d7ff 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -854,7 +854,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return 0;
 }
 #endif /* CONFIG_USER_ONLY */
-static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
+static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
 {
     return cpu->env.cpu_state;
 }
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 50782fac3ce..ca4445e6474 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -333,12 +333,12 @@ void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
 int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
-bool s390_cpu_has_io_int(S390CPU *cpu);
-bool s390_cpu_has_ext_int(S390CPU *cpu);
-bool s390_cpu_has_mcck_int(S390CPU *cpu);
-bool s390_cpu_has_int(S390CPU *cpu);
-bool s390_cpu_has_restart_int(S390CPU *cpu);
-bool s390_cpu_has_stop_int(S390CPU *cpu);
+bool s390_cpu_has_io_int(const S390CPU *cpu);
+bool s390_cpu_has_ext_int(const S390CPU *cpu);
+bool s390_cpu_has_mcck_int(const S390CPU *cpu);
+bool s390_cpu_has_int(const S390CPU *cpu);
+bool s390_cpu_has_restart_int(const S390CPU *cpu);
+bool s390_cpu_has_stop_int(const S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 1dca835c5d8..d7e3fd45e4b 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -139,10 +139,10 @@ void s390_crw_mchk(void)
     fsc->inject_crw_mchk(fs);
 }
 
-bool s390_cpu_has_mcck_int(S390CPU *cpu)
+bool s390_cpu_has_mcck_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_MCHECK)) {
         return false;
@@ -157,10 +157,10 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_ext_int(S390CPU *cpu)
+bool s390_cpu_has_ext_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
         return false;
@@ -199,10 +199,10 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_io_int(S390CPU *cpu)
+bool s390_cpu_has_io_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_IO)) {
         return false;
@@ -211,21 +211,21 @@ bool s390_cpu_has_io_int(S390CPU *cpu)
     return qemu_s390_flic_has_io(flic, env->cregs[6]);
 }
 
-bool s390_cpu_has_restart_int(S390CPU *cpu)
+bool s390_cpu_has_restart_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_RESTART;
 }
 
-bool s390_cpu_has_stop_int(S390CPU *cpu)
+bool s390_cpu_has_stop_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_STOP;
 }
 
-bool s390_cpu_has_int(S390CPU *cpu)
+bool s390_cpu_has_int(const S390CPU *cpu)
 {
     if (!tcg_enabled()) {
         return false;
-- 
2.53.0


