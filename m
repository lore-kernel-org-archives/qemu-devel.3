Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4EDCF9C59
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 16:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srgBh-0003Pk-Rq; Fri, 20 Sep 2024 12:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srgBg-0003PH-NY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srgBe-0003c1-O8
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726848527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZTEZ9UjZi+mk132GAgnDO4DMeGHxqjvKkV91AdRAuY=;
 b=S1Swvzxv7FOjeaUocyLrrAm61l/zZzat0aAPBzbBXenKtjPFKDASOYnhqmqD4GReMeX/hM
 h8FoGh3+8ejFYxAzNXHPnkJOwP0RyCAL8bAE7GDNNlY+g7ZwR6eIVE0+fFSy2BeYrwbVkE
 TcTPTa5u1IoX2MmBkNfgl78W263yaHs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-w-NQnbtEMbKn3g-3aVM-kg-1; Fri, 20 Sep 2024 12:08:46 -0400
X-MC-Unique: w-NQnbtEMbKn3g-3aVM-kg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9a6251df5so496228985a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 09:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848526; x=1727453326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZTEZ9UjZi+mk132GAgnDO4DMeGHxqjvKkV91AdRAuY=;
 b=tYh63F8Cxg9qE38jR4Kg6vi1Brx6pnVPCOSrhD19GGxLHpX/gsuJDTdLLs/dBd36Y4
 qXYO++BWoY/iuxNh3IUs1o9aSCzab69/QlREJPCd2HpGOd0v6NzD0vh7qdqDenJglslK
 glsrdcF3B3yJEaDvFv07F+a5t4p2zaRg73PNVT4itJxkl+tTHiRWytBahvsjwfbppuzb
 RQ001RUYc+VaDI47CofYtikzYD63cYpoMVH1dDMMg/68dGnjSOG4h5NhCWKxQWjePcaq
 0VUifquMsRZmS8hvbG+7USS1C/IJcaLMOX3mGOqJbzDnAaNNYs4oztJms6t+QMCqK1G0
 cHnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrAU2H02f98s1AeFnZESsQvP3DWoLUJ7NgHId3u7zFPfBVX7tyu4GDD8w7LJhWBEpyElVYoTPTP1i/@nongnu.org
X-Gm-Message-State: AOJu0YwtwUOBKjrGhu9RCZkrRKC5XYtjFJ6OVD+USw+ekPNtVZ6gecid
 F8+4nYzn/qs8r/EaFUX0aIPw3osVIe5G3+fT7aNnslmA3q5WYw69k8dCCgY4hQUhTbltF/PF4pu
 WOdbTusVrrOMp0UBBMdnQhtfsvp2RXVFFlr3HKRfMN++m8OVQ7XlY
X-Received: by 2002:a05:620a:1993:b0:7a9:a8c5:d492 with SMTP id
 af79cd13be357-7acb80ccc87mr517730985a.34.1726848525708; 
 Fri, 20 Sep 2024 09:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO2g/7v529/a89vAyngiTdnPMFV+Wsllk5ZWvWpVlYGa7roX5RGyYNGCdrTM7S6/2TiC8qSQ==
X-Received: by 2002:a05:620a:1993:b0:7a9:a8c5:d492 with SMTP id
 af79cd13be357-7acb80ccc87mr517726985a.34.1726848525255; 
 Fri, 20 Sep 2024 09:08:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb0808503sm194826285a.34.2024.09.20.09.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 09:08:44 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:08:42 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/17] migration: Add
 save_live_complete_precopy_{begin,end} handlers
Message-ID: <Zu2eCryj12zr_2PK@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
 <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com>
 <Zt83mWWlMomX4mRD@x1n>
 <fa64bf51-7fec-454b-b204-f92f5d06f731@maciej.szmigiero.name>
 <Zt9HuA3QtP0E93X1@x1n>
 <81dd1071-9285-415f-a334-3d8109e0a905@maciej.szmigiero.name>
 <ZuyPlyh0sCYPP7C2@x1n>
 <c90deba5-8f47-4a9c-b039-284b84fe7d19@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c90deba5-8f47-4a9c-b039-284b84fe7d19@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Sep 20, 2024 at 05:22:54PM +0200, Maciej S. Szmigiero wrote:
