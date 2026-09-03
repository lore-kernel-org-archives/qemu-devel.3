Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC9C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24uE-0004X3-2X; Thu, 03 Sep 2026 06:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uD-0004VD-AC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uB-0006uB-Hf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHHOE327193
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 24k+NmDlKHqucu5k9Mwo/WIRUV6E4FqHBbmZ6C0Ahw4=; b=L3MAdmM8deU8POtB
 TPAELd5dRpEmS/0XcyCi73QRYUP6USndB2mrupealrSL42+Opf+eAKriNQmcWup1
 h3IPnxuAGMPaOV6cXMJ6524GscKMvrbv7fVU3iBXYNMttp+LSg7mdNRJM1Ihi4qx
 kI4qDD1cnjS4BC7RZ7Lb3a1Bnk+ZjDBnzm2BlmPLhXQi/4PL1Qs440jcAcE6PKWa
 1Xs6AulI83w7I1OWoZ49sRXTnOaqEh4fIZmplzmTIX8Fo/EyOcVgXMQJ4EF5/sbz
 qOTFO3Q2nY8pyQiaXhUc4Kbf00HxsTewmmq65l9FOS9cJ266fyeig6wydbuK8w9M
 6PhK+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekgtpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so420284485a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432170; x=1789036970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=24k+NmDlKHqucu5k9Mwo/WIRUV6E4FqHBbmZ6C0Ahw4=;
 b=DbVAUDruHClqBB41LtnVi/XUWQ+7t+2jTcqpotH06dacV/N4p/IpPXUm6Q6jpRlXOQ
 dUxccYHXrtD2P0BQNocQYvmy2HR/BGhpUlweourvqjO1VVt8Ux2WcBvuqzvqoLpceuBT
 F6Yie4/E4HowFWgkDj/r3yFCvkhrWGCfYQRV+heeXHcgEwnoDw4OabBPx8q3r8alvku/
 Z17cl9FcUYmCKADB27jLd+XVm4K/uGCW8fNtEuQPjV56M4I8tq8r9HscWZz1Ae3PkuUD
 619Mm9gUM865ClNqCkdReLZA1maHKf7DcjZeWEvt7QxxriIXWmF1S52ice7OD+kAQhQ0
 vpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432170; x=1789036970;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=24k+NmDlKHqucu5k9Mwo/WIRUV6E4FqHBbmZ6C0Ahw4=;
 b=q3vhW357Ko1fjcHsFj0b/Eq7XdDi/z2Wg9XTkuugeA/yJp4/UZ7SgBK3K4FH6Ey/uH
 M6rpyajr2wys1gz+sKVytG2Q0LYAYNbZizWFYchIZL2ScfW/NWmwFUnO8VRbLc1Z2f0Z
 KrmNcbo3/5Pr2ii+bW5zzuZmDzVF7LIzYbVz3f2Az0xlsis7ewJDqAUalMfFvrsCsKTv
 2tGTadCPVGIGIfWjJFSdX6P9lNTIo6vlIOv+86AIEa4b4sNna3Y1rLe7u3eFWKXI18ki
 bO3s0iTnv3QuzNiAAlcJU+9ugp/W1sMols7wvTb5rJu65DZFGPI+OM8HJXyL4S/779i0
 L3qg==
X-Gm-Message-State: AFuF++klBZ5B3O22cbz7bHrjiadC2hLbIYcQb1oE+Bmtxl7BLBULTWcZ
 r8EKDo5XADjfzAZZA+VMhpbDwJEO0eciYKZ/uKJJYsVry93+a3U2bTR9vvzUz1Zgb9i3atDCxc/
 9ixfzdfZp5DIiUOlIF5vWsMVnV2Ll8mdehXJKRim8LF7As5ZsQtFH/fDEqAP36pWp7Q==
X-Gm-Gg: AYBFou3V2YHJTVklKGTRRI+6aPiQ7QA3ecRbLchycXWz9s3xTJaRsFMmuqoEKI2VKU3
 mpq0sbJh9Gc0HPe7gwf+Yin05Px/PT8St1XDbQpfuUb1TjhwH3AmvjNEHNbJ5089NR/heDDAr9B
 JWOpSNFeUfgckPs3Ra8aTusUoBMSSfC1PtmvhlDwq0M4xl0ul77Iy65RVXhaLKL4PRSwgok/Tsy
 mgi6+VK3HAXD8Y4UlVR/vipr7Tx2smeylJRXynXQ0YlIyLlBc7PpuHFApATXzP7jUNT563UoZjV
 jup/HAYS7IQiDUGJvKR0iRSDQIFIKqPH3zFAYoMYNDiz7fkx0+Z4yKKr09mG+MmjTbvovvwxIUr
 8FjYA0HiW1Op3Mqfh0m6uIqw6H7p/9Os06ROFXRrc
