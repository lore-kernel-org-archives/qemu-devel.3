Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2185ACF9C55
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 16:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srgPr-0005fJ-6k; Fri, 20 Sep 2024 12:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srgPp-0005em-Bt
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srgPn-0005yQ-Pi
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726849404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5ftDNI4+MN336NjHNR0lrO3iggZbuuQMrLWus/bYGU=;
 b=AMrycSqffteiSpob4NhpHCo6d6m1oidF92NE4wX0DOc2COhOObL9fAGKnpTmh4B+CCzSfm
 TmSNqWYPc/jjK2gL28heidyfSaMjVFpBUNPOCze7hKSvA7jGNi23G+T/eqLZyk8wOPMXis
 DkWvUoM0CxiGKsM+/tHdsqbPUOG6URA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-vsJEX93xOGy3qC03bbab9w-1; Fri, 20 Sep 2024 12:23:22 -0400
X-MC-Unique: vsJEX93xOGy3qC03bbab9w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c3649bca89so37475196d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 09:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726849402; x=1727454202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5ftDNI4+MN336NjHNR0lrO3iggZbuuQMrLWus/bYGU=;
 b=WVQFcgfmUEVy9RcVVeu64vQu3tBsGUE7FWxkeS7UQZa8j52qT98nu33SumBbpMdodM
 hUv2dK+nARzxppqI8IUZ/SU7P7PGeOFaCpKw6kiT/gh3Iad/A4enxfEfvOW68CwFQPbK
 IKpqlYCFJHdmGjmJU+H3apA/9Kk2ovSH/QXHFhy2wkC1AcAdDSnWmRcIk6/OyhY197sn
 1/Nr3SxRCRtza9C1DG6a5qHEAoDKAgWjSM8rq1bcALA5ZVRRT1Q+Jeexhj5YPxBovGww
 hvA6oZ3Wbg/mcci5NCp3wjtLhAqGO0Si87wmu5J2Im93UvAjezb5KCDD9FlR9gVyWRyL
 /D6Q==
X-Gm-Message-State: AOJu0YyicnUcwHWNRr3QDzhiuoGsEEaxcrryefroETzYg/jwTYbZj9HU
 pGioPRaouG+a5IngTzUfe62+D2H3VMj4jEnX7zj8RtwZZRLqg6qYKWSp5rhmqrEKJQhlpWduwgh
 8mC3F2DKzuQs97739u8KZipcuz1MYHQbH12XMA5WzFeNYJHsg+Efb
X-Received: by 2002:a05:6214:5690:b0:6b8:5afd:8f89 with SMTP id
 6a1803df08f44-6c7bc8127d6mr50927606d6.37.1726849402034; 
 Fri, 20 Sep 2024 09:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDpRN3aqOARKsk5XIZWKdjruVTatrE3GedQtGXGk5/Toe8xsLbv8oFu/e4EiZf/uRZ4m7dew==
X-Received: by 2002:a05:6214:5690:b0:6b8:5afd:8f89 with SMTP id
 6a1803df08f44-6c7bc8127d6mr50927146d6.37.1726849401442; 
 Fri, 20 Sep 2024 09:23:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e586d26sm19477486d6.137.2024.09.20.09.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 09:23:21 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:23:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/migration-test: Wait for cancellation sooner in
 multifd cancel
Message-ID: <Zu2hd3-mE4a4a-lj@x1n>
References: <20240920161319.2337625-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920161319.2337625-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Sep 20, 2024 at 06:13:02PM +0200, Juraj Marcin wrote:
> The source QEMU might not finish the cancellation of the migration
> before we start setting up the next attempt. During the setup, the
> test_migrate_start() function and others might need to interact with the
> source in a way that is not possible unless the migration is fully
> canceled. For example, setting capabilities when the migration is still
> running leads to an error.
> 
> By moving the wait before the setup, we ensure this does not happen.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

+Fabiano, +PeterM.

Some more context: this issue Juraj can only reproduce in one of our
downstream 9.2 branch with some probably over crowded build systems.  But
logically it looks still possible to also happen upstream..

queued, thanks!

> ---
>  tests/qtest/migration-test.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 814ec109a6..95e45b5029 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3267,6 +3267,16 @@ static void test_multifd_tcp_cancel(void)
>      qtest_wait_qemu(to);
>      qtest_quit(to);
>  
> +    /*
> +     * Ensure the source QEMU finishes its cancellation process before we
> +     * proceed with the setup of the next migration. The test_migrate_start()
> +     * function and others might want to interact with the source in a way that
> +     * is not possible while the migration is not canceled properly. For
> +     * example, setting migration capabilities when the migration is still
> +     * running leads to an error.
> +     */
> +    wait_for_migration_status(from, "cancelled", NULL);
> +
>      args = (MigrateStart){
>          .only_target = true,
>      };
> @@ -3282,8 +3292,6 @@ static void test_multifd_tcp_cancel(void)
>      /* Start incoming migration from the 1st socket */
>      migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
>  
> -    wait_for_migration_status(from, "cancelled", NULL);
> -
>      migrate_ensure_non_converge(from);
>  
>      migrate_qmp(from, to2, NULL, NULL, "{}");
> -- 
> 2.46.1
> 

-- 
Peter Xu


