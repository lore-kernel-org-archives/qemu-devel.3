Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C16D29FAF
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aKk-00079F-IS; Wed, 06 Nov 2024 02:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t8aKi-00078M-3V
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t8aKd-0007Oa-Kr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730877597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVU830fRfsrVbXBfW+gryIqa8QA2on2YdSQtZnAD6mY=;
 b=YV54BMP+NB4a6mW912vPUm+27lctDNY9Kdx5Z/XDwHf+FhHLEXiTB5Ug+vxv7EyDhA/5nI
 3LgwtZsWXaJcQ49d5cWd4HKllDVjyQICSzQDKMER+/4vwHHD2RcEljPNfCW1JovwAcr32A
 TtOiSGkHURMqdfMAcveXYowayGNLUvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-nCjDNnaFPNyNq6pEynI2RA-1; Wed, 06 Nov 2024 02:19:55 -0500
X-MC-Unique: nCjDNnaFPNyNq6pEynI2RA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso3163443f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 23:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730877594; x=1731482394;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vVU830fRfsrVbXBfW+gryIqa8QA2on2YdSQtZnAD6mY=;
 b=Mpm9CGLm63ZWP8oLUP/VFMTNLyuDwQQCs7m/tM5zNkj1oIckX23kCBkqbuOOxnG3VL
 VMaO2YxHqx18FBf7IR+TYuVZ0t0motqKM7EeBvGcTSl48YE2Wnm8eDzkqGCBXxTA3kBH
 im6uUwIGiQ9MwDQkUY8QPt2nFkB9fre7dKyJS2c/TjabqWHptf3ijiP2Iaf2+k5Vw5aw
 7s8eJYkRVQlneBgWWBVUZr/Qg03FaWbmWwaKyR8xwotJpax/y87ApgBMA8KXeE1LrZhR
 66wEz0L3uYH8ylUiKVy0QggtKWixBCioV0qM7cvgv3JqMFkv61rNJBPMo5zOCp8TW72X
 3+5g==
X-Gm-Message-State: AOJu0YzMJqj4LH/xaQOfINsaCt+J1C6KHuneY8+X4NKP6QySmPuaa8fi
 DsdRTSnD5bYK84DCZOE7OLaSb3hAoc9/azTiwNzdY40rFodoTzxL7I9a0exe9fRF/kyJOV/QAML
 Nz0LPACfMN41WRx+a34L85H68BphNpXHbvatuTV0+0YJMrAKTTot1
X-Received: by 2002:a5d:5749:0:b0:37d:5133:8cba with SMTP id
 ffacd0b85a97d-3806112800amr27055689f8f.20.1730877594246; 
 Tue, 05 Nov 2024 23:19:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbOO3OKhJjpNPXwI2XaPSxuebv4gwmEF3bCC6gbmrlgV8f7swcEDVRKjurRsKNNuci/qpxlA==
X-Received: by 2002:a5d:5749:0:b0:37d:5133:8cba with SMTP id
 ffacd0b85a97d-3806112800amr27055669f8f.20.1730877593828; 
 Tue, 05 Nov 2024 23:19:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b27sm18473537f8f.19.2024.11.05.23.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 23:19:52 -0800 (PST)
Date: Wed, 6 Nov 2024 02:19:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PULL 23/65] qapi: introduce device-sync-config
Message-ID: <20241106021918-mutt-send-email-mst@kernel.org>
References: <cover.1730754238.git.mst@redhat.com>
 <3f98408e2e4fb1792102aed2cd5425aa0e34cc9c.1730754238.git.mst@redhat.com>
 <Zyng7yk8zQ1MPx_s@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zyng7yk8zQ1MPx_s@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 09:10:07AM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 04, 2024 at 04:07:00PM -0500, Michael S. Tsirkin wrote:
> > From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > Add command to sync config from vhost-user backend to the device. It
> > may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
> > triggered interrupt to the guest or just not available (not supported
> > by vhost-user server).
> > 
> > Command result is racy if allow it during migration. Let's not allow
> > that.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Acked-by: Raphael Norwitz <raphael@enfabrica.net>
> > Message-Id: <20240920094936.450987-4-vsementsov@yandex-team.ru>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  qapi/qdev.json            | 24 ++++++++++++++++++++++++
> >  include/hw/qdev-core.h    |  6 ++++++
> >  hw/block/vhost-user-blk.c |  1 +
> >  hw/virtio/virtio-pci.c    |  9 +++++++++
> >  system/qdev-monitor.c     | 38 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 78 insertions(+)
> > 
> > diff --git a/qapi/qdev.json b/qapi/qdev.json
> > index 53d147c7b4..2a581129c9 100644
> > --- a/qapi/qdev.json
> > +++ b/qapi/qdev.json
> > @@ -163,3 +163,27 @@
> >  ##
> >  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
> >    'data': { '*device': 'str', 'path': 'str' } }
> > +
> > +##
> > +# @device-sync-config:
> > +#
> > +# Synchronize device configuration from host to guest part.  First,
> > +# copy the configuration from the host part (backend) to the guest
> > +# part (frontend).  Then notify guest software that device
> > +# configuration changed.
> > +#
> > +# The command may be used to notify the guest about block device
> > +# capcity change.  Currently only vhost-user-blk device supports
> > +# this.
> > +#
> > +# @id: the device's ID or QOM path
> > +#
> > +# Features:
> > +#
> > +# @unstable: The command is experimental.
> > +#
> > +# Since: 9.1
> > +##
> 
> Again, we're in the 9.2 dev cycle currently.


Good points, Vladimir, can you fix this up pls?

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


