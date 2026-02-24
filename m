Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE9DF4BB7A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy82-0001zN-Tg; Tue, 24 Feb 2026 14:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7C-0001ow-BJ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:30:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy76-0000n3-Qh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:30:35 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso50272595e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961430; x=1772566230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJvVqQyy5oZSysZTNN5WiY/fDfYfGZ0/GLOLav4S0p0=;
 b=dMLueoFUkyd5sXhbZWxq2u0onNkQG/x8pVVlB146Kjw+fjTOLJGacrH6e4GM5L21Yp
 Afpa/6CGnM91j4GWdgSVkXj4IvCGzGNnJ4CoK583KLP7aq2B3P/ckauZiIkxb7kZKBU5
 IWRsgxkyrzDQW51AWmb+mTxhTGoO7c4/LRMeSeApN4VBy2nicz7PhrX1aLElW3xxEmVZ
 B9asdROL0GpKbf5jIBAs/B/Wek/x5CaJifeBxx//EhCeK787ADiUkJm5jjOQma5zNIMy
 ORYQBsY5qnd+qVKEAmqP/NNH91Kkz8nv0yHhAUcc/HuzF9KQY6FSouBK2MxGRKtpN/u8
 K/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961430; x=1772566230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJvVqQyy5oZSysZTNN5WiY/fDfYfGZ0/GLOLav4S0p0=;
 b=DjJwV0ivk0suXiafMDsPzyv4oqXlx/C0JnPb4J3XpNEpG1qc3qNz/rmUTkzXgooldP
 SuG9Y9VQawb9U+weY12qiClwYn5MjCdJua5e/ehjYSgyXFQhhQrSlLGqwdfhQw9Zr9Kf
 HLsd3ZVN5/KWSH03ECN3zOvcsSilssbQ8aVUHyXXFNpnIitMg9HSFozNoeTtGZ0Zhe1u
 6c+jWq6voToOCLPWN6rUW7UOtyNqJdDoYpqnpCJ5PeqG4kbuRyYlgRQX3YUeMxfasIu0
 WoOfZMbd8WJ/lgGpHa7RqIeoMEJBMD5PwriAM3ILn/G3py9OOzhxwCDs2+cKTRDjXRd/
 HVPQ==
X-Gm-Message-State: AOJu0YwsC7tyvBQZhrFjf75oTFuWND3XxSUiuytpc4uAfmtRaIcp/gM2
 Nb0Lb/aVtScS9i/Wn5ter/aGkBXxVJiRXjDRhF2QW14M/jF8omkAOIcHnXejTToJwV8LtbEt+4P
 f5akqEBU=
X-Gm-Gg: AZuq6aKG6jNJ3JRWtV/+Wk68ItNhCkcxN+JSdWYB9r69SDlXJaIy/+9j9iCvqthKpgM
 WI4YQ7ms/EOs92JnVNYua38jM9K9FCITLVGgT895niQbku/mtHyjjD4DGIfstPjQghF3MzEKo/Y
 tonlfW9S+fGYM9MnCYBQzknck9utcRinBQr1tykc70JSE9XM0Bei/iJqzwoN04beyAxIa7MVRBM
 ZEya1rtgpeEBhjYrkB2UA5r9L7N8S2Sl2qUNlse2TEnxbCJyNSMIz4BADlTupmNZRqHcVvw7p2S
 e6BTVlqiH5oYOmoh9KN0UZX3I2oZdexs6B0dbgaE80u3/RlndtW5iAAuS3ydZ8AxYO5CW0COisk
 jg5eVYxZxzaE5ywl3z96c92JeY5b2tYj5vcROwl3/ELF1AEyUYKPSq/hndQw9ht7tvbL7wTiX2s
 UGwSc+UbHtWNwLj+P4FRdnDAi0CfrN4p9fAveSxqiNzhgoHROdAIKgyyqhYDQCEcVKfWQriRWG
X-Received: by 2002:a05:600c:c166:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483a960a0e8mr236645985e9.15.1771961430508; 
 Tue, 24 Feb 2026 11:30:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d40004sm28474648f8f.21.2026.02.24.11.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:30:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/5] target/tcg: Rename some helpers common to various
 targets
Date: Tue, 24 Feb 2026 20:30:22 +0100
Message-ID: <20260224193028.2370-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

TCG helpers are declared using the DEF_HELPER*() macros
which imply global symbol scope. Unfortunately when building
a single binary (containing multiple TCG 'target' frontends)
these symbols clash.

This series takes the dumbest approach, renaming the symbols.

There are still around 20 symbol clashes (usually FPU helpers),
but this series is good for my proof-of-concept.

Philippe Mathieu-Daudé (5):
  target/tcg: Rename bitswap() helpers
  target/tcg: Rename crc32*() helpers
  target/tcg: Rename unaligned_access() helpers
  target/tcg: Rename raise_exception() helpers
  target/tcg: Rename set_rounding_mode() helpers

 target/arm/tcg/helper-a64-defs.h                 |  2 +-
 target/arm/tcg/helper-defs.h                     |  4 ++--
 target/hexagon/gen_tcg.h                         |  2 +-
 target/hexagon/helper.h                          |  2 +-
 target/i386/helper.h                             |  2 +-
 target/i386/ops_sse.h                            |  2 +-
 target/loongarch/tcg/helper.h                    |  8 ++++----
 target/m68k/helper.h                             |  2 +-
 target/microblaze/helper.h                       |  4 ++--
 target/mips/helper.h                             |  6 +++---
 target/ppc/helper.h                              |  2 +-
 target/riscv/helper.h                            |  2 +-
 target/sparc/helper.h                            |  2 +-
 target/i386/tcg/ops_sse_header.h.inc             |  2 +-
 target/arm/tcg/arith_helper.c                    |  4 ++--
 target/arm/tcg/helper-a64.c                      |  4 ++--
 target/arm/tcg/translate-a64.c                   |  4 ++--
 target/arm/tcg/translate.c                       |  4 ++--
 target/hexagon/op_helper.c                       |  2 +-
 target/hexagon/translate.c                       |  2 +-
 target/i386/tcg/excp_helper.c                    |  2 +-
 target/i386/tcg/translate.c                      |  2 +-
 target/loongarch/tcg/fpu_helper.c                |  2 +-
 target/loongarch/tcg/op_helper.c                 |  6 +++---
 target/m68k/op_helper.c                          |  2 +-
 target/m68k/translate.c                          |  2 +-
 target/microblaze/helper.c                       |  2 +-
 target/microblaze/op_helper.c                    |  2 +-
 target/microblaze/translate.c                    |  4 ++--
 target/mips/tcg/op_helper.c                      |  6 +++---
 target/mips/tcg/translate.c                      |  6 +++---
 target/ppc/tcg-excp_helper.c                     |  2 +-
 target/ppc/translate.c                           |  6 +++---
 target/riscv/fpu_helper.c                        |  2 +-
 target/riscv/translate.c                         |  2 +-
 target/sparc/helper.c                            |  2 +-
 target/sparc/translate.c                         |  6 +++---
 target/i386/tcg/emit.c.inc                       |  2 +-
 target/loongarch/tcg/insn_trans/trans_bit.c.inc  |  4 ++--
 .../loongarch/tcg/insn_trans/trans_extra.c.inc   | 16 ++++++++--------
 target/loongarch/tcg/insn_trans/trans_fmov.c.inc |  2 +-
 41 files changed, 71 insertions(+), 71 deletions(-)

-- 
2.52.0


