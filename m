Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAD8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0SF-0000XI-No; Wed, 17 Jul 2024 04:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU0SE-0000WH-9E
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU0S8-00032C-Im
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721206559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQPLfe/NfZL1qKm7yMeQAE0d1PqrsGgEF7DivEi9I4g=;
 b=aevHnXG5D4bWVEu5ZwRH9WMite+bcr/XbaI6xvwOsJrwnuEs8sSG6/+lYoYKcaaAP6bFrP
 m4c5X4yCs8+Cl3twYd7Ek/ZaOQlcJyrwLX/kDKsEml3nN6mNmVppoh3NTdlko3G8Kedmjw
 18EPBr84ixPj08eeEH3jc4vybL8tZhM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-gqq5Cn1bMxCShYy7jwOJsA-1; Wed, 17 Jul 2024 04:55:58 -0400
X-MC-Unique: gqq5Cn1bMxCShYy7jwOJsA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so3763675f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 01:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721206557; x=1721811357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQPLfe/NfZL1qKm7yMeQAE0d1PqrsGgEF7DivEi9I4g=;
 b=it3WHIOA+Foec0noe/pe5Xz/iV/BHSCIyHHZe5o7pazNtyx2KAw77SiBxW20UbX4+Q
 LCACm1ctI29lGHTqFbx4eePsHzFb7GcoueNDruRl2I1hM2n9MElxRQ9Ey9fUdyje/+tc
 YTJKxRLjef9xsP8uxmDV31I8yjk2k8wp0t7ncyXRBDwBlKknzvPYLAcXA8NCfDurRslM
 Vy6mJ4mtkCC6bu+AvnXNNQI/XsyGSof6LRiWTeySdotAFN9hjje8YyWnelvnPUHLHGKL
 HdU3z4Gg9PJlt3awNbvp6abLg0GEnrRQKe/rdR/xFV2xGqvL5a0s/UWe59OZ6h0CEOla
 bu+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJPhvHKum6yBZC1xE018ZnCmGzyalK192gAX4EqFoLWVvkOmBGlju4RRG4qU6oCDw7Jk5B3Xo6n/kXwJPcpX3nJM+xPvo=
X-Gm-Message-State: AOJu0YzlVk18vEawGkq/NFX+SZV74TzCv9lShDpL/teoCRAZ11yfNCI6
 orbs1cmL3bHFw0v3nRknY5XMwuuiWqI82y2YBnbPZetekh1xPz1ADqOEfxZAPgkN8GW5dCb3uPh
 LwYFueJNVi+HEuMZxZxxOjzT/KxSeR75ZZelkb3WH/xak6B+zH+0L
X-Received: by 2002:a5d:56ce:0:b0:367:9877:750e with SMTP id
 ffacd0b85a97d-36831605880mr647105f8f.25.1721206556788; 
 Wed, 17 Jul 2024 01:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzP0b2mY/U5XAp+clNfhl2plxQwCYkiKwu4W/2uHqL7/ytR81ZMpnA4Xuu1laJCMUKaiPtGQ==
X-Received: by 2002:a5d:56ce:0:b0:367:9877:750e with SMTP id
 ffacd0b85a97d-36831605880mr647092f8f.25.1721206556013; 
 Wed, 17 Jul 2024 01:55:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:360d:da73:bbf7:ba86:37fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbf29sm11163692f8f.70.2024.07.17.01.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:55:55 -0700 (PDT)
Date: Wed, 17 Jul 2024 04:55:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <20240717045335-mutt-send-email-mst@kernel.org>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpbuChi9QMIogmuS@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 16, 2024 at 06:02:50PM -0400, Peter Xu wrote:
> On Tue, Jul 16, 2024 at 03:44:54PM +0530, Prasad Pandit wrote:
> > Hello Peter,
> > 
> > On Mon, 15 Jul 2024 at 19:10, Peter Xu <peterx@redhat.com> wrote:
> > > IMHO it's better we debug and fix all the issues before merging this one,
> > > otherwise we may overlook something.
> > 
> > * Well we don't know where the issue is, not sure where the fix may go
> > in, ex. if the issue turns out to be how virsh(1) invokes
> > migrate-postcopy, fix may go in virsh(1). Patches in this series
> > anyway don't help to fix the migration convergence issue, so they
> > could be reviewed independently I guess.
> 
> I still think we should find a complete solution before merging anything,
> because I'm not 100% confident the issue to be further investigated is
> irrelevant to this patch.
> 
> No strong opinions, I'll leave that to Michael to decide.
> 
> > 
> > > You could pass over the patch to whoever going to debug this, so it will be included in the whole set to be
> > > posted when the bug is completely fixed.
> > 
> > * Yes, this patch series is linked there.
> > 
> > > The protocol should have no restriction on the thread model of a front-end.
> > > It only describes the wire protocol.
> > >
> > > IIUC the protocol was designed to be serialized by nature (where there's no
> > > request ID, so we can't match reply to any of the previous response), then
> > > the front-end can manage the threads well to serialize all the requests,
> > > like using this rwlock.
> > 
> > * I see, okay. The simple protocol definition seems to indicate that
> > it is meant for one front-end/back-end pair. If we are dividing the
> > front-end across multiple threads, maybe we need a document to
> > describe those threads and how they work, at least for the QEMU
> > (front-end) side. Because the back-end could be a non-QEMU process, we
> > can not do much there. (just thinking)
> 
> IMHO that's not part of the protocol but impl details, so the current doc
> looks all fine to me.
> 
> Thanks,
> 
> -- 
> Peter Xu


I just want to understand how we managed to have two threads
talking in parallel. BQL is normally enough, which path
manages to invoke vhost-user with BQL not taken?
Just check BQL taken on each vhost user invocation and
you will figure it out.


-- 
MST


