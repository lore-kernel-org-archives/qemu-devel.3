Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9374DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTus-0002zQ-5h; Fri, 08 Aug 2025 16:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTum-0002wz-T2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTuk-0003CW-9R
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so2347737b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685727; x=1755290527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7l7y2ZwCGs/WPyV12kMqxn1KFDVvSp9DGB/Xq5Rw2XM=;
 b=FhzBOknn0CuyM/gB27tkKFhk3De6uaqY5uspNStWNoogw+uZhX58adSmLffx0ZZn3G
 EsRXpptYQ3Z+FGEcAUGcrPhxsC5AhCK2lmAPDW6hPGGPGYdVtz3eTV4hFB8yr6iHMFXy
 hpgtpe6UPxDMuH5DSTzY3u8S+UjXWkjEsfOAJcjtPeRU8JtG/i+Mdm3jQlKT/X5xHPnB
 89Hszy/LLbBW8AGTErwDe4tFRey8w6ET+mgr69wPv0ZhBYopuCBRv8NOjYaz53dD/V51
 L+cqaP0+6LgRV0spE88mvQyXbREnl/aJk10o79cQpG5GoyeVXq1T6QbQA/IXHybGMXyK
 3AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685727; x=1755290527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7l7y2ZwCGs/WPyV12kMqxn1KFDVvSp9DGB/Xq5Rw2XM=;
 b=qHS+bJV5S8uQUdTLPFxbygGfyTYOTHNVOWg5C3PtYzAE9LbwS4bKZutHp8B7KDrkDh
 cqTUighV2+6s6U4ctW7BhCErB7/onja1jxLajIyNNIGzj/hl8UMZgTCAFWtGOh9dRyeB
 G/p3jAlUkNVhjmJtfpwJL/bFPiUYYdP1FzNpj1NLnV9ze2EWNhNhD62KIOd7WioZYDmw
 4O7WDaTuCUhBqgCGbuBvh/74X9/SbeGYz480F+arh1UFocKAOcOC5i+W5gMFKe3TrJft
 P0a5uxVQzvqLlB3vio0kZliRzXqZZhC1z/uoO5HuX143kOxFubLVm0pDRJFatxWUa3sJ
 FqwA==
X-Gm-Message-State: AOJu0YzNHj9ZV77o2cUjnfOFPDwDlk+Bwl/T8I7JNKDPzA16W+g7jRK0
 Ouzu+pqYnA2G2k9ypc58OnPnpp6ufaq/O4A87u5nLq3zHkg8z29PrrkWLVwvH75dXT5ufNbV7VC
 ohghKhD043w==
X-Gm-Gg: ASbGncsumPcRo0GqDFarRobAI+xNFOqMTZM9Jc0Cab6Y1Dj30nNMc6u5SVoEDy3FVZ4
 w71yctEOG5ED/Ebfl7bq7JvUo/PqI8lOclMFweq1MnLmL7akUJ/cpF+i5HN5PgNOVVFf9Pq4rTS
 stNBd/gWKHEHBGSQEYSTFIbv9cEte8Fzo04DSyOuiHodPPyXl0Sw7hp0i0uXxyZIrioInhAQBGD
 2Wi1bTrK3inYSN8PF5Z2aMAS15+Mrov7wR5FpjFvqZ/9UMus6s9ps/DgZx5IyFbDV5YQpW06H/F
 4Lcd9Z7mdAbP8tGf498ulaB1mKemFJ3c8XAoeuzekPl/oT1oaPqVfUswUu0am1e3Jl9Jz1gN5mK
 doL6ujNkMMDPnyoBZUZaCwg==
X-Google-Smtp-Source: AGHT+IGSpfIEPzaNH18hQv5G2tij+NmJQIMVcvPYILc49coG7i0pSZVi+pez4kU0DCmDYfmgPHLlOA==
X-Received: by 2002:a17:902:d2d1:b0:23e:3bdf:e3bd with SMTP id
 d9443c01a7336-242c2006fdamr81257335ad.22.1754685726895; 
 Fri, 08 Aug 2025 13:42:06 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org,
	pierrick.bouvier@linaro.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 0/9] contrib/plugins: uftrace
Date: Fri,  8 Aug 2025 13:41:47 -0700
Message-ID: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

This plugin generates a binary trace compatible with the excellent uftrace:
https://github.com/namhyung/uftrace

In short, it tracks all function calls performed during execution, based on
frame pointer analysis. A big advantage over "uftrace record" is that it works
in system mode, allowing to trace a full system execution, which was the
original goal. It works as well in user mode, but uftrace itself already does
this. It's implemented for aarch64 and x86_64.

Let's start with concrete examples of the result.

First, in system mode, booting a stack using TF-A + U-boot + Linux:
- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
- Stat and open syscalls in kernel
https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview

Full trace is available here:
https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
You can download and open it on https://ui.perfetto.dev/ to explore it.

Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
- Loading program and its interpreter
https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
- TB creation
https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview

Full trace is available here:
https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz

If you had curiosity and now you're ready to give some attention, most of the
details you want to read are included in the documentation patch (final one).

Overhead is around x5-x15, and long traces can be directly filtered with uftrace
if needed.

I hope this plugin can help people trying to understand what happens out of the
user space, and get a better grasp of how firmwares, bootloader, and kernel
interact behind the curtain.

v6
--

- fix types and spelling mistakes
- use _MAX for privilege level enums
- uftrace info file: use empty strings
- trace flush: assert we wrote all data
- doc: added style for keyboard keys
- added URL to document uftrace entry format
- updated comment in vcpu_tb_trans to explain why we always instrument the first
  instruction in tb

v5
--

- addressed Alex comments
- split plugin implementation in several commits
- removed instruction based timestamps (only use time based timestamps)
- removed sampling implementation

v4
--

- add support for x64

v3
--

- fix missing include unistd.h (build failed on MacOS only)

v2
--

- trace active stacks on exit
- do not erase map generated in system_emulation
- add documentation to generate restricted visual traces around specific events
  of execution

Pierrick Bouvier (9):
  contrib/plugins/uftrace: skeleton file
  contrib/plugins/uftrace: define cpu operations and implement aarch64
  contrib/plugins/uftrace: track callstack
  contrib/plugins/uftrace: implement tracing
  contrib/plugins/uftrace: implement privilege level tracing
  contrib/plugins/uftrace: generate additional files for uftrace
  contrib/plugins/uftrace: implement x64 support
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst           | 199 +++++++
 contrib/plugins/uftrace.c          | 876 +++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |   3 +-
 contrib/plugins/uftrace_symbols.py | 152 +++++
 4 files changed, 1229 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2


