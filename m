Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF031C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjkE-0003YU-BD; Wed, 07 Aug 2024 12:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sbjkC-0003Pu-Bh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sbjkA-0006LJ-5z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723048951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGiB+E3DRpmN1IjdRxWjcF8QrKtTv7J7kN2rGddoucQ=;
 b=CL5APFrs+8CvEN6HyxxjWiCp8es0AFdSS+nNhvPrnJ74aKdU+EneA6Op4zw5qWFzgD4WFT
 71jCgNRfvvuSxoqtPwiV70fX5oaOGjXH2FM+b0px0gZmE6P5C+L6xkRw4QhSMeP2Fp9tmB
 odYKRcIe1qO9yaYmgRK9WGUrhe8X9Gk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-RBPslv-DP_2yE7jMiNrNEQ-1; Wed, 07 Aug 2024 12:42:29 -0400
X-MC-Unique: RBPslv-DP_2yE7jMiNrNEQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6643016423fso742957b3.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723048949; x=1723653749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGiB+E3DRpmN1IjdRxWjcF8QrKtTv7J7kN2rGddoucQ=;
 b=dykYOPwHqPraxfEZKJOta020agj9LA4IRs0GI8wuArXgGSeTnq9lRF4vVzHnJVuxgL
 C4K8Q92Z1xBFK9YtkCbNwL4k2/5xevBS6ySHDxY1W2q5y0Fzlc2baul9J/yaC1ZLEN1L
 r650Xl1WezZzjVu+9tbDBzoYS/L1iWFWxcwJToPVvU8HnD4UPncPq+yOpxlYeF87CckR
 eilbDc3gIDFpeeNqnabt3koYCAdFhu5e3x73aeuAN1NZXuPnuVL6DnRbvyGi45vDgI9H
 sEq3wnUk4NC+LqF4B6eSOvxq5aYktL2K394xgi/SNTkxoJRFA1eQkcuCbXSEroob+Zl1
 1Gpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLR2fYkgvMYVdd6tXlEmIknahXvGbsA8w3qujZNIAFOElO7NMnycSs8rYVxLWRhPlOUn13ltb9x2wdR3SMF6K9wczkeWk=
X-Gm-Message-State: AOJu0Yybk8BHomoqqLzskTnuqnmDompP8AzEKeMPZLplQ6WT3xUscLhO
 otjJFV5LvZJhEET+ewEPu20tuPm2WZTxtuY2Zaup6ftwXVonjQkZYIDMrFF75u7lDJVZ04Kdr9j
 89Wtr/gCjoRejkrb4Hu73HfdneXKlDCPS0LdomXpmAlp+YmvrFtEpUkYbBxmP7FaTLY0FDI/jCR
 C5XKN4sj+CCT9BQkt8w+zX/wgl8Vw=
X-Received: by 2002:a81:b407:0:b0:615:1ad2:1102 with SMTP id
 00721157ae682-689601abbfdmr202963177b3.11.1723048949358; 
 Wed, 07 Aug 2024 09:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV1k68qFEQAlwrimexFRZB7X0BN7JrlrtGXk7M4uBoaSbybObn+V1slWFkpFMMUI/o/va145VhJuoKAZiGRKA=
X-Received: by 2002:a81:b407:0:b0:615:1ad2:1102 with SMTP id
 00721157ae682-689601abbfdmr202962497b3.11.1723048948085; Wed, 07 Aug 2024
 09:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
In-Reply-To: <20240802112138.46831-1-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 18:41:52 +0200
Message-ID: <CAJaqyWfZ=Q-+Yvv2Vb7jAGcoDvoEBFFyAdh3omTUqbVn=DKyDg@mail.gmail.com>
Subject: Re: [RFC v3 0/3] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Hi,
>
> Here's a new patch series that incorporates all
> the suggested changes from v2.
>
> I have tried my best to deduplicate the implementation.
> Please let me know if I have missed something.
>

I think they are in good shape :).

> I'll also test these changes out by following the
> suggestions given in response to v1. I'll have more
> confidence once I know these changes work.
>

Please let me know if you need help with the testing!

> Thanks,
> Sahil
>
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg03417.htm=
l
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06196.htm=
l
>
> Changes v2 -> v3:
> * vhost-shadow-virtqueue.c
>   - Move parts common to "vhost_svq_add_split" and
>     "vhost_svq_add_packed" to "vhost_svq_add".
>   (vhost_svq_add_packed):
>   - Refactor to minimize duplicate code between
>     this and "vhost_svq_add_split"
>   - Fix code style issues.
>   (vhost_svq_add_split):
>   - Merge with "vhost_svq_vring_write_descs()"
>   - Refactor to minimize duplicate code between
>     this and "vhost_svq_add_packed"
>   (vhost_svq_add):
>   - Refactor to minimize duplicate code between
>     split and packed version of "vhost_svq_add"
>   (vhost_svq_memory_packed): New function
>   (vhost_svq_start):
>   - Remove common variables out of if-else branch.
>   (vhost_svq_stop):
>   - Add support for packed vq.
>   (vhost_svq_get_vring_addr): Revert changes
>   (vhost_svq_get_vring_addr_packed): Likwise.
> * vhost-shadow-virtqueue.h
>   - Revert changes made to "vhost_svq_get_vring_addr*"
>     functions.
> * vhost-vdpa.c: Revert changes.
>
> Sahil Siddiq (3):
>   vhost: Introduce packed vq and add buffer elements
>   vhost: Data structure changes to support packed vqs
>   vhost: Allocate memory for packed vring
>
>  hw/virtio/vhost-shadow-virtqueue.c | 230 ++++++++++++++++++++---------
>  hw/virtio/vhost-shadow-virtqueue.h |  70 ++++++---
>  2 files changed, 206 insertions(+), 94 deletions(-)
>
> --
> 2.45.2
>


