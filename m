Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B4DC021A0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 02:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tilFx-0003VF-Mm; Thu, 13 Feb 2025 21:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tilFv-0003V4-S7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 21:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tilFt-0007MG-Mk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 21:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739499394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDTezo6UcWt2OsUwXzx9tvJZP+31X+X9ZwmnRiaLcBE=;
 b=c8dU8ZULXI5U8y3wG2FlgRu0/Xt+687tfk6lA9mZbe3aMecWRAqVO2h13KI2qJwEVxKYsp
 4eVIXGW7G2OBHTHDX6IKxOj6BSPwnr3P3dExNPedfrzGbcWuQP99mV5qw6MqYBmK+fZLiU
 xIin8O1cDs5Mk8wjJb7GQetD6rfN8yk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-OIQPGnbcPIuYMccb1PdCgQ-1; Thu, 13 Feb 2025 21:16:32 -0500
X-MC-Unique: OIQPGnbcPIuYMccb1PdCgQ-1
X-Mimecast-MFC-AGG-ID: OIQPGnbcPIuYMccb1PdCgQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7f3ad7757so192483566b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 18:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739499391; x=1740104191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDTezo6UcWt2OsUwXzx9tvJZP+31X+X9ZwmnRiaLcBE=;
 b=ZNYVYsIMRjwAIzapCMKNVDvBEu98aQFSaOyMsf9z5t6EoTMOH6Ws4NzJjwlKBfJCaC
 81pdI9mV3mfaD38yMqh1XNtPgKOQinQhidRjF5jSN/RN2ujlTPvymG43/CozwkxSpl4D
 Dvp1bbNq0sAlaMBQh6QwITIrmzrRigh68NR9hztsH815N8g7e/hrcTDAz7iVJDgdmImN
 egDxSgzvAOEWfxakOUnfE1XZwbGNe6sCDiPpQttQlyBlEZF2Rz5+RbUT9euh6J7VrBFj
 zJcMgtTQ4BfI89CC13S1o4dMF0qID/1JTWONDtKuqmNRVorSANQhNOXDqAb7yrBurMg/
 aF4Q==
X-Gm-Message-State: AOJu0YyAIUQy8GqapvLSEeeDa2lDbTtvdng+ph5SiFY1+65P7mi526Vb
 eiBMuQ4z+J6JOmWPOYVKVIGEBjjjrcD85Rm30cU6pFQHvZrOfvzr52EANn5IeL+vIKkPKSF/MVf
 YxX//iNgXjI6umQ3KP+mDoC4X65tJ+IHQbO5nvLV5bZxmQlYendj/LnfLztHHU0GDRJcoMUNuFJ
 Z0A3cWT8Xls5FH48kPtIDY0tHbf1M=
X-Gm-Gg: ASbGncuctshAp1ahpltaXD6jzWiOmt+h+Z7Y6INJYer/0oqZZxboe1dN1jk4FqOGwWB
 TKZEJGckSAL6iIdCwlG/hE+u1zVv04LEEpSNJNdU8GOGxZY0ZywqQpKtVs7dk1lg=
X-Received: by 2002:a17:907:6d19:b0:ab7:db71:2975 with SMTP id
 a640c23a62f3a-ab7f33d374amr994822766b.31.1739499391178; 
 Thu, 13 Feb 2025 18:16:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOs+/3d5Egwwz72cleulPzFukJX/l7Jw6/eLN/wL1rbKYDCUTH15NWjJ2dlfZcpiiSmU5enWMd1YDDB+5o29k=
X-Received: by 2002:a17:907:6d19:b0:ab7:db71:2975 with SMTP id
 a640c23a62f3a-ab7f33d374amr994821466b.31.1739499390786; Thu, 13 Feb 2025
 18:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20250205145813.394915-1-jonah.palmer@oracle.com>
 <CAJaqyWe=vyx0CW+qaJ+3m6hODg5B7=xcXvaKaGDSztBcwa++EA@mail.gmail.com>
In-Reply-To: <CAJaqyWe=vyx0CW+qaJ+3m6hODg5B7=xcXvaKaGDSztBcwa++EA@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 14 Feb 2025 10:15:53 +0800
X-Gm-Features: AWEUYZnD9JD2zEV58bEUIX8I6KbNcpFBRiZ9SHhZMB0nPonjIq5YJPVCry0D_7I
Message-ID: <CAPpAL=ySaeZCm0gCxv=gJOTO=4Qn1aTw9Wn+DtZwQ085m+3wVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Handling aliased guest memory maps in vhost-vDPA SVQs
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com, 
 Eugenio Perez Martin <eperezma@redhat.com>, dtatulea@nvidia.com,
 jasowang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I tested this series patches with vdpa's regression tests, everything
works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Feb 12, 2025 at 12:20=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Feb 5, 2025 at 3:58=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
> >
> > An issue arises from aliased memory mappings in the guest, where
> > different GPAs map to the same HVA. For example:
> >
> >  - GPA1->HVA1
> >  - GPA2->HVA1
> >
> > When these mappings exist in the IOVA->HVA tree, a lookup by an HVA
> > backed by guest memory results in ambiguities because the same HVA coul=
d
> > correspond to multiple GPAs. This duplication causes issues in managing
> > IOVA trees for SVQs in vDPA, leading to incorrect behavior.
> >
> > For example, consider these mapped guest memory regions:
> >
> >               HVA                            GPA                       =
  IOVA
