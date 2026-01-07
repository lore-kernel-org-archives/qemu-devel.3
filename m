Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FEBD0D145
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdX0v-00087u-6h; Wed, 07 Jan 2026 12:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdX0b-000805-J2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdX0Y-0003Zb-GB
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767805660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkazvGp4RwSTP+Ovfg+0fjTnH18m2GQBcduP2dTrjCk=;
 b=ckHnQBR8252ulExxMXhdvHqii8Zw1/DrFwKeCPOt5Yp1N6fCLNXhYSnR0ECm7tMO2WtXwP
 jjCssVGIEO0ZiXGVAytCK0bTlMiIJl7ozsdcfI4a5/ZeZstngCA7A4EldTsmQcL5v3RrTQ
 eziVS4TkXwM6weuxZWDiqZLk6xwMp/I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6Ds3ViYvNN2drnAOqlaOOg-1; Wed, 07 Jan 2026 12:07:39 -0500
X-MC-Unique: 6Ds3ViYvNN2drnAOqlaOOg-1
X-Mimecast-MFC-AGG-ID: 6Ds3ViYvNN2drnAOqlaOOg_1767805657
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b51db8ebd9so756706985a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767805657; x=1768410457; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XkazvGp4RwSTP+Ovfg+0fjTnH18m2GQBcduP2dTrjCk=;
 b=f3AHC8kehtw9Jwaj1bOfPj+yEOO93FZOAyKL1KdbfHrM+OW2eZh6iYIHRN/Rf+NJNP
 BigFa7/IacC72jrjgnEnllFxo6+gEzL14Qo/y3k5uBY9/14FdXb2/Fa84yt2G+efJw1H
 u7YThC53ytQlD/ITlcRzpNrM5wa4HO4Gh6CIeWRaOsgv/ccH+6KBtvJDxbNO0Z54QmD5
 rDNstk0t60negvFgFWSTum5P+S7V7DxzJRU6FWm3avYsQSQkVJKyyBkfjSQRy139iHOj
 dGHJSCKfUXDFv2YP1ZjcwUDeNzFIF8mp8gLumgl01swfJrwTpEt5gpnNuQdBLW1cFsG2
 YO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767805657; x=1768410457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkazvGp4RwSTP+Ovfg+0fjTnH18m2GQBcduP2dTrjCk=;
 b=h+v2stODASjBmYVSlOtMWTenMPJonwfgZQzrqcM0XTuABTZ318wPUlKHt24+Pyf27N
 tesS+J92nxtj7AM7no6SXWEM+pRwK2v2C5G4sV/CeL9vsKrrEzVawpcF/S1LEalNGrV9
 WvGuZcFdpIsXu34mUDq7PYQoDf6iRJulkiFJBC6K85Qy9QG3RnI7HovqAp/ai0MC5sUq
 74Cd91KaR9E4gv6v/zHgkTYcxRzNn7n6vVAeq43hkeNoX+LO8n/9Ts6U/Xi+mEudLdLo
 b8gQpX7GD1LGRHMobW7qkJw2TSsCmyWtNn+pv2Z2jVNDqtQOBHBOFnzmn+P9QWUmOwwi
 liPQ==
X-Gm-Message-State: AOJu0YxA1yLAbjPIY9inkSGzA56itjqNnlVm36Ww0jYYQ51FiIMD1d1E
 Tq5z8JgmJmzYv3tS0z3dt24PnuWRMPy/4niUa1elfa3rS1IRvyN91hFwpj2HAHFGumQGKt2hVn6
 OEhOV+wv3Wu2lZZKhcK3EdXubIzC4wQm2eKpU0w/8+Tw64DK9n0MUEbeQ
