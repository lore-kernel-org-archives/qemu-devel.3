Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC62A104BED5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Gu0-0006kL-Jx; Wed, 11 Mar 2026 06:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0Gtx-0006iw-L9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0Gtv-0003yy-Mr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773225289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zB+7PNTERDPVh3Nyas0IvElsDKPqdF4lA7ruby4Yp6A=;
 b=KXGdQSdXf7sGMB+5HsfkEsyWpkXvDyV5JaodfDHfBLrQCL59sWl9t/MHmLD6WujO5Gs6hj
 0Xq4CWUkB2wfVLWcuTj9eu6kM32ZhTEy2VI2ztLh7w/G9hz3seViinL6Juth2DEH1EXhve
 waZwSpHzvIo5o7FW0AAMWekWzfRF1R0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-eQTMn6faM0ms2pyNNzfMtA-1; Wed, 11 Mar 2026 06:34:48 -0400
X-MC-Unique: eQTMn6faM0ms2pyNNzfMtA-1
X-Mimecast-MFC-AGG-ID: eQTMn6faM0ms2pyNNzfMtA_1773225287
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso157940565e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773225287; cv=none;
 d=google.com; s=arc-20240605;
 b=bvmuJ7Jrxv4+tMbzRj9Kf5Y88QwfVPVjh5QRHfqyiWbKrcZVD8wwYW816qnYIJdqfY
 d2/DjlprdxxTmeTpON9RFhP8yPUFlYbB7bEc6rRx6RrPN71r9umbHsEG3I7u9a5LZNdj
 NJ2GN4392Y1cuzWI64FRyPFzHw+47GaB1kPpnzZ5DV8dho+7r6XDjfz1FuPy+xq3l+Dj
 4eLw1L8J/Jr7IIAZTDEftMFb497pxZ12gXOIbr+Q2W3yvXaSwgbhfwlKu23YIMY+vBku
 Wbb+h/6b6/FlJSPQgckVUGTY4g6uclNIpjM8qixcTnEoljgRxgHqKZFHH41Om4FH2P2l
 Dj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zB+7PNTERDPVh3Nyas0IvElsDKPqdF4lA7ruby4Yp6A=;
 fh=jJSuppldnKTzKFj6lwnMFqs9z6PbYca7cw17lgQhG4M=;
 b=bh7VBlDBv4L20e/G2RZDB7Ab0JatAJYsXtp8PqVVTmOnAtwHKTdp6Ut7lvcoER1yeu
 wHoukKV2ioeIkY0clv5RUCUU22u41FKyy+P3aK8MdmUQyTAZfLMdtoVeVRGvVj63MFSI
 GaemRrJrAD7FkO4y21Y1yFKZzzeMT/wOXfLCwq18LZK+mZuHUaFwbC5KPwIBgd5q2HJP
 5EUQ4/G50a8mHcI93CqA/WSDoZAlSIaDS3YqvmpyrEts+i5ZrlM3QEYhaWdhs5A0Ziwb
 z91qgkXG9SQ4EXqc0ccEBVHjOhXbMVT5w7n+0CNT9CuWRnDsAqaHVj5uiV0NuoQqXHT2
 7fsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773225287; x=1773830087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zB+7PNTERDPVh3Nyas0IvElsDKPqdF4lA7ruby4Yp6A=;
 b=ANBy5wG8pqPzkSifX131UXruXnFnpPb9Eb6UYlpH0SHIqdA3avZtmrL2wOyoAklsHv
 4qmjsXfLnS4gnEGgXn8v+7D0Pat+OGlSBtSRAqYB2yjM983c5axcqOdxgtjVRpyG4J7l
 SgSfE5mWBEzPWf8SEJ8bZf28E1byzj49Xk87m05J8A9pig8ynQPiP7JlJLR/fVfXcqz6
 7BFmhiG30+JrT8O1JFJyQ/XXrKSHUbZ2QHD2norHIxEGoaSH4zeUd6AJjruPGBMXbGO8
 It1ocwbYUutnmGtbyChq7aG3jtkw6dnBrqNem1KrEe6b+QFYazggJI50LCybOFd6V0o1
 Josw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773225287; x=1773830087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zB+7PNTERDPVh3Nyas0IvElsDKPqdF4lA7ruby4Yp6A=;
 b=r6AGW9PftB60Z7EopaIoBZ3Wpk9vkKvzgM4ordiu+Hj7rv/fUokQfYjTJlXkp0GiPt
 BCZdHL8abjegzg7xir67tkNe42dqkZInCM2zv3bI+tLE1JB9w5qlnwZ93S6Qax1JIx2S
 eWPf6EWOdvmEER7QKcG22xthPhKntdxoUovcrcVOqh/SVT7llLwtSMvd5WInWAoxF+U8
 AUiB6V664cGhRKb6G8SbaZ4S7B17zqT9Ttoouz5eu8WzI5Do6jojF4nncqNasYtn+MnK
 2WYTDPnb4gkpNETLmS9cK6rCgNYcqtdjDXiaFi2UN7JZDnrd267SnPqBBXTgERNXyIgK
 j5LA==
X-Gm-Message-State: AOJu0YzL5lSk2Y3srKC8Vl3BTsrK9br+0EIbVt0nECFobdIGjcwEByMm
 KeFgsQPo6wWjdKqY10caQAgIGu+RDFiAuaXgsG96zYA1ncF/8nSuzyF3AO/P6DXOgWuaF/WO1Vu
 yScX9VirWH29jl5gmAQ3zblrbEVO3KDgQ0dwenZyRZ+w9BQ3+uyWYICMQKJX3PKxxq6aYVhKoJ/
 aBa0OKYh0xrxEixgZC0sLW1j8nByldaIY=
