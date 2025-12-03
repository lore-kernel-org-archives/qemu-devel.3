Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA7CD12D56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnO7-0007Qd-Ce; Wed, 03 Dec 2025 08:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vQnNz-0007Pd-Nh; Wed, 03 Dec 2025 08:59:17 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vQnNx-0001z0-Ou; Wed, 03 Dec 2025 08:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=cYaQAF68DgxyikWt+xj9R3RPLh65hX0qP7Cq2HXAxjI=; b=YSzn0x0n8YXuhYHN
 96ymWEUo7ZfIUg/PzUHMj1IY0DWsCeFRw/fHYS6FJJpSM1905imUYgGRHMsItamohbeH6UufWZGkz
 mMVen947rVYaRkx5rPH2uBDOWJ+JWmmIbE80sMJBk8OBz8x3mP2tC7BxLk9z2wv5STSMbUZeU3ZhA
 w/HDzlkiEGfKwxxW8LNRtLcvUjPZyS2RvL/wwrelHJHXjmTVEMLt1loeBD5gi07+kEcziz2N0Q8eD
 O5s1jUfL3e84Pk0pxZxVRtC04XoJoBRM9+CH4gr6UIrd2DzmAXm8VkbquFzsnXe2iV5cJq0R7mXbu
 LswEnuNEsbZSp5kgog==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vQnNt-00000007qcG-1NFf;
 Wed, 03 Dec 2025 13:59:09 +0000
Date: Wed, 3 Dec 2025 13:59:09 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 thuth@redhat.com, pbonzini@redhat.com, jak@jak-linux.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
Message-ID: <aTBCLbDbpXgkTLHr@gallifrey>
References: <20251203131511.153460-1-dave@treblig.org>
 <87a4zzu230.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4zzu230.fsf@draig.linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 13:30:44 up 37 days, 13:07,  3 users,  load average: 0.00, 0.00, 0.00
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

* Alex Bennée (alex.bennee@linaro.org) wrote:
> dave@treblig.org writes:
> 
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> >
> > -M is used heavily in documentation and scripts, but isn't actually
> > documented anywhere.
> > Document it as equivalent to -machine.
> >
> > Reported-by: Julian Andres Klode <jak@jak-linux.org>
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >  qemu-options.hx | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index fca2b7bc74..ec92723f10 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> >  #endif
> >      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
> >      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
> > +    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
> >      "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
> >      QEMU_ARCH_ALL)
> >  SRST
> > @@ -179,6 +180,9 @@ SRST
> >  
> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
> >  
> > +    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
> > +        Define an SGX EPC section.
> > +
> 
> This seems unrelated.
> 
> >      ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
> >          Define cache properties for SMP system.
> >  
> > @@ -208,12 +212,10 @@ SRST
> >  ERST
> >  
> >  DEF("M", HAS_ARG, QEMU_OPTION_M,
> > -    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
> > -    QEMU_ARCH_ALL)
> > -
> > +    "-M              as -machine\n", QEMU_ARCH_ALL)
> >  SRST
> > -``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
> > -    Define an SGX EPC section.
> > +``-M``
> > +    as -machine.
> 
> Did we have a merge conflict at some point that messed things up?

It's not clear - it was the only option hanging around in -M and it was
already appearing wrong in the man output.
I wondered if it was some requirement to have *something* in the -M
definition so thought it best to move it at the same time.

Dave

> >  ERST
> >  
> >  DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

