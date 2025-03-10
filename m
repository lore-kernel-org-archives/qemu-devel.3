Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B975DC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYMs-0006Pc-B7; Mon, 10 Mar 2025 04:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYMq-0006NM-Bh
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYMk-0004Ae-Cd
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741594799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8dh/VhidLhRnAZYmemneE028i0H2G6UoHb9BsguyTc=;
 b=ec92ZRaZi1ObHosgvfCMLU9A0S3fx1N1DnUdspubrbeE3rlszKHdbpMh2X1g6RDfMqDzt3
 VWmC8Nzqd/In2rPn4eFMuAvYU3/7/2/4OIwxQ4pBOgJfjOfOX+wyEekxYxLDLdCBmeRvbd
 7W5mk1jAs7DKF3z2MM4Nly0vICu7j0M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-SLk8Gqt9OIaxEssEfbfIwQ-1; Mon, 10 Mar 2025 04:19:58 -0400
X-MC-Unique: SLk8Gqt9OIaxEssEfbfIwQ-1
X-Mimecast-MFC-AGG-ID: SLk8Gqt9OIaxEssEfbfIwQ_1741594797
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2172631f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594797; x=1742199597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N8dh/VhidLhRnAZYmemneE028i0H2G6UoHb9BsguyTc=;
 b=BzJpTFDchdXU+RrcqvGfzCH1yIZT5xXVvZKQIq1vltGOk6V6W5Slao5+G819hpPf4L
 UrvhIlKiPIQqo9BJKCb1Rev0clyCvpk56BGx6EE5dbb2ILiF31Tmio7Lqy4/p9nZhRhg
 kpZT5IG8L9j2x14SZsJ+Gaygm3Dr9Nte8T5JREf3yw9HnN5lq6cwN+I2IWZAONvyHZWZ
 +Uubfx5q/2DQ6oZW98rsY+T/Y0fqZ5WtE+4Sv/g1u3f2ROD2A371u11rVQ4WbHi0Q8t7
 TlGTCaSDnzh0tQOLn8HcsmWzJ5sZLG6LwouBWZfNFLAXUEXeZqxLlu5hkRrk3gRE5SVu
 bGlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLK8hPysgEZQemkA6McvLRj0o1kNAc9J6mZDb15Tznbocs7fiGCfRxyFkRGxXaWptl3DfQAqvyLL06@nongnu.org
X-Gm-Message-State: AOJu0YywoYqDaWII79Qj8W1K7ToJ3lZiXugjmhSHFlmuVJkMTivgRZRy
 1pdq516+fNGUXxKdDMPaEjQuzOtMLUyaV4n9F2ZmHD9zkyTTxUzBxFJCvlwTF5goI7x2IspPIHq
 z3XpTZVRND7LxfiAvq2C1sorrOdlYtv/vLD7XT2oX1PyWy45YU+ep
X-Gm-Gg: ASbGncu7eOlJQ3dDgXcLEqikF51kXwmcuEL/8I8voC9YRehcY62er+/FRFr0MnWvD0/
 52HOo8cvNRfVRMeWapeVrC5FPkxJd34qZcJSbZ5q2ek6WyknyUIXjL++biZzUSnFSAHjB8N3jGm
 pGBCTMCYjNfE3kVJ8IpuF/AgueSsDhUSJgZnk65emovA+2ORL3RyOj5xM0ZRAReMGIhSVwFnpx0
 C72eq/4tFiUhAM5eoluF+i1Uu20qa3++T5LUItNKdlEaV75XuA3tq4ssZ2dXSU3duJ+2QyVqWiJ
 dLewfYzmgx8gXlRt75Oo/7KelMGA7yTK5AR9VAZ44EiFOaLoicH6UwSKubwXr7M=
X-Received: by 2002:a05:6000:18a9:b0:391:bc8:564a with SMTP id
 ffacd0b85a97d-3913af2dcb5mr5699531f8f.22.1741594797269; 
 Mon, 10 Mar 2025 01:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJQwUb1052QL6wDZkevtHZEP40DWReuAaQITFm7+tPcB4MO94B9hab5aIHRUEbMoZhyRFO3g==
X-Received: by 2002:a05:6000:18a9:b0:391:bc8:564a with SMTP id
 ffacd0b85a97d-3913af2dcb5mr5699488f8f.22.1741594796855; 
 Mon, 10 Mar 2025 01:19:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9470e2sm136236215e9.33.2025.03.10.01.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:19:55 -0700 (PDT)
Message-ID: <a7ccab3e-af5b-44d0-a7d0-bfc0e218d532@redhat.com>
Date: Mon, 10 Mar 2025 09:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] hw/vfio: Compile some common objects once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-4-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:08 AM, Philippe Mathieu-Daudé wrote:
> Some files don't rely on any target-specific knowledge
> and can be compiled once:
>
>  - helpers.c
>  - container-base.c
>  - migration.c (removing unnecessary "exec/ram_addr.h")
>  - migration-multifd.c
>  - cpr.c
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/migration.c |  1 -
>  hw/vfio/meson.build | 13 ++++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 416643ddd69..fbff46cfc35 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -27,7 +27,6 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-vfio.h"
>  #include "exec/ramlist.h"
> -#include "exec/ram_addr.h"
>  #include "pci.h"
>  #include "trace.h"
>  #include "hw/hw.h"
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 260d65febd6..8e376cfcbf8 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -1,12 +1,7 @@
>  vfio_ss = ss.source_set()
>  vfio_ss.add(files(
> -  'helpers.c',
>    'common.c',
> -  'container-base.c',
>    'container.c',
> -  'migration.c',
> -  'migration-multifd.c',
> -  'cpr.c',
>  ))
>  vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>  vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
> @@ -25,3 +20,11 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>  vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>  
>  specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> +
> +system_ss.add(when: 'CONFIG_VFIO', if_true: files(
> +  'helpers.c',
> +  'container-base.c',
> +  'migration.c',
> +  'migration-multifd.c',
> +  'cpr.c',
> +))


