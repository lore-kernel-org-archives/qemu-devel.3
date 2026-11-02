Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD73606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=VuwX13eh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO0DO-0003di-U7; Mon, 02 Nov 2026 17:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xO0DN-0003dI-AS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 17:09:17 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xO0DK-0000CZ-UW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 17:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=V+FuXwgBaZ6LIXBLvf/6VZ1j11yEQbvqEZEzaHTTm3o=; b=VuwX13ehaKPA7Euf
 h9APqcRij/RsuKgLd5jRZ8uQSXbNvY3FohPlnhVmk8KhisoEXpi2WSCqwZ5tPSavs1Q19wFNEhsiw
 b1xitJ+AUh+BiJtkkeKTvc9I03NK/wrRhE44C7mV+isXTgzqD6CBPdFajlluc/8ad08jNyeysUm9j
 rblXqT4cQPPk5Qwey6a470aiJ+5dwy9DQzWlZqRtg+sR7u3bWN7PBU1q51wEE8QtC8eCmzXBSknSX
 PQXjQdJtJWsdwhacxa8NqiOYQeoc0cqXMxrw4LrQ2Omgex+d4M9c2qTI2QDGv5Q/GSYAJoKQD8lnQ
 y0k2NT5eUmeB1CxctQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xO0DE-000000001ds-3F15;
 Mon, 02 Nov 2026 22:09:08 +0000
Date: Mon, 2 Nov 2026 22:09:08 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org
Subject: Re: Qemu qurt and fastrpc?
Message-ID: <aukKBIeeShQaQD6M@gallifrey>
References: <aue3t9EKkoeb0FnG@gallifrey>
 <C972F7F0-CAAD-4BC3-98E6-0A1A4CD70ECA@unpredictable.fr>
 <751b1263-850d-448b-a2b6-27f2876d4e50@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <751b1263-850d-448b-a2b6-27f2876d4e50@oss.qualcomm.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.115+deb13.1-amd64 (x86_64)
X-Uptime: 21:57:42 up 36 min,  3 users,  load average: 0.06, 0.06, 0.04
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Brian Cain (brian.cain@oss.qualcomm.com) wrote:

Hi Brian, Mohamed,
  Thanks for your replies.

> On 11/1/2026 5:41 PM, Mohamed Mediouni wrote:
> > 
> > > On 1. Nov 2026, at 23:05, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> > > 
> > > Hi Brian,
> > >   I tried your hexagon support booting qurt images, very nice!
> > > I did:
> > > 
> > >   ./qemu-system-hexagon -M virt  -kernel ./qccdsp8380.mbn -nographic
> > > 
> > > and got something believable.
> > > 
> > >   Do you have glue that lets you run comms to the emulated qurt via
> > > fastrpc in the same way that, say a Llama running on a normal
> > > Linux host would?
> > >   It feels useful for debugging/watching what maths kernels are
> > > doing.
> > Hi,
> > 
> > There’s no FastRPC… however:
> 
> Until we have heterogeneous TCG + ARM apps CPUs + SMMU + SMEM/cmd-db + DSP
> machine it's not likely to support FastRPC as-is.  This seems like it's
> quite a ways away, unfortunately. But we could conceivably craft something
> that resembles glink/fastrpc using ivshmem + doorbells.  That seems very
> do-able.

Yeh it was that kind of hack I was wondering about; although just specifying
the Hexagon Qemu's guest memory as backed by a shared-memory file (like vhost-user)
would then let another process (i.e. the fastrpc library) read/modify the hexagon
ram.  So then the question is what doorbell-like things were needed.

My thoughts were something like a modified fastrpc library that spawned the qemu
(or connected to one), mmap'd the qemu's hexagon ram and then did...something to
do doorbell like things (e.g. maybe using qmp to read/write to the guest with
no change to the guest).
But no urgency etc, I might have a play.


> > You can download the Hexagon SDK from https://softwarecenter.qualcomm.com/catalog/item/Hexagon_SDK
> > 
> > That comes with a version of QuRT that is semi-hosted as runelf.pbn.
> > 
> > A working QuRT loading on top of that (w/ a semi-hosted -M option):
> > 
> > -kernel /opt/Hexagon_SDK/6.7.0.0/rtos/qurt/computev75/sdksim_bin/runelf.pbn \
> > -append '/opt/Hexagon_SDK/6.7.0.0/libs/run_main_on_hexagon/ship/hexagon_toolv19_v75/run_main_on_hexagon_sim -- libmain.so'
> 
> Indeed - sorry, should have some docs on how to do this coming Real Soon
> Now.  But that's the gist of it.

This one is a little less interesting from my side, I was more interested
in using the qemu as a way to see what was going on inside a running
fastrpc app.

> > The QEMU on Hexagon inside of the Hexagon also (used to) comes with an oddball QEMU Hexagon
> > version inside the package that has HMX emulation as a closed-source module, but that’s a
> > separate story that is going to be wound down thankfully.
> > 
> > If you don’t want to use the Hexagon SDK, there’s another option through hexagon-hypervisor which
> > has a very partial QuRT compat story. Or outright Linux on Hexagon which works too…
> > 
> > The (modern) kernel tree for Linux on Hexagon being at https://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux.git/log/?h=hexagon
> 
> Yeah, now that we have a decent basis in QEMU, I'll work on upstreaming
> those kernel changes.  Some have been reviewed on-list already.
> 
> 
> > A pre-built artefact exists at https://artifacts.codelinaro.org/ui/native/codelinaro-toolchain-for-hexagon/23.1.2/qcs6490-cdsp/ with the booter at https://artifacts.codelinaro.org/ui/native/codelinaro-toolchain-for-hexagon/23.1.2/hexagon-hypervisor/
> 
> The h2 hypervisor is also available as a prebuilt rom in QEMU now, which is
> convenient for booting linux.  That h2 won't forward the QEMU-synthesized
> device tree pointer yet though :( - so it's probably easiest to build your
> kernel with its own internal DTB.
> 
> 
> > >   (Not urgent, I'm just trying to get my head around it on my
> > > X1 laptop)
> 
> If you want an X1 CDSP machine in QEMU - let me know.  We can include one in
> 12.0.  We did include the X2 CDSP - it's SC8480XP.

For me that would probably be useful only with the hack mentioned at the top
to allow a fastrpc use; but given the number of X1's out there it's probably
not a bad idea.

Thanks again.

Dave

> 
> > > 
> > >   Thanks in advance,
> > > 
> > > Dave
> > > -- 
> > > -----Open up your eyes, open up your mind, open up your code -------
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > > \        dave @ treblig.org |                               | In Hex /
> > > \ _________________________|_____ http://www.treblig.org   |_______/
> > > 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

