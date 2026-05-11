Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA61CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMR0D-0006La-72; Mon, 11 May 2026 09:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMQzy-0006K8-4i
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMQzv-0003gc-US
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778507318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4lRusBxp69b291Rn2KyoduTNZklrUnXfQmClhnt/9XI=;
 b=SVOWsmOY13ABaALthqq73/P/T9Ca98xSr2nvUs26wlOEJhca9De+V3e1Okh0WuEFYDt/RL
 nAkiJLjkrkYj4Co8Q2nn4vghZAqdtPZOB96yu/6yiSJT6hID6j03WFI4yZEhSO13MAJ+W6
 2b3XE8NF09cYI4IKw6tPH98UTns+JUA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-g2w0QrP3MHOc7yUsTESPPw-1; Mon, 11 May 2026 09:48:33 -0400
X-MC-Unique: g2w0QrP3MHOc7yUsTESPPw-1
X-Mimecast-MFC-AGG-ID: g2w0QrP3MHOc7yUsTESPPw_1778507313
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51009190feeso77454111cf.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778507313; x=1779112113; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4lRusBxp69b291Rn2KyoduTNZklrUnXfQmClhnt/9XI=;
 b=OFqO/HYJAVxvYxDJcRr8ckFyDaejoPnjkQ0aP6qBwXteaIhJHyl73THqbbf078OBKN
 uDjiBs5Q3KaSC4ffi5dR9zUvU0FZ7FOXGTxWjlXGPlIk0EzG4Yv14neiWZf19S/TCViz
 PP4vS3iOW3fKO4goqRgbHKwSJo5V+L0fo6J2DBZxrMKmtA5dr73da/MTP/DiA1LcEMSw
 RHIP0rV5q/gZnPXRlR1HXMYSj0HHCsUz+lDPrCvOeczg+pZznOh8bxYq0WRE1g0CZb+y
 fdEoF/isv3WdSbnu5uDMOEku+lRQ2UXdDkAvqEBTzIM/sFNgoLahps3/TTcA4QsLikT2
 Nm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507313; x=1779112113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lRusBxp69b291Rn2KyoduTNZklrUnXfQmClhnt/9XI=;
 b=hiVaa3Trlyre+d716b7aLjCjzVS/v+TuSkBAbcVylwKn2gglCMyUC76/lydyAEokYQ
 6xQbN0KW/ZHZemRZv0TDRJ8ORWRTXwQlWWP2ndRqq3e/Hajmu7hRdRyTZjlmi9jfAl5U
 pBdvapvDTkUv+optiqGD10Lh5BzLP1Nqzb1c3PZP97EGLkbuEEIVJv36wAu+dnYvOJfx
 7kz10hoINIrwAr1UpAQIHkuakI9E0QALm8+K0V5dmXAtIAEnQ/chYgAB0mYo+Yn5oTHl
 Vy2leF9c5WKwXkaeoorLvz+Sxha6hPZP1gSJbeYNrobMd/JmJIIIVY64CWQw9U9a4jS4
 PtBQ==
X-Gm-Message-State: AOJu0YyMbt9fkKlrfYUyqLFzewJFYzm0KBcl7hes9Mq8QrPTz4qHgTwe
 B0fdOu6blcpicY2qr7KoljzqF4D8D2g2sL7ImCs6oz139Z0yZPd5Bmb/wOQeoFN00p0RFqGthZi
 EVqS7iHQLHOfcmUoZyyglV0lYpRarEIaaFTBEQnAeFy0qlgeqOvduOEvX
X-Gm-Gg: Acq92OFuzPWljv+1m7rJMpfxHuTrhHogThWsYHte9lEjHnk7Dzl4ytVSEzwf9NOUzgJ
 i4yUBBFudKU6dOIDDv5p/m/tlHc6fL5f5ssSW0Ijv4iVjF26NzdW1kFJi6DUyrBODdddEXd1kr8
 RTGpj9nMs+n6KOxfwmMnzVovJCjQjsP2sjXg/k9oFu60NENayyJs9VLQ8whCmvxS5DkM1snjUlL
 BZmTrteN/vzow5C/NdEBr8hBmh89R2BlrLQ7S/spPz/l7wuvEokE480TQV7MmN724M0vG1kN1H5
 5nKfq1mp8d+zjzuvHBkFtFCvNZNAMmERCy3FhIFCABmsZRMZ0i/nflrOndjYglw3+C5/vSEIRRP
 O54/SOJsVQQIqia1ybuUV1zxBpH2sO+/fbeQTRQ1AKGFCXuM=
X-Received: by 2002:a05:622a:149:b0:50f:b17d:7e5e with SMTP id
 d75a77b69052e-514a0a8ebecmr132311481cf.24.1778507312994; 
 Mon, 11 May 2026 06:48:32 -0700 (PDT)
