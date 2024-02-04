Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E74C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 12:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWbIx-0000ZM-9N; Sun, 04 Feb 2024 07:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rWbIv-0000YT-Hj
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 07:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rWbIu-0000iF-1D
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 07:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707048533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZgd+FvMhHlMzWX6cc7WX9EVkdTvVxtVmI0BKMthI2o=;
 b=cuDmA2tKC9w8SijdgKzHuVrF65A5doPjp9rA4NTKSqDkiBkgrenKmPQAb//FReE+q+y4Kh
 I+GQnVFXA74HcNlimXV4cqkq5Jr3chuzFll8wLkvnXtZk9zvZJP01ZcgbWXTtVo3OSymYV
 YIiTHNIgh0MKjbpM+9FfwHJoLmrohyM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-jkFpyE6CNdKUbSArUWJ58Q-1; Sun, 04 Feb 2024 07:08:52 -0500
X-MC-Unique: jkFpyE6CNdKUbSArUWJ58Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a357c92f241so207877466b.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 04:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707048531; x=1707653331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZgd+FvMhHlMzWX6cc7WX9EVkdTvVxtVmI0BKMthI2o=;
 b=sIz8tU/ish+mIC3r8JGArXEXdE/8JeCzaoQuiTAdQFTvcCTzp/Tk8iJFr4WC4UPKyK
 +nptbjrxsg8ja+pqJIxwtTKX1wtPgMM9K9+rHZi8xkDhXTQZkg9Sgw9eK8PXxB8ujsjP
 Cc1kD+GPFHb88i3PKGocNfMIn6PmYGTlEIHCAzPXenfp6eRo7zjhhbtQbNBf+OmO4O6a
 0uHrQZFjIYc6I9+CiyArJAhDUEmXvKwJzNjspLdBGka2Gf5FO+PoWXqLckT7CmZmYR/Z
 7xKYhuhO3toQEWwnvC668EIMVvYfnI50Xexq7p4Gv5SNI0BxbaMxwbqgnwN1l5PUTVIS
 gnWQ==
X-Gm-Message-State: AOJu0YyeYPwRafoq3bJ/4ub6MSq3M60DltBS4Gn3nh/rGEJsD7FxnKeV
 n6Pvv0zC2xOqnQOidpLcGnei1vGa2JdJCqmOcfpswmr8n3K/EUcNDO399Dr2NBhlGHxJI1YTeA6
 ydptzICXGHSWV/Ltq3YhzGEEHxeBcVfLa5MVePAtNl1xyI+Jq1F4N
X-Received: by 2002:a17:907:78c9:b0:a37:97f1:d70f with SMTP id
 kv9-20020a17090778c900b00a3797f1d70fmr681716ejc.19.1707048531041; 
 Sun, 04 Feb 2024 04:08:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+ZIpGoloay66k3Snh53LdJxjtvKo79iqZGwNESAsAM9s5WQylCK01MUtTx/JO3NEFqAN9NQ==
X-Received: by 2002:a17:907:78c9:b0:a37:97f1:d70f with SMTP id
 kv9-20020a17090778c900b00a3797f1d70fmr681697ejc.19.1707048530747; 
 Sun, 04 Feb 2024 04:08:50 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUH7szXyxWSIXr6x9ESaFxk89w/sGnj6mGDTTpJ3E6qfd/x2whtQaeOdn8ItvnsxXyg0oRx4z8HgLbIlv6Jtqn4EXLyGZcGcmOZUn2Zrt8jMqHKYMh96Ifby24OX1d/klIGCTVke3vPGe+NmYA/xYd1tliPWpmCBIFQ8N+ZjnmnQsfz2TyMbkgzMMwTdyRI1UYawYMEA455qvkTXxTjlWfu
Received: from redhat.com ([2.52.129.159]) by smtp.gmail.com with ESMTPSA id
 z9-20020a170906714900b00a36edfb508asm3083139ejj.79.2024.02.04.04.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 04:08:49 -0800 (PST)
Date: Sun, 4 Feb 2024 07:08:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v2 0/2] hw/smbios: Fix option validation
Message-ID: <20240204070829-mutt-send-email-mst@kernel.org>
References: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
 <7ee3278a-3224-41de-81fa-a3667aa491fb@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee3278a-3224-41de-81fa-a3667aa491fb@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.137,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Feb 04, 2024 at 07:57:48AM +0300, Michael Tokarev wrote:
> 29.01.2024 11:03, Akihiko Odaki:
> > This fixes qemu_smbios_type8_opts and qemu_smbios_type11_opts to have
> > list terminators and elements for the type option.
> 
> > Akihiko Odaki (2):
> >        hw/smbios: Fix OEM strings table option validation
> >        hw/smbios: Fix port connector option validation
> > 
> >   hw/smbios/smbios.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> 
> Should I pick this up via the trivial-patches tree perhaps?
> The changes are trivial enough.  Picking up there, unless there's
> a pull request pending for smbios area.
> 
> Thanks,

Fine, sure

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> /mjt


