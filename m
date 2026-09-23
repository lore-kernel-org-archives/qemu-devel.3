Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FA8C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QaS-0001NO-Ue; Wed, 23 Sep 2026 13:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXd-0006Wy-4N
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:14:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXa-0001Mp-DQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGU1ZO3106099
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NMMUYlRFOEu4Y+0NjhX8Ge/q9RoTfSWrF7SafoChtWc=; b=fJGYs3VPFpDR1GkG
 5Ms5UCqNUru+3di6NMJKOgYye1y/etGby4orSJZ8Squw2YJMzvGKAixxBYvCPKZ6
 ZYYr+cwooZ69oxuGEWYI2fTaBcr1KPyUgoBwaZFaMm6tGfIlG82N0iil+OreNiuw
 vFEH5HzM0Yu3mB9oDzFXRvvt9pGwkJrMYzDZKHju2eJkVFBlPAN8mJ6SkSztdS4R
 8dduiOk6buUQyL5DwkywCHd/ICJkCH94IZPaTbK8okAR7yOX8Ggg+pt+TOlLlpQF
 UzaI8IawwxJ+4p7bydE95scWMDRbdG4+RST/1mkRiXZcqsFLQrt2rbLrwF/k+At0
 PEeNCQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwh15a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7a8e3cc28e6so61351137.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183623; x=1790788423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NMMUYlRFOEu4Y+0NjhX8Ge/q9RoTfSWrF7SafoChtWc=;
 b=AIsQrkRNhMMdmBF57mxstSIWACBBuSwFevrAkdpcXbew7nof6SitDnfK7/+b7hZdnU
 COSwHWpTu2naw/h8S8obV4fLJ8+BcmKVC3z0hgaq0CF4mOitLRumXF+QMzGWJS2qjWPO
 Q6cMlhqvKBKTORbjg365zKs5ea7QYFCp4BkRE31mBw7+7Z6DwlDn//RWcKYwPPFrlcry
 OnXa3W+NM9Tcp1r8EovpWi60eyJMThGO3WPRhM5lvs4EcWUCS3lIiv8IHkG2GEgLeZ+L
 4WrV9l8tQpxsL9NT9sJf1pC5ANurGaaeZxgXGcD6BR7DV/UDxz8Tx4x21NXVv7TUPhri
 l+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183623; x=1790788423;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NMMUYlRFOEu4Y+0NjhX8Ge/q9RoTfSWrF7SafoChtWc=;
 b=Pu/GdJce1XJ1JDnDBKYkBS7j49ENAKVHkidmJ6KD+/lhaObLJmiDxf8Oc+5+lEmINU
 Nr5v18x8Gs036I6G4h2QGxNDxZGh18dt1PoPRXQs6M3L6VbbVUzBMBjEVY3kKPUnTo12
 rvz++rhXP4EfP3Y/ISNCgpVIeNhdUdEM33xj54cATFAzWoXyuTW2fSYPIQ+laCrbgDgG
 BctuurSymxo/1l2/4poPDt/hkWQvrRfM2wKIORzAlG7Dc7GLZvGKKvzVzaj3V8DEk96x
 twCk/tutpwu0nfmuF1Wv27SGlSmWwpuIUKHmWQ361iSMYPR2lenWqOpYw2tW7po8edAq
 fYtA==
X-Gm-Message-State: AFuF++lLGfhpnABEy7uvKAzYWEg4Zo7ASPh6p4M3sHT1NZVhunCy+JUs
 OOssDwzUX04aWKLuR+WBSpv5ndUXXpY7EyENV+wnHIziOItzSwiE/KiPlLDEwcH3e0l3pmQrO9I
 LdPDCGcvfn3X85DUp7ZiFOqZ65PABQkVuDqJ5VbqXB7bW+tvO3s5MFjrrmhEW+3tX8Gf8
