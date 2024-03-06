Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D3FC54E55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgXH-00028k-O0; Tue, 05 Mar 2024 20:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhgXG-00028X-4a
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 20:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhgXB-0002mC-Fq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 20:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709690247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQdGQl20jZC2CZgCCzn3ATSQ140fF/bNQwe8oYfTI90=;
 b=dGvcvO+tGUgvY6oallVLP15uSRblLNcCnyLNNdLnIrW+rASkGikFjx2nNaoEUPdW1mfS/W
 J5QHeXojJuIdj5e1X3uhGxbRfmGCZ38NTzGBX8Z4D2X+Y86ey5sEeIs3RnoI36EG9hU3uE
 8RqrxP6J6jzOnokQyHyKKZ/9BqoiP24=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-5iYIM5YkPE-NI4Png1tgdw-1; Tue, 05 Mar 2024 20:57:25 -0500
X-MC-Unique: 5iYIM5YkPE-NI4Png1tgdw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so1660805a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 17:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709690245; x=1710295045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQdGQl20jZC2CZgCCzn3ATSQ140fF/bNQwe8oYfTI90=;
 b=naXg1HAF8LFW5FAovbx9XeyKUV+RmwyQnTiw1tqLCXH64bsSYCEtO63qV77GZw4Vas
 AKgIyQ5GfJiuM72W/vsSZBL0V3Nj4U6j/v3k2kZIiQK0tFIou6p79kZP16PLNZGG9002
 D65Bw9A/l4qYTDKcxdDcu3yC0jPYH4b+aUaljTHK3/ueitNOZWkiI2tHOh/ieDCipoK1
 7P4/rjtqZ1pxHVxLxFyJkvh41TYKGvf/SxDeV09hKJ1U6ck43BMvdUhwUOdZpwGsbCXJ
 h2cuHhuzEEwokYy1W29Kg1pGAEbfaSPxdc5XJ1fAOv9V2VXw0Oqf4KxdyWQzR2qLtEBy
 F14A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9l4YYRWsuVgZipX1HDjmMwVUrsA4E8qOZOCJnd4orhtPAr0vb+buNUA9k8/aI3HvPC33k3DLurqqJhnUb7pXTbNIYeOI=
X-Gm-Message-State: AOJu0YyF3QQ6N/PAec1Suf34+GaEMiqYpEfIzvdFKsni3OPcppMXtxXF
 +shFg2LRKwV5HdKrQ+JGQ5mThVtFfmYmXjcXTMZy2isWeEurbMxcuM+zf20DiwWjRLd2ou5Qin9
 hbmT0oUkQWybjYXvW5lyvKhMQuWnid9ILdZRHD9Q8GwxVkFjyB+3v
X-Received: by 2002:a05:6a00:14cf:b0:6e4:8dda:691 with SMTP id
 w15-20020a056a0014cf00b006e48dda0691mr2536677pfu.3.1709690244636; 
 Tue, 05 Mar 2024 17:57:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaVOzxlUhRGkU/TM7joblhRyu3ZTiJiUp4aEcjlGx9ATdzZ6lMkPsercG8lSpBULIH7b36fw==
X-Received: by 2002:a05:6a00:14cf:b0:6e4:8dda:691 with SMTP id
 w15-20020a056a0014cf00b006e48dda0691mr2536663pfu.3.1709690244255; 
 Tue, 05 Mar 2024 17:57:24 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fx14-20020a056a00820e00b006e632056c40sm2697917pfb.0.2024.03.05.17.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 17:57:23 -0800 (PST)
Date: Wed, 6 Mar 2024 09:57:16 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, jsnow@redhat.com, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 0/4] machine development tool
Message-ID: <ZefNfJ3BwudA-M7t@x1n>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
 <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
 <874jdkn3he.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jdkn3he.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 05, 2024 at 03:43:41PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Mon, 4 Mar 2024 at 13:52, Maksim Davydov <davydov-max@yandex-team.ru> wrote:
> >>
> >> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
> >>
> >>   Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-04
> >>
> >> for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
> >>
> >>   scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
> >>
> >> ----------------------------------------------------------------
> >> Please note. This is the first pull request from me.
> >> My public GPG key is available here
> >> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
> >>
> >> ----------------------------------------------------------------
> >> scripts: add a new script for machine development
> >>
> >> ----------------------------------------------------------------
> >
> > Hi; I would prefer this to go through some existing submaintainer
> > tree if possible, please.
> 
> Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.

Yeah this seems like migration relevant.. however now I'm slightly confused
on when this script should be useful.

According to:

https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/

        This script runs QEMU to obtain compat_props of machines and
        default values of different types of drivers to produce comparison
        table. This table can be used to compare machine types to choose
        the most suitable machine or compare binaries to be sure that
        migration to the newer version will save all device
        properties. Also the json or csv format of this table can be used
        to check does a new machine affect the previous ones by comparing
        tables with and without the new machine.

In regards to "choose the most suitable machine": why do you need to choose
a machine?

If it's pretty standalone setup, shouldn't we always try to use the latest
machine type if possible (as normally compat props are only used to keep
compatible with old machine types, and the default should always be
preferred). If it's a cluster setup, IMHO it should depend on the oldest
QEMU version that plans to be supported.  I don't see how such comparison
helps yet in either of the cases..

In regards to "compare binaries to be sure that migration to the newer
version will save all device properties": do we even support migrating
_between_ machine types??

Sololy relying on compat properties to detect device compatibility is also
not reliable.  For example, see VMStateField.field_exists() or similarly,
VMStateDescription.needed(), which are hooks that device can provide to
dynamically decide what device state to be saved/loaded.  Such things are
not reflected in compat properties, so even if compat properties of all
devices are the same between two machine types, it may not mean that the
migration stream will always be compatible.

Thanks,

-- 
Peter Xu


