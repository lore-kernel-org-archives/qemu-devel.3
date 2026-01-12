Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53272C9EC68
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFCZ-0000qb-5X; Mon, 12 Jan 2026 05:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFC3-0000J4-SR
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:30:53 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFC2-0001cG-86
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:30:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so68300585e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213836; x=1768818636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7267+OhhCBR5I6AkRU6RfU6yngvUSAYC2qk6Sp2APtM=;
 b=x6zqhVfc9LueJ+IAO4AO7+LDIl7y2JNN9Ooahx2qTLUmquxFI/5f+VwVQhqFARCIzC
 kVSZ/EAP9vCloRRnV/zHGa7jG20AXFs3rU1cpqGxqHznqmvcWBZYWedJOjllx5EH1TQ4
 qGQJagfSnEl0P/SfHEXItHVJapNIDR9+Tm4Ycnhx4tJOtpKmY/H5JplkipIXWjmb93k1
 ZTLrgcToT1l1j8FEEgauq62PpOJSiDDe8bFNtuAO859VyjFD5tUfbxSG77MEWVltlyjX
 oU5mRZpmPDIFGr520dWgN3SCSwh30A0ZGT1hmOD/rUE5+gWGXxkXhMvO9HJSQaun7HFc
 2JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213836; x=1768818636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7267+OhhCBR5I6AkRU6RfU6yngvUSAYC2qk6Sp2APtM=;
 b=VAQk7vmX0YK8FcEtZRXDQN6RsgPAlqQtozFuLWv17N1sUPQa3F8X1p0/s0JbW3Bq41
 9bLjnX16ZZ9+EFv7xhyy2k79dQ+FMS6NR/K2BQR6FiYjnj0LTtb1VuxMp6C+Tw91Mt2z
 vOcXCp56fmI9jPSp2jOAbkDeTe+9WMZVNlN9mizTkH+/xLl3Kp/FJLDnWCVEEn0vpBSq
 rXMrpToyLgs4AQExHyAD0P8ZAZ9J7eGQilaPv/D2fKw6YJ2SmXTUQ9eyINk/FdCcBrDE
 U3BvDUCQN4tsUjWxXoPxSULzzwCRQtJxKIlCd1lO9LcEWytbzPdzaTtj49ObVEBOml0C
 pT8w==
X-Gm-Message-State: AOJu0YzE0+euBUQabqVB2OFcYW6KXKlwRQWLwUyxoaY/wT6ZfyBdsN91
 vGdzlXcozOcr1UyqiLvV2UNBRj6VPuMK215cpcSHyv8S/yQ6S5aCilEYwvug9Lvpxak7C/UzIHT
 qjMX8eIE=
X-Gm-Gg: AY/fxX6LCWnVfUByOpDsi/bT1kSZGhW3fNC1z01s5jkIuAoX/IBTGS2tRzSDwvVqzDP
 86UtaY1X9pfinIKG3yyqsy4mG7zSH9mPaTBoIqu3IO6Lk+m+dARyWK5ZXvl+ID+itm51NuLWOgJ
 O8u5T4fl5FF0q9YoahK4BZndxwXsaNziBZ7jhHoG/wwCK06UA+dK/65kBJWpMVBIDnAh1SQRAOz
 vuvqEczuuvbt+NESyjKaLezNmThG8+Io8y45RxwZNoXDHnhUDNorvjrlkcsFWTiwUQQ8G/iYDos
 vGLO/XF6cFMtQzVFQcxt5/MTue41n0zE/+K302S7ihtlEZrfefNJQGxIOyuy7MUt+0QgFrQyuSD
 gqLovRGu0vT0ZVxTL2BnyIC8G+0XGgqdirHO44dGZA/ISNGuIjI8645VzwPGAZ8YSTB1I7YRBJo
 jbfGMCiBQDjUebZeJIu68qYoE6zHHFghnmDawHFCHP+A9RDIKKSLrFFS2EtNL2