> On 19.09.2024 22:54, Peter Xu wrote:
> > On Thu, Sep 19, 2024 at 09:47:53PM +0200, Maciej S. Szmigiero wrote:
> > > On 9.09.2024 21:08, Peter Xu wrote:
> > > > On Mon, Sep 09, 2024 at 08:32:45PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 9.09.2024 19:59, Peter Xu wrote:
> > > > > > On Thu, Sep 05, 2024 at 04:45:48PM +0300, Avihai Horon wrote:
> > > > > > > 
> > > > > > > On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> > > > > > > > External email: Use caution opening links or attachments
> > > > > > > > 
> > > > > > > > 
> > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > 
> > > > > > > > These SaveVMHandlers help device provide its own asynchronous
> > > > > > > > transmission of the remaining data at the end of a precopy phase.
> > > > > > > > 
> > > > > > > > In this use case the save_live_complete_precopy_begin handler might
> > > > > > > > be used to mark the stream boundary before proceeding with asynchronous
> > > > > > > > transmission of the remaining data while the
> > > > > > > > save_live_complete_precopy_end handler might be used to mark the
> > > > > > > > stream boundary after performing the asynchronous transmission.
> > > > > > > > 
> > > > > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > > > > ---
> > > > > > > >      include/migration/register.h | 36 ++++++++++++++++++++++++++++++++++++
> > > > > > > >      migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
> > > > > > > >      2 files changed, 71 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > > > > > index f60e797894e5..9de123252edf 100644
> > > > > > > > --- a/include/migration/register.h
> > > > > > > > +++ b/include/migration/register.h
> > > > > > > > @@ -103,6 +103,42 @@ typedef struct SaveVMHandlers {
> > > > > > > >           */
> > > > > > > >          int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> > > > > > > > 
> > > > > > > > +    /**
> > > > > > > > +     * @save_live_complete_precopy_begin
> > > > > > > > +     *
> > > > > > > > +     * Called at the end of a precopy phase, before all
> > > > > > > > +     * @save_live_complete_precopy handlers and before launching
> > > > > > > > +     * all @save_live_complete_precopy_thread threads.
> > > > > > > > +     * The handler might, for example, mark the stream boundary before
> > > > > > > > +     * proceeding with asynchronous transmission of the remaining data via
> > > > > > > > +     * @save_live_complete_precopy_thread.
> > > > > > > > +     * When postcopy is enabled, devices that support postcopy will skip this step.
> > > > > > > > +     *
> > > > > > > > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > > > > > > > +     * @idstr: this device section idstr
> > > > > > > > +     * @instance_id: this device section instance_id
> > > > > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > > > > +     *
> > > > > > > > +     * Returns zero to indicate success and negative for error
> > > > > > > > +     */
> > > > > > > > +    int (*save_live_complete_precopy_begin)(QEMUFile *f,
> > > > > > > > +                                            char *idstr, uint32_t instance_id,
> > > > > > > > +                                            void *opaque);
> > > > > > > > +    /**
> > > > > > > > +     * @save_live_complete_precopy_end
> > > > > > > > +     *
> > > > > > > > +     * Called at the end of a precopy phase, after @save_live_complete_precopy
> > > > > > > > +     * handlers and after all @save_live_complete_precopy_thread threads have
> > > > > > > > +     * finished. When postcopy is enabled, devices that support postcopy will
> > > > > > > > +     * skip this step.
> > > > > > > > +     *
> > > > > > > > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > > > > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > > > > +     *
> > > > > > > > +     * Returns zero to indicate success and negative for error
> > > > > > > > +     */
> > > > > > > > +    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
> > > > > > > 
> > > > > > > Is this handler necessary now that migration core is responsible for the
> > > > > > > threads and joins them? I don't see VFIO implementing it later on.
> > > > > > 
> > > > > > Right, I spot the same thing.
> > > > > > 
> > > > > > This series added three hooks: begin, end, precopy_thread.
> > > > > > 
> > > > > > What I think is it only needs one, which is precopy_async.  My vague memory
> > > > > > was that was what we used to discuss too, so that when migration precopy
> > > > > > flushes the final round of iterable data, it does:
> > > > > > 
> > > > > >      (1) loop over all complete_precopy_async() and enqueue the tasks if
> > > > > >          existed into the migration worker pool.  Then,
> > > > > > 
> > > > > >      (2) loop over all complete_precopy() like before.
> > > > > > 
> > > > > > Optionally, we can enforce one vmstate handler only provides either
> > > > > > complete_precopy_async() or complete_precopy().  In this case VFIO can
> > > > > > update the two hooks during setup() by detecting multifd && !mapped_ram &&
> > > > > > nocomp.
> > > > > > 
> > > > > 
> > > > > The "_begin" hook is still necessary to mark the end of the device state
> > > > > sent via the main migration stream (during the phase VM is still running)
> > > > > since we can't start loading the multifd sent device state until all of
> > > > > that earlier data finishes loading first.
> > > > 
> > > > Ah I remembered some more now, thanks.
> > > > 
> > > > If vfio can send data during iterations this new hook will also not be
> > > > needed, right?
> > > > 
> > > > I remember you mentioned you'd have a look and see the challenges there, is
> > > > there any conclusion yet on whether we can use multifd even during that?
> > > 
> > > Yeah, I looked at that and it wasn't a straightforward thing to introduce.
> > > 
> > > I am worried that with all the things that already piled up (including the
> > > new thread pool implementation) we risk missing QEMU 9.2 too if this is
> > > included.
> > 
> > Not explicitly required, but IMHO it'll be nice to provide a paragraph in
> > the new version when repost explaining the challenges of using it during
> > iterations.  It'll be not only for me but for whoever may want to extend
> > your solution to iterations.
> 
> Will do.
> 
> > I asked this question again mostly because I found that when with iteration
> > support the design looks simpler in begin(), so that the extra sync is not
> > needed.  But I confess you know better than me, so whatever you think best
> > is ok here.
> 
> If we do the MIG_CMD_SWITCHOVER / QEMU_VM_COMMAND thing common for all
> devices then we don't need begin() even without live-phase multifd
> device state transfer.
> 
> > > 
> > > > It's also a pity that we introduce this hook only because we want a
> > > > boundary between "iterable stage" and "final stage".  IIUC if we have any
> > > > kind of message telling dest before hand that "we're going to the last
> > > > stage" then this hook can be avoided.  Now it's at least inefficient
> > > > because we need to trigger begin() per-device, even if I think it's more of
> > > > a global request saying that "we need to load all main stream data first
> > > > before moving on".
> > > 
> > > It should be pretty easy to remove that begin() hook once it is no longer
> > > needed - after all, it's only necessary for the sender.
> > 
> > Do you mean you have plan to remove the begin() hook even without making
> > interate() work too?  That's definitely nice if so.
> 
> As I wrote above, I think with MIG_CMD_SWITCHOVER it shouldn't be needed?

Ah I see, yes if with that it's ok.

Just a heads-up - please remember to add one migration_properties[] entry
and a compat property for pre-9.1 so that we don't generate that message
when migrating to old binaries.

Meanwhile if we're going to add it, let's also make sure postcopy also has
it, as it shares the same SWITCHOVER idea.

Thanks,

-- 
Peter Xu


