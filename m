Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F892D6E2BD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 17:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWHtK-0004I9-8H; Thu, 18 Dec 2025 12:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWHtG-0004Hg-Lq
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWHtD-0005Er-Mk
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766079249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRzBd0QavuuzPtNtj6nv2GwDQqOBM9L/5ufR7nGbRLk=;
 b=Fa5zJ7EAmnEwM8xnjbsoy6ZSnJMnUmaigjC+yX9D/82bdnj+iZ6OMxT5faIAw7HKx8+zFx
 sQgV291UBQfjrUeSOnZ738Liq30KuDM040y8IlQudoK8MTRagbxGlcrC2DkRrXLUq1bNFD
 WbEjaBGLk6wxeOEjGxzO9DtH/5T7FHs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-E7TYK_ymPHikcpma8UViZw-1; Thu, 18 Dec 2025 12:34:08 -0500
X-MC-Unique: E7TYK_ymPHikcpma8UViZw-1
X-Mimecast-MFC-AGG-ID: E7TYK_ymPHikcpma8UViZw_1766079248
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2dbd36752so186830185a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 09:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766079248; x=1766684048; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kRzBd0QavuuzPtNtj6nv2GwDQqOBM9L/5ufR7nGbRLk=;
 b=cQZJh2vOsDDk6eRtlfP0Gm6YTSqmBFHs13cXiCA1+fS3cq4MniK/XTKYSKEFHNKRys
 pVoHih3OKQ1drr6TD4HfX+bWt4k8WF5B7x1RlQkeHyy1yjgtKjacKUh/nf4GvYN/Ksel
 nNXau6dhMTYgbGhD6fUAC2ic49bCtQO+C9xhzp9M0PScQOMWnzYOt5shhdcXRs37V8bS
 nzTWgdnPKG6rra8Jw76XzuccVT7fj5Nrugza+xCU8P6JPlMvM+638zvxcb5ZcAr8Y6FJ
 APIp1m1Ig+QSC20cYEF1Yz85kjwCrDMm3bFZFQr1nZ01SXUXi9oUu1siSqmwiz90yAHD
 HzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766079248; x=1766684048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRzBd0QavuuzPtNtj6nv2GwDQqOBM9L/5ufR7nGbRLk=;
 b=SWA+wYMfw0f99p614ddyfmtPMxqG7lO6BRvh2gL8ElbmV1k9SmM8fss+fr9QnbM9wO
 IXAjtHtfrGMuANzpKwGl32KGHfeu0K+ZwYRJDQtzQ/NK4NdbjWFY+YLOFZygfRAEzb1u
 lzdKla1QETpvpn8XeJPFEbHvgKTyToj0rBAip9JP2YVp0D3eFGGmSd8pb7kB6GfE3Aiq
 L4ZcjWc1cBc5fUDTKsZj2uTB4hYmDUGW6g7kxcOETGWgdtJYxTepLu+YshARzTJ2VwnZ
 oxZGTxU3C3VlGlezOCZ3gsqOfEOZjoBXcJJV0tSd+jqIhV3+obT2hUPK5+Jho2JBGeGT
 mzuA==
X-Gm-Message-State: AOJu0YzQvj45Ol/7LHUDU99n10mRHsS37Y1FGLQQ0gzyNLVyrq3dKP2T
 JSp6I/hlFss0YQ7VEiXTAHHL8xu2rTZdz6QvLDnlj3fKk1l5hq2P4zhDs94DtbtQg9R6UfYeMOy
 t5AYrCtBqd9WBAvDnsAissij6Hs4ujinQGr8w/NLflWM8QWB6qm3pE3b/
X-Gm-Gg: AY/fxX5m34HZuJW3X+PA0lI65rrn21wuRvLk3P1+gawORu6f3iJ0Ldf4P0uCPEZgaBR
 dTtlWPmO9ytUAkAueNJh7D/S2nJaaCfNk8J98RMfkHmELUf0/DI4a4Y/FtTxf6f5gcWDSP6aFCw
 LHelslktOKgiHffN+bKQDj4RYY0ypITwOU48ZHtx2JF9MaIAaZ5G9a5L4vZUq4nZSo9zUqThoiA
 jTfQXaRb+GdPBNcRC/Mqgi+NKaeKgsxbzKLbFnFRRzSm+WUbziOhLdtomEBkbKlGkU4aZUaSHzV
 JAh9g8pOy3HFhhFIcm31E8gkakMLaJmq/9fOOUg3eYzAphrVvEU0SgBRlDJL2QQ1wRykE7RJRSe
 MWE0=
X-Received: by 2002:a05:622a:610:b0:4ee:5fc:43e5 with SMTP id
 d75a77b69052e-4f4abcd07cdmr244951cf.12.1766079247626; 
 Thu, 18 Dec 2025 09:34:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcS8SCFC2aSeJnvfZjBZJ3GYg8vGs3BqCox6mV7BVQ+A60Z9clQShQ94/w/wXrXkcm4aH9YQ==
