Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3EBC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg98-0001Qm-E5; Mon, 23 Jun 2025 08:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg90-0001M9-2i
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8w-0000Ub-Kr
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so21441515e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681159; x=1751285959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtS7m+vqlh7Qr+Y7luF/PvAhAhpP9RBj3It7GX3FL/4=;
 b=CaAcsmHArnAVywA+7kTSniaUsUF/qc7GdNCRYPPfVvF0n3u0dNdKYrzRHFrrJuXz5V
 Zf9wGCUqZywwdQUT3eVGkcFbpT6tgGk435cxzeQ19/ABVFtaAcElVkcX9F1o1cRkfnTq
 EnFjaPdSq3kcFRtB4vzJaUglAPrdpfyX0ag1qoJfVLAwgyxAQotIPwqLYBUIOVqb1KUH
 Tcu9sVz1Z2PrpQy4XplldQ+fGBHc74R9m0s+wEaEDswP0BzpwrPJarV0cbbYKGBJkFxf
 j0+2OTJMRdSEKq3F/2ttCzhbrQrjjTk9UGIzpYb8vsmk4F3H0byIepYyojbNHFCg5NPz
 6u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681159; x=1751285959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtS7m+vqlh7Qr+Y7luF/PvAhAhpP9RBj3It7GX3FL/4=;
 b=g6ZM+e3WDkVYZqwp7J/Rg8Clv6RXP6SsUmb5Re9RNPl6bC8kRGadnWhycfpFf+6UyM
 5KBMWCS0T+ckloa70RN+9DkP4HeKEkxjmZ/zRcYzoA4QQAuACS1XtBtkr4RbWN/PJ2rL
 xgSkaq5x4AOk81Rz+gykxKFcsNv9K5rw/ZuqLmOVZDRJHlcxJQRJ3GfAMcIu4KKlwuPl
 GsP9UJ4CfgfMh5055D5qpTfmGMVaa4Bk/eDT3751O7vYHEoQIsbZOEBKFR/yG4UnM5wW
 TUgZIR0srZMSs4I4QJ3shEf5q9ATFlk6NY6ZRk4voHu0crWKrQmiFmthFX7pg45v+rGR
 KIZw==
X-Gm-Message-State: AOJu0YyFii7nGdjW4+PhDGpgEtorzolqCIwxrxedBxQoPMGSM7bPdJiC
 SwoaWkmJkNHWfuwoGOS3P6tc0RBEVirWfIyrOKE+8PKIVbj17ihb3ZyjKX6xWrqtgIq5azOe051
 pYplP
X-Gm-Gg: ASbGnct5Wa4tIbX/Pwj8AZ/5KVYlXcDUBERjZK23WklAbGcU8VCLnfUxVTUobonH6zq
 p3Dug2/vDyO0wgyO6aQ3KNdq9oo4EGeRbewk6rYm2HLny8dPXYF3xtxnzLNgjOaWOOMSqVwIAxL
 8XiVcZwtlItsuN/BNViFveDlyPNXQqViBVPh5OUDleuZ++PbZFi/Y6iNbW0w1hHnVOXT3Ruq5c5
 ZSudCw1l96PT3xCowmJKKDKRReU1Q3DQ3cqrW/yiJnhC6kGar+8iMGLjbHPN9i3qGeu28LDpBYK
 izH3Ohfg4NzGEJ5yUy4g8JyauIslSMfYTrsl9Nf/eVzHKeI26cbOzxV33ymd1+VrZKbUILrlZhF
 cPnEls+L7CoBZ9F8CUQY65eDZN0XjDrR2tpFM
X-Google-Smtp-Source: AGHT+IFl2eAC2wXLNGcTcgz9pBye6T6IVeM4BN03TDgb6Vv2/UKfmtbrc+hijHKDuuTiPnREIJvcsA==
X-Received: by 2002:a05:600c:314f:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-453656c313fmr101273355e9.28.1750681158702; 
 Mon, 23 Jun 2025 05:19:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536fefd2b4sm51673585e9.36.2025.06.23.05.19.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 06/26] target/arm/hvf: Trace hv_vcpu_run() failures
Date: Mon, 23 Jun 2025 14:18:25 +0200
Message-ID: <20250623121845.7214-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 10 +++++++++-
 target/arm/hvf/trace-events |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef76dcd28de..cc5bbc155d2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1916,7 +1916,15 @@ int hvf_vcpu_exec(CPUState *cpu)
     bql_unlock();
     r = hv_vcpu_run(cpu->accel->fd);
     bql_lock();
-    assert_hvf_ok(r);
+    switch (r) {
+    case HV_SUCCESS:
+        break;
+    case HV_ILLEGAL_GUEST_STATE:
+        trace_hvf_illegal_guest_state();
+        /* fall through */
+    default:
+        g_assert_not_reached();
+    }
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 4fbbe4b45ec..a4870e0a5c4 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -11,3 +11,4 @@ hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
+hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
-- 
2.49.0