X-Google-Smtp-Source: AGHT+IEO88rv+iPQWE+EMhOoBXvbqlCroVCaTfDpn8JJM82nfaleCZ8gmQmLsgcz42i0B25qOsQDuA==
X-Received: by 2002:a05:600c:190e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47d84b3f21fmr209681565e9.35.1768213836159; 
 Mon, 12 Jan 2026 02:30:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dd78f5a8sm18004224f8f.27.2026.01.12.02.30.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:30:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 00/19] target/arm/hvf: Consolidate
Date: Mon, 12 Jan 2026 11:30:14 +0100
Message-ID: <20260112103034.65310-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Series fully reviewed.

- Patches 1-11 fix migration on HVF
- Patches 12-14 remove a signal race with WFI
- Patches 15-18 correct guest timer frequency

Since v5:
- Rebased on top of 3bee93b9abf ("Fix i386 HVF compilation failures")

Since v4:
- Rename gva -> gpa in hvf_set_phys_mem (Akihiko)
- Dropped missing VTimer synchronization patches for 10.2

Since v3:
- Call qemu_real_host_page_mask/size once (rth)

Since v2:
- Improve host page size/mask uses (rth)
- Remove cpu_test_interrupt in hvf_wfi (rth)

Since v1:
- Addressed Mads & Richard comments
- Fixed migration by reworking memory listeners
  (unfortunately the current broken code has been
   used as base for WHPX)
- Sync CNTV_CTL/CVAL_EL0
- Remove WFI racy signal implementation
- Simplify PSCI Suspend (I expect the same can be
  done for the other hvf_psci_cpu_off() calls).
- Emulate more missing registers (PMU & Monitor Dbg)

From v1:
- Fix a pair of memory leak
- Check a pair of return values
- Mention calls which must be run on vCPU thread
- Force MIDR
- Use hv_vcpu_config_create/hv_vcpu_config_get_feature_reg
  when not running on vCPU thread
- Factor hvf_handle_vmexit() / hvf_handle_exception(() out
- Call hv_vcpu_run() in loop
- Guard hv_vcpu_run() between cpu_exec_start/end()
- Restrict ARM specific in AccelCPUState

Philippe Mathieu-Daudé (10):
  target/i386/hvf: Use host page alignment in ept_emulation_fault()
  accel/hvf: Enforce host alignment in hv_vm_protect()
  accel/hvf: Skip WFI if CPU has work to do
  accel/hvf: Implement WFI without using pselect()
  accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  target/arm: Create GTimers *after* features finalized / accel realized
  target/arm/hvf: Really set Generic Timer counter frequency
  target/arm: Only allow disabling NEON when using TCG

Richard Henderson (9):
  accel/hvf: Create hvf_protect_clean_range, hvf_unprotect_dirty_range
  target/i386/hvf: Use hvf_unprotect_dirty_range
  target/i386/hvf: Use address_space_translate in ept_emulation_fault
  accel/hvf: Simplify hvf_log_*
  accel/hvf: Move hvf_log_sync to hvf_log_clear
  accel/hvf: Simplify hvf_set_phys_mem
  accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
  accel/hvf: Remove mac_slots
  target/arm/hvf: Implement dirty page tracking

 include/accel/accel-cpu-ops.h |   1 +
 include/system/hvf_int.h      |  22 +---
 accel/accel-common.c          |   5 +
 accel/hvf/hvf-accel-ops.c     |  18 +---
 accel/hvf/hvf-all.c           | 186 ++++++++++------------------------
 target/arm/cpu.c              |  67 ++++++------
 target/arm/hvf/hvf.c          | 167 +++++++++++++++---------------
 target/i386/hvf/hvf.c         |  44 ++++----
 accel/hvf/trace-events        |   1 +
 9 files changed, 208 insertions(+), 303 deletions(-)

-- 
2.52.0


