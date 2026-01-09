Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39ED232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve65a-0001tp-2k; Fri, 09 Jan 2026 01:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65Y-0001tN-0n
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65W-0007H5-Bt
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2016874f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767940508; x=1768545308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc57H6Wj/i2IihsY5LvmXV7/IJY0oilIjXpTEqMK6Z4=;
 b=ZH5TAq929mXXN2drv6Ig4K33LuJ1CBiSW7Sht4PKOhzSzNKZFCCBpzetC/kNfjKGJh
 3c34Us15fW0QTaa8IB1hd0WwIMapkheVIujNee4nVw/bdY00tzne7KALEmPcL3nJIdd9
 gZGXvBtUtHzwfcqeiCUUHVHvVsNTxOFAjcbJ1qfwMswFO4fAJUQJAQAKWPWLFSkvAWFM
 qSxA8m9jCkZ9waD6gfPrzakJvZVJwfm3D/6t68cCCcagK+X+WNPrRm/RnW0ezgN1YHGT
 pydcZyoL/A9SiQ7apxIZZnRZ9J9aLBAeMUUXAEEH/UW5iikDzMjXDuUtkg60g/dOXfnS
 x+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767940508; x=1768545308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vc57H6Wj/i2IihsY5LvmXV7/IJY0oilIjXpTEqMK6Z4=;
 b=vvxhQixkVZeaKGS4DA11CCHPAI9eu6QtTuu2RaIOzREDz328VS6gprPscVVaChdeWM
 xv18woaynQJl3aXcX2ETO/ivCLqXIpq48bk5ejLGtv1mQLfI2DD7salfSPu3azdR1NLi
 3ceOBJk2/7C0Q1/NhCfMcoYoxh5KEF1heIZQCI7UzUME2o1jqk7e/6g6jhRDn5ghbwsB
 42tk5vpBRVf2nsIVH7Nc5ayNTn9CEcezFmxE9zJQuXEE2DEKXvzsw0AV5KCSmhV4hgkS
 Cn10s9U/eUYJPzX7ax/0DI8sESwf3o5oxjeO3fRSf7bwf3qjiCB0Qbj82r33+LKKFaI6
 xtHA==
X-Gm-Message-State: AOJu0YyYNRdzVOUm6YzlM723G42GzCYmyVQ1UWjmE3XhMC9jiWPjuo75
 uMKJEOgPeOtK+uyjKcvAnyv+qKd1d2Ir9WU6TpOWXvxfFRO6AdZ84xZ5t95GNYd/JdhGfaQlWlm
 xhMTn+yk=
X-Gm-Gg: AY/fxX6ulR4KKnI5EWDKFSy+Drr4Z9af0gsix4u3sv1PsYQ7z5Jumgf1PvpwFk6l97c
 6D/YxvHTqCjhtjsm7soQTRsc335bzmCpb6kWASdoFmyk3QxW/0kpwfG4xevYPS8QJWYX0SYhAXO
 LWaRTtW6/7A67xh3Ph0YtRaUH+XAPIJMnSMhgEZuwJee9gO6FVPsAgcSRvMxLQ7/Sfc7wc95AQp
 VuCBJ3yJ/v9xQ+3TK/+O2fwamDa8UoFmEbo+a9DeTfUTXzYDjD7wdTfK9QGRQdPXmfMz0CC7qqp
 ec5MCl/oyJQPxJwsIeDzLbbrjt6ECe6euIcFj9sJy/WkUmlijs4GaDL41UPRss48sF7BqDo+aSU
 dv0NbFXBDa7ZrmrEze0W+b4kvh66CKYM0oU9jXHFQJSyqDMUttDUWjgKMKeCwzePtPdjTkkPktn
 4dM9wlPh0JK4zjAh5ReYYd6ohLrcJ/lmX1lFfcRmYwjzZOUdkToIN48mG5lURB
X-Google-Smtp-Source: AGHT+IHGv1ROT2uOE1gLfMwrMiHJmcvDuDgCwdleHJhnLXai/tTH4s9x/CR4pOsqZ141OaI3HQC0sA==
X-Received: by 2002:a05:6000:1862:b0:430:ff81:2947 with SMTP id
 ffacd0b85a97d-432c379dba5mr11427014f8f.40.1767940506921; 
 Thu, 08 Jan 2026 22:35:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm20296704f8f.28.2026.01.08.22.35.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 22:35:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] system/memory: Clarify unaligned load/store API
Date: Fri,  9 Jan 2026 07:35:00 +0100
Message-ID: <20260109063504.71576-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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

I have been confused by the load/store 'host endian' API
for years: this is just about unaligned loads/stores.
Rename to clarify.

v2:
- No "memory_" since it's for host pointers and not
  guest memory addresses (Paolo)
- Fix regexps

Philippe Mathieu-Daudé (4):
  docs/devel/loads-stores: Clarify regexp are POSIX basic ones
  docs/devel/loads-stores: Fix ld/stn_*_p() regexp
  system/memory: Extract 'qemu/ldst_unaligned.h' header
  system/memory: Rename unaligned load/store API

 MAINTAINERS                    |  1 +
 docs/devel/loads-stores.rst    | 47 ++++++++---------
 include/qemu/bswap.h           | 96 +++++++---------------------------
 include/qemu/ldst_unaligned.h  | 67 ++++++++++++++++++++++++
 accel/tcg/translator.c         |  7 +--
 hw/display/ati_2d.c            |  3 +-
 hw/display/sm501.c             | 21 ++++----
 hw/remote/vfio-user-obj.c      |  5 +-
 hw/vmapple/virtio-blk.c        |  3 +-
 net/checksum.c                 |  7 +--
 system/memory.c                |  4 +-
 system/physmem.c               |  8 +--
 ui/vnc-enc-tight.c             |  3 +-
 util/bufferiszero.c            |  8 +--
 accel/tcg/ldst_atomicity.c.inc | 10 ++--
 15 files changed, 153 insertions(+), 137 deletions(-)
 create mode 100644 include/qemu/ldst_unaligned.h

-- 
2.52.0


