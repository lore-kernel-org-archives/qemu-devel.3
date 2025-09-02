Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E9ECA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNuO-00025s-Vr; Tue, 02 Sep 2025 06:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNuH-0001zc-9I
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:06:29 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNuF-0005Xd-63
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:06:29 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e96ff518c08so4229782276.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756807585; x=1757412385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nUtg0NfjgMS6VqrAMD7abuPWLy0kNYoziKDXF8HwgLM=;
 b=M7QMFVe58fpFnVvWEX6VkRtA95MT+9ca70kdcHfmWyvuYMPQjjSBwuctgv906tT36I
 VOvFd/8jHdmEfZctUNOF4VCTRHAm0pxfcLnsz/RAbv5GrhLd3GRwbwD9go1RiMTZuJYi
 x24SAfe239ENPAfgptkyfDEkqZIND0yAylDWRP4+wkw+prlojS3dOy2ylcW9W6PLzkwJ
 igEr/jmCgg7/YIkAvy3FEKIom3no1ZvLr3leNqpAwE6ZxkMgmi1XKhzHXohHKaQbd9c0
 Q+HPvTgVHTcgbpeGviSQszazUiA0MD9zql2I99D8suACMuy0rH10EvaSkmz+q8s/hT6r
 BE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756807585; x=1757412385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUtg0NfjgMS6VqrAMD7abuPWLy0kNYoziKDXF8HwgLM=;
 b=Q5+A7l0PwD64vsUidogwQCftmoSbEccKohcTfQWqt/A1p8FoN84eHEPE32cx0EW+JT
 wTffZJLizYUrI9evtFCcoNRxgFKnapBp4qBxpVIpazKUnbdb9AfsMCKtuqm105Sp3rz7
 YQ1ZJGpoVr7nS5+EXQ2HJWHHQ5VvGSojk6DYdDXZ1HlCrNdg/Jo5dJGQwhT2dcrXhMuZ
 hSB3Lz7S4EdnAanrSMm/Lda39irPxyqLOl3U9NkQvuczy6DS0Rk/jF+b23Oeg+NNPX2n
 +ZUP95hnKGtY37kDB6nbEMxqP2tLJk9UGaxjyzrJKO3/8gY2KZqklK5twmVESuLagrUZ
 N6eA==
X-Gm-Message-State: AOJu0YxbaEVyZW5U7kOZgfih92/kdolqLgeh6l1bZbyvJWsKppP3pnZ+
 YGh4bw1/BYM1fcQluK9oN+Ir6f1Xi9PMe1rb/Zjjl/Cx2Oy9cP279VP0dwndhnYS/3Nw52TGpsu
 yKxpb8DKSyAA/G17WWxN/0n1ZoSpkqs1b7uBHqOvOJg==
X-Gm-Gg: ASbGncuc/cvb7XVL3qYdOYwhkPIqHkC/48RsKXJHkFKvLQVuO4J85VUlVEbj6sH2k8e
 6/9tXONNgNIWnBFL+by0uXYJ92N/KYPTq25JorMMk5MZ5qvkMm3MhQfVLOkchMe5A1PrlTI71EX
 eEP/Z+t1aZfZhdZb7kbmTwXZ2VSQiZiYwv6WTmgKuO37BTG4Y9etw65upLBXdbI8W9biw2ksTAc
 H07jbLA
X-Google-Smtp-Source: AGHT+IESuJFfPQqcx/PfjGYCuGeUkFUptrs52xgu7W4zYNFa3OFTZaYJ+EEAnp07RCrOe2d4wMzOyMQ1Pv733gLYFYI=
X-Received: by 2002:a05:690c:61c6:b0:721:6667:60a0 with SMTP id
 00721157ae682-722764acdd2mr110877237b3.31.1756807585393; Tue, 02 Sep 2025
 03:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250826221750.285242-1-peterx@redhat.com>
