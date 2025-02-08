Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09324C0219B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtQ-0001tt-8N; Sat, 08 Feb 2025 15:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtK-0001rp-Of
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtJ-00057K-79
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:30 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f50895565so26333315ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048247; x=1739653047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KwnHCfQIkLSuI5gCbIKhc6TbHv3lQ5OLotA3Bb1FOg=;
 b=vvAtBFHcqttXCdPb8ajkZKxSIRxuDxw/a0IHdXr1IdQFWQEzp8Fu9JKHAdF+nvT18C
 v/I8plcy5QvqEIpjhC5TotzmQTDs2Zgn/TwqJZrhFRrCxd+9ApZ6X3m73PEIrXC+wBBG
 rlDGRrA+wTsQxtm9TSbqAi3AT2BpgUOFQwGt3vHlVIZ4SVM3Q/eTkgsFVHBpFlMxFTnP
 DdveFNymnFpxD6RjB790EJ+0XuAxCMQ4ymu7R76vVnjG+6wc+ntfDj3nNEu/+zjpqdwf
 S3moxfE/QxCzVj7/QExqiMOFOiZ5YZoAT0DxYhWM60lOqQNFmK8hzBgN/Znz/q+Yjc4z
 KUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048247; x=1739653047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KwnHCfQIkLSuI5gCbIKhc6TbHv3lQ5OLotA3Bb1FOg=;
 b=FBx7TZ7uaDoTAxUWLGRHqGVBP0s0ok/3fzvZVmJW0w3eEIQNsNpOIm3LDOH53RZJij
 0wOzlcbyiGWsPX+M4EuXgSQFxYFLYi35bW9v0h6OBAn3GYdCgwp+tuW7lmJcXqCeiyhg
 wICRwhmhP5J2P4sZUdoqhaWiHXAO588aUGomlDhuVTlcXHs+r2Mt7boJlef1C9M3zL6p
 pSTIIoYtBCZGslHwtJLBrw7FrnkOhRioh7qnyQlNycl1OOoyqX4G9WG4C0SL351iGv17
 9/P1ER6bXzJF08rini/8WOBsA7Vj7Ce7MwTK4X3L2m4wJFw+AAa4FOZhi7W1WlwZiMIL
 5gXg==
X-Gm-Message-State: AOJu0Yyej/OZd+vDZ5vFbXC+OKVNDArYFh25cR55avg4fV4WnL8yojZT
 16kORXtXxNoEdQ1SnlOpgCaM9dxpN4ZUJkVkkft7Pzk2KiGdkaaiwGNI0BQrDU9yQPjTzOTPPBX
 L
X-Gm-Gg: ASbGncvXDfSAG2FiN57WEzyajV1bpSQUAKEEzeVTAH7/kqoj3wokU5CcizDupRAEJQl
 nYF4jVRBLPi5UkJmsn9MDTNNT3YQMfMcXARw2jwCujxynseIUX+18TvuZvwSuoXLo3Ib0dvVqLJ
 LX2eaycBxDG6cKhYxVxOkv5/J2sSk9a0FlKJAFHoWft8PdIWG1j2qonPmSPz6bhwhcWsH1WhI0+
 /fZjPnmzuAJDTTymNLIFk9lv9sC5xCTandnCd5ZiapmW4Eo6JYc3ymhA/7PhEqTvEPWtoCAXosh
 oZOoNQLcfyHPx/SLJTncFw3+EdiMEW0nUxNum/0TLhuAaT0=
X-Google-Smtp-Source: AGHT+IGT0gUdl5BxYgZ6WXx4AFubJ+VbzC5L5lCwKm9a4OXIOd/b3TT9QNCxaSyWOcy3fk4Z4es9Zw==
X-Received: by 2002:a17:902:f541:b0:21f:5e6f:a432 with SMTP id
 d9443c01a7336-21f5e6ffccamr93752375ad.24.1739048247667; 
 Sat, 08 Feb 2025 12:57:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] meson: Disallow 64-bit on 32-bit KVM emulation
Date: Sat,  8 Feb 2025 12:57:17 -0800
Message-ID: <20250208205725.568631-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index e50a103f8a..1af8aeb194 100644
--- a/meson.build
+++ b/meson.build
@@ -277,21 +277,27 @@ else
   host_arch = cpu
 endif
 
-if cpu in ['x86', 'x86_64']
+if cpu == 'x86'
+  kvm_targets = ['i386-softmmu']
+elif cpu == 'x86_64'
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
 elif cpu == 's390x'
   kvm_targets = ['s390x-softmmu']
-elif cpu in ['ppc', 'ppc64']
+elif cpu == 'ppc'
+  kvm_targets = ['ppc-softmmu']
+elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu in ['mips', 'mips64']
+elif cpu == 'mips'
+  kvm_targets = ['mips-softmmu', 'mipsel-softmmu']
+elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu in ['riscv32']
+elif cpu == 'riscv32'
   kvm_targets = ['riscv32-softmmu']
-elif cpu in ['riscv64']
+elif cpu == 'riscv64'
   kvm_targets = ['riscv64-softmmu']
-elif cpu in ['loongarch64']
+elif cpu == 'loongarch64'
   kvm_targets = ['loongarch64-softmmu']
 else
   kvm_targets = []
-- 
2.43.0


