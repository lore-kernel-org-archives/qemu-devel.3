Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17908C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZR5f-0001YH-7c; Thu, 01 Aug 2024 04:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sZR5d-0001Xj-TY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sZR5c-0005SB-51
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722500588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=keJs/l4xu4+z2oxXxkAWZ2XWAcI6whwPSbiDiu8nmpY=;
 b=h7cAmGHPueknJSpyM3sstC5yySbRSPM98U93AarSl9Z2wqu9Y+ZwwqS1X6LauLk9OgtdRC
 ssqxPsWFmARbhxkupiHDRRN9IRNFpEWq0JEbYUOP37b2tRz/I0T0dMrDZFr+dVyE+GijI9
 PV7O70LdBC3qdD8SsKxFLlyfRNeqrCU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-OtuyM8WHM4eCF775wHmiGQ-1; Thu, 01 Aug 2024 04:23:07 -0400
X-MC-Unique: OtuyM8WHM4eCF775wHmiGQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-666010fb35cso31497827b3.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 01:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722500587; x=1723105387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keJs/l4xu4+z2oxXxkAWZ2XWAcI6whwPSbiDiu8nmpY=;
 b=aUa2NPrBz95iBbJf1x+wuk2B5840KJk+X+c9XyGfqYLxqgD82y+K3AFk1wxAuik2Xw
 VueXSbwOIwPCuVNflul7DT/l7btOIcPXI1eiHn029r28z9wSwunkbsgZx0HSiaCe5ETA
 sWYQlXy48pfZa0hxLwyIDiuSMXXZJO/PVO+AC+Ym26iyfxcB8gnpICCyDxRPyZ8xwgKZ
 ny6VZ8nIIG4O76dPmX1aIXQsRnE+BhjqkD+GdhmmcZeogL0JeHkMxKkP3pVfsFrOfMXI
 +R0Nplw+DImtKo8QQGhJ31EN1pVtSJYB4YFpA484YQC42V2jXqg1e8VDGJsW41SMTcDa
 APYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz1ZLfXunMCoBltBvX6UbkoAn3jcSmFl9gugvcayJmbRzIDwwGNNNGhBoXzvyprpbL54tPjfADgQBgoXt6Rk/0phPtCl0=
X-Gm-Message-State: AOJu0YyJhc/f0z3e3lMQ6BJUk8TuZVCrAOTWul678KORE9SO2xfsQs9A
 FSyPguaCcsEBxak1pqCiHQkG9p8NF9HKI6gsR0P4dkAhWEEDFGxzW2Xf+5qKCANhLW3YWVstIo8
 KM2LNau4mlugJFpKf6usYtNYAUpLolZjRBy97UIwKfKukQAfddtf1XOkYhQulh6hQrwm5yxgc9A
 ODlw0HmsGrZeDbtjhd92lFF/hRsRo=
X-Received: by 2002:a81:8a84:0:b0:62f:60db:326 with SMTP id
 00721157ae682-688553e839bmr3517027b3.20.1722500586656; 
 Thu, 01 Aug 2024 01:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2XN/cIkf09QuLeRbnP+3kk1Tibt4otwCWth8YxBCmlIYGVLnMASSqMfnf8B/aYsw7t3del94XBWio5Sz5QUM=
X-Received: by 2002:a81:8a84:0:b0:62f:60db:326 with SMTP id
 00721157ae682-688553e839bmr3516867b3.20.1722500586303; Thu, 01 Aug 2024
 01:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
 <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
 <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
 <CAJaqyWf-Tcu0RdiWU3m9P07xJ7c33QXwSDH0-D=8u2FHC-=uZA@mail.gmail.com>
 <15d9fb93-58f9-4078-8f07-2ebf0f228d3b@oracle.com>
 <50fd84e1-a8af-4c61-90cc-2ceb653869f6@oracle.com>
