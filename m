Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807C9D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuZ8-0003ES-Ec; Tue, 12 Nov 2024 12:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZ2-0003Cm-UI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZ1-0003gq-7U
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so50739785e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432025; x=1732036825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q/oqUubIYMwA7uPib0CIy9olV9ImiWGi9CG1ukd5VfE=;
 b=rTpAFtnfGezCbVvTUyP2qYOgG/SC6OKUtqeXdwfYeYrWEb8p4RDRAiLuNZdVdBunTB
 oDKaAQ74WgDqGUpJrii5utmjkPS+wA3npfrk2av0QLPfuzBjf+IIkIIPW1DNa+LYqOOl
 Fy/maGG9F2ZL8jWDpx9HfcAf93VcItkZWOj83AX6B/SI9R4FfHu/IshzPkXZWtPz2rTv
 0vIa+/0KLMjdjFvd6H5n/XdlolS8RpJZErDdWax8D6sVx+aceeGmjRabHSVw63ykctYS
 QieaFLRg6gKSnNSBx/bqvdg2BUiXPLFhUCAu+23Te7QRO4EK4Z7BpUQdXU4MsN0BN49H
 YMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432025; x=1732036825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/oqUubIYMwA7uPib0CIy9olV9ImiWGi9CG1ukd5VfE=;
 b=NRpjBBs5KSh5g/Uy6PxrHBNTjM04QhmE5okRhSTom6g7CyaeR7zSu/h2Oyc9HpDUGe
 GUsAwy2C543wYfHC1fXlzzEEezvca6Vz9TIa1jM31u69ub9ZYOCufuZ4D5OckrC3q+o9
 DZohJqukVyAEU0jzzwct7dk81I8uyys13T4EHXYKrn+qgKSOf3jz14gdkdBVftr+PS4R
 9h8S2D0O9lScRJSrAnHkJhmwuvVDHO6C8cJfmV5f8Xcah2OkCzdxUcGPw9yiIw91Aj9g
 OaNXJehU3b4aEY62sppja7eI8WFGafgB1s+mINpOts92tevxSXmfag8v2XdrL0egzmK+
 alBg==
X-Gm-Message-State: AOJu0YybJkdgRogkhhphQZmmn7OLLlZRCK5QsPdNNPUY+BJb/KobQBQ2
 SfIaJCeY16VSwogXdxFxJethG46bgGk+QEyGy/M2FahiZsUQOXhA9BJ4IstLKj3Qko5r37J6fGh
 y
X-Google-Smtp-Source: AGHT+IFFjKmMNwqxRLCnzz5EPS5ozgmm+tF4mT9mHMreyJJJsY7bKcRrcMwnJWWh0ctHTnomxJ0WlA==
X-Received: by 2002:a05:600c:3b05:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-432b7503f43mr153404865e9.9.1731432024966; 
 Tue, 12 Nov 2024 09:20:24 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5f82sm221382445e9.42.2024.11.12.09.20.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 0/6] target/mips: Convert nanoMIPS LSA opcode to decodetree
Date: Tue, 12 Nov 2024 18:20:16 +0100
Message-ID: <20241112172022.88348-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Prepare buildsys to decode micro/nanoMIPS opcodes using
the decodetree script.
Simplify gen_lsa/dsa() and convert micro/nanoMIPS LSA
opcode to decodetree.

Philippe Mathieu-Daudé (6):
  target/mips: Introduce decode tree bindings for microMIPS ISA
  target/mips: Introduce decode tree bindings for nanoMIPS ISA
  target/mips: Have gen_[d]lsa() callers add 1 to shift amount argument
  target/mips: Decode LSA shift amount using decodetree function
  target/mips: Convert microMIPS LSA opcode to decodetree
  target/mips: Convert nanoMIPS LSA opcode to decodetree

 target/mips/tcg/translate.h               |  4 ++++
 target/mips/tcg/micromips16.decode        |  9 +++++++++
 target/mips/tcg/micromips32.decode        | 17 ++++++++++++++++
 target/mips/tcg/msa.decode                |  3 ++-
 target/mips/tcg/nanomips16.decode         |  8 ++++++++
 target/mips/tcg/nanomips32.decode         | 14 +++++++++++++
 target/mips/tcg/rel6.decode               |  4 +++-
 target/mips/tcg/micromips_translate.c     | 24 +++++++++++++++++++++++
 target/mips/tcg/nanomips_translate.c      | 21 ++++++++++++++++++++
 target/mips/tcg/rel6_translate.c          |  5 +++++
 target/mips/tcg/translate_addr_const.c    |  4 ++--
 target/mips/tcg/micromips_translate.c.inc | 11 ++++++-----
 target/mips/tcg/nanomips_translate.c.inc  | 16 +++++++--------
 target/mips/tcg/meson.build               |  6 ++++++
 14 files changed, 128 insertions(+), 18 deletions(-)
 create mode 100644 target/mips/tcg/micromips16.decode
 create mode 100644 target/mips/tcg/micromips32.decode
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/micromips_translate.c
 create mode 100644 target/mips/tcg/nanomips_translate.c

-- 
2.45.2


