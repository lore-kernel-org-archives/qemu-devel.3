Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48EDCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGLH-0007ui-M1; Wed, 27 May 2026 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSGL7-0007tT-TP
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSGL5-0002La-AW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779896313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=853nuwN2Mbj0WBrSnBo6VH4AEaYuahWSbhAuGZ2eME0=;
 b=R7NxtcTxESnuyfdUGdnKD4yz9SwUT6HOcQeGSV8fHooclsvgoLVk6CC9tGq9yW1jhcry8C
 Kk10cM5wArj7H1aX+QbXWUiK3XzGn4KyiZas7Oc4CfBUFcl+NmZC9ltF5fA9ji47JKXuCJ
 LGLNg9vPGuAsOGcq9ViHWPtWdP0NHD4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-_x8Vy8r_NEGMgde0GwDXGA-1; Wed, 27 May 2026 11:38:32 -0400
X-MC-Unique: _x8Vy8r_NEGMgde0GwDXGA-1
X-Mimecast-MFC-AGG-ID: _x8Vy8r_NEGMgde0GwDXGA_1779896312
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50edf01172bso162766451cf.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779896312; x=1780501112; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=853nuwN2Mbj0WBrSnBo6VH4AEaYuahWSbhAuGZ2eME0=;
 b=V8a4ENea4bp+wngMm3OOnUuzfQdXzYf9kTu7CTOWgLl5Yb6Yb0g/kN5wSZ/89GYPsx
 974bD//ks0p+2Y9C1gmDxZ4ZotGZaNBmi6COzJy+D0SpJkcGZM1fBQ+lCp2y8IE0AzYl
 o7cmo9cu1jmKh6+KdyKCLcfhi1lZ9ccyNL0FSkgnY/JFSplZfeUdKAqLMZ8iY4jxSiyW
 NL4iiJsDGMagtM4Ntq889qcH5Aj//FjT1HBax+04WWegZ2jsvvBULYguYvGg05rednty
 DkO9RDUXcg2ZRvfa4tQwU9SP5BxgFs/U3XU9+zA2Z96z8uWck2ztYcBPOy4fM6RKIb1l
 0t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896312; x=1780501112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=853nuwN2Mbj0WBrSnBo6VH4AEaYuahWSbhAuGZ2eME0=;
 b=b8oRV4m/zSJIhZuI0E5E0Yx1Ot39LP2Aph/todJvMJyKv4TkVOBlWz5hCLalhQalfY
 DpylapZFiriKaV84JO79MdtbqzD+NO3AbrXh8RMfLGiIps6moxL4eOQzJqmGhn+2Rp0k
 pfXLnAETi3kwKhj9+4E+I5Eb2QEqlroW03vsIvFuhoC1LVkwfO51GSkAG4PGBruFO8so
 qRdIPESaRfB9/j1Ot4g8I/YYxyTLgaOSNfYFVdkKYwJT54nNoJV4rosX3ykDPO7czTwR
 ZZL+66O2HWB8BbRjuDLWFOyCkwXXnTZeTyjVtTiYkqLLY/+SEYUCiDrwghUaj3qmi6ao
 TBlg==
X-Gm-Message-State: AOJu0YzBlvmK5cIiYebSvPfELOpXo7VmqsIIX8tjLV2H2xd4E3fGiAcn
 3Bspp53jDdWpdlnTZzE42R3890Aw+0/QaHNqWZHwpLub8DyM/VVlExJMSn9bvmIt5GzDwilfATf
 mAQPT5bPVqoft1QIrXWLqTc8ImoUXM5Bo2B0jGbtQMzjv6UAC5nBe0bO3
X-Gm-Gg: Acq92OGIHtnQVty3A2qysKDCoTjeZHyWKPq+n7Gb2tUUoUI3wyDb9u+tJWizQmjtsQL
 MgModhxtErRy3sYbljqDobPSUXJsAoW8dH1jEVZP0t+HVNNXCZb9MMGTmCa9kc9j0e9wqNRegZo
 WezEit26tWiQm+yYtV9XuwalLLqNSbfAo1kYMHhapBPl3S1dB7br+tUVfYHllIHczc+Kq9Lzocy
 A/ayf6xMqHKIXsQ8PMud2KCPfTvIfz21BlbjC3WFrHSWsh6pCpILHmQQGG49ccTx7O+0FMyBrDF
 ytl4ZcW7eo4iotP3CUtnbTpmbCkhgG2ixtU1HFjYtdD78HVkzkI7FWJkR+/93xzy86u/DLxqrPn
 ya4Q7lO+EZ7Da0fz9pWZcJgDK2+zzgRTHJ9H2YHPVdKc+Gp6RdxlF2bvtOA==
X-Received: by 2002:a05:622a:144:b0:516:ea30:876d with SMTP id
 d75a77b69052e-516ea309333mr221275281cf.4.1779896311672; 
 Wed, 27 May 2026 08:38:31 -0700 (PDT)
