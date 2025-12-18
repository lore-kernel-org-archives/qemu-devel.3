Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA17D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLXy-0001DE-Hh; Thu, 18 Dec 2025 16:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLXq-0001Al-Nx
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLXo-0007D8-W0
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:22 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so947973f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093298; x=1766698098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NSN5g1gmcQDvfqX06c2vxNvSnIv7HqynZqyCdun5704=;
 b=Ka66YiLwh2PUjPn3ypgvaTmQiRMNFg0xeNK3D3EfaLTXnfp4qfF7ulCOTTR56P9ltR
 Dlp+W8CLDOhxjMuMJypz77puqV4YIvhCcKhUHctSS76iws0jeK3v/r9+vjgUeaHdPAL8
 pc2oy6tcaWVMtVpzWdDjB0GAiksny747gMJgUPxnfu3T0dZlG2dmPawwDAJI7WSmEjVx
 3PPtDYWdSeT7pOEggAPb/80wiHUKvHaVwgk61hHF7y2Y0pPpitle1ndVyaEAPa6qLwPX
 iyVmQT2IIMqHt0wpJQrSXsxkOrp1i9uFvvf5gNRAxi3GkX+DM91zhxEBwjVR6/6qOLrZ
 iC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093298; x=1766698098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSN5g1gmcQDvfqX06c2vxNvSnIv7HqynZqyCdun5704=;
 b=gBdaXWnv0bdW4Ror5aAAn6F6c3nj/1hrNHDlFU0tjkV3H2GFCE8Kg0dOlwd53zDEXB
 IxRdujPfe9aWkPJZgfZDOcgmRrSn2SoXDoeO15aLVTSlNnutsAhEUFF3T7IuYH/rBx+G
 +TRsxOTXeCJkJnottz30e0Ulm7PUlovN7di0t9YS79lbZmFR4KRMUHquBGjq4IcVSKFP
 3aoPWoSC2nhSOQjgz6cP4HAhSk/k1tJqpMAko/VkTkNGOMaY2yTJrYCTJs8MO7Wm3Taj
 Rn6CLao8UYBffqxoYXmp2NMHzOJcEU/AhfbsAs+AsUH5APWtDer3s4p47EJUEMe9jtHa
 eaog==
X-Gm-Message-State: AOJu0YwHGrMP5EaGeE2we8XOZMRGZlyqM0W7J9Oqj2T5t06J3w9aAO1M
 MmoJ6zpvK6dwsfePQG0HFDa2TQGSiEINQ6gcjtWbmVzo34TJI4u8nVFnkOudclwKV/G4BQkgZcI
 AojkT+d8=
X-Gm-Gg: AY/fxX6wr+nBLxiEnAcuE3Ci27JUVEG0YIE94MCSrM1TXhXQngsFTR2CosbOeMR95nY
 iJ03VIAGL96EyLrx0UGIWIBR6ZtssdbnRF0MDKCY2/wd4Vhs+0+vfQHyt2iFVlyyxwuioYeTF4g
 aY9m8srhjBzcpGrnciguquy0cc6dWFWJ7QJcylJEGiHhgsgy1g0/zv09ZiX90k8F3LTo4H+slrV
 +j1y8/zy1TDbMAp5Wye1bWDDHxO7k9ggB/5LVg2F4YgCOUFLYU73FK+xG1j/bb0fsOaJhNecaaY
 LS4VsLlgJCJI7HHOgTclGOyXJhRHMmhLkbEj1g70fwgCw4HFW3Elf0IQDC5vEIv3iRaeeoWHQHg
 RxXExaYUA6CCx0ZWv6PWbQGZI5q4CDRXCRzqvxl9gQkp0pSZJzw2lLogA0A50TzALiNAi7RyAEh
 06BS+U0RUVO8kcUnS8PehQ7LTstMpZ+2E+pShkPgQMryEoS09ijrfVI/Kv/F24zxgF2N1EW1E=
