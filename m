Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79CAD11197
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM1z-0002E8-Vc; Wed, 26 Nov 2025 15:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM1j-00026u-At
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:12 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM1c-00023X-7j
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so1007765e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188522; x=1764793322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vfni1IOQGN3g8RROC5YF75DC2PBdoHAs3xiWfJCop/k=;
 b=rtHquGmdEXU9fBpPNIb1tKgbZIK8EMlGPWyl17ggDQZdgs+ak4qtsFt99LmE8NwXrL
 MAOetcsddS2z7ZAiumYcw7A4IdiyebDBNokdKfwXsO5IhtYF2+hLIsSUlFxv/lFTNsCl
 /rCIq0RC0EzRXRpuFmoe/FmiJKl9DfZTZ09m2xkyZaM04RKvBsB2pnWkPvQqc4uJO0my
 eC+L3Kw2h+qZ4wjUKC4LzNvy6Vva8PjghKqBOtOhXo951vapKqEkkap0dfu5qr4X6blt
 wQhHCwK7VnW/xqxWV0DwyPkTAYt6CGyrZwF/MmzW+PcvzjCO7R9gToKkc/fPGFaAXim/
 iaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188522; x=1764793322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vfni1IOQGN3g8RROC5YF75DC2PBdoHAs3xiWfJCop/k=;
 b=ZpMgXmz/qaOuo2t8Pdoo9of/HxmVl6Rlvpazt95y/RXCWgtteMEfGcn7LZQgbrV0o8
 OXPwVjopLMvTB4PSv05JRUtChanZtTOD29RZHmpEKSjOas0dabCSOJ4T0u+B7/uX0HXm
 hYyk3UhjnwJc9ufcwnhYW7n5kiKFRNs1jznVpF8f6zOLP7YTWHlvb4BUgZgi9HgBH06f
 sWP10lf6EdsxXFR0EWfwBtEcg5DVX06nOGRwEjN2ToOr+IE0CRtGfLbL7C+GCBdP3CPb
 8hlW+eeI/swFnQJRx5FfSNR/Z368B1L1FhAqq8CbOc8UWkE2/4Fv6iX6k2QWURlSZm6a
 SDlQ==
X-Gm-Message-State: AOJu0YwTqowNZmILeolFHro9fweixyvwxQbnwDyY2Htcaxn07+dRgXr8
 PIaDfD8gnJX4BajqnmdeEECs6zHjGZ2CNp3+hEyeCtuMqU4mgeUZC7uTG41Nlxp8NgiMutSa2mC
 oLox4F4CKwO4z8TY=
X-Gm-Gg: ASbGncvj8MVRdC4zkuibxdZpB4qSC03t+LBv0mU9hkGuJ0lxGU4jtomu8/AY5WkYTM4
 FflTZuAihPX3Zm7m+mK7G+xRTxjuBBCmyFGLwj4QFvTG199Fp0lQNNRNP3+nUkW34tw8uqhd3Bm
 i+OlM10oxwbeteZwGXEF8aQ60hxDHANJhZtyguZgXUX33pD2HjyJVlG1bOD146DCH1mkOli/7Md
 pwnxrAraS7MR0mynd0zSB5reGqQJu9KGausTfy3T7Z1JoZcHHfMeL/EkQ99JjQQ2TevQx8qT91n
 ZvfPvTIJy2KThzyvrTLQ94MeaRRoRpuh6mBWwuluKEwZLyCA3Znci0reKTZwHHsy6Bdm3xBru8R
 KS7wI9DvNycBOPpIjRKiEt7P21RKH+PeF4SoEYGrICgwmpXeVMi5l/ERwH0iY7M6hKH6eXi4WsN
 aAREaCUCRFw5GWe9WHfLsWGSWDzioM1zqVt1F1aUgfYJOKw6YCtcEi8+xGz6Mm
X-Google-Smtp-Source: AGHT+IEP6tsuteUmqKX0XpNrTRGTxbTPt+mRAu1nTsuHCjcA5oSUt8XKRzS17rPSMjsNnUnpRFPsNg==
X-Received: by 2002:a05:600c:3b1a:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47904b12f1dmr74230945e9.19.1764188522322; 
 Wed, 26 Nov 2025 12:22:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm33009191f8f.7.2025.11.26.12.22.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 v3 00/22] accel/tcg: Remove most MO_TE uses in
 cpu_ld/st_data()
