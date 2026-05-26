Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C45CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRvjU-0006In-K7; Tue, 26 May 2026 13:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRvjP-0006FV-3c
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRvjM-00038Q-1T
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779817094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rx7K2c6aCvCxfnO/S9ypd6NySLP7G1XwuDuwvZ7q9cc=;
 b=auKvo6QheOPMjsdeNlASYNs9/uKF74b2wt4IC/LqK9a5flJ/I7sP5OciuXoEH4pxIhV9nk
 U5DzdkLB98y+f09mhPO8H+aq8/An3AOtm6wY6FNNhLDlIbfDlZOcyKXpc88rTgMuv25Vll
 2k2nGnIr3xBBlxR4liz3NVnRS66IrPo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-P9JIUrP7MKeaLY5-VRgTeQ-1; Tue, 26 May 2026 13:38:12 -0400
X-MC-Unique: P9JIUrP7MKeaLY5-VRgTeQ-1
X-Mimecast-MFC-AGG-ID: P9JIUrP7MKeaLY5-VRgTeQ_1779817092
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d19f68acso100172521cf.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779817092; x=1780421892; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rx7K2c6aCvCxfnO/S9ypd6NySLP7G1XwuDuwvZ7q9cc=;
 b=kFDBn1dHzjZfBCGuMblQgoQ89OPGPn0E5uF4oEjyGeteVEm0+Fz6mTikQg1zZCQba2
 No/VkjHYbFPgMP+x7ElOGRNoZK9F9qWysSo01WZVKW1BuOjQ+f7XcZgBIT/b3OnZXeaM
 v/ek4qP4/xr8oj9kCkay3P+TmPda/DRssah7fHSqwrzSHum86yTruoxcwyMEGPmMUEq1
 b193OjHheR9g+pF48Faw5ueBhr11J3VI71korwTGOQxDKZv1FFF4BbJN7sUgmfpnT3fv
 27ZUXBWy60ELkk0q5Rx4gxtkw1FIfSzMi/0VU2NkHHanQsyq+uKc2rWlRdt7nniB/ulp
 QPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779817092; x=1780421892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx7K2c6aCvCxfnO/S9ypd6NySLP7G1XwuDuwvZ7q9cc=;
 b=juMAcK87NSFQ8RIaaZf7ynnpyuZU+dlkiLksa/dNTUuM0BMNpD8EDJrZ7P6K/nFPTQ
 DfAYw8/xM6VIVsR8P3ct9PS7CoHDxy+2v0NNOpcEsnWgm0zuN/Y6OuhW6DnkhhP6U7cS
 xesu7izGowGwdhjIA0/yTYs5Hr7EKvx89ZkOG1nKeIlAqg7xMXQ6ZcB+Yx8s24mJvuDp
 7Af3Wkf+V91kTd1xfa1WwOACBoiu1pJOqUuWlLR4IHZcZHmE4XDHZORoGUyCmQJV/xtu
 qkTRTkGTIWn3TQfRufHGug8mQ8SWp+LZgP3IDTFHVx5uXXGeWgvtY4dCjwOFi4rb2Nng
 edlA==
X-Gm-Message-State: AOJu0Yxa0fDd1XSGnuR5EL5ABQVhCmioLJh8uRXVyS/eHdvaKR6asqWc
 MfoBotNntjoUay02rWljgK4fmzro22AhoFFOzUp7qDuUCueTD9N+VxzWabgCeYJ9uTSj9aCsDX9
 fQVFPyr+J03r7q/fsnjoJdEwv3YumZBCGiToHhENcOM1E27V3UWl+Qhi8
X-Gm-Gg: Acq92OHn20IH0TzJRKdr86sxuECPnfjvPFl97qfHVl0uFjgN6xGKLgeV3ixqOFpUKZk
 DnZlanxG3A0l7wVolFRXt5gEGws3d4ob6RmwqO2+ha6P3sXalgH/3Jpo9gIcxUQomv6vp5mt9WT
 i7nVKTO3LuKYwkVrWdsBJ2bLU4Bhi++snDKcXB01s9vaQ2OLtWr98l5BjAfUDxMhuZa6EgpAQz1
 xAf+dScdLsLzf+PUjYh+2dPIw3k6SuHsD2U/cc8xrelmJGaMjc6k2/LBQq9pMPzUkWdaLYwye5o
 gKkVylXpUrSEfFFoiJ6OmuSPAMIfcj5rfSflVwyrpsmgmk89QlRv0Cz8vTxSCRZU6++/ILNE3kJ
 TUI+nIVTFEdyJUxSX2Uk0eWmX0MgKqKISP+oN6kp0t0JXpG0=