X-Received: by 2002:a05:622a:144:b0:516:ea30:876d with SMTP id
 d75a77b69052e-516ea309333mr221274841cf.4.1779896311115; 
 Wed, 27 May 2026 08:38:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc812e657csm189885516d6.24.2026.05.27.08.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:38:30 -0700 (PDT)
Date: Wed, 27 May 2026 11:38:29 -0400
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
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
Message-ID: <ahcP9dtUqSAc-LAq@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com>
 <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com>
 <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com>
 <ahRkT19AVwi4SQA9@x1.local>
 <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com>
 <ahXJD6QkXccf60Cn@x1.local>
 <c450e363-22f5-4bf8-9c04-896ccb02938b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c450e363-22f5-4bf8-9c04-896ccb02938b@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 11:17:45AM +0300, Avihai Horon wrote:
> 
> On 5/26/2026 7:23 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, May 26, 2026 at 12:08:34PM +0300, Avihai Horon wrote:
> > > On 5/25/2026 6:01 PM, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Sun, May 24, 2026 at 09:34:48AM +0300, Avihai Horon wrote:
> > > > > Yes I think so.
> > > > > 
> > > > > We just need to indicate modules that it’s the last query during switchover
> > > > > so they can handle it properly.
> > > > > Do you think it would be reasonable to add a "bool final" param to
> > > > > save_query_pending handler?
> > > > > 
> > > > > For RAM it will be used to indicate we are running under the BQL (since
> > > > > currently save_query_pending runs only outside BQL) and to pass the proper
> > > > > last_stage param into migration_bitmap_sync_precopy().
> > > > > For VFIO it will indicate we should not do a query precopy info ioctl (which
> > > > > is only valid in VFIO precopy states, not while VM is stopped).
> > > > Yes, a final boolean sounds reasonable, implying both (1) last sync before
> > > > switchover, VM stopped, (2) BQL held.
> > > > 
> > > > For VFIO, I double checked the complete() that does not depend on the
> > > > precopy_bytes fetched, then it should be fine indeed,
> > > > 
> > > > vfio_save_complete_precopy():
> > > >       do {
> > > >           data_size = vfio_save_block(f, vbasedev->migration);
> > > >           if (data_size < 0) {
> > > >               return data_size;
> > > >           }
> > > >       } while (data_size);
> > > > 
> > > > It's just werid to see that it doesn't depend on either precopy_bytes or
> > > > initial_bytes, even if logically it should.. this will be confusing to
> > > > whoever start reading this code.. but I understand not much we can do with
> > > > the current kernel API.
> > > > 
> > > > Side note: should we still better update these fields to make sure they'll
> > > > be zero after migration? That means vfio_update_estimated_pending_data() in
> > > > vfio_save_complete_precopy() too, with/without further sanity checks.  That
> > > > seems to be missing right now.  I'm not sure if it's intentional.
> > > Yes, it's intentional, since we don't use these values after calling
> > > vfio_save_complete_precopy() -- they are only used for downtime estimation
> > > prior switchover.
> > > Precopy_init/dirty sizes are zeroed in vfio_save_cleanup() though, but not
> > > stopcopy_size (however, that's benign, since upon new migration it will be
> > > reset before used).
> > > 
> > > So calling vfio_update_estimated_pending_data() here seems redundant to me.
> > Logically migration can still fail during complete():
> > 
> > qemu_savevm_state_complete_precopy():
> >      ret = qemu_savevm_state_complete_precopy_iterable(f, false);
> >      if (ret) {
> >          return ret;
> >      }
> > 
> > If vfio_update_estimated_pending_data() has the safe guard for any form of
> > overflow, then IMHO we should try to maintain those counters if possible.
> 
> Yes, we can call vfio_update_estimated_pending_data() in
> vfio_save_complete_precopy(), but I am not sure I see what's the benefit of
> it?
> 
> If it's to ensure these counters are zero post of migration, then even if
> migration fails the .save_cleanup handler will be called and zero them (I
> can add a patch that zeroes stopcopy_size as well).

Nothing critical indeed.

I only wished save_complete() should look almost what save_live_iterate()
looks like.  Because they should really do similar things dumping iterable
data.. with some nuances only.

Ideally, if we can add vfio_update_estimated_pending_data() into vfio's
complete() it reduces that gap.

That, including the other thing you plan to do by moving the slow sync out
of RAM's complete(): both of them try to also make complete() look more
like save_live_iterate().

If one day we want to remove save_complete(), it'll also be easier.  And
IMO we should consider removing it at some point, passing another "bool
final" to save_live_iterate().

If we see some other save_complete() hooks: htab_save_complete() is almost
a dup of htab_save_iterate() with trivial diff, cmma_save_complete() is
literally cmma_save_iterate() with passing "final" to cmma_save(), etc.

So that's only about making VFIO less special in complete() only.  If you
think that's a good future approach we can do that in this series together,
but we can also leave it for later.  No strong feelings.

Thanks,

-- 
Peter Xu


