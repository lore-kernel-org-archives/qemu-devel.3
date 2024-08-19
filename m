Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8833AC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0cF-0004Xd-Kb; Mon, 19 Aug 2024 07:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sg0cD-0004Vr-Lp; Mon, 19 Aug 2024 07:32:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sg0cB-0007so-RY; Mon, 19 Aug 2024 07:32:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-202376301e6so5809865ad.0; 
 Mon, 19 Aug 2024 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724067118; x=1724671918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q0WRL3MjlfD2sGyNmGan0k6158IInmLjELt4dS2Xec=;
 b=M1swBtJXZLHReNFMPBcYXtTv7bw3JlVuIfDNW4bGiHGsRNn53V58XCyDrmXVqY9ubR
 ejWCvpCjXPEbeemXA0TfWkaNaZmn1QJs36tzvUJYzPLY4LzwkUtwveZQ/9DzpwfN/OQ6
 +7jSSZWVLgbby/bc5C52zFt9eRFwHIBYyRzvyhRrp559tMJlQ4QNjQMcaHBbx9oLsZX4
 2Cir7jJnx6azQEk1eE7IYQpjZP5ox8agy71WCMLuU9S/Z7lIu3yWC5XTYR5rgVqup+Zg
 Kh/5da/0SKGcQq2r390dv0Q46Pw/W86vO6fqT0q/oBkfWjnPs8VJ6KDLmdExIT0yGK9D
 2jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724067118; x=1724671918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Q0WRL3MjlfD2sGyNmGan0k6158IInmLjELt4dS2Xec=;
 b=hxFcgW63Jz/m+Uounl21e3nQG1f22/wknH9HbfUQZiqVx5j3n5JAJeqN8AKw45MJq1
 ENhvUkZKNyXrjdO6/l1z/h1xbD+SZOR+bkIdonKbBe3U1VW0OwA0sg+lbfi7hT+akeqK
 1M4wRAkU6ivkjqq3AVam7QMUN2mOOa0kAXKRtbdG9KKqnbTZ9UAaL/YZfNL5+h+i2LEk
 Qav9J31QD0dkrNPbBkj7BnK9H9VmxbtpIpB/SsPcAiQmgepvmwEX7pzWOSdiLA6uzg7P
 zhCuvLU5MJDdSTIKbRtS4Xuvwu+ehfUZOZxYHzaDmBRmvhhNCi7EXdloUx8r7rn7nuqy
 QLlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9YiyVC3G+Cib+3Snz7261Jc4+rGzCYk9xXigyhjpcycG5yr2l/rfUeJVXrZQA4LTQzfzy9eJiy6Fq7PcXGlw2L7b3lCo1gdr3aeIvyXZkUagoDXVstx/iFeQXMg==
X-Gm-Message-State: AOJu0Ywf1slOwgVEU74cvVs4PSaNAd37bwQ2ijph5TLRmXeK04WxZMBp
 1vMDKoxyuiiuj72UaqZgrJftGzyAHQ7biEJsvUAKuJpN1UX/5VyZ
X-Google-Smtp-Source: AGHT+IHudqouSK8axqyXAbWo9yJcVOZfykgiJLAK21/SamjcKI7/IIWUgk1Slnm3ekvUu6Peme09Vw==
X-Received: by 2002:a17:902:e847:b0:202:435b:2112 with SMTP id
 d9443c01a7336-202435b22d3mr30189895ad.34.1724067117753; 
 Mon, 19 Aug 2024 04:31:57 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a84esm61263445ad.189.2024.08.19.04.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 04:31:57 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Cc: liwei1518@gmail.com, atishp@rivosinc.com, palmer@dabbelt.com,
 Bin Meng <bmeng.cn@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Paolo Bonzini <pbonzini@redhat.com>, dbarboza@ventanamicro.com,
 alistair23@gmail.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 0/2] riscv: char: Avoid dropped charecters
Date: Mon, 19 Aug 2024 21:31:46 +1000
Message-ID: <20240819113148.3007047-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

This converts the RISC-V charecter device callers of qemu_chr_fe_write()
to either use qemu_chr_fe_write_all() or to call qemu_chr_fe_write() async
and act on the return value.

v2:
 - Use Fifo8 for the Sifive UART instead of a custom FIFO

Alistair Francis (2):
  hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
  hw/char: sifive_uart: Print uart charecters async

 include/hw/char/sifive_uart.h | 17 ++++++-
 hw/char/riscv_htif.c          | 12 ++++-
 hw/char/sifive_uart.c         | 88 +++++++++++++++++++++++++++++++++--
 3 files changed, 109 insertions(+), 8 deletions(-)

-- 
2.46.0