X-Gm-Gg: AY/fxX4U/LZO+VNwyNTvKL71KdT5N4RWXWd5eY81GIXX9eqpOacP41RGiaBdwkR91jS
 mp/dC06UKsB1wcs1iR4sqYCRJ40sK6RWDLpwUrUwI9Dt2jVonRNPEZr1XhcGB7VuAsmuZWKNB1u
 DRYOtPLBZm2M9xNhNdc4ECzb2Q/l/t+lHzsesrm1r3P/umDDYihMPNHICn9jJqgeIS+fD9AxclD
 AAUwAKWtAQ61RG6x0rKJvnoJY7CkUvkhesV3/gJYKTrIWLRjf3TrdcUx+5QBbT1ax8NnCWEW9yh
 YK3CRtPGgmrL9ur1ziZzF0jKR3KzPzmihWHtja8qGgycSsSxNHOkBtf5bWFJziXl87v609k4rXL
 BHTc=
X-Received: by 2002:ae9:e713:0:b0:8c3:7e05:daf2 with SMTP id
 af79cd13be357-8c389379dc0mr342485785a.15.1767805657228; 
 Wed, 07 Jan 2026 09:07:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4B32Asoy3K8bqHJKCGkSu35Hvb5/Vne66OUUYgAuwy6UCgSdLOqsjanBN+RskTyz+3q7Ozw==
X-Received: by 2002:ae9:e713:0:b0:8c3:7e05:daf2 with SMTP id
 af79cd13be357-8c389379dc0mr342480185a.15.1767805656609; 
 Wed, 07 Jan 2026 09:07:36 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f53129fsm409546385a.44.2026.01.07.09.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 09:07:36 -0800 (PST)
Date: Wed, 7 Jan 2026 12:07:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aV6S17Byi4qSrN6x@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <aUqyfkOtXwl6cy9A@x1.local>
 <CAE8KmOwnPYoK0i53LB8nO95gC53QK4FoNvMrbb9anR3OB+RS4Q@mail.gmail.com>
 <aV0o-EYEC-4rvdSz@x1.local>
 <CAE8KmOyh+vku1bnbHfmmek9Uru7AaF-mc0q34807SE+_r5QT3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyh+vku1bnbHfmmek9Uru7AaF-mc0q34807SE+_r5QT3w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Jan 07, 2026 at 04:31:54PM +0530, Prasad Pandit wrote:
> On Tue, 6 Jan 2026 at 20:53, Peter Xu <peterx@redhat.com> wrote:
> > Yes, something like this would be more than welcomed, thanks.  You can
> > provide a simplified version in the commit log when repost.
> 
> * Okay.
> 
> > Note that I'm not reading carefully into each of them, because we have
> > concurrent changes from Fabiano recently, essentially it'll change when
> > migration_cleanup() will be used in above examples:
> >
> > https://lore.kernel.org/r/20260105190644.14072-12-farosas@suse.de
> >
> > So we'll need to be careful landing these two changes.
> > Considering that the other series was close to landing, IMHO it might be
> > good idea to have your patch (when reposted) based on that series.  Please
> > have a look.
> 
> * Yes, I see it is changing the same code areas. I'll wait for
> Fabiano's series to merge upstream. Will it happen this week? @Fabiano
> Rosas?

IMHO you can work on top of that series directly, then when you repost you
can add "Based-on:" mentioning that series.

> 
> > I still think FAILING isn't such a huge change so it needs to be split into
> > multiple patches.  It's a new status and we need to review every spot of
> > FAILED status change, in which case one patch is very well self contained.
> >
> > Even in a backport I think we should backport all relevant changes about
> > FAILING when necessary.  We should not backport part of it, causing FAILING
> > status to behave different over different paths.
> 
> * Adding a new interim state to the .json file is not going to break
> anything. But other places where we start using it via a bulk change
> might break things we don't know. So far we've only tested it in a
> live migration use case. We have not run snapshots
> (bg_migration_iteration()) OR the same host migration use case.
> Hopefully it might work fine there, without any breakages.

Having a new status introduced only partially to the subsystem in separate
patch and especially only backporting that partial patch sounds more risky
and wrong.  Let's try our best to make sure it won't break anything but
implement the status properly altogether.

Thanks,

-- 
Peter Xu


