Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7E6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 19:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC2Ns-00082i-Iw; Tue, 28 May 2024 15:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC2Nr-00082J-C9
 for qemu-devel@nongnu.org; Tue, 28 May 2024 15:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC2Np-0002EN-Oh
 for qemu-devel@nongnu.org; Tue, 28 May 2024 15:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716924076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+mj8Oo/8BoBtqd5SnkOgvpFV4aem2rrS6GizfrC7XU=;
 b=diNX0sWVeX8KadPtYpaGKz+MFKQzAOUL4zEKQtP8Y3lKbm0OWXE8wFM861ogU6XujtrVGO
 R5TkiJLExGhfFursqUTDvPZj7kyy2/rriRSwFQgsst68Od/swDAu8gxBtK3sQPB0T/bb8m
 5xZSGUTIaozBi8EDe7MjkrzEOqPG14E=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-5wJNgCfZM9qnDyqct-kRWA-1; Tue, 28 May 2024 15:21:14 -0400
X-MC-Unique: 5wJNgCfZM9qnDyqct-kRWA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d1c872c80bso68187b6e.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 12:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716924074; x=1717528874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+mj8Oo/8BoBtqd5SnkOgvpFV4aem2rrS6GizfrC7XU=;
 b=hFlXQ9OpvIB7S0d/WKTTTNGeUs1Vo3NYQNDdjzGN2wlWAO2azbwVQ8j5ZMbqh/XjGZ
 4DAogFPrXMJiQ1Y6Ye9xgmjs+CsydUvmx/FYUFKn958c8wVDvLT4yOIRr1k8lut2h6gy
 LrHtSkntfTB3bGM6D9OwWRLwiddOAcb4K5mqcp5zTpyo7tUTUq5DXlq3RabwSDV0jfS4
 Rzq/lDKndjy/eYD26ZffGYoU/gf2ML8NYAE5ly96Zbrxkmyofwxm0AaxmMEUA/AxOwnq
 4zsvVGVN9FK0qgXEo7/sSXjfhCLagaR0KHunnDHoGSb1uh8YnPouawiikzM59fKuPQ+V
 mHEA==
X-Gm-Message-State: AOJu0YxyvLISozxXQ2uKsfoMz0J3D9MN3NbCb41AScrk7SeaqdK+3kQD
 70wdsrnm4BQCcDgxD8+bCuUDZLFY62T65E8kfTVieUXJ+PHsj9TyqiX0MuQX0BCbfeND5fa7BiX
 MQWTuPScLfAz7IATwfqzZlKlzETq3T2xerycuOXgl4KyZ3CQrBkQT
X-Received: by 2002:a05:6830:3615:b0:6f0:52fb:c693 with SMTP id
 46e09a7af769-6f8d0a643e4mr12447089a34.1.1716924073731; 
 Tue, 28 May 2024 12:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEXKWZhMp9y1GnGELDGNqG1CFe/mTHQRgFLMdR/ObPANeiOI4SCrAJfba68rJt1fXvArf8rw==
X-Received: by 2002:a05:6830:3615:b0:6f0:52fb:c693 with SMTP id
 46e09a7af769-6f8d0a643e4mr12447067a34.1.1716924073230; 
 Tue, 28 May 2024 12:21:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb17cce1asm45023961cf.27.2024.05.28.12.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 12:21:12 -0700 (PDT)
Date: Tue, 28 May 2024 15:21:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 2/6] tests/qtest/migration-test: Fix and enable
 test_ignore_shared
Message-ID: <ZlYup1uFyottfCPi@x1n>
References: <20240528004211.564010-1-npiggin@gmail.com>
 <20240528004211.564010-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528004211.564010-3-npiggin@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 28, 2024 at 10:42:06AM +1000, Nicholas Piggin wrote:
> This test is already starting to bitrot, so first remove it from ifdef
> and fix compile issues. ppc64 transfers about 2MB, so bump the size
> threshold too.
> 
> It was said to be broken on aarch64 but it may have been the limited shm
> size under gitlab CI. The test is now excluded from running on CI so it
> shouldn't cause too much annoyance.
> 
> So let's try enable it.
> 
> Cc: Yury Kotov <yury-kotov@yandex-team.ru>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave's new email is:

dave@treblig.org

Please feel free to use it in a repost.

Thanks,

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/migration-test.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 04bf1c0092..8247ed98f2 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1893,14 +1893,15 @@ static void test_precopy_unix_tls_x509_override_host(void)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -#if 0
> -/* Currently upset on aarch64 TCG */
>  static void test_ignore_shared(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
> +    MigrateStart args = {
> +        .use_shmem = true,
> +    };
>  
> -    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
> +    if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
>      }
>  
> @@ -1925,11 +1926,11 @@ static void test_ignore_shared(void)
>      wait_for_migration_complete(from);
>  
>      /* Check whether shared RAM has been really skipped */
> -    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
> +    g_assert_cmpint(read_ram_property_int(from, "transferred"), <,
> +                                                   4 * 1024 * 1024);
>  
>      test_migrate_end(from, to, true);
>  }
> -#endif
>  
>  static void *
>  test_migrate_xbzrle_start(QTestState *from,
> @@ -3580,7 +3581,8 @@ int main(int argc, char **argv)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
> +    migration_test_add("/migration/ignore_shared", test_ignore_shared);
> +
>  #ifndef _WIN32
>      migration_test_add("/migration/precopy/fd/tcp",
>                         test_migrate_precopy_fd_socket);
> -- 
> 2.43.0
> 

-- 
Peter Xu


