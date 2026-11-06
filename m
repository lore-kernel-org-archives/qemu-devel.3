Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD0606A328
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jJyCuHJH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPF8K-0006OP-Ey; Fri, 06 Nov 2026 03:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xPF8G-0006Nh-BB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:17:08 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xPF8E-0006iU-Mw
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:17:08 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so593074eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 00:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793953024; cv=none;
 d=google.com; s=arc-20260327;
 b=XgevIyJQNxfvGokhbVLrqkXnTA072tKUXol5/zrVj0gNaC0MWAZk8zfaMkEgg1DGDS
 DVBAY0RdNtR7/MDTV/82WfK0V259WmiXcIPmI7ws1LYtd8e4Me89YpmWSGEeEkiciM7X
 7SdN0CT+K65pzGMemPcVPtNBtiywuXbfRCpWq8MYYwonF0VC4ep4CLd8OXca6KvNVEDC
 oBeXGP1waisnC1o4itnJ6FISosr0Yh6b6oxc6mn/QFg9UsJKHdLE8Rq6ox5di+9H6EmH
 jhjnlJCOfzCQD50eUczuI7TC9S8dT+FFtesj98CpOJczvj5sF18Ij0E/jv+BmYla7UKm
 jXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XBTpDCNn95IkK+PlBufbmcBt+9A0txHHIVWAu9rJxSw=;
 fh=L7jMwmWD9fXfhoiBs5Mggg6Opxj0KO/K+h1yf0imA58=;
 b=POSd8iJe3fUS5rN5ZkWcq9hB0vf7YBTArrtQbcgUIjvmz7B5TKonQAdi/ao39dmwuE
 kL13qjOvn0ke5TsseekYKeaDW8FD/XsKZglghqK+Ui1St0Zdrt/yng97Y9tcWtAgLhxb
 EGyg7yZtBTqRdpJnP/91iEnuspIPAvfQwGDATxnCH2e4UdRpXnwkd4Rq6S9o6kbTpClQ
 HzdYCHabKkrEYkyMnJshVW42kyxeNsQ/2BOJQdOYXmI49nHTkz0A0TIPOIyU1FGYSTVk
 7NNv0Vl3pf/O+WkugNE8rn69M6SQz8Z4KXXBCJ/8XybUuG0xT3/5OR77QMz6XztNydjd
 hJSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793953024; x=1794557824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XBTpDCNn95IkK+PlBufbmcBt+9A0txHHIVWAu9rJxSw=;
 b=jJyCuHJHNkfw4txbMMetwGWo1heHwWP9Qk53CAD1GrJ4hHSezgwPhSkTMV5XC9PLYV
 5wWaicFloKR0NL9fSTpUG4GV7l5IJ+B4PKgMgLVjumlO0+rbz5THiJBas7gXv0xcdX/k
 ujRWTZEgT9NmA6qiFlOPCYCHXnI/R9gETo1FCwY9oCUxKXhzksTlhZ7y6WWPnUtIrnJJ
 mnCK99din1PfrD8Hub15VxUO6xZBnuV8euvP4xcl6nAjEYToNKDpFogC3G+9bbkCE2Da
 7XLy9v0Ys97sOzaX4SX3MN8+oL4CFnk4f7IupRo1AcyGxtukxr19gdJHy8K0J5rQmcC6
 IrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793953024; x=1794557824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XBTpDCNn95IkK+PlBufbmcBt+9A0txHHIVWAu9rJxSw=;
 b=bjOwYACXYCd5oqeR2ous6aihb8xyyBdlqdHsLrRPpwu5MvDh1BwKketUk55TFDIDB/
 b7n1r6N+UMFNbML3tBtg9vBwq2Vc9zpDNXPVTnpJArg5WFCcwSJBXtVLLoZuc0vHiP74
 ve2UFz0+T/OBxl7X2I+89N/7/n8JOAJM7vcppuex819WS/rJeREN58es3tIk245CVR8N
 bKWe0U5WC/Ke+OIk8fYnt0z+bqICMgZTobupC7B+pNIkKlcTQLU6CeIJhi2usJQr9O/9
 92slP5bYDWW6hpf7i30wzeEQ2QORpyy3vfSWz+f6HOojUjrIJJaW2k5fq0Ep/gmUoV2V
 nX4g==
X-Gm-Message-State: APuU4Z/sDMe/6IrEUfwNhtobPGJ70bqd3ZKLBHp72girjhYDH1I00J9T
 HLQK428NneUuR5w/BuqXpr3kOBUUELRJ4j6nY49wvQiPQ+P+NVK/ligQyrt3HCBowcmO7kOTuIi
 7St4OKFKPhRZZ7DPdllW/olhcIQEeJbYBqCmD
X-Gm-Gg: AYBFou1Oku4p7P2qwkF+DyT6mfBlRHdjf+3DIHkO1fFX6zpAIfJmYYwu8BeDp8GSbO8
 SwiCEIZ5sDdjRlYieizUVJdWkovOGPj9JGS+QPJ4TiCbx11A3fDb9/x8xgqDiZ3qpmZLFARPJwg
 mDdU+TUI6pfb+QMgGWwsAlCxkMGjMSUf2LaE46vk87oPr0rK0L1Zl4Z9dd11q/DP90RrtjAsIkY
 KrSgTmqWjofoidaf4rJJqTizH556AnZJUOCOa2E0qIIT1jMqfO2kC1/cyFQ52DssepP7I5G7PSr
 XurEj5yQ5Ukx/yWyBUaoPPBrzYcv6g5OGFdE6Fa0mvUbSJGvme+/OwehGKxOyV5qqOLHCBG+CVg
 pjSTNz9PbZwokQtJkgJmrx7/h216vfIZ9/ngy40y/Mkd1POOewOw4KWoCS+4KYDJ/apgZ
