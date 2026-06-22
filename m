Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C511ECD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbmEz-0001W3-DE; Mon, 22 Jun 2026 17:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wbmEx-0001RF-W2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:31:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wbmEw-00030Q-7q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:31:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8453bcf7276so2728305b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782163893; x=1782768693; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wbGZkNGAhGxRwPK/P+g3tEKhll0n+6YKLHW4pSQF68g=;
 b=cbdp1jsC5ElLsYpMPFLoPGI4CCpt7kgCkNbj66thS939YhWlLjLwg1vtPu+blthkmj
 DagjN4hAStWyH7can12MpqKLZZswKHFzR67jnvyJ2tljXLx2OVsqf+wvTltwKgi8I0Ue
 xlEEqPH/WxkLsWRffp/CHu2ndp4t1KVJFfE0jETCYmTrg2tc3s1QUxh9dojNzcev39ua
 sxaPHXr+KvARHRoL3nBzojElgK/jhWJk0AhrjwahOyMyXhG1b69E3LlrO9e7EGCjBNzw
 3vxcyzV7lZBLYoK03QUU3ydbJ5JhsRN9NUzIe8wKiH7vtHOLbRkFfSQpl8hKzgSVn5Tq
 xOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163893; x=1782768693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbGZkNGAhGxRwPK/P+g3tEKhll0n+6YKLHW4pSQF68g=;
 b=BZPwR3cq+N9WBA+zFZZlz6/b1GpMqDeiaOAgO1OILhQiIWByZZjEs6yPELTPYGYELH
 aA2FgB9s1nQKV1mDUI4yQ2Unn5Ly+YSACUQIZAi7tPIlKPk7jY9LYxCnvllDyqUKAiSo
 oUwZjhnP4EXfDoNbm/Y1s7GiS9sTYFj7/6d9ULWYeHyHYIwCnEHPuSP3+ZgxbH2U/kAh
 tZpHrtsb44pD7qw2t1a8MpLU3hP7v/yfTYfHrdZ2Q6BBHJr4dxOUJHWu8LHvfNtvCAGt
 Sueh3ufrlf92cVLWdUVG4N+e4SYGTcpBkU+7gPwN54FBiBSm3dGCrsrhXg/De16pW3+3
 GpMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qbk8NMJY1baERvmon0AXDGtk2s3CcYE4fJvDB+kWDjAkRnO1upZD7jR9D9LyPCykvRlU914CNv7aG@nongnu.org
X-Gm-Message-State: AOJu0YxzujeXacmARSXQeEAhQxGq5p7kjwv7ZvLsUjNQjbwBjxO0YZaD
 a/b7k7UCaz1l5w06MV+z/bZ5rzFuOUoeYv13qpepdYpknmPCKtGcmnJs
X-Gm-Gg: AfdE7cnRFduJ6sDolAlNzXBM6GgDzwt9LA/sX4XLFVp26b1EWSu8ySvPqiDxDxesVJd
 r1I+KUewHPQ02pluU1MWiyhB8C3rOggLypXLXUBvx1msBlUYBiCS4w7SnJT7fkHUE38Bjx04oeJ
 lEgFmTtqjMEN+0CkOThHannEGdVN/s6TB16Y74UMmuLRT13SQRBhqedQf//bnTPNPHsbS956mM1
 rxQqEdAXvdTYNm44nChbvG9Bj0qNLDzMJnrkuX+usvfmlghnWpEmpL5W3UpL0cqrouxa1y0s6La
 SIEaPDSWkCi0uZ5h8jTycA18jQuZuElYKHyw8SAGTLR5/toLbsy1KGYxt2aPdUv0jTbLhO2DlCu
 i9/8DNTsG1XPUuCGTPDRrXGgD3AEeOQlNUJAOW3ujRluAApdGuJBalek+RfFxYeuf+6gLpDyWyb
 kpfylZknAI/zx65/7sDATHha4=
