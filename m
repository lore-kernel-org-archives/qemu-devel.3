Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hh9DmB5P;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iXe1qnnY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKOGe-0004OR-BE; Fri, 23 Oct 2026 19:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xKOGb-0004Nq-S4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 19:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xKOGZ-00053V-HU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 19:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792796498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwLD211UVaqu7pPKoIP8ESXXlc0IwvVvX30TV5bc3zI=;
 b=Hh9DmB5PqdLCEKJrMP+z3WGlg/wT0hS2nqFGbmsJUgouBs+jlBI+cer5HUDFX9MRbqQPmB
 pW+5lldJGKgPB6YBE26Ah7hjCX3oL675VyH/WPTcUal0UaTVnJ0c1WHf5Hy4fNiIz6wds8
 562pd9m3MnFs6bfKCcD1MwIuc2ktlas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6EMQXN4ePPStyjBlULo-Xw-1; Fri, 23 Oct 2026 19:01:34 -0400
X-MC-Unique: 6EMQXN4ePPStyjBlULo-Xw-1
X-Mimecast-MFC-AGG-ID: 6EMQXN4ePPStyjBlULo-Xw_1792796493
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a2001e85c8so9220765e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792796493; x=1793401293; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PwLD211UVaqu7pPKoIP8ESXXlc0IwvVvX30TV5bc3zI=;
 b=iXe1qnnYb8zFd4qShyifo0uk3y9Fpqafidcr9I2Z8eJlgvnQ8Rsl9pVFe0PZAJIrun
 erRC3co/h+xUBAVD8bp6kCfxfBnPTCqrnaBPmVMsccrgul2ZhY4OBiLe1VIM7mCrYAOU
 QYJcrX3KhThMvE2GbLvEzmv0ZjKIa3xxbIIu2P22aWLuHJBNq08JIo13aZtmWBINhBVP
 9BxGlHwLwxklCTYwEcNMW0gPEY1neSxSV+l3kawnY0Tri+0CUQs4BhIB94nRnhZWjoMA
 P/Ra88as3m0tC+UvikQYKj/h2fWlrd9Q6eRqJK7ts72OleD1ASWGX7ePt9qBjt6wNGgI
 8SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792796493; x=1793401293;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PwLD211UVaqu7pPKoIP8ESXXlc0IwvVvX30TV5bc3zI=;
 b=dzprT0nIfBRJc0rnF8UxurdSzeqGBxZCw2XzwbDXUsd5CxMxcJ9smlz6SFD/USe0ph
 0sGclRKMio2hXjnuy1So0OjDuc7sg81qRaImv53SPc0FHHctp6sTdiLeTGFJXveuwm+u
 7NdbF0PHa2iX7dZYzhKJxb5MsITBbuiEjKPwNbCY/VQW038v9yLs3BmKVoPBmXgjGF+z
 u5c0GUDOkTXT43up3M1GV1VxOJBr5ZkKN229Gt3qMpmHkc4jxnV50V23IdlEhF2OL2fS
 F4qBwlD8vuuI/WP8PoWNDOC+W4gdkiqKpiWRVL7eITg7nySmv8+thSwUYdRZU3OYRMfz
 h7yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZhf8FCYI3wdU5hyUakYmmJq4nGV2nNyVvrVa1UzIugTX3f2alhAiqR/DjcdkqhDAkZGR952fzGoap@nongnu.org
X-Gm-Message-State: AFq9FYKwcxQh2Rb9RpKE3KifaaQxHlo7nfpxTkv0Djg4YuA2RXItZYok
 geM5YOtZcauHnGOuYtynTrRg5cNd+pqzqlZlqPUL6W17mQcpp0j7VHpZN7bYJjspLq7KyxsRMQC
 yJ3jt2uLzn7sPDYIXguTr7WpLu3tNEDd23ilYD00dQDv3fLN5552DpCOg
X-Gm-Gg: AYBFou2dhI5A3FKteebf23tmXGrTQ2u2Vwb4uZMVlgoeBnv8udLpxYuOBNR1HK//e0k
 fa5zK2OHcrRJ3EFc1AXmWuF0hSouF1Dk+9ipryHSppSLqtf8zCLljP/2E1ZKSkPZeeq4CwFyf3n
 cCdpNru6FTD4XdyiBscyb6ddSYacYuTi9KRMdAr8ZB1uaP4S5tBBWCR00CBXHSmN/FrJsuAEYr1
 YmCdSWDh2RghB5+8vhhWzv516V77gzIwBTxLpKnWIt3itNmre11aHfVh3D74EMLth1IECj1lfng
 d1FzpzVLaOMFQypfn4iJElVauZPdwojzUgZjq8YKgucidhI7CKs2a51J7miqV7rGeLlP8zU=
X-Received: by 2002:a05:600c:4e87:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4a35acafe0dmr5967705e9.6.1792796492862; 
 Fri, 23 Oct 2026 16:01:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e87:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4a35acafe0dmr5967235e9.6.1792796492252; 
 Fri, 23 Oct 2026 16:01:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm11090945e9.1.2026.10.23.16.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:01:30 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:01:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Dorinda Bassey <dbassey@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 vhost-user@lists.linux.dev
