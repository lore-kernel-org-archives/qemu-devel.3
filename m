Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35126C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgV2-0005wR-5f; Wed, 24 Apr 2024 13:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgV1-0005wH-Fv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgUz-0002zE-NR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3499f1bed15so746744f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980015; x=1714584815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HM1N0hhTRGbhzqQAYFmVH+2l++gLcjeTSRnq3kiiav4=;
 b=Pm/x2a1JAX5TyhzTzPHLUvkAH75bARKpyBXQIZyMliwP5/i4mm4Uk8K2NJVK21u3+O
 Y+1wyZVCDJ/yPcBLP8dow9O+7NECSO48KzziOZbLjUfNG1L1dlszkgG8KL4+sZcXssCl
 JAaeDaLpbFMMlnEYgEOfHd3cQrMzsfBscE00crWTjRTC2oN3OsiLlKNAni4kZ9VRFtaL
 oJKdcoDNeTxZjl+8WnLNyuVLMQ9Y4qrgcqjpzpcy9ilwOXxOcGMde9BZJSUEKCu/pkn7
 mGlVLKVaz4nWY8h2EgsziOX+HHFaMqRtZycQHf29R7B5TkmCnYyEjIylARaekrWlNmAL
 TaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980015; x=1714584815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HM1N0hhTRGbhzqQAYFmVH+2l++gLcjeTSRnq3kiiav4=;
 b=JU5Sq9EatTuj+RQKfd5cc8ztGaAwgKINIqIsTbF2yDnZTdCV/xWnWvylQAJCdkmelM
 uy9nyx78PXnayIVUHSXGFaJKkOcvuFiAm56yDwgOQWTGOXZWyET/Ps/nPLyvRqIxCGZE
 SIChqDevQAKa38CbOdpY0qMJg9OEKvcxA9IJIY4Hd8qnSugNjz9WRD94hZUP9Ukv8Saj
 3jIJme6RgBkaGkl1pty6v47DAl2BDnwfmqsV9zty1sndWs3RuG8GH9+JUZYi/Go/9pQQ
 sCtudTbKgKGmP781PAe3/Z8hR49324XgkHmwVzOzqACYmxRF+zYX6Jp2C7CG3751PLpx
 gaGg==
X-Gm-Message-State: AOJu0YxcZen1hTYxY2erts/Y+JMNXV3N/JyXUDBrs/Ca7Eb1nCn3gp2D
 Eq0ipD5KrB2nJM1JF/1lasZhKN01+TbJjnNkrg/ZS7VGL/RJD/XLV3n9Wz8q75we0TiD300In8u
 0
X-Google-Smtp-Source: AGHT+IHWFi1WedXWQNnHrGXw4LDdejkmo894UfD6K8NHtZn3+n1pRNmfp/StfqH+2o/roduUfLiFOw==
X-Received: by 2002:a5d:52c8:0:b0:346:a39f:6b69 with SMTP id
 r8-20020a5d52c8000000b00346a39f6b69mr217613wrv.24.1713980015508; 
 Wed, 24 Apr 2024 10:33:35 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 g30-20020adfa49e000000b00343f662327bsm17928944wrb.77.2024.04.24.10.33.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:33:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] include: Rename some expanded headers using '.h.inc'
 suffix
Date: Wed, 24 Apr 2024 19:33:29 +0200
Message-ID: <20240424173333.96148-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

v2: one more

Per our Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Rename elf_ops.h, helper-head.h and host/load-extract/store-insert
headers.

Philippe Mathieu-Daudé (3):
  hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
  accel/tcg: Rename load-extract/store-insert headers using .h.inc
    suffix
  accel/tcg: Rename helper-head.h -> helper-head.h.inc

 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 include/exec/helper-gen.h.inc                                 | 2 +-
 include/exec/{helper-head.h => helper-head.h.inc}             | 0
 include/exec/helper-proto.h.inc                               | 2 +-
 include/hw/{elf_ops.h => elf_ops.h.inc}                       | 0
 bsd-user/elfload.c                                            | 2 +-
 hw/core/loader.c                                              | 4 ++--
 linux-user/elfload.c                                          | 2 +-
 accel/tcg/ldst_atomicity.c.inc                                | 4 ++--
 include/exec/helper-info.c.inc                                | 2 +-
 16 files changed, 9 insertions(+), 9 deletions(-)
 rename host/include/aarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/aarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/generic/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/generic/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/loongarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/loongarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/x86_64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename include/exec/{helper-head.h => helper-head.h.inc} (100%)
 rename include/hw/{elf_ops.h => elf_ops.h.inc} (100%)

-- 
2.41.0


