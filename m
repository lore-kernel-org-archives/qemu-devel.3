Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1C4C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6Os-0003nF-0K; Tue, 25 Mar 2025 11:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Oq-0003mr-0m
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Ol-00045L-2b
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:07 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so5109689f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917260; x=1743522060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=35BUB0yKlMpR/hJurzs00OmRTmd2ntRQUmn7l5RxrmM=;
 b=av6t/4AtpzZau9xUn4ijrPF525fhiaU0i6Q7HTNo8U4C2A+hDPJZWZZC128r8KdfD0
 K1sNf+RC/CRa+GVGg5pCY0oML9bapqPLiXICBrnhP+XhlxPcGuCIFf43Yf6tljz1QIkH
 S4hmXkQUJ24CL+v7ZmIFTiQpXpVsjuNicdiBAVkgoUUrtD6sNYf1ReZK9pAalcJjco9F
 PXHj1o8M3HUibES+63uw0/qjWx1QUB0LyWJ1t9N1VwO410nxxP0/yr3AoVN9ayWE7Q5O
 rfJ4brzsFh0kxR96HeXlkZWmFLrpiDp+qmZxt6n1xXabxArV+3jM7lF1/9kpcXxtFzMv
 Vnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917260; x=1743522060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35BUB0yKlMpR/hJurzs00OmRTmd2ntRQUmn7l5RxrmM=;
 b=hoLuee8Kyzd4wXn72g/BKO4uyOBE6E51Aa5k6vDYKQDaOHa1RQ8hrux4v2X82jxBPe
 733KMiUAO3qPnewS+vJ5tpvRqg4Ic9cMeUzWlg9nX20fd6VV0Fk3gwTe49eKBK9gsbMi
 Y1zkIRr70iEAw4lGvBbMn+xycDy9xupSPnj+pyMmo+GrWrzoUjMkEGXXi/5pMaiPvOaE
 TwqIvO4D9TrRIYNGWl0Hch5GAkPTNGGSPm50tuZho4nPBLIHEHSldX+D5Q2zLtflOU5N
 Xl4Y7xz5QGgmFaQ6Xel9AvL0WHYONgaDehhyXWVj+MZ5WLgWWot5o+SvNclPTBbt17YB
 tNVQ==
X-Gm-Message-State: AOJu0YzsGPCr/i/IFbZjxaOEaib99XEXExmo3k+GW5tyzZX4NFCGVzBC
 PAX9nBh6jomEony5eH2qLfqfgbtIKyey/cDTjfYt0P+0HGajzAYfrpxm8HbrNFmKf1zQIHWqd9l
 J
X-Gm-Gg: ASbGncsXbRBkfugUVf0XizGAroLXa3HlOeVT/j9UUcA+mmzfhw7qINUbnQcBT4u5bW1
 jgTBP3Cuh/Oo+iKDFmJSwW/aGKKgjPs/YfZMlQexWjS9IuzYjzEbISvldGJ1iVeFjcf2OslE+17
 yyMwouGhWupmIoLblxkw036XADsy8hoc2Yd2Z0m5dVFZ0U4pQr96S7nMSHZlLpp0HhejPbjerux
 EPbgNigNiz2Fg6U1bqPtqVY+bkS+rLUIN4acK7b2w/bRFQkutKppqrcEi8zFgUVd45YGymMWnpQ
 JxGZOQBh0FgKLshhG0jiMVQU0WuD0bhOSVbj49yj1sG9tFa/1wf24ObxjFkG5OioSWI7gJBu97i
 Drgt7Dsm2zRJuDOOzDr8=
X-Google-Smtp-Source: AGHT+IHGkGYRrA0lVyiXauJGhuzpwoDB48kM9ElMQCP7hlh2B8m0HGsVlpsaUVCMxD1EAC7vz33/Zg==
X-Received: by 2002:a05:6000:42c2:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-3997f9424ffmr11023749f8f.55.1742917260472; 
 Tue, 25 Mar 2025 08:41:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9955fbsm13940057f8f.5.2025.03.25.08.40.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:40:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 0/8] target/mips: Make 'cpu-qom.h' target agnostic
Date: Tue, 25 Mar 2025 16:40:50 +0100
Message-ID: <20250325154058.92735-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

- Remove the TARGET_MIPS64 use in 'cpu-qom.h' to
  make it target agnostic
- Introduce mips_cpu_is_64bit() as a runtime check
  for compile time TARGET_MIPS64 definition
- Replace the ldtul_p() gdbstub call by ldn_p()
- Rename few symbols to avoid future linkage clash

Philippe Mathieu-Daudé (8):
  cpus: Open code OBJECT_DECLARE_TYPE() in OBJECT_DECLARE_CPU_TYPE()
  target/mips: Declare CPU QOM types using DEFINE_TYPES() macro
  target/mips: Make MIPS_CPU common to new MIPS32_CPU / MIPS64_CPU types
  target/mips: Prefix MMU API with 'mips_'
  target/mips: Replace ldtul_p() -> ldn_p(sizeof(target_ulong))
  target/mips: Introduce mips_cpu_is_64bit() helper
  target/mips: Get CPU register size using mips_cpu_is_64bit()
  target/mips: Introduce mips_env_64bit_enabled() helper

 include/hw/core/cpu.h               |  7 ++++-
 target/mips/cpu-qom.h               | 14 +++++-----
 target/mips/internal.h              |  5 ++++
 target/mips/tcg/tcg-internal.h      |  2 +-
 target/mips/cpu.c                   | 42 ++++++++++++++++++++---------
 target/mips/gdbstub.c               | 14 +++++++---
 target/mips/tcg/system/tlb_helper.c |  2 +-
 7 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.47.1


