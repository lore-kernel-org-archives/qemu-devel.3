Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3E4C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht0K-00059S-LQ; Tue, 11 Feb 2025 11:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tht0H-00058U-40
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tht0E-0002Eu-QG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739290848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmL8zCEomqqeH6TBCgFCx6NLF8jU5/YK9n5VSswWW1o=;
 b=jWSc80NG6u8T2DxLx3Chn/1IwPCrzAw/QkDZZispPSM9upLIuEJru6H5ESINHUbmPmQS08
 THJI9SrtYN0jqte5aIVLfdR2hQ6yRO4Jk6cSNpJuS0aXEAFuBW/u77kGXeI9jOMkUUQLJE
 ByKawWLyG+UWaJKA1OMczEr86osNnps=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-HjcuZLLZPbqft_softg5QA-1; Tue, 11 Feb 2025 11:20:45 -0500
X-MC-Unique: HjcuZLLZPbqft_softg5QA-1
X-Mimecast-MFC-AGG-ID: HjcuZLLZPbqft_softg5QA
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e02fff66a83so6614833276.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739290845; x=1739895645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmL8zCEomqqeH6TBCgFCx6NLF8jU5/YK9n5VSswWW1o=;
 b=uC2ILsVKPwE2kMcKzvPhDmgXzC4C+AxsVdOh/tJHZBHpmdsvvTLyMEeZiYFWifuNET
 Dq0UI0iVlmRnHaInggLSuKYMBXYtTfKeEUPESS6vZ6A55uThZwkKoP/4vi1r+ipnCnDZ
 Gk3V4PCcV2ukTmf4YnZXObni8/z3DzWVE3RIXfzhbjwJ3xGEnH4NhkF8qAyZzn6s6Vu/
 Wx2W5nb/W7tY6I6fuVQN4VZm9XHQCKPbMs9LHu74yu8IWKGQZvoO0u8VL7hL1t25jpek
 r31amLD19ybiFf9h25IDoVFuwMhoH/CVcjmFmA+xp3tBwzznENMs7x7G3vKYmKmRzOaA
 T2cQ==
X-Gm-Message-State: AOJu0YzKSQC4DaEzH8HNvpR9hIbTzFoVITsMMt4e9uYNfQrg/mAdGnhL
 ce0i/1BGw8pvV4c7XCk2QVOH7Lcf4SXFYCcesYasr1DGeyxmmsR0LLW28X+7m8+Yeqft4WPkUyy
 P72Bu1711G5PXEZF4Cv6em+eQGrIR1temhghdTeQnTLY+kGHCpO1EJREDquFOY7dYZ/aQBA959+
 QPnnlc3fYrErHOgr7VnnwLTmTV/cM=
X-Gm-Gg: ASbGncuqYKB2lcRp50sZf9I7P89iDRs3fZBTNyq2feO/BbNcK47HAemKHgPW42VxU9K
 Gpe9yajkfWDuR+iin8ZbanxaG1r5gyGgF1/yt8me4EQq+FeFkrZRJYcbyS3n+
X-Received: by 2002:a05:6902:1085:b0:e58:3741:2749 with SMTP id
 3f1490d57ef6-e5d9e88adfemr385081276.40.1739290844698; 
 Tue, 11 Feb 2025 08:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVnydcg91cmv/xZYrDKNH4l+wGY/ti0/Df3rLNrmF+K3pmTROy0cd0qEROQyHWdSaQYicQbvL5KIEIjwGn+hI=
X-Received: by 2002:a05:6902:1085:b0:e58:3741:2749 with SMTP id
 3f1490d57ef6-e5d9e88adfemr384996276.40.1739290843984; Tue, 11 Feb 2025
 08:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20250205145813.394915-1-jonah.palmer@oracle.com>
In-Reply-To: <20250205145813.394915-1-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Feb 2025 17:20:07 +0100
X-Gm-Features: AWEUYZl0cBloY_2NnGkeARu-XLws6ljzKI7b0qQv7VmeNL7Fe3BoRyYdVs8si-Y
Message-ID: <CAJaqyWe=vyx0CW+qaJ+3m6hODg5B7=xcXvaKaGDSztBcwa++EA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Handling aliased guest memory maps in vhost-vDPA SVQs
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 5, 2025 at 3:58=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> An issue arises from aliased memory mappings in the guest, where
> different GPAs map to the same HVA. For example:
>
>  - GPA1->HVA1
>  - GPA2->HVA1
>
> When these mappings exist in the IOVA->HVA tree, a lookup by an HVA
> backed by guest memory results in ambiguities because the same HVA could
> correspond to multiple GPAs. This duplication causes issues in managing
> IOVA trees for SVQs in vDPA, leading to incorrect behavior.
>
> For example, consider these mapped guest memory regions:
>
>               HVA                            GPA                         =
IOVA
> -------------------------------  --------------------------- ------------=
----------------
> [0x7f7903e00000, 0x7f7983e00000) [0x0, 0x80000000)           [0x1000, 0x8=
0000000)
> [0x7f7983e00000, 0x7f9903e00000) [0x100000000, 0x2080000000) [0x80001000,=
 0x2000001000)