X-Received: by 2002:a05:622a:149:b0:50f:b17d:7e5e with SMTP id
 d75a77b69052e-514a0a8ebecmr132310271cf.24.1778507311878; 
 Mon, 11 May 2026 06:48:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d35787esm312282626d6.44.2026.05.11.06.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:48:30 -0700 (PDT)
Date: Mon, 11 May 2026 09:48:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PULL 13/23] migration: Calculate expected downtime on demand
Message-ID: <agHeLeJ-uVz0B5jg@x1.local>
References: <20260505202640.1011006-1-peterx@redhat.com>
 <20260505202640.1011006-14-peterx@redhat.com>
 <CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 07, 2026 at 08:57:24PM +0100, Peter Maydell wrote:
> On Tue, 5 May 2026 at 21:29, Peter Xu <peterx@redhat.com> wrote:
> >
> > This value does not need to be calculated as frequent.  Only calculate it
> > on demand when query-migrate happened.  With that we can remove the
> > variable in MigrationState.
> >
> > This paves way for fixing this value to include all modules (not only RAM
> > but others too).
> >
> > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> > Link: https://lore.kernel.org/r/20260421202110.306051-12-peterx@redhat.com
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Hi; I'm seeing a clang undefined-behaviour sanitizer failure
> in the code introduced in this change when running the
> aarch64 migration-test via "make check" on an x86-64 host.
> 
> It seems to happen fairly reliably when I do a "make check -j20",
> but not when I run the test on its own, so it's probably load dependent.
> 
> Here's the backtrace:
> 
> ../../migration/migration.c:1051:12: runtime error: inf is outside the
> range of representable values of type 'long'
>     #0 0x57b49d635c0d in migration_downtime_calc_expected
> /home/pm215/qemu/build/arm-clang/../../migration/migration.c:1051:12
>     #1 0x57b49d63e860 in populate_time_info
> /home/pm215/qemu/build/arm-clang/../../migration/migration.c:1075:35
>     #2 0x57b49d63617e in fill_source_migration_info
> /home/pm215/qemu/build/arm-clang/../../migration/migration.c:1184:9
>     #3 0x57b49d63617e in qmp_query_migrate
> /home/pm215/qemu/build/arm-clang/../../migration/migration.c:1264:5
>     #4 0x57b49e4aed75 in qmp_marshal_query_migrate
> /home/pm215/qemu/build/arm-clang/qapi/qapi-commands-migration.c:48:14
>     #5 0x57b49e526814 in do_qmp_dispatch_bh
> /home/pm215/qemu/build/arm-clang/../../qapi/qmp-dispatch.c:128:5
>     #6 0x57b49e58c35a in aio_bh_call
> /home/pm215/qemu/build/arm-clang/../../util/async.c:173:5
>     #7 0x57b49e58c698 in aio_bh_poll
> /home/pm215/qemu/build/arm-clang/../../util/async.c:220:13
>     #8 0x57b49e542fc1 in aio_dispatch
> /home/pm215/qemu/build/arm-clang/../../util/aio-posix.c:390:5
>     #9 0x57b49e58f10a in aio_ctx_dispatch
> /home/pm215/qemu/build/arm-clang/../../util/async.c:365:5
>     #10 0x7c74a09b8584
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d584) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #11 0x7c74a09b86cf in g_main_context_dispatch
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
> 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #12 0x57b49e5901cb in glib_pollfds_poll
> /home/pm215/qemu/build/arm-clang/../../util/main-loop.c:290:9
>     #13 0x57b49e5901cb in os_host_main_loop_wait
> /home/pm215/qemu/build/arm-clang/../../util/main-loop.c:313:5
>     #14 0x57b49e5901cb in main_loop_wait
> /home/pm215/qemu/build/arm-clang/../../util/main-loop.c:592:11
>     #15 0x57b49d5f5486 in qemu_main_loop
> /home/pm215/qemu/build/arm-clang/../../system/runstate.c:948:9
>     #16 0x57b49e42cdfb in qemu_default_main
> /home/pm215/qemu/build/arm-clang/../../system/main.c:50:14
>     #17 0x57b49e42cdd3 in main
> /home/pm215/qemu/build/arm-clang/../../system/main.c:93:9
> 
> 
> > +/* Return expected downtime (unit: milliseconds) */
> > +int64_t migration_downtime_calc_expected(MigrationState *s)
> > +{
> > +    if (mig_stats.dirty_sync_count <= 1) {
> > +        return migrate_downtime_limit();
> > +    }
> > +
> > +    return mig_stats.dirty_bytes_last_sync /
> > +        migration_get_switchover_bw(s) * 1000;
> > +}
> 
> Presumably in this function migration_get_switchover_bw() returns 0,
> so the (floating-point) division results in Infinity. That's fine
> until we have to convert it to int64_t to return it, which is the
> UB that the sanitizer is complaining about...

True, I can easily reproduce the warning too.  I'll send a patch.

Thanks,

-- 
Peter Xu


