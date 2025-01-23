Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81173C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Ba-0004q5-K8; Thu, 23 Jan 2025 16:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5BY-0004pq-8O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5BW-0002jA-Pu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso841340f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669381; x=1738274181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bH5J3cRQDjcVRgPq7zp3SpsLhqrv1PdlyvsdQnQjIBk=;
 b=Eh6Z+/BIeON7Np2C8AGq6cvYnbSqAAvojCEn7CYn6/UwLmDUXUP6BiXyKAVDkB13Dv
 5gF0RQwlQcJBuImrhD9BtqPRSgxgRVCU5Q9X5g1BgHNttzkvFg9uwJjZMGNaQULDc0zK
 ixNxvVT1dI0PoljLaDnB3ppFzmFLj5X2WyDDAWF88S8m7ed9wlrSzJ2N3vdfh+vIWtSA
 tEk4FZ9Y+ZrS04IPQiYk1zkkNCS5kOfu1ugkuQXE6Lph0LLFzYSa56Y8ksrqIOEcY/dL
 6Af7hFifuwCsyn4eANGeDRtCFAs738BwgL1g5x5Hqc6SXXCiIZV/mPsTvnnmU49CTd0S
 XVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669381; x=1738274181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bH5J3cRQDjcVRgPq7zp3SpsLhqrv1PdlyvsdQnQjIBk=;
 b=Sbq4anpk1qH0Eq+25fNDwP/UD4ZoEmMVbHNTT8rTajYviPEGDEm//+0evYzyJTb7pH
 pwMAoqZOYslLmpYahCAGO3h6t1JtIMFYdDFF9dh8Sf8oGLLC/cy0aiEqr4CbXW0uCbvv
 eZrUNvNz/N1Z4FMg8qe+uiSQ5XaEH07TO9XArbtm8rgsFdPZbpeYaTcV6pbot2K3rY8G
 JpgGLJq2fdP4q8tS79TYGNqUwAA5G8cdCwrwHYe5JXf5AKlWwmzg7f7X7yN2TUsSQrBo
 LoDFr19sSjRnGQgqwud7IKUzSRzuHZH4u0ku+SYXsPeuxdtht5OqUqGM+0rOPzvZfUDV
 Bfqg==
X-Gm-Message-State: AOJu0Yzwc4ylgWXccyg3dzCofXXYnJGNX4gYTparFmqFqXeAKyaP2ERB
 ysdP/m6kPwRt5wB6Cbq92CLl8J96IxcBHgMAF/z+H7Cg9E7EFMROK+Vt2mbL5sB+c+zFP4AVe7l
 wtio=
X-Gm-Gg: ASbGncvQyXG1eMQDQdZWnJ2z4DG0AMEiqlEXjxWixvSz7wFIFYmvyS3kqsOSC2u05tm
 CFmjgG3ohe5J3Xo0VrhzHF43tOWakBKtfD7PKaD8fFfTsNxswC+aWCxcPMpTxSB0JDt8hBr/2wx
 gKapDPDKxtd5/7OlaSjrpEeRnOBDFQQbfJZLPto85dj2lVptGsUZa3GOr29rCZWFzO48x0HarBm
 Cg9l4VujEwI7Lz79huuuY8ne+k6gWCIvVT3KlWusQwjtE3SmQ01u6mbBKGE1ZOpEJW7luXL/6L3
 83ifAsCV1iYKGCFeSZ2R/DiMiBIWnJAgK+iei0FmuCgYGq38eUmiv6k=
X-Google-Smtp-Source: AGHT+IEMuB+bskUbKGysrMlSDbqUlZX0V4nRiLrAkQKdCjm2SlFYcl8mqJ3QAH4OTPbPkMqlN7ycdw==
X-Received: by 2002:a05:6000:1863:b0:385:f560:7911 with SMTP id
 ffacd0b85a97d-38bf5655589mr26500138f8f.10.1737669381002; 
 Thu, 23 Jan 2025 13:56:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1ca723sm772228f8f.101.2025.01.23.13.56.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/15] hw/ppc/spapr: Restrict part of PAGE_INIT hypercall to
 TCG
Date: Thu, 23 Jan 2025 22:55:56 +0100
Message-ID: <20250123215609.30432-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Restrict the tb_flush() call to TCG. Assert we are using KVM or TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_hcall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index dbf30358a1a..4f1933b8da6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -299,8 +299,10 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (flags & (H_ICACHE_SYNCHRONIZE | H_ICACHE_INVALIDATE)) {
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
-        } else {
+        } else if (tcg_enabled()) {
             tb_flush(CPU(cpu));
+        } else {
+            g_assert_not_reached();
         }
     }
 
-- 
2.47.1


