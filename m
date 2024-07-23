Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8117CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWK8S-0002f9-Ah; Tue, 23 Jul 2024 14:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWK8M-0002Hk-5x
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWK8F-0003t2-BR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721758853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CW+DLmFs3Dm4MuLIbq/di9q7c20LsMFnV8+gxYu1EDY=;
 b=QAqnh6pbQaFOf1Ngr0gLvguZtxCDKZvJZSYxgM82BUQcjRhClMf9f3Ppru5rUA7fcGueYg
 m81HqG0CelWKUa1Fg7H5bm1Hg4YZ26986A04JLudNDGfnA/yLUEuEXV7NwNyM3LEsW37xV
 aniT88wtPwO7wn0tWVysSAO2b6yCAw4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--XWgfYJ4MF6q9QcahSB0aw-1; Tue, 23 Jul 2024 14:20:49 -0400
X-MC-Unique: -XWgfYJ4MF6q9QcahSB0aw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b7b1d79bacso12525276d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758849; x=1722363649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CW+DLmFs3Dm4MuLIbq/di9q7c20LsMFnV8+gxYu1EDY=;
 b=JPqFmS3Zea1DhR3Fzv4J9vDPjSJxFEbQ6Q46TuBds0aY69iTbdW7SZH0HB3DawQsm5
 TH4+c84wMcWZoFz0+oomFJUolVOmbWlsQBa3mjy4Ax+4cOBtuyIHsSKWuj7/XLPVfYYE
 jpbQhT/9zbqKZa1Rz3TVDozToGq56L/YTpguKxgdcgfI9FKb7LP4GGmMmhX41zHKz+qk
 AQAwFfUv3TlqiqGLSbpAXO/Oql3ECWlU2Y49lQc4BYOva/yyCLjzgKz9/d9iVfmd9NNw
 /gv9WSIGlcoDWX7nEazVX7n3SFubp/PrFRbJfOnleLTlKNUaRi5dkKFohvNeE97ZNoBX
 5c2w==
X-Gm-Message-State: AOJu0YysFvoF/Jt2WYhSiKbhslLrSQPlrF7Z0WRMuXscq262H9NaA6+p
 0JJ0Ce6BnSj8D9l6++TO7eLMeK5SfBIWR6FzfVc7ZdSm4ad2UCfWc1P+vIrSgAn95VBfBdCCs8Y
 hQqJMqnDGAIyL6Sc1kp7BsM9+r5vnZZj+3s2EW7QDAsE5hwxP+tf/a94fKnTJ
X-Received: by 2002:a05:622a:1b9e:b0:44e:d016:ef9 with SMTP id
 d75a77b69052e-44fa5387fb4mr85634651cf.9.1721758848742; 
 Tue, 23 Jul 2024 11:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFLopSp6C08NVdZ/UAHsDW4/CrY2yOQ+FRZTyHGzJah+Sq5QmDRzwZL+7xn1rP7sWXWV2VUA==
X-Received: by 2002:a05:622a:1b9e:b0:44e:d016:ef9 with SMTP id
 d75a77b69052e-44fa5387fb4mr85634421cf.9.1721758848181; 
 Tue, 23 Jul 2024 11:20:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cd06244sm46840891cf.34.2024.07.23.11.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:20:47 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:20:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 0/9] migration/multifd: Remove
 multifd_send_state->pages
Message-ID: <Zp_0fFCJ3Ca2MvuV@x1n>
References: <20240722175914.24022-1-farosas@suse.de> <Zp65zvb9oy9my-qY@x1n>
 <87msm9yy77.fsf@suse.de> <Zp7HH6-WeYKXQ-fy@x1n>
 <87a5i9yvhf.fsf@suse.de> <Zp7k4wF1W6Fzp7YW@x1n>
 <8734o0yp6n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734o0yp6n.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 23, 2024 at 02:48:48PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jul 22, 2024 at 06:20:28PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Jul 22, 2024 at 05:21:48PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > On Mon, Jul 22, 2024 at 02:59:05PM -0300, Fabiano Rosas wrote:
