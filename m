Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13464CFB44C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqz0-0006pT-Tr; Mon, 07 Oct 2024 12:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sxqyy-0006oq-Lf
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sxqyx-00027j-18
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728319994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6F/v8/AKoSk0Mm9eSlgxSnE9cJhVGeB+hWn10hDs/3Y=;
 b=UHT8YVvEAMeElB03gcOqkmJdEzx6mm9ZXltCQFoqc+NfOxwWCwcc3+nd9+Ur0uM7vQuhUM
 B21Wb5yZLWjgAgUo0GHHxFmjPZaUG8dywVkdAxzgbzAo2VP5HbJTMpOoxxyBEz1UHH9b6k
 xD07mHMyTTfdN7f/BQQUBp/B7bcsf0g=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-YC99iMmjMcS_68GxIVV34Q-1; Mon, 07 Oct 2024 12:53:12 -0400
X-MC-Unique: YC99iMmjMcS_68GxIVV34Q-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6e28b624bfcso65163447b3.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319992; x=1728924792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6F/v8/AKoSk0Mm9eSlgxSnE9cJhVGeB+hWn10hDs/3Y=;
 b=gRGJTAbxl5w/h5mygRWO03NMahNtm6UplEIVYWtFbH8BGyRr35/ERPtEfGCrmGZMXO
 2BZYvwSB8sinOIjWQvhbhcTNStCUYBPAy+mPsvATJ2DpVQxpf/002s4KmO8uN/4Oryct
 TmTZeznNAXSeypoM9AdoBQ/xQr6k26InaqRO9fRdVayMaxFgNYgsyS6FknMY8An8qVCs
 w+bRoBqWOsp99jblkTqDSmO5g+35DWoord0ZKv4T+/ZopyGZAaWzm9nDH/s7ZRto0rCf
 IjWgvPEvJBF9tON8V1HSfYZhslfbi3TXspUYN0W7jyLmp5RlhuwvJJHfslBWeNUEx6Na
 Y6jA==
X-Gm-Message-State: AOJu0YyrUns0E7TCgZLUcGbG2hCoFQXOpFtOTdBmKPWJwihK27GDLzrG
 T/OtYRIDH0ZfcVxXyYJFxojJbq3U10opwg54fwlCIG/ZvM4H0HnztRw7jCBHARtCwNhiHZq3+Og
 yGgz29gVDhEO/8IfT0BlKdImgKXGnA4iyUdwuHxTDeIDqrBUQ4GdaCLL8EufKJyTiyMT3n3VyQm
 8DWy/1jfI3z3mN1Faoo4sU4c0M8e8=
X-Received: by 2002:a05:690c:4090:b0:6e2:a88b:9d89 with SMTP id
 00721157ae682-6e2c7017ad9mr71902427b3.11.1728319992419; 
 Mon, 07 Oct 2024 09:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ3yXBXMQyYij9+Y5HoAGfxtojBDYX/haJvxMtuE7/gJG/F5nZJu8J+s0gwbZkUPGniDhDvC90NQayJxiy/Ig=
X-Received: by 2002:a05:690c:4090:b0:6e2:a88b:9d89 with SMTP id
 00721157ae682-6e2c7017ad9mr71902227b3.11.1728319992152; Mon, 07 Oct 2024
 09:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <b229652a-f651-4ecf-adbb-d8e4a45973f4@oracle.com>
In-Reply-To: <b229652a-f651-4ecf-adbb-d8e4a45973f4@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 7 Oct 2024 18:52:35 +0200
Message-ID: <CAJaqyWcTwR8vsDax_KzakpBmFBq7_EMSDNyz2DAa4Ai2q3MP-Q@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 7, 2024 at 5:38=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 10/7/24 9:51 AM, Eugenio Perez Martin wrote:
> > On Fri, Oct 4, 2024 at 8:48=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >>
> >>
> >>
> >> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM Jonah Palmer <jonah.palmer@ora=
cle.com> wrote:
> >>>>
> >>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
> >>>> translations for guest memory regions.
> >>>>
> >>>> When the guest has overlapping memory regions, an HVA to IOVA transl=
ation
> >>>> may return an incorrect IOVA when searching the IOVA->HVA tree. This=
 is
> >>>> due to one HVA range being contained (overlapping) in another HVA ra=
nge
> >>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPA=
s to
> >>>> translate and find the correct IOVA for guest memory regions.
> >>>>
> >>>
> >>> Yes, this first patch is super close to what I meant, just one issue
> >>> and a pair of nits here and there.
> >>>
> >>> I'd leave the second patch as an optimization on top, if the numbers
> >>> prove that adding the code is worth it.
> >>>
> >>
> >> Ah okay, gotcha. I also wasn't sure if what you mentioned below on the
> >> previous series you also wanted implemented or if these would also be
> >> optimizations on top.
> >>
> >> [Adding code to the vhost_iova_tree layer for handling multiple buffer=
s
> >> returned from translation for the memory area where each iovec covers]=
:
> >> ----------------------------------------------------------------------=
-
> >> "Let's say that SVQ wants to translate the HVA range
> >> 0xfeda0000-0xfedd0000. So it makes available for the device two
> >> chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other on=
e
> >> with addr=3D(0x20000c1000 len=3D0x10000).
> >>
> >> The VirtIO device should be able to translate these two buffers in
> >> isolation and chain them. Not optimal but it helps to keep QEMU source
> >> clean, as the device already must support it."
> >>
> >
> > This is 100% in the device and QEMU is already able to split the
> > buffers that way, so we don't need any change in QEMU.
> >
> >> [Adding a permission check to iova_tree_find_address_iterator and matc=
h
> >> the range by permissions]:
> >> ----------------------------------------------------------------------=
-
> >> "About the permissions, maybe we can make the permissions to be part o=
f
> >> the lookup? Instead of returning them at iova_tree_find_iova, make
> >> them match at iova_tree_find_address_iterator."
> >>
> >
> > Ouch, I forgot this part. This is a small change we also need, can you
> > add it for the next version? Thanks for remind it!
> >
>
> Sure can!
>
> I apologize for my lack of understanding on this, but for example in
> vhost_svq_translate_addr, how do we know what the permissions are for
> the addresses we're translating?
>

No need to apologize :).

The calling function, vhost_svq_vring_write_descs, knows if they are
RW (write=3Dtrue) or RO (write=3Dfalse). We need to pass the parameter to
vhost_svq_translate_addr.

> I'm not sure if this is always true or not, but if the address that
> we're translating is backed by guest memory, then can we always say that
> the permission for the mapping would be IOMMU_RW (since the OS needs to
> be able to modify it)?. Likewise, for addresses backed by host-only
> memory, can we always say that the permission for the mapping would be
> IOMMU_RO to avoid accidental modifications by the guest?
>

Not really, there are parts of the guest memory that are RO and the
SVQ's used ring in the host memory is RW.

It should be enough to check that the write bit is enabled in the
flags & is requested.

> If so, this would mean that these mappings would never have the
> IOMMU_NONE or IOMMU_WO permissions, right?
>

That's right.


