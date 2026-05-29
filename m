Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB83FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy6h-0002V9-Mz; Fri, 29 May 2026 10:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSy6f-0002Ua-5q
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSy6c-0000oS-9c
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780064553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rWzrd7atfqwUk+GQoUQOhVZR+SyVxjV88icPptPsHoo=;
 b=bPuqfjzO8UNG5q/cIdQl/n28cF3x6QqGUGDn1IgNReBd/fcP7VNNQPV6cKwQid+A+qSX6O
 HPP/abqHBoAsDWb/e01sJ1M8LLnJ9JqbodGHoe3JSk8kE6E14zQ72BXr0UuC0lg+cdNvqL
 48zzxhD7BLYMDGghWadB4lqmb5S1B8Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-8MJUg3xbPpq_ybt8stsnkw-1; Fri, 29 May 2026 10:22:30 -0400
X-MC-Unique: 8MJUg3xbPpq_ybt8stsnkw-1
X-Mimecast-MFC-AGG-ID: 8MJUg3xbPpq_ybt8stsnkw_1780064550
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516d09e77e6so166929781cf.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780064550; x=1780669350; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rWzrd7atfqwUk+GQoUQOhVZR+SyVxjV88icPptPsHoo=;
 b=NNTpzPzO1RzvhvTsrdtzQXzpi0uWX7wnGVuTuHB0WgnqVmN/Fge5dtOeK/gZ3Ld1dH
 ALBgkFnkfjARD4tYBi9NyXEq0ms+bOFSCulKEv5gA6INyrn1NdigoASy+2ETdqyRdcS/
 dR4bYyCmjiQr32Me/fKnGJyA4F7nF+PuJyZCDdrpAyJzWfy21b4WY2OuK0K6LVekIIlW
 GfMamhkGP/9jeTgUAJ15dWBpZKQhGpYZwT/R6svqL8Qizq5fNR8MwiFrpaJ480oVXVnk
 fEC08sNhSsRBmTajtGacv4+eJqvBtb7vLGJ422uziI6OCjykwsyNoWjVx/1wKbuYoO+X
 4FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064550; x=1780669350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWzrd7atfqwUk+GQoUQOhVZR+SyVxjV88icPptPsHoo=;
 b=pvwcZ4AgsTyCAN67d9g35ZYjRIxhNaZNpEn0f1fNE4u+KAMDI/vcPeQmioDcmp8GMq
 XIn9uZL7tUUF+MnVtxCR6/QiT8lRlR/aA6EvaObFLrA4EGp5ceR3TODnBbjJw/O23OE/
 IL245ydOYmIncBlujeScYCCdchKzCLW2aByDfrsZuiZfZ9PXaaDWly3sHSS8tVlf/qCN
 z8EZRlnoG+4JXxO5Va9IG8HDEiXBY1xCdn5wjNJLRj9ZjuMySonhafT0gnW88rK2jxQz
 iFJtdFkzk1f21w2wQ7xWxPLavT1kLmXfJAXBXZFzLwxFgkIECtAz639iGZXymwIQD1xz
 9oAA==
X-Gm-Message-State: AOJu0YxDyvCjJJ+lsKs0chmjDnGs6d6XnXnauvhjEby+P3nofeajiiCc
 O1jzxM9rDEEM4If3yxVrqq9Nvjl43vFmNKYxPQbrei3/HCQJFqXFSnuDbtiL/EuXi4IcnsIWde9
 AAJ52428aGrfMzXcgO0g2ZaDSjEVgnVEtjRWsOeJJPP7aarnGeuOCy9FT
