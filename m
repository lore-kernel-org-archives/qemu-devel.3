Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA55BD3CC82
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 21:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8sb-0003aN-Vl; Wed, 14 Jan 2026 16:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg8sa-0003a4-FT
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg8sZ-0003A0-4N
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768427893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8SBT1pBmEfJh/nYjObHr7fEkO+/sSZDOi3orguP0nw=;
 b=eT39JzGfd1gIAMQbjC57ZNSnhrqhpL0GEBhceMl/eyw2hjqXCB6Z8KOONTccUXhtz/kGRE
 1VsMgqPiyqXnskUzXk7XIbslQdvUWt1RdqjUNKECcml5LXWGPwSuwe7JBEtFdLiEyMHfyJ
 nZaG1tTSXV1JOGpDVqXmWGf1vUUkxXo=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-VY9bc7nyPpKw0dEhmSkslg-1; Wed, 14 Jan 2026 16:58:11 -0500
X-MC-Unique: VY9bc7nyPpKw0dEhmSkslg-1
X-Mimecast-MFC-AGG-ID: VY9bc7nyPpKw0dEhmSkslg_1768427891
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-5ed0b7ed42eso268975137.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 13:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768427891; x=1769032691; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t8SBT1pBmEfJh/nYjObHr7fEkO+/sSZDOi3orguP0nw=;
 b=T0KEIySt7m+Z2l2qlaFdbeZcEHNkH5VgcOgsjHVGXac0amQ1Yn9bRHFlVcQIhn6Ryp
 tFY/eVRWC7warIa0g9KpzgNbL3AxeAEljJrhU6dq+syKslZMRR6X2ULB6uHl0V3tZQDv
 dIe54YWUQGaRSHt20mhJIMDQMZE4VBxJPBCEm48ex1Y6koNL1rU1m8OUC4+2dGgaYdKY
 Ek1PsmuHL5ANcTf3Z1V3Df06AjpYUItYAnOb0WKgvLGBSzgYQ9e0tu3kUWyRnJPan57X
 rD+a6KY/D0hiU5gFosc+BDYPIurOpbQ9iHIcbsS+BrVy53ndKKBg5lK3OUo9Y3bBxay7
 6LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768427891; x=1769032691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8SBT1pBmEfJh/nYjObHr7fEkO+/sSZDOi3orguP0nw=;
 b=JZL+RKBCzUtb3jFL8H7GH00IEmXgLW+0gCoCiiNzwweGIof2Fv79qaVPQZkZYp6GXO
 gjri0/Dzet5SCwdnpUHSse14h8rNemUyTcE78PeK2wWF2QpqYdrwybivzXSC870Mtq65
 83ChmNhDaEAAm4YBUUcINcWa0teXph+rOsLlM8UeA6E9F+PwHE8f81Ngrc35yYcwSu0+
 Tv/HTPKIrc6bQ3HXQhtUD01b0EIQ6VYGz10mkP+W7gwct4THC6bZMZQxW0uFsNP3Dvuw
 cirqaJACB5fFBYPs+Dp3Ch0F27E6sblNEbpFOhElZs3P37egXblqBGFt3IdT11zqAisS
 Vaqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaHFnSQ/EdWoyW0/vr3sQTG6CMNvfwuTuLlqXCpu1CWzkU5o+0QNW/V4pzt3mem1Hf3y88yX/Ccleq@nongnu.org
X-Gm-Message-State: AOJu0YxGJMf1tQiUKzFx9gO2Ui9MddpHlBU/goFaDI9vspSxbzqvLYTo
 yNaocx6i9BB7RBUSD0+wWgoKtLQbGr4pngu1rjvcEcjlMw+wlzvNIJ9yXO3YKpsITkSB9qWmmy6
 /iV+whFsAUzSL7NW4iHdp6ObDf5X1Qd2BARql/b1cbt1qa4BLBe1Qnvtr