X-Received: by 2002:a05:622a:610:b0:4ee:5fc:43e5 with SMTP id
 d75a77b69052e-4f4abcd07cdmr244371cf.12.1766079247096; 
 Thu, 18 Dec 2025 09:34:07 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d9a254849sm312566d6.44.2025.12.18.09.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:34:06 -0800 (PST)
Date: Thu, 18 Dec 2025 12:34:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 30/51] tests/qtest/migration: Add temporary code to
 toggle usage of config
Message-ID: <aUQ7DcU5T_GH8G1V@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-31-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-31-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 07:00:16PM -0300, Fabiano Rosas wrote:
> The tests are being refactored to pass migration options to QEMU using
> the new API of passing a JSON object as argument the migration
> commands instead of using several calls to the
> migrate_set_capabilities|parameters commands.
> 
> Since multiple tests share common infrastructure (framework.c,
> migration-utils.c, migration-qmp.c), it's cumbersome to convert tests
> in small chunks, which would require changes to every common function
> to accept both the new and old ways.
> 
> After some tinkering, an easier way to do this transition is to allow
> the tests to set a key in the config dict itself telling whether the
> config is supported. With this, the common functions can be fully
> altered to support the config object, as long as they check this
> temporary key and do the right thing.
> 
> QEMU doesn't know about this hack, so some code is needed to hide it
> when issuing QMP commands with the config object.
> 
> This will all be removed once tests are fully converted.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/migration-qmp.h  |  1 -
>  tests/qtest/migration/migration-util.c |  1 +
>  tests/qtest/migration/migration-util.h | 34 ++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
> index 940ffd5950..9a36a677ba 100644
> --- a/tests/qtest/migration/migration-qmp.h
> +++ b/tests/qtest/migration/migration-qmp.h
> @@ -47,5 +47,4 @@ void migrate_recover(QTestState *who, const char *uri);
>  void migrate_cancel(QTestState *who);
>  void migrate_postcopy_start(QTestState *from, QTestState *to,
>                              QTestMigrationState *src_state);
> -
>  #endif /* MIGRATION_QMP_H */
> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> index 416dd10ef8..e702f00896 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -255,6 +255,7 @@ static void migration_test_wrapper(const void *data)
>  
>      test->data = g_new0(MigrateCommon, 1);
>      test->data->start.config = qdict_new();
> +    qdict_put_bool(test->data->start.config, "use-config", false);
>  
>      g_test_message("Running /%s%s", qtest_get_arch(), test->name);
>      test->func(test->name, test->data);
> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> index e73d69bab0..3c3b5a8777 100644
> --- a/tests/qtest/migration/migration-util.h
> +++ b/tests/qtest/migration/migration-util.h
> @@ -60,4 +60,38 @@ void migration_test_add_suffix(const char *path, const char *suffix,
>  char *migrate_get_connect_uri(QTestState *who);
>  void migrate_set_ports(QTestState *to, QList *channel_list);
>  
> +/*
> + * Scaffolding to allow the framework _common functions and _qmp
> + * functions to use the config object while some tests are still using
> + * migrate_set_*. Tests that have been converted will set use-config =
> + * true on the config dict.
> + */
> +static bool has_key;
> +static bool use_config;

Looks like this is temp measure, so no strong opinions.. said that, it
looks tricky to have the two globals shared between all the tests, and
having magic keys in the qdict.

Can we pass in MigrateStart* for config_load() and config_put()?  Then at
least we can change globals into per-test flags of MigrateStart.

Btw, AFAIU the two helpers should always used in a pair but load() and
put() do not look like a pair..

If we can have args->use_config as a bool, having tests opt-in config
setups by setting it, then I wonder if we can do that like:

  if (args->use_config) {
      // do whatever with args->config...
  } else {
      // covered by other migrate-set-parameters QMP commands..
  }

Do we really need config_put()? I'll keep reading, but please evaluate..

> +static inline QDict *config_load(QDict *config)
> +{
> +    if (!config) {
> +        return NULL;
> +    }
> +
> +    has_key = qdict_haskey(config, "use-config");
> +    if (has_key) {
> +        use_config = qdict_get_try_bool(config, "use-config", false);
> +        qdict_del(config, "use-config");
> +    }
> +
> +    if (use_config) {
> +        return config;
> +    }
> +
> +    return NULL;
> +}
> +
> +static inline void config_put(QDict *config)
> +{
> +    if (config && has_key) {
> +        qdict_put_bool(config, "use-config", use_config);
> +    }
> +}
> +
>  #endif /* MIGRATION_UTIL_H */
> -- 
> 2.51.0
> 

-- 
Peter Xu


