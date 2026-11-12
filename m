Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC9606C724
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SlGKKz9A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MvwhR0KV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVPs-0006iF-EG; Thu, 12 Nov 2026 09:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPV-0006So-Ls
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPS-0007S3-HT
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:17 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACBVXOF3476859
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LDt9m4VL31vta49qyUdzCLLxgvh4VaLWpi+uQnOPXoc=; b=SlGKKz9AH8xnh6AW
 UhMeddt9jiQ5f3AEA6jdE/KAgjX5WGRb+QDHuRcIK8flllZ4rzWhenQGWuqAwcmn
 qRKnOBRng1lMZLmD8+2G5afc4hbXvyl8Bg4W/F51mniHqG8VbRMcepQd8iMp76ys
 RKh1h6dgNxSX64EVqSlAm15zbbpgv+2Q7ISuiP2894jiomd5eazkZaez2ogJKPRS
 vg7Qh8fOrwUCo2Re9sFsXZeG05j84Zd38o3E049rGyAdRMV9wUeMhMF3ADP/1vfd
 rD5/82gGtcL1SOvOKtqqUwmA5boEOQiW3UdGZ8UYA+jxKUVukUazZFD/tmMhyque
 6E3I5A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuhu46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:12 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so5631432e0c.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492251; x=1795097051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LDt9m4VL31vta49qyUdzCLLxgvh4VaLWpi+uQnOPXoc=;
 b=MvwhR0KVLrZQl0Ry7msEpVnS19w95W8O5pI52eIZJLQycPMvWIoFIOFjYXADM30RSV
 ZtcNMfS5Set11YBWu0/FCBLANubY7ojCD0iWEabGyun0qWSX7BSmN60A0gyKypOWE5JX
 MPNFQ1zxJmnk78r/tI7Ai5yoJPlIfsMI5iXCWAwvTaYdCU1M9dkjq/oyLkuRnyz6Ui97
 fO0XByfUzyppRYuyBGKIM6Y7BQZLcFzCvNpUhQ7mFhvlTWU8pUh6UlIyI3cmIQsUUfi4
 dOIk3hKLMTnCAg6N9Jiu3TC0LqUimoxQ4iLdG8ogbE9fr6SZyF8lwRD6CoNv/PAukCRc
 9log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492251; x=1795097051;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LDt9m4VL31vta49qyUdzCLLxgvh4VaLWpi+uQnOPXoc=;
 b=Gu6lafn4HPxxBac2YBHzaVZ/SkZXHLXNYObzHUGVmajblarLD2390oEN3wgFn+88QP
 jR7Omx0HfHtPaVG0f9+5sqisPp6YI/XC5YD2BDpuday0S0/3haCbO01SbeKTr4/cYHni
 S96q0VHyAySkygDUVR5Vl4TzKN6tyZRcdSR7+NSep+jEk+5cW6Scx20CbXZF+BavU0Bv
 T0lut5qcSyImL7gBlBEoq9/jixqamGzAuzV0BEFjZD3a5phwcBstnCWX+7Yi+qMOd1WA
 I+auoRhkI1c/6GkSk5T+gACmSCqYZSlfTnxQ+wklKDYPMR58AcDpDdeuhfYv2OPpRu5Z
 DC+g==
X-Gm-Message-State: APuU4Z/E7RFx4sXAk0hZJXVPHMb2qlWg/WINfAgdvPoXzLS+LIRrbeW9
 55aEUo3av4prb4cdnoISBwuw7ONTwEUegLH0K0avgbLEDmx4Z9h6ibEaALHaomzKB3DIK+diXDp
 hUT28FPSlW/+5xJEtvXbvp6s+WftA0yxzgff4mJNb9mNNbMfLoyuyJf2Yleamw4Hx3hsy