X-Google-Smtp-Source: AGHT+IE51sVWa+tGQjh0ssGMxGJFVVsnC9OVkJBkzOSrqx7ulPCpa8YpbaJMavj6FU5bxK8mD6/yOA==
X-Received: by 2002:a05:6000:1448:b0:430:f742:fbb2 with SMTP id
 ffacd0b85a97d-4324e4cd56emr1016899f8f.19.1766093298467; 
 Thu, 18 Dec 2025 13:28:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2ebfsm961098f8f.40.2025.12.18.13.28.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:28:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] system/memory: Allow restricting legacy 'native-endian'
 APIs
Date: Thu, 18 Dec 2025 22:28:10 +0100
Message-ID: <20251218212814.61445-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Have all targets set the TARGET_USE_LEGACY_NATIVE_ENDIAN_API
definition, then restrict our headers to only expose legacy
"native" endian declarations when this definition exists.
This will allow us to gradually clean the repository,
eventually removing the legacy API.

(The motivation is the single-binary project).

Philippe Mathieu-Daudé (4):
  system/memory: Use explicit endianness in ram_device::read/write()
  system/memory: Introduce LD/ST helpers with @m suffix (for MemOp)
  configs/targets: Introduce TARGET_USE_LEGACY_NATIVE_ENDIAN_API
  system/memory: Restrict legacy 'native-endian' APIs

 docs/devel/loads-stores.rst                  | 10 +--
 configs/targets/aarch64-softmmu.mak          |  1 +
 configs/targets/alpha-softmmu.mak            |  1 +
 configs/targets/arm-softmmu.mak              |  1 +
 configs/targets/avr-softmmu.mak              |  1 +
 configs/targets/hppa-softmmu.mak             |  1 +
 configs/targets/i386-softmmu.mak             |  1 +
 configs/targets/loongarch64-softmmu.mak      |  1 +
 configs/targets/m68k-softmmu.mak             |  1 +
 configs/targets/microblaze-softmmu.mak       |  1 +
 configs/targets/microblazeel-softmmu.mak     |  1 +
 configs/targets/mips-softmmu.mak             |  1 +
 configs/targets/mips64-softmmu.mak           |  1 +
 configs/targets/mips64el-softmmu.mak         |  1 +
 configs/targets/mipsel-softmmu.mak           |  1 +
 configs/targets/or1k-softmmu.mak             |  1 +
 configs/targets/ppc-softmmu.mak              |  1 +
 configs/targets/ppc64-softmmu.mak            |  1 +
 configs/targets/riscv32-softmmu.mak          |  1 +
 configs/targets/riscv64-softmmu.mak          |  1 +
 configs/targets/rx-softmmu.mak               |  1 +
 configs/targets/s390x-softmmu.mak            |  1 +
 configs/targets/sh4-softmmu.mak              |  1 +
 configs/targets/sh4eb-softmmu.mak            |  1 +
 configs/targets/sparc-softmmu.mak            |  1 +
 configs/targets/sparc64-softmmu.mak          |  1 +
 configs/targets/tricore-softmmu.mak          |  1 +
 configs/targets/x86_64-softmmu.mak           |  1 +
 configs/targets/xtensa-softmmu.mak           |  1 +
 configs/targets/xtensaeb-softmmu.mak         |  1 +
 include/accel/tcg/cpu-ldst.h                 |  2 +
 include/exec/translator.h                    |  2 +-
 include/qemu/bswap.h                         |  5 ++
 include/system/memory_cached.h               |  2 +
 system/memory-internal.h                     |  2 +
 include/exec/memory_ldst.h.inc               |  2 +
 include/exec/memory_ldst_cached.h.inc        | 30 +++++++++
 include/exec/memory_ldst_phys.h.inc          |  2 +
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys_endian.h.inc | 10 +++
 system/memory.c                              | 68 ++++++++++++++------
 system/memory_ldst.c.inc                     |  2 +
 scripts/make-config-poison.sh                |  1 +
 43 files changed, 146 insertions(+), 25 deletions(-)

-- 
2.52.0


