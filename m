Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36E8CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMo5-0004Wd-1k; Tue, 03 Sep 2024 02:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMo2-0004U9-Bl
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:22 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMo0-0002E2-Ac
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71431524f33so3947832b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725344058; x=1725948858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BsDUiz5IMMsh8VBD+lmtXUJuv3SkFc/yhWliEOAa+Bg=;
 b=Ma7KK4OiwCRuTq+QWqKAMGqkf4c8D0RsmZVqYz6f/yHGbwVaqEEWEpBGrfNtYechdf
 uflKDn+PUr0/hfyIlgWae+xkn1peHKLnUnb/jblHWC9Bw3cyWjOVexMjk5GT3PhyRoNa
 uxRwdsbBSU8UiufaUDOpgiF9aHkP7UgILQE35CmJVLbtyB7czNs0a588bxtdNwWXc7n+
 70mVk/c0WztFosMtGZWahYjM5WfyQfX4nj4t0jsc67Rq7IUQrSGGxiFHTvW7pdcssBIP
 CdYSz69qNxc6xv2hQDV8SYCzRzeBJaeJgM0qYdSKY6M0MLUJSbueOYANhhS8wU+hAtw8
 M/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725344058; x=1725948858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsDUiz5IMMsh8VBD+lmtXUJuv3SkFc/yhWliEOAa+Bg=;
 b=brt4fm44UU0Szzwa7aVyhjz4Pszv8Ogmb8F+L5ElDfVINv7xnvf1gJurx43tDhQmar
 2hx94sHnil6/9vpgVqucIcoCX2jZ9bkhNgXmjm6+OEG9sxkO4FwSQcjUXOvObRTw0m3n
 S7TyA5hY2Fcyru8L6VF2lGMXFiqqgINF50oWjO20dHuJm8wF68mS+hn6rQuNUG+TKRb4
 /RxfJQg7PgKL1bdIncO22mgH0pR+fglKWaRBagg24iVmdcU8mCHaFldPaRa/7HP9YsA1
 2ps1tqpSWFZbwRGGqxq5UbrETvBWo/OQbFrCb6nSqs2wSrYiTWUPNVtGGHLqRCmp4j3I
 49/w==
X-Gm-Message-State: AOJu0Ywn7YsAZXoVUaI8oUXtpk5+MeSZAcp1GwNnZe0beStGuEE9tiLj
 f1Yly0x39uofZrdDixZqH839rTC0ivMVro6BEu/5wFIdHo774ukN0rMcJn6J9hW8QkRUfukjqrZ
 FYePXj2rXA+7u7uGJX/p/q86aUig5ae3cgpXJHwlXOjjZ4lsIbRAQjD6iF+ornxrMQsVLbQ4i1a
 wF0nSi1tGuS+R9y1RStMYQv5Gkh26ObNYyLy8=
X-Google-Smtp-Source: AGHT+IHkML8FKJRpnsyFLoo9i6OCuL0pw59U/73eDl4IqhJ1mgtlhkxpfPAsbigcOTPTw/kkNho//g==
X-Received: by 2002:a05:6a20:3d88:b0:1ce:f588:28b0 with SMTP id
 adf61e73a8af0-1cef5882b1dmr3363876637.13.1725344057562; 
 Mon, 02 Sep 2024 23:14:17 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20524c16145sm60467145ad.98.2024.09.02.23.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:14:16 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 0/5] Introduce svukte ISA extension
Date: Tue,  3 Sep 2024 14:17:52 +0800
Message-Id: <20240903061757.1114957-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42b.google.com
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

base-commit: 8d0a03f689bff16c93df311fdd724c2736d28556

* Add svukte extension

Fea.Wang (5):
  target/riscv: Add svukte extension capability variable
  target/riscv: Support senvcfg[UKTE] bit when svukte extension is
    enabled
  target/riscv: Support hstatus[HUKTE] bit when svukte extension is
    enabled
  target/riscv: Check memory access to meet svuket rule
  target/riscv: Expose svukte ISA extension

 target/riscv/cpu.c        |  2 ++
 target/riscv/cpu_bits.h   |  2 ++
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
 target/riscv/csr.c        |  7 +++++
 5 files changed, 67 insertions(+)

-- 
2.34.1


