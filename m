Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C821CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkJj-00085S-5o; Mon, 22 Jun 2026 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbkJh-00084s-AP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbkJf-0000hz-EE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782156498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VG7BnIPX3GQnSpBekFs0Zvg/+BJtTZ/jPlj0eSfGCtY=;
 b=Aau7LbsDxukCDXTVyej4126G9F8g7sFzU3d6vfvEdMxQ3Vw1berj8o0i2HIdJWDZneaLqR
 CLuoc6By6TKH6IpqGtqKdr0AMq1VYlluNpOTReFnGbfaRGoGKIb7ZSc0Nd+23pi/rjXEo+
 9QJC+fQRAbMxzjF0v6UyMiEK9QN0XBI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-vjCS-FuFM3OraAAiRdyAgg-1; Mon, 22 Jun 2026 15:28:16 -0400
X-MC-Unique: vjCS-FuFM3OraAAiRdyAgg-1
X-Mimecast-MFC-AGG-ID: vjCS-FuFM3OraAAiRdyAgg_1782156496
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-519899aa6bfso89065101cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782156496; x=1782761296; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VG7BnIPX3GQnSpBekFs0Zvg/+BJtTZ/jPlj0eSfGCtY=;
 b=XlFtq+1kLEz29/8A15RE4H5I/kSy0bHs/Po2nwpILqnDfIUO3/aliTrVXBrWhqSZWI
 p0ZULl8eyEKqdw4cxJMUVPf77ZhpX67fPvmb3M46kF9cmKuX/r6+uCMGlNdIug+o3yvr
 JO8o2dc3Ti3OqeoVIkpHEamezV98A1zSFc2/U1hPAyANKPLoXr7VPv86kMgCAugv9qYy
 zZcgBM5j8U9tH9X3OamasdgKSuT2U4irufmBcatFFQ8xi1t+yBkUH9ILBra9D7YWdKOD
 L9BwDzftDf9hDNpbnXUzOdvM2mZrNaiXO0ZnYZUFLlb78veXR1wLtRVnK6nH222e+s93
 BhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156496; x=1782761296;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VG7BnIPX3GQnSpBekFs0Zvg/+BJtTZ/jPlj0eSfGCtY=;
 b=CXGQLf0V8kY2OVxmqJVCstHn9shcIA4bT9etLL6q0rPM6eGD+E3E7Bvwtjx6PYkaAy
 quC2xii6Rl4PPHxSnexN/cGhTjAC00CnPJGCXKx607W3p3CgyuoepMx5S2yWOlgDvB9H
 K5RIGdwWBqi2HHOrUuonnpMCVY5Co1TB+r8DSedBHBUFtC4O3W8cxBBQqHtX8lBRiwkP
 g2pbH/+FYt3JrKDOKRz1vaLM3y/bv9PSoQk9ltc18HicDHBFcIhhPuQZb2nZF9BnPhS1
 kqM69cBphhgMorS/I45JDuJaFMDjd2XSBOTwmao4X1QugKoWbD737AP6M53Rozxn3tqr
 FTMQ==
X-Gm-Message-State: AOJu0YxbzTYCr3yremPr+Cm3GqwR5fxNgrQ+ZOuTWtgPNzgEoLTIac29
 DFqFwHvznEhjgqT3qqdvwq1WraRb75vlkkif5TVPx9HoCwgSSFq0XHCHfqY44a2Z/5UF0KEG4Lt
 Tvz7lwO76PKcTvdtRgesBIpuhSYXKPBoQi4i+CUHrPcEd0xapQp21UmlJ
X-Gm-Gg: AfdE7cl5Zrfr49eaZZ+ybBDBR5jTuFXnEhoayzKiSXlloLLhhrUI9JpMbw9ow7eB+Qe
 pIfE3MiSF+jpA5NJ2RtJCSo0pyUdqhmx/PnaTcA7UgknaOCPLgoxpgDlo7UyatL8ql9PpxbN8Lm
 ohzsDd0jvIV5ozz+NvehwJNRzK4RBKe+GpWqvvGsIxkP5BA49K31B2+/BUhqRpPRaFzhtk9m/s4
 qJJua12U0YJN5Hd5yQSA43nNXK5U4IRWuTh1pbAdY+RYacSCW25ZKEU3anIu/5t/crBJUNT504M
 uEdFXkwn+6ISEC0cgI6/OvlON7e/ZsETDJ2575XeATQqGJJPXFtYWf+f5VA947Ok5Pzj2/UP/zu
 KXx3vQ9THu1YS8Y2YhqJVzSXA/sidTbo7y94lF5pmAKlDXFrFN0mrBQVe3ObDV1UqsTzGp+bI
X-Received: by 2002:a05:622a:1492:b0:517:7baa:c57f with SMTP id
 d75a77b69052e-519e4e4e50bmr239733121cf.54.1782156495802; 
 Mon, 22 Jun 2026 12:28:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1492:b0:517:7baa:c57f with SMTP id
 d75a77b69052e-519e4e4e50bmr239732491cf.54.1782156495119; 
 Mon, 22 Jun 2026 12:28:15 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51a9bca9sm5745081cf.19.2026.06.22.12.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:28:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:28:12 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <ajmMzMAXay65Sl7U@x1.local>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
 <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 22, 2026 at 03:53:33PM +0400, Marc-André Lureau wrote:
> Hi Peter
> 
> On Fri, Jun 19, 2026 at 7:13 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Thu, Jun 4, 2026 at 5:46 PM Marc-André Lureau
> > > <marcandre.lureau@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This is an attempt to fix the incompatibility of virtio-mem with confidential
> > > > VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> > > >
> > > > The first patches are misc cleanups. Then some code refactoring to have split a
> > > > manager/source. And finally, the manager learns to deal with multiple sources.
> > > >
> > > > This has been tested together with the Linux kernel series from
> > > > Zhenzhong Duan [1] for TDX guests.
> > > >
> > > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> > >
> > > Can the patch 1-11 be queued or are we missing something?
> > > (RFC patch 12 can be dropped for now)
> >
> > Likely yes.. one thing to double check with you before I do: We don't need
> > the kernel series, do we?  Since when unplug, I expect with the truncation
> > approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE then
> > unaccept is done (?).
> 
> > Say, what happens if we run QEMU with this series applied, but without the
> > kernel series?
> 
> The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
> will have KVM_RUN return EIO, and finish into assert (while tearing
> down ioeventfd).

Could you elaborate a bit more on why ACCEPT would fail?

I used to ask the event flow here:

https://lore.kernel.org/qemu-devel/agTjb3M8ElUAlfp1@x1.local/

If AUG existed, then why ACCEPT would fail?

PS: I didn't read a lot of what a Linux guest would do; I know there're
some lazy accept approach, but IIUC it's only a matter of time to ACCEPT,
not correctness.  My understanding is if we properly notify these new slots
with AUG, then it should be able to ACCEPT?

> 
> > What confused me a bit is the dependency of this series v.s. the kernel
> > one.  It seems to use different approaches, but then I don't understand why
> > this series was tested with the kernel change.
> 
> My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
> That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
> doesnt currently control. I don't know whether this is then
> redundant/needless with qemu doing discard on the guest_memfd..

The problem is if this series depends on the kernel series, should we then
wait for the kernel solution be accepted first in case it'll change?

But obviously I still don't yet fully understand how this whole thing
works.. :(

Thanks,

-- 
Peter Xu


