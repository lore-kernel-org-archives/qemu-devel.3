Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148D4CCD1A4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZE-0007Uz-Ss; Sun, 19 Oct 2025 17:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZ9-0007Sk-FG
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZ6-00022v-48
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63c3d7e2217so3760256a12.3
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907822; x=1761512622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4M6OPI3ZScUV1Z3V9YEwq0Mmh3V3HGR6RP7L9+iqOHI=;
 b=RGBiyAzeh+I2fwE7FLEQTcgph2CwfsHeVVXBgGZGDaetEaKBUwkBdareYLl6JjyZ/G
 itN9CfOud8S4vHcf1FJTq7KsdenzG9iy0viTWE7OM58yuKKLdAjn5wvpSG32vVu1l7PJ
 ZPmNlgLp3i9G7NaTOMvC6XLdM0+r+NxyMtBtK9hl1utBGynTT+ylEw2x5hXMm+IFjdo9
 bmnSTI2TnbOCduSH/Y/OiWM6apGDf85TUqBWP+4A5TPIshbRY+aqbK0kxzY6P5tAXjyX
 1W3hdCuALwuk0FoG7HwJLOPjbcmwIzHRQ35keFkGbqGbpE7lz8dMQYjF5rm+t5AgiHsN
 0+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907822; x=1761512622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4M6OPI3ZScUV1Z3V9YEwq0Mmh3V3HGR6RP7L9+iqOHI=;
 b=HiYoqJyG1tgJPQAuH8ctR8PuIZIQDlCYs1Eg9mdmOWdFbP+tQDvuKcf/rz+VuXQxgH
 8o/uyKq4D+uXZviR+UJNZYn1urqrIl1uBML0tb2kOriXJh4IET+Gi562U0wxLwgbzinQ
 nji0wbXtBRKWaSxFtBZ9TtgMRB1panGGzTtVu4kf46vTL/YSMejKtjA7/QNaQMEFfT38
 ceLYDR/MrXGvVzmRWxP46D9rd5eGkVaUV5Tgpug3PFxCq24m26aYUSBtuQrSGbrbEXHh
 r3UKMVPXn84fqbVxVQ+unMbdH98Uf4Hh2FhlInDqqttWQzrkO8XTZjl4LzHsZNsK1uvb
 noog==
X-Gm-Message-State: AOJu0YzToFkb0WAiTt+yc72G0LR+26ATnUn8S35TEWGXBTH2bh8bdtM/
 zlyst03CiJV1zmVADGc9PytlmhKuHfxKQHyJaGFY/XkoR+94Tvks6h1UrcIuTSFk
X-Gm-Gg: ASbGnctNm9fxqpUVM0lnujBPmalWSc6Dn5PmRE/QBwYJOQGKjYHSCQTdXDU9csa3vdr
 95+Wj/z9mp+QeDDnP8wAsUhDfCkYzGlRU6LZ2fPi+oU4swBQju69rO2avnS3M0hv6si+pQ381in
 iMdoThEnzhZ0lTfHzTTHMQc7WHaBCLVKFIybTpNjq/RW6xHtJrFoH4+/YxBxkbHrCKPF+lD5w0d
 Tpq6M0fYjxR+VivjJAx5EIfkllOhxRrWiBeUxvsD2uwlqj96cHzorJkxzzUao5O6f/oVfwVrKA6
 eS+FY9nTRPRWf1hnZqYKsmwPMphzN8zfd1w91maJLmkseGNPYIj3spB3ThARVKvIc5eUPK7reWE
 JIhyBPfUb/19h5tGkrCGgnh1Gv7V+0+1p5sHHLXbQMk9nyqVfjRbfynbPdk4LBvoVTuNGTTW5dF
 OtqxupB2RtO1fQjkeX/3vMIyoNgMKHS8qB9a9UKYwgZfPF8zb5q4nbTKaCN+v12mX+TmMr
X-Google-Smtp-Source: AGHT+IGSAEruyy42RcbostlDmIvNL1l2atIU8PAtqHcOivFYyhlrRwD6QwsSK/hgSujyhUWyY/+Q2w==
X-Received: by 2002:a05:6402:2681:b0:634:ba7e:f6c8 with SMTP id
 4fb4d7f45d1cf-63c1f6d5e1bmr9986226a12.34.1760907821475; 
 Sun, 19 Oct 2025 14:03:41 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 08/10] hw/i386/apic: Ensure own APIC use in apic_msr_{read,
 write}
Date: Sun, 19 Oct 2025 23:03:01 +0200
Message-ID: <20251019210303.104718-9-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Avoids the `current_cpu` global and seems more robust by not "forgetting" the
own APIC and then re-determining it by cpu_get_current_apic() which uses the
global.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/apic.h               |  4 ++--
 hw/intc/apic.c                       | 10 ++--------
 target/i386/hvf/hvf.c                |  4 ++--
 target/i386/tcg/system/misc_helper.c |  4 ++--
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index 871f142888..6a0933f401 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -19,8 +19,8 @@ void apic_sipi(APICCommonState *s);
 void apic_poll_irq(APICCommonState *s);
 void apic_designate_bsp(APICCommonState *s, bool bsp);
 int apic_get_highest_priority_irr(APICCommonState *s);
-int apic_msr_read(int index, uint64_t *val);
-int apic_msr_write(int index, uint64_t val);
+int apic_msr_read(APICCommonState *s, int index, uint64_t *val);
+int apic_msr_write(APICCommonState *s, int index, uint64_t val);
 bool is_x2apic_mode(APICCommonState *s);
 
 /* pc.c */
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index cb35c80c75..ba0eda3921 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -881,11 +881,8 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
-int apic_msr_read(int index, uint64_t *val)
+int apic_msr_read(APICCommonState *s, int index, uint64_t *val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
     if (!s) {
         return -1;
     }
@@ -1079,11 +1076,8 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
     apic_register_write(index, val);
 }
 
-int apic_msr_write(int index, uint64_t val)
+int apic_msr_write(APICCommonState *s, int index, uint64_t val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
     if (!s) {
         return -1;
     }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8445cadece..33f723a76a 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -527,7 +527,7 @@ void hvf_simulate_rdmsr(CPUState *cs)
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
-        ret = apic_msr_read(index, &val);
+        ret = apic_msr_read(cpu->apic_state, index, &val);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
         }
@@ -638,7 +638,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
-        ret = apic_msr_write(index, data);
+        ret = apic_msr_write(cpu->apic_state, index, data);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
         }
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 9c3f5cc99b..0c32424d36 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -299,7 +299,7 @@ void helper_wrmsr(CPUX86State *env)
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
         bql_lock();
-        ret = apic_msr_write(index, val);
+        ret = apic_msr_write(env_archcpu(env)->apic_state, index, val);
         bql_unlock();
         if (ret < 0) {
             goto error;
@@ -477,7 +477,7 @@ void helper_rdmsr(CPUX86State *env)
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
 
         bql_lock();
-        ret = apic_msr_read(index, &val);
+        ret = apic_msr_read(x86_cpu->apic_state, index, &val);
         bql_unlock();
         if (ret < 0) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
-- 
2.51.1.dirty


