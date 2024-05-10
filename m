Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE117C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5OCs-0000Vp-UY; Fri, 10 May 2024 07:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5OCq-0000U6-SP
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:14:28 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s5OCo-0008Qc-FH
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:14:28 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-522297f91easo175831e87.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715339664; x=1715944464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+VyR4yQ//2IQBmod7fwSbuCPCJkuvP1E0TIuAzoI34=;
 b=BWRd2Tl+/KMoE7i88EVVxOD2dXpnbd3tOnF5+tBc0B6ewX+bkVnUKMX+qGjMfvou/n
 9+Z7Ubq3y9f2ktinrwXgjp/1SLJhcHS021XYUp9ab40B/Y4+7GSNiOwUxHi1jx16nyHG
 JAUooFSnB5TpFwgApJwzs1DaBBZdOmjftHV6aoFBpx2Hy8XdsoQXurR1SFRg6tiOTpOl
 IhluFAOpikK/ULIHvDGXBzPj46eFSKuG9JF+nn7+K/AZU5hUZ0kqS5ZqRDLye3HQogWZ
 2kl99xI92Mhg3VcX09tJYGPoW2n5Tckv2wgj8Sh03q11Jutt9YlDuTCWPH2G7Mz/TkwG
 xBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715339664; x=1715944464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+VyR4yQ//2IQBmod7fwSbuCPCJkuvP1E0TIuAzoI34=;
 b=wAclIeX06Ju6liLqTDfntnLgFGZxdmEBhf2B4XO+c/PSsTVpJxalLzeg9vlTXm4xLX
 9HdGn4pv3T9U4PPSEntGSU2/Hhj/6x/2SU2t3i4cG1tYZ9MJvJeIKS91Afs++n49nCoa
 ajVXRewew6RwdNVPp+Sf3O0x8LcKkXSRfXBwwqNvHsql9XF74OYn0AecRMbCwMhXnH7l
 Qf3tIZuOUdL8Gkp7vCg9BiwbUzh8ypU578cL2xbjokSrrPjjGtwLY8StOlYXRWqrET24
 SAirrnLC2Tu+fDwo6zMPF6ojgxfaR6a493cXVktQ3++35s2i4c4R28PSMjEm/cXddXp2
 HrDQ==
X-Gm-Message-State: AOJu0Yy/4WBOmetD1Lvje7RsLhJo8ryaeJyLJvWgpa0kG6OCLOn5Z+MT
 EsOHJt515r0RXtQBe/g718GvtohelU+XqUJOJ0Wlmc3ZsLCARHLiigz/LxNFcJbi0SkjX8eOlZa
 wW92PglcdGdjS/AFWhz9zDB9LQIFqmjDnDtp8EyltBmk+EDBBzkaYmpdQE3bw43QUd0/K9qSMmi
 RJGkU7+HPb4Ptm6LAP/BqioHOFM7cxU1u8JJP9PNWo/A==
X-Google-Smtp-Source: AGHT+IEiFM4lpdWo2CML6STfhAdIIp0Fhz0V2cDwjyatiRb9GROxeknyJcVC5JHAsCh6uOZa+VF7Dw==
X-Received: by 2002:ac2:54b9:0:b0:51f:d72:cd2d with SMTP id
 2adb3069b0e04-5220fc7aeb4mr1388875e87.22.1715339664045; 
 Fri, 10 May 2024 04:14:24 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f38d7f7csm647687e87.189.2024.05.10.04.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 04:14:23 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2e09138a2b1so22229581fa.3; 
 Fri, 10 May 2024 04:14:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVrd1iCxAEzohgE/4ucktyPMGXEKrFFd3pUE7FX3hxkN4dT6EGQeWjdTEZDtb4Rt9x4atgrF6/1XWKYJRVKZd/87X6BPWc=
X-Received: by 2002:a2e:3305:0:b0:2df:fa4a:ef15 with SMTP id
 38308e7fff4ca-2e5204ccee8mr14419491fa.39.1715339663484; Fri, 10 May 2024
 04:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 May 2024 19:14:12 +0800
X-Gmail-Original-Message-ID: <CANzO1D0x5eyZKoNQfH1Q36ieMw21MjxFO30=gzADWNOV5gKXbw@mail.gmail.com>
Message-ID: <CANzO1D0x5eyZKoNQfH1Q36ieMw21MjxFO30=gzADWNOV5gKXbw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] riscv: QEMU RISC-V IOMMU Support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12f.google.com
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

Hi Daniel,

