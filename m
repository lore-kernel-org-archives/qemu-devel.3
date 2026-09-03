Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4335FC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24tu-0003iK-Ig; Thu, 03 Sep 2026 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ts-0003gX-GX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tq-0006rM-64
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHH603782437
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ERReEaXdeWam22GR8Ul5fOsg6IlyleQvlAQu5a4eTpU=; b=GVVhtHFj2eZT364v
 RKHuTd8C/BeHiZ9z6ABYRVMjLiVXk5GeaqOU6e9MkDD0motZwsvlWS9oO0QalCpm
 yUiGYOZCPX6yzmd9QxoJzOFQMg4kLlOMO2RHspTqrv9n5bD1IoMZVAJZRNckStM9
 teEW1qH53jAMLWT3ODvAU0QPVYGQJES+KO5mEIDapwI0huy5aaK0dKFu3FY1o70K
 cgDawwkyNRkadG6ypofUGqUDgJnMAFuGiHqDsYdoe/Y655XuqCCW7IZeym2drOYo
 4TdWWxm3Wv6OALtdoj3Q/1Hrc7ZEzhXSwWhwDVWDstKXKa10b1rPtdF7NLW+g2Rt
 Jtct3Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrfyy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9102f07f2fdso15339466d6.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432149; x=1789036949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ERReEaXdeWam22GR8Ul5fOsg6IlyleQvlAQu5a4eTpU=;
 b=OHDlunb0OCkAip7euOpp3aODRTqGze+AzSRqRnK/Rrbcs/MOCbZfA2HQrISxcGo8kR
 hr6SgTJF7YaApoAzeKHoCuQcNRH9K8WAfJSVs1VaYK9Sq/dbm2lqBP3/K2HXd/g5Y0Ew
 jMa0V9sf0Tq5ma4Ml7MdGVtMBaKi3nl1N755/V+Gv1wCR/fnED7xm46KVgvLNbRMp5cr
 0CD7fxBJqzz5xFB209NR1kv6+z4cpj0xkBZuuZ8jAUOeRfQ8Pu8SWWE3/500Ad+aZ4d0
 7NMnG2OUq5kKauA6ioMacYdfh1z6IgmTBuSHM6r7yWA6wSXyh7fkiM52d8+s2fm5t7Sr
 Eljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432149; x=1789036949;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ERReEaXdeWam22GR8Ul5fOsg6IlyleQvlAQu5a4eTpU=;
 b=IkaqAfa5iswNC//EJsOWK6nzcuEqo+FqDTqX6Qn1hqCnCJFWeB1pYIv3jYGpIIso6x
 u3Fw/OUqYbk6utUwSQ/cXFCi2N1joqBAuGfQbG9cE0MQF9GqSSeFj6/CHpbAc9+L7mwD
 OfR2Q+jo906dcd/qSbpeiwEz/0yYTTa16td70e3FRpZiGm4Q6YZ2ownAWK4ibRz2gmHu
 7WdbYTCSOELq3Q6CeDRrYu/8KPS3NzYnyrTQr4cWTCS7I2hnZXWevgq3xWhnoVZZOo3n
 N+eXO9d9uJPyH3bWgOdypWJGcOUpw91zOfqjfHBR860Yuq9DRXfwu1Mzsceb/Re00C6q
 XP/A==
X-Gm-Message-State: AFuF++nD2sxTV0IuCUQXFZhOYpilBuaATDbIGyMiMJ/iFgaAbzIut4ZM
 fn43b67DompM2q0M5KyMhuNx6nXb/u4YDc4e8Q+kEVIgUz2c8BuKi7X1xAIMoCChhKlKHaB0066
 kMFN5BKAkXVGq+ZABJtYHqDypxQWLYlzcfRLH+w3YScY7pjOhNZ3JvUQGOQ+6+pkvVw==
X-Gm-Gg: AYBFou1C6b6+OGrxpyQx5yLIxAf+4eoFXKhwcHUexPrPZpilUsg4bvaj6U29vzCXrpV
 P9OCxOTwB/gBVBEHgPpIaduNPG1HbYCUIqztlBQxQOLb/6Z0CejonMZGboTU6lYmKsOJPCvQLQ5
 HRaol0EK/Qc2m6m2EW967WPLt0QdkgmcGpoom4vTWL1UkQkNyqK52dMmYNdZqcWI3eo8jp1gbiG
 i6vnTse6gga5W/nZ7QadSC526h+U3li6nQ4MVIvUV3ueeySTc6r2/rTJAG7V82QhdmblXhyqLST
 YyF/VdFHeb5bkkMvQEEc0+rsRu5ovM2r2QRXUigEMbhhjZVAvquUxpsMedKHeMhl1cgo0D7tirN
 s8hD1VGWjKFgOesqk/p+74dmzEkrkYUSIPlG8uA7b
X-Received: by 2002:a05:620a:28d0:b0:939:72cb:bae6 with SMTP id
 af79cd13be357-93972cbbcc2mr193211385a.29.1788432148628; 
 Thu, 03 Sep 2026 03:42:28 -0700 (PDT)
X-Received: by 2002:a05:620a:28d0:b0:939:72cb:bae6 with SMTP id
 af79cd13be357-93972cbbcc2mr193209085a.29.1788432148167; 
 Thu, 03 Sep 2026 03:42:28 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm61255935e9.2.2026.09.03.03.42.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/51] linux-user: Replace env_cpu_const() by generic env_cpu()
 equivalent
Date: Thu,  3 Sep 2026 12:39:07 +0200
Message-ID: <20260903103936.62355-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXw9+15UtHi+cI
 uRMh6jYiePa+2K7hQUfP78eyFM0b+2ujeasV7Y+c1flTybH/VBGG97Vk+Yt36ybsrdq4pMYtVCV
 zf/3FZ/nJkp+dAEC6cGIsQvm8+p1Edc=
X-Proofpoint-ORIG-GUID: DCPXinijXfkygppVesPZIq5EbbsC1b4x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX0neysQhuDJRa
 nY78O3G4s59KdVOu/YLJPHBnNtEOmvlex2EmvdPDYhdfwcQ881OmUfI+SVfQdYOnoQ9NfAoVFJM
 mR3SKHovsnyfYoNrMh35dBPEcc4S0UgGbmHuFFOnWICxIjcZmHubvUa7xZ1NC92MeuzjaRDE96h
 ElbHLO2kYMKCMB/3+2TjCksQ7LvgTywBJ+bCZWxbdD2Nrt5mky0650n2JqBkef3sBkF6A/p+EYU
 6lGPP013yY1E3vvSj9nDAgcIrlpulpnQKblpCcYyjd2411Zkxd692IcDsngr5j8jB2mQOGM1C0b
 5PqQAeQ2JbyKn5j8kYOlApsP9jee3YVxZ1h1njPRAu5Cul4SiKr4o3ta1nidYa8iFKAS2vjKSiQ
 cukggr+RRRR2snWUW+IM0+BfKrE58UtXMnFiaUiuI6MpUKxJcxYalsPvPTtzmHg+VM9NhjjQ0R8
 jIHSuIVW2/nGnGe7Kmg==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a994f15 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DCPXinijXfkygppVesPZIq5EbbsC1b4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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
Message-Id: <20260901095229.72018-5-philmd@oss.qualcomm.com>
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


