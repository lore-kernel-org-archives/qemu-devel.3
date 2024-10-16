Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D92D1AD48
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 11:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t12Km-0003qX-GZ; Wed, 16 Oct 2024 07:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t12Kk-0003qC-8k
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t12Ki-0004YU-76
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729078600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmBsKze0iN+0whtkCE9VpuiMVHda1AMo8z8LY1ua5ic=;
 b=fWtdnWjlV7lsDIyHE8BnTbEKu4Bc3cR6SASNHWXlsSAkK2eKEqqKFBVW4Q4LMKzfiS01ss
 HfJXuiZyVn/TM6ZnhwUc+H40aHF2zjE2dJanSp4HDTYi+0hwvYxYnGY6RTNQ9qGzG5Bj3d
 072GURNwsd4SB7lgOQ2wgqhG3g1Jno0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-pBla_nCVPRmmu2qRRP_CdQ-1; Wed, 16 Oct 2024 07:36:37 -0400
X-MC-Unique: pBla_nCVPRmmu2qRRP_CdQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e33e5fc515so3066392a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 04:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729078596; x=1729683396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmBsKze0iN+0whtkCE9VpuiMVHda1AMo8z8LY1ua5ic=;
 b=cGVQhMaUNmaOBDDxVk3J8d6gYuLNl0u3cwNcCyEXTFB7uTxbjol1OmxEJywzwRSEaM
 tw7R8nH8bJWBaKkkdj25v82svK7v2p70ZE6flbKnrzMNkVsGKdAr9o0Aq7sZjhzi31Ps
 l91XGsfnNEOvFyJuqjt+hEsjvnLohrWJGAZMDXSPSs8f3naN2HtrU3m8YhnUrolcAtI+
 ItoePLP9QSKsS+2qhgcqH39KD42y3Y3DiUegAqMwfYxGOTIx2eLcXZU2b358BxY+H6K9
 sPio2hZvw4QehRGb+FAuVlOvXeoRE6lkXYGT/vaCKg07L3+65OAGdHfMYfj8QEqYXpXf
 mu1A==
X-Gm-Message-State: AOJu0YywIz/srunG7kYDG92mCyV0ECe7a6nBknodbLXt/qJsLfXgy/pR
 uxRVEu2EZdrn9/snSReLpFKCGiKRagy/ANAP0brpo8NPz+4OhrZ6XBtghqJdTgYb8qEXAwGbNis
 2IpA5EbI10Ys1x1+71QJsC6pmc+W/iJD1mc4UytMA8GMg3KhgmLtjQ/m5c1gSey7ZgPxCk/8wlK
 hIXxgM7dSfP3JvStjJo/P3qya13qX1ExnYsno=
X-Received: by 2002:a17:90a:d90f:b0:2e0:b5c8:9ca2 with SMTP id
 98e67ed59e1d1-2e2f0a971bamr20927705a91.9.1729078595974; 
 Wed, 16 Oct 2024 04:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/QLC9+VaQ/3L9xANYrSnJqa+RWz3jLXBC1oq3bAGR4BO83vifRcDlW7vn2zpC34hVzaBZWmdxuVfd4vBZtJU=
X-Received: by 2002:a17:90a:d90f:b0:2e0:b5c8:9ca2 with SMTP id
 98e67ed59e1d1-2e2f0a971bamr20927686a91.9.1729078595569; Wed, 16 Oct 2024
 04:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-8-r.peniaev@gmail.com>
In-Reply-To: <20241016102605.459395-8-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 16 Oct 2024 15:36:23 +0400
Message-ID: <CAMxuvaz9_7JBGqsJHZO0zuvrdO20oDef2v=6TSy345byzkm1Tw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] tests/unit/test-char: add unit test for the
 `mux-be` multiplexer
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Wed, Oct 16, 2024 at 2:28=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> The test is trivial: several backends, 1 `mux-be`, 1 frontend
> do the buffer write and read. Pipe is used for EAGAIN verification.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  tests/unit/test-char.c | 306 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 304 insertions(+), 2 deletions(-)

please fix the few leaks (found with --enable-asan)