X-Gm-Gg: AY/fxX60bBsgGAo7tq8ZbQjKmeyF37ESon+ifIlyawJ76I8yIvAG6wJ30qtFM1FRpLi
 coiVJJRbIBzOxiSn9b5C96GxSLLYg0r07+k2aj58Jm8WbgWd+zP5BXHDdh2gM9cLPIRDfL4ZEBN
 ElxKPiXe4GDUTZ6zI0ridoiP75jU4tSntR84aTLi07Ua0DuTqvOjOAxl2NJyP4uLZXkpEL7FOYK
 GYjwShQrj17+2owJRgfqZbtjeEOPBw0vY3AldmQhAFa7Da/QT3a2gHj5xS9V/LblGksZkC/92k2
 Vepmk8x/T52a7EGtAz6mjHQh51zM4Lca7O8Xxgfd61E0ImkHfDGjQK5KgtQx9KEZFkwUc8iOMLM
 3HVs=
X-Received: by 2002:a05:6102:5e86:b0:5ec:c528:4dd3 with SMTP id
 ada2fe7eead31-5f17f69f277mr1758010137.42.1768427890926; 
 Wed, 14 Jan 2026 13:58:10 -0800 (PST)
X-Received: by 2002:a05:6102:5e86:b0:5ec:c528:4dd3 with SMTP id
 ada2fe7eead31-5f17f69f277mr1757981137.42.1768427890497; 
 Wed, 14 Jan 2026 13:58:10 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944124e97b1sm23437598241.15.2026.01.14.13.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 13:58:10 -0800 (PST)
Date: Wed, 14 Jan 2026 16:57:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
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
Subject: Re: [PATCH v6 4/5] vhost: add vmstate for inflight region with inner
 buffer
Message-ID: <aWgRZmQuQNDRRNRs@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-5-dtalexundeer@yandex-team.ru>
 <aWfrT6JOMm9MGoIw@x1.local> <20260114213817.GA622013@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114213817.GA622013@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 14, 2026 at 04:38:17PM -0500, Stefan Hajnoczi wrote:
> On Wed, Jan 14, 2026 at 02:15:27PM -0500, Peter Xu wrote:
> > On Tue, Jan 13, 2026 at 02:58:17PM +0500, Alexandr Moshkov wrote:
> > > Prepare for future inflight region migration for vhost-user-blk.
> > > We need to migrate size, queue_size, and inner buffer.
> > > 
> > > So firstly it migrate size and queue_size fields, then allocate memory for buffer with
> > > migrated size, then migrate inner buffer itself.
> > > 
> > > Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > > ---
> > >  hw/virtio/vhost.c         | 57 +++++++++++++++++++++++++++++++++++++++
> > >  include/hw/virtio/vhost.h |  6 +++++
> > >  2 files changed, 63 insertions(+)
> > > 
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index c46203eb9c..f655c53b67 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -2028,6 +2028,63 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
> > >      }
> > >  };
> > >  
> > > +static int vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> > > +{
> > > +    info_report("vhost_inflight_region_buffer_pre_load");
> > > +    struct vhost_inflight *inflight = opaque;
> > > +
> > > +    int fd = -1;
> > > +    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > > +                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > > +                                  &fd, errp);
> > > +    if (*errp) {
> > > +        return -ENOMEM;
> > > +    }
> > > +
> > > +    inflight->offset = 0;
> > > +    inflight->addr = addr;
> > > +    inflight->fd = fd;
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +const VMStateDescription vmstate_vhost_inflight_region_buffer = {
> > > +    .name = "vhost-inflight-region/buffer",
> > > +    .pre_load_errp = vhost_inflight_buffer_pre_load,
> > > +    .fields = (const VMStateField[]) {
> > > +        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static int vhost_inflight_region_post_load(void *opaque,
> > > +                                           int version_id,
> > > +                                           Error **errp)
> > > +{
> > > +    struct vhost_inflight *inflight = opaque;
> > > +
> > > +    if (inflight->addr == NULL) {
> > 
> > IIUC this can never happen because pre_load() must trigger before
> > post_load(), and when reaching post_load() it means pre_load() must have
> > succeeded..
> > 
> > So, IIUC we can drop this post_load() completely (or assert addr in
> > pre_load instead).
> 
> I asked for this input validation check. If the migration stream is
> inconsistent (e.g. broken or malicious source QEMU), then the subsection
> might be missing but size could be non-zero. The destination QEMU should
> fail cleanly and not run into undefined behavior.

Ah I misread it as the one pairing with the pre_load().  It makes sense
indeed to have such post_load() in the parent VMSD.

Please ignore my comment, sorry for the noise.

-- 
Peter Xu


