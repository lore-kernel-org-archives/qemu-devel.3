Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B1606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AvZMqm3U;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b/9ZonkC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJ2l-0003sF-SY; Fri, 23 Oct 2026 13:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xKJ2e-0003ri-FM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xKJ2c-0000nr-AL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792776412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAKUqij1gfbZxV4/z4/dQDdc1hDuO7Zccp7zljhgFlM=;
 b=AvZMqm3UtZzg1Rz/4zAkVLBz+cjPb1yhlfXCQM5Qmfg6cFqJmEu0sWWxUu/vz5IDPlaKnJ
 66mefP5js8lKmeln+6hz3Tvnz+YuDh4tNdedHTFE0hLw6GAmgl4ZJYID/jGU95npBg6rT4
 9J8RDuGoic150fgfE6nO7HO9mHT3miM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-zmjs_iuyMPKEIS4UWM1LjQ-1; Fri, 23 Oct 2026 13:26:51 -0400
X-MC-Unique: zmjs_iuyMPKEIS4UWM1LjQ-1
X-Mimecast-MFC-AGG-ID: zmjs_iuyMPKEIS4UWM1LjQ_1792776410
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso8539955e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792776410; x=1793381210; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jAKUqij1gfbZxV4/z4/dQDdc1hDuO7Zccp7zljhgFlM=;
 b=b/9ZonkCIxSBS+GK3RD5vY/mibXjpzZPQBX9FjJnubC8HS/kVrbj7mZA7tZDaeulqW
 0w2QoycKY/rBq3BKNCzU+4eMmtX2GX7y3sInNYMGMA7lUKg+fAUoNF0mQagS8Nv8V81b
 PyWiokUqFwC4F2eSv1LkMwYhsLXDpSdc2C5l1mw898YIRJQryht07V2Jjb0hnzOSqVEm
 8gfkG14nlQnwdV6wi7Dlqr62CqDOWjyhl2FbeF01m6Psut5RDGKOAA1N76ZjLRk1Edhy
 Q34nW5AY2IuiPIq6iXO1dgWlMBCUHzwRJbtYC8+w3Yt6Eq9gE9RIZCRhrxha4ZlKxrE5
 pqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792776410; x=1793381210;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jAKUqij1gfbZxV4/z4/dQDdc1hDuO7Zccp7zljhgFlM=;
 b=XNSPittGcGV9DgS0xgATwCUQ5VKO7UFiF4jVqDHWbK/UkCrVyLTHP2fh7jBJC5M0CG
 mriXT4htjFEpO5PCVpHuj3gArhcWndWyAOl6cNF+zKNArYOOHtbky7BECz+oq8aukqE6
 iX6O5oHUPlkaow0Ck7LbtIHhJ+sH+7CYbCsvmIN2twrKkDTCulvC9+PbY1LPxK+Mz/X2
 xDt/ViJuqCkUlbRIm9IvojxNsBMDub3D6dFQWhivp7+3snf/v06A5F7D7kxIwotGqM7c
 L8k6MVYV5XikiIOFNQ5Dm2zj/Wr/0FBkwNqPyl2rYf1gNYGFQlfcyn4G1q2CUnZqUvm4
 DJfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh9Tq4Yw4ld/Mcwk1WBKa3tknp+jN1WF9RmWqLBeNpUcv7TAqy/wN1x7YjClcvtakAh1I1KnaIdOBQ@nongnu.org
X-Gm-Message-State: AFq9FYJ/49gh34oB4a6sncPNvDxL3CusmprNwm2ncKkkRhh6fcSJBm/f
 q+xvj8LQGO+zOwnUfJJSpfECwBesWN+LxVBfekR5LKRUfWZvIAP/eAFFlsl+uzi3yaJVxvkx0h2
 9x87dCAHWRnhZlIB7W5TIUAiKZYaKLzgGN2NYq/CiwlCOyeOUWHPd1llf
X-Gm-Gg: AYBFou2KwhvNDxxuz4gOu6J76wBVubHbPhww8TDM6/SXEatBjeeH2tUf7bgcomOpaX+
 Njd1zAUKcITbzxjNxMqW3gwfinDvrLjok/ZmU1GxtXeMZFSH4zSfZWKxzQ3YTESpMdEIYOFOSQw
 nszMHSVg3nWj+XHxCUJGk9uxpQJj7VpG9pKOkd1GpcR5inL22eapMor+rzjZWp2Y+Q7ZB7clZu7
 Q9YHLdfIHz9t0EO0Gpyri1GwpHmspzF7HiwtU/vjhULQsL4ytrVwnuTo6m6Qz9Yl2N+Ud3ivQqw
 EzBKKYlMHMvkGqzJpBStA00TmSVyj0V4ZdXph5Y4lu0AswB6KU1IVCtunnVCiMYiH6QPNiM=
