Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A06BC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEql5-00014l-BI; Wed, 05 Jun 2024 09:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEql3-00014S-Ts
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEql2-0002pW-F3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717594370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlrAvSq5wEQmBCOYWHoVH7xlYqLznSMZQ11ErQXBpWE=;
 b=Pt20EuSzBfsCEnux0uFn5PbwekcN5YG17v/sS4uKsszOhxkv6+DhYUINjqiPR9SrIv2HYZ
 yOtG1WyDRcT28yoCdMT9mJv4n6bVv4GDkIfao/25KYSkFBiTFVMPhQYTd4AWGQv9WUrF0V
 Qoek26FN3ADKuvWy3y0rxuEE8XzZHAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-V7ApRu-1MbS4cL3PDWRz1g-1; Wed, 05 Jun 2024 09:32:49 -0400
X-MC-Unique: V7ApRu-1MbS4cL3PDWRz1g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4215604d4a2so7358375e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594366; x=1718199166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlrAvSq5wEQmBCOYWHoVH7xlYqLznSMZQ11ErQXBpWE=;
 b=YC/cCjK1mWcROnuTfPnMJEmuy/GvOXBpzzcPfYeBH8FdBgbD8OKn8qkTmzdaR/dE63
 s6jx+WWfLzbMdWrhu8xbKiPsWxEFkf3ioS0xjuAxJk2YlqLEzzlLd4hZnKU1iL4Zh8oZ
 URd+yltv7pcufEkmpguXqYy4a2M01/Nac6G+Z4XY+mt6BORPWv3KSdrkKnFbKuSLhlSG
 AdKtDIYMHOjPSnyAC3tT4O00Mn7fPsaFGOrGuC0HXoqXhzt38M+qop8RoVLrpCxd0mQ1
 cc2acXnv3OKdJ8n1kXaEJFgbsWaan9loI3sugXCDf5zB9UcUUcWhub10w0IPgqHlUPkJ
 Iipw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfr7nwAHt39xSqkwgv6YFub0lWC825I3ihXn0vygti5h8Bsu4GDsFCLNfbpfKmPUZjYi52Hzk2TbuHUhM7ZHvcYtNEDfg=
X-Gm-Message-State: AOJu0Yy9rNDgbiA2CM4q7GKnTEUsQrXzzkdaG0vISpCc/B6ByP345/ME
 /bnIaVkTlvqdGNW5NxSCjaiTcGzEbN9FEXxAO59PFBLz57NM2UQkfR9WwqzRVQvY1GQ1aZImjBE
 5nMrWHI4y/ISfrn7/1Rav/H+Jpkre+gk7xkXLFFkxmCd6ZwsFJVAs
X-Received: by 2002:a05:600c:4986:b0:421:5554:744c with SMTP id
 5b1f17b1804b1-421562cf1dbmr21506375e9.11.1717594365968; 
 Wed, 05 Jun 2024 06:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQEN2XG7hncHNsIUxlGLEAIjqlgG3PpI5/D2HxIimnbGHxv/ml60wqHPoNp8FitXOGvvabxQ==
X-Received: by 2002:a05:600c:4986:b0:421:5554:744c with SMTP id
 5b1f17b1804b1-421562cf1dbmr21506145e9.11.1717594365626; 
 Wed, 05 Jun 2024 06:32:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158135b44sm21464865e9.34.2024.06.05.06.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 06:32:45 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:32:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
Message-ID: <20240605153244.4102f7e8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240604062133.40637-1-anisinha@redhat.com>
References: <20240604062133.40637-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue,  4 Jun 2024 11:51:33 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> 'pentium' cpu is old and obsolete and should be avoided for running tests if
> its not strictly needed. Use 'max' cpu instead for generic non-cpu specific
> numa test.
> 
> CC: thuth@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/numa-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
> index 7aa262dbb9..f01f19592d 100644
> --- a/tests/qtest/numa-test.c
> +++ b/tests/qtest/numa-test.c
> @@ -125,7 +125,8 @@ static void pc_numa_cpu(const void *data)
>      QTestState *qts;
>      g_autofree char *cli = NULL;
>  
> -    cli = make_cli(data, "-cpu pentium -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
> +    cli = make_cli(data,
> +        "-cpu max -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
>          "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
>          "-numa cpu,node-id=1,socket-id=0 "
>          "-numa cpu,node-id=0,socket-id=1,core-id=0 "