X-Received: by 2002:a05:6a00:9296:b0:845:286d:4675 with SMTP id
 d2e1a72fcca58-845507c1c40mr16720911b3a.10.1782163892808; 
 Mon, 22 Jun 2026 14:31:32 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ef4c09sm9525473b3a.61.2026.06.22.14.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 14:31:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 05:31:27 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com,
 alistair.francis@wdc.com, farosas@suse.de, lvivier@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 0/5] hw/riscv: Add support for Milk-V Duo board
Message-ID: <ajmpr3VIk-dmRNnF@google.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <ajI_7sMKcaa-_lKD@ChaodeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajI_7sMKcaa-_lKD@ChaodeMacBook-Pro.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jun 17, 2026 at 02:37:34PM +0800, Chao Liu wrote:
> On Tue, Jun 16, 2026 at 07:01:42PM +0800, Kuan-Wei Chiu wrote:
> Hi Kuan-Wei,
> 
> > Add initial support for the Milk-V Duo board.
> > 
> > The Sophgo CV1800B SoC features T-Head C906 processing, standard PLIC
> > and CLINT controllers, a dw8250 uart, and basic clock control. The
> > current implementation can successfully run OpenSBI and boot Linux v7.0
> > from an SD card to the Linux shell.
> Can you add a document for the Milk-V Duo board?

Ack.

Will add a doc in next version.

Regards,
Kuan-Wei

> 
> Thanks,
> Chao
> > ---
> > Changes in v3:
> > - Rebase on master branch.
> > - Drop custom T-Head PMU CSR patch to avoid duplication.
> > - Use REG_BYTE_WIDTH macro in clock controller.
> > 
> > Changes in v2:
> > - Added link for the custom T-Head PMU CSRs
> > - Added qtest to validate basic for the dw8250 and clock controller.
> > - Removed RFC tag.
> > 
> > Kuan-Wei Chiu (5):
> >   hw/char: Add dw8250 UART
> >   hw/misc: Add Sophgo CV1800B clock controller
> >   hw/riscv: Add Sophgo CV1800B SoC support
> >   hw/riscv: Add Milk-V Duo board support
> >   tests/qtest: Add qtest for Milk-V Duo board
> > 
> >  MAINTAINERS                                 |  12 ++
> >  configs/devices/riscv64-softmmu/default.mak |   1 +
> >  hw/char/Kconfig                             |   4 +
> >  hw/char/dw8250.c                            | 118 ++++++++++++++
> >  hw/char/meson.build                         |   1 +
> >  hw/misc/Kconfig                             |   3 +
> >  hw/misc/cv1800b_clk.c                       |  90 +++++++++++
> >  hw/misc/meson.build                         |   1 +
> >  hw/riscv/Kconfig                            |  14 ++
> >  hw/riscv/cv1800b.c                          | 168 ++++++++++++++++++++
> >  hw/riscv/meson.build                        |   3 +
> >  hw/riscv/milkv_duo.c                        | 124 +++++++++++++++
> >  include/hw/char/dw8250.h                    |  27 ++++
> >  include/hw/misc/cv1800b_clk.h               |  24 +++
> >  include/hw/riscv/cv1800b.h                  |  52 ++++++
> >  tests/qtest/meson.build                     |   3 +-
> >  tests/qtest/milkv-duo-test.c                |  70 ++++++++
> >  17 files changed, 714 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/char/dw8250.c
> >  create mode 100644 hw/misc/cv1800b_clk.c
> >  create mode 100644 hw/riscv/cv1800b.c
> >  create mode 100644 hw/riscv/milkv_duo.c
> >  create mode 100644 include/hw/char/dw8250.h
> >  create mode 100644 include/hw/misc/cv1800b_clk.h
> >  create mode 100644 include/hw/riscv/cv1800b.h
> >  create mode 100644 tests/qtest/milkv-duo-test.c
> > 
> > -- 
> > 2.54.0.1136.gdb2ca164c4-goog
> > 

