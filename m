Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4687AFDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSC-0000Ux-HY; Thu, 23 Apr 2026 13:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxRm-0000LY-8X
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:02:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxRk-0004bZ-FN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:02:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b150559bso55103575e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963754; x=1777568554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JPzvlo9um4RJnn5Z0StH34yRFT3d/QW3zHx2ct8iG9g=;
 b=R46Gu5SE9BGH64m10IW+CARvNfeh34gEZTh+SRgV6oXFHrtAsNZYPUTMhbypwP38/B
 HEVphZnkLlt6kfowWkuoR9GkuCg+6no9fH6CqhkUZCk/tlMRjFZS0YwZUEFY9+O20E93
 1ajz5xDmv1FBSCTv80YvWeSo/lp8I57e5URSp/pZHPl1TUBMAxi/Uya3XcaxdF7Kv0CM
 4CFx2ctRcXGaaRTfpVihBBArydEvT6ezgkHmPMGNvlezMHHVxCf1vUTC+Wie8GlVzj8f
 +D/cYqdcElZmrReu6NmXb6VvBwsOhxDubjO1xnmgetBjaKB4DrLeOZFA7X424svz9AB0
 dvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963754; x=1777568554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPzvlo9um4RJnn5Z0StH34yRFT3d/QW3zHx2ct8iG9g=;
 b=Frq17pYcQi5TgxvLUsZ4ejiU5y5xNZN7htrLx74nb/BIeqiV54CNZQ8xhKhjPA/5wG
 WCDls85Y7BGXrw7ej3RY+3NpcVl8CT4+3BhXq97Y8nBzOCn5nE7+AqfjhVEuhN0FEJ85
 cupDFZRj93skDgAyUBkSUy3Uzgj71XK5hMVcoSWS/J6mrTkoVr8nLYtzNF6xEbQfcENE
 65n/guJ/+72rB5m5OpXzZ7TF4+bP/ThdejmsenqOl0O5j5Y3H8caulD3czPnVZID7Sfh
 EFB3bD9BTcuEEmvR2pnwHxsShbWauzXFOUufSoOfSoktkdiR2gMrtkngeYMlSFlatTPT
 o4bQ==
X-Gm-Message-State: AOJu0YwGMhci6+f5G9WNQs5gp6dEF+XJW7ACfdQI1BIPM1w8kEZPdJQd
 AWuHmb282NSKCgLD1cSNYkj4HzPkVU74eG2zvb6bFH8EZ/Lqh145HGfDH7/Zt9a5XozYU93+QVw
 f3G0EWoQ=
X-Gm-Gg: AeBDies4OpAXDxIHnWU6wIasnxQNLi8fjy6jE8okMRN+hB8loC5zOj5hXHhYCpV9wSf
 dvQcX29xRSbg7UB8bTg+fomYitIrS8+K8tmk5QheilKHIk9Badoltr8QvjPK+N0mZt1njYsxuAJ
 RhI+KNUmrYyoPQ3VU086tZce3cZQu8mb+4hurfKz5Xe0GJ1QzUG2bRMW1z9Cj2CpMPSFp3CXBYP
 /XFlJUzkgsjewRadLu2Sw4KbUqRJ4S9Dw55VTbxL167P/ApBYGThCv8SnJPdM7j2fdrNgYaSJUC
 3qZtaM7EIoS2Fw7AJeSgp8PpX6zrwrtJzoUTDSkJ7lnccvGYqfXRnzNcZ09sns6qq0kxLoXgbaM
 zgxtrm/lMpRpU7Kes3XrWcx+3NpZsnvMyTN5Dniafre/UgoOtR2Htq5BY5Hj0Ug/QFO1C9tLdlT
 KOtr5uXqnauIObmCnp5RESajbAQJcuiEU9+FNczrcrbuJeZudlRsBkCeZV3XZQT3vsyWxskiJZ2
 DDS0i2uVOk=
X-Received: by 2002:a05:600c:8717:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48a568faffemr173859635e9.8.1776963753609; 
 Thu, 23 Apr 2026 10:02:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm83393205e9.31.2026.04.23.10.02.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:02:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/16] accel/hvf: Assorted collection of patches queued before
 v11 release
Date: Thu, 23 Apr 2026 19:02:12 +0200
Message-ID: <20260423170229.64655-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Various patches related to HVF I'm carrying.
Some are already reviewed, some aren't :)

Except the last one (RFC) I plan to eventually send
a PR with them once reviewed / tested.

Matheus Tavares Bernardino (1):
  accel/hvf: fix double hv_vcpu_destroy() causing teardown error on ARM

Philippe Mathieu-Daudé (13):
  target: Simplify env_archcpu(cpu_env(cpu)) expression
  hw/cxl: Define cxl_fmws_get_all_sorted() stub
  hw/arm/virt: Do not select Kconfig symbol PCI_EXPRESS
  tests/functional/test_aarch64_kvm: Stop dumping kernel ringbuf
  hw/core/cpu: Expose CPUState::start_powered_off docstring
  system/cpu: Defer memory layout changes until vCPUs are realized
  system/cpu: Reset vCPU %exception_index before resuming it
  accel/hvf: Enforce host alignment when calling hv_vm_protect()
  target/arm: Use generic hwaccel_enabled() to check 'host' cpu type
  target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
  target/arm: Remove vcpu_dirty=true assigments in
    hvf_handle_exception()
  target/i386: Report TPR accesses to HVF
  Reapply "target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0"

Scott J. Goldman (2):
  accel/hvf: avoid executable mappings for RAM-device memory
  target/arm/hvf: Fix WFI halting to stop idle vCPU spinning

 include/hw/core/cpu.h                |   2 +-
 include/system/hvf_int.h             |   1 +
 accel/hvf/hvf-all.c                  |  12 ++-
 hw/cxl/cxl-host-stubs.c              |   5 ++
 system/cpus.c                        |   1 +
 system/physmem.c                     |   8 ++
 target/arm/arm-qmp-cmds.c            |   5 +-
 target/arm/cpu.c                     |   5 +-
 target/arm/helper.c                  |   2 +-
 target/arm/hvf/hvf.c                 | 118 +++++++++++++++++++++++++--
 target/hexagon/translate.c           |   2 +-
 target/i386/helper.c                 |   2 +-
 hw/arm/Kconfig                       |   1 -
 tests/functional/aarch64/test_kvm.py |   1 +
 14 files changed, 147 insertions(+), 18 deletions(-)

-- 
2.53.0