X-Received: by 2002:a05:600c:354b:b0:4a1:97c6:d2e8 with SMTP id
 5b1f17b1804b1-4a211ef95e3mr52870175e9.32.1792776409824; 
 Fri, 23 Oct 2026 10:26:49 -0700 (PDT)
X-Received: by 2002:a05:600c:354b:b0:4a1:97c6:d2e8 with SMTP id
 5b1f17b1804b1-4a211ef95e3mr52869515e9.32.1792776409149; 
 Fri, 23 Oct 2026 10:26:49 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2959197d2sm18671455e9.0.2026.10.23.10.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:26:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:26:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 Dorinda Bassey <dbassey@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 vhost-user@lists.linux.dev
Subject: Re: [PATCH] vhost-user: add dedicated mailing list
Message-ID: <20261023132627-mutt-send-email-mst@kernel.org>
References: <20261023162441.89450-1-sgarzare@redhat.com>
 <atuSO02ui1nOWKsQ@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atuSO02ui1nOWKsQ@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 05:58:35PM +0100, Daniel P. Berrangé wrote:
> On Fri, Oct 23, 2026 at 06:24:40PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > During the "Virtio and Vhost-User Ecosystem for Production and
> > Automotive Systems" BoF at LPC 2026 [1] we discussed and agreed on
> > creating a new vhost-user mailing list, mainly for changes to the
> > specification and discussions around the protocol.
> 
> You say the list is for discussions around the spec / protocol, but...
> 
> > The main reason is that the vhost-user specification is also used
> > by other VMMs and implemented by several back-ends outside the QEMU
> > repository, whose developers often do not follow qemu-devel.
> > 
> > Add a paragraph in the specification about the new mailing list and
> > a dedicated MAINTAINERS entry for the vhost-user protocol, covering
> > the specification, the QEMU front-end and libvhost-user (back-end
> > library).
> 
> ...this MAINTAINERS addition means the mailing list will be CC'd
> on all code patches sent to QEMU for those file patterns. Are you
> sure that's content that members of the list want to be sent
> unconditionally ?
> 
> 

Good point. Let's make it a separate section?

> > 
> > [1] https://lpc.events/event/20/contributions/2365/
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  MAINTAINERS                 | 12 ++++++++++--
> >  docs/interop/vhost-user.rst |  6 ++++++
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d9209f043f..dcdb65d8cb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2532,19 +2532,27 @@ M: Michael S. Tsirkin <mst@redhat.com>
> >  R: Stefano Garzarella <sgarzare@redhat.com>
> >  S: Supported
> >  F: hw/*/*vhost*
> > -F: docs/interop/vhost-user*
> >  F: docs/system/devices/virtio/vhost-user*
> >  F: contrib/vhost-user-*/
> >  F: backends/*vhost*
> >  F: include/system/vhost-user-backend.h
> >  F: include/hw/virtio/vhost*
> >  F: include/*/vhost*
> > -F: subprojects/libvhost-user/
> >  F: block/export/vhost-user*
> >  F: util/vhost-user-server.c
> >  F: net/vhost*
> >  F: tests/functional/x86_64/test_vhost_user_bridge.py
> >  
> > +vhost-user protocol
> > +M: Michael S. Tsirkin <mst@redhat.com>
> > +R: Stefano Garzarella <sgarzare@redhat.com>
> > +L: vhost-user@lists.linux.dev
> > +S: Supported
> > +F: docs/interop/vhost-user*
> > +F: hw/virtio/vhost-user.c
> > +F: include/hw/virtio/vhost-user.h
> > +F: subprojects/libvhost-user/
> > +
> >  vhost-shadow-virtqueue
> >  R: Eugenio Pérez <eperezma@redhat.com>
> >  F: hw/virtio/vhost-shadow-virtqueue.*
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index c1e02ff7e9..198ad30f5c 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -38,6 +38,12 @@ conventions <backend_conventions>`.
> >  The *front-end* and *back-end* can be either a client (i.e. connecting) or
> >  server (listening) in the socket communication.
> >  
> > +The protocol is developed and discussed on the `vhost-user mailing list
> > +<mailto:vhost-user@lists.linux.dev>`_, archived at
> > +https://lore.kernel.org/vhost-user/. Until October 2026, when this list
> > +was created, discussions took place on the qemu-devel mailing list,
> > +archived at https://lore.kernel.org/qemu-devel/.
> > +
> >  Support for platforms other than Linux
> >  --------------------------------------
> >  
> > -- 
> > 2.56.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


