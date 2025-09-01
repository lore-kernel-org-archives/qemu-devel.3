Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AECCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1yI-0006kx-6t; Mon, 01 Sep 2025 06:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ut1yF-0006k2-FI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:41:07 -0400
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ut1y9-000782-TC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:41:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.164])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cFllM0jyRz5x9Q;
 Mon,  1 Sep 2025 10:40:47 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.58; Mon, 1 Sep
 2025 12:40:46 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006b9bd2c1b-ccfd-4ec4-9a61-b4a0987e2eec,
 CAAE178DC29C5141E9BFB396468E1D399C164DD0) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 1 Sep 2025 12:40:40 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Mark Johnston <markj@freebsd.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Message-ID: <20250901124040.53166f30@bahia>
In-Reply-To: <12113631.YhV4tvpBIu@silver>
References: <aJOWhHB2p-fbueAm@nuc> <2602995.s6eulQLtdm@silver>
 <aKxcsmP6MI5p9OPe@nuc> <12113631.YhV4tvpBIu@silver>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: cbfd3aed-59ec-4bfd-ab69-6b01c81eb208
X-Ovh-Tracer-Id: 8659859135243393385
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleduleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffetffefleetvdevkeffiefhkeefgfffjefghfejvedvkedtkeeutdduvdeghfeunecuffhomhgrihhnpehqvghmuhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdeipdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmrghrkhhjsehfrhgvvggsshgurdhorhhgpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=gqjUpL9fgAszdT/kDQaagT3CtXC0PEPTmJv+Yxri8XU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1756723247; v=1;
 b=wOyrL1dOw1AL/W7VPFKDSNEhMPKeG8VRa+DAXxh0tJQ0Nb00wkvYgVYK6M2nXNXosluCTOw2
 Vsb3J+oHnjpq7KtCAXyph5Qh4O/znHNGDt7WA/eExXEmIqfd5vwRLetNLWzcyuk8vIT3/lfCTZN
 qAyX3tT4O4Bnk5TPqaJCf2CUvP1igTSFYb2n/H+H4dtRfEZ3Bss+Gquqx7r2V+4fVEG8WDYXBhn
 KiOadVF/eIket+GoPYxUZBpMd4N5+GV2uEiX0irczPsTEQlLd7Q/FAQlUwBMvBwBljca2lzvEGW
 zY0v90a5g+4RZLKekyJOc9XGqSTTr3lvJ/wmhn9VxhLRw==
Received-SPF: pass client-ip=188.165.58.48; envelope-from=groug@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 26 Aug 2025 14:34:45 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Monday, August 25, 2025 2:53:06 PM CEST Mark Johnston wrote:
> > On Thu, Aug 21, 2025 at 01:24:04PM +0200, Christian Schoenebeck wrote:
> > > On Wednesday, August 6, 2025 7:53:08 PM CEST Mark Johnston wrote:
> [...]
> > > Not forgotten. I just hoped there were other reviewers or testers in the
> > > meantime, but be it.
> > > 
> > > Like I said, I don't have FreeBSD system here to test this, so I am taking
> > > your word for now that you tested this and plan to bring this into QEMU
> > > when master re-opens for new features soon.
> > 
> > Thank you very much!
> > 
> > In case I missed somewhat, what testing would you typically do
> > otherwise?  So far I had run the QEMU test suite (which indeed found
> > some bugs in the initial version) and tried mounting a 9pfs share from
> > Linux and FreeBSD guests and doing a bit of manual testing.
> 
> Apart from QEMU's test cases, I also use guest systems running 9p as root file 
> system [1], run software compilations there among some things. That proofed to 
> be quite a useful test environment to spot edge cases, concurrency and 
> performance issues and such.
> 
> [1] https://wiki.qemu.org/Documentation/9p_root_fs
> 
> Greg was running some general purpose file system stress test suite in the 
> past, but I currently can't recall what that was.
> 

Hi Christian and Mark,

I was running this in the guest :

https://github.com/pjd/pjdfstest

Cheers,

--
Greg

> > > If you have some time to adjust the commit log message above, that would
> > > be
> > > great, otherwise I can also handle this on my end later on. Looks like
> > > that
> > > comment is not adjusted for v2 yet (i.e. "user." and not mentioning
> > > "system.").
> > 
> > Here's an amended commit log message.  Please let me know if this is
> > better submitted as a v3.
> > 
> > commit b79bf1b7d42025e3e14da86a7c08d269038cd3ed
> > Author: Mark Johnston <markj@FreeBSD.org>
> > Date:   Wed Jul 16 20:32:05 2025 +0000
> > 
> >     9pfs: Add FreeBSD support
> > 
> >     This is largely derived from existing Darwin support.  FreeBSD
> >     apparently has better support for *at() system calls so doesn't require
> >     workarounds for a missing mknodat().  The implementation has a couple of
> > warts however:
> >     - The extattr(2) system calls don't support anything akin to
> >       XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> >     - Attribute names cannot begin with "user." or "system." on ZFS, so
> >       these prefixes are trimmed off.  FreeBSD's extattr system calls sport
> >       an extra "namespace" identifier, and attributes created by the 9pfs
> >       backend live in the universal user and system namespaces, so this
> >       seems innocent enough.
> > 
> >     The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> >     filesystems.
> > 
> >     Signed-off-by: Mark Johnston <markj@FreeBSD.org>
> 
> Almost. Maybe something like this to make it a bit more clear?
> 
> - Attribute names cannot begin with "user." or "system." on ZFS. However
>   FreeBSD's extattr(2) system supports two dedicated namespaces for these
>   two. So "user." or "system." prefixes are trimmed off from attribute
>   names and instead EXTATTR_NAMESPACE_USER or EXTATTR_NAMESPACE_SYSTEM
>   are picked and passed to extattr system calls instead accordingly.
> 
> /Christian
> 
> 



-- 
Greg

