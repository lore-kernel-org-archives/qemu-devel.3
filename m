Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0B4CF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 06:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssybU-0007g1-0E; Tue, 24 Sep 2024 02:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssybR-0007el-Fg
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 02:00:49 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssybP-0003ii-Qk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 02:00:48 -0400
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C15CF1140348;
 Tue, 24 Sep 2024 02:00:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Tue, 24 Sep 2024 02:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727157646; x=
 1727244046; bh=vf/4OwJcWki6RJWwuBu/6MXyDwZMb0Yb3kV4uOludTk=; b=p
 HuzeqroOQR9iZ8I/7r4P6HBBpn95eiyYwYQc7zjr6joKdJKJSplOVkzedQtgn2i1
 8qeb0LCXqtu1KnfXWcPxwwIAFORMrSWU1/hfOx+cnKqULunsCfH5I4a64jzPaiC2
 /wyeV8HEc3kagRBk7zI5vfCkQ1ucSXhOnqsqhdN1h4aoWgC53krwTmdLes0/kNIb
 8RQR8/iL+6FFFn6tWfXApfio94Ryytjiot1gAoEEBh5r64VNXtNKSz2mRJx0kkOG
 0V3m0Ij/6cNvEmySoD/LEfTsTdlYTq8tJsdb+VuIXbjuywCNRQ3oZQQ+fEvaJ1J5
 hwGKrRlQxW/sQoalfqydg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727157646; x=1727244046; bh=vf/4OwJcWki6RJWwuBu/6MXyDwZM
 b0Yb3kV4uOludTk=; b=ennakQVSO3SvmoaIoAyCYOKx48j4cV5KKLwrLHJGqlS0
 v4LCe3bh/ScIX1fGA2jEABvTaRHkWXqj/pgTDrh4MTjf8SEkUcmHrjwGjfml2ihB
 cDNbYIze48AZkWigAfCLuVBijTzOo3/Ws9vgTUTa4oZ72P1AN7T2wKnIe5GD/1K+
 w9mh6j+bqeiMkuAGH2JkpejQjSVfeYvUG7FvStPZV5j4foNgVWrLDYwGB3ONy7Kz
 AwE7cnUWOOElIlCkNepAKUxbDvUG49Kf9oJE7TkmvbKMLaad88orXtQwLRs3Od0b
 wOTsVZWCIyb5ziZvHJ4I8BelnBbQPkJNO7Pk+depgQ==
X-ME-Sender: <xms:jlXyZtQr9h24Z8kHrN1HQh1kVbhEkFGrtNCyNgTN83VY2xfMr5q80A>
 <xme:jlXyZmw9l3T9Lp6xndYWC2v13SFsOYhOm8yHRPDKstgUrOrrpHItbE5kKjnkGLuYg
 zdLa9zqh4YWRw_Br2I>
X-ME-Received: <xmr:jlXyZi2HhMRqJH1FeifCn86GA99SU3KWzRBd9n7CWPqPE4A3PvqneXKUwr1JeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
 fukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcu
 oehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeevjedtje
 etveefhfffheeivdffvdduledviefgkeefveeltdeiteffheeggefgudenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvg
 hvrghnthdrughkpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprh
 gtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:jlXyZlBoP6YOAMq6v18hXeXZL0t0Q41Xk3m1REUIvtYtXF6DEUCWaA>
 <xmx:jlXyZmgOu4ZFpzxNvfxXUGQIUOMjTjZ_kv2gQLe5eRN3guu9gypTTA>
 <xmx:jlXyZpouXWXRmXETj3RYXK80F1_MXkMzM-WqHbRqPEL6Z2Er39UF4g>
 <xmx:jlXyZhjFINWfOP3HZYV8aztUu5BDQtnr_cgg0RTPgFxokJnj2yQrrQ>
 <xmx:jlXyZoZo-6GtGzNiIKBdEHeRh5ZRMlwky917at_LOxnmFuKsBd3N3iwj>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:00:46 -0400 (EDT)
Date: Tue, 24 Sep 2024 08:00:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: clear masked events from the aer queue
Message-ID: <ZvJVjX6mfUfx73iV@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240906052849epcas5p2602787ff0700a8feca81ad173f957ffb@epcas5p2.samsung.com>
 <20240905235859.3416741-1-arun.kka@samsung.com>
 <ZvEfGe6rSCuUEvie@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvEfGe6rSCuUEvie@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Sep 23 09:56, Klaus Jensen wrote:
> On Sep  6 05:28, Arun Kumar wrote:
> > clear masked events from the aer queue when get log page is issued with
> > rae=0 without checking for the presence of outstanding aer requests
> > 
> > Signed-off-by: Arun Kumar <arun.kka@samsung.com>
> > ---
> 
> Hi Arun,
> 
> Thanks, LGTM. One small nit below.
> 
> >  hw/nvme/ctrl.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 127c3d2383..85039779da 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -1649,9 +1649,16 @@ static void nvme_smart_event(NvmeCtrl *n, uint8_t event)
> >  
> >  static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
> >  {
> > +    NvmeAsyncEvent *event, *next;
> >      n->aer_mask &= ~(1 << event_type);
> >      if (!QTAILQ_EMPTY(&n->aer_queue)) {
> 
> It's safe to remove the QTAILQ_EMTPY check as well.
> 

I dropped the empty check and picked this up for nvme-next, thanks!

