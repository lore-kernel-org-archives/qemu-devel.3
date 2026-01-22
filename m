Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694D4C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTQ-00014s-Fu; Thu, 22 Jan 2026 03:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTO-0000mQ-EM
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:26 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTM-0006Fj-QJ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so620672f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072123; x=1769676923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NjJh+n8oLXlyBLnzim7XsVqlpQS9JRK+6x+WCLrk+0Q=;
 b=wjHYoBvIsVSQI41G40snETlVRVfASzd3zKXqk6TwFNmAmqCetQn04nNN6Z9ArPvupc
 vLJSHhS/QYqGCCEsbT0J6suBwYSjwKYoytL0AQcOw3TLynMHK8lijOTeZ8ak4cIHjXLp
 qlbAzb4Sypv/pMq0xSLDDOdtiWs0lUoO2tgSxGBONtvqmO8f3c9VV3CbnnHVIxFTVIXL
 wj8sYOvVbKnYuNuHbIZ+w09ZdS+vCVB4LQtJ5w0E8fNGOnqY5KCfHK5DxHoQERu/zHAg
 1w7KEBBuTrQSfrPgHIwUWbbcWSfcy6TgvVkLze11knoalLtJExI39IeWgkX/vYHIEWML
 Tqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072123; x=1769676923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NjJh+n8oLXlyBLnzim7XsVqlpQS9JRK+6x+WCLrk+0Q=;
 b=i2f5A0Wq3qAwiWSUuYxzZmuFGsRGnJjKpLySkqGFPigl1fWqzS081UQ3l8K/CJWiT5
 U7P82mvoHDl4Fp4MultRPqceGA8r9vmRuhNni/8VDidR5/kE7iNA15LJQ6MWa3rvV9Q4
 F4UmYTxZLYQd/5I75Wi7OWOpFNwfiKxKWDcL7Hsxrflrc5GH+BMgfRR/Dg6u19l7+cVc
 Q4PGRbD5qLYg/kkZizct4WbFBcIHgK6o2QM4jmReNmpfhN/moDGQ2ZH1HGT/3HvjgRyM
 OowUtQbeU00kaCt0o0z03OWub5tjw45/v4t28B2cUQnAMEahEilaHW0KODiSMCROfKUT
 csTA==
X-Gm-Message-State: AOJu0YwqbbzMMBnMkznBJguWaEFGZwhIFGxWLCSlkAnLteQXtkJACupH
 MTrez0GfKyPce/WzhyVhu5XFlBWkIkE6uxvEqZXYQmv6EvyuPtjqSVKLKoRPpAkr4AudQyMc/vS
 EYpKSxTQ=
X-Gm-Gg: AZuq6aKSZA+xU9HZEfHA4MnVgOLo66xUL4oi1KWIYJcsAnIbZoaHX8uSBIsThpogJw5
 ak9rCMLFhMxnfNB0Y6TBl8uMZ8yF2ibvnFa3SX3BKhJZsDI2ngVwuGbwUWhqjBLYo//+gypBRV4
 AaIsdtbk0wJDEMzmBUdk4qV9xzbHzGNHJZ+fQGJUb6ds6oNBkRjTHFgyU//RSBg4VMIvuP0MfMh
 M3lH9+rDOyhX3ro7rGQhba37soQSIQqoIdwsbUPBqeSJGl+075DS918+2Wth9nsLM7aClM/mL9O
 6F2EIs2RewFrYJ+5Nw8uAmbb1oiFasZcpi9V/xt5dq4CsREOMcooyA0YkZI+JeKZ92MGw3YZA5F
 OjNNq+nQplayub6kNYBDEl7A7JAx8NhELVV3RpGhxSeDiwUe4H+C9J/IuEzqmPFmwXzEGRZ27kS
 ytVe4V+Ny6b/7HmU1VemI/bDl4YvyH8LwBABTU3QWzYCeTb9s+Ymb+TW7rPu3UNduqdkMhdT8=
X-Received: by 2002:a05:6000:40cc:b0:432:8651:4070 with SMTP id
 ffacd0b85a97d-4358fed143dmr12969172f8f.10.1769072122533; 
 Thu, 22 Jan 2026 00:55:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm43075403f8f.40.2026.01.22.00.55.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/31] configs/targets: Forbid OpenRISC to use legacy native
 endianness APIs
Date: Thu, 22 Jan 2026 09:52:45 +0100
Message-ID: <20260122085255.95035-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

All OpenRISC-related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . 52392f95e69 target/openrisc: Inline translator_ldl()
 . 16c0efb5a7a target/openrisc: Use explicit big-endian LD/ST API
 . 5b67dbf1dc3 target/openrisc: Replace target_ulong -> uint32_t
 . 500708331e3 target/openrisc: Inline tcg_gen_trunc_i64_tl()
 . 4f6c60683f2 target/openrisc: Replace MO_TE -> MO_BE
 . 73cd283e58d target/openrisc: Introduce mo_endian() helper
 . 2f737e19a4d target/openrisc: Conceal MO_TE within do_store()
 . 22c36c0a20c target/openrisc: Conceal MO_TE within do_load()
 . ef797ac0025 target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
 . 81e2fb236b7 target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
 . 9dc4862dc4a target/openrisc: Use vaddr type for $pc jumps
 . 2367c94cbb1 target/openrisc: Remove target_ulong use in raise_mmu_exception()
 . 1843e89bec5 target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
 . a3c4facd395 target/openrisc: Do not use target_ulong for @mr in MTSPR helper
 . 2795bc52af4 target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224161804.90064-5-philmd@linaro.org>
---
 configs/targets/or1k-linux-user.mak | 1 +
 configs/targets/or1k-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 810567a98f9..97d7cb10465 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 89f81b75bf7..c53408a2bf5 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


