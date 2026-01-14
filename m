Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98757D37E40
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2cx-0003f3-GK; Wed, 14 Jan 2026 10:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2cm-0003Yn-Ov
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2cl-0006cf-6c
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768403848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j3seQXZjw+28+mx3Tr/xlZXK2Idg9HhvWuCCmUoYFyo=;
 b=dv3UIKDwEA1yV2/5T65msHZw7yEGI1Vo1IUPZhEZS2MmMEe6hyKQ+NrgQF9iyqbLrp/sMn
 TBjABtIzYDvvtKi4H7JXHcgK8+UgJ96eM2GxZ3Z2Do32HEYvDXdH4PXN4zVQagKAJFqR+y
 u9bU2MK9wnspNxmdkm45XLPlwLgQGdM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-NqRKo_SJOrebVceGEEBA0A-1; Wed, 14 Jan 2026 10:17:27 -0500
X-MC-Unique: NqRKo_SJOrebVceGEEBA0A-1
X-Mimecast-MFC-AGG-ID: NqRKo_SJOrebVceGEEBA0A_1768403847
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ec87b2b4ddso6959246137.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768403847; x=1769008647; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j3seQXZjw+28+mx3Tr/xlZXK2Idg9HhvWuCCmUoYFyo=;
 b=dsMTaYnK1EvZg9NGHccu36Dpx/qsPLBHZCuGqx09OmmQz2dEDsBu5IEFdbN5qozhJB
 cvJZ7TEjOC8J/hH2WRRe+Lw/uU/5V35XmflKMLJXeh/J/ku8WHri7orNczq3SFXiR+8c
 RcebUA1nOy98QfefWpIhqwZbZuGbk7QxmvkCYPOqEHd80STr0FlLomXXunX/Iug3WKuQ
 IUiDxsRNabUUF5LZ/en0X0xMtfLN0jBCMl7a+dy8Rm1ZPavUTqkXDlkUpSMgGqeFakfH
 SzfKpWDwOJwaLz9VZXcjMdZ/apoh/yuutAX+C2W5p91jvhGeyngUGt3j5oFnoYVh4nN7
 eUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403847; x=1769008647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3seQXZjw+28+mx3Tr/xlZXK2Idg9HhvWuCCmUoYFyo=;
 b=WdYNMOIuVwV0g+RPm/cZWCdmDMQYFYlWW2zfofeaFB4IPGmB6FRNI2dWQbNZs1Qrb1
 8V4btyxU2XjX+AFdYs0sFs6qsKvPkWOqz7QvdxrZ84gpwaDmoit/lxPdV0AhWIiHaMJS
 CMsKfCUdVuf1m5jks6Jk9fJyRqWOK0CJDD/AbWvIMy0TqyIefFJplaA2ZpfEODpuxVF4
 F7RU3UbKErSqfK8qPzxjBE5UzSoF0Xk7BU3qqKAK5y33Yce3sRvrCi3TiODiOYDyuX81
 Lj3X6oLeQKOHtqDFoGfaGIZCio/8csQkZb6rpUrSOWGNrzb0gpwNz9ajCQEhNhqyO/Gu
 aEnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoRG/szbX2FKlZuHrF8Zxw+tLKE+FRfjw1RpAFu0BYO4Nd/EfLVJDnK48klBOisTs8pyrTraaHH5A5@nongnu.org
X-Gm-Message-State: AOJu0Yw1Od8TvDCkjh5L6hpLPKng++2ulGU4PNIuw1UMB07jBi5y9FhT
 gQcQkZ/uxmW7hE0EQXFtaME1+mzuAQoB30dpJVb99l4lrL+4UynfA8ezhTEtaeh3Gox60Kmq/zi
 7o3B94xExcEzfLaT542OhhIynJb5dMdfWy4zWyshlub+FDnynVGINS/7z
X-Gm-Gg: AY/fxX6lgWjnRJznVgm4JssdEOqxDqlXGAvV/toO+ksdjUiRXHSSoFufpNE/hPdRzbH
 3uIWqmUeg5ZB3e6DmMYMDw+69kwX9OHc3Ni9BUrbhxWmlUTFxtdHBaOt03fyD2JkeZ2mwApAoHk
 zf4+HfYr/mfEm14C/lk8PWS19fiQFDDih2PDztl2+xK1yCzXfRuAk96gRquuz7dvGkxH6yQjPz/
 /aoyHRPnjmjUG+A/C5KdtVXDhz+lJfeP0K4sCSltKCuMEqQK5Lr6qtaZGwm1C2onbxdF0ACPlpe
 +2g/Aj53efryXqFhx+6MyrLAfYdZky6ZBh4+5LdeRKaM2e6Jij5WcELYn8lqVigEsYTYJ+YVmwH
 0/QM=
X-Received: by 2002:a05:6102:6893:b0:5e8:1d93:921a with SMTP id
 ada2fe7eead31-5f1838c4bb8mr838249137.15.1768403846488; 
 Wed, 14 Jan 2026 07:17:26 -0800 (PST)
X-Received: by 2002:a05:6102:6893:b0:5e8:1d93:921a with SMTP id
 ada2fe7eead31-5f1838c4bb8mr838209137.15.1768403845950; 
 Wed, 14 Jan 2026 07:17:25 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770cc7b1sm177183316d6.5.2026.01.14.07.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:17:25 -0800 (PST)
Date: Wed, 14 Jan 2026 10:17:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 0/5] support inflight migration
Message-ID: <aWezg94AB5a3F0EV@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113181242.GB528940@fedora> <aWaVVJh13ctiW9Ku@x1.local>
 <2af404d1-5e50-4caa-bee6-f8aab6a30a7e@yandex-team.ru>
 <aWeKn5A7-tWaWv0z@x1.local>
 <832f4005-2e51-49fd-91e8-9f4cbe9f2adf@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <832f4005-2e51-49fd-91e8-9f4cbe9f2adf@yandex-team.ru>
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

On Wed, Jan 14, 2026 at 05:35:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 14.01.26 15:22, Peter Xu wrote:
> > On Wed, Jan 14, 2026 at 09:19:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 13.01.26 21:56, Peter Xu wrote:
> > > > On Tue, Jan 13, 2026 at 01:12:42PM -0500, Stefan Hajnoczi wrote:
> > > > > On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:
> > > > > 
> > > > > Peter: Please review the migration aspects (especially the vmstates).
> > > > > Thank you!
> > > > 
> > > > Looks good from my side as long as it's based on VMSD, I appreciate that
> > > > change from the old versions where it used to use qemufile APIs.
> > > > 
> > > > The major question here is if this series depends on Vladimir's other
> > > > series
> > > 
> > > No, it does not. And if we can proceed with merging these series first, I'll
> > > be happy to rebase on top of it.
> > 
> > I thought it requires migrate_local_vhost_user_blk() be present?  The
> > inflight feature should not be enabled only if there's a hint that it's a
> > local migration..
> 
> Oh right, I missed it.
> 
> We discussed that Alexandr will rebase the series on master without dependency
> on my RFC.

The problem is IIUC the new INFLIGHT feature bit will be declared as
supported to vhost-user-block after applying this series.  Then if we start
a remote migration (rather than local) it'll be automatically (and wrongly)
enabled?

AFAIU, the dependency makes sense, at least to the patch to introduce the
"local" / ... capability?

-- 
Peter Xu


