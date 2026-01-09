Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDE0D232DE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 04:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve4Xm-0008OV-Vx; Thu, 08 Jan 2026 23:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1ve4Xh-0008Mj-JS; Thu, 08 Jan 2026 23:56:10 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1ve4Xf-0004Ow-PT; Thu, 08 Jan 2026 23:56:09 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A7DB760133;
 Fri,  9 Jan 2026 04:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24059C4CEF1;
 Fri,  9 Jan 2026 04:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767934565;
 bh=iEYf+hcUPMArviGYeng3D7Xp8iltvBK9tHSYgMsC8uQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IkcJnrV9VpNa5meyC375/uAvUtuAFx3zbElIBg5oGxOQUirxLkLLlgh05b4qa2x0B
 ffjsN197FxG5UMJ3tpjX+tRzNH8UainGJYSlQhFfdjhntYYtrl98RwTtGiCWGzRiMe
 pGBHnQ7gATfFAXUCRB3Uv3AvaHvnAeagyzykj/MteCxj5D7rXLH03PXlg4zB8FAY7S
 ygq+2FZqd2XQ+Tq/FgsSNeXQl6IxFRCnXOw7GM15Flz1F0TWUeIhskX4cueoeOvgN/
 YKCwLFefILs35ugm6zga7Od0gVobFofGznJXfSh9KRmWApCM1WFOr6OuPu2nz7zvOz
 0AVZgfS5EH7ww==
Date: Thu, 8 Jan 2026 20:56:03 -0800
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Subject: Re: [External] Re: [PATCH v4 0/6] riscv: implement Ssqosid extension
 and CBQRI controllers
Message-ID: <aWCKYy7/yGdw16QR@x1>
References: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
 <CAEEQ3wkM9h0kJNE4yTtN5ms2JgRBp6b_530KM8irbGKzjMkrgg@mail.gmail.com>
 <aV9drIreiKV84MjG@x1>
 <CAEEQ3wmebe9ArBEYP--mh3f6Na_k-V6y+CWCCrUzGdCRpibHqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmebe9ArBEYP--mh3f6Na_k-V6y+CWCCrUzGdCRpibHqQ@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 08, 2026 at 04:46:10PM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Thu, Jan 8, 2026 at 3:33 PM Drew Fustini <fustini@kernel.org> wrote:
> >
> > On Wed, Jan 07, 2026 at 03:38:34PM +0800, yunhui cui wrote:
> > > Hi Drew,
> > >
> > > On Tue, Jan 6, 2026 at 5:55 AM Drew Fustini <fustini@kernel.org> wrote:
> > > >
> > > > This series implements the RISC-V Quality-of-Service Identifiers
> > > > (Ssqosid) extension [1] which adds the srmcfg register. It also
> > > > implements the RISC-V Capacity and Bandwidth Controller QoS Register
> > > > Interface (CBQRI) specification [2]. Quality of Service (QoS) in this
> > > > context is concerned with shared resources on an SoC such as cache
> > > > capacity and memory bandwidth.
> > > >
> > > > Sssqosid srmcfg CSR
> > > > -------------------
> > > > The srmcfg CSR configures a hart with two identifiers:
> > > >
> > > >  - Resource Control ID (RCID)
> > > >  - Monitoring Counter ID (MCID)
> > > >
> > > > These identifiers accompany each request issued by the hart to shared
> > > > resource controllers. This allows the capacity and bandwidth resources
> > > > used by a software workload (e.g. a process or a set of processes) to be
> > > > controlled and monitored.
> > >
> > > 1. The CBQRI specification does not mandate 64-byte access width for
> > > its registers. Therefore, is it necessary to add a field in the ACPI
> > > RQSC table?
> >
> > Sorry, I don't follow. Why would a new field be needed in RQSC?
> 
> Different manufacturers may design CBQRI registers with different
> widths (32-bit or 64-bit). See:
> https://github.com/riscv-non-isa/riscv-rqsc/issues/10

Thanks for the link. I now understand that you are talking about a field 
to indicate the supported access width. I think Radim's comments
illustrate that software should not have to worry about about 32-bit or
64-bit accesses as the CBQRI spec requires a controller to support both.
I think we will have to wait and see if there are any real hardware
implementations where that is not the case.

> > > 2. In addition, although CBQRI does not require configuring a specific
> > > number of RMIDs for each CLOSID like MPAM does, creating a control
> > > group will by default create a monitoring group. So on RISC-V, the
> > > number of MCIDs should be at least no less than that of RCIDs, right?
> >
> > Yes, I have working on the assumption that the number of MCIDs (RMIDs)
> > will be greater than, or equal to, the number of RCIDs (e.g. CLOSIDs).
> >
> > Chapter 6 of the CBQRI spec states that: "In a typical implementation,
> > the number of RCID bits implemented (for example, to support 10s of
> > RCIDs) might be smaller than the number of MCID bits implemented (for
> > example, to support 100s of MCIDs)."
> >
> > I would be very interested if anyone can share the RCID and MCID count
> > for their CBQRI hardware implementation.
> >
> > > 3. By the way, for Linux, could you also release a version of the
> > > CBQRI/Ssqosid patchset with ACPI support?
> >
> > The series I am about to post for Ssqosid+CBQRI [1] just contains a
> > device tree example, but I will do a followup series for RQSC. The
> > kernel branch [2] from the RQSC proof-of-concept was based on v6.14 so I
> > need to rebase it. The good thing is that 6.19 now has the PPTT helpers
> > from the MPAM driver series.
> 
> Oh, that's great! When will the RQSC-supported patchset based on 6.19
> likely be posted? Looking forward to your update.

I don't think the kernel patches for RQSC will be that complicated to
rebase. However, I think the Qemu branch [1] will take more work as it
was based on an old PPTT patch series [2]. I think I will have the
Ssqosid+CBQRI kernel patch series ready to post tomorrow, so I think it
is reasonable to target posting the rebased RQSC series for Linux and
Qemu 1 week later.

Thanks,
Drew

[1] https://github.com/tt-fustini/qemu/commits/riscv-cbqri-rqsc-pptt/
[2] https://lore.kernel.org/all/20240129104039.117671-1-jeeheng.sia@starfivetech.com/`

