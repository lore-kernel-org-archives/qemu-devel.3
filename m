Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61257C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lv7-0002gC-UR; Wed, 08 May 2024 14:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s4lv1-0002eq-6i
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s4luz-0001jw-34
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715192486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoz3JnYamTO21tpB5TUcC8r0hcWk7Xh9DqZtVdHC+Uk=;
 b=hUzXk7ld6Xdoscs43sO5xC2L25Ndx0VWjL8EDoi/LDgmtgz1UEiIb78VYFiI0dlxJ88VS0
 rzs1KqgjOigAIY6A3hM6pJfSNdP+KUq8wbzPfr0aZGv6QjGKPybiIsxCs+0FmvSTZ2xT/8
 UrMIge2kuMlyJe79q5fuVUuMP08R9Lk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-6u0AYP24N9mJXNHFgH2-pg-1; Wed, 08 May 2024 14:21:25 -0400
X-MC-Unique: 6u0AYP24N9mJXNHFgH2-pg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-34dd570f48cso2790296f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 11:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715192484; x=1715797284;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zoz3JnYamTO21tpB5TUcC8r0hcWk7Xh9DqZtVdHC+Uk=;
 b=ZYr4BuWyqlqTAXcVpPsaUrCKXX0st0CbtgNp/ymuMGjckyzzkXXRLdWVRoM5xUf+/i
 aoHubAxUF4mIKfBjbfeH5WNb98v9EqaDS0yhK3LlPd+q+FmUwXK4fGj+QkMt8iomxQSH
 AcBB9HPuvnaF6BqiJeXns5kXTOt2V2zuAJE1OaUAxu99YEAuQB5F98MePGL7pRlSjxs6
 283Q1oUdevej1gnnFYIDc/Ln/ZS0mFgPXRK4sDp7FKSY4hczEjvM7f+5j8YTccjn1fpF
 VfAd/F9a/NDbsn3cUaS7rP+6PnW/jdmSVb+TFb7M5VFPCcuDlb3SDwT+SobeKNTmBqmi
 bBjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSWDlEKKH0CkRXFHwfiRM4dvWFO7jIE3m3qca3ErcF38rMNzi3biJtYE/NMRRbvmLZm9nIL76TvlYLvYIEqnNDKrsOiJk=
X-Gm-Message-State: AOJu0Yyblvo70dZGRDGxDfsKax0EGmri6FunICgZNxgncTrK0R293iNr
 vKqc/lj8UQH5UR5p/5sWDAEjIs7+X8dLE5wn612tNOToTewgC90/+RpxjnpL5vvXDaQRpt7DzfV
 7F/vYYmdXmPNX4VHP4rPH1kqj5r05A0jKI0f8bFdVkL5D4SFC1RHJ
X-Received: by 2002:adf:a30c:0:b0:346:c7ed:22de with SMTP id
 ffacd0b85a97d-34fcaddfa90mr2174064f8f.14.1715192483799; 
 Wed, 08 May 2024 11:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeZe83pgrhfgE6Xw1Klz81MPjdRHJ0xwQ+SOrPdzCbQqb3l4ToglGrVjVtaLl1LfoRulg1SA==
X-Received: by 2002:adf:a30c:0:b0:346:c7ed:22de with SMTP id
 ffacd0b85a97d-34fcaddfa90mr2174037f8f.14.1715192483049; 
 Wed, 08 May 2024 11:21:23 -0700 (PDT)
Received: from redhat.com ([2.52.1.121]) by smtp.gmail.com with ESMTPSA id
 r2-20020adfce82000000b0034dd7984d7fsm15844669wrn.94.2024.05.08.11.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 11:21:22 -0700 (PDT)
Date: Wed, 8 May 2024 14:21:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Wafer <wafer@jaguarmicro.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <20240508141920-mutt-send-email-mst@kernel.org>
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
 <CAJaqyWcgMFJL8y7wXwFZa6dny34WKDRH+tuEaCdP8oFN4Qf5fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcgMFJL8y7wXwFZa6dny34WKDRH+tuEaCdP8oFN4Qf5fQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 08, 2024 at 02:56:11PM +0200, Eugenio Perez Martin wrote:
> On Mon, Apr 22, 2024 at 3:41 AM Wafer <wafer@jaguarmicro.com> wrote:
> >
> > The virtio-1.3 specification
> > <https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
> > 2.8.6 Next Flag: Descriptor Chaining
> >       Buffer ID is included in the last descriptor in the list.
> >
> > If the feature (_F_INDIRECT_DESC) has been negotiated, install only
> > one descriptor in the virtqueue.
> > Therefor the buffer id should be obtained from the first descriptor.
> >
> > In descriptor chaining scenarios, the buffer id should be obtained
> > from the last descriptor.
> >
> 
> This is actually trickier. While it is true the standard mandates it,
> both linux virtio_ring driver and QEMU trusts the ID will be the first
> descriptor of the chain. Does merging this change in QEMU without
> merging the corresponding one in the linux kernel break things? Or am
> I missing something?
> 
> If it breaks I guess this requires more thinking. I didn't check DPDK,
> neither as driver nor as vhost-user device.
> 
> Thanks!

I think that if the driver is out of spec we should for starters fix it ASAP.

> > Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
> >
> > Signed-off-by: Wafer <wafer@jaguarmicro.com>
> > ---
> >  hw/virtio/virtio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 871674f9be..f65d4b4161 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1739,6 +1739,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
> >              goto err_undo_map;
> >          }
> >
> > +        if (desc_cache != &indirect_desc_cache) {
> > +            /* Buffer ID is included in the last descriptor in the list. */
> > +            id = desc.id;
> > +        }
> > +
> >          rc = virtqueue_packed_read_next_desc(vq, &desc, desc_cache, max, &i,
> >                                               desc_cache ==
> >                                               &indirect_desc_cache);
> > --
> > 2.27.0
> >


