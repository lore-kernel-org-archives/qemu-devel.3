Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646AE8304A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn7Sv-00041u-R1; Mon, 02 Feb 2026 22:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vn7Ss-00041c-3O
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:52:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vn7Sp-0006Dm-PU
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:52:33 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a76f90872cso27177125ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770090749; x=1770695549; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=43W/bqijZC7YzWZaWeBVeDKMvvvgnYk7wAD2A/CWaRk=;
 b=iaFoDksjYmDedEl9OOrYB035iV/IwhQ9f4Yi4QJMnUM7+jMO2ur7kA6/q0yK4dbFSx
 OB20t1gmfCBAriP8pY5pVAD8gax665EX2PV4KB20WBgnaegL7BlYIwpr26BHRSjnRrvY
 LNKjhub8nyAInVOjpawMjH/6O83x6pJKSRs+G8a1+hzfM3mloAdado0QibZH9pFI2rDu
 di5RuvCthVlk+KB2sD09rs/twI3SsR1BpmmJZ6ZYEr7C4njl8ge2ZD1+ax1vbw9p4/Fl
 HRtAuXEkPtFwemMGgQbJX8oObuYHeMSG536daiw5+wqyFVAz4eA5UYQvr9qcTq7BR0hJ
 qPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770090749; x=1770695549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43W/bqijZC7YzWZaWeBVeDKMvvvgnYk7wAD2A/CWaRk=;
 b=w/2b38HYfv8kr6wR5Mqlv6SFqotzNJyu/8QV6bqd/CYsr8RHreVH005YYe5OZ89piQ
 vFOFFfhIAeoPDJF8vJSz67D8QAuXP1rnC0RZAiJeZ4gAM7c0WDKTvoW40GuS95EIbgR2
 DpG1UhxdL4QDrnK0h3yY3k03e2+fg65OY1hw/hCBBExujQ16+ud0ihkXYF9ljITxHnUV
 RESOuLJyo3Sq896JHB/e+yR3vNBx6XKGuKsUMf/kyeK/kFM4SIoWNK1WAQDK+hI1cay6
 hGsqtladIpZheF+UQQrm0grQxS44fs95s3Y50Nv14kPRpTfgQnkIz8v/CVvez2zeUHnz
 TUZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJHMVbgAo2mKj3HgFsM4TBgrxJLyiuDbVNJ4urfnTwaX6MwbhW1F86fvTPr5H1Kqj8UIkeOaaHP1Jm@nongnu.org
X-Gm-Message-State: AOJu0Yw4/rTTwq1j1q/qQ2h7acfCBC0uGhmEzEOJrhgxLXOUp1QxTMg0
 i0Gu0KLZI3a8/ajGawgk37IBgpDJfROZqaQtJyIeFaBtUkcxS/4HEETL
X-Gm-Gg: AZuq6aKTcQb6/3c1M9UDF345kz4s3Gm5lqvsOy4PhNiNn0ScFylSlOG6muuSHekGLMF
 aVSItwqc1ZSsgy9ObJ5FmXp9Mqb2/1LbPX4wa9fjgqO16Eq/nN5JvqzkbfI51xs+t1sWWVtBFq2
 Ra5BcCO4gnLRFcL1rvx/+zOQYgXgjDwkICMlvjYt8/Al59HiJRFy7/rN+wzsS0mv3xXwmIIbww0
 eevLFg2oVtmU0p3Y/zPsI9up7eU+qlOP0DX16XBCBL9lAWAtqWpL/US6o+cTu4T/b4B0SliSjJP
 P8xypoo04vHeS6v9sDF3fJcRHLIbE9jtcu6kdtS7vtUsf3NvPhyNqYGAGiz59d3vY/qIhfO7JUd
 qfeAoLerBBE6HJWQSERiSoOdf4nuR1c26hnMKx8BwXHaunrsthcU/cq3VTw2FyS0TBY++eLOT13
 69fXb9D5Oh0ZcNfbGZRLXMSgkAYz2FFC6eIwUIdJp+q4UPGgKGXyL5HIu80A4/b6qqwE0YLA4t2
 g==
X-Received: by 2002:a17:903:2305:b0:298:2879:fdf5 with SMTP id
 d9443c01a7336-2a8d9a5b220mr145853555ad.61.1770090748830; 
 Mon, 02 Feb 2026 19:52:28 -0800 (PST)
Received: from b962e8cb79b7 ([43.139.160.244])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c64276ef9fcsm15839683a12.1.2026.02.02.19.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 19:52:28 -0800 (PST)
Date: Tue, 3 Feb 2026 11:52:22 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, hust-os-kernel-patches@googlegroups.com
Subject: Re: [RFC PATCH v2 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
Message-ID: <aYFw9sUi3rkuDIZq@b962e8cb79b7>
References: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
 <7cc1e085432336463dd19e11212cda516b97a33e.1769678103.git.chao.liu.zevorn@gmail.com>
 <87sebjq7x6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sebjq7x6.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
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

Hi Fabiano,

On Mon, Feb 02, 2026 at 04:09:25PM -0300, Fabiano Rosas wrote:
> Chao Liu <chao.liu.zevorn@gmail.com> writes:
> 
> > Add a qtest suite for the RISC-V IOMMU PCI device on the virt machine.
> > The test exercises bare, S-stage, G-stage, and nested translation paths
> > using iommu-testdev and the qos-riscv-iommu helpers.
> >
> > The test validates:
> > - Device context (DC) configuration
> > - SV39 page table walks for S-stage translation
> > - SV39x4 page table walks for G-stage translation
> > - Nested translation combining both stages
> > - FCTL register constraints
> >
> > This provides regression coverage for the RISC-V IOMMU implementation
> > without requiring a full guest OS boot.
> >
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> ...
> 
> > +static bool riscv_iommu_test_setup(RiscvIommuTestState *state)
> > +{
> > +    if (!qtest_has_machine("virt")) {
> > +        g_test_skip("virt machine not available");
> > +        return false;
> > +    }
> > +
> > +    state->qts = qtest_init("-machine virt,acpi=off "
> > +                            "-cpu max -smp 1 -m 512 -net none "
> > +                            "-device riscv-iommu-pci "
> > +                            "-device iommu-testdev");
> > +
> > +    qpci_init_generic(&state->gbus, state->qts, NULL, false);
> > +    riscv_config_qpci_bus(&state->gbus);
> > +
> > +    state->iommu_dev = find_riscv_iommu_pci(&state->gbus, &state->iommu_base);
> > +    g_assert(state->iommu_dev);
> > +
> > +    state->testdev = find_iommu_testdev(&state->gbus, &state->testdev_bar);
> > +    g_assert(state->testdev);
> > +
> 
> These two will leak. Otherwise, looks good.
> 
Thanks for the review. I'ill fix this in v3.

Thanks,
Chao
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