> >> >> >> Hi,
> >> >> >> 
> >> >> >> In this v2 I took Peter's suggestion of keeping the channels' pointers
> >> >> >> and moving only the extra slot. The major changes are in patches 5 and
> >> >> >> 9. Patch 3 introduces the structure:
> >> >> >> 
> >> >> >> typedef enum {
> >> >> >>     MULTIFD_PAYLOAD_NONE,
> >> >> >>     MULTIFD_PAYLOAD_RAM,
> >> >> >> } MultiFDPayloadType;
> >> >> >> 
> >> >> >> struct MultiFDSendData {
> >> >> >>     MultiFDPayloadType type;
> >> >> >>     union {
> >> >> >>         MultiFDPages_t ram;
> >> >> >>     } u;
> >> >> >> };
> >> >> >> 
> >> >> >> I added a NONE type so we can use it to tell when the channel has
> >> >> >> finished sending a packet, since we'll need to switch types between
> >> >> >> clients anyway. This avoids having to introduce a 'size', or 'free'
> >> >> >> variable.
> >> >> >
> >> >> > This at least looks better to me, thanks.
> >> >> >
> >> >> >> 
> >> >> >> WHAT'S MISSING:
> >> >> >> 
> >> >> >> - The support for calling multifd_send() concurrently. Maciej has this
> >> >> >>   in his series so I didn't touch it.
> >> >> >> 
> >> >> >> - A way of adding methods for the new payload type. Currently, the
> >> >> >>   compression methods are somewhat coupled with ram migration, so I'm
> >> >> >>   not sure how to proceed.
> >> >> >
> >> >> > What is this one?  Why compression methods need new payload?  Aren't they
> >> >> > ram-typed?
> >> >> 
> >> >> The data we transport is MultiFDPages_t, yes, but the MultiFDMethods are
> >> >> either nocomp, or the compression-specific methods
> >> >> (e.g. zlib_send_prepare).
> >> >> 
> >> >> How do we add methods for the upcoming new payload types? I don't expect
> >> >> us to continue using nocomp and then do "if (ram)... else if
> >> >> (device_state) ..." inside of them. I would expect us to rename
> >> >> s/nocomp/ram/ and add a new set of MultiFDMethods for the new data type
> >> >> (e.g. vfio_send_prepare, vmstate_send_prepare, etc).
> >> >> 
> >> >> multifd_nocomp_ops -> multifd_ram_ops // rename
> >> >> multifd_zlib_ops   // existing
> >> >> multifd_device_ops // new
> >> >> 
> >> >> The challenge here is that the current framework is nocomp
> >> >> vs. compression. It needs to become ram + compression vs. other types.
> >> >
> >> > IMHO we can keep multifd_ops[] only for RAM.  There's only send_prepare()
> >> > that device state will need, and so far it's only (referring Maciej's
> >> > code):
> >> >
> >> > static int nocomp_send_prepare_device_state(MultiFDSendParams *p,
> >> >                                             Error **errp)
> >> > {
> >> >     multifd_send_prepare_header_device_state(p);
> >> >
> >> >     assert(!(p->flags & MULTIFD_FLAG_SYNC));
> >> >
> >> >     p->next_packet_size = p->device_state->buf_len;
> >> >     if (p->next_packet_size > 0) {
> >> >         p->iov[p->iovs_num].iov_base = p->device_state->buf;
> >> >         p->iov[p->iovs_num].iov_len = p->next_packet_size;
> >> >         p->iovs_num++;
> >> >     }
> >> >
> >> >     p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
> >> >
> >> >     multifd_send_fill_packet_device_state(p);
> >> >
> >> >     return 0;
> >> > }
> >> >
> >> > None of other multifd_ops are used.
> >> 
> >> There's also a conditional around device_state when calling
> >> ->recv(). That could seems like it could go to a hook.
> >> 
> >> https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com
> >
> > Actually that's exactly what I think is right.. it looks to me now that we
> > could bypass anything in MultifdOps (including recv()) but let device state
> > be a parallel layer of MultifdOps itself, leaving MultifdOps only for
> > compressors.
> >
> > And yeah, I still remember you just renamed it from recv_pages() to
> > recv()..  it's just that now when think it again it looks like cleaner to
> > make it only about pages..
> >
> >> 
> >> >
> >> > I think we can directly invoke this part of device state code in
> >> > multifd_send_thread() for now.  So far I think it should be ok.
> >> 
> >> It's not just that. There's also a check for "if (ram)" at every call to
> >> multifd_ops to avoid calling the ram code when doing the device
> >> migration. It would be way easier to just set noop functions for those.
> >> 
> >> static MultiFDMethods multifd_devstate_ops = {
> >>     .send_setup = noop_send_setup,
> >>     .send_cleanup = noop_send_cleanup,
> >>     .send_prepare = devstate_send_prepare,
> >>     .recv_setup = noop_recv_setup,
> >>     .recv_cleanup = noop_recv_cleanup,
> >>     .recv = devstate_recv
> >> };
> >> 
> >> I'm not saying this needs to be done in this series though. But I do
> >> think that's the correct design choice for the long term.
> >
> > Yes it should be separate.
> >
> > And what I meant is we don't need all these noops, but recv() keeps being
> > ignored just like above, then for sender side, right now it's:
> >
> >             ret = multifd_send_state->ops->send_prepare(p, &local_err);
> >             if (migrate_mapped_ram()) {
> >                 file_write_ramblock_iov();
> >             } else {
> >                 ret = qio_channel_writev_full_all();
> >             }
> >
> > VFIO can process device state in parallel, so:
> >
> >     if (ram) {
> >         ret = multifd_send_state->ops->send_prepare(p, &local_err);
> >         if (migrate_mapped_ram()) {
> >                 file_write_ramblock_iov();
> >         } else {
> >                 qio_channel_writev_full_all();
> >         }
> >     } else {
> >         // device state handling
> >         multifd_send_device_prepare(...);
> >         ...
> >         qio_channel_writev_full_all();
> >     }
> >
> > Then MultifdOps doesn't apply to device states.
> 
> To avoid getting into bikeshed territory, I think we should postpone
> this discussion until after Maciej's series is merged, so we can speak
> more concretely about the implications. It's easy enough to go from your
> suggestion to mine than the other way around, so let's leave at that.
> 
> I had it already written, so more of my reasoning below, if you're
> interested.

