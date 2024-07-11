Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A91C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 06:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRn3I-0005TH-QG; Thu, 11 Jul 2024 02:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRn3H-0005Rk-13
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:13:11 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRn3E-0005bV-RN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:13:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so511899a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720678386; x=1721283186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mb4ID0NJ7bCqmcY1Z/OTx00TL2CS53fK9VYinwR+kKI=;
 b=MTwPU+Z0MfgEqtfzGCppw++Iak5trTweYWQunuy+erYgeN2Q+YiaciRkfXnhQ5znJ1
 eF27ivXX+L2sXZAnlagECTUNDXP9/FF69f87n/a9LR3zoKoQe7Qzd7RFtxm67OFJ+ItF
 dQU8nBveWE9ar3upRXeMvk4Wy9VZNCt2AeK//uom7+nACG2fplJr/6qL9DhPWI1rWFyH
 1HcvCgzrsdYyF4JGt9cq6eks2MdWQYdEyNJGjtDYrc6ThTilLrO/AkXEzfSNQDQ85g1S
 Oru4iDGaQOIIOm/Adch5pSCA3ZY7fJu83D51vOO8/BKRihkIyKzIeUOZoCj76zCwwzB9
 OA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720678386; x=1721283186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mb4ID0NJ7bCqmcY1Z/OTx00TL2CS53fK9VYinwR+kKI=;
 b=rsm231ALLPYFbxGp4wNwI7Ne8ersJU2aSpEe8vS40kU8tZWf5LZEzdhXuqiuLm549c
 wdrzQvSf6144J+Z7pOhN8WxXQTd1ETqd8y2Za0Dz3tiohRXTC2OVxlpIlqsfmib3yCh3
 y0uDWeD2FEpeHxCn8PdFlO+QlFt4P2ZlFccHH9fPMrEphjowsqZDkcky7/vQdq6Et1yB
 MXZNSDjXklmx3XEQXYkeMDgTn9pPnkvs0ZN2dAQZ4EPivwDUQyjJszidGUYUU4AOABmk
 Oa6vYlK4DPd8ufzSnyLr5EcXIo3xloRjhOAyLsxs6oesucUl6Yi3CZIZKkHRWMBC2IbH
 dhkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH0EF1XvnFSxTNYg+INdYCHfLjKh9yKL+jn6YUer21or/gFJ/pSssJxIkJtwJQQWkuFyP9qIkdGDji8rnZl0E8d/FbFd4=
X-Gm-Message-State: AOJu0YyXXsOlcrTw9lE48eyT3mnzPb0VUrZiJ4nU7mQFcYMvffnS9I6I
 xBUUmXPk/+zRl3lyYzzq6tQTHRAgB3Igij5cl2q9hNqg26J4zNyZmZwP1tfc0XAxUNb6HO3k0nC
 tAdKWAfRR/Y96XduH9R8XCjQLuf/XBVyYAqBXtA==
X-Google-Smtp-Source: AGHT+IFJ+oDtA9xR4PyZIzmLTLzPr5Ia6vgEZ4q33zdc4MCQv9sJbHlO8gKfmX1c0uCoxp8V3CYYS6yR00sn/tSEB+Y=
X-Received: by 2002:aa7:cb11:0:b0:58d:c542:2539 with SMTP id
 4fb4d7f45d1cf-594bb674e6amr4377164a12.24.1720678386051; Wed, 10 Jul 2024
 23:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240627181245.281403-1-kwolf@redhat.com>
 <20240627181245.281403-3-kwolf@redhat.com>
