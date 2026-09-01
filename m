Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45A5C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LAv-0007VY-4W; Tue, 01 Sep 2026 05:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LAu-0007VG-CO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LAs-0007S1-OS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179hXn1812024
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VTnZDkxqxcWE+Uhz4CNPQNK9aE/+Gp16fw+HxNLxbPo=; b=h0saezt2bNSgO1kD
 WAO94k6ogRLJXrirjIbXLBV+/fhgZ6nNNnO/q5eel7zmuVQFv0gfFmitmdM2I3DN
 fzkI1wwu8vjkioK//sDKR+KSyZ9I8d9bolzVJlHJX4B6hciKc85bq78nHEH1G4SJ
 L6nXKLYZ9NwjOWdmqCuLmos5wTniU36LRu7vtjiiSY3Z41FTB1PbzK0BLtaNysO4
 17RrEYguMRSwemNSbDM2QQDYkcFV+es3Lt2bKHpiGN8QTUlx7/rh+uwQbB/p/99H
 2lJSxFDxBwAjSf6wTcKcMYLiarSsRq8wcbYNbiWHfnEl1TUgLq7skG0tj4+HB27X
 7zGI7A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4dv6nx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:53:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494527488so134164585a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256381; x=1788861181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VTnZDkxqxcWE+Uhz4CNPQNK9aE/+Gp16fw+HxNLxbPo=;
 b=FxRo8CQusyIQ/FDaU1ciVAgBJugE9vRpFoFboQsdrdXw78Ve4eWAdRkZbbeM3QJ/KW
 gxmAxhSxo6jTCaejzuXjSmblxzuA4SToS4RNOnSQpjsKQGqUqVBWBG6OO6KWqvSFMyUE
 wn0Jr2H2g7CcKGR8ZQGH4YXZkXlhKrb6y7nO/IHsXgqzKW9VbgNNd+Q2fLy4zt5QJfrJ
 Vl8kp9COgkUZFDZ0Q8K/VpW2/q+CBbRYWi4ekx0Hw8ApsUQdZdVUPCUrHdGlYRv7z2WL
 frrH66vyPz1vyoegb1xJ8Le0BlxfTbJUl8x7LveNSJBt81gIwcoAW6UpQGAiDqq0FOKh
 vbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256381; x=1788861181;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VTnZDkxqxcWE+Uhz4CNPQNK9aE/+Gp16fw+HxNLxbPo=;
 b=dtWjlLVXvSP/zLY7EwTTiZEnwRAbSICOH7IO72oClJz1lXffe6P83n/lRIkveuYPv3
 RloDR5oxRjEt1ckd5uq9rvOsQxzAadVjvd3qqrUs9Dr4Pun7ZRGGBkEdEX/aa4AZJxCb
 NvT56wsEptvVWGsili2ehP0d6FO7v+PCPhakiK717anGdAikbVWMJQZAf/RYmrh9hJY3
 DzJ9QOrfcaiafv00oICzR+a086oOcMN6qO2XcWYXG4gMmYZi9q9h1tIpsJ1/Cx6dK93U
 kU0zRzmDoip4LINE2OFWMG/L45CQ6aZwnClYVP9nR2lvs04nMzMOsrAMnE3SbCv8rO2v
 mvFw==
X-Gm-Message-State: AFuF++nT6Au8POvlVYkUkZoEtCIOilWU8v/7lPuBCnF4c8XOMEqvxb3/
 OorT0nbHG9fkMMjM+GMZuwruOU3FFqsN+rnhY9ZJqPh6qFMDqSewBrOUd/7xRFLOYBnSiXmKFh1
 UL1m79IG8GX8u7DPEYCK5sPmkY27Taenh3hz6NCFzrIE4Rc6+qIwIeGaGWSmRetAtGw==
X-Gm-Gg: AR+sD10jCEnrZ5YSmU2DdMEjBcX7TijRcZ/GQCIG8fB9lUuV5KTPhyeBJ7svkFd7u/9
 MC6DMNsgzvG62DBhp8Mty740lrIWghcFkj7Dn9op3ns2y2GbtUQOSjFw8MVqgNcO2X+uTC76A5V
 KDzXmjFU2HfI0EYFYPrDCNAya8puFpsqGnxJphqUfepQemkSEFsDLpJfrYg73UcV65o6YPJcyhW
 PRGYiXa/gnqBbWPjZ0PZWcrWxZNpZeK4KxO0662B38fPNpvH+XifXeKXawlkZSuwHkHHSzKvzqS
 0X9dm80iqkCVA1UsXOSxUhfdbYvwAk55DsSrP7yaNXeFpsGYFDQ/YsEmstK1nC/WDEwU2oW6WlG
 LsD9zI5hGtMvbrr/1X1EJWix3BAp4E1kKu5Mi6VFw