>
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index a1c6bb874c8e..3eb0692b199f 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -178,7 +178,7 @@ static void char_ringbuf_test(void)
>      qemu_opts_del(opts);
>  }
>
> -static void char_mux_test(void)
> +static void char_mux_fe_test(void)
>  {
>      QemuOpts *opts;
>      Chardev *chr, *base;
> @@ -359,6 +359,307 @@ static void char_mux_test(void)
>      qmp_chardev_remove("mux-label", &error_abort);
>  }
>
> +static void char_mux_be_test(void)
> +{
> +    QemuOpts *opts;
> +    Chardev *mux_be, *chr1, *chr2, *base;
> +    char *data;
> +    FeHandler h =3D { 0, false, 0, false, };
> +    Error *error =3D NULL;
> +    CharBackend chr_be;
> +    int ret, i;
> +
> +#define RB_SIZE 128
> +
> +    /* Create mux-be */
> +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux0",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "mux-be", &error_abort);
> +    mux_be =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
> +    g_assert_nonnull(mux_be);
> +    qemu_opts_del(opts);
> +
> +    /* Check maximum allowed backends */
> +    for (i =3D 0; true; i++) {
> +        char name[8];
> +
> +        snprintf(name, sizeof(name), "chr%d", i);
> +        opts =3D qemu_opts_create(qemu_find_opts("chardev"), name,
> +                                1, &error_abort);
> +        qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
> +        qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
> +        qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
> +        base =3D qemu_chr_new_from_opts(opts, NULL, &error);
> +        if (error) {
> +            const char *err_fmt =3D
> +                "too many uses of multiplexed chardev 'mux0' (maximum is=
 %u)";
> +            unsigned n;
> +
> +            ret =3D sscanf(error_get_pretty(error), err_fmt, &n);
> +            error_free(error);
> +            error =3D NULL;
> +            g_assert_cmpint(ret, =3D=3D, 1);
> +            g_assert_cmpint(i, =3D=3D, n);
> +            break;
> +        }
> +        g_assert_nonnull(base);
> +        qemu_opts_del(opts);
> +    }
> +    /* Finalize mux0 */
> +    qmp_chardev_remove("mux0", &error_abort);
> +
> +    /* Finalize all backends */
> +    while (i--) {
> +        char name[8];
> +        snprintf(name, sizeof(name), "chr%d", i);
> +        qmp_chardev_remove(name, &error_abort);
> +    }
> +
> +    /* Create mux-be */
> +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux0",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "mux-be", &error_abort);
> +    mux_be =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
> +    g_assert_nonnull(mux_be);
> +    qemu_opts_del(opts);
> +
> +    /* Create chardev which fails */
> +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "chr1",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
> +    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
> +    qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
> +    qemu_opt_set(opts, "mux", "on", &error_abort);
> +    chr1 =3D qemu_chr_new_from_opts(opts, NULL, &error);
> +    g_assert_cmpstr(error_get_pretty(error), =3D=3D, "chardev: mux and m=
ux-be "
> +                    "can't be used for the same device");
> +    error_free(error);
> +    error =3D NULL;
> +    qemu_opts_del(opts);
> +
> +    /* Create first chardev */
> +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "chr1",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
> +    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
> +    qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
> +    chr1 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
> +    g_assert_nonnull(chr1);
> +    qemu_opts_del(opts);
> +
> +    /* Create second chardev */
> +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "chr2",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
> +    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
> +    qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
> +    chr2 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
> +    g_assert_nonnull(chr2);
> +    qemu_opts_del(opts);
> +
> +    /* Attach mux-be to a frontend */
> +    qemu_chr_fe_init(&chr_be, mux_be, &error_abort);
> +    qemu_chr_fe_set_handlers(&chr_be,
> +                             fe_can_read,
> +                             fe_read,
> +                             fe_event,
> +                             NULL,
> +                             &h,
> +                             NULL, true);
> +
> +    /* Fails second time */
> +    qemu_chr_fe_init(&chr_be, mux_be, &error);
> +    g_assert_cmpstr(error_get_pretty(error), =3D=3D, "multiplexed charde=
v 'mux0' "
> +                    "is already used for multiplexing");
> +    error_free(error);
> +    error =3D NULL;
> +
> +    /* Write to backend, chr1 */
> +    base =3D qemu_chr_find("chr1");
> +    g_assert_cmpint(qemu_chr_be_can_write(base), !=3D, 0);
> +
> +    qemu_chr_be_write(base, (void *)"hello", 6);
> +    g_assert_cmpint(h.read_count, =3D=3D, 6);
> +    g_assert_cmpstr(h.read_buf, =3D=3D, "hello");
> +    h.read_count =3D 0;
> +
> +    /* Write to backend, chr2 */
> +    base =3D qemu_chr_find("chr2");
> +    g_assert_cmpint(qemu_chr_be_can_write(base), !=3D, 0);
> +
> +    qemu_chr_be_write(base, (void *)"olleh", 6);
> +    g_assert_cmpint(h.read_count, =3D=3D, 6);
> +    g_assert_cmpstr(h.read_buf, =3D=3D, "olleh");
> +    h.read_count =3D 0;
> +
> +    /* Write to frontend, chr_be */
> +    ret =3D qemu_chr_fe_write(&chr_be, (void *)"heyhey", 6);
> +    g_assert_cmpint(ret, =3D=3D, 6);
> +
> +    data =3D qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abort);
> +    g_assert_cmpint(strlen(data), =3D=3D, 6);
> +    g_assert_cmpstr(data, =3D=3D, "heyhey");
> +    g_free(data);
> +
> +    data =3D qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abort);
> +    g_assert_cmpint(strlen(data), =3D=3D, 6);
> +    g_assert_cmpstr(data, =3D=3D, "heyhey");
> +    g_free(data);
> +
> +
> +#ifndef _WIN32
> +    /*
> +     * Create third chardev to simulate EAGAIN and watcher.
> +     * Mainly copied from char_pipe_test().
> +     */
> +    {
> +        gchar *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL=
);
> +        gchar *in, *out, *pipe =3D g_build_filename(tmp_path, "pipe", NU=
LL);
> +        Chardev *chr3;
> +        int fd, len;
> +        char buf[128];
> +
> +        in =3D g_strdup_printf("%s.in", pipe);
> +        if (mkfifo(in, 0600) < 0) {
> +            abort();
> +        }
> +        out =3D g_strdup_printf("%s.out", pipe);
> +        if (mkfifo(out, 0600) < 0) {
> +            abort();
> +        }
> +
> +        opts =3D qemu_opts_create(qemu_find_opts("chardev"), "chr3",
> +                                1, &error_abort);
> +        qemu_opt_set(opts, "backend", "pipe", &error_abort);
> +        qemu_opt_set(opts, "path", pipe, &error_abort);
> +        qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
> +        chr3 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
> +        g_assert_nonnull(chr3);
> +
> +        /* Write to frontend, chr_be */
> +        ret =3D qemu_chr_fe_write(&chr_be, (void *)"thisis", 6);
> +        g_assert_cmpint(ret, =3D=3D, 6);
> +
> +        data =3D qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abor=
t);
> +        g_assert_cmpint(strlen(data), =3D=3D, 6);
> +        g_assert_cmpstr(data, =3D=3D, "thisis");
> +        g_free(data);
> +
> +        data =3D qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abor=
t);
> +        g_assert_cmpint(strlen(data), =3D=3D, 6);
> +        g_assert_cmpstr(data, =3D=3D, "thisis");
> +        g_free(data);
> +
> +        fd =3D open(out, O_RDWR);
> +        ret =3D read(fd, buf, sizeof(buf));
> +        g_assert_cmpint(ret, =3D=3D, 6);
> +        buf[ret] =3D 0;
> +        g_assert_cmpstr(buf, =3D=3D, "thisis");
> +        close(fd);
> +
> +        /* Add watch. 0 indicates no watches if nothing to wait for */
> +        ret =3D qemu_chr_fe_add_watch(&chr_be, G_IO_OUT | G_IO_HUP,
> +                                    NULL, NULL);
> +        g_assert_cmpint(ret, =3D=3D, 0);
> +
> +        /*
> +         * Write to frontend, chr_be, until EAGAIN. Make sure length is
> +         * power of two to fit nicely the whole pipe buffer.
> +         */
> +        len =3D 0;
> +        while ((ret =3D qemu_chr_fe_write(&chr_be, (void *)"thisisit", 8=
))
> +               !=3D -1) {
> +            len +=3D ret;
> +        }
> +        g_assert_cmpint(errno, =3D=3D, EAGAIN);
> +
> +        /* Further all writes should cause EAGAIN */
> +        ret =3D qemu_chr_fe_write(&chr_be, (void *)"b", 1);
> +        g_assert_cmpint(ret, =3D=3D, -1);
> +        g_assert_cmpint(errno, =3D=3D, EAGAIN);
> +
> +        /*
> +         * Add watch. Non 0 indicates we have a blocked chardev, which
> +         * can wakes us up when write is possible.
> +         */
> +        ret =3D qemu_chr_fe_add_watch(&chr_be, G_IO_OUT | G_IO_HUP,
> +                                    NULL, NULL);
> +        g_assert_cmpint(ret, !=3D, 0);
> +        g_source_remove(ret);
> +
> +        /* Drain pipe and ring buffers */
> +        fd =3D open(out, O_RDWR);
> +        while ((ret =3D read(fd, buf, MIN(sizeof(buf), len))) !=3D -1 &&=
 len > 0) {
> +            len -=3D ret;
> +        }
> +        close(fd);
> +
> +        data =3D qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abor=
t);
> +        g_assert_cmpint(strlen(data), =3D=3D, 128);
> +        g_free(data);
> +
> +        data =3D qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abor=
t);
> +        g_assert_cmpint(strlen(data), =3D=3D, 128);
> +        g_free(data);
> +
> +        /*
> +         * Now we are good to go, first repeat "lost" sequence, which
> +         * was already consumed and drained by the ring buffers, but
> +         * pipe have not recieved that yet.
> +         */
> +        ret =3D qemu_chr_fe_write(&chr_be, (void *)"thisisit", 8);
> +        g_assert_cmpint(ret, =3D=3D, 8);
> +
> +        ret =3D qemu_chr_fe_write(&chr_be, (void *)"streamisrestored", 1=
6);
> +        g_assert_cmpint(ret, =3D=3D, 16);
> +
> +        data =3D qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abor=
t);
> +        g_assert_cmpint(strlen(data), =3D=3D, 16);
> +        /* Only last 16 bytes, see big comment above */
> +        g_assert_cmpstr(data, =3D=3D, "streamisrestored");
> +        g_free(data);
> +
> +        data =3D qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abor=
t);
> +        g_assert_cmpint(strlen(data), =3D=3D, 16);
> +        /* Only last 16 bytes, see big comment above */
> +        g_assert_cmpstr(data, =3D=3D, "streamisrestored");
> +        g_free(data);
> +
> +        fd =3D open(out, O_RDWR);
> +        ret =3D read(fd, buf, sizeof(buf));
> +        g_assert_cmpint(ret, =3D=3D, 24);
> +        buf[ret] =3D 0;
> +        /* Both 8 and 16 bytes */
> +        g_assert_cmpstr(buf, =3D=3D, "thisisitstreamisrestored");
> +        close(fd);
> +    }
> +#endif
> +
> +    /* Can't be removed, depends on mux0 */
> +    qmp_chardev_remove("chr1", &error);
> +    g_assert_cmpstr(error_get_pretty(error), =3D=3D, "Chardev 'chr1' is =
busy");
> +    error_free(error);
> +    error =3D NULL;
> +
> +    /* Can't be removed, depends on frontend chr_be */
> +    qmp_chardev_remove("mux0", &error);
> +    g_assert_cmpstr(error_get_pretty(error), =3D=3D, "Chardev 'mux0' is =
busy");
> +    error_free(error);
> +    error =3D NULL;
> +
> +    /* Finalize frontend */
> +    qemu_chr_fe_deinit(&chr_be, false);
> +
> +    /* Finalize mux0 */
> +    qmp_chardev_remove("mux0", &error_abort);
> +
> +    /* Finalize backend chardevs */
> +    qmp_chardev_remove("chr1", &error_abort);
> +    qmp_chardev_remove("chr2", &error_abort);
> +#ifndef _WIN32
> +    qmp_chardev_remove("chr3", &error_abort);
> +#endif
> +}
>
>  static void websock_server_read(void *opaque, const uint8_t *buf, int si=
ze)
>  {
> @@ -1506,7 +1807,8 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/null", char_null_test);
>      g_test_add_func("/char/invalid", char_invalid_test);
>      g_test_add_func("/char/ringbuf", char_ringbuf_test);
> -    g_test_add_func("/char/mux", char_mux_test);
> +    g_test_add_func("/char/mux", char_mux_fe_test);
> +    g_test_add_func("/char/mux-be", char_mux_be_test);
>  #ifdef _WIN32
>      g_test_add_func("/char/console/subprocess", char_console_test_subpro=
cess);
>      g_test_add_func("/char/console", char_console_test);
> --
> 2.34.1
>


