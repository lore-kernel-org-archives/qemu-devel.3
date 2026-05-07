Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CD5CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKzFD-00032X-53; Thu, 07 May 2026 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKzF9-00031P-IM
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:58:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKzF7-0006xm-5F
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:58:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso584703f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778162298; x=1778767098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OWYgSumz8mq3xVh86X0WxwAoKHbIXTWbtCvS0CrHxmE=;
 b=aLOrUU+wUvMfKU2juESJAVH3IcQVOc0mFP6PpQ/pqHjbAEMVp9nOrl0j6UONg50vSC
 WV0OQDMOSlw0tITqTCHleCp4X50bjjBEY34tv2MixtqdWoazT6iXcaug0/5gaDoC8fQn
 YfPm4fR0tOVBHZ8ZmNSJfhJQ6zRkUye3Z/9pb5A5VuMr1WZ39sByokYnkIhjbj/CtGT9
 BqQJw7KfaVD/LY4CRNHXTZ9nglyZBge93CGgH8fuqW8iPzvwrxdLaUMSaGfBv2eI2aCc
 n2WlZBBKOY6X4b0MQXX5MmAOrlin7WpVmnlELIuAVavmuuyQ6rJAx+D+HBpP3svbnH/C
 Lq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778162298; x=1778767098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWYgSumz8mq3xVh86X0WxwAoKHbIXTWbtCvS0CrHxmE=;
 b=Tkz4qjYRno+5B7KdKwBmFcgvy8CXNVxGm86B7bVoB1A78mtjDr5H3vbuYftXMhIKC9
 UesQgFkPvQ1pwyLljsgL8P/+xj2cGzIgNg0S7+AQmxzzzfHxDpwgkwRd7VDW40ZynIao
 E2BnJmjD/pU3UOLm5nqQUaIE6bazp/m2A2YvcyFTsuMqSPxQZ4asd9CBy6E0j/GhLF2u
 5KZAcsZCbWi6EBVAF4mn/rwkaCnYCiM/eFyDiQWH5OkXwFJccPILKjfQbV611PpR1US9
 AosSyPxMgW5DMZxkjV7TYDSbB4x9+/hBgfkWt/HDiNqBIy+6tETLIh/7uqRcV0E02o37
 hbEA==
X-Gm-Message-State: AOJu0Yw/rRgVbYrxSDL7sCVu3WaGMMn/n26o/LGVv/oyORt+EDq9piGk
 YLXh0DHiaxy9Ka0OmwQmyRZw50/syqf2qAkc9V9flczKXnwE0G7ijyrMu0G0oTsS3vHB2AcuTcw
 YbzibmoQ=
X-Gm-Gg: AeBDievcQz6yjtA6+Z0CpQwP+lEZbdRrqlB7+DIPaxLOWoy9J6NRxtW6FDu+TQ7lTGF
 vNsCapoMAOKUDy7FSHlHb1Kxv+WPJ427DIVVDGfDzyp9gyh6o8uXNMKvhXUY3lPBalWosj8Oar9
 IRn6aExF1GR7TiXaqTnMbnvzGDXErfUlP84PfDyuQG4RRwZ3lNlf7r+NQbcA1U4kdbpBDe8JQwT
 ey4QQl6YhsaueKNvsy4DmNaksVH4eGUbVohUXmUI/Il2l1BJGsKzWoSderDaBB/ZV6PRQP2Yr28
 6Y6BPjvPFQ9t+OrcoNXDCDmRb7rLg6IJZpt6Eje1yLtgbABFjGa89BMg/tMZg3HJpM+FfbCYePO
 sskqktDQkLD3hPXwlEkANqVPMcLrtYnPhgGJRIU8AfjqAA7v/krOsIeQQMsXGOyAXG2l4eu6UWS
 jJ1vxgln0jPf30pZ19j7MHLMDRWCPgzx9foudD1M0iA8DounB50i4n17kmkNwyEhIM1kPr38mNo
 TUXMKTyccupfWrPT4jprg==
X-Received: by 2002:a5d:64e7:0:b0:445:ed7f:ce84 with SMTP id
 ffacd0b85a97d-4515b524043mr13172085f8f.10.1778162298166; 
 Thu, 07 May 2026 06:58:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e7c0sm18577599f8f.3.2026.05.07.06.58.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 May 2026 06:58:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm: Build ARM/HVF GICv3 stub once
Date: Thu,  7 May 2026 15:58:16 +0200
Message-ID: <20260507135816.71171-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Move arm_gicv3_hvf_stub.c, introduced in commit 48396ad6ce9
("hw/intc: arm_gicv3_hvf: save/restore Apple GIC state"), to
the global stub_ss[] source set which holds stub files being
built once for all binaries, instead of one time per system
binary. This prevents symbol clash when trying to build a
single QEMU system binary:

  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  duplicate symbol '_vmstate_gicv3_hvf' in:
      libqemu-aarch64-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
      libqemu-arm-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
  ld: 1 duplicate symbols

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index c6de2d9d00c..25a4144c83e 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
-specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: files('arm_gicv3_hvf_stub.c'))
+stub_ss.add(files('arm_gicv3_hvf_stub.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
-- 
2.53.0


