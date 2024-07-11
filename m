Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C4DC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuhf-000477-Pf; Thu, 11 Jul 2024 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRuhe-0003r8-0w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRuhb-0006h5-SE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720707798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfhQtPg6E6lDKVRXDjGIPN+hZwD6fzoHj8AYeuDMm9w=;
 b=f5ZCN6XKRyKoJtE3xCQcbUt4q5kDBoVc1EFh+CHvvWYtachAHjSGSOgcL1DW0a36FyRIAN
 ClsMkPGJiSmZnWaXEzI8dHgfHCV3GgQa3ke7u1f2xigXmkk2J5/6mxwRuHBphgEa/9n9C9
 u4bywULZYXR27zWuAxLXk2LobIbRg/4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-lTp0ZwRgON-oeZoGJ74Efg-1; Thu, 11 Jul 2024 10:23:16 -0400
X-MC-Unique: lTp0ZwRgON-oeZoGJ74Efg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b60b5b85deso2056186d6.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 07:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707796; x=1721312596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfhQtPg6E6lDKVRXDjGIPN+hZwD6fzoHj8AYeuDMm9w=;
 b=u8xjIJz56qiG4vrNUfK58CLN/R6D/FLttH3Nr6mjcrTgpMTi6zpQUvTFuWDNDazpZi
 Zit8nMaRi2z8hGpqsEBEO6rghQm/eEbOly4we7h1fXl4WG9w5myQ/+YwOIf6EMlhxx1u
 5f8IsnlPvoYU0tTzUPnq2Vsvg6JUeoyaxFhsRVWNOHPHUD9TGUwaB5xl61V8Jlnrrr0v
 fhd5slYC3LMAfI3gKPPtGJ6NgSSRF+tZicJPOapSMZ3s7vx7EKmo4lY5W6481nK/u11b
 mvS+9QdxRVmAep1vN2sP80ayV6jGKN5hglsbQW+0ugui1umGnGLVM6nxF3MLlTchHg3A
 uqPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOMRoQg8LNeXJBCPDLuAQeHGAl2QVEoXbz5Nhlk0Jw3MN8jXpzZmdXkYGd0CUxakCOuoPKlQRrhns9qI4AGqp/bORpmWE=
X-Gm-Message-State: AOJu0Yx6ECyNRH6K+auvU3Kd7WTNVFXukNQFtl49Eg8+gB0eQcxZ7+lk
 UA01M3URlPbBHm+NpEfEx/NvbS2zeL+CUrUOdyfMjLNzffsA1wXlvQcmXTaF2QY20QJFiwCMfcc
 3xAdTV7Fmwmq+6SgPYHzE6YlaWlHobpywvjMaT0aMU371Fq9wKyBk
X-Received: by 2002:a05:6214:1188:b0:6b0:6370:28d4 with SMTP id
 6a1803df08f44-6b74b23aae0mr27163746d6.6.1720707796258; 
 Thu, 11 Jul 2024 07:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCoMtyse9UyFiewn/OEe27YMu2lHJT7PcrINi97SAtWWa5Z28vq3uOZc0w/tAJMB2mt2lxCQ==
X-Received: by 2002:a05:6214:1188:b0:6b0:6370:28d4 with SMTP id
 6a1803df08f44-6b74b23aae0mr27163486d6.6.1720707795898; 
 Thu, 11 Jul 2024 07:23:15 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba74bdcsm25980796d6.97.2024.07.11.07.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:23:15 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:23:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v5 5/5] tests/migration: Add integration test for
 'qatzip' compression method
Message-ID: <Zo_q0UKEwEi3KWsJ@x1n>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <20240711025229.66260-6-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711025229.66260-6-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 07:52:29PM -0700, Yichen Wang wrote:
> From: Bryan Zhang <bryan.zhang@bytedance.com>
> 
> Adds an integration test for 'qatzip'.
> 
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  tests/qtest/migration-test.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 70b606b888..b796dd21cb 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -32,6 +32,10 @@
>  # endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> +#ifdef CONFIG_QATZIP
> +#include <qatzip.h>
> +#endif /* CONFIG_QATZIP */
> +
>  /* For dirty ring test; so far only x86_64 is supported */
>  #if defined(__linux__) && defined(HOST_X86_64)
>  #include "linux/kvm.h"
> @@ -2992,6 +2996,22 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
>  }
>  #endif /* CONFIG_ZSTD */
>  
> +#ifdef CONFIG_QATZIP
> +static void *
> +test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
> +                                              QTestState *to)
> +{
> +    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
> +    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
> +
> +    /* SW fallback is disabled by default, so enable it for testing. */
> +    migrate_set_parameter_bool(from, "multifd-qatzip-sw-fallback", true);
> +    migrate_set_parameter_bool(to, "multifd-qatzip-sw-fallback", true);

Shouldn't this already crash when without the parameter?

> +
> +    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
> +}
> +#endif
> +
>  #ifdef CONFIG_QPL
>  static void *
>  test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
> @@ -3089,6 +3109,17 @@ static void test_multifd_tcp_zstd(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_QATZIP
> +static void test_multifd_tcp_qatzip(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
> +    };
> +    test_precopy_common(&args);
> +}
> +#endif
> +
>  #ifdef CONFIG_QPL
>  static void test_multifd_tcp_qpl(void)
>  {
> @@ -3992,6 +4023,10 @@ int main(int argc, char **argv)
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
>  #endif
> +#ifdef CONFIG_QATZIP
> +    migration_test_add("/migration/multifd/tcp/plain/qatzip",
> +                test_multifd_tcp_qatzip);
> +#endif
>  #ifdef CONFIG_QPL
>      migration_test_add("/migration/multifd/tcp/plain/qpl",
>                         test_multifd_tcp_qpl);
> -- 
> Yichen Wang
> 

-- 
Peter Xu


