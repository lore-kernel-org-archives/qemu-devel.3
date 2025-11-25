Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013E1D0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqh4-0003Ye-0H; Tue, 25 Nov 2025 05:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqh0-0003SH-FS
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:54:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqgy-0001Oc-28
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:54:42 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so3528290f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068076; x=1764672876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jfyijvl1JFPahxbivQxrrAGa5h/+4fXCl7qTUyuB64s=;
 b=Z2ytID3XEq5wrX9W0qoX5GTwR2C6BSaLNfgqhgGdUpVH3vOnSlVUYQcGMQKjVvgzPn
 ntvCYByGSyZYHyYZXm3SMbrGtXzfn7RIDFUHW4m+6GL6HXKExthNv8cMeQO6aC2EpVxR
 8nWWIQ1627aEQJVc6d2migzMwN5a+Uh9vCEZllCm+pCqXYFjEKZrU2esVDs49rVWlN+l
 FcMJrZOlANNZfnIWyLyr98r1SamYM2dYMi0QI/7BChOTdVM8vjhXnL2ukDY7tUTbUyrj
 WQRVnqXSP6rXHPy5NLJcsBhysJLfi0zMzEF8KZrGBR62JTnGXNcRJ1CS4PYBWjfHRPc/
 TKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068076; x=1764672876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfyijvl1JFPahxbivQxrrAGa5h/+4fXCl7qTUyuB64s=;
 b=JnSFuKFC29J+lXHdlJIgW2R7yV18pHqRw/RDDlx2ZQ3vAJ3wm/PE2bwu/803S6T4Ru
 b3uAO8rxwVdB4vuc/08bvG74j7JKGcn5GM2xQjJg2+2aLXNY4WvTH9weRsi4S2KawS22
 BtTYZw7CRUvpaohNj8ADznwf39nfOrec45HdCvikDaSQsb7ZWy2SztGh7HAHcSgc7t5e
 /MQzAB8io8ivPixqH6jd8o3dxHmmEiMXIPNKrGAYykBbkBLup1wd7AbZbjvbf9kf82PQ
 ATvKKUkESFuPFJWio4AOADMDfojZxkArJgqSxkwKzGj6HQ7f4N3gbZEFDmTKuJcP67VU
 y13Q==
X-Gm-Message-State: AOJu0YxWlLDS9CwmcpUBFDFndqDlYJBoTmlNqfmc4862zPNcVxzT4cFu
 AzkqFbQSTrzrnJ6tY9C5rEsuGMMXSbXbZIby3arKkuuXnRCQPmLj/TYJUGfEeRHb34c5FjWy4Ew
 P3qLawafiBPP4
X-Gm-Gg: ASbGncv4E9jVlrZQYODspw3YrgyY5uIHGtAc/nOtfVwVwKwMG4jBbDAkdGBp2gzQ/wZ
 k52f0t4y11bRIeDKkQVFN+YmlyBrP5qB+OFwD2OIFwFKwqIgacHUcBKPLRFbOxVx99klfO5E1/M
 qvVO6YuDkxFCw4bM5Odkb8q+3vSwUKq+IeOFyt+PyhJj2qjbD0dcOGFcBGasbU0h79FyPSY46MP
 tnlgg7d9a2FsJDiof7Eua8/2B96k5bP3nb28DElA73waJlQDNOMqVIM1gFmMJl/N3ntJbZhDh1Q
 p960xWXmbLiwZy+mxSVfl5izspT1sqXr2q9ljXOcFmWJ3tNEMEQNoLhvS6gGjVzMOuBCyenUuDi
 HrKz04Gz5XOSAb2C2mVk5CaxtOyye53LEHiQl+/bOdfu6MYMeJI+xzUFsSGw0XlBYZJfFFQCEvF
 juQgMmbuzFwLTHIq+SQ96V9+FhdpgMJgZi5hB8P9+kvvc6I9cDcUwA2f2Lh7IP
X-Google-Smtp-Source: AGHT+IERb9JX2msGUhosBK7KYnxgaVzJeCNqY8/qwfS0VTZe5M/yJxvfuGH+GR0rR4EcCKGJXvCyMA==
X-Received: by 2002:a05:6000:22ca:b0:42b:30a6:9c10 with SMTP id
 ffacd0b85a97d-42cc1d22e12mr16261013f8f.56.1764068076531; 
 Tue, 25 Nov 2025 02:54:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8a29sm34188178f8f.30.2025.11.25.02.54.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 02:54:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 00/12] accel/tcg: Remove most MO_TE uses in
 cpu_ld/st_data()
Date: Tue, 25 Nov 2025 11:54:21 +0100
Message-ID: <20251125105434.92355-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Still trying to remove MO_TE uses, here looking at cpu_ld/st_data()
in fixed-endianness targets.

Series split of bigger one [*] where Richard made a comment on
*_code() patches. Since not related to *_data() uses, post separetely
since almost ready (still few PPC/MIPS paths to update, but I'd rather
check if this is heading in the correct direction before looking at
them).

[*] https://lore.kernel.org/qemu-devel/20251121134503.30914-1-philmd@linaro.org/

Philippe Mathieu-Daudé (12):
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/rx: Use little-endian variant of cpu_ld/st_data*()
  target/m68k: Use little-endian variant of cpu_ld/st_data*()
  target/s390x: Use little-endian variant of cpu_ld/st_data*()
  target/sparc: Use little-endian variant of cpu_ld/st_data*()
  target/i386: Use little-endian variant of cpu_ld/st_data*()
  target/hppa: Use little-endian variant of cpu_ld/st_data*()
  target/riscv: Use little-endian variant of cpu_ld/st_data*() for
    vector
  target/sh4: Replace cpu_stl_data() by explicit endianness variants
  target/mips: Use big-endian variant of cpu_ld/st_data*() for MSA
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
 target/i386/tcg/system/svm_helper.c  |  48 ++++-----
 target/m68k/fpu_helper.c             |  12 +--
 target/m68k/op_helper.c              |  88 ++++++++--------
 target/mips/tcg/msa_helper.c         |  51 +++++----
 target/riscv/vector_helper.c         |  12 +--
 target/rx/helper.c                   |  14 +--
 target/rx/op_helper.c                |   6 +-
 target/s390x/tcg/mem_helper.c        |  48 ++++-----
 target/s390x/tcg/vec_helper.c        |   8 +-
 target/sh4/op_helper.c               |   6 +-
 target/sparc/ldst_helper.c           |   6 +-
 target/tricore/op_helper.c           | 152 +++++++++++++--------------
 23 files changed, 305 insertions(+), 336 deletions(-)

-- 
2.51.0


