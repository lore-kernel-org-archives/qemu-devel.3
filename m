Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBA606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WarbIOzb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BjEMbzBs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQMZO-0003Id-Lg; Mon, 09 Nov 2026 05:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xQMZM-0003FM-Kt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xQMZL-00025R-4h
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794219942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXEKbtbosUlzfcqYYDS6HEaUWzEBNVodepyG4eI4gKI=;
 b=WarbIOzbEeInlI5fPH3xpxC/I5lNecYQLXsDvlljcsK7gmos3objpJff38K9PuVTkh6HQc
 SrFo8b2yNEf5o8FAayOKaZ5Ok3DeMpezR93shHwaKmVsA/LkSiXmkhDhNcqSpS3rxO8SXS
 ASoEbOxWWKCZMM2kXsL0fiBF8Yjq+Ao=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-h9xmGtJmOy6bG5WniY1UXg-1; Mon, 09 Nov 2026 05:25:40 -0500
X-MC-Unique: h9xmGtJmOy6bG5WniY1UXg-1
X-Mimecast-MFC-AGG-ID: h9xmGtJmOy6bG5WniY1UXg_1794219939
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4b9f7cace4bso7130105e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794219939; x=1794824739; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pXEKbtbosUlzfcqYYDS6HEaUWzEBNVodepyG4eI4gKI=;
 b=BjEMbzBs3UnXoCR0FY8zJ7BCm74unqBmZWEGre3exgAYG6333E65oG3G+2VElSI26D
 JFuMgznPWZOJXrqaoGUJaTJ3Ovg6nnXvc2nUEl8NXkPiGXsF8M41B2rcysxK4SIUlvBh
 4Ze40QIN/ACqQ4WQiU1NdXJq+Ry1tCb1zQyqOCoc3TuFJRfeQBRG8yEPm9XQa0bof7OV
 bwTL0PzYd3btBSjOQzliqwdSSnzBzxq++q+AZoW+0SKUxqgL5IGeWHpNg7esA6DBGUrW
 flgRZ8tud3uwcdUh/ImrhhwUYMjqcLkHLqliZe6k53L7VvBFo8g9kh/YIfD29levSJP+
 hE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794219939; x=1794824739;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pXEKbtbosUlzfcqYYDS6HEaUWzEBNVodepyG4eI4gKI=;
 b=U7AUP9u/4B5avY/CR4wgC9Fwo1I+BzIEq9mR0TVgL5YD2OPtIa8VWyYkhP1dy3uRFX
 JPNeL7JXT+h6OJ4mCEnoP8cgUG0Kkve3dZ4qeqSv6K6Sc5VaXnoeosdckT84QJKGvMcb
 tfk2PzBEV9cJodref8gElzOzlig4pu8lHDLdb9ClAsMEpljZNxtc4iuxgJK1Pxxi8VPx
 pR73BC5O4O5UqD09R+k2yEftczJkI4ioE1dZVZkcdit5ytpF44aWJHSddaoETd53UEO7
 fyOjUhaR9SBji65XGfwvRKxd1suEcHQCSFGoz7KOrg6mh1/7a+IZk4Ey4wOxOpis9lqp
 oURA==
X-Gm-Message-State: APuU4Z8L72Kfd5U0ns1XCZNBR+yqU9X2OTzGe2KR6egQQOZ3hVwodOYD
 jlWUSlGIs4rtTULC/yJDaXo7rIYrpw9aiVO4P44GEGrGLlozzFVPAiX2bkG9Rq3p5u08VtvEq9l
 28m1DYLPq1iO+tLamLp1IFenMpae8M8H06dfmylsTL55ccM4sRcpETyz/
X-Gm-Gg: AYBFou16oSIgnAwQFU5NFyLG3uJ2N1m+s9uFcpXJ5mrjG3X3Ch/C0pSSYCeLtJXDppc
 9jK6XT3Le146RPshtb9LloFNyhtQniQq6WBu1nokMZj5NHNVVEolhly/DgfDU79Rc9LfwRjt4+y
 11us6S5/ojMQGqtQeKP/QWQCVr3SqdNLrKnzLlqmGUCBHHpsgz+cBNkUQMWW+WicS7xsFghef9P
 HB+zeBrYopGxaJwc2+hHeJQG6xX6/nvvhUi8cP7GQSE3nIyvr7QcTCe26QKje/BdzGCmBVVlkq1
 NUbyCW5VEIhPol0V3baFP5k5yvQO8UmAR17qqeH79hJGkghPdZBiJHllKkPkrGqUAh52qiL9Ghb
 Y4BQg4/KIFv7UzyeZDC95qS68v6XLr0H5KbC0Ql/lVvdycx/Uroix
X-Received: by 2002:a05:600c:3113:b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4b963c91d7fmr67427685e9.24.1794219939170; 
 Mon, 09 Nov 2026 02:25:39 -0800 (PST)
X-Received: by 2002:a05:600c:3113:b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4b963c91d7fmr67427265e9.24.1794219938670; 
 Mon, 09 Nov 2026 02:25:38 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee1ddc7sm178161235e9.4.2026.11.09.02.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 02:25:38 -0800 (PST)
Date: Mon, 9 Nov 2026 11:25:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@lists.linux.dev
Subject: Re: [PATCH v2] vhost-user-fs: fix virtqueue array leak on realize
 failure
Message-ID: <avGfejcI5dd7kFLT@sgarzare-redhat>
References: <20261109062401.81161-1-dtalexundeer@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261109062401.81161-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 11:24:01AM +0500, Alexandr Moshkov wrote:
>On failure, vhost_dev_init() clears vhost_dev, so the error path frees
>NULL instead of the virtqueue array. Keep the pointer in the existing
>vhost_vqs field and use it to free the array on failure and unrealize.
>
>Fixes: 98fc1ada4cf7 ("virtio: add vhost-user-fs base device")
>Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>---
>v1 -> v2:
> - use the existing VHostUserFS.vhost_vqs field in realize and unrealize
>   instead of local vars.
>
> hw/virtio/vhost-user-fs.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


