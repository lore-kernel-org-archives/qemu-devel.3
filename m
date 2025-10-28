Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB26CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd5k-0004Cd-Bl; Tue, 28 Oct 2025 02:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd5i-00047F-9w
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd5g-00008L-4c
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so19658725e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632512; x=1762237312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEapZ+GwwTa94UZnU22jnYxk7ZbhPqC6KAzkq5Qh8JM=;
 b=ypJIl/pxqU21ZKhBWGDXzyjytas67sPO5bh1Veq8RrGvndKvFs7lWDvKFjT0Jomdbi
 I9m+ToATMI/wIm8UxsLi8M5yaUgdpMKUbaMtIfn7cpMKQSL47w9/BYVZdAbgjBIBQqWh
 5tuiobO6Ht9fUfMVmvCYAJbF9oj6HQcrCVjw3rnVnFzOGld+xkWw2+YjZg9zE4FoBkE8
 GeANvFEt0U4WkTEwLfRhi3qVAziFjkQXlh/LRKeu4bQ2QQlbQgwxq7Qp4uxqXYCk2T/6
 SHNt+48H0+O7d2rhvQibSzpYTGilH9V1wkfdmeyjk+DirDRHuMLMjkQPqHwEg434EJG5
 qK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632512; x=1762237312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEapZ+GwwTa94UZnU22jnYxk7ZbhPqC6KAzkq5Qh8JM=;
 b=LZP1RmpPGY5OFjsHM+Lg3TbsrYTQsRqr750nVIyIJ6bUatJ32QvImWvTlUyc8SWeZ8
 3BNCIX5aaDDvA5uVxLCz2eII88m+7FeY05Npv28jgKc6x3HVSTQ6yMD3CEtFmME4+6+2
 nk0/W6IR7V4rAqp7ZdyEg7gqw01q4k/Vx2MQd/JwheYvXYe1PCOzEvec5imr5hYt8exc
 e/ycFAfW4vnSZTJU36j+gaLoZ8qjntl0J+maINeeKK/5NMQtFUMK8U+J9SLn0t+X5/wQ
 UIkOIln5myqrApdxWK0uayMdfTJgrEJdUr71qNRUiqwmoE+lwn2uGhG8Bf9cOkafrMzG
 g8Gw==
X-Gm-Message-State: AOJu0YwGjHso1NAA1WVBseo/hqOd4R6Yp482Dze4TlXnI/lipL21HZdM
 rV3aYvnBBijFKOBPbOIom2eDgT4p7ip8GHuXptBxfbNd5JlDculoXI/hX+OO9BFhidpuTXuLW0k
 cRIe7zco=
X-Gm-Gg: ASbGncshTT138fA8iirjfcvjZ2HLNzBxt+2vR/17SDdSHHT01auk0rLYaedY+FJ2Ap3
 pWg4/CJnKSX0BPV6bubh45pIpgC55HDXqUCe/oRP6idOopObbdJm4NQ6jmIyyX5zALCePn3EC/N
 IRupwv8PpZIeCUn/sXunPnfyjbKF6lRDIeipr8QEXPEmez3NbGjnrlndyd33zbTDCauJXkrTSjf
 Ro7otKS1WIWBwB/lZTAh4UxhYMOqg+bG0/WmaTTGEU2WDk8oZvMALjKM/uh6TX9Mul9UBgW5ZZA
 fvjrpbZAQ5gyyy+j261/Ok6K+3SmK79k5KoPwdjTJOQ5QSG/5vH1JNTnZuGb4o1z8ciwNKkiy0G
 LDG+328uS2x45RbNt4UpqOG+7RxqPuo3HpoE4qmOt8y8mN4yAoXcjF8qpqfTby9ON3qX9xK3h5k
 kZZFFUh5GdNg+/u6Zt6ijl931kP9TBgRAN73NMtYAGm/LD2Ko8QvsDFdA=
X-Google-Smtp-Source: AGHT+IE+o9q0tm9MnlYgDlTxMkFBwXWj6tGtugu3plkqadXG+M17i1RvdpeqpSLXj5vu9TNYc+6Psw==
X-Received: by 2002:a05:600c:548d:b0:475:df91:ddf2 with SMTP id
 5b1f17b1804b1-47717e073fdmr16946745e9.17.1761632512538; 
 Mon, 27 Oct 2025 23:21:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc5efsm179583945e9.16.2025.10.27.23.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:21:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 55/59] accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Date: Tue, 28 Oct 2025 06:42:31 +0100
Message-ID: <20251028054238.14949-56-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cc02df2e907..22b7e34db0e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+
+#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
+#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -2013,13 +2016,49 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
     return ret;
 }
 
+static void hvf_sync_vtimer_pre_exec(CPUState *cpu)
+{
+    hv_return_t r;
+    uint64_t val;
+    bool b;
+
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
+    assert(b);
+    r = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
+    assert_hvf_ok(r);
+
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
+    assert(b);
+    r = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
+    assert_hvf_ok(r);
+}
+
+static void hvf_sync_vtimer_post_exec(CPUState *cpu)
+{
+    hv_return_t r;
+    uint64_t val;
+    bool b;
+
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
+    assert_hvf_ok(r);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
+    assert(b);
+
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
+    assert_hvf_ok(r);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
+    assert(b);
+}
+
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    hvf_sync_vtimer_pre_exec(cpu);
     flush_cpu_state(cpu);
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
 {
+    hvf_sync_vtimer_post_exec(cpu);
 }
 
 int hvf_arch_vcpu_exec(CPUState *cpu)
-- 
2.51.0