Subject: Re: [PATCH] vhost-user: add dedicated mailing list
Message-ID: <20261023190116-mutt-send-email-mst@kernel.org>
References: <20261023162441.89450-1-sgarzare@redhat.com>
 <atuSO02ui1nOWKsQ@redhat.com>
 <20261023132627-mutt-send-email-mst@kernel.org>
 <atucq-HuQIj_zXCk@sgarzare-redhat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atucq-HuQIj_zXCk@sgarzare-redhat>
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

On Fri, Oct 23, 2026 at 07:50:34PM +0200, Stefano Garzarella wrote:
> On Fri, Oct 23, 2026 at 01:26:45PM -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 23, 2026 at 05:58:35PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Oct 23, 2026 at 06:24:40PM +0200, Stefano Garzarella wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > During the "Virtio and Vhost-User Ecosystem for Production and
> > > > Automotive Systems" BoF at LPC 2026 [1] we discussed and agreed on
> > > > creating a new vhost-user mailing list, mainly for changes to the
> > > > specification and discussions around the protocol.
> > > 
> > > You say the list is for discussions around the spec / protocol, but...
> > > 
> > > > The main reason is that the vhost-user specification is also used
> > > > by other VMMs and implemented by several back-ends outside the QEMU
> > > > repository, whose developers often do not follow qemu-devel.
> > > >
> > > > Add a paragraph in the specification about the new mailing list and
> > > > a dedicated MAINTAINERS entry for the vhost-user protocol, covering
> > > > the specification, the QEMU front-end and libvhost-user (back-end
> > > > library).
> > > 
> > > ...this MAINTAINERS addition means the mailing list will be CC'd
> > > on all code patches sent to QEMU for those file patterns. Are you
> > > sure that's content that members of the list want to be sent
> > > unconditionally ?
> 
> I added them mainly because QEMU is kind of a reference implementation,
> indeed during the discussion we agreed on keeping the spec file in QEMU
> source git, because we saw a value on asking for both spec and code changes.
> And also because other implementers can be interested on issues/fixes of
> QEMU front-end and back-end code.
> 
> But yeah, I see your point, I can leave just spec files if we think it's
> just noise.
> 
> > > 
> > > 
> > 
> > Good point. Let's make it a separate section?
> 
> Do you mean a `vhost-user specification` section with just the spec (and the
> new mailing list), and another `vhost-user implementation` section with the
> code (without the mailing list)?

Right.

> Not sure about that, the code is already covered by `vhost`.
> 
> Thanks,
> Stefano
> 
> > 
> > > >
> > > > [1] https://lpc.events/event/20/contributions/2365/
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > >  MAINTAINERS                 | 12 ++++++++++--
> > > >  docs/interop/vhost-user.rst |  6 ++++++
> > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index d9209f043f..dcdb65d8cb 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -2532,19 +2532,27 @@ M: Michael S. Tsirkin <mst@redhat.com>
> > > >  R: Stefano Garzarella <sgarzare@redhat.com>
> > > >  S: Supported
> > > >  F: hw/*/*vhost*
> > > > -F: docs/interop/vhost-user*
> > > >  F: docs/system/devices/virtio/vhost-user*
> > > >  F: contrib/vhost-user-*/
> > > >  F: backends/*vhost*
> > > >  F: include/system/vhost-user-backend.h
> > > >  F: include/hw/virtio/vhost*
> > > >  F: include/*/vhost*
> > > > -F: subprojects/libvhost-user/
> > > >  F: block/export/vhost-user*
> > > >  F: util/vhost-user-server.c
> > > >  F: net/vhost*
> > > >  F: tests/functional/x86_64/test_vhost_user_bridge.py
> > > >
> > > > +vhost-user protocol
> > > > +M: Michael S. Tsirkin <mst@redhat.com>
> > > > +R: Stefano Garzarella <sgarzare@redhat.com>
> > > > +L: vhost-user@lists.linux.dev
> > > > +S: Supported
> > > > +F: docs/interop/vhost-user*
> > > > +F: hw/virtio/vhost-user.c
> > > > +F: include/hw/virtio/vhost-user.h
> > > > +F: subprojects/libvhost-user/
> > > > +
> > > >  vhost-shadow-virtqueue
> > > >  R: Eugenio Pérez <eperezma@redhat.com>
> > > >  F: hw/virtio/vhost-shadow-virtqueue.*
> > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > > index c1e02ff7e9..198ad30f5c 100644
> > > > --- a/docs/interop/vhost-user.rst
> > > > +++ b/docs/interop/vhost-user.rst
> > > > @@ -38,6 +38,12 @@ conventions <backend_conventions>`.
> > > >  The *front-end* and *back-end* can be either a client (i.e. connecting) or
> > > >  server (listening) in the socket communication.
> > > >
> > > > +The protocol is developed and discussed on the `vhost-user mailing list
> > > > +<mailto:vhost-user@lists.linux.dev>`_, archived at
> > > > +https://lore.kernel.org/vhost-user/. Until October 2026, when this list
> > > > +was created, discussions took place on the qemu-devel mailing list,
> > > > +archived at https://lore.kernel.org/qemu-devel/.
> > > > +
> > > >  Support for platforms other than Linux
> > > >  --------------------------------------
> > > >
> > > > --
> > > > 2.56.0
> > > >
> > > >
> > > 
> > > With regards,
> > > Daniel
> > > --
> > > |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> > > |: https://libvirt.org          ~~          https://entangle-photo.org :|
> > > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> > 


