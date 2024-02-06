Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D6CC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFto-00083v-TW; Tue, 06 Feb 2024 02:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFtZ-00082w-8K
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:29:30 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFtW-0007od-G1
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:29:27 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d0a0873404so31341411fa.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707204564; x=1707809364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wLmeKxRwsugMUnvezte8WVXIxrVjqcnKlIAyTj3jfB4=;
 b=D/1mHzRMf0Rokqsq/wNsmIZiSHv4FP9EIROBchKGE/Wl93r0mp+uc8HfRVOHSHObb/
 PPQioabF4cTNmajbYVaRkDyrZbMiGfaGNwTz9Ip4qIDyQe3HjI805F4y39NtL6aYPKkf
 woKW9jyuCXyXq06QX0pKnljEYJ/zimJxgeu0Y8DRXnZ5VCMlJN0Fa6p+NwE8FRKua7SD
 RvaOfslZamftFEA58f2fKC+tjSfe3XcbfnjJECtGjW/LSu11rILd/YQkXaOY+pFjy4Jb
 8HEoD7n7PXM/vUkJ2jNNqBDvclKUJuoIPlfL4omA3ybzyU044nAMSxQxwKknYwY+jwwN
 8Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707204564; x=1707809364;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLmeKxRwsugMUnvezte8WVXIxrVjqcnKlIAyTj3jfB4=;
 b=swGKOuurXKSejBQsT3GVgtExfz6qoQgd7FuSsur1D+kjwEqUXW5ni7nWROKUM83gLz
 +Ut7BLeZqRCC5WwaDIbEVnWfwY53xsOYh22VMCD/iuInH4/w/avt0XqsEX+NmaWR9YWG
 NMaSYhmx6VdusHjx4Kecp5A+89jW883WEcsCnrHEktzXeqZVxS3SRxjDz1pd2coYLE2L
 pwUflXvL6mNDHwVvNQsIG6i2eQov/5S6hM+SdBqTrHXdZ7/ND0NUp7/rNMftjoh6THcj
 m8OFQsMLrG698VuYhqA+lS/PZyk5oQpTZMfojU+sedRP/tHSxbciy/SqAh2dtpOV6uDL
 kaDg==
X-Gm-Message-State: AOJu0YxIUx9tXytpMkL27I+U7RML2KTjCTHE1mYbFz07joqf9ZyHQfPB
 BZkqu/PoPLYDAB0mfTGdNOQlcFMexnLuXTdiXoUtLd3r65sQA08Jhmz19QG6e8uqknUCvtoFPzK
 a
X-Google-Smtp-Source: AGHT+IE5OL0Z+GNqNEklrZ7WE2LauzrSQ+EQ8SUUj7X3NuD5NooAYuHQWit4CWf/Fdt0lw3yQ9m2wQ==
X-Received: by 2002:a05:651c:1035:b0:2d0:c058:11c3 with SMTP id
 w21-20020a05651c103500b002d0c05811c3mr284421ljm.20.1707204563553; 
 Mon, 05 Feb 2024 23:29:23 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXdykQr0UjzWYuUqofa9QOmvqnj9FRxpLWFqCxz8s5885/8cAPc+eIJJyY23nMj9pS2xZsDHNB2Gt6H3dnW8qYAWCo1BrGfHBGp5h5hWrlEKke1IcnTjZcWk36dochtFSGLtA7vOlEqoQcdfIhEFUuyzn7qW+7MMqWKmvO59FJ0PGkCTe3IuwSjKkr7bXgNvcfQWfNPoXGfLcpf6Z2Be0T2Ke/MKhCq
Received: from meli.delivery (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 ec44-20020a0564020d6c00b0055fed0e2017sm741674edb.16.2024.02.05.23.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 23:29:22 -0800 (PST)
Date: Tue, 06 Feb 2024 09:28:57 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] monitor: use aio_co_reschedule_self()
User-Agent: meli 0.8.5-rc.3
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-6-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-6-stefanha@redhat.com>
Message-ID: <8fbgw.qqmdqoyo5bff@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x232.google.com
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

On Mon, 05 Feb 2024 19:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>The aio_co_reschedule_self() API is designed to avoid the race
>condition between scheduling the coroutine in another AioContext and
>yielding.
>
>The QMP dispatch code uses the open-coded version that appears
>susceptible to the race condition at first glance:
>
>  aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
>  qemu_coroutine_yield();
>
>The code is actually safe because the iohandler and qemu_aio_context
>AioContext run under the Big QEMU Lock. Nevertheless, set a good example
>and use aio_co_reschedule_self() so it's obvious that there is no race.
>
>Suggested-by: Hanna Reitz <hreitz@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> qapi/qmp-dispatch.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
>index 176b549473..f3488afeef 100644
>--- a/qapi/qmp-dispatch.c
>+++ b/qapi/qmp-dispatch.c
>@@ -212,8 +212,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
>              * executing the command handler so that it can make progress if it
>              * involves an AIO_WAIT_WHILE().
>              */
>-            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
>-            qemu_coroutine_yield();
>+            aio_co_reschedule_self(qemu_get_aio_context());
>         }
> 
>         monitor_set_cur(qemu_coroutine_self(), cur_mon);
>@@ -227,9 +226,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
>              * Move back to iohandler_ctx so that nested event loops for
>              * qemu_aio_context don't start new monitor commands.
>              */
>-            aio_co_schedule(iohandler_get_aio_context(),
>-                            qemu_coroutine_self());
>-            qemu_coroutine_yield();
>+            aio_co_reschedule_self(iohandler_get_aio_context());
>         }
>     } else {
>        /*
>-- 
>2.43.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

