Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E8606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwyK3bcy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VzDGxLbm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2vi-00071f-Qq; Wed, 28 Oct 2026 08:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM2vh-00071M-Ge
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM2vf-0001tX-SM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793191134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0k4lEuaA2VMUBEqwYByf9JNpS5DEZDiF4my9pTV8pxA=;
 b=LwyK3bcyoT5Nw2ZpOnXsM/wZKeNgImKZtDGzUdqhy7pvM2vRBLhJEs5wlA4SmGI3pLNGq8
 A1BwunoS3QopjfV2fM2x3Og82jnTNK2vSHad+E6+8AMMuvQfTGYV8LIIV6FniW/pjWdfL5
 QKC/Vzrpy8zj8Th0DtLxrpfHUIbcet4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-ox-El-HfNGibNijqgU7Dkw-1; Wed, 28 Oct 2026 08:38:46 -0400
X-MC-Unique: ox-El-HfNGibNijqgU7Dkw-1
X-Mimecast-MFC-AGG-ID: ox-El-HfNGibNijqgU7Dkw_1793191125
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so533317f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793191125; x=1793795925; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0k4lEuaA2VMUBEqwYByf9JNpS5DEZDiF4my9pTV8pxA=;
 b=VzDGxLbmg47scTWJW8Q3EWD4W/A+HXsCOm9+tphv/qzpBPcVHHoENIIsL0ZAbdsRsJ
 rhmGzlSbWdD9N3Sqslj4OZfrXj78A21h+iYSjp8jyxD5LLixlkKCUb6CLsoufAT64PtS
 WGDqnr8Ldo5RTC8GZNAuZxdzbu59ELNlQ4HWULJ8vp+X07sXDUcw8Mjhtbag9xh+a+64
 dfz9uCnov9Va6K2T7yWLpLY3NZh8faQRUjt1wtRoiej9S05eMkhvojyb5ybJc+61R/SA
 3fOPYnUiQaSdj+NQf9Nd2535bpKY+aRa8yW6sS5HQV8P/jWVZoT6xw3KlBzGqr/VObUJ
 tE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793191125; x=1793795925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0k4lEuaA2VMUBEqwYByf9JNpS5DEZDiF4my9pTV8pxA=;
 b=MJ5UlWVPCrl0ReQeiz/1qgIC65eirB4OWqyovo71tLjKP13ACZJ6XipxaVANVKQ/8V
 DYGWqRx409P7aQVuWK+r9+mPX3q0erPyeX+5xt1Dg4798q3mDAJ4iTrzS3ShAB0zX8eS
 A0s11X22G49Uhsn1ny5vkRzoRHhwRj2aNb0Dp+5CBeRddujOMeA2aI65CkN4I/dDAtii
 PKMPruBy2/+IV0hSjmC2qrY62jpbx1PIbX1WMHboRe9IKoK0I+Ywd4WRXscD+s6T/SYT
 qxZkdDg8QArYYzyyskaTohSbNk4hDg23gE6t215NTuLsP9MDhpE8P/kXmR7ED71+9PuW
 1pfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByAYkjzLlwZCFeyGrLaaI2KUAFovTWWds2pfixIre34yoJbSiM3H7v3vBEsZ4Q6wLu7wI35pXnPInjo@nongnu.org
X-Gm-Message-State: AFq9FYIL/vWoLMFVG76qNZ+o0iSldBEe0COll84le/oUZlbPB2you7cE
 UqKSS0t5cO3aIc9NTicJVJgJA03Y4HSpuxw3HsxAz65msyF75mcgGkzusyY9Nbgsgh0sqgbg0uN
 pb8gcn7uy+IeXMkF3TRfUnHgZVEl3Y0xd91MQuFz8QT3OLgD3HIlSvwV0
X-Gm-Gg: AYBFou2nmFaJ9MDg5Gm3afY2dCKif3u9+lrA8dhVIFnRDjJaVM9Cm+JV/m9yeV0X2kd
 +kjPObgE3ZDsQRRi1SyldiHjimonWgqRdKrgusofr5d9TAGwRnt32kD+48yxJPbPwE3UVnH5zyY
 CKTJrybQD16nlX1Q69Stq/ILSChdaSy6Psrm+gyN5LbZh8hOq9LSzM+CXs0m8CrD8q0m1xlqqi3
 oggYaz1Jng1CaS6dadhc/2J5Jwf7xy97aJGvLW3x9o52w1ywDTu9TqBC+oWVJXQIQ945mu+NHls
 YPMJ3xwhWlD2qwDoZpuO8i2izgHt/K9H4daob3xIXzVfDyp9gtAoO8bEgqyDih8/fFKnvM9XwEe
 JolZRQF8IlzyK/toFmy76V2ycf0LqN3T+7k6H9yme
X-Received: by 2002:a05:6000:4919:b0:48e:4325:4e60 with SMTP id
 ffacd0b85a97d-48e5d5c38a4mr5347267f8f.10.1793191124980; 
 Wed, 28 Oct 2026 05:38:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4919:b0:48e:4325:4e60 with SMTP id
 ffacd0b85a97d-48e5d5c38a4mr5347216f8f.10.1793191124368; 
 Wed, 28 Oct 2026 05:38:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecde7easm28616730f8f.52.2026.10.28.05.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 05:38:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:38:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] vhost-user: drop support for
 postcopy+CONFIGURE_MEM_SLOTS
Message-ID: <20261028083556-mutt-send-email-mst@kernel.org>
References: <20260916182917.820031-1-vsementsov@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182917.820031-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Sep 16, 2026 at 09:29:15PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The combination of postcopy and CONFIGURE_MEM_SLOTS is neither properly
> documented nor correctly implemented, see details in 01. I suggest to
> drop it for now, and document that fact.
> 
> Vladimir Sementsov-Ogievskiy (2):
>   vhost-user: drop postcopy support for CONFIGURE_MEM_SLOTS case
>   vhost-user: drop extra "else" in vhost_user_set_mem_table_postcopy()

what I get, after reading 1: , memory hotplug is broken with this,
indeed. However, pretty much everyone negotiates CONFIGURE_MEM_SLOTS
so this would just break postcopy for everyone, no?

Not a good tradeoff.

How about we just fix the issues, or at least the major ones?

>  docs/interop/vhost-user.rst |  30 +++-
>  hw/virtio/vhost-user.c      | 296 +++++++++++-------------------------
>  2 files changed, 116 insertions(+), 210 deletions(-)
> 
> -- 
> 2.43.0


