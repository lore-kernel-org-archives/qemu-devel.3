Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE5606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iPeiObm0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RHEvUpuJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJPr-0002kt-My; Fri, 23 Oct 2026 13:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKJPm-0002jy-V2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKJPk-0002zS-I1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792777847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CugUozewjWHX80CQRKUYYDjpFAt9FQqtNIAskqD2gpA=;
 b=iPeiObm0jDY0tamfe4WE6UEaJCGVlmctTd5zGRwU64TKb5S9wnUZoY7cox9ZgzY4te0erz
 GJKqqK5OYCXpzFRLtXnFAeY0mvWfZ4L0iJRzwWBsvF0HDi1+JdvORMia3YdqR5n6AwjH9H
 ESI1fafAw5a5smMdAU4923l83y6OTco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-BVCOTBw0OTGOO_YQM371WQ-1; Fri, 23 Oct 2026 13:50:45 -0400
X-MC-Unique: BVCOTBw0OTGOO_YQM371WQ-1
X-Mimecast-MFC-AGG-ID: BVCOTBw0OTGOO_YQM371WQ_1792777844
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1895ffc83so8311335e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792777844; x=1793382644; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CugUozewjWHX80CQRKUYYDjpFAt9FQqtNIAskqD2gpA=;
 b=RHEvUpuJFCNoerJfsRD3q7Wzqp3vDb068TvSS7RyzCtrcgfvClp0gaOhItm+FS0gwc
 r+i9WqwIkAXhbk9Mc/pcz3PNx4oEKkV2MmQpiRo5S+wbFULioe3uex0w5Mm0JBWy4z9d
 xY/xfDKa1jayg80THxpU/W0preTeUXP3MA88FhyXVjKYSEkPK3jSVuO82J9X/eMqCVlH
 7CV9E6AiAr0llr4z2K8Y5QLGD76LQ3PUm20uQjeQrx32qnVJc1NHoNpVcrrBdghjdAi0
 KVYfRnFeHXUy//6WhvauUarF/14ELH1cFjMUhp7AF/jXnf6tNtyAL2M2ELRDqB3iNOcx
 Fu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777844; x=1793382644;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CugUozewjWHX80CQRKUYYDjpFAt9FQqtNIAskqD2gpA=;
 b=lTLkgDNmMlgoFRa15M3v7QXQy8HoCxIAwTxth3y27YRYAEdINIJh87u8ckOo0c1aim
 CSfcpjNBOv8JviO3UqdTomxgPZpRRrgThPVdBIQpSSgqd98rPQl7K2uc67w7MYWBhim8
 uQoiiAYdAzyNZtNttgzAUhIlVEFEOOdcsN+edtgio+TXfA2wexHY6qoNwjI7iXtbFTVz
 h0usN1ZSUocCdNbR/DHUNj2ffbB+fBxUJ+tP0J5eUl9aSijcD6HP8BAjucBnmxpjOVVj
 2aSZstOkDFvsr/YIHnGWkJmYur0+5SykEbMwVkEW5mMFF17+31MImXGchj1yvslJ69iC
 WQRw==
X-Gm-Message-State: AFq9FYJCaDktIpAqcIax1C3i00CLykQPHD7o9QvPkp6I0GommnE6vYJx
 wyWceDYxLzk2lkXeRr6/te3BU7jppfAx0qMdHee3jerFCOK2a94ohc7z4HTRMTCR5EaxiQ4qkhb
 xbbuP5XN9Zl1W5rRKC4zd+ZoKBoioCZbuEoEaOhK4V5mzUVoQGN4Lk2m9
X-Gm-Gg: AYBFou3iOFQfFtXtwGDLr03sjNa4MXoyEzSIpiWlP2Ir1Roj3HUlfgpWBnrJ8hGj797
 gPz1DpyVtYNmDIEWNJN1aZLMgHo8XFDoV6Q/CyU7Ll7K8pvUDd528uMisZZ+cOwk8lv1suWASwO
 uq734MEENepP0Oy5iCDHTjlPAV63MGOrKvdGzCisTI/bz7cwnA5HIMYW1/OVj1oHaNhc/tHIbCq
 R2cDMCxTYSHUMDidWHYbJWpHt6ALQhH7rISwHxt3pa+SVueLJRUAH+x6P0LTN+e7KGvJbOvwkhW
 zE63kbmMdy3xuGRVQxIhRD9eKSN9CsE+YLFq02bSbhyZ/O1iZeP0+rHDu4PruNAf5P0YjnjWhHS
 PLg==
X-Received: by 2002:a05:600c:470d:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4a211caf202mr48524685e9.9.1792777843994; 
 Fri, 23 Oct 2026 10:50:43 -0700 (PDT)
X-Received: by 2002:a05:600c:470d:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4a211caf202mr48524295e9.9.1792777843177; 
 Fri, 23 Oct 2026 10:50:43 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.131.81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d09csm20670065e9.5.2026.10.23.10.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:50:42 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:50:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Dorinda Bassey <dbassey@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 vhost-user@lists.linux.dev