In-Reply-To: <20240627181245.281403-3-kwolf@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 11 Jul 2024 09:12:50 +0300
Message-ID: <CAAjaMXYz6ixb9fCyOF-796i1Gtqq6Ns5C8o2KCDjge_gXz6QsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block/graph-lock: Make WITH_GRAPH_RDLOCK_GUARD()
 fully checked
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eblake@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Jun 2024 at 21:13, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Upstream clang 18 (and backports to clang 17 in Fedora and RHEL)
> implemented support for __attribute__((cleanup())) in its Thread Safety
> Analysis, so we can now actually have a proper implementation of
> WITH_GRAPH_RDLOCK_GUARD() that understands when we acquire and when we
> release the lock.
>
> -Wthread-safety is now only enabled if the compiler is new enough to
> understand this pattern. In theory, we could have used some #ifdefs to
> keep the existing basic checks on old compilers, but as long as someone
> runs a newer compiler (and our CI does), we will catch locking problems,
> so it's probably not worth keeping multiple implementations for this.
>
> The implementation can't use g_autoptr any more because the glib macros
> define wrapper functions that don't have the right TSA attributes, so
> the compiler would complain about them. Just use the cleanup attribute
> directly instead.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/graph-lock.h | 21 ++++++++++++++-------
>  meson.build                | 14 +++++++++++++-
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
> index d7545e82d0..dc8d949184 100644
> --- a/include/block/graph-lock.h
> +++ b/include/block/graph-lock.h
> @@ -209,31 +209,38 @@ typedef struct GraphLockable { } GraphLockable;
>   * unlocked. TSA_ASSERT_SHARED() makes sure that the following calls know that
>   * we hold the lock while unlocking is left unchecked.
>   */
> -static inline GraphLockable * TSA_ASSERT_SHARED(graph_lock) TSA_NO_TSA coroutine_fn
> +static inline GraphLockable * TSA_ACQUIRE_SHARED(graph_lock) coroutine_fn
>  graph_lockable_auto_lock(GraphLockable *x)
>  {
>      bdrv_graph_co_rdlock();
>      return x;
>  }
>
> -static inline void TSA_NO_TSA coroutine_fn
> -graph_lockable_auto_unlock(GraphLockable *x)
> +static inline void TSA_RELEASE_SHARED(graph_lock) coroutine_fn
> +graph_lockable_auto_unlock(GraphLockable **x)
>  {
>      bdrv_graph_co_rdunlock();
>  }
>
> -G_DEFINE_AUTOPTR_CLEANUP_FUNC(GraphLockable, graph_lockable_auto_unlock)
> +#define GRAPH_AUTO_UNLOCK __attribute__((cleanup(graph_lockable_auto_unlock)))
>
> +/*
> + * @var is only used to break the loop after the first iteration.
> + * @unlock_var can't be unlocked and then set to NULL because TSA wants the lock
> + * to be held at the start of every iteration of the loop.
> + */
>  #define WITH_GRAPH_RDLOCK_GUARD_(var)                                         \
> -    for (g_autoptr(GraphLockable) var = graph_lockable_auto_lock(GML_OBJ_()); \
> +    for (GraphLockable *unlock_var GRAPH_AUTO_UNLOCK =                        \
> +            graph_lockable_auto_lock(GML_OBJ_()),                             \
> +            *var = unlock_var;                                                \
>           var;                                                                 \
> -         graph_lockable_auto_unlock(var), var = NULL)
> +         var = NULL)
>
>  #define WITH_GRAPH_RDLOCK_GUARD() \
>      WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__))
>
>  #define GRAPH_RDLOCK_GUARD(x)                                       \
> -    g_autoptr(GraphLockable)                                        \
> +    GraphLockable * GRAPH_AUTO_UNLOCK                               \
>      glue(graph_lockable_auto, __COUNTER__) G_GNUC_UNUSED =          \
>              graph_lockable_auto_lock(GML_OBJ_())
>
> diff --git a/meson.build b/meson.build
> index 97e00d6f59..b1d5ce5f1d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -624,7 +624,19 @@ warn_flags = [
>  ]
>
>  if host_os != 'darwin'
> -  warn_flags += ['-Wthread-safety']
> +  tsa_has_cleanup = cc.compiles('''
> +    struct __attribute__((capability("mutex"))) mutex {};
> +    void lock(struct mutex *m) __attribute__((acquire_capability(m)));
> +    void unlock(struct mutex *m) __attribute__((release_capability(m)));
> +
> +    void test(void) {
> +      struct mutex __attribute__((cleanup(unlock))) m;
> +      lock(&m);
> +    }
> +  ''', args: ['-Wthread-safety', '-Werror'])
> +  if tsa_has_cleanup
> +    warn_flags += ['-Wthread-safety']
> +  endif
>  endif
>
>  # Set up C++ compiler flags
> --
> 2.45.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



-- 
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

