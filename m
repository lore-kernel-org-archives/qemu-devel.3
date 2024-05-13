Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971ABC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6U8a-00020x-Uy; Mon, 13 May 2024 07:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1s6U8Q-0001yO-Rv
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:46:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1s6U8M-0003sX-3r
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:46:25 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so2348021f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715600780; x=1716205580;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=amBqxkPPFqRY9jRiXGlmTGX1uICfdcFTqDqTkXr7Swc=;
 b=UrhgW6oakUCd//dd+Jg4LGfxKCytylBCEm/kau3cq/J5QFPTLarxdEqctvkyqxQ2IV
 h2pyQglSEVbyvgJsEOtH1f8ElkHYoTtRNAwVczCsqKtgqdUJ4AgqxOjLxztfAS2+s3x5
 bMoMvL6yaSX+vM5hgqiq00v4R3m0+naQBR0jIYnJSbab1TREEWIlebeDdxf/Zt8fQp3s
 YuD4Ou6h7Tg/bNTRVdDEEQ0aOOWmRI8u+0VXoMUnTCYXH9RErFHC9B/MMTww2uQsQCRB
 Cx0B90QAUB4SYdq4SXM45oOOW83Taw/Sub0OGMvPvCIyDtFQZftWiY1CGBH5Z5HhjnJ7
 SFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600780; x=1716205580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=amBqxkPPFqRY9jRiXGlmTGX1uICfdcFTqDqTkXr7Swc=;
 b=ku4o3jBw4Izy+c2xSPqo3KuD85pkyRpKoGfPhPvUy00fp1ZdnENVR/5msp9Aa3l/JY
 SHZteyUbrj+m3CeHD1K1gl5lvJIJ5IeDJNBK3kJZZkCLLW1+VLkcxrQflQSgw7FdOVB2
 hWlFUQ5xMvVK7QZNu8GBkJ74WVXaBkdXwsJYlR11eJYY0yu2VOuYKKIfR/D/guHMxPYg
 bYsntslC3dk2j71tOFL0Dfd2TJwRqlHdWXXNtP2mcYwyBMyQWnEVGymaQbhHKlT1AEv9
 zuN15YN2eHzPQYDVLM6Ws8+Q6ySg9FZm9yNGdF1Xb0s4IB06oAqj4m0USakQF8VTTF5z
 gjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtKmOSo1YM9A/4Z2rU71o9c+ATUiJlAKlqP0R3cOcBWRtrQSSv0j1J/2+8SCs5NwKM2CRNbuQHXYmgsPvzJ41vgXDKzdk=
X-Gm-Message-State: AOJu0YxJ7FbNiIG1YtBYCUmqO4xDIHvaQI7oILTjYnis4Axp0S58cTSl
 Y40KQI7fGC3dFzjDb5hwi5nayxlp/NjvjLhEevuEOYHX/H46Ykq6oJtdDuEpp70=
X-Google-Smtp-Source: AGHT+IGx8cgmZKwD3vwNweKzY+bza2zH71MGWSGYKFcTLEVK2sqtWKgsJ3JqnY1NgOyE7O+SnjCqbA==
X-Received: by 2002:a5d:4892:0:b0:34d:af19:2373 with SMTP id
 ffacd0b85a97d-350498a4c57mr7968620f8f.16.1715600779936; 
 Mon, 13 May 2024 04:46:19 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:45f9:e636:91a8:bb8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf47sm10907636f8f.78.2024.05.13.04.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 04:46:19 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com
Subject: [PATCH 0/2] Minor fixes and improvements for Virtual IRQs
Date: Mon, 13 May 2024 12:46:00 +0100
Message-Id: <20240513114602.72098-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series contains few miscellaneous fixes related to Virtual IRQs
and related code. The first patch changes CSR mask widths to 64bit
as AIA introduces half CSRs in case of 32bit systems.

Second patch fixes guest and core local IRQ overlap. Qemu creates
a single IRQ range which is shared between core local interrupts
and guests in riscv_cpu_init(). Even though, in the current state
there is no device generating interrupts in the 13:63 range, and
virtual IRQ logic in Qemu also doesn't go through riscv_cpu_set_irq()
path, it's better to keep local and guest range separate to avoid
confusion and any future issues.

Patches can be found here on github:
https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/irq_fixes

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
Rajnesh Kanwal (2):
  target/riscv: Extend virtual irq csrs masks to be 64 bit wide.
  target/riscv: Move Guest irqs out of the core local irqs range.

 target/riscv/cpu_bits.h |  3 ++-
 target/riscv/csr.c      | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)
---
base-commit: 09d8c49f23e9a130593984d5c8cf048bdd76f73e
-- 
Regards,
Rajnesh Kanwal

