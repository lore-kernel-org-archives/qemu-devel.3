Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56275C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 00:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGMP-00071n-P4; Tue, 25 Jun 2024 20:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMGME-0006zk-L4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:17:54 -0400
Received: from [170.10.129.124] (helo=us-smtp-delivery-124.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMGLW-0002aa-6G
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719360962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rev1NjoEJJXHEvGvl9T4+up+8BzB/9mnBukmn7puj68=;
 b=O3DxiguiUflty8SmSzYqRCem7klXR8VGixVGZxaMuL1qYrTnaZHkxY1Le0THm26VOHevYV
 VoK9j8UIp5IE57yOfG5NscPgQOYJjOe4eSlTjopmPSKuFPyqAMh/EJpXZKVyzqQ5WOp+h6
 BLFv82MRpSL9Agu4ZSMT91UWV55scUE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ryrsLSeGMLu2vYXZo0riUA-1; Tue, 25 Jun 2024 15:04:01 -0400
X-MC-Unique: ryrsLSeGMLu2vYXZo0riUA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-25cbd68532fso1360085fac.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 12:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719342241; x=1719947041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rev1NjoEJJXHEvGvl9T4+up+8BzB/9mnBukmn7puj68=;
 b=Se2fPi24aTIXvcKXN1Cgc486CsVjYcneBEqBsEyIVimpymGrIJ0MoKKqsuiJnsRICd
 sD3/RAkfuOFLWUdrnXFVCV1GDnWv9LAJpsIyNM7jaA/iOkgMcO0H0/DQ04nU08g9gKHK
 Jk8YqPm/Gk+GatsjYMKABoOoOiYGp0HS5J4siavyFg+uBZhtcwgHR6/Vg0HH1V1IKvVB
 c1Xr44IuhEEgmc0U02WiS7e+FVNZfJIjNP/suhgK5WPvvXCh7Y3CWMAeCXFQgEI/510f
 Uh3vyDacQQZCDcjj03xRFUDi4i2PxgJlXwvoG2LhagejnesRSjV/0Flos0gCeyfv1zI5
 gd/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9opCy0CrNcjBWHxNKif6bSyla8e1hi22kweyZmOVbCDcha7A2pY1ulnEt7OB3JGQa8b8KmN2UXrMBQx+O3GV6zyRhx6o=
X-Gm-Message-State: AOJu0YzdsxOXn5UhRPjBlv+aytzcwlRMipvXDZh/FeiP0k53Ko99McIV
 il19mskTmTnZzT+Yf50KRmljEFaCIPxv1BwkwnsqnKsUzWyTKkeFphGWsugwNrkeIs8riLKVgMA
 150yPVhABNOHwqmHdBY5vz+3HUlCAd4kqn4HwiJnQzL+KF0x88sUJ
X-Received: by 2002:a05:6359:4ca7:b0:1a4:6af9:2324 with SMTP id
 e5c5f4694b2df-1a46af924f6mr312590955d.2.1719342240358; 
 Tue, 25 Jun 2024 12:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTL3A6+Z1MaB4cUIxDP5N4aVTuunyC704WX59VuPg31dtbHVz3vtMWs0zRqLafghXrxxK3BQ==
X-Received: by 2002:a05:6359:4ca7:b0:1a4:6af9:2324 with SMTP id
 e5c5f4694b2df-1a46af924f6mr312585955d.2.1719342239788; 
 Tue, 25 Jun 2024 12:03:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b534b6fb20sm33456826d6.58.2024.06.25.12.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 12:03:59 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:03:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZnsUnKZHtsMKQc_2@x1n>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
 <ZnrZ9W6WpvmDBpgv@x1n>
 <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 170.10.129.124 (deferred)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 05:31:19PM +0100, Joao Martins wrote:
> The device-state multifd scaling is a take on improving switchover phase,
> and we will keep improving it whenever we find things... but the

That'll be helpful, thanks.  Just a quick note that "reducing downtime" is
a separate issue comparing to "make downtime_limit accurate".

> switchover itself can't be 'precomputed' into a downtime number equation
> ahead of time to encompass all possible latencies/costs. Part of the
> reason that at least we couldn't think of a way besides this proposal
> here, which at the core it's meant to bounds check switchover. Even
> without taking into account VFs/HW[0], it is simply not considered how
> long it might take and giving some sort of downtime buffer coupled with
> enforcement that can be enforced helps not violating migration SLAs.

I agree such enforcement alone can be useful in general to be able to
fallback.  Said that, I think it would definitely be nice to attach more
information on the downtime analysis when reposting this series, if there
is any.

For example, irrelevant of whether QEMU can do proper predictions at all,
there can be data / results to show what is the major parts that are
missing besides the current calculations, aka an expectation on when the
fallback can trigger, and some justification on why they can't be
predicted.

IMHO the enforcement won't make much sense if it keeps triggering, in that
case people will simply not use it as it stops migrations from happening.
Ultimately the work will still be needed to make downtime_limit accurate.
The fallback should only be an last fence to guard the promise which should
be the "corner cases".

-- 
Peter Xu