Date: Wed, 26 Nov 2025 21:21:36 +0100
Message-ID: <20251126202200.23100-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Since v2:
- Reworked SH4
- Completed PPC / MIPS.
Since v1:
- Fixed s/little/big/ typo (thuth)

Still trying to remove MO_TE uses, here looking at cpu_ld/st_data()
in fixed-endianness targets.

Series split of bigger one [*] where Richard made a comment on
*_code() patches. Since not related to *_data() uses, post separetely
since almost ready (still few PPC/MIPS paths to update, but I'd rather
check if this is heading in the correct direction before looking at
them).

[*] https://lore.kernel.org/qemu-devel/20251121134503.30914-1-philmd@linaro.org/

Philippe Mathieu-Daudé (22):
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  target/i386: Use little-endian variant of cpu_ld/st_data*()
  target/riscv: Use little-endian variant of cpu_ld/st_data*() for
    vector
  target/rx: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/hppa: Use big-endian variant of cpu_ld/st_data*()
  target/m68k: Use big-endian variant of cpu_ld/st_data*()
  target/s390x: Use big-endian variant of cpu_ld/st_data*()
  target/sparc: Use big-endian variant of cpu_ld/st_data*()
  target/sh4: Replace cpu_stl_data() call in OCBI helper
  target/mips: Use big-endian variant of cpu_ld/st_data*() for MSA
    opcode
  target/mips: Introduce loadu8() & loads4() helpers
  target/mips: Pass MemOpIdx to atomic load helpers
  target/mips: Drop almask argument of HELPER_LD_ATOMIC() macro
  target/mips: Inline cpu_ld*_mmuidx_ra() calls in atomic load helpers
  target/mips: Expand HELPER_LD_ATOMIC()
  target/mips: Inline cpu_ld/st_mmuidx_ra() calls in memory helpers
  target/ppc: Inline cpu_ld/st_data_ra() calls in do_hash()
  target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in memory helpers
  target/ppc: Inline cpu_ldl_data_ra() calls in ICBI helper
  target/ppc: Simplify endianness handling in Altivec opcodes
  accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers

 include/accel/tcg/cpu-ldst.h         |  46 --------
 target/hexagon/macros.h              |   6 +-
 target/i386/ops_sse.h                |  12 +--
 target/i386/tcg/seg_helper.h         |  12 +--
 linux-user/vm86.c                    |   4 +-
 target/hexagon/op_helper.c           |   6 +-
 target/hppa/op_helper.c              |  44 ++++----
 target/i386/tcg/mem_helper.c         |   8 +-
 target/i386/tcg/mpx_helper.c         |  28 ++---
 target/i386/tcg/seg_helper.c         |  16 +--
 target/i386/tcg/system/excp_helper.c |   8 +-
 target/i386/tcg/system/svm_helper.c  |  69 ++++++------
 target/m68k/fpu_helper.c             |  12 +--
 target/m68k/op_helper.c              |  91 ++++++++--------
 target/mips/tcg/ldst_helper.c        | 108 ++++++++++++-------
 target/mips/tcg/msa_helper.c         |  51 +++++----
 target/mips/tcg/translate.c          |   9 +-
 target/ppc/mem_helper.c              |  75 +++++++------
 target/ppc/tcg-excp_helper.c         |   9 +-
 target/riscv/vector_helper.c         |  12 +--
 target/rx/helper.c                   |  14 +--
 target/rx/op_helper.c                |   6 +-
 target/s390x/tcg/mem_helper.c        |  48 ++++-----
 target/s390x/tcg/vec_helper.c        |   8 +-
 target/sh4/op_helper.c               |   5 +-
 target/sparc/ldst_helper.c           |   6 +-
 target/tricore/op_helper.c           | 152 +++++++++++++--------------
 27 files changed, 440 insertions(+), 425 deletions(-)

-- 
2.51.0