X-Received: by 2002:a05:620a:19a7:b0:914:afc1:c66d with SMTP id
 af79cd13be357-939137f96demr3630167385a.11.1788256380988; 
 Tue, 01 Sep 2026 02:53:00 -0700 (PDT)
X-Received: by 2002:a05:620a:19a7:b0:914:afc1:c66d with SMTP id
 af79cd13be357-939137f96demr3630163685a.11.1788256380539; 
 Tue, 01 Sep 2026 02:53:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6e9cfsm3992344f8f.22.2026.09.01.02.52.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:52:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 04/21] linux-user: Replace env_cpu_const() by generic
 env_cpu() equivalent
Date: Tue,  1 Sep 2026 11:52:10 +0200
Message-ID: <20260901095229.72018-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a96a07d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX7zZCSMojngHW
 OMjdLkkaS3kEr2bkw3cb2jMzeQmTqenhe/Sw53Qr5nGX7S8bv+61hResDFKVZMSoGNY7wB0A7pV
 5dWKHQU2/AXR21kzqS+ncXmjnh7uSAZ6PjdzYYeJJ5BzgHRrtXclrpfZwuzBVC+ZJIW0plghNfu
 h3gFS4FaO/E6WKsSb53nBlsnQA5Dh7LYRxcEj3ZlL0qrwLV6pAaxfj5jzOurp6lro5VVa1j+3SR
 X+rsHFm7rEq0K0V7s/vF1jFFrLy4LYlK8u979udVWaBHDjVOK1CkNO9QPh+sDIwqGo/eRhxmQPH
 3x4vpwniRX/NrLmZ675U/ivMqeERXc6ZI7ETB73owxGaRiUzwJGB7dW7cws8XMJLT6llm7wb7dH
 HM4UAcSUf1/5JNsbuPPhvXViRMccTgjvRc301UBgZNhPqQAMt8LcDDKRD4RTxtroXxfp87HVok+
 wlToTfD2jfe/eUP8I/g==
X-Proofpoint-GUID: 278onfzqMbEs6qIlSQ0dH0933LAH_jk4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX9ODcseovAMvn
 kS+mUB71y822ScDHHVNpO30lTLRKOnkDF49W2Lxu1SzobUfq3TmwahapZAMyNC1c9F597tQw8be
 hfFK7duoSPgZEURJsgGEzZXTOOCr7+Y=
X-Proofpoint-ORIG-GUID: 278onfzqMbEs6qIlSQ0dH0933LAH_jk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_CSS_A=0.1 autolearn=ham autolearn_force=no
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

Use the generic env_cpu() macro introduced in the previous
commit and remove the few env_cpu_const() uses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h   | 1 -
 linux-user/elfload.c        | 2 +-
 linux-user/i386/elfload.c   | 2 +-
 linux-user/x86_64/elfload.c | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 60997628cc6..c14362f780d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -102,6 +102,5 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
                 (CPUState *)((void *)(env) - sizeof(CPUState)), \
             const CPUArchState *: \
                 (const CPUState *)((const void *)(env) - sizeof(CPUState)))
-#define env_cpu_const(cpu) env_cpu(cpu)
 
 #endif /* CPU_COMMON_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 88508deac50..c4bdaa146a7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2128,7 +2128,7 @@ static int wmr_write_region(void *opaque, vaddr start,
 #endif
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
-    const CPUState *cpu = env_cpu_const(env);
+    const CPUState *cpu = env_cpu(env);
     const TaskState *ts = (const TaskState *)get_task_state((CPUState *)cpu);
     struct rlimit dumpsize;
     CountAndSizeRegions css;
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 26b12001a3e..2e10f38a412 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -38,7 +38,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
     r->pt.es = tswapal(env->segs[R_ES].selector & 0xffff);
     r->pt.fs = tswapal(env->segs[R_FS].selector & 0xffff);
     r->pt.gs = tswapal(env->segs[R_GS].selector & 0xffff);
-    r->pt.orig_ax = tswapal(get_task_state(env_cpu_const(env))->orig_ax);
+    r->pt.orig_ax = tswapal(get_task_state(env_cpu(env))->orig_ax);
     r->pt.ip = tswapal(env->eip);
     r->pt.cs = tswapal(env->segs[R_CS].selector & 0xffff);
     r->pt.flags = tswapal(env->eflags);
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 49a6f6180e0..121a8167acc 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -59,7 +59,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
     r->pt.dx = tswapal(env->regs[R_EDX]);
     r->pt.si = tswapal(env->regs[R_ESI]);
     r->pt.di = tswapal(env->regs[R_EDI]);
-    r->pt.orig_ax = tswapal(get_task_state(env_cpu_const(env))->orig_ax);
+    r->pt.orig_ax = tswapal(get_task_state(env_cpu(env))->orig_ax);
     r->pt.ip = tswapal(env->eip);
     r->pt.cs = tswapal(env->segs[R_CS].selector & 0xffff);
     r->pt.flags = tswapal(env->eflags);
-- 
2.53.0