> > -------------------------------  --------------------------- ----------=
------------------
> > [0x7f7903e00000, 0x7f7983e00000) [0x0, 0x80000000)           [0x1000, 0=
x80000000)
> > [0x7f7983e00000, 0x7f9903e00000) [0x100000000, 0x2080000000) [0x8000100=
0, 0x2000001000)
> > [0x7f7903ea0000, 0x7f7903ec0000) [0xfeda0000, 0xfedc0000)    [0x2000001=
000, 0x2000021000)
> >
> > The last HVA range [0x7f7903ea0000, 0x7f7903ec0000) is contained within
> > the first HVA range [0x7f7903e00000, 0x7f7983e00000). Despite this, the
> > GPA ranges for the first and third mappings do not overlap, so the gues=
t
> > sees them as distinct physical memory regions.
> >
> > Now consider an operation to unmap the mapping associated with HVA
> > 0x7f7903eb0000. This HVA fits into both the first and third HVA ranges.
> >
> > When searching the HVA->IOVA tree, the search stops at the first
> > matching HVA range [0x7f7903e00000, 0x7f7983e00000) due to the behavior
> > of the red-black tree (GTree). However, the correct mapping to remove i=
s
> > the third mappings, as the HVA translate to GPA 0xfedb0000, which only
> > fits in the third mapping's GPA range.
> >
> > To address this, we implement a GPA->IOVA tree and use the GPAs of
> > descriptors backed by guest memory when translating to IOVA.
> >
> > When a descriptor's GPA is used for translation, the GPA->IOVA tree
> > ensures that each GPA maps to exactly one IOVA, regardless of any
> > overlapping HVAs. This guarantees that operations such as unmapping or
> > accessing a descriptor correctly targets the intended memory region in
> > the guest's address space.
> >
> > For descriptors not backed by guest memory, the existing IOVA->HVA tree
> > is still used.
> >
> > GPAs are unique and non-overlapping within the guest's address space. B=
y
> > translating GPAs to IOVAs, the ambiguity caused by multiple GPAs mappin=
g
> > to the same HVA is avoided.
> >
>
> I'd squash patches 2 and 3. While it adds some clarification, I think
> it is not worth adding the code to remove it.
>
> Either way,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>
> > --------
> > This series is a different approach of [1] and is based off of [2],
> > where this issue was originally discovered.
> >
> > Patch v1:
> > ---------
> >  * Created separate alloc functions for guest-backed and host-only
> >    memory.
> >  * Alloc functions also insert mappings to their respective trees.
> >  * Make patches self-contained and functional to prevent breakage durin=
g
> >    bisection.
> >  * Don't move range checks from alloc functions.
> >  * Use existing VirtQueueElement members 'in_addr' & 'out_addr' instead
> >    of creating custom 'in_xlat_addr' & 'out_xlat_addr' members.
> >  * Move documentation changes to separate patch.
> >
> > RFC v3:
> > -------
> >  * Decouple the IOVA allocator to support a SVQ IOVA->HVA tree for
> >    host-only mappings.
> >  * Move range check for IOVA allocator to its own patch.
> >  * Implement a GPA->IOVA tree alongside the SVQ IOVA->HVA & IOVA-only
> >    trees.
> >  * Add in_xlat_addr & out_xlat_addr VirtQueueElement members to hold th=
e
> >    GPAs of an element's input/output descriptors (to be used during
> >    translation).
> >
> > RFC v2:
> > -------
> >  * Don't decouple IOVA allocator.
> >  * Build a IOVA->GPA tree (instead of GPA->IOVA tree).
> >  * Remove IOVA-only tree and keep the full IOVA->HVA tree.
> >  * Only search through RAMBlocks when we know the HVA is backed by
> >    guest memory.
> >  * Slight rewording of function names.
> >
> > RFC v1:
> > -------
> >  * Alternative approach of [1].
> >  * First attempt to address this issue found in [2].
> >
> > [1] https://lore.kernel.org/qemu-devel/20240410100345.389462-1-eperezma=
@redhat.com
> > [2] https://lore.kernel.org/qemu-devel/20240201180924.487579-1-eperezma=
@redhat.com
> >
> > Jonah Palmer (4):
> >   vhost-iova-tree: Implement an IOVA-only tree
> >   vhost-iova-tree: Implement GPA->IOVA & partial IOVA->HVA trees
> >   svq: Support translations via GPAs in vhost_svq_translate_addr
> >   vhost-iova-tree: Update documentation
> >
> >  hw/virtio/vhost-iova-tree.c        | 115 ++++++++++++++++++++++++-----
> >  hw/virtio/vhost-iova-tree.h        |   8 +-
> >  hw/virtio/vhost-shadow-virtqueue.c |  55 +++++++++-----
> >  hw/virtio/vhost-shadow-virtqueue.h |   5 +-
> >  hw/virtio/vhost-vdpa.c             |  40 ++++++----
> >  include/qemu/iova-tree.h           |  22 ++++++
> >  net/vhost-vdpa.c                   |  12 ++-
> >  util/iova-tree.c                   |  46 ++++++++++++
> >  8 files changed, 248 insertions(+), 55 deletions(-)
> >
> > --
> > 2.43.5
> >
>