I never thought this is bikeshedding.. What we're discussing now is exactly
what should appear in Maciej's code, am I right?  I thought we should
figure it out before it's merged, if that's the case..

And whose suggestion isn't that important, IMO.  We simply try to discuss
this technically and reach a consensus.. no matter who proposed what.

> ======
> 
> We already have the send/recv threads structured in relation to what we
> do inside the hooks. You're just defining a function that's not a hook,
> but it has the same signature and responsibilities and needs to be
> called at the same moment.
> 
> I think the dissonance here is that you don't see the multifd thread
> code and the payloads (ram, device) as separate layers. Payload-specific
> code should not be at top level. Otherwise, it breaks any semblance of
> proper layering:
> 
> - payload code will have access to MultiFD*Params, which has a bunch of
>   control variables for the loop, the semaphores, etc. that should not
>   be touched;
> 
> - payload code ends up influencing the flow of the thread
>   function. E.g. when zero_copy_send used to dictate whether we'd have
>   separate IO for the packet or not.
> 
> - temporary variables needed by the payload code will have to be
>   declared inside the thread funcion, which makes tempting to use them
>   across payload types and also in the thread code itself;
> 
> - it creates doubt as to whether new changes go inside the hooks, in the
>   if/else or outside of it;
> 
> Think about how easy it has has been to review and merge the various
> compression features we had. It doesn't matter how much they mess up
> inside the hooks, it will never cause the dreaded "Memory content
> inconsistency at ..." error from check_guest_ram(). At least not in a
> way that affects other people. Now compare that with for instance the
> zero-page work, or even mapped-ram, that required a bunch of changes to
> the multifd control flow itself (e.g. all of the sync changes w/
> mapped-ram).

I think there's one issue where we only support one MultiFDMethods as of
now to be active, while the "clients" of multifd can be >1 from payload
POV.  It means I'm not sure how VFIO can provide a MultiFDMethods if it
will overwrite what should be there to define how to process RAM..

Then, we should logically allow VFIO migration to happen with RAM being
compressed with ZSTD/ZLIB/whatever, right?  The question is which
MultiFDMethods we should assign if they're the same layer in this case..

-- 
Peter Xu


