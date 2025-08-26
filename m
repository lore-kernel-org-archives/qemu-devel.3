Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50900CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 21:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur1fd-0003DA-Nb; Tue, 26 Aug 2025 17:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ur1fa-0003CX-SV
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 17:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ur1fX-0005Qi-V5
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 17:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756245450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eVLM+mI5GY7nNysu6o4MpvRQzAYYBnK/Zh/dyRPVleQ=;
 b=fQioLVnEnveaq0M2N/LUIwGzQrm0peH9SYzKvoRVw3xQSI0ggui6OuOHP1TU1K4b285KcD
 E3tdT0wjMVoriE93reMHyCSKDlEQ0ID34aS3fB9C2FU0bG1+WffIqMBdKpbvhBdiDwxiqz
 nTtPDEeB3L/OwXvxy3SeuDfS6k0GCng=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-p0JrN4RzNHC-85u1i70lGw-1; Tue, 26 Aug 2025 17:57:28 -0400
X-MC-Unique: p0JrN4RzNHC-85u1i70lGw-1
X-Mimecast-MFC-AGG-ID: p0JrN4RzNHC-85u1i70lGw_1756245448
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70d9eb2e970so126112176d6.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 14:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756245448; x=1756850248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVLM+mI5GY7nNysu6o4MpvRQzAYYBnK/Zh/dyRPVleQ=;
 b=M+VJ5CJo1SU6ivwWUPTQhodCTIcH2rI4PNHzLjQraTN/Yp/z8JfRKaY5nKNXLaE3JU
 CX2538Vgiig9RP5kf54QTOzFJlXlz5qCjJstMHc3Z/Mo7G9Jo32jm9BwRPudgCxlP93d
 +bfpnMKUZJc1zGyKZH9/UT/uilAAdC4bz6N4OKsHdDsyuLwaX5U7V74Nac/lWODMPl2T
 1d3aFeKcBg9BFg2fa0c4oWr/UOM+Qy4tVtlXE9OhAFqx9GpgPq6oIWbTD01YTr6EmOkC
 27cx5jg7TORxgsvTWXi9ZogQ55JbEFKSI5sEAbL7ADJ/ql3cA1lf6aYQSV68S0qfPuwP
 qx4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh+Jl4CY/jwWBE0k4m0IYWN4fKkE8zhoKKmr5YDjKmybfc6Zt3M544o19Nk51abFeeoPJv7CvekL2Y@nongnu.org
X-Gm-Message-State: AOJu0Yz7GzwAmZFsudbNvGoNG/o0qbYTBa8FztTm+riFHC4curPISjln
 GCxAfS+OKbRPo1w3eUTSIyghSabt63aqLjMrLJOdqEURb8Xbbh0niaak5nwDxpKobkAYH+CV33U
 Gs4xylZSXMGUzbjxrXToGTyyYitbhESIWHDnKRzxXIWokGlWwKjjvx+RM
X-Gm-Gg: ASbGnctLCdpU77wHs+f7/g7CPoF5bTmTlSuVatt8Q3MkS4heyQdeysPfREmi92vuiky
 dUTn/BXIRyRzQ1n19o7VE9DSTTpmkIsxOAX7U+wjGOWUwC0LLwmtToUUUDOG8fefzn5wfuU8HBS
 a8Y9VHubWyElid7dFq2SrZ3cV/1Y+TeixrH2pA3b/csQJtmf5lH2nolzYo2DQd9LpGTCLTdDVn9
 b2w6oRN5+VPj3uJMDYYnpSvffCyyPmQ+WXdQeYobVmNi8zvDvfmadr10MLdwIvJ8CmsRGuFvvvI
 g8Da92/9lYM9nElmE0VIQps0f7NjM04u
X-Received: by 2002:a05:6214:f2f:b0:709:895b:51b4 with SMTP id
 6a1803df08f44-70d97245902mr192674456d6.11.1756245448032; 
 Tue, 26 Aug 2025 14:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEWAwj+c0hayeRknKDfgnTpROfA77Jelo4oM3BBJUiWWDlFSo8Snjq1q23P+PnS5rCz67Vjg==
X-Received: by 2002:a05:6214:f2f:b0:709:895b:51b4 with SMTP id
 6a1803df08f44-70d97245902mr192674046d6.11.1756245447518; 
 Tue, 26 Aug 2025 14:57:27 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da7145ec7sm73534956d6.15.2025.08.26.14.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 14:57:26 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:57:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
Message-ID: <aK4tuhRfotpndpa8@x1.local>
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
 <aKctCjv8newNIX71@x1.local>
 <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
 <aKdizYeNGocXvTzv@x1.local>
 <CAFEAcA8dKu3mSuD=rJkwDPcvqQASsOpFPdpG4Ht59GrTb+AywA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8dKu3mSuD=rJkwDPcvqQASsOpFPdpG4Ht59GrTb+AywA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 26, 2025 at 06:45:43PM +0100, Peter Maydell wrote:
