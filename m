Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE767C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEj10-00016u-Pa; Tue, 13 May 2025 02:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uEj0u-00016S-Lu
 for qemu-devel@nongnu.org; Tue, 13 May 2025 02:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uEj0r-0001Cu-LM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 02:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747117271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6eLhr2L+9qOFaS1s2HNVztxs5zRUy9kWOjKJpy7LwTs=;
 b=Q/KTEu/S7lg9kpqVFSXITgs3vjn8GvM5E9gEwl0j30YaApfG5ji2sck0sd64CfAjCqlgRb
 Nmnyet2NhXDCxUto0ikA13bKraN0tH9Wqv3HcJEdeY5aJ9lG6EWWOtfPd7ouO7DbWlpdf1
 TqYAOIg/mQUKqH6E0u56AODxJcCrbmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-u747PWdXNNaiSTfYnoLdww-1; Tue, 13 May 2025 02:21:09 -0400
X-MC-Unique: u747PWdXNNaiSTfYnoLdww-1
X-Mimecast-MFC-AGG-ID: u747PWdXNNaiSTfYnoLdww_1747117269
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442cd12d151so35187155e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 23:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747117269; x=1747722069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6eLhr2L+9qOFaS1s2HNVztxs5zRUy9kWOjKJpy7LwTs=;
 b=BaaIFp49t+qYMYpgvmP9CVW5sl+bPId+g1+VEnh9Klxat9huDi3/ANVVf7sFj8WNxh
 07495Nz5AkzRuE4i/gpnn1ZS1XJIvpcHMx2y1lqwj/NKmAH3GVH2e2z/+lzUQbwWLTd4
 v2rIkgUb67a76X8+sX3GM7g8UKmsRiVOKH47pq54HBjsGgvIdDYLmWz9KbLWmbmtNSz1
 raWl3p64xhPx2uUTkG+YhSc7oTH+8Dmhnj3hh+KjNawO/rNBHbtb849Bh7WlNSViTMVv
 rnebcTmBKHOxnjSTsHskt+9n+TPRqhGBk5SiELbAWkMFLINFmmKMMEU4YFAgNImZUYG6
 xytQ==
X-Gm-Message-State: AOJu0Yyd14SWSRl94KYfJXlQsZHUdnUBxsPAteWFAb3U+RlsqdElCs8D
 q5K/pXEvcIulMKaXGYakc6/h2qZphwX2jtsbsH8iHt//Wn33paH2+N9FxHQfoYrVGOnKjJEGA0f
 Hz3EnSSLCiPwY+SAmVTwq9b4ymZJ5ISh7MtfiJShp8XFTFbNQfT57ysg80MNBbuXmPNNd4tuRTK
 SyXV4saf5SilnTRfIF0ki4r1THJ2s=
X-Gm-Gg: ASbGncvkWpGwqwmT4ZtIoT2w2/DO0nPYyQUj5bAs7zeg2jfER7xUH3L2ggYmilC7krY
 YGet9rDKHfL6llZ+v/AnqMRNVBsAPBpFeVZCbgFj26uMlAWubPxzz6tzliqWv02Vu9Pc=
X-Received: by 2002:a05:600c:1d07:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-442d6d37079mr150180435e9.10.1747117268658; 
 Mon, 12 May 2025 23:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUmgFSZ4cb3RGFItFhdDF3+1SbYOqvV4nlQme4X+UiL+6EXZN0T36rQg+zxuBKpDaSttl+DipBBdZ8AmebC1E=
X-Received: by 2002:a05:600c:1d07:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-442d6d37079mr150180225e9.10.1747117268368; Mon, 12 May 2025
 23:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-3-ppandit@redhat.com>
 <aB0AMQdPbcdNy_bS@x1.local>
 <CAE8KmOx_7EXXNQa0q0gKvZmWMT-0hYcKH6wRFiUEs_-KANf1Ow@mail.gmail.com>
 <aB4Rgj5nghklODSq@x1.local>
In-Reply-To: <aB4Rgj5nghklODSq@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 13 May 2025 11:50:51 +0530
X-Gm-Features: AX0GCFsZoVTtYg195Whh72gh1N1yW1IL6k6aIapcV0-7GpAnabXgGYEPr3Sagv4
Message-ID: <CAE8KmOweYYgZKK8dgts=xex_segpwS_Ts2_R7qcXq61XKn1Yig@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] tests/qtest/migration: add postcopy tests with
 multifd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 9 May 2025 at 20:00, Peter Xu <peterx@redhat.com> wrote:
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index a575791c72..441a65bcf5 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -34,7 +34,6 @@
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>
>  static char *tmpfs;
> -static bool postcopy_ram = false;
>
>  static void test_precopy_unix_plain(void)
>  {
> @@ -525,7 +524,7 @@ static void test_multifd_tcp_channels_none(void)
>   *
>   *  And see that it works
>   */
> -static void test_multifd_tcp_cancel(void)
> +static void test_multifd_tcp_cancel(bool postcopy_ram)
>  {
>      MigrateStart args = {
>          .hide_stderr = true,
> @@ -612,11 +611,14 @@ static void test_multifd_tcp_cancel(void)
>      migrate_end(from, to2, true);
>  }
>
> +static void test_multifd_precopy_tcp_cancel(void)
> +{
> +    test_multifd_tcp_cancel(false);
> +}
> +
>  static void test_multifd_postcopy_tcp_cancel(void)
>  {
> -    postcopy_ram = true;
> -    test_multifd_tcp_cancel();
> -    postcopy_ram = false;
> +    test_multifd_tcp_cancel(true);
>  }
>
>  static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
> @@ -1205,7 +1207,7 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>      migration_test_add("/migration/multifd/tcp/uri/plain/none",
>                         test_multifd_tcp_uri_none);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
> -                       test_multifd_tcp_cancel);
> +                       test_multifd_precopy_tcp_cancel);
>      if (env->has_uffd) {
>          migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
>                             test_multifd_postcopy_tcp_cancel);
>
>
> Would this work?
>

* I did; v11 includes it. Thank you.
---
  - Prasad


