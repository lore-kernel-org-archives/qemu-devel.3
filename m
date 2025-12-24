Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12285E776C1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWJ-0002IO-1w; Wed, 24 Dec 2025 11:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRVy-0002Dy-QX
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRVw-0001Gs-Or
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3217796f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592901; x=1767197701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nVCfRdBdeH6qM5hKowFQ+CO0ZL9O+v5VwkCKX8eNtcs=;
 b=bZxxG6lfZAOcXoXncrmvFfbWPR2PuXeqUKMzGUG0qmDGAYWHLWJjN+I3ZMZCtXcH+b
 7D4gyNr7pLQL5DvODlbncJjfG6gE5a5VObTiACsIR8HiEf4/2aL/42YdSmXBDgbF+htN
 kX7ZaGStM47v8CGt+AplCbKVFCiU1SCjqd25M2yTywlwtVCxC9IU0ERalmR+zFfZpDvJ
 nSlMBPQ/oem8Kf66qCzkorq7KQwOPQTWlw2hbCSjoBRuPcO55AMAv9ImeNUnoMhcrtk7
 lcXSe4HuO7w7V4ixcZy8xSzO2qMtSTZfzDxpCxoAOdF1p4t6RqSgtG5Bh/QFHYRdKHYu
 QZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592901; x=1767197701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVCfRdBdeH6qM5hKowFQ+CO0ZL9O+v5VwkCKX8eNtcs=;
 b=AwTBLssxtZrqoGcnI2Hg/6FLdjyrVSZb2an+7qbv4b2HXSvFcZ+KqX16kd/17WG+ki
 82zhXFIZXmF8JSMm9XYvHdkpAyI1PMnAnhtAGZgUnD/bIlThpakbUnc61PzSn5TLp/J5
 0S0qn919/Z+bOqI5PUP40tGWkpkAqEezuyMgQ3t5XfJa1W7uRWGkguJCxhXJ21ol9ppL
 4TrMM4NqAUsH0aFS13vgIgxaJBQK+MYRihbAA5A3E1aydYldPapNQ1NrSwvtOuCOjxOC
 VzUrRKOfgH6AgpTR2PPdEapdb1QYROG+c2u6VLASWq1rIteeCNXLyOSeIkTUxlBiJEP7
 xHMA==
X-Gm-Message-State: AOJu0Ywax2PG5GOnGhEpVtpTNzqWeM7qiS/pjbzx3bTJo1gvMzA5W3b1
 SvISwq1Y6H1Ej0Ff/gF2biPE9H9ShCW+ay4NGQGxbkd2/D+UToMmr7warKX1Dxq5VzzmSFW9MkW
 2LUlVuIw=
X-Gm-Gg: AY/fxX7uRoopjaPqj/BT7s+x8kPCoZx+Bn8Z/G/umiSsNz1LZWCBaHhh6hcrx905D8n
 FNvkw/5U3T1PRxDg6jxYKweIoj6W7GQ0Oo1WD0TPhgpTKUfooUPrzejXXMuvi9v2X68zqJnvOPo
 gcRLQuMbgsUb3EGjJw7ObDqVtSatKUTKpFtkN+Jv0dzVE2v8m0FWlirD103YSNZujeVMFtS+qVP
 ivYWw49eOIXSEMOxgRLwm3IiPH6FXNdyKnZzg/9/OfhnS3+DcNmmRp5Jeo/tZnuSpQmCQ23YEoy
 DMHnPEL+OhbTl7n3ZCseGucuO4H4gedsR4tx94ODsbCt/OCzkT0J54re0XDJu8S3lSZo6sIypB7
 mBhnTsRBGPEkMlOqfzvVWbxfz5WtgadgeFp4flgU8uUNjWBexLRdGYhzFCLXxdQGMB7jyAhnq3b
 GaOJu+wgX2VKnO8QrQ/d/rkV5kyV7mvMw0Rk2HGikAV05sK5qtn8fmbS0ryp/dc/HcDw==
X-Google-Smtp-Source: AGHT+IEwroF7v+zQQi4cW3FKtP659BnlEjnaJZ9x12eWEHP6HHFEYW2zRy32sbQYJTTnXFvH0jP6pw==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id
 ffacd0b85a97d-4324e4cbcc1mr21725423f8f.23.1766592901056; 
 Wed, 24 Dec 2025 08:15:01 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm35618470f8f.38.2025.12.24.08.14.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] target/loongarch: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:14:48 +0100
Message-ID: <20251224161456.89707-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

LoongArch is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.
Remove some target_ulong uses. Forbid further uses of
legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_loongarch-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (8):
  hw/loongarch: Use explicit little-endian LD/ST API
  target/loongarch: Replace target_ulong -> uint64_t for DMW and
    TLBRBADV
  target/loongarch: Use hwaddr type for physical addresses
  target/loongarch: Replace MO_TE -> MO_LE
  target/loongarch: Inline cpu_ldl_code() call in cpu_do_interrupt()
  target/loongarch: Use explicit little-endian LD/ST API
  target/loongarch: Inline translator_ldl()
  configs/targets: Forbid LoongArch to use legacy native endianness APIs

 configs/targets/loongarch64-linux-user.mak    |  1 +
 configs/targets/loongarch64-softmmu.mak       |  1 +
 hw/loongarch/virt.c                           | 18 ++---
 target/loongarch/cpu_helper.c                 | 12 +--
 target/loongarch/tcg/iocsr_helper.c           | 24 +++---
 target/loongarch/tcg/tcg_cpu.c                |  4 +-
 target/loongarch/tcg/tlb_helper.c             | 10 ++-
 target/loongarch/tcg/translate.c              |  3 +-
 .../tcg/insn_trans/trans_atomic.c.inc         | 80 +++++++++----------
 .../tcg/insn_trans/trans_fmemory.c.inc        | 32 ++++----
 .../tcg/insn_trans/trans_memory.c.inc         | 64 +++++++--------
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++--
 12 files changed, 136 insertions(+), 129 deletions(-)

-- 
2.52.0


