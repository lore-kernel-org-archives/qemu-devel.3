Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227A9C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXbpl-0001fA-QI; Wed, 07 Feb 2024 01:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXbpi-0001eq-M7
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:54:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXbpg-0006sM-G9
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707288895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xg1lj879D3VIhM61yRu3naU6ggdd9zhRW+3NBFpYdww=;
 b=FanpRMRJhT2uyJF5cbs8/A0mYXKM7Ib+JTiQ9wHSbyJFoEy4HI1y1ShIjn7Z44NJk/lZE8
 kOmmVVGO35gsqO9bpImbUUgjFmHdUNZ0dSWkjeP4IlIPOaqkqhkYSs4gS/++l+Fu/0729U
 CzfKi3tZJWa3ZSxrG/Rv04LPwYDJfLM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-DKZjLAaLNTqJanS3h6RqJA-1; Wed, 07 Feb 2024 01:54:53 -0500
X-MC-Unique: DKZjLAaLNTqJanS3h6RqJA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29692c99979so60438a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 22:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707288892; x=1707893692;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xg1lj879D3VIhM61yRu3naU6ggdd9zhRW+3NBFpYdww=;
 b=lbCrVUlA1mQ8+Gn78VEqkYLtXSWan9sMOFAR+rk6FACIthgQRbXLze2KJv+7x1pDVe
 9f3m5hmyderKjMfz0DIUkKCBJvoBFg+EQL0b7PQskdEl4H9gm3JnwJ4H7DHZ7OHdMaW7
 Zz66b0Fiubw6ceV3Rx1yMGd+FQxXhd0p4kQrkHvJ4sKRKPrGcL6BNfgROeKb9AXFC0zc
 zdzPPeqTdgHL47Zc4rTOiCFcMT/x9jGMkzFf+ZFDyjA5nxh0cX1nyiA2yH/F07SY4D2i
 VkW8WK1MZq3aMpJPESz+QI9vSx3aD/p4oosX83XmzJbCdNnqkE3d8hFVxadClmLTIVZi
 VzbA==
X-Gm-Message-State: AOJu0Yy83aHtNmySwYhORZiq8toFxvJToUW5SlEpQhCWZfhaX7o55GC0
 f/YUEzjDOeJQLDpigKvaJ2ugV7bo7mxOtd1vqjHHdMFaSe/E9POtvFlxrBv1qHFYJGM01vzLGM+
 H1gYifO0VTgtzHgTnCICdHDT/T/rAJ6MYyqsFxQ69W4TtaqALJ3h0
X-Received: by 2002:a17:902:e884:b0:1d9:d43e:598a with SMTP id
 w4-20020a170902e88400b001d9d43e598amr5371443plg.5.1707288892722; 
 Tue, 06 Feb 2024 22:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9ZiqxJYHkHX1Ia2B94+EW+UERb1loRTdk/STC84Du5tYNmULOB6EHlaCXSZrklzfYk3QZYw==
X-Received: by 2002:a17:902:e884:b0:1d9:d43e:598a with SMTP id
 w4-20020a170902e88400b001d9d43e598amr5371429plg.5.1707288892413; 
 Tue, 06 Feb 2024 22:54:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ZQs0YC6KpcsvE7NqKm8FZEawVqIfUtWIM5iSic6fyxNS+Ht3I4NFaVwuYsjq3P9AX22vbzH3S+0hbCkfu19bvpkbUDlpzZDnCwLDWxyOA6sPyq0=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 21-20020a170902ee5500b001d752c4f180sm661433plo.94.2024.02.06.22.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 22:54:52 -0800 (PST)
Date: Wed, 7 Feb 2024 14:54:43 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi/migration: Add missing tls-authz documentation
Message-ID: <ZcMpM5BU5F5qcP2v@x1n>
References: <20240207032836.268183-1-peterx@redhat.com>
 <877cjgx0w1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cjgx0w1.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Wed, Feb 07, 2024 at 07:07:58AM +0100, Markus Armbruster wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > As reported in Markus's recent enforcement series on qapi doc [1], we
> > accidentally miss one entry for tls-authz.  Add it.  Then we can drop
> > @MigrateSetParameters from documentation-exceptions safely later.
> >
> > [1] https://lore.kernel.org/r/20240205074709.3613229-1-armbru@redhat.com
> >
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 819708321d..f4c5f59e01 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -980,6 +980,10 @@
> >  #     2.9) Previously (since 2.7), this was reported by omitting
> >  #     tls-hostname instead.
> >  #
> > +# @tls-authz: ID of the 'authz' object subclass that provides access
> > +#     control checking of the TLS x509 certificate distinguished name.
> > +#     (Since 4.0)
> > +#
> >  # @max-bandwidth: to set maximum speed for migration.  maximum speed
> >  #     in bytes per second.  (Since 2.8)
> >  #
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> I propose I queue this right after [1] with the update to pragma.json
> squashed in (appended), and the sentence "Then we can drop ... later"
> dropped.
> 
> Thanks for your help!
> 
> 
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 7ac05ccc26..6929ab776e 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -69,7 +69,6 @@
>          'JSONType',
>          'KeyValueKind',
>          'MemoryDeviceInfoKind',
> -        'MigrateSetParameters',
>          'NetClientDriver',
>          'ObjectType',
>          'PciMemoryRegion',
> 

Yes, please.

Or queue this prior to that series, then below diff can be squashed into
the other patch; either way works.

Thanks Markus!

-- 
Peter Xu


