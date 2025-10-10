Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E48CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77Di-0001aK-3C; Fri, 10 Oct 2025 03:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Df-0001a6-LB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Db-0007w5-1j
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1538314f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080024; x=1760684824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJSvMMJXQte8aWXKowubQTblJA/tVcB5k1ljNNzIK6Q=;
 b=XFdEfYb9t8Dmr854L7H91s3Qbgst/Q5MRAUAnYyQBxrtxwW2q29W1gtn/JzqN0Whvz
 BHqTwX590k0O5cLZ2AE265G4Exs09hQx8Y1w6Qq10t15qFMJng9r6rTDY8C7SWNTSeU5
 Ml6ynMC3rx8giYJJKzKQ461eY1oVOwRufGvtLlaa4OPi1wFQGjl63xlasgoUAsJ0zYvd
 uI8HdGCwFN6eH93C7Dhs58a/8ya2fp/ZrQsbDlmqVVH7TUfCR4sTGMCi7Wa9Z9B7XpI6
 eIpYc7x5RUqsEw7isfF6H3NQaKmBDkOz3OaoWmkjspufwoXszQrVTokHhthu9GYDBPwP
 knAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080024; x=1760684824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJSvMMJXQte8aWXKowubQTblJA/tVcB5k1ljNNzIK6Q=;
 b=hZk0xfHYKPYq7MPzMxT6xnFjmPCac48Sk9RkgLJP2s8GP+Hh0ZGGblIUYsjNeMUkyu
 vM5ZuFgRnuIIKGb+9fDRE3+Cci+pYY07jgGtSTD3svy6PP6R3Kd3ehJyxTP+8wlv1uUl
 v1con0N7rdQpvtrDC3p8j4wp1hbm6Lyb1UpjZYfcrnaiJYTiPp77V/rhY25ihw4lomYP
 6x+iYYfM8UExLaA8sh914OfrvYIbd0VCfW48txPTzCooBEP0UZF4gCLVjdtyPlNbiEAf
 V8GA6DYgs6l8LmhvVK5GLGd1At2wQUblX5zOFZH9Q4AgTNoenksyenXuQFjv/SFctLxG
 B9+g==
X-Gm-Message-State: AOJu0YzVCF51OcxmWTMbf7ovSqZjpPKRgX8fxfEZ4S8r5YrCtp/arHH5
 0TbwYmG8gCIR4KteQC1Nbkxo3TQmIXDg31mwMCp0u08ec9afUAhxGwNCfBmDSutrQlOpqQCAofR
 GPNmbZb+k/A==
X-Gm-Gg: ASbGnctJV7gIwlXydenonqjvHonRxJC8WWvZeUNDNXBDTvQgyaicPq0AKlpQtmIL5CC
 J0rsGUPwIjXzWKPPB5KnQm+qgxF9ZURRUBkwMLKBFiF0T/3yNleYw0Kfo1REw184eTKP8LW/gwq
 +xoHTYi/HtF/O6WI26x2AKkyUGdky6KAXBWcp5q/ioi44g4rQa5uo4amILOp5dXHv4xfkbuvpPb
 c1mqdmzyJ81L4xGLEPG9+2jGIhLfpq2orO0SOeCKVTIFQX/TyYqNaYutOcMRg8YxtTfq2Di0xub
 tG0XITMqFyCJWJjybphPoKKU0urwYrizbGyGCFB2n58ua6MdYCAbEEuSgtsuioNxD+tgn72nC89
 HYfYbyoR+6gJRzlPOWoLv1Cp5gQ8iR1a3Br3gJ1hvKvYKBHtP2Or6yTN20qj3Amd8v1hxfY3yHn
 V7D4PDtLbQKyiF4jWMCMVZ9xK4
X-Google-Smtp-Source: AGHT+IFO5Y6xuWYEwk3gpRwdKeL1qvsAvRlDJfkbF5i+fIqe/nxz6OnLsa1q70mzYNggDcqJGQ+9eg==
X-Received: by 2002:a05:6000:1861:b0:3ea:63d:44a8 with SMTP id
 ffacd0b85a97d-4266e6ca4e7mr5957183f8f.15.1760080023971; 
 Fri, 10 Oct 2025 00:07:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d404sm2728103f8f.3.2025.10.10.00.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/13] target/openrisc: Remove all uses of target_[u]long
 types
Date: Fri, 10 Oct 2025 09:06:48 +0200
Message-ID: <20251010070702.51484-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Missing review: 7 -> 11

v3:
- Introduce mo_endian() helper

v2:
- Remove 'TARGET_LONG_BITS != 32' dead code
- Addressed Anton's review comments (MO_TE -> MO_BE)

Remove all the target_[u]long uses in OpenRISC frontend.

Based-on: <20251010031745.37528-1-philmd@linaro.org>

Philippe Mathieu-Daudé (13):
  target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
  target/openrisc: Do not use target_ulong for @mr in MTSPR helper
  target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
  target/openrisc: Remove target_ulong use in raise_mmu_exception()
  target/openrisc: Use vaddr type for $pc jumps
  target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
  target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
  target/openrisc: Conceal MO_TE within do_load()
  target/openrisc: Conceal MO_TE within do_store()
  target/openrisc: Introduce mo_endian() helper
  target/openrisc: Replace MO_TE -> MO_BE
  target/openrisc: Inline tcg_gen_trunc_i64_tl()
  target/openrisc: Replace target_ulong -> uint32_t

 target/openrisc/cpu.h        |  31 +--
 target/openrisc/helper.h     |   8 +-
 target/openrisc/fpu_helper.c |   8 +-
 target/openrisc/machine.c    |  20 +-
 target/openrisc/mmu.c        |   7 +-
 target/openrisc/sys_helper.c |   7 +-
 target/openrisc/translate.c  | 459 +++++++++++++++++------------------
 7 files changed, 260 insertions(+), 280 deletions(-)

-- 
2.51.0


