Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F9CCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoPl-0003Jy-7C; Wed, 03 Jun 2026 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoPj-0003JP-6y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:25:55 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoPf-0004Ip-T2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:25:54 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66067da0638so2557335d50.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503951; x=1781108751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YNEAS5GV0N+3LXdy4P7AttmaZtzqqjHsfFtcLHX8v98=;
 b=E6idPM4Ss3J6fobkru9GrhpRlqHcv9Q7GCpM5kxCEzaIYJu4Vv0Zwf1N4lgQlFw5va
 cL3+yWl0/xdZKhY5u7xbn42ztDlmROOtQ8nPBhCi4Gs+KW0La2jSeSpOTMW7EseBVoGt
 9DZaVOdzd+dhY0VswKd1rIG80KRkwtGe8QypIgv0VQRH2TMgdjJC6Pfbil+X7brRXZvf
 g8WNHT7+JaII6HkkFvF7mya5cYJi34ltkhkGvPlNB0VfNxF3vhfUPYS34f4NxTOtAeMb
 9wxlGXdQ7wx6GYKDTwl5JCJwHGax3qYPhvLt6QMAwlUeR7jgbcpHheGY3Notpj3OrvzL
 0i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503951; x=1781108751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNEAS5GV0N+3LXdy4P7AttmaZtzqqjHsfFtcLHX8v98=;
 b=S7Wv7DQpONBZFpEhydGVU69QF/ae3gREuzUa9yQxzLlttufodOCdnuiWLKoWMBTBFO
 2M2E0l7rm1L/D0hImDaR439v8HsMcM9mb2q9GTQ69ByvdzkP8v73R9pWs702Ia35Hoem
 u8Ir6fsRBr0FEPOa1AM5/XlBTSQSUtVZK2ja3CMnIBXBz1fSE/g0F8u363GNn3nUsDgn
 2OBETqHROciz8VAG2KxKQFjVWgloIZCh4PkO+W6FZL9xmeV3ID0mPz109HhgBM6b7K4+
 rClcSo8Sy3I8hIL1OjFf0GZeXBc1I2LCwm9Yl+WNuCvU+88Tt1ANpbs7pZkPGLogL53d
 CS3Q==
X-Gm-Message-State: AOJu0YxJrkgDqZAWo9mVNE0CDT7fVVQBfXAfbF/YDRUmYyw7FnWmlJZh
 4+NykCIWBPcdZXM9Wmfzsb3bqPpCr2RGSl7R8gtm4mjHycdZFc3qOhaqwZL8Q9KeZao=
X-Gm-Gg: Acq92OFsbHC6OBEcc98yWxRDYUdiSgGF5F8xt7wsyrWfh5u+4QQJimLbOH4O9/7r8cg
 8ZOBmGQAzDRRZYfJU5a0Rt5qwKuwgF/HGQUUGkssglEiUw76N636va/rtiXDFGrLI/BC0MKrx3y
 DJyZFtuab8eot+DFWrT3yddCcpMDCPGK8tS7RDtD0NcXWSHM/ARrVJdd1JQpoQtjnlWyo29j+iV
 5YXgWUJttMvYzqqrCUaNANJg3c0IZFfnUccF8ethPZj+kX4zR7AXFjTC6QVUkD5WKIeyGSt9BUX
 QBsx4/urdmyie3q3iFAKXrWQ54hqsi+wVX4lBHRJmU22/6Vj+4Fy17pY1/be5nmoeKInuO0BPdj
 E64xeEcIcHi4JwgvM+wR6SC58VzFe1Pq4+YcIRsRT4hjrkJg1OrGxpTV60JCJVoFvVNvqFDcxpn
 QyUOQxLWqX92w0O80/O73zeKMr1F6rUXhVlw==
X-Received: by 2002:a05:690e:4083:b0:654:c2b5:b77c with SMTP id
 956f58d0204a3-660dbe20fccmr3480446d50.7.1780503950731; 
 Wed, 03 Jun 2026 09:25:50 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d62040c5sm2177620d50.12.2026.06.03.09.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:25:49 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/2] target/xtensa: add cpu_set_fcr/fsr helpers to sync
 fp_status
Date: Wed,  3 Jun 2026 12:25:43 -0400
Message-ID: <20260603162545.1835769-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Factor FCR→fp_status and FSR→fp_status synchronisation out of the
wur_fpu{2k,}_fcr/wur_fpu_fsr helpers into cpu_set_fcr(), cpu_set_fsr(),
and cpu_get_fsr(). Signal delivery code needs to restore the FP rounding
mode and exception flags without duplicating the flag-mapping tables.

cpu_set_fcr() applies the union mask 0xfffff07f (superset of the
wur_fpu_fcr mask 0x0000007f and the wur_fpu2k_fcr mask 0xfffff07f) so
that FCR bits valid only on fpu2k configs are preserved while MBZ bits
7-11 are always cleared.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/xtensa/cpu.h        |  4 ++++
 target/xtensa/fpu_helper.c | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git ./target/xtensa/cpu.h ./target/xtensa/cpu.h
index 75cfeee6e3..442e98bd1b 100644
--- ./target/xtensa/cpu.h
+++ ./target/xtensa/cpu.h
@@ -642,6 +642,10 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
 }
 void xtensa_runstall(CPUXtensaState *env, bool runstall);
 
+uint32_t cpu_get_fsr(CPUXtensaState *env);
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v);
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v);
+
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
 
diff --git ./target/xtensa/fpu_helper.c ./target/xtensa/fpu_helper.c
index 5358060c50..9937bc5bea 100644
--- ./target/xtensa/fpu_helper.c
+++ ./target/xtensa/fpu_helper.c
@@ -64,6 +64,48 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
                              &env->fp_status);
 }
 
+uint32_t cpu_get_fsr(CPUXtensaState *env)
+{
+    uint32_t flags = 0;
+    int fef = get_float_exception_flags(&env->fp_status);
+    unsigned i;
+
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (fef & xtensa_fp_flag_map[i].softfloat_fp_flag) {
+            flags |= xtensa_fp_flag_map[i].xtensa_fp_flag;
+        }
+    }
+    return flags << XTENSA_FSR_FLAGS_SHIFT;
+}
+
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v)
+{
+    static const int rounding_mode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+
+    env->uregs[FCR] = v & 0xfffff07f;
+    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
+}
+
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v)
+{
+    uint32_t flags = v >> XTENSA_FSR_FLAGS_SHIFT;
+    int fef = 0;
+    unsigned i;
+
+    env->uregs[FSR] = v & 0x00000f80;
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
+            fef |= xtensa_fp_flag_map[i].softfloat_fp_flag;
+        }
+    }
+    set_float_exception_flags(fef, &env->fp_status);
+}
+
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
 {
     static const int rounding_mode[] = {
-- 
2.53.0


