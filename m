Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8267D6AAEC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LTN-0000Az-Ev; Thu, 02 Apr 2026 13:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTH-00009g-V9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTD-0000es-Hr
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so661416f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149477; x=1775754277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UolboCUEZpC2bIGieZdsWjT74OHHgRoWm02qV7hCKf4=;
 b=UJdmVTOqVnqZ+Futh1Iu41fpxCuxnft9kg0n5lrSF1x6tdI6B/9d3K1paHkzM21pgO
 FRCB207GtpfMQvbCpzN9I3vi1FAe1ykPNAc0XODGJJT0TZJnpWwVSDvhOmkDdjn3ERrc
 si9ur7E3nkKa0tvRh4wxWqL/6xgWSAq2khAU6/LAJIkyfHYvboa8Do6PqVnO6KeY6FAe
 VdQk0v8fcgfQfDWasntvWyhmRq3X3dInemqiPRuUGtrj1xkWERUreVt2XcI0aod9auf+
 DprJSkbS7M/bFbrYIO8Us5OpuInF1IvZh9VqlhOdNudY4d/uA00LnJDXhSoPAhIMt6Wd
 SRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149477; x=1775754277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UolboCUEZpC2bIGieZdsWjT74OHHgRoWm02qV7hCKf4=;
 b=tJtU5YSZDYQ2bFzQrZefmvufxX/SexI8hk+KOVQ77i5HbbX+zDRdAanY8yIhOFXV4K
 C++Y44Kr+6LrRS8v/n+0KvdfnZKO9NvVEndqOx28MdnqgvxmFu4l47Ish9UjU3MbAZZc
 fNIUm9rILiKglsiZQCH64btsbIYbF79fmRXAMyzer+dJmU46YLDPizEoYw4Nt3ie+j8g
 H0Hmwd+/usqcU7U4x/Y2bPROW+d4vei9ET1SGUxF/y6vUAGTppEBcMCCAd9UolqKKE6o
 SYPbwY2OijC7Wub3HmzS5crY/WdeKq0Ai8OpnGpHEH/aBW6+N6YYbgZK9hBFYUKlutF/
 TzPw==
X-Gm-Message-State: AOJu0Yz9h2qv70ThacSVSkEF/GVZcgHadB50onUKzmj09zu5AsAiAaFS
 8K3bbL1Z18uVdQAckZU9aPkR//IPhrbLsmQgTsY5XTZ0socO3mfrEQ6Xwl9Qjxu3lZ2Z2ADXOC0
 uKhkytQw=
X-Gm-Gg: AeBDieu/FizHWQ+EF+jLg7HFEILXQ36rXmeVHNeew0td5l8qfj1v+Zvkpr0MazacXis
 9/ZSrHssPX1GHbAFIE2C3cX0ekhZYhfC6q3YqwfqOLd4YZCOQKG4Gp9lx3zj8L5FVB8XwMe2YR7
 XPgbIyuNX4Tp0H+N0cPDRo2eEFz81M2TFB/JQ+oRtM0jge9S4ZbgjywXNR05pNCnrTj0MovQxcJ
 SjXdI435NwBQN3KTpjv8f0ugGuCcnIuppllLsZ/oYwaTlVuAm9Palk0/5IhizfcC64agv86WbR/
 xPARBUCmfdBHdbAAuL5IAchnvwH/gpq/idI7waCOhFpQ/zg3qUoUIlOQTXWBlfE/9DtfP+IJ5Dk
 wThdLzdYy8jIktm8g97UhvLNpyaJVcu+gP06Las98I2jbeef9MF+lT3mVIB7GYBRdQGKq5RcMBC
 fsZJm1dbAJuqPRcc0XcKB+RpD8QutPRRmQ3lQvwIegrnLynAIGVcskin8OI3i4W87kAhHyOXnzd
 JvkzO387JQ=
X-Received: by 2002:a05:6000:4285:b0:43c:f40f:6c92 with SMTP id
 ffacd0b85a97d-43d150429c7mr15427579f8f.8.1775149477038; 
 Thu, 02 Apr 2026 10:04:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d214f2b63sm6044517f8f.28.2026.04.02.10.04.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:04:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 0/9] target/arm: Compile accelerator-related
 objects as common code
Date: Thu,  2 Apr 2026 19:04:25 +0200
Message-ID: <20260402170434.94783-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

First drop TARGET_KVM_HAVE_GUEST_DEBUG (all targets but MIPS
support it), then -- after minor changes -- move the ARM
specific accelerator units to target_common_system_arch[]
source set, allowing to remove arm_system_ss[] for good.

Since v1:
- Include missing "exec/cpu-common.h" & "qemu/queue.h" headers

(I plan to merge via single-binary tree)

Philippe Mathieu-Daudé (9):
  accel/kvm: Include missing 'exec/cpu-common.h' header
  accel/kvm: Include missing 'exec/vaddr.h' and 'qemu/queue.h' headers
  accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
  accel/kvm: Expose all non-target specific declarations
  target/arm: Compile WHPX as common object
  target/arm: Remove target_ulong use in hvf_handle_psci_call()
  target/arm: Compile HVF as common object
  target/arm: Remove target_ulong cast in kvm_arm_handle_dabt_nisv()
  target/arm: Compile KVM as common object

 configs/targets/aarch64-softmmu.mak     |  1 -
 configs/targets/i386-softmmu.mak        |  1 -
 configs/targets/loongarch64-softmmu.mak |  1 -
 configs/targets/ppc-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak       |  1 -
 configs/targets/riscv64-softmmu.mak     |  1 -
 configs/targets/s390x-softmmu.mak       |  1 -
 configs/targets/x86_64-softmmu.mak      |  1 -
 include/system/kvm.h                    | 14 ++------------
 include/system/kvm_int.h                |  2 --
 accel/kvm/kvm-accel-ops.c               |  4 ----
 accel/kvm/kvm-all.c                     | 14 +++-----------
 target/arm/hvf/hvf.c                    |  2 +-
 target/arm/kvm.c                        |  3 +--
 target/mips/kvm.c                       |  5 +++++
 target/arm/hvf/meson.build              |  2 +-
 target/arm/meson.build                  | 12 +++++++-----
 target/arm/whpx/meson.build             |  6 +++---
 18 files changed, 23 insertions(+), 49 deletions(-)

-- 
2.53.0