X-Received: by 2002:a05:693c:62d1:b0:36d:3c0f:cc85 with SMTP id
 5a478bee46e88-36f723e9d36mr2456530eec.5.1793953023889; Fri, 06 Nov 2026
 00:17:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260730171027.1023696-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260730171027.1023696-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 6 Nov 2026 12:16:51 +0400
X-Gm-Features: AclHuK-nhceM4cKa-H3mrUhUGf6utaMrlO2lKdZsICBrOomU1_9rilaXhGfsi0M
Message-ID: <CAJ+F1CJDgZwD999DQPa6-nkF_9xnDfMPNYBLwixrYiFD6-smtg@mail.gmail.com>
Subject: Re: [PATCH v3] block: add missing coroutine_fn annotations
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, Hanna Reitz <hreitz@redhat.com>, 
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Jul 30, 2026 at 9:12=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The functions call coroutine functions or are called by coroutine.
>
> Add an assert() in qcow2_do_close() code path which calls a
> no_coroutine_fn bdrv_graph_wrlock_drained().
>
> Add an assert() in qcow2_update_options_commit() in the coroutine
> path.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
> v3:
>  - remove indentiation changes leftovers
> ---
>  include/block/blockjob_int.h |  2 +-
>  block/crypto.c               | 13 +++++++------
>  block/io.c                   |  8 +++++---
>  block/qcow2.c                |  9 ++++++---
>  blockjob.c                   |  3 ++-
>  5 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 4c3d2e25a209..34e172874fa9 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -150,7 +150,7 @@ void block_job_ratelimit_processed_bytes(BlockJob *jo=
b, uint64_t n);
>   * Put the job to sleep (assuming that it wasn't canceled) to throttle i=
t to the
>   * right speed according to its rate limiting.
>   */
> -void block_job_ratelimit_sleep(BlockJob *job);
> +void coroutine_fn block_job_ratelimit_sleep(BlockJob *job);
>
>  /**
>   * block_job_error_action:
> diff --git a/block/crypto.c b/block/crypto.c
> index 36abb7af4680..8a34d92fded6 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -56,12 +56,13 @@ static int block_crypto_probe_generic(QCryptoBlockFor=
mat format,
>  }
>
>
> -static int block_crypto_read_func(QCryptoBlock *block,
> -                                  size_t offset,
> -                                  uint8_t *buf,
> -                                  size_t buflen,
> -                                  void *opaque,
> -                                  Error **errp)
> +static int coroutine_mixed_fn
> +block_crypto_read_func(QCryptoBlock *block,
> +                       size_t offset,
> +                       uint8_t *buf,
> +                       size_t buflen,
> +                       void *opaque,
> +                       Error **errp)
>  {
>      BlockDriverState *bs =3D opaque;
>      BlockCrypto *crypto =3D bs->opaque;
> diff --git a/block/io.c b/block/io.c
> index a916b236c3c8..99dd16864a3d 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -346,8 +346,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
>      assert(data.done);
>  }
>
> -static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *paren=
t,
> -                                  bool poll)
> +static void coroutine_mixed_fn
> +bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
> +                      bool poll)
>  {
>      IO_OR_GS_CODE();
>
> @@ -397,7 +398,8 @@ bdrv_drained_begin(BlockDriverState *bs)
>   * This function does not poll, nor must any of its recursively called
>   * functions.
>   */
> -static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
> +static void coroutine_mixed_fn
> +bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
>  {
>      IO_OR_GS_CODE();
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 19271b10a49f..03526c4a131f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1287,9 +1287,10 @@ fail:
>  }
>
>  /* s_locked specifies whether s->lock is held or not */
> -static void qcow2_update_options_commit(BlockDriverState *bs,
> -                                        Qcow2ReopenState *r,
> -                                        bool s_locked)
> +static coroutine_mixed_fn void
> +qcow2_update_options_commit(BlockDriverState *bs,
> +                            Qcow2ReopenState *r,
> +                            bool s_locked)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      int i;
> @@ -1299,6 +1300,7 @@ static void qcow2_update_options_commit(BlockDriver=
State *bs,
>       * table caches
>       */
>      if (s_locked) {
> +        assert(qemu_in_coroutine());
>          cache_clean_timer_co_locked_del_and_wait(bs);
>      } else {
>          cache_clean_timer_del_and_wait(bs);
> @@ -2905,6 +2907,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_dat=
a_file)
>      g_free(s->image_backing_format);
>
>      if (close_data_file && has_data_file(bs)) {
> +        assert(!qemu_in_coroutine());
>          GLOBAL_STATE_CODE();
>          bdrv_graph_rdunlock_main_loop();
>          bdrv_graph_wrlock_drained();
> diff --git a/blockjob.c b/blockjob.c
> index f3b11cc7a194..f3ad6a93125a 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -338,7 +338,8 @@ void block_job_ratelimit_processed_bytes(BlockJob *jo=
b, uint64_t n)
>      ratelimit_calculate_delay(&job->limit, n);
>  }
>
> -void block_job_ratelimit_sleep(BlockJob *job)
> +void coroutine_fn
> +block_job_ratelimit_sleep(BlockJob *job)
>  {
>      uint64_t delay_ns;
>
> --
> 2.55.0
>
>

