Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D9ACF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJB-0004yU-L9; Fri, 04 Oct 2024 12:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlH1-0008M7-PA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:23 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGz-0006Sb-0u
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:23 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2facf00b0c7so30477241fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059719; x=1728664519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hTPF2P0wkzOAl3QcmMS55AC0dIObjOQe3WnAgnhe+k=;
 b=ZuB0jU4K88OVDQVNrOJZ8HeMX1m0z8jd4vIL4a/dgxfoaGJOSJqkl/3aQO/s9eOlhy
 Kb2wCgRnEmDJ+PiQio03iDUpj1jsOOakdt06e4YSjxzcZ6E3Xb7DC4jqWSgGyKzxsxoN
 09BepvsgLUw63Xpdy6wPeUoDO4njTCovkRb6WyqRCPJHnVGFdskZ/58+CaiBokkA/pVf
 nGPb4fdtBBS6hHn0nuClei+fhxjL8AQ3pTNs3uJkMRXZEEylwf2gD9Wql0Ee6LPJ5XjG
 XL5z3l3qO+eeQIfPj3SfGwEeFQRxqEIRG5PvwIaECEAxiDCc3l/4Z0o6xYWfdk/S2nF5
 28wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059719; x=1728664519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hTPF2P0wkzOAl3QcmMS55AC0dIObjOQe3WnAgnhe+k=;
 b=QWWO26xAxTEo+RG6jo7+AZlZE78QcXxSpEcJHkICq7bQckhYGfXnl0wFEhWRfvOd53
 cNQRsTDjVnE/drzcxyhBjrAfmGTHNTMlOuTKuFhuX7ERN3+X9Ms6rhLChenyfSj7lc19
 lF3kYsTxzbDxT148al2jWGxgrT8vTp51qXTETPG552iD4bxcySnP+4W6Auw9Oh7qWvSR
 rUVPNBMr2AgVaW+gut40r6VS9KyGirE1KQ4/T1UxmHZtfZ/SYoPhzMhxOgTqHn+bBOob
 xNZnh6FKkFVoYoF1ki39kdYVV3h/fkuffuiw0Xo/AeCiDRMqxt7bywe3HMENw0NCrdZL
 CCsg==
X-Gm-Message-State: AOJu0YwAic126m9e1+HPJbpb0uukaqPY9x1g5wKomL2OEytb30ihbMRZ
 NnP6V4EqqLFaqjUh32ZGVY6zNbpmfGLGSNLOFZLaVLKeEACVFxDrSeGj1BQKdCqaKokufmKPBbj
 463sWvQ==
X-Google-Smtp-Source: AGHT+IExeF/RRjZ4znjlHEqqCOKoSzJRoizTQ9lnK9GLXbUykc0LJXovMIo8HQLADJGkSBH+NqnoMA==
X-Received: by 2002:a05:651c:1989:b0:2fa:cfba:fb65 with SMTP id
 38308e7fff4ca-2faea1b7d1dmr26392521fa.3.1728059718985; 
 Fri, 04 Oct 2024 09:35:18 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b24991sm201001fa.83.2024.10.04.09.35.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:35:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/25] target/m68k: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:34 -0300
Message-ID: <20241004163042.85922-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The M68K architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/m68k/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/gdbstub.c |  2 +-
 target/m68k/helper.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 15547e2313c..136159f98f2 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -52,7 +52,7 @@ int m68k_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 8) {
         /* D0-D7 */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 4c85badd5d3..9d3db8419de 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -57,15 +57,15 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 8) {
         float_status s;
-        env->fregs[n].d = float64_to_floatx80(ldq_p(mem_buf), &s);
+        env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        env->fpsr = ldl_p(mem_buf);
+        env->fpsr = ldl_be_p(mem_buf);
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
@@ -107,10 +107,10 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     }
     switch (n) {
     case 8: /* fpcontrol */
-        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpsr(env, ldl_be_p(mem_buf));
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
-- 
2.45.2