In-Reply-To: <20250826221750.285242-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 11:06:13 +0100
X-Gm-Features: Ac12FXzA6a4tcbYYef0OKdvmO6y8RUH86oFN6UkSxJgy3GIn4lh0fFuwI8uDdNY
Message-ID: <CAFEAcA-4pqbqSwiHtpVnRE0taReP7evnwwTtekRMGo307NN=mQ@mail.gmail.com>
Subject: Re: [PATCH] memory: Fix leaks due to owner-shared MRs circular
 references
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 26 Aug 2025 at 23:20, Peter Xu <peterx@redhat.com> wrote:
>
> Currently, QEMU refcounts the MR by always taking it from the owner.
>
> It's common that one object will have multiple MR objects embeded in the
> object itself.  All the MRs in this case share the same lifespan of the
> owner object.
>
> It's also common that in the instance_init() of an object, MR A can be a
> container of MR B, C, D, by using memory_region_add_subregion*() set of
> memory region APIs.
>
> Now we have a circular reference issue, as when adding subregions for MR A,
> we essentially incremented the owner's refcount within the instance_init(),
> meaning the object will be self-boosted and its refcount can never go down
> to zero if the MRs won't get detached properly before object's finalize().
>
> Delete subregions within object's finalize() won't work either, because
> finalize() will be invoked only if the refcount goes to zero first.  What
> is worse, object_finalize() will do object_property_del_all() first before
> object_deinit().  Since embeded MRs will be properties of the owner object,
> it means they'll be freed _before_ the owner's finalize().
>
> To fix that, teach memory API to stop refcount on MRs that share the same
> owner.  Because if they share the lifecycle of the owner, then they share
> the same lifecycle between themselves, hence the refcount doesn't help but
> only introduce troubles.
>
> Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
> against its container, as long as they belong to the same owner.
>
> The latter is needed because now it's possible to have MRs' finalize()
> happen in any order when they share the same lifespan with a same owner.
> In this case, we should allow finalize() to happen in any order of either
> the parent or child MR.  Loose the mr->container check in MR's finalize()
> to allow auto-detach.  Double check it shares the same owner.
>
> Proper document this behavior in code.
>
> This patch is heavily based on the work done by Akihiko Odaki:
>
> https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

I have some wordsmithing review stuff for doc and comment text
below, but otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>

> ---
>  docs/devel/memory.rst |  7 +++++--
>  system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
>  2 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 57fb2aec76..a325e97d7b 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -158,8 +158,11 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
>  as soon as the region is made visible.  This can be immediately, later,
>  or never.
>
> -Destruction of a memory region happens automatically when the owner
> -object dies.
> +Destruction of a memory region happens automatically when the owner object
> +dies.  When there are multiple memory regions under the same owner object,
> +the memory API will guarantee all memory regions will be properly detached
> +and finalized one by one.  The order which memory region will be finalized

"The order in which memory regions will be finalized is not
guaranteed."

> +first is not guaranteed.
>
>  If however the memory region is part of a dynamically allocated data
>  structure, you should call object_unparent() to destroy the memory region
> diff --git a/system/memory.c b/system/memory.c
> index 5646547940..d7f6ad9be2 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1796,16 +1796,36 @@ static void memory_region_finalize(Object *obj)
>  {
>      MemoryRegion *mr = MEMORY_REGION(obj);
>
> -    assert(!mr->container);
> -
> -    /* We know the region is not visible in any address space (it
> -     * does not have a container and cannot be a root either because
> -     * it has no references, so we can blindly clear mr->enabled.
> -     * memory_region_set_enabled instead could trigger a transaction
> -     * and cause an infinite loop.
> +    /*
> +     * Each memory region (that can be dynamically freed..) must has an

s/..//
s/must has/must have/

> +     * owner, and it always has the same lifecycle of its owner.  It means
> +     * when reaching here, the memory region's owner refcount is zero.

"region's owner's refcount"

> +     *
> +     * Here it is possible that the MR has:
> +     *
> +     * (1) mr->container set, which means this MR can be a subregion of a

"this MR is a subregion of"

> +     *     container MR, in this case it must share the same owner

s/, in/. In/

"same owner as that container"

> +     *     (otherwise the container should have kept a refcount of this
> +     *     MR's owner), or,

s/, or,/

(it's possible for both 1 and 2 to be true for an MR here)

> +     *
> +     * (2) mr->subregions non-empty, which means this MR can be a container

"is a container"

> +     *     of other MRs (share the owner or not).

"of another MR (which might have the same owner as this MR, or
 a different owner)"


> +     *
> +     * We know the MR, or any MR that is attached to this one as either
> +     * container or children, is not visible in any address space, because
> +     * otherwise the address space should have taken at least one refcount
> +     * of this MR's owner.  So we can blindly clear mr->enabled.
> +     *
> +     * memory_region_set_enabled instead could trigger a transaction and
> +     * cause an infinite loop.
>       */
>      mr->enabled = false;
>      memory_region_transaction_begin();
> +    if (mr->container) {
> +        /* Must share the owner; see above comments */
> +        assert(mr->container->owner == mr->owner);
> +        memory_region_del_subregion(mr->container, mr);
> +    }
>      while (!QTAILQ_EMPTY(&mr->subregions)) {
>          MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
>          memory_region_del_subregion(mr, subregion);
> @@ -2625,7 +2645,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>
>      memory_region_transaction_begin();
>
> -    memory_region_ref(subregion);
> +    if (mr->owner != subregion->owner) {
> +        memory_region_ref(subregion);
> +    }
> +
>      QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>          if (subregion->priority >= other->priority) {
>              QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> @@ -2683,7 +2706,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
>          assert(alias->mapped_via_alias >= 0);
>      }
>      QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> -    memory_region_unref(subregion);
> +
> +    if (mr->owner != subregion->owner) {
> +        memory_region_unref(subregion);
> +    }
> +
>      memory_region_update_pending |= mr->enabled && subregion->enabled;
>      memory_region_transaction_commit();
>  }
> --
> 2.50.1

thanks
-- PMM

