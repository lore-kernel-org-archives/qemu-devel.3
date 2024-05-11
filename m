Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA172C25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhA-0005Qn-La; Sat, 11 May 2024 06:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jh8-0005QC-Fq; Sat, 11 May 2024 06:11:10 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jh3-00029W-IY; Sat, 11 May 2024 06:11:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a5a157a1cd1so703827966b.0; 
 Sat, 11 May 2024 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422263; x=1716027063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FRLCSiStzS03uKjm5c7EFnC/rqpApJgOQMqLnOWycmQ=;
 b=ZlE8gYqGsRaOdlriQYSjDCaU9HbJYruShWELXCCBUAfIqgSPRuxY3/wNPCWoueVwE9
 8njbze0h1HnCSC7rMqmIHtBCMqM/ow0jiVIgUf30U85ZoyzfU8EqYigw+L255xtJqEGI
 t76Tg3PALlQzW+unW3Ff2UluGthfAD2pxgWNqI1usgtzGGLoPyMhidlsFt3aS3iJQf2W
 3ChZToaoHhzo0bmZj2voqoY4pdQJgBv6lQF5AMkBGeuosm3VIq8wJOlryXxvS41x/0J8
 XjIX2sGRIZi0E+Otswf7oqWSmMoNvmjTl9pWbdkfM7oxwUu/fgPwcyI5CRZmiT0L9Bff
 OoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422263; x=1716027063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRLCSiStzS03uKjm5c7EFnC/rqpApJgOQMqLnOWycmQ=;
 b=oqgFphGnvlJP5S0Q32vlRHz3j2SeIKc6ko3gTULIiYsQ7DnY/sKgNxAugGp/uPmtpl
 H54miRZWqzpxXM/Laac33h1nHEamjT25Gq6jWeUQNSo/H5Tpd+DP9AwVuqLA4osWS2Rg
 EApO50S7PHzbAceulnOwG1lsUBMZ7PP82wouSYHb4McIIyt9DJHKRTIzv6bolbuPsj7o
 KJtRXA4Nl5MEnCa6Hb1/4qPjj4184E+5W/rE6FzTmdG/j9gOyxhyAgajHhvWQR5d94ph
 h6FTZGni8NxzFExgTUiffAGX/iWCmRorUeNH1GJesD4MQR51smfBkb1jsv+Kbh/OIFEm
 dDTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+kZKEY6pcCHWNMUQqQCMhyiR2ma+A9z7GGeOu5L67CD+7j5rJpGvN+NcNnIIjYrd16TVnsRo5IL4UPDeUdr4XUqozE6QJEhvDHOOcR3+GViZrH9L/p0+ByrrlOw==
X-Gm-Message-State: AOJu0YxWUNmF5q8WzUZqn4tftlnelXB9Eupd35eQfsi9anicOUsGSe7H
 LMgEvX5OBLXnuDwdOOsVkqZ0sSSN0j6kHr5WaulbM7G5gT0yoOnL
X-Google-Smtp-Source: AGHT+IEwEEkmb/u6WrwlqmiF5BFkJrHqUnqkLEkNzRT95owR3s/Bihidr678i3C2ACuMXdJl/ycWfg==
X-Received: by 2002:a17:906:3085:b0:a58:bd1b:a05f with SMTP id
 a640c23a62f3a-a5a2d67f8b5mr328258266b.68.1715422262994; 
 Sat, 11 May 2024 03:11:02 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:02 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
Date: Sat, 11 May 2024 13:10:47 +0300
Message-Id: <20240511101053.1875596-1-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Hi,

It looks like Pointer Masking spec has reached v1.0 and been frozen,
rebasing on riscv-to-apply.next branch and resubmitting patches. 

Thanks.

[v8]:
Rebasing patches on current qemu branch and resubmitting them.


[v7]:
I'm terribly sorry, but previous rebase went wrong and somehow I missed it.
This time I double-checked rebased version.
This patch series is properly rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

[v6]:
This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

[v5]:
This patch series targets Zjpm v0.8 extension.
The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
This patch series is updated after the suggested comments:
- add "x-" to the extension names to indicate experimental

[v4]:
Patch series updated after the suggested comments:
- removed J-letter extension as it's unused
- renamed and fixed function to detect if address should be sign-extended
- zeroed unused context variables and moved computation logic to another patch
- bumped pointer masking version_id and minimum_version_id by 1

[v3]:
There patches are updated after Richard's comments:
- moved new tb flags to the end
- used tcg_gen_(s)extract to get the final address
- properly handle CONFIG_USER_ONLY

[v2]:
As per Richard's suggestion I made pmm field part of tb_flags.
It allowed to get rid of global variable to store pmlen.
Also it allowed to simplify all the machinery around it.

[v1]:
It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
Compared to the original implementation with explicit base and mask CSRs, we now only have
several fixed options for number of masked bits which are set using existing CSRs.
The changes have been tested with handwritten assembly tests and LLVM HWASAN
test suite.

Alexey Baturo (6):
  target/riscv: Remove obsolete pointer masking  extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v0.8
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c           |  21 +--
 target/riscv/cpu.h           |  46 +++--
 target/riscv/cpu_bits.h      |  90 +---------
 target/riscv/cpu_cfg.h       |   3 +
 target/riscv/cpu_helper.c    |  97 +++++-----
 target/riscv/csr.c           | 337 ++---------------------------------
 target/riscv/machine.c       |  20 +--
 target/riscv/pmp.c           |  13 +-
 target/riscv/pmp.h           |  11 +-
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  46 ++---
 target/riscv/vector_helper.c |  15 +-
 12 files changed, 158 insertions(+), 546 deletions(-)

-- 
2.34.1


