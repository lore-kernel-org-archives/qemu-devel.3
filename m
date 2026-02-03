Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C5DE7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnLuS-0003oe-Of; Tue, 03 Feb 2026 14:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnLuN-0003oL-05
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnLuJ-0005gu-LB
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770146269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbDM89XJRnU9nvtkKBFgYLjVR3F4b27HtOcs96sk3KI=;
 b=Y93cnKqdE/eH4RQ6a1YxchBnVmvGnAotyI2xMzfbYCjAA2D1cpn5tZqFFvnuxOC32pwUzv
 NqVgwYmhmwMokEEuPy0X8uZTose3OcR6Vn94ivjKOABggsJJuWsv2GKEqFCBLNL7qpKBzX
 0XVTZJsOOVhDEnrmHI3QZAIJ0XNpri0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-j6iwXnNBNsC8oGLbJt92PA-1; Tue, 03 Feb 2026 14:17:48 -0500
X-MC-Unique: j6iwXnNBNsC8oGLbJt92PA-1
X-Mimecast-MFC-AGG-ID: j6iwXnNBNsC8oGLbJt92PA_1770146267
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c6a2ef071dso1781770185a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770146267; x=1770751067; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sbDM89XJRnU9nvtkKBFgYLjVR3F4b27HtOcs96sk3KI=;
 b=SCHWUChgxV8itr0jlExKwsB8zR9RRu2FdEmUu3ZQDJ4gQsE7te6e/+Kzjujhq0jsvh
 nFEhjtgnizJcMlbvlEhjMpgriMupymyfyWHUV/3AGN0aj807BSrT4BqMQterjdtoI7qT
 M91YeDiOa/g/BCw+r/9cTBJM0K6IXOGjk6PDnE56xLNOIwAf89sEfkEe3fxvw8xXwRTM
 qxZMsyArgXaeU6qlUTBbL+IYjoar0hZibIdW9+ZbCsxWWu5X1D4j5gUZYh1o+fvnSh/P
 u9kK+6QatUnsHOoK9yubdO/HtCgdzoJSAUNuzkz7IJhr/4rCWnHXtfExbtihgJyyAsM/
 +++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770146267; x=1770751067;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sbDM89XJRnU9nvtkKBFgYLjVR3F4b27HtOcs96sk3KI=;
 b=nwerEB5mt2XkSetIngf2Xf31etICB5oqwp6IEj8D/7XQWKzEGxM4weL6T4d7E5HpRY
 /VEJuvpF2/uHVccXibrW0ImbmLW1hmV1UGp7y44GtkH68wE7N8pxPeGHo94RGa3JM5B/
 Ys13qXJMzDJNvSPLy4zZR6r7iOWA8c3yAbZZHXeibvBXawaBz0PfJGvZ7CDYZsNQWl21
 g3MrXk2kVZNpx45IQS8BhD3l1INwo6ViBe+4oRRqrTky+VvWg+X7vVpCSf50TXtEi2SN
 QPGsRPOZvucaoO1qXOPTo5PDyQY8QoDYZTyaBmqRK6MKZ/FUiS599iAnX/csn1rksJbI
 HzVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHlufTk0HOFCpKOEdSDIZ3aCIUBV0fBlPLwC4Cvb1eyUaGtT9D9zBpOMmze1kRKPhqjGA4Ar1mDZj0@nongnu.org
X-Gm-Message-State: AOJu0YzI1K5v9grYcQAJa1cOvTMzYGkSlyFCWuo2AuU7VOZv3YvgGRU8
 s8WD1j9ZoGSrjKvgE1S1eaJopirbIdFN8Upsa/FEeTqWOPzKpgWV1uKI2MLpXnbC3jLSJANGH/J
 evIIGlMIiS4aC4iXFMlVn8rjKRo/9TvkBREv5TkIqCL1hRLn/cvDXTP6E
X-Gm-Gg: AZuq6aK3H44TKjCE6gdgP63JdFGlTqzdX0LmtFaTxkKefAbe8Syu/i0rkNV0jeW26On
 4eRfiQcU5WVlgoxqSnxQJwgZYAWRRBgINi1ov2GR/8GzVO6VEAU7wseTNAQZ9A+MOgnctIdtIG2
 6BBD9Ytl/CN6rKvFyukIHG4+RRXeKsramTBQrXSPqNC3Qjcne4V641Mbh9mSjSSL0fTvupGwfzT
 Pfbz1jP7P0QTMqqX+nPY2fIkDCS9NkXucyXx0IY1+SJz8thMaCb3dw0ddYjBQt6VsoZM9YPAh7J
 N3Odm7nSZWgXsNccLK8OokUBzpvF5crdeGe1o20VWnajdqIrvDAt1eC9ThFcDw/HxOLxLvuj2/d
 V5p8=
