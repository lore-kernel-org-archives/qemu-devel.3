Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B1606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIZdlBGW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLcS3-0003RG-0u; Tue, 27 Oct 2026 04:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLcS1-0003Qn-Dj; Tue, 27 Oct 2026 04:22:33 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xLcRz-0001oH-Eu; Tue, 27 Oct 2026 04:22:33 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1C85601FB;
 Tue, 27 Oct 2026 08:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256871F01828;
 Tue, 27 Oct 2026 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793089349;
 bh=aj5Obr/MW1OY020bmqqhtHv5qCM1RtrMDb8sv3AAcIY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aIZdlBGWlhyK8eCmm5Uu8UtbPR8tzffJofiFd1QowfmHi4Egdz2gIGgMKYXeQwKeG
 7YvC5gIf52ka1FafaIRIDcaCCuHkLMc6YcNov860K8eDwkgDulLapsIGB3Qc0SrZwy
 bSgQ9JidEHAWodarmrDVgwkuiu7XmmaeBSnQPqreddy/IdlnunSlxlX1/DF/d2nXsx
 mgUzWIas6fyNPy1FoKTbyLKMj2vqriWRd/9PcX/erAmeLcfp5QJ0Xy2Jm+L2SOxI0E
 AoFz1hQDexayDfr7IfyOnj6uQsD/zshJDHoU8kLrzff7sb4u4t46hzRTP9N+RI6XV9
 wR4QTza4xa8uA==
Date: Tue, 27 Oct 2026 01:22:27 -0700
From: Drew Fustini <fustini@kernel.org>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "sunilvl@oss.qualcomm.com" <sunilvl@oss.qualcomm.com>,
 "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "shankar.c@oss.qualcomm.com" <shankar.c@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "prajwal.n@oss.qualcomm.com" <prajwal.n@oss.qualcomm.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Message-ID: <auBfQwrhu8UJBaJi@thelio>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
 <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
 <95082036aaf5b0ed1bee69fc21fcbb18fd74d61f.camel@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95082036aaf5b0ed1bee69fc21fcbb18fd74d61f.camel@wdc.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
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

On Mon, Oct 26, 2026 at 11:56:38PM +0000, Alistair Francis wrote:
> On Fri, 2026-10-23 at 17:28 +0530, Sunil V L wrote:
> > On Thu, Oct 22, 2026 at 10:23 AM Alistair Francis
> > <Alistair.Francis@wdc.com> wrote:
[..]
> > > Why not add a vendor cpu/soc specific one to a vendor board? That
> > > way
> > > it actually model hardware instead of just providing the guest some
> > > made up information.
> > > 
> > Thanks for the feedback!
> > 
> > Just to make sure I understand your suggestion correctly: should we
> > avoid
> > defining a hardcoded cache topology for the generic CPU on virt, and
> > generate
> > PPTT cache information only for CPU models that provide an
> > appropriate cache
> > hierarchy?
> 
> It was a question
> 
> Something to keep in mind is that I (and others on the list) don't know
> all of the context that you know about this extension. So the cover
> letter and commit messages should describe **why** we want this.
> 
> Remember, I'm (and other on the list) are not part of RVI. We don't
> have the insight that you have. I also don't know what Drew is working
> on (I see some patches today, but before then I didn't know).
> 
> So, when sending patches please try to explain why we want them.
> 
> The question was, what use/value is there in faking some cache layout
> that doesn't exist? There might be a good reason, but that should be
> justified and explained.
> 
> > 
> > I can certainly omit the cache information for the generic CPU. The
> > consequence
> > is that Drew's CBQRI series, which requires cache information, would
> > need a
> > suitable CPU model before it can be used with virt. Drew, please
> > share
> > your thoughts.
> 
> Drew works at a company making it's own CPU, I would argue he can just
> use that :)

I could add caches for the Ascalon core complex in Atlantis but the
topology is pretty simple with just private L1 and shared L2. The
tt-atlantis machine is also device tree only, so it would not produce a
PPTT or RQSC table. A generic cpu with L1, L2 and L3 caches like Sunil
defined is ideal for testing my Qemu RQSC series [1], since RQSC needs
to reference cache IDs from PPTT. My plan is to rebase my RQSC series
once PPTT support lands and send the new revision as a non-RFC series
since RQSC has been ratified.

Qemu is important for testing the RISC-V QoS support in Linux [2],
because I'm not aware of any hardware yet that supports all 4 features
of CBQRI: capacity allocation, capacity monitoring, bandwidth
allocation, and bandwidth monitoring. Ascalon only supports capacity
allocation, and I have not seen public details from other vendors about
which CBQRI features have been implemented.

Thanks,
Drew

[1] https://lore.kernel.org/all/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/
[2] https://lore.kernel.org/all/20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org/