X-Gm-Gg: Acq92OHqzFf7R+Vs/2f+jP+QxR5bS7rfSXd3mbeiX1g8e3oVXIvcnCv+lbn8KRB5olq
 NyGruHxk0YMcwMgKr+j0J9reqSZMXxHHTSbSBaOTFkDjsqlHQO5KN1t3TXrsefiC9/iYlH/rdYb
 3rKiTlhIvOuxp71pKnUpezUsTcc3AOeb1n5h++TlteVNFdqNCRtXo2PEKl6eJRvdf4+b4fa1hvC
 kg9hFbzufHLXiHHxthZ/CZwmX9wotdKomjM4RGwpDUIk+Ujj1HO4Ay7wXdZFme9Ep6BnpL4BAFr
 4VY4Z16CXRmvSp2wSSttm0+DdZho42BsbFsT998eJ3OLatDlJeqHsyD7w46DdXknql7LuO5GMZF
 ZUdLzeNSJcMm/5swmSdSefS/j7UqgCNimHc7gb8hDCdcj65xfiMT2jGAqjg==
X-Received: by 2002:ac8:7e93:0:b0:516:d657:2c65 with SMTP id
 d75a77b69052e-5172dc23931mr41506071cf.6.1780064549971; 
 Fri, 29 May 2026 07:22:29 -0700 (PDT)
X-Received: by 2002:ac8:7e93:0:b0:516:d657:2c65 with SMTP id
 d75a77b69052e-5172dc23931mr41505121cf.6.1780064548804; 
 Fri, 29 May 2026 07:22:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5172ebb5e2asm21838031cf.27.2026.05.29.07.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:22:28 -0700 (PDT)
Date: Fri, 29 May 2026 10:22:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
Message-ID: <ahmhI-cukV3R-Eyq@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
 <4f0f12ec-504e-45c6-b53f-e7567bb46b34@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f0f12ec-504e-45c6-b53f-e7567bb46b34@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 29, 2026 at 10:19:22AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 29.05.26 00:29, Peter Xu wrote:
> > QEMU doesn't yet have a good way to specify migration parameters so that
> > they can be available even during early stage of QEMU boots.  It is because
> > the migration object (who owns the migration parameters) will only be
> > created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
> > reading migration parameters is illegal.
> > 
> > However, QEMU does have special use cases for such, namely only-migratable
> > flag, and cpr-transfer. Recently, we have one more possible user to read a
> > to-be-introduced new migration parameters during backend initialization
> > phase.  We can introduce yet another global variable (or per-device
> > parameter) to bypass this limitation, but we can also seek for a generic
> > solution that we can setup migration parameters very early, even during
> > backend initializations.
> > 
> > See this discussion for more details on the context of the problem:
> > 
> >    https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local
> > 
> > This patch wants to take the latter approach.
> > 
> > As a start, introduce a new way to specify migration parameters in QEMU
> > boot commandline, as proposed in the above discussion:
> > 
> >    -incoming config:key1=value1,key2=value2,...
> 
> Do I understand correctly, that with qobject_input_visitor_new_str(),
> it automatically suuport also json-like syntax
> 
>      -incoming config:'{"key1": "value1", "key2": {some more complex structure}}'
> 
> ?

Yes.

> 
> > 
> > When specified, QEMU will parse a string formatted MigrationParameters and
> > keep it.  When migration object is created, it will apply all the settings
> > as initial value.
> > 
> > Since the application of boot parameters will be after object_new()
> > completes, it means it happens after all machine compat properties or
> > -global settings (which should be done during instance_post_init()).
> 
> [..]
> 
> >       to issuing the migrate\_incoming to allow the migration to begin.
> > +
> > +``-incoming config:key1=value1[,key2=value2,...]``
> > +
> > +    Specify migration parameters in QEMU commandlines, so that these
> > +    parameters will be available even during very early boot of QEMU.
> > +    They will be applied properly after QEMU boots and when the migration
> > +    core is initialized.  From that POV, it has similar effect as setting
> > +    these parameters using QMP command ``migrate-set-parameters`` or HMP
> > +    command ``migrate_set_parameter``.
> > +
> >   ERST
> >   DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
> 
> So, to have a "defer" migration with preset parameter, I need two options
> 
>     -incoming defer -incoming config:key=val
> 
> right?

Yes.

-- 
Peter Xu