Thanks for the upstream work.
Sorry that it took a while for me to review the patchset.

Please let me know if you need any help from us to update the IOMMU model.
We would like to see it merged for QEMU 9.1.0.

Regards,
Frank Chang

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> This is the second version of the work Tomasz sent in July 2023 [1].
> I'll be helping Tomasz upstreaming it.
>
> The core emulation code is left unchanged but a few tweaks were made in
> v2:
>
> - The most notable difference in this version is that the code was split
>   in smaller chunks. Patch 03 is still a 1700 lines patch, which is an
>   improvement from the 3800 lines patch from v1, but we can only go so
>   far when splitting the core components of the emulation. The reality
>   is that the IOMMU emulation is a rather complex piece of software and
>   there's not much we can do to alleviate it;
>
> - I'm not contributing the HPM support that was present in v1. It shaved
>   off 600 lines of code from the series, which is already large enough
>   as is. We'll introduce HPM in later versions or as a follow-up;
>
> - The riscv-iommu-header.h header was also trimmed. I shaved it of 300
>   or so from it, all of them from definitions that the emulation isn't
>   using it. The header will be eventually be imported from the Linux
>   driver (not upstream yet), so for now we can live with a trimmed
>   header for the emulation usage alone;
>
> - I added libqos tests for the riscv-iommu-pci device. The idea of these
>   tests is to give us more confidence in the emulation code;
>
> - 'edu' device support. The support was retrieved from Tomasz EDU branch
>   [2]. This device can then be used to test PCI passthrough to exercise
>   the IOMMU.
>
>
> Patches based on alistair/riscv-to-apply.next.
>
> v1 link: https://lore.kernel.org/qemu-riscv/cover.1689819031.git.tjeznach=
@rivosinc.com/
>
> [1] https://lore.kernel.org/qemu-riscv/cover.1689819031.git.tjeznach@rivo=
sinc.com/
> [2] https://github.com/tjeznach/qemu.git, branch 'riscv_iommu_edu_impl'
>
> Andrew Jones (1):
>   hw/riscv/riscv-iommu: Add another irq for mrif notifications
>
> Daniel Henrique Barboza (2):
>   test/qtest: add riscv-iommu-pci tests
>   qtest/riscv-iommu-test: add init queues test
>
> Tomasz Jeznach (12):
>   exec/memtxattr: add process identifier to the transaction attributes
>   hw/riscv: add riscv-iommu-bits.h
>   hw/riscv: add RISC-V IOMMU base emulation
>   hw/riscv: add riscv-iommu-pci device
>   hw/riscv: add riscv-iommu-sys platform device
>   hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>   hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>   hw/riscv/riscv-iommu: add s-stage and g-stage support
>   hw/riscv/riscv-iommu: add ATS support
>   hw/riscv/riscv-iommu: add DBG support
>   hw/misc: EDU: added PASID support
>   hw/misc: EDU: add ATS/PRI capability
>
>  hw/misc/edu.c                    |  297 ++++-
>  hw/riscv/Kconfig                 |    4 +
>  hw/riscv/meson.build             |    1 +
>  hw/riscv/riscv-iommu-bits.h      |  407 ++++++
>  hw/riscv/riscv-iommu-pci.c       |  173 +++
>  hw/riscv/riscv-iommu-sys.c       |   93 ++
>  hw/riscv/riscv-iommu.c           | 2085 ++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h           |  146 +++
>  hw/riscv/trace-events            |   15 +
>  hw/riscv/trace.h                 |    2 +
>  hw/riscv/virt.c                  |   33 +-
>  include/exec/memattrs.h          |    5 +
>  include/hw/riscv/iommu.h         |   40 +
>  meson.build                      |    1 +
>  tests/qtest/libqos/meson.build   |    4 +
>  tests/qtest/libqos/riscv-iommu.c |   79 ++
>  tests/qtest/libqos/riscv-iommu.h |   96 ++
>  tests/qtest/meson.build          |    1 +
>  tests/qtest/riscv-iommu-test.c   |  234 ++++
>  19 files changed, 3704 insertions(+), 12 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-bits.h
>  create mode 100644 hw/riscv/riscv-iommu-pci.c
>  create mode 100644 hw/riscv/riscv-iommu-sys.c
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
>  create mode 100644 tests/qtest/libqos/riscv-iommu.c
>  create mode 100644 tests/qtest/libqos/riscv-iommu.h
>  create mode 100644 tests/qtest/riscv-iommu-test.c
>
> --
> 2.43.2
>
>