Subject: Re: [PATCH] vhost-user: add dedicated mailing list
Message-ID: <atucq-HuQIj_zXCk@sgarzare-redhat>
References: <20261023162441.89450-1-sgarzare@redhat.com>
 <atuSO02ui1nOWKsQ@redhat.com>
 <20261023132627-mutt-send-email-mst@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023132627-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Fri, Oct 23, 2026 at 01:26:45PM -0400, Michael S. Tsirkin wrote:
>On Fri, Oct 23, 2026 at 05:58:35PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Oct 23, 2026 at 06:24:40PM +0200, Stefano Garzarella wrote:
>> > From: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> > During the "Virtio and Vhost-User Ecosystem for Production and
>> > Automotive Systems" BoF at LPC 2026 [1] we discussed and agreed on
>> > creating a new vhost-user mailing list, mainly for changes to the
>> > specification and discussions around the protocol.
>>
>> You say the list is for discussions around the spec / protocol, but...
>>
>> > The main reason is that the vhost-user specification is also used
>> > by other VMMs and implemented by several back-ends outside the QEMU
>> > repository, whose developers often do not follow qemu-devel.
>> >
>> > Add a paragraph in the specification about the new mailing list and
>> > a dedicated MAINTAINERS entry for the vhost-user protocol, covering
>> > the specification, the QEMU front-end and libvhost-user (back-end
>> > library).
>>
>> ...this MAINTAINERS addition means the mailing list will be CC'd
>> on all code patches sent to QEMU for those file patterns. Are you
>> sure that's content that members of the list want to be sent
>> unconditionally ?

I added them mainly because QEMU is kind of a reference implementation, 
indeed during the discussion we agreed on keeping the spec file in QEMU 
source git, because we saw a value on asking for both spec and code 
changes. And also because other implementers can be interested on 
issues/fixes of QEMU front-end and back-end code.

But yeah, I see your point, I can leave just spec files if we think it's 
just noise.

>>
>>
>
>Good point. Let's make it a separate section?

Do you mean a `vhost-user specification` section with just the spec (and 
the new mailing list), and another `vhost-user implementation` section 
with the code (without the mailing list)?

Not sure about that, the code is already covered by `vhost`.

Thanks,
Stefano

>
>> >
>> > [1] https://lpc.events/event/20/contributions/2365/
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> >  MAINTAINERS                 | 12 ++++++++++--
>> >  docs/interop/vhost-user.rst |  6 ++++++
>> >  2 files changed, 16 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index d9209f043f..dcdb65d8cb 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -2532,19 +2532,27 @@ M: Michael S. Tsirkin <mst@redhat.com>
>> >  R: Stefano Garzarella <sgarzare@redhat.com>
>> >  S: Supported
>> >  F: hw/*/*vhost*
>> > -F: docs/interop/vhost-user*
>> >  F: docs/system/devices/virtio/vhost-user*
>> >  F: contrib/vhost-user-*/
>> >  F: backends/*vhost*
>> >  F: include/system/vhost-user-backend.h
>> >  F: include/hw/virtio/vhost*
>> >  F: include/*/vhost*
>> > -F: subprojects/libvhost-user/
>> >  F: block/export/vhost-user*
>> >  F: util/vhost-user-server.c
>> >  F: net/vhost*
>> >  F: tests/functional/x86_64/test_vhost_user_bridge.py
>> >
>> > +vhost-user protocol
>> > +M: Michael S. Tsirkin <mst@redhat.com>
>> > +R: Stefano Garzarella <sgarzare@redhat.com>
>> > +L: vhost-user@lists.linux.dev
>> > +S: Supported
>> > +F: docs/interop/vhost-user*
>> > +F: hw/virtio/vhost-user.c
>> > +F: include/hw/virtio/vhost-user.h
>> > +F: subprojects/libvhost-user/
>> > +
>> >  vhost-shadow-virtqueue
>> >  R: Eugenio Pérez <eperezma@redhat.com>
>> >  F: hw/virtio/vhost-shadow-virtqueue.*
>> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> > index c1e02ff7e9..198ad30f5c 100644
>> > --- a/docs/interop/vhost-user.rst
>> > +++ b/docs/interop/vhost-user.rst
>> > @@ -38,6 +38,12 @@ conventions <backend_conventions>`.
>> >  The *front-end* and *back-end* can be either a client (i.e. connecting) or
>> >  server (listening) in the socket communication.
>> >
>> > +The protocol is developed and discussed on the `vhost-user mailing list
>> > +<mailto:vhost-user@lists.linux.dev>`_, archived at
>> > +https://lore.kernel.org/vhost-user/. Until October 2026, when this list
>> > +was created, discussions took place on the qemu-devel mailing list,
>> > +archived at https://lore.kernel.org/qemu-devel/.
>> > +
>> >  Support for platforms other than Linux
>> >  --------------------------------------
>> >
>> > --
>> > 2.56.0
>> >
>> >
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
>> |: https://libvirt.org          ~~          https://entangle-photo.org :|
>> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