> [0x7f7903ea0000, 0x7f7903ec0000) [0xfeda0000, 0xfedc0000)    [0x200000100=
0, 0x2000021000)
>
> The last HVA range [0x7f7903ea0000, 0x7f7903ec0000) is contained within
> the first HVA range [0x7f7903e00000, 0x7f7983e00000). Despite this, the
> GPA ranges for the first and third mappings do not overlap, so the guest
> sees them as distinct physical memory regions.
>
> Now consider an operation to unmap the mapping associated with HVA
> 0x7f7903eb0000. This HVA fits into both the first and third HVA ranges.
>
> When searching the HVA->IOVA tree, the search stops at the first
> matching HVA range [0x7f7903e00000, 0x7f7983e00000) due to the behavior
> of the red-black tree (GTree). However, the correct mapping to remove is
> the third mappings, as the HVA translate to GPA 0xfedb0000, which only
> fits in the third mapping's GPA range.
>
> To address this, we implement a GPA->IOVA tree and use the GPAs of
> descriptors backed by guest memory when translating to IOVA.
>
> When a descriptor's GPA is used for translation, the GPA->IOVA tree
> ensures that each GPA maps to exactly one IOVA, regardless of any
> overlapping HVAs. This guarantees that operations such as unmapping or
> accessing a descriptor correctly targets the intended memory region in
> the guest's address space.
>
> For descriptors not backed by guest memory, the existing IOVA->HVA tree
> is still used.
>
> GPAs are unique and non-overlapping within the guest's address space. By
> translating GPAs to IOVAs, the ambiguity caused by multiple GPAs mapping
> to the same HVA is avoided.
>

I'd squash patches 2 and 3. While it adds some clarification, I think
it is not worth adding the code to remove it.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> --------
> This series is a different approach of [1] and is based off of [2],
> where this issue was originally discovered.
>
> Patch v1:
> ---------
>  * Created separate alloc functions for guest-backed and host-only
>    memory.
>  * Alloc functions also insert mappings to their respective trees.
>  * Make patches self-contained and functional to prevent breakage during
>    bisection.
>  * Don't move range checks from alloc functions.
>  * Use existing VirtQueueElement members 'in_addr' & 'out_addr' instead
>    of creating custom 'in_xlat_addr' & 'out_xlat_addr' members.
>  * Move documentation changes to separate patch.
>
> RFC v3:
> -------
>  * Decouple the IOVA allocator to support a SVQ IOVA->HVA tree for
>    host-only mappings.
>  * Move range check for IOVA allocator to its own patch.
>  * Implement a GPA->IOVA tree alongside the SVQ IOVA->HVA & IOVA-only
>    trees.
>  * Add in_xlat_addr & out_xlat_addr VirtQueueElement members to hold the
>    GPAs of an element's input/output descriptors (to be used during
>    translation).
>
> RFC v2:
> -------
>  * Don't decouple IOVA allocator.
>  * Build a IOVA->GPA tree (instead of GPA->IOVA tree).
>  * Remove IOVA-only tree and keep the full IOVA->HVA tree.
>  * Only search through RAMBlocks when we know the HVA is backed by
>    guest memory.
>  * Slight rewording of function names.
>
> RFC v1:
> -------
>  * Alternative approach of [1].
>  * First attempt to address this issue found in [2].
>
> [1] https://lore.kernel.org/qemu-devel/20240410100345.389462-1-eperezma@r=
edhat.com
> [2] https://lore.kernel.org/qemu-devel/20240201180924.487579-1-eperezma@r=
edhat.com
>
> Jonah Palmer (4):
>   vhost-iova-tree: Implement an IOVA-only tree
>   vhost-iova-tree: Implement GPA->IOVA & partial IOVA->HVA trees
>   svq: Support translations via GPAs in vhost_svq_translate_addr
>   vhost-iova-tree: Update documentation
>
>  hw/virtio/vhost-iova-tree.c        | 115 ++++++++++++++++++++++++-----
>  hw/virtio/vhost-iova-tree.h        |   8 +-
>  hw/virtio/vhost-shadow-virtqueue.c |  55 +++++++++-----
>  hw/virtio/vhost-shadow-virtqueue.h |   5 +-
>  hw/virtio/vhost-vdpa.c             |  40 ++++++----
>  include/qemu/iova-tree.h           |  22 ++++++
>  net/vhost-vdpa.c                   |  12 ++-
>  util/iova-tree.c                   |  46 ++++++++++++
>  8 files changed, 248 insertions(+), 55 deletions(-)
>
> --
> 2.43.5
>