In-Reply-To: <50fd84e1-a8af-4c61-90cc-2ceb653869f6@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Aug 2024 10:22:29 +0200
Message-ID: <CAJaqyWcLW3tTdQLM65voYzKQ_S-5ZTQh5NAQAzU88m=BTyWa5g@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Thu, Aug 1, 2024 at 2:41=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Hi Jonah,
>
> On 7/31/2024 7:09 AM, Jonah Palmer wrote:
> >
> >>>>>>>>>> Let me clarify, correct me if I was wrong:
> >>>>>>>>>>
> >>>>>>>>>> 1) IOVA allocator is still implemented via a tree, we just
> >>>>>>>>>> don't need
> >>>>>>>>>> to store how the IOVA is used
> >>>>>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is
> >>>>>>>>>> used in
> >>>>>>>>>> the datapath SVQ translation
> >>>>>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> His solution is composed of three trees:
> >>>>>>>>> 1) One for the IOVA allocations, so we know where to allocate
> >>>>>>>>> new ranges
> >>>>>>>>> 2) One of the GPA -> SVQ IOVA translations.
> >>>>>>>>> 3) Another one for SVQ vrings translations.
> >>>>>>>>>
> >>>>>
> >>>
> >
> > For my understanding, say we have those 3 memory mappings:
> >
> > HVA                    GPA                IOVA
> > ---------------------------------------------------
> > Map
> > (1) [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000,
> > 0x80000000)
> > (2) [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> > [0x80001000, 0x2000001000)
> > (3) [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> > [0x2000001000, 0x2000021000)
> >
> > And then say when we go to unmap (e.g. vhost_vdpa_svq_unmap_ring)
> > we're given an HVA of 0x7f7903eb0000, which fits in both the first and
> > third mappings.
> >
> > The correct one to remove here would be the third mapping, right? Not
> > only because the HVA range of the third mapping has a more "specific"
> > or "tighter" range fit given an HVA of 0x7f7903eb0000 (which, as I
> > understand, may not always be the case in other scenarios), but mainly
> > because the HVA->GPA translation would give GPA 0xfedb0000, which only
> > fits in the third mapping's GPA range. Am I understanding this correctl=
y?
> You're correct, we would still need a GPA -> IOVA tree for mapping and
> unmapping on guest mem. I've talked to Eugenio this morning and I think
> he is now aligned. Granted, this GPA tree is partial in IOVA space that
> doesn't contain ranges from host-only memory (e.g. backed by SVQ
> descriptors or buffers), we could create an API variant to
> vhost_iova_tree_map_alloc() and vhost_iova_tree_map_remove(), which not
> just adds IOVA -> HVA range to the HVA tree, but also manipulates the
> GPA tree to maintain guest memory mappings, i.e. only invoked from the
> memory listener ops. Such that this new API is distinguishable from the
> one in the SVQ mapping and unmapping path that only manipulates the HVA
> tree.
>

Right, I think I understand both Jason's and your approach better, and
I think it is the best one. To modify the lookup API is hard, as the
caller does not know if the HVA looked up is contained in the guest
memory or not. To modify the add or remove regions is easier, as they
know it.

> I think the only case that you may need to pay attention to in
> implementation is in the SVQ address translation path, where if you come
> to an HVA address for translation, you would need to tell apart which
> tree you'd have to look up - if this HVA is backed by guest mem you
> could use API qemu_ram_block_from_host() to infer the ram block then the
> GPA, so you end up doing a lookup on the GPA tree; or else the HVA may
> be from the SVQ mappings, where you'd have to search the HVA tree again
> to look for host-mem-only range before you can claim the HVA is a
> bogus/unmapped address...

I'd leave this HVA -> IOVA tree for future performance optimization on
top, and focus on the aliased maps for a first series.

However, calling qemu_ram_block_from_host is actually not needed if
the HVA tree contains all the translations, both SVQ and guest buffers
in memory.

> For now, this additional second lookup is
> sub-optimal but inadvitable, but I think both of us agreed that you
> could start to implement this version first, and look for future
> opportunity to optimize the lookup performance on top.
>

Right, thanks for explaining!

> >
> > ---
> >
> > In the case where the first mapping here is removed (GPA [0x0,
> > 0x80000000)), why do we use the word "reintroduce" here? As I
> > understand it, when we remove a mapping, we're essentially
> > invalidating the IOVA range associated with that mapping, right? In
> > other words, the IOVA ranges here don't overlap, so removing a mapping
> > where its HVA range overlaps another mapping's HVA range shouldn't
> > affect the other mapping since they have unique IOVA ranges. Is my
> > understanding correct here or am I probably missing something?
> With the GPA tree I think this case should work fine. I've double
> checked the implementation of vhost-vdpa iotlb, and doesn't see a red
> flag there.
>
> Thanks,
> -Siwei
>