X-Gm-Gg: AYBFou0Depn980VSZ6Rzb6C8ZcU5rii6bdpbWu3VzrrRxYp1XyVcDIJNYo1V9Hk+deg
 m+NmXMkhfN9tJEGhKRNB8qisu0lJNj/pmX3JdJ/Vj13v70WymVEc3Flt/sY/krBANWEGtUdrzj9
 s8p+1btTjr3CjwqWeJHYH362nyIT94R5CwY4S7o3e5lmnujiqrXZHbpXOj/P+xu/iLA8FRpjeC6
 CI7sJGqpwLLsOU70sliY2J1jgYVo7oDBVJqacFDDKY2qoOTGpYArxf60E/TIuz2VSDxWjUIfO9F
 Lai220nOL429B7xp9LmpPLybsIpeeg/g/9BvJPW1h3Kpa5ItdpZB4cxxHLSe/KOnRY731333cv2
 UY14AEIIh+pAi4CnmPm1QsCiP0/7wLkHPOyOGCDc+B2moKYgvRR5ICiseUFsI/SzEQIddLHnF30
 IbXs3cXTRBFzN4dA==
X-Received: by 2002:a05:6122:3488:b0:5de:ee96:75b with SMTP id
 71dfb90a1353d-5ee1c426b9cmr2428087e0c.12.1794492251277; 
 Thu, 12 Nov 2026 06:04:11 -0800 (PST)
X-Received: by 2002:a05:6122:3488:b0:5de:ee96:75b with SMTP id
 71dfb90a1353d-5ee1c426b9cmr2428040e0c.12.1794492250641; 
 Thu, 12 Nov 2026 06:04:10 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e26c2casm65946565e9.12.2026.11.12.06.04.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:04:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-12.0 3/8] linux-user/aarch64: Move CPU/signal endian
 checks to runtime
Date: Thu, 12 Nov 2026 15:03:38 +0100
Message-ID: <20261112140343.61634-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MSNARAaiVn-n_5LJtWn4MDG7IMpqlmzz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX40wXAK4x61hY
 20C89uPFNGiR9Bh5ZxKcihgxpm7hPOG3BanL1LajUBGkvnQhhC4yGDo/iI98zy7xTNR63UenlRm
 ZQbMAc8+kbiv374n5dL20KCfshNTqOg=
X-Proofpoint-ORIG-GUID: MSNARAaiVn-n_5LJtWn4MDG7IMpqlmzz
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5c75c cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=vkEjUumcn_Dj4zhYd20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX41vTAzUeKGAP
 +44Ropw6OCF50mLtKn27V06cuVeR8zlKkqr5nt0a6jzRSH/sENhxlgnFRtc5/8mPO78ZpRExN5r
 2pozZzJDfdEEf7K1/GH0GGn360p1ColQ9tS1lB9hSbDp7hmRKntX3LAP8onVFHCKBgItbgJv3kF
 Pzcg44qL7dPZFfxundBgAoIRJuzvhy3KNLjF3Jlnt9KXjQnC8ga994xQI1zfnslazJP2DBu0QTc
 +rqfnJ6A0JGU2tzi2Zl8Ewi4534WV6sumNCd4jEXmqo01uNGxo9uWwD7rw8yXOX5LSCxkF/Eh7t
 /udbtLBZCStI8V/wYrX93nD85Fhln9hAw9FxYZVgb8PEm2PF1Qv3Xz0t6ONzTY7H9A+23aJuN0a
 kiygHz8lcM0tWImVmvILOrMZskvCvNP7sHIjK7eeZtpf8+YfaOhoMmWcBSX7VprzfVh524VYx9K
 hmIL43uwHnQdHivst1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120055
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use target_big_endian() for CPU endian initialization, FPSIMD
signal-frame ordering and CPU-versus-ABI byte-order checks.

