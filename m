Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFEEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBKu-00032b-OW; Thu, 22 Aug 2024 13:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shBKt-000328-Ln
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:10:59 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shBKr-0006KE-Ih
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:10:59 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f43de7ad5eso7741881fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724346655; x=1724951455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=On2YjpSl/H1q54htE/odhCA+fOeFKi5Q6vphWYDgBg0=;
 b=x7QeXBZeOlhJ/8KtEI3+w/k1cbYCU7LwgaaPeVrBbD7hTai+Glt6rFlPP0yIOBqTmc
 FFRKK/2mKDe5tApN4caTMvPAVzjTsskxYp0uZsFYVrQaB9tbqaQgp2puKgQMo7AAofBf
 JNIMpbHwJToLniyN1iftHD7kdQWHpupGYYDq7a4AeR1ea62P/10cEalsdoszmt6e0wA3
 mkxSqyjbrZ9WeQNiK+g6vqmMd/o+cUJlhDTLChp99GYHLLOBOUvn+aSjB48L8DSt0Y7p
 bI71QzCOK62sQ/25VYkflIswkLxdrO+aTrXrnTnGt43M6WaykHHzzjHsvLmdAiY9nr6d
 2rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724346655; x=1724951455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=On2YjpSl/H1q54htE/odhCA+fOeFKi5Q6vphWYDgBg0=;
 b=vRxnYGDXge+PFH21L6MtdNgO5aZDQB6v//g7MRGSV9K1JVReI8V5aSnzHPs4nucem+
 WCIWoVnV0wWAE7G7TOY7N2+D5znc5QPmOUggoQDP1M4D+qrs162T2G35jug5oEWZNAa5
 P6JCAeUcLzLi3HY+KGoLvAGRTqzF+EMILjKQN/K3JtHJ+7JbD0+bVah5mK6Cx+06Awzi
 nPPbZDei4I8gzXJTopt0hAgffHl9ypoAEYqZJBw/LESFN7m/2MFiBocBajyAyI0x7mvD
 Onhxr2CzDLOzWFWJoZl7ZNG0+QTLjOqx65mKQUV0/29Q0SfvdgxLzqH4P+tlBy5vehyD
 QfDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE3iHS4vg8o4Rs733ThDn7yFakVPE5tja2YCOSXSTe1ngCGI6wqQV+mFY1ZucPeIx2TK2l0nkNhjxJ@nongnu.org
X-Gm-Message-State: AOJu0YwCIK+V84BDet6XcDgES2Riahz7j7+mzqTNlkdUkjPwJRGXeK3E
 +uyHKWwLHRmrxOSyRvoJsig49x+gFOHxe1kJY1SmF7B8ypCy3Xb0PpKew62IfheSyF77PQOQ5Wb
 miV77UqkmVNSd8g735EjW/BTiJckqVIX6Cdw+Zg==
X-Google-Smtp-Source: AGHT+IE2kzeoTEvBkQ6UzOb0QloZVDgiZrLG1JxPLxajkqbi1vXloK+4EJ3jsChA+gPxQyERJ99dIp54RCDjkUoRSJ4=
X-Received: by 2002:a05:651c:1506:b0:2ef:251f:785 with SMTP id
 38308e7fff4ca-2f3f883012amr48440531fa.1.1724346654991; Thu, 22 Aug 2024
 10:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-9-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-9-750bb0946dbd@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 18:10:43 +0100
Message-ID: <CAFEAcA9KTSjwF1rABpM5nv9UFuKqZZk6+Qo4PEF4+rTirNi5fQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 27 Jun 2024 at 14:40, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> A memory region does not use their own reference counters, but instead
> piggybacks on another QOM object, "owner" (unless the owner is not the
> memory region itself). When creating a subregion, a new reference to the
> owner of the container must be created. However, if the subregion is
> owned by the same QOM object, this result in a self-reference, and make
> the owner immortal. Avoid such a self-reference.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  system/memory.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 74cd73ebc78b..949f5016a68d 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2638,7 +2638,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
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
> @@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
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

I was having another look at leaks this week, and I tried
this patch to see how many of the leaks I was seeing it
fixed. I found however that for arm it results in an
assertion when the device-introspection-test exercises
the "imx7.analog" device. By-hand repro:

$ ./build/asan/qemu-system-aarch64 -display none -machine none -accel
qtest -monitor stdio
==712838==WARNING: ASan doesn't fully support makecontext/swapcontext
functions and may produce false positives in some cases!
QEMU 9.0.92 monitor - type 'help' for more information
(qemu) device_add imx7.analog,help
qemu-system-aarch64: ../../system/memory.c:1777: void
memory_region_finalize(Object *): Assertion `!mr->container' failed.
Aborted (core dumped)

It may be well be that this is a preexisting bug that's only
exposed by this refcount change causing us to actually try
to dispose of the memory regions.

I think that what's happening here is that the device
object has multiple MemoryRegions, each of which is a child
QOM property. One of these MRs is a "container MR", and the
other three are actual-content MRs which the device put into
the container when it created them. When we deref the device,
we go through all the child QOM properties unparenting and
unreffing them. However, there's no particular ordering
here, and it happens that we try to unref one of the
actual-content MRs first. That MR is still inside the
container MR, so we hit the assert. If we had happened to
unref the container MR first then memory_region_finalize()
would have removed all the subregions from it, avoiding
the problem.

I'm not sure what the best fix would be here -- that assert
is there as a guard that the region isn't visible in
any address space, so maybe it needs to be made a bit
cleverer about the condition it checks? e.g. in this
example although mr->container is not NULL,
mr->container->container is NULL. Or we could check
whether the mr->container->owner is the same as the
mr->owner and allow a non-NULL mr->container in that case.
I don't know this subsystem well enough so I'm just
making random stabs here, though.

thanks
-- PMM

