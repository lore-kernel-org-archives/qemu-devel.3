Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67D1C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 03:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccs0-0000nS-83; Tue, 20 Feb 2024 22:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rccrx-0000mg-18
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:02:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rccrv-0007cQ-Eg
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708484516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mswJtolUs4GxvGaVsUXK0tnhhTQZDZhhYRu+I/P74+g=;
 b=GM8UYd2qSnnfuoV745NmxboESE30p2Gsf7AK5FvkKcL2f5/OcGR2E9lCowW+T0+SVWABwv
 8j3PMAk1+HFHqa7PNzctndHxRKSmbQMyqWt9fTfotVj9cM0Xy6oqSycVvk+AGbLIUa8lQq
 qngFnNHbjJ60GBVpBQ2+FrY39DydLF8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-uYiSpQ3jPA2h5S_gdGy8kw-1; Tue, 20 Feb 2024 22:01:54 -0500
X-MC-Unique: uYiSpQ3jPA2h5S_gdGy8kw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so52707a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 19:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708484513; x=1709089313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mswJtolUs4GxvGaVsUXK0tnhhTQZDZhhYRu+I/P74+g=;
 b=afsD2mWa5RME8tPlk1g0FLPZjKYK6GQa5yd5B0TSWlqgLj9thj9diL0vTJweyL/psc
 pVMueHomu2eSj0fZUnhIlqHluRd3JWU4zqWy4cIvMfl66zqXgX7XfdFbNZQTx1O9YRVM
 YtK9MUDnn0oni+fhB2vqIM91NK7RXG+Tfz6uolY4ltj0ivP1UDjHu91LyUUHktJdkrsK
 ihZpOsTIQtW3mQo/d98/j2K61/LZG5f5Vwz3JWCFR2B40nGKyNf238/y2GGhyKw7GiPN
 X7uPIwihDCGDir4mlJZeum9xZEOETqEZa/HF3DEq5D/CWqLiQFUCIUcEDoVkSgaLdT29
 BsEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfMSJbwzOl/l0K5Xwc9/wbBgC3HmzVnfPhe7q/uaX7a4q5opwroOzmsp0mYkpcTS3bxUjCv1VCJiAnLptlAaV/nEzJbXo=
X-Gm-Message-State: AOJu0YwfMNlZv35/00SbZs1ERXEsEBSI65o23eMcTjEsiwlPeIT5XH1c
 iHYhpyquYC1uMIzBNK1GCOqGnTodj6iPFM2cqSI1WgBwXsRrXtqRw8vIUW5D4UMnO2KAshx3NM3
 PUGnLpdJj7mRYtv6Zic76Ls9K2hmKbpcOaIiPeC6fT+tzauXpa2pJ
X-Received: by 2002:a17:90a:6d24:b0:299:dddb:3a92 with SMTP id
 z33-20020a17090a6d2400b00299dddb3a92mr3361001pjj.1.1708484513708; 
 Tue, 20 Feb 2024 19:01:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTYK1+rAvlYUOcMYYS/1I/TMNotohT8TQaGmTfB3wQ7HQZoqdwUyqoS4Qe4K9ptd3lp6Woqg==
X-Received: by 2002:a17:90a:6d24:b0:299:dddb:3a92 with SMTP id
 z33-20020a17090a6d2400b00299dddb3a92mr3360984pjj.1.1708484513368; 
 Tue, 20 Feb 2024 19:01:53 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sj2-20020a17090b2d8200b002998d713b5fsm439300pjb.40.2024.02.20.19.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 19:01:53 -0800 (PST)
Date: Wed, 21 Feb 2024 11:01:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] tests: Add migration test for loongarch64
Message-ID: <ZdVnmiT94SciVNBn@x1n>
References: <20240220124126.1164081-1-maobibo@loongson.cn>
 <20240220124126.1164081-6-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220124126.1164081-6-maobibo@loongson.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 08:41:26PM +0800, Bibo Mao wrote:
> @@ -823,6 +827,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>          start_address = ARM_TEST_MEM_START;
>          end_address = ARM_TEST_MEM_END;
> +    } else if (strcmp(arch, "loongarch64") == 0) {
> +        memory_size = "256M";
> +        machine_alias = "virt";
> +        arch_opts = g_strdup_printf("-cpu max -bios %s", bootpath);
> +        start_address = LOONGARCH_TEST_MEM_START;
> +        end_address = LOONGARCH_TEST_MEM_END;
>      } else {
>          g_assert_not_reached();
>      }

Acked-by: Peter Xu <peterx@redhat.com>

One thing to mention is that Fabiano recently added a compatibility test
for old qemu binaries, in which we would prefer any tests in
migration-test.c to use stable qemu cmdline ABI (IOW, avoid using
"max"/"virt" if any of them can change its abi in newer QEMU binaries).

It's not a problem for now, but only a problem if loongarch also wants to
enable it some day.  More of a heads-up.  Feel free to see
migration-compat-x86_64 in .gitlab-ci.d/buildtest.yml for more info;
currently it's only enabled on x86_64.  Comment above
migration-compat-aarch64 explains what's missing for arm, which is similar.

Thanks,

-- 
Peter Xu


