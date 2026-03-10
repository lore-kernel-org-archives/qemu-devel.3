Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95479FD4F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w03Ed-00042z-0J; Tue, 10 Mar 2026 15:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w03Ea-00042h-4O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w03EX-0002sh-T0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773172752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/XQBwzplxIakvMMEUmhCkx2hEg2Nniql1ADIUBX17g=;
 b=RZ764UmMeYHzxaM2QL5BqLF+UyzJUJL1vD96uQ0OEU59q3y/Zlfmsv9Wbe2USPbEZLCAOv
 9Cl37GnW/IgnstbtvFopMETVDMaVVuHTz2NbP8v4APlhAV9QF61nnGMAce2PfbHlFSTKXs
 Um9a6UX24tnbrsoWjOW205Fd0UjYP9Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-QjSBb-HGO5OqaKj1_1bfWQ-1; Tue, 10 Mar 2026 15:59:08 -0400
X-MC-Unique: QjSBb-HGO5OqaKj1_1bfWQ-1
X-Mimecast-MFC-AGG-ID: QjSBb-HGO5OqaKj1_1bfWQ_1773172748
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899ee20dd34so702127996d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773172748; x=1773777548; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C/XQBwzplxIakvMMEUmhCkx2hEg2Nniql1ADIUBX17g=;
 b=WtKTsyP+FUwEuJ4dgr1Tyr24hL0Hc2tc8c8R2D8FoV3Mar1hReqsTzvIAIpSc4CNza
 Qwgkd/vnxPpobAJS7/YyZ+JFgtJEUm1CLIlhhr9vzCILF6BKV/xK6y3GN7KhKm+FVxao
 uJWbRVupxyGQc9jKt+FG38x7OmQNHGTCM1w4wtAmmJ21vNyCVav81b9152Rxdla4bbwi
 YtG/Ok8mrDhgTxTFw20UGyWzzERHLvZ5TyeulMGWZZWyiUC800+eVQA1nN7uuPHIulwW
 PY7zhachIc9v+FQMnTpxwj/ZdGbDTjfkN9ngcanqM24vbLLfJy96ozZgjUOdKB4/6gDa
 KK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773172748; x=1773777548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/XQBwzplxIakvMMEUmhCkx2hEg2Nniql1ADIUBX17g=;
 b=kIip6gppyShDXa0VhcznsxERq+nSEMSXCfqVaN2kQTOxu+zWnr5CXZuDLNZIH1CliK
 ex+/P0OHWKB9uAeQ466fizQ3CZWEaFhA3oy0oFL8+4eZZBYYYsYxwAP5NE0HOokw+xet
 JTdFpEf5VL6yWy+cDmnZh6ySsY/io9du/C6x/paTAuZZz2zNUTYUM7mfCSJbPhmjfyfl
 NeGdqsWK/v0Wl6as0i/hXhAwhQcWbYBE51i0yk1YSwf3mVY0+SduJNEc4MoYt5c4FpFo
 VFJztAGdU0m9KHTufL7KRayxIkQxi+jfIfnfIFXpolozC5MtEhn2QJoPQb8s8zg59KGM
 JuPw==
X-Gm-Message-State: AOJu0YyZmkniBOGSpe4qHwXipeMRR6vWLCVxvgPUHQWnCt1pHX/Y2JBU
 4uoIRiwN2PKNXPg3r0vZUfJn/ezZ38l43FsKBH+X/bwevU+f9LqLsfRtfDrcy8Gsmk5/6ltU9z7
 iK8Fco1Zotk9hrgWXqQ8+i9QQegN/oqzrwQD8EFD0EiEWPEU4pj6Gt2UytBckgwUF
X-Gm-Gg: ATEYQzxe2eRndzcWXr4VUZ2NXdQhv7YhEiUYUJMMKpCfz84NJPo/nLIpknzeLwtX0Ka
 rZTAJ2+hq6mwFQlt6o5m32OTmSJq4D+NPYko41kVtRD+cArQyKHf7MnZC5nxwrsTl8wYneKSY3G
 CX4myujNVkNOWkHlLICqmkFwsigFq3B8X5No95i0N3t9WgE8yHJ+kqOmNWVwi1NeF7uRRvlwPDh
 0/9Znvzy0hZCoJwl37RI/YrK4LT6NjOdgLlX6Zk5ywZb8yYPA0kWVxM9wlc4FQ6b9EKaPBn3yM3
 +q/P6ZFF3Yan5azjmufCv6B5G6t1j6zrzi4TPzxrA/k/biHpQFw9OBNjjrW3zQ14e3u5WNdraYr
 JTgJ3+W8R1xvKKA==
X-Received: by 2002:a05:6214:d66:b0:89a:18bc:2b1e with SMTP id
 6a1803df08f44-89a30ad1536mr243848446d6.38.1773172747677; 
 Tue, 10 Mar 2026 12:59:07 -0700 (PDT)
X-Received: by 2002:a05:6214:d66:b0:89a:18bc:2b1e with SMTP id
 6a1803df08f44-89a30ad1536mr243848076d6.38.1773172747184; 
 Tue, 10 Mar 2026 12:59:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65d16395sm663426d6.48.2026.03.10.12.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:59:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:59:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/8] tests/qtest/migration: Change validate_uuid test to
 not trigger exit(1)
Message-ID: <abB4CCl_VpmzEmT-@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310135540.8679-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 10, 2026 at 10:55:34AM -0300, Fabiano Rosas wrote:
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

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


