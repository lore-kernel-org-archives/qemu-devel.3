Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EA606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwxfSaMe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLttD-0005hw-OZ; Tue, 27 Oct 2026 22:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLtt8-0005hV-Nx; Tue, 27 Oct 2026 22:59:43 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLtsn-0001xl-Co; Tue, 27 Oct 2026 22:59:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5328742BC6;
 Wed, 28 Oct 2026 02:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A01F01825;
 Wed, 28 Oct 2026 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793156358;
 bh=NXsULG64tVDnsXhfm+seWOmuHSMRKB50ip9FfysVYo0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EwxfSaMeKmk3ki6hpheLjATW0LDCtrBNTxl5U3KUjcvyFx4kFGK6yMyhZeZdvNtmv
 kvihHBl2TZmpuyJllDXhlvktPVLR4gI9vi/4abBFt0+1R+y2JOj+5Hxim18BLlG826
 ksaIGsaLczEhR2AKq6SmLE8p4UIMou81sLJitefPebOnaeGHls2B4BhioyD3XE3EbU
 KsVzsFQoE6lRq353h2QtFw2ePmWP8a9uiPN3eTH4RKuoXoXsqaXfeI2/Bm1FfqHokx
 vmBrtu1pTOjAIPgVIhmrseH+DdOM2cFtec985AIDZCXdj0pFD3Tdw/7TOMQdLk3kCp
 n3Lf/8x87Sb+A==
Date: Tue, 27 Oct 2026 19:59:16 -0700
From: Drew Fustini <fustini@kernel.org>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mindal@semihalf.com" <mindal@semihalf.com>,
 "sunilvl@oss.qualcomm.com" <sunilvl@oss.qualcomm.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>,
 "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "cp0613@linux.alibaba.com" <cp0613@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "radim.krcmar@oss.qualcomm.com" <radim.krcmar@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
 "npitre@baylibre.com" <npitre@baylibre.com>,
 "cuiyunhui@bytedance.com" <cuiyunhui@bytedance.com>,
 "atish.patra@linux.dev" <atish.patra@linux.dev>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Subject: Re: [PATCH v6 1/6] riscv: implement Ssqosid extension and srmcfg CSR
Message-ID: <auFlBAtOZSw94vnk@thelio>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-1-1a367a35cd0e@kernel.org>
 <20219a9e5fcaf2f50eee2bd123a12a04c05cb97a.camel@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20219a9e5fcaf2f50eee2bd123a12a04c05cb97a.camel@wdc.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:22:02AM +0000, Alistair Francis wrote:
> On Mon, 2026-10-26 at 10:47 -0700, Drew Fustini wrote:
> > From: Kornel Dulęba <mindal@semihalf.com>
> > 
> > Implement the srmcfg CSR defined by the Ssqosid ISA extension
> > (Supervisor-mode Quality of Service ID). The CSR contains two fields:
> > 
> >   - Resource Control ID (RCID) used determine resource allocation
> >   - Monitoring Counter ID (MCID) used to track resource usage
> > 
> > The CSR is defined for S-mode, so check mstateen0.srmcfg to determine
> > if s-mode is allowed to access it. In addition, accessing it when V=1
> > shall cause a virtual instruction exception.
> > 
> > Link:
> > https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
> > Link: https://docs.riscv.org/reference/isa/priv/smstateen.html
> > Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> > [fustini: rebase on v10.1.50, fix check_srmcfg]
> > Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> 
> I'm just meat proxying this one, but it looks believable, let me know
> if it's wrong though:

Is this something I can run myself in the future?

I can run local sashiko for my linux patches but I wasn't sure what to
do for qemu.

> - [HIGH] In target/riscv/tcg/csr.c, none of write_mstateen0,
> write_mstateen0h, write_hstateen0, or write_hstateen0h ever ORs
> SMSTATEEN0_SRMCFG into wr_mask when ext_ssqosid is set, so bit 55 of
> mstateen0/hstateen0 stays read-only zero and M-mode firmware writes
> that enable srmcfg access are silently dropped, violating the
> Smstateen spec (a bit for an implemented extension must not be
> read-only zero). check_srmcfg gates the new CSR on
> smstateen_acc_ok(..., SMSTATEEN0_SRMCFG), and Smstateen is enabled by
> default on the same dynamic CPUs that get ext_ssqosid by default, so
> on the stock virt machine every S-mode (V=0) srmcfg access traps
> illegal instruction and VS-mode additionally takes a virtual
> instruction fault: the QoS feature this series exists to expose is
> systematically unusable. Fix by ORing the bit into the stateen write
> masks like the existing CTR, P1P13, and SVSLCT cases.

This is a real issue for mstateen0 and mstateen0h. I will add
SMSTATEEN0_SRMCFG to wr_mask in write_mstateen0() and
write_mstateen0h(). However, I believe hstateen0 bit 55 is WPRI so I
think the current behavior is correct.

> - [MEDIUM] In target/riscv/cpu.h, env->srmcfg is new guest-writable
>   architected state (written via write_srmcfg in
>   target/riscv/tcg/csr.c) but target/riscv/machine.c never migrates
>   it: vmstate_riscv_cpu has no ssqosid/srmcfg field or subsection.
>   After live migration, savevm/loadvm, or snapshot restore the
>   destination CPU resumes with srmcfg = 0 while the guest believes its
>   programmed RCID/MCID are still in effect. Add a versioned
>   vmstate_ssqosid subsection with a .needed predicate on ext_ssqosid,
>   following the vmstate_smstateen/vmstate_envcfg pattern.

I'll add a VMStateDescription for Ssqosid.

> - [MEDIUM] In target/riscv/cpu.c (isa_edata_arr), Ssqosid is
> registered as a user-facing extension and enabled by default on
> BASE32/BASE64 with no tests/tcg coverage anywhere in the tree. The
> RISC-V upstreaming rules require unit tests for new extensions' CSR
> accesses, and the stateen gating and V=1 trap paths added in
> check_srmcfg are exactly what such tests would exercise -- they would
> have caught the broken SRMCFG stateen bit above. Add tests/tcg cases
> for srmcfg read/write, WARL masking, and the
> stateen/virtual-instruction-fault gating.

I'll add tests for srmcfg.

> - [LOW] nit: in target/riscv/tcg/csr.c, the check_srmcfg comment says
>   "we need to throw and virt instruction fault"; s/and virt/a virtual/.

I'll fix.

Thanks,
Drew