> On Thu, 21 Aug 2025 at 19:18, Peter Xu <peterx@redhat.com> wrote:
> > I remember I provided a draft somewhere during the discussion, anyway.. I
> > redid it, and attached a formal patch below that will contain the removal
> > of the mr->container check (plus auto-detach when it happens).  The hope is
> > this should work.. and comparing to the v8 of Akihiko's, it won't make MR's
> > own refcount any more complicated.
> >
> > If necessary, I can send a formal patch.
> 
> This patch seems to work, in that it fixes the memory-region
> related leaks I previously was seeing. Review comments below
> (which are only about the commit message and docs).
> 
> I also can't remember the details of the previous discussions about
> these patches, so I'm reviewing the one below essentially from
> scratch. Apologies in advance if we end up going back around
> a conversation loop that we've already had...
> 
> > Thanks,
> >
> > ===8<===
> > From f985c54af3e276b175bcb02725a5fb996c3f5fe5 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 21 Aug 2025 12:59:02 -0400
> > Subject: [PATCH] memory: Fix leaks due to owner-shared MRs circular references
> >
> > Currently, QEMU refcounts the MR by always taking it from the owner.
> >
> > It should be non-issue if all the owners of MRs will properly detach all
> > the MRs from their parents by memory_region_del_subregion() when the owner
> > will be freed.  However, it turns out many of the device emulations do not
> > do that properly.  It might be a challenge to fix all of such occurances.
> 
> I think that it's not really right to cast this as "some devices
> don't do this right". The pattern of "a device has a container MR C
> and some other MRs A, B... which it puts into C" is a legitimate one.
> If you do this then (with the current code in QEMU) there is *no*
> place where a device emulation can do a manual "remove A, B.. from
> the container C so the refcounts go down": the place where devices
> undo what they did in instance_init is instance_deinit, but we
> will never call instance_deinit because the refcount of the owning
> device never goes to 0.

It should still be able to reach zero if we skip the refcount of internal
MR subregions like what this patch does.

Said that, I think you're right..  the problem is we have object_deinit()
after object_property_del_all() (in object_finalize()), which means
memory_region_finalize() will be invoked before object_deinit()..  Then it
looks wrong now to delete subregions in a deinit() even if reachable,
because the MRs should have been freed..

> 
> Further, even if we had some place where devices could somehow
> undo the "put A, B... in the container so the refcounts go down
> correctly", it is better API design to have the memory.c code
> automatically handle this situation. "This just works" is more
> reliable than "this works if you do cleanup step X", because it's
> impossible to have the bug where you forget to write the code to
> do the cleanup step.

Fair enough.

> 
> > Without fixing it, QEMU faces circular reference issue when an owner can
> > contain more than one MRs, then when they are linked within each other in
> > form of subregions, those links keep the owner alive forever, causing
> > memory leaks even if all the external refcounts are released for the owner.
> >
> > To fix that, teach memory API to stop refcount on MRs that share the same
> > owner because if they share the lifecycle of the owner, then they share the
> > same lifecycle between themselves.
> >
> > Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
> > against its container, as long as they belong to the same owner.
> >
> > The latter is needed because now it's possible to have MR finalize() happen
> > in any order when they exactly share the same lifespan.  In this case, we
> > should allow finalize() to happen in any order of either the parent or
> > child MR, however it should be guaranteed that the mr->container shares the
> > same owner of this MR to be finalized.
> >
> > Proper document this behavior in code.
> >
> > This patch is heavily based on the work done by Akihiko Odaki:
> >
> > https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/devel/memory.rst |  9 +++++++--
> >  system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 43 insertions(+), 11 deletions(-)
> >
> > diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> > index 57fb2aec76..1367c7caf7 100644
> > --- a/docs/devel/memory.rst
> > +++ b/docs/devel/memory.rst
> > @@ -158,8 +158,13 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
> >  as soon as the region is made visible.  This can be immediately, later,
> >  or never.
> >
> > -Destruction of a memory region happens automatically when the owner
> > -object dies.
> > +Destruction of a memory region happens automatically when the owner object
> > +dies.  Note that the MRs under the same owner can be destroyed in any order
> > +when the owner object dies.  It's because the MRs will share the same
> > +lifespan of the owner, no matter if its a container or child MR.  It's
> > +suggested to always cleanly detach the MRs under the owner object when the
> > +owner object is going to be destroyed, however it is not required, as the
> > +memory core will automatically detach the links when MRs are destroyed.
> 
> I think we should not say "we suggest you always cleanly detach the MRs":
> instead we should say "you can rely on this happening, so you don't
> need to write manual code to do it".
> 
> The actual code changes look OK to me.

I'll send the patch out officially for review, with above point taken.

Akihiko, let me know anytime when you want to either add your SoB or take
over the ownership of the patch.  I'll be OK with it.

Thanks,

-- 
Peter Xu


