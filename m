Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E90CC531DE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 01:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sePh7-0005Hn-LT; Wed, 14 Aug 2024 21:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sePh5-0005Gf-Ta; Wed, 14 Aug 2024 21:54:27 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sePh2-0003l8-7y; Wed, 14 Aug 2024 21:54:27 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so309496a91.2; 
 Wed, 14 Aug 2024 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723686860; x=1724291660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0cTAz6zG8aiJUJw+hV4b2Q9u2/AmVS0l283humavc2Y=;
 b=eefvHCc00gBIiWr4AL9lElzwT0rRd6yJbU5laDECd7CqiUeTqpTFrj/6z2aU66TmVG
 Sn7ZASPY2pdC9NUL/0kJrHaqJXg48WojxI+1v1/Lw0lmEm5Y3Cls2ggKKUxtVIkLxiQK
 4R6Df4RL0GkFS3/b+Ngeyjv2C24lOgRMJK0aRvYEDsaYyVcx0F63qk0LWTR+PfVnnVHn
 K3yRrtZ3Hnfu2urQ+QTSDYbWH2OeowQJQNpO0OIMr63llh9bu5mzeTomzWf80XzdnX2x
 YLdpZEa2Q0a40IwztzFThH+ZWs84KpbL4YCUTdZ1kFUZRM/LmQf3rstjv9YwQY4ISzoE
 C4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723686860; x=1724291660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cTAz6zG8aiJUJw+hV4b2Q9u2/AmVS0l283humavc2Y=;
 b=g5mXw5uvc8On5zI4gIrw1X+oGNhS0pL8tQa73rH6fzBGvrGscChMmcatHqs0jrwaGJ
 0bCFWjLIJOjJFcb1I8lB/DCDiWNrBfiqmjpals9AEfZj96mha1DBwG+4pGlaPG1G5tNA
 8CyRyXYbsn//nQTTAkXuuEIB5YrIu4nQ0mVzczQrdorL0uoATaAH5zU80xGegXFni22C
 7oDLIHrD6ZPEcBYx80ngKkutr1T4be22qk2ZlJvS5sWDwPnDzTDprBGzYbTaYnJFrfQt
 UvB7pbOc7KG1U1XYYrOcfj+gHcMoIOu4HzKsZX/UlGMm8X+aYdfaiElQCjgwhuq7LQeU
 k5Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsEI//KNtu8F8bkIQbG8xr1DIx42mz/KSzrEAnSvLtHRJVjkLvfB3c++w3o4aKQVzWSTyPynpTaixdygjLu7yIwzxCUW9GjJwN5YuqO8lm9URwf2O+Da7sal6Aaw==
X-Gm-Message-State: AOJu0YzZnH0BXuEtOoWqr5rSFCs2txhF5EeENZTrtfKN2RsF4LZUOQAo
 JlN2EVNUICUExJKQiZtpjTUzMYr4qxuY/SjKNeDaj2ndR7/VCfu9Tu1CLQ==
X-Google-Smtp-Source: AGHT+IHh9EVnnhVOzIn0n106LHYEQdy8ee1dYIDrZSvDKptP+XPUIbk74OJWP1aTTgY+U+FnubTm5g==
X-Received: by 2002:a17:90b:2641:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2d3aaa88498mr5672522a91.10.1723686860197; 
 Wed, 14 Aug 2024 18:54:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d396a59287sm2477688a91.0.2024.08.14.18.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 18:54:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: alistair23@gmail.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/2] riscv: char: Avoid dropped charecters
Date: Thu, 15 Aug 2024 11:54:08 +1000
Message-ID: <20240815015410.369925-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series fixes: https://gitlab.com/qemu-project/qemu/-/issues/2114

This converts the RISC-C charecter device callers of qemu_chr_fe_write()
to either use qemu_chr_fe_write_all() or to call qemu_chr_fe_write() async
and act on the return value.

Alistair Francis (2):
  hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
  hw/char: sifive_uart: Print uart charecters async

 include/hw/char/sifive_uart.h | 17 +++++++-
 hw/char/riscv_htif.c          | 12 +++++-
 hw/char/sifive_uart.c         | 81 +++++++++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 8 deletions(-)

-- 
2.46.0


