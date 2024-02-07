Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE62C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXgxH-0006uC-8y; Wed, 07 Feb 2024 07:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgxD-0006sm-JZ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 07:23:03 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgxB-0007CF-RF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 07:23:03 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3810e975aaso73354966b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707308579; x=1707913379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6c0+jAJcIvM2Q/kEsWP4N3nMwV9L3z0k0TxQk9Bd3gU=;
 b=eatoIPr1Y5b5ASKVDFdqvDf9VNU3mXY3qUENJ3UZLq/GGcnYmIcBFhqpnkabpEgZoM
 GQeLSlgnCBv7g1ezvkXvlQNnhC4KIEAA6ufEbeeI0KyCCnQ0ztZ7MtLDshlAi3ws7QG7
 Dgw/xZC2JLNuh9bGZY4bqMD2KbI4/FAYy6maLzwjHauIvJCmQDrhSGLWqGv4LlhEOjw9
 dHrRCPPlTm4jFv1tKyWDVD5+n+MjdtlF0qRtUUHLiNl1LjjfKptG4ggAzSm4zy9XqWav
 iSD0/svWZbAe8nzeaSKIVtMofLyV85GmlK/tcywXC6TaEr26cjgjmwU+Ks/vi2AbFxrm
 dHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707308579; x=1707913379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6c0+jAJcIvM2Q/kEsWP4N3nMwV9L3z0k0TxQk9Bd3gU=;
 b=A3yrLxLua8vUNMivRaLcVP7K8Jnkm3r7Fdo0P0rpFi/sKzNuB4jDORkBCQ8xl8p9HR
 73sv5ATnq+2+FmUq+nAUORmiqMAc4wE6EeDUGLWv+K203oobjbfs5NxlvP8w3B9Vixqc
 53eoawed6AhcMhMCruI+9WmzamXnWJwp+xCS/HmGVS/s8kgnJU3aEh7Chf4Vvh9lArrj
 u5Ee1vD0b9fCxI22Vo3JlKwmoQO8jKsaX2BHE9ZUZA5aTcxfgoGuVcTaPyh19w4fQ+/d
 NgnDKV3+n0Vvu9hWmjKhctxwLaHVYdmeVDEydthQuHw9UZn0jbL4/uEY8wcTXTE3Hu5o
 0VDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGIijic5A5yc84rP1GL4AZrPppGDjNmybFc9aK1fS7eIe+dnSoNHrfQUtXUmP+VHbkSZMj6Pcp4Ri9z79IqgCjWwbzHn4=
X-Gm-Message-State: AOJu0Yx/XQTsNL5i9YBYmnk4GHORGbS8S1b2UU4PrtWvyxhUoAEaZItA
 hH851PQz8LW3fJs0MUJnayh5efGNhT3rS/k9iwTd0LOZyEXvclEBj49xio+2Ehs=
X-Google-Smtp-Source: AGHT+IHjL/nZxzrrz73nZKGbIRnfc947P9WwJStfPY+2FPxAsPtwl4rgQqoB9AA3pgzg3ZbXPyA5UQ==
X-Received: by 2002:a17:906:4908:b0:a35:b808:8f1d with SMTP id
 b8-20020a170906490800b00a35b8088f1dmr4667243ejq.67.1707308579523; 
 Wed, 07 Feb 2024 04:22:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3CAXFO/olopSw+0AmoMdfCAmlRbTaZQJvkYJPKvajZNTgSqWG90aNCtNmpsgfU50l9uId/nT3uaRZ3l3jlr0Iy00ooZUtJWZALwlwMkC13OeQC35r6pAE03Oc4T+ZKYnB3cspbUGYpSnpokmxcwhHpaPX5EBAicgVCz6sOrWPtX5ezSYF1M7MKlPwG1qJnX9If7fQQuHv66Za7VQ2hlCfoCdG2aXMoFHErDBouMjYbNdWNlB2XEcBRARL4DNa+4s2eQHpba6Vhjn1muwZjlNvEtG8Lgcd128K70wM+g4YbtLZxbjTyBzDMlqWXXxKvRxgt7DkbGq2
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 v8-20020a1709063bc800b00a3515b35be4sm702284ejf.104.2024.02.07.04.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 04:22:58 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 0/2] RISC-V: Add Ztso extension
Date: Wed,  7 Feb 2024 13:22:53 +0100
Message-ID: <20240207122256.902627-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The first patch of this series picks up an earlier v2 Ztso patch from Palmer,
which can be found here:
  https://patchwork.kernel.org/project/qemu-devel/patch/20220917072635.11616-1-palmer@rivosinc.com/
This patch did not apply cleanly but the necessary changes were trivial.
There was a request to extend the commit message, which is part of the
posted patch of this series.  As this patch was reviewed a year ago,
I believe it could be merged.

The second patch simply exposes Ztso via hwprobe.

Relevant in this context might be also, that Richard's patch to improve
TCG's memory barrier selection depending on host and guest memory ordering
landed in June 2023:
  https://lore.kernel.org/all/a313b36b-dcc1-f812-ccbd-afed1cbd523b@linaro.org/T/

The first patch was already sent as part of an RFC series for Ssdtso:
  https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02962.html
Since I don't want to keep this patch until the ratification of Ssdtso,
I would like to get this merged independent of Ssdtso.

This series is based on today's riscv-to-apply.next with my other series
that adds the new hwprobe keys
(https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01293.html).

This series can also be found here:
  https://github.com/cmuellner/qemu/tree/ztso

Christoph Müllner (1):
  linux-user/riscv: Add Ztso extension to hwprobe

Palmer Dabbelt (1):
  RISC-V: Add support for Ztso

 linux-user/syscall.c                    |  3 +++
 target/riscv/cpu.c                      |  2 ++
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
 target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
 target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
 target/riscv/translate.c                |  3 +++
 7 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.43.0