Preserve the behavior of the existing fixed-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/internals.h         |  2 +-
 linux-user/aarch64/cpu_loop.c  | 12 ++++++------
 linux-user/aarch64/signal.c    | 20 ++++++--------------
 target/arm/gdbstub64.c         |  4 ++--
 target/arm/tcg/translate-sve.c |  2 +-
 5 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 033d6d66da3a..1381ef9638a3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -588,7 +588,7 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #ifdef CONFIG_USER_ONLY
 static inline bool arm_cpu_bswap_data(CPUARMState *env)
 {
-    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
+    return target_big_endian() ^ arm_cpu_data_is_big_endian(env);
 }
 #endif
 
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index e7f643d69d56..91ebf4e0778f 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -242,13 +242,13 @@ void init_main_thread(CPUState *cs, struct image_info *info)
     env->pc = info->entry & ~0x3ULL;
     env->xregs[31] = info->start_stack;
 
-#if TARGET_BIG_ENDIAN
-    env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    for (int i = 1; i < 4; ++i) {
-        env->cp15.sctlr_el[i] |= SCTLR_EE;
+    if (target_big_endian()) {
+        env->cp15.sctlr_el[1] |= SCTLR_E0E;
+        for (int i = 1; i < 4; ++i) {
+            env->cp15.sctlr_el[i] |= SCTLR_EE;
+        }
+        arm_rebuild_hflags(env);
     }
-    arm_rebuild_hflags(env);
-#endif
 
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 899fce76436c..f24fcddfec3e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -208,6 +208,7 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
                                        CPUARMState *env)
 {
     int i;
+    int big_endian = target_big_endian();
 
     __put_user(TARGET_FPSIMD_MAGIC, &fpsimd->head.magic);
     __put_user(sizeof(struct target_fpsimd_context), &fpsimd->head.size);
@@ -216,13 +217,8 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
-#if TARGET_BIG_ENDIAN
-        __put_user(q[0], &fpsimd->vregs[i * 2 + 1]);
-        __put_user(q[1], &fpsimd->vregs[i * 2]);
-#else
-        __put_user(q[0], &fpsimd->vregs[i * 2]);
-        __put_user(q[1], &fpsimd->vregs[i * 2 + 1]);
-#endif
+        __put_user(q[0], &fpsimd->vregs[i * 2 + big_endian]);
+        __put_user(q[1], &fpsimd->vregs[i * 2 + !big_endian]);
     }
 }
 
@@ -402,6 +398,7 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 {
     uint32_t fpsr, fpcr;
     int i;
+    int big_endian = target_big_endian();
 
     __get_user(fpsr, &fpsimd->fpsr);
     vfp_set_fpsr(env, fpsr);
@@ -410,13 +407,8 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
-#if TARGET_BIG_ENDIAN
-        __get_user(q[0], &fpsimd->vregs[i * 2 + 1]);
-        __get_user(q[1], &fpsimd->vregs[i * 2]);
-#else
-        __get_user(q[0], &fpsimd->vregs[i * 2]);
-        __get_user(q[1], &fpsimd->vregs[i * 2 + 1]);
-#endif
+        __get_user(q[0], &fpsimd->vregs[i * 2 + big_endian]);
+        __get_user(q[1], &fpsimd->vregs[i * 2 + !big_endian]);
     }
 }
 
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 0c3e5b30bd6a..ee6ed8296e33 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -122,8 +122,8 @@ int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
              * On the wire these are target-endian 128 bit values.
              * In the CPU state these are host-order uint64_t values
              * with the least-significant one first. This means they're
-             * the other way around for target_big_endian() (which is
-             * only true for us for aarch64_be-linux-user).
+             * the other way around for target_big_endian(), which reflects
+             * the executable's byte order in Linux-user emulation.
              */
             if (target_big_endian()) {
                 q[1] = ldq_p(buf);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 10375577b1e0..6c4cf29238c6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5165,7 +5165,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
     /* Note that unpredicated load/store of vector/predicate registers
      * are defined as a stream of bytes, which equates to little-endian
      * operations on larger quantities.  There is no nice way to force
-     * a little-endian store for aarch64_be-linux-user out of line.
+     * a little-endian store for big-endian Linux-user guests out of line.
      *
      * Attempt to keep code expansion to a minimum by limiting the
      * amount of unrolling done.
-- 
2.55.0


