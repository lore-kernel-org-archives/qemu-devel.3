Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFD606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTZzv2QE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKjLg-0006Ax-Uo; Sat, 24 Oct 2026 17:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xKjLa-0006Aa-Oj; Sat, 24 Oct 2026 17:32:15 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xKjLZ-0004rr-48; Sat, 24 Oct 2026 17:32:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4697B40A28;
 Sat, 24 Oct 2026 21:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DE71F01825;
 Sat, 24 Oct 2026 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792877528;
 bh=dcG7MExrLIDX9pNtwa7kbxNBvrB4lAR88Md+OGTBxkI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JTZzv2QEsF0yZNx4KWMFMA5ZhI1JVQbSlMv8GVGNssVmRqEAsC/4qxZIa+8Y9aeHp
 6Np8joGNVu0m6PI0c4UsN6xVg+XrHbK7UdcL8ln/EMCyF+aBUtZgYFY7SKhOhxW8Vz
 YbD88m9HsFxYnFpdXButSIBMzSUMZwqIPgGbwVSNOINM7kDRa0e6PYFTl40TTawOKI
 LVJERHlALebrmwJH2Dlc0qyElXtxPE2UP8ACJ06aMLs4t0h70olRXjHt4erONDJju8
 7wE4uL0DxdlDMyLkS1vKLuYzF/SIq6J6Sfcn4EEgGVr6uItlpCl6LSvMinXe5vUPsx
 7HWOVoO38Gk7g==
Date: Sat, 24 Oct 2026 14:32:06 -0700
From: Drew Fustini <fustini@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "shankar.c@oss.qualcomm.com" <shankar.c@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "prajwal.n@oss.qualcomm.com" <prajwal.n@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Message-ID: <at0j1iQQVBCvcSI4@thelio>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
 <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 05:28:31PM +0530, Sunil V L wrote:
> On Thu, Oct 22, 2026 at 10:23 AM Alistair Francis
> <Alistair.Francis@wdc.com> wrote:
> >
> > On Thu, 2026-10-15 at 12:19 +0530, Sunil V L wrote:
> > > Hi alil,
> > >
> > > This series adds ACPI Processor Properties Topology Table (PPTT)
[..]
> > > future, it can be enhanced to support vendor cpu/soc specific cache
> > > information to override this default hardcoded cache details.
> >
> > Why not add a vendor cpu/soc specific one to a vendor board? That way
> > it actually model hardware instead of just providing the guest some
> > made up information.
> >
> Thanks for the feedback!
> 
> Just to make sure I understand your suggestion correctly: should we avoid
> defining a hardcoded cache topology for the generic CPU on virt, and generate
> PPTT cache information only for CPU models that provide an appropriate cache
> hierarchy?
> 
> I can certainly omit the cache information for the generic CPU. The consequence
> is that Drew's CBQRI series, which requires cache information, would need a
> suitable CPU model before it can be used with virt. Drew, please share
> your thoughts.

RQSC is a RISC-V standard so I think it would be nice for the generic
cpu to have a set of caches defined. This would allow the ACPI virt
machine to produce a PPTT with cache IDs that RQSC can reference, and it
would simplify testing for the RISC-V QoS support that I am trying to
upstream into Linux.

Thanks,
Drew