X-Gm-Gg: AYBFou08eL9t68x2dhCjv51NS+PdBdoVxlx49qnxA/1phCIevJSaomOgSZgWJnOS0Vp
 yuLvCB8R/cOw2aa1VCNZSpRxjPiF7tD6UB00SZzYs/guEVqEy9Ph5YTTPEG3uo9La5fqwFTSZdj
 j+t6VsikTAbZTaupPO5dKkC9NlCGpxRIdrAU+H2t/BwS6tBMWdUgbtdIzcg/x1onRHZSo9OzVbS
 jStXpO5KzJGwMtOJ7KR09Huz64rZqGbWVrgikWdCkCVcCPU8rUlshRUHjKuYyFnH+ZnX+JNByQu
 TVaNOJSNXQVUeSJm3kr37o0zr0Xv9j3mg9h3f9bgKUOYLcSX6hCDb9r0Gw85J/5Qz/T7vjSL3fD
 U4tRIEnhOqrf0RjBzG80si+gsO1cYH4Sn93wALF7q
X-Received: by 2002:a05:6102:8192:10b0:785:6b42:b7b0 with SMTP id
 ada2fe7eead31-7aa9df8e032mr5426520137.4.1790183622740; 
 Wed, 23 Sep 2026 10:13:42 -0700 (PDT)
X-Received: by 2002:a05:6102:8192:10b0:785:6b42:b7b0 with SMTP id
 ada2fe7eead31-7aa9df8e032mr5426502137.4.1790183622364; 
 Wed, 23 Sep 2026 10:13:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877970fsm8890958f8f.24.2026.09.23.10.13.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 19/21] target/i386: Split leaving-halt handling from
 x86_cpu_exec_halt()
Date: Wed, 23 Sep 2026 19:11:13 +0200
Message-ID: <20260923171116.31276-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX5CSNfHJkZE0W
 PkZEB4NfovU2yTDFLpX8R4XLlOHSUdTlWwwLn5GuWw6LmXmyiU+i5KyMBfLMRKJrFf3y0iQACnt
 b02xJl3VZTBll5RJQvRcQGR+7/MGww1m/hqE0irBsPB8MDkDRnn3ISi+Q4NZItTiOqY7GvLpCmN
 n0G//j+ZtuYowRekDNPGfn779ZL3ZuGkBiom9pn8RCpMaZi7ka9vg23KIuRppGDuHb/ye5fmLx2
 3ekW6jECZtNQ+aRauY54mbvCOC+9RJ+0Q5CuAg7OGlR3hVjVbLmUaLlrzzdkyXYk5T8QaUve/h9
 hRUTEgv75JGIHBcvIbXcwp2VDGPub4/eq5vOQog89B4w33D5w/MGv/WCSwVFzSMJjWcW+bp5zt0
 XLrLCnumFEDXGZyHZxYsWL5CZa1Ja0JyhxpQuEKhN5UX97mfbmGvo5GSefuSMkbFQ+J95Rau7Ss
 WvLtvFQkBiZtIrS8JMw==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab408c7 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GiXQl85om2WzCxkx9rAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfXz/vo8OiIqBEM
 yxuJZVcHiYU4wws1e6rsClj9jP2vp7ayikjRN535RHCuXo7Afjo9NjB73bqWy1SmJvOSV4/IQ2R
 YM0v5X2s+Pn0WSkVXfoEXDHG1KrBDjk=
X-Proofpoint-ORIG-GUID: wGvbV07DR3siPlA4i7DX1A1g019xe9UA
X-Proofpoint-GUID: wGvbV07DR3siPlA4i7DX1A1g019xe9UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move debug exception handling performed when leaving HLT into
x86_cpu_leaving_halt(). Keep x86_cpu_exec_halt() responsible
for checking whether the CPU can resume.

Document that #DB IRQ delivery through do_interrupt_all() runs
in the vCPU thread and does not require BQL protection.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 58e8ca0bc1b..96accb30a80 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
+void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 9ce608a0bb7..566b3d4d80c 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -140,22 +140,31 @@ void x86_cpu_poll_during_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_leaving_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-
-    x86_cpu_poll_during_halt(cpu);
-
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
+    CPUX86State *env = cpu_env(cpu);
 
     /* Complete HLT instruction.  */
     if (env->eflags & TF_MASK) {
         env->dr[6] |= DR6_BS;
+        /*
+         * do_interrupt_all() is the normal TCG exception-delivery path
+         * and runs in the same vCPU thread context, so #DB delivery does
+         * not require BQL protection here.
+         */
         do_interrupt_all(x86_cpu, EXCP01_DB, 0, 0, env->eip, 0);
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
+    x86_cpu_leaving_halt(cpu);
+
     return true;
 }
 
-- 
2.53.0