X-Gm-Gg: ATEYQzyNl4JwPBBoTeJuRU4N86ySdhmvIYKqtXkUPh/kyLxhY2gifX79jW5qpVJuh6h
 cTkhDeLVxoRPbScfKn5GW/P1S6lOVfc6a9KKWUzeGDSH1472jw6mseBapoMWbhwj1wQnMmNXRDz
 11903l//WWnt1r7JeEkZS50uPoeksr9ZVxtwLCBpXMihWVbx9GCk5C/9b29RINC9FNO/DE0xjMM
 k5bAToF+6DAjcn0yV3T+b2MJI8Y8Jy7X5gzTDpvpfoKEbfRIf/vwPpZEYkNeIx/Heq2
X-Received: by 2002:a05:600c:4752:b0:485:3692:e906 with SMTP id
 5b1f17b1804b1-4854b0c77f4mr31539705e9.13.1773225287315; 
 Wed, 11 Mar 2026 03:34:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:485:3692:e906 with SMTP id
 5b1f17b1804b1-4854b0c77f4mr31539125e9.13.1773225286856; Wed, 11 Mar 2026
 03:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-2-farosas@suse.de>
In-Reply-To: <20260310135540.8679-2-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 11 Mar 2026 16:04:29 +0530
X-Gm-Features: AaiRm52ridvGQxesTvnucjwSeBoVST33LRFFkk_X2ahbEqRsOcm_VAG0zcVW0s8
Message-ID: <CAE8KmOz=k54o0ND0dLW8mHVeW0WDf2G-Nc1GVAPSpmqyUTVE3Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] tests/qtest/migration: Change validate_uuid test to
 not trigger exit(1)
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Mar 2026 at 19:26, Fabiano Rosas <farosas@suse.de> wrote:
> The UUID validation happens early enough during the migration process
> that the incoming coroutine hasn't yet yielded once so the
> EXIT_FAILURE from the coroutine can trigger ASAN leak detection due to
> the temporary socket from qio_net_listener_channel_func() still having
> an elevated refcount.
>
> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>     #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
>     #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
>     #2 0x55e66a8ef05f in object_new_with_type ../qom/object.c:767:15
>     #3 0x55e66a8ef178 in object_new ../qom/object.c:789:12
>     #4 0x55e66a93bcc6 in qio_channel_socket_new ../io/channel-socket.c:70:31
>     #5 0x55e66a93f34f in qio_channel_socket_accept ../io/channel-socket.c:401:12
>     #6 0x55e66a96752a in qio_net_listener_channel_func ../io/net-listener.c:64:12
>     #7 0x55e66a94bdac in qio_channel_fd_source_dispatch ../io/channel-watch.c:84:12
>     #8 0x7f3c7e2adf4b in g_main_dispatch ../glib/gmain.c:3476
>     #9 0x7f3c7e2adf4b in g_main_context_dispatch_unlocked ../glib/gmain.c:4284
>     #10 0x7f3c7e2b00c8 in g_main_context_dispatch ../glib/gmain.c:4272
>
> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
>     #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
>     #2 0x7f3c7e2ad40c in g_source_set_callback ../glib/gmain.c:1879
>     #3 0x55e66a95c4d2 in qio_channel_add_watch_full ../io/channel.c:416:5
>     #4 0x55e66a95c5a9 in qio_channel_add_watch_source ../io/channel.c:444:10
>     #5 0x55e66a96380c in qio_net_listener_watch ../io/net-listener.c:166:46
>     #6 0x55e66a96496a in qio_net_listener_set_client_func_internal ../io/net-listener.c:275:5
>     #7 0x55e66a963e79 in qio_net_listener_set_client_func_full ../io/net-listener.c:284:5
>     #8 0x55e669e1b3bb in socket_connect_incoming ../migration/socket.c:165:5
>     #9 0x55e669d26b9f in migration_connect_incoming ../migration/channel.c:83:13
>     #10 0x55e669d5f6d2 in qemu_setup_incoming_migration ../migration/migration.c:672:5
>     #11 0x55e669d5f344 in qmp_migrate_incoming ../migration/migration.c:1771:5
>
> This is inconsequential in production, but let's give ourselves an
> easier time and avoid this situation when testing. The uuid_error test
> doesn't really need to check the exit code, just the migration state
> would be sufficient. Set exit-on-error=false for this test.
>
> While looking at this, add a comment to the source explaining that the
> incoming coroutine may block the main loop for a (longer than
> expected) while.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c              | 5 +++++
>  tests/qtest/migration/misc-tests.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index f949708629..c77832f851 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -898,6 +898,11 @@ void migration_start_incoming(void)
>
>      Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>      qemu_coroutine_enter(co);
> +    /*
> +     * This doesn't return right away. The coroutine will run
> +     * unimpeded until its first yield, which may happen as late as
> +     * the force yield at ram_load_precopy().
> +     */
>  }
>
>  int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 810e9e6549..06da2657d5 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -131,7 +131,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>
> -    if (migrate_start(&from, &to, uri, args)) {
> +    if (migrate_start(&from, &to, "defer", args)) {
>          return;
>      }
>
> @@ -146,10 +146,10 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>
> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>      migrate_qmp(from, to, uri, NULL, "{}");
>
>      if (should_fail) {
> -        qtest_set_expected_status(to, EXIT_FAILURE);
>          wait_for_migration_fail(from, true);
>      } else {
>          wait_for_migration_complete(from);
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