X-Received: by 2002:a05:622a:c4:b0:516:51da:ae35 with SMTP id
 d75a77b69052e-516d43686dcmr261106311cf.34.1779817091530; 
 Tue, 26 May 2026 10:38:11 -0700 (PDT)
X-Received: by 2002:a05:622a:c4:b0:516:51da:ae35 with SMTP id
 d75a77b69052e-516d43686dcmr261105401cf.34.1779817090673; 
 Tue, 26 May 2026 10:38:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706af131dsm23398301cf.21.2026.05.26.10.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:38:09 -0700 (PDT)
Date: Tue, 26 May 2026 13:38:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 09/14] vfio/migration: Re-query precopy size before
 sending VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
Message-ID: <ahXagMySNbLFJBhc@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com>
 <agzAzawATnGGMIGO@x1.local>
 <e4803220-4d73-433a-b697-3aa67dc55e12@nvidia.com>
 <ag8e-Czuujdt5hm1@x1.local>
 <5af18c64-267e-4948-98c9-20d94b4db4e9@nvidia.com>
 <ahRoln21IZAO_iOA@x1.local>
 <a75a99be-0af9-4c46-abef-02a6e5231824@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a75a99be-0af9-4c46-abef-02a6e5231824@nvidia.com>
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

On Tue, May 26, 2026 at 12:17:07PM +0300, Avihai Horon wrote:
> 
> On 5/25/2026 6:19 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Sun, May 24, 2026 at 09:45:33AM +0300, Avihai Horon wrote:
> > > On 5/21/2026 6:04 PM, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Thu, May 21, 2026 at 04:46:31PM +0300, Avihai Horon wrote:
> > > > > On 5/19/2026 10:58 PM, Peter Xu wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > > 
> > > > > > 
> > > > > > On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
> > > > > > > When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > > > > > flag is sent to the destination to indicate that initial data has been
> > > > > > > sent, so destination can indicate back to source when it finished
> > > > > > > loading it.
> > > > > > > 
> > > > > > > To get a more accurate estimation of initial_bytes, re-query precopy
> > > > > > > size before sending the flag. Extract the flag sending logic from
> > > > > > > vfio_save_iterate() to a new helper for clarity.
> > > > > > > 
> > > > > > > This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > > > > > flag if, for example, the previously queried initial_bytes was lower
> > > > > > > than actually is. Additionally, it prevents sending the flag if
> > > > > > > vfio_query_precopy_size() failed.
> > > > > > > 
> > > > > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > > > > ---
> > > > > > >     hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
> > > > > > >     hw/vfio/trace-events |  1 +
> > > > > > >     2 files changed, 33 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > > > > > index 2911583ee1..243624b5fe 100644
> > > > > > > --- a/hw/vfio/migration.c
> > > > > > > +++ b/hw/vfio/migration.c
> > > > > > > @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
> > > > > > >                                              data_size);
> > > > > > >     }
> > > > > > > 
> > > > > > > +/* Returns true if the init data flag was sent, false otherwise */
> > > > > > > +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
> > > > > > > +{
> > > > > > > +    VFIODevice *vbasedev = migration->vbasedev;
> > > > > > > +    int ret;
> > > > > > > +
> > > > > > > +    if (!migrate_switchover_ack()) {
> > > > > > > +        return false;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    if (migration->precopy_init_size || migration->initial_data_sent) {
> > > > > > > +        return false;
> > > > > > > +    }
> > > > [1]
> > > > 
> > > > > > > +
> > > > > > > +    /*
> > > > > > > +     * precopy_init_size holds an estimation of the initial data size, re-query
> > > > > > > +     * precopy size to ensure it's really zero before sending init data flag.
> > > > > > > +     * Don't send the flag if query fails.
> > > > > > > +     */
> > > > > > > +    ret = vfio_query_precopy_size(migration);
> > > > > > > +    if (ret || migration->precopy_init_size) {
> > > > > > > +        return false;
> > > > > > > +    }
> > > > > > IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
> > > > > > much (when NIC reconfigures?), then we can still rely on the window where
> > > > > > the "new switchover ack" will be requested later on during the exact sync.
> > > > > > 
> > > > > > Relying on that seems slightly cleaner.
> > > > > Not sure I follow.
> > > > > 
> > > > > New switchover ack is requested in exact sync if we see new init_bytes > 0
> > > > > (REINIT flag).
> > > > > This flow happens only after the new switchover ack is requested in exact
> > > > > sync, when init_bytes = 0 again.
> > > > > 
> > > > > So this chunk just makes sure we send the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > > > flag at the right time.
> > > > AFAIU, what this chunk does is, we may save one switchover-ack if REINIT
> > > > got here.  It doesn't provide much functional difference in reality.
> > > > 
> > > > With this code there, when it happens to see REINIT, instead of sending an
> > > > immediate VFIO_MIG_FLAG_DEV_INIT_DATA_SENT message, it falls back to send
> > > > init data in the next iteration loop, saving that flag, and saving a
> > > > "request switchover-ack" on src QEMU too.
> > > > 
> > > > If above code removed, IIUC VFIO will send VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > > immediately causing dest sends ACK.  vfio_query_precopy_size() will be
> > > > postponed until the next sync query (which must happen at some point before
> > > > final switchover), then it will be collected there, VFIO src will request
> > > > for switchover-ack, then another VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is
> > > > expected.
> > > > 
> > > > Both should work, but what I meant is, I think we don't need this random
> > > > check, because it's optimistic, it's not functionally necessary, IIUC.
> > > > 
> > > > IOW, see the current code and how it can still race with a REINIT anyway:
> > > > 
> > > >                migration thread                                  some vfio driver thread
> > > > 
> > > >       ret = vfio_query_precopy_size(migration);
> > > >       if (ret || migration->precopy_init_size) {
> > > >           return false;
> > > >       }
> > > >                                                                      got reconfigured,
> > > >                                                                      set REINIT
> > > > 
> > > >       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> > > >       migration->initial_data_sent = true;
> > > >       trace_vfio_send_init_data_flag(vbasedev->name);
> > > > 
> > > > It's the same to me if e.g. we try to vfio_query_precopy_size() in VFIO's
> > > > iterative loops from time to time, it'll also work, it'll make sync more
> > > > frequent, but it's not needed.
> > > I see what you mean now.
> > > However, the purpose of this chunk is not to check for another REINIT, but
> > > rather to ensure VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is sent at the right time
> > > -- when init_bytes is truly 0.
> > IIUC, that part should normally be guaranteed by this line you added prior
> > to it:
> > 
> > +    if (migration->precopy_init_size || migration->initial_data_sent) {
> > +        return false;
> > +    }
> > 
> > Hence when reaching vfio_query_precopy_size(), precopy_init_size==0.
> 
> Yes, but here we only know that the estimation of init_bytes that we queried
> previously is 0.
> Because it's an estimation, it may be lower than reality and then we end up
> sending the INIT_DATA_SENT flag before all init_bytes were actually sent.
> 
> For example:
> Precopy info ioctl reports 10MB init_bytes estimate, but in reality there is
> 12MB init_bytes.
> We send the 10MB init_bytes thinking we are done with it, but if we query
> again we see the extra 2MB (no REINIT in this case, because the 2MB belongs
> to the same previous init_bytes chunk). So the INIT_DATA_SENT is sent too
> soon.
> 
> That's why we try harder and do another query just to make sure the previous
> estimate was accurate.
> But as I wrote below, I first thought such case could happen for mlx5, but
> then realized it couldn't happen. Though I still chose to keep it for the
> general case, not only mlx5.
> 
> However, thinking about it again now, such scenario as the above can't
> happen as it violates the uapi, because init_bytes can't suddenly grow
> without a new REINIT (and if there is a new REINIT, as you mentioned, we are
> fine since next query pending will catch it).
> So yes, I guess this extra query is redundant. I will remove it, unless you
> think otherwise.

I prefer removal in this case.

Thanks,

-- 
Peter Xu