X-Received: by 2002:a05:620a:a190:20b0:939:27b1:66b4 with SMTP id
 af79cd13be357-93960c6c960mr1016085085a.6.1788432170029; 
 Thu, 03 Sep 2026 03:42:50 -0700 (PDT)
X-Received: by 2002:a05:620a:a190:20b0:939:27b1:66b4 with SMTP id
 af79cd13be357-93960c6c960mr1016081985a.6.1788432169598; 
 Thu, 03 Sep 2026 03:42:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3840sm13725034f8f.17.2026.09.03.03.42.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/51] target/hexagon: Constify CPUHexagonState in
 hexagon_thread_is_enabled()
Date: Thu,  3 Sep 2026 12:39:10 +0200
Message-ID: <20260903103936.62355-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FF3shs8I-BVo0L8hvZ1LxcFDTxEt08m5
X-Proofpoint-GUID: FF3shs8I-BVo0L8hvZ1LxcFDTxEt08m5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxsbxW39Bxroi
 s2J2iDrGAGb1ufrphdhn14gGRmS+oyvV4hcpQmPUswRn94NPoE3cAUaomTAIOQ3KBVIUoXjPiqj
 RxKYjyeSjA9Cv7rRwm+lpVFFCopJrgqdvZ4XnRTzWws1ancwlL1vrudGsRf2/HgiHHV5lkIPhB/
 vu2H1Pxd0ItRq1j1HJdKcpfEVXk0jQBuCod2d+PUBtTK2WiexG0Sl0i05SlUSFeXv5nXpwahbSA
 yDN9vwXM+U9K6D6hKJDvz8glNNt76OqElWWZFJmZltofZv+fbPlFsqhE9Ig2TK3tvxNLJywXjAa
 ZRDTdEBjxC931V5MuDUvkZWol6P5yGJFenQSYMtw+NTbNva/IxrWE86RUjodmX56foVuZYL63ls
 Xisqx+I3o6LWvp5e9w+FqYGBvQjQrQckQoedptHCyeXCf44RmA/vzrBI6m86h/f7JzgRFL1KuMl
 KiGdVzxQOb2mm6E84Bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX8RYLz6Xjvz9w
 1X2hDBFYpxmijeblNUeNsirtss+vhHsKwT/63a18g1KDL1cwbIZ7+xsR2JrF57NCXLk9/CbYQnw
 dQt/e2pWswIHevNJ6jXfEdPqa4lCppw=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a994f2a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=XxrlQHdRtCO5bKJNttYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

@env argument is accessed without modification in
hexagon_thread_is_enabled(), qualify it as const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-Id: <20260901095229.72018-9-philmd@oss.qualcomm.com>
---
 target/hexagon/cpu.h        | 2 +-
 target/hexagon/cpu_helper.h | 4 ++--
 target/hexagon/cpu.c        | 4 ++--
 target/hexagon/cpu_helper.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index ed5671abe5c..8a4a81dc26c 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -217,7 +217,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
  * @return true if the @a thread_env hardware thread is
  * not stopped.
  */
-bool hexagon_thread_is_enabled(CPUHexagonState *thread_env);
+bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
 void hexagon_cpu_soft_reset(CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index ca2e13ab1d1..12512efd74f 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -15,8 +15,8 @@ void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
                                uint32_t length, uintptr_t retaddr);
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
-int get_cpu_mode(CPUHexagonState *env);
-int get_exe_mode(CPUHexagonState *env);
+int get_cpu_mode(const CPUHexagonState *env);
+int get_exe_mode(const CPUHexagonState *env);
 void clear_wait_mode(CPUHexagonState *env);
 void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);
 void hexagon_start_threads(CPUHexagonState *env, uint32_t mask);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0530ec3ca96..4a7b76e3bcc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -346,9 +346,9 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-bool hexagon_thread_is_enabled(CPUHexagonState *env)
+bool hexagon_thread_is_enabled(const CPUHexagonState *env)
 {
-    HexagonCPU *cpu = env_archcpu(env);
+    const HexagonCPU *cpu = env_archcpu(env);
     uint32_t modectl;
     uint32_t thread_enabled_mask;
     bool E_bit;
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 17d6b4eb2b4..9ce260d7448 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -316,9 +316,9 @@ void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause)
 }
 
 
-int get_exe_mode(CPUHexagonState *env)
+int get_exe_mode(const CPUHexagonState *env)
 {
-    HexagonCPU *cpu;
+    const HexagonCPU *cpu;
     uint32_t modectl, thread_enabled_mask, thread_wait_mask;
     uint32_t isdbst, debugmode;
     bool E_bit, W_bit, D_bit;
@@ -488,7 +488,7 @@ static int sys_in_user_mode_ssr(uint32_t ssr)
     return 0;
 }
 
-int get_cpu_mode(CPUHexagonState *env)
+int get_cpu_mode(const CPUHexagonState *env)
 {
     uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
 
-- 
2.53.0


