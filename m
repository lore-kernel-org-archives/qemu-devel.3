Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A956C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvAgo-0007PV-7J; Fri, 12 Apr 2024 02:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rvAgm-0007PG-DI
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rvAgk-00085V-Tw
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712904426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viHg+oF+OZPWVX7w1dEy85oREcDGrcMcRqa0kQ8Bo1A=;
 b=YURO6MupfxFpagAKUhaQZQ9cztyX62E9rInJ1n/p0h4bpc7zqnwcFPN2lSofjfZvaACXCu
 R4qijXjncXRMB8I7ucpf7lGRFdsfh2Bxgun5+kagwv6WTdJtCvdCtDj7OooRI1jERqdZ5W
 PEXgz58OK1hdLX4DjlKgzX2mD3LFhaA=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-9-nrTAqZPeOTJzgdN6W8jw-1; Fri, 12 Apr 2024 02:47:03 -0400
X-MC-Unique: 9-nrTAqZPeOTJzgdN6W8jw-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4d40305ddb3so225240e0c.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 23:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712904423; x=1713509223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viHg+oF+OZPWVX7w1dEy85oREcDGrcMcRqa0kQ8Bo1A=;
 b=FoiQQXTW92quHA7Hdtv/lvuUl7fT+G2wULK/vE2eImujlbC4o6Ee0+3MSAo/Ob7All
 0qO4DnDjRVVVyyDHW5f70AKWbL0p4I/0KSKhlLufOkcKEETD3kHCiey1f8vFBSHKRqf1
 Z7uiXr3Z/byRDCr4afhwzJrpyrog5t8H0/g636o6xx6MMkwiPmnrRHdHoPvSe42WIXV8
 YCpyWdNCe4E1SS8dxIfeRAh/3Q7GYkQUCuyrvnKP5+3YwnRh9nmgsBBGsvcytGjL5jJ6
 NipPP1WIPhc28UerCkvEKucGb+mUolq2Tqt1nz5sGzhqYtfH6hL1W2Pw5jr/35as+9ws
 5Rbw==
X-Gm-Message-State: AOJu0YxcIJOodYxjUW0KPPLWMD30aX41JM02qY83BXQ4sK3mMNdkHVBe
 5OyGeoCgL1uIQ2FOkwKOjFeeWa+XVfjW7Z7io74wF+YkciXPZ1yZpV2aVtwxW5gzd8Z2Ev5Ul0J
 nnebI5JKumSYBz59/mVj5DTgu2P1ksyTkjfbXjCWBJ1Bmc4itLrPYj77K/4R0zKD3oqqDbaujLU
 vr5P/NxZhJE+dVe9s6x9JlIlXykB4=
X-Received: by 2002:a05:6102:471b:b0:47a:29bb:741f with SMTP id
 ei27-20020a056102471b00b0047a29bb741fmr1994576vsb.30.1712904423256; 
 Thu, 11 Apr 2024 23:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3gGdpEJv6NdJIeFNRCPfbiJvS3NUBqD/jZVPvOJwDxGORGtbniZVKBzQQVCM3XAHKCY4K32mTv+Lu1PwtNg0=
X-Received: by 2002:a05:6102:471b:b0:47a:29bb:741f with SMTP id
 ei27-20020a056102471b00b0047a29bb741fmr1994561vsb.30.1712904422996; Thu, 11
 Apr 2024 23:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
In-Reply-To: <20240410100345.389462-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 14:46:51 +0800
Message-ID: <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> The guest may have overlapped memory regions, where different GPA leads
> to the same HVA.  This causes a problem when overlapped regions
> (different GPA but same translated HVA) exists in the tree, as looking
> them by HVA will return them twice.

I think I don't understand if there's any side effect for shadow virtqueue?

Thanks

>
> To solve this, track GPA in the DMA entry that acs as unique identifiers
> to the maps.  When the map needs to be removed, iova tree is able to
> find the right one.
>
> Users that does not go to this extra layer of indirection can use the
> iova tree as usual, with id =3D 0.
>
> This was found by Si-Wei Liu <si-wei.liu@oracle.com>, but I'm having a ha=
rd
> time to reproduce the issue.  This has been tested only without overlappi=
ng
> maps.  If it works with overlapping maps, it will be intergrated in the m=
ain
> series.
>
> Comments are welcome.  Thanks!
>
> Eugenio P=C3=A9rez (2):
>   iova_tree: add an id member to DMAMap
>   vdpa: identify aliased maps in iova_tree
>
>  hw/virtio/vhost-vdpa.c   | 2 ++
>  include/qemu/iova-tree.h | 5 +++--
>  util/iova-tree.c         | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> --
> 2.44.0
>