X-Received: by 2002:a05:620a:288e:b0:8ca:105a:298f with SMTP id
 af79cd13be357-8ca2f9f65acmr105785785a.68.1770146266994; 
 Tue, 03 Feb 2026 11:17:46 -0800 (PST)
X-Received: by 2002:a05:620a:288e:b0:8ca:105a:298f with SMTP id
 af79cd13be357-8ca2f9f65acmr105777785a.68.1770146266162; 
 Tue, 03 Feb 2026 11:17:46 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fd2b5e3sm30256585a.25.2026.02.03.11.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 11:17:45 -0800 (PST)
Date: Tue, 3 Feb 2026 14:17:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: "Chaney, Ben" <bchaney@akamai.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
Message-ID: <aYJJ17xU2iQmk5sQ@x1.local>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local>
 <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
 <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Feb 03, 2026 at 12:57:16PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 02.02.26 18:42, Chaney, Ben wrote:
> > 
> > 
> > ﻿On 2/2/26, 9:07 AM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com>> wrote:
> > 
> > > > The latest version was
> > > > 
> > > > [PATCH v9 0/8] virtio-net: live-TAP local migration
> > > > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20251030203116.870742-1-vsementsov@yandex-team.ru <mailto:20251030203116.870742-1-vsementsov@yandex-team.ru>/__;!!GjvTz_vk!T9a83fcFgNhv7DgAAfFINb-FE6knVp53t5c7XkCrY76jAhmGxZz42YqHIlPt-eV_hh7V-OksMeBMsw$
> > > > 
> > > > and I plan to post v10 soon.
> > 
> > 
> > > Yes, thanks for re-raising this. If we have similar features being
> > > proposed, we should always discuss whether we should stick with one of them
> > > if that'll work for all.
> > 
> > 
> > > IIUC Vladimir's solution looks indeed superior in that it has less
> > > constraints, and also works for CPR mode.
> > 
> > 
> > This was previously discussed here: https://lore.kernel.org/all/ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru/
> > 
> > My impression from that discussion is that
> > 
> > 1. Vladimir's solution has some extra complexity
> > 2. We are trying to standardize cpr as the primary method for local migration,
> 
> I believe, that we may do local migration of devices with FDs natively,
> through one migration channel, without CPR.
> 
> In my opinion, CPR breaks migration architecture, creating additional
> state, which owns mixed pieces of different devices (and sometimes,
> not only FDs, I heard).
> 
> Instead we can keep device state all in device state description,
> including FDs if needed.
> 
> Also, second migration channel, and the fact that on target we can't
> access QMP until we say "migrate" on source seems to me an unnecessary
> load on the user and management software, we can avoid this.
> 
> Next, as I understand, the only point, why we use CPR for devices, is
> avoiding rework of initialization code of some devices, which wants to
> have FDs at early stage. But that approach can't be applied
> everywhere. An example is vhost-user-blk: you have to rework
> initialization code anyway, as if you simple pass FDs to the target in
> CPR state, when source is still running, target will simple break the
> source, touching the FDs. And, if we can't touch FDs until source stop
> - it's actually a usual migration, and we can pass FDs through main
> migration channel, doing necessary things in pre-save and post-load,
> as usual.
> 
> Hmm, looking at patch 01 here, I understand, that virtio-net/TAP does
> suffer from same problem? That we actually must not use passed FDs on
> target, when source is still running? But stopping source earlier
> means increase freeze-time. I think, if we can avoid it (and we can)
> we should avoid it.
> 
> > so the benefit of supporting non-cpr local transfers is slightly double edged
> > 
> 
> So, I think, if we plan that there would be more and more devices,
> supporting FDs local migration, and we have any change of fitting them
> into the "old" migration architecture (without CPR), we should try it.

Well explained, thank you Vladimir.  I wish some day we can move all at
least cpr-transfer users to local-migration and deprecate CPR if ever
possible.  The uncertainty to me is cpr-exec, but I really don't know how
much mgmt is adopting cpr-exec..  cpr-reboot also looks pretty special and
may not be relevant.

The core idea (originated from Steve..) is really about fd sharing, and
it's great if we can do it in a cleaner way.

> 
> --
> 
> Hm, I don't have a full picture of CPR, it's not only device migration,
> but also some other things? Interesting, how much feasible is to move
> all these things into main migration channel. That's the question I
> can't answer now. But even if keep CPR for some non-device things, it
> seems still good to keep the whole state description for a device in
> one place - in device code, like it was historically.

My understanding is there're some special mgmt (Oracle's?) that may depend
on cpr-exec; I'm not sure how far that went in any downstream deployment.

That should be able to reuse mgmt channels too (relevant to chardev fd
sharing, perhaps?) instead of requiring e.g. all monitor ports to reconnect
to a new QEMU after migration.  Said that, I always assumed re-connect is
fine, and most mgmt supports live migration so the mgmt should have that
infrastructure there already.  Maybe Ben would know better.

Thanks,

-- 
Peter Xu


