Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E39C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf5sD-0006tZ-ER; Tue, 27 Feb 2024 17:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3E2HeZQcKCoQswutwlqowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--komlodi.bounces.google.com>)
 id 1rf5sB-0006sl-Aj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:27 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3E2HeZQcKCoQswutwlqowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--komlodi.bounces.google.com>)
 id 1rf5s8-0008Hq-55
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:27 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2992c1d4e7fso2091870a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709072660; x=1709677460; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JXG4tZrCKCTQ/UKh/RNLGqEovZ4jw5ABcy4v4l/utkc=;
 b=fzWgHMtBPsbTq7/2/4yDiGIIzk2pHW4F/UUsUNmaIjSqPuS9PaxdmhEbt4y3vQjm+C
 gjLbHYi3p6GMn6QI0PWhIzxAyyuzgDe/4IGnu+eiVL3XH5nk764UOVu3CYDFBRGm2U0o
 BAhNFHdjOOp8IiBhp5Nvzv8AhCw+GhMWnd7oac2Mp6o1C+9GgbCWpkeMkCuvZrkZjjLg
 mNtLtlb493rxz/2Nt+a+Xv+sGcwMqNmrlMDX3Y7vDPOTRregTXPqY6jvuzLuORkzcb9L
 e4j4ltrHm2d29T1wlWBArqugyhZAzdNDa3+0t0PAbaZbgsGIzBI/nYqGgMJC0oR8w1l0
 RExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709072660; x=1709677460;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JXG4tZrCKCTQ/UKh/RNLGqEovZ4jw5ABcy4v4l/utkc=;
 b=KivqqKy5UcYWhM4tl4Hi4pouCH3Y5xbAdPbpThokBh2m/1wu9BlZC0FBnCWnm28jyV
 xx+oHJDggCv2sJqw5YX7eaVu2D1uHFT6549OCqUEe7n39AerNQteBTFSRLg31NCpQ14O
 M374I1ASZNQY9QFDf6p5FGUbNoG+z+K+60BYxdYsOM9jdliaHSmTxk7lEGTSeu5yinmk
 AuZyKgyoldlgVgJeQBFzPXXl09GmDf+HpyFurE5dl0rJZFzhUqyT9QppiQW3c81L6Lwt
 2lcTo27kKiJTDHK6kdvEWkoDD0P1J5D2Lwv0hBL4ChSmKO7MDddGmI1G/63kYxnq+f2U
 aReA==
X-Gm-Message-State: AOJu0YzSg8INRi/6KlhoOIZtTLE8k4y4iL8aN93JdUgb1qZvEl2eskSo
 4tr2T8Im7pLXvwdRvxD9rWLKia8UqPsq+H7lCpdn+tfziPHydUBcrK3+mSGRwR7kzTSNErBCfx7
 6GEyxG4TlyvXK5e1qNdK9oyJKcZNMs0yFFmxEUsAHJgvkJ4vW2Fp3kOg0vmcElDVHScGeOviRUD
 rVUGJw63FslrVXDHpgrErxyek7S3OngCXO3jAE
X-Google-Smtp-Source: AGHT+IFD2E5oSwgl9tk22ApL/JmI69ybqqttlgwkN9zWLmh++Vn8Yc9Ps6qRs3jnZCIDjxTdcevuSf049HFm
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:90b:2c8e:b0:29a:bb5e:1d7c with SMTP id
 sw14-20020a17090b2c8e00b0029abb5e1d7cmr23454pjb.3.1709072659041; Tue, 27 Feb
 2024 14:24:19 -0800 (PST)
Date: Tue, 27 Feb 2024 22:24:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222417.929367-1-komlodi@google.com>
Subject: [RFC PATCH 0/5] memattrs: target/arm: add user-defined and requester
 ID memattrs
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3E2HeZQcKCoQswutwlqowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi all,

This adds requester IDs to ARM CPUs and adds a "user-defined" memory
attribute.

The requester ID on ARM CPUs is there because I've seen some cases where
there's an IOMMU between a CPU and memory that uses the CPU's requester
ID to look up how it should translate, such as an SMMU TBU or some other
IOMMU-like device.
For a specific downstream example I've seen, Xilinx overrides CPU
attributes with ones passed in by an object property in order to have
their IOMMUs work:
https://github.com/Xilinx/qemu/blob/23b643ba1683a47ef49447a45643fe2172d6f8ca/accel/tcg/cputlb.c#L1127.
The object property with the memory attributes is declared here, for
reference: https://github.com/Xilinx/qemu/blob/23b643ba1683a47ef49447a45643fe2172d6f8ca/target/arm/cpu.c#L1310.

The user-defined attribute represents optional user signals that are a
part of AMBA-AXI. As the name suggests, these are defined
per-implementation and devices that receive these have their own
interpretation of what the user-defined attribute means.

We add them in CPUs and PCI transactions, because some of their
attributes are set in functions in ways that are not user-facing. DMAs
or other devices that set attributes (using address_space_rw or some
other means), can add them on a per-device basis.

RFC because it's possible we might want this implementated in some other
way, and it touches some pretty frequently used code that I'm somewhat
familiar with, but not 100% familiar with.

Thanks,
Joe

Joe Komlodi (5):
  target/arm: Add requester ID to memattrs
  memattrs: Fix target_tlb_bit whitespace
  memattrs: Add user-defined attribute
  target/arm: Add user-defined memattrs
  hw/pci: Add user-defined memattrs

 hw/pci/pci.c                | 3 +++
 include/exec/memattrs.h     | 8 +++++---
 include/hw/pci/pci_device.h | 1 +
 target/arm/cpu.c            | 6 ++++++
 target/arm/cpu.h            | 8 ++++++++
 target/arm/ptw.c            | 9 +++++++++
 6 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


