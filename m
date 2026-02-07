Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C405EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vohgE-0002xe-Sh; Sat, 07 Feb 2026 07:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vohgD-0002xG-FQ
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vohgA-0000qh-Qb
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770468288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vnKfluWkbgWXVBr0wqEZT5Kz9iQa3HpHmsP4eTiwLRE=;
 b=aHU/t/cF1mJtuDSGF9eX1j0PurMD/cPosCrVz0VGj2lFZrn9uysu9x1AQIOs9rVlegrFC8
 yNTwQi5uZ/9WOGAhZQDhmeS1vtkko41yoOptfz4iTL5wg0Qp/Feot6IJYrtWttfngdxEY8
 GJcvhqOsuP98BXe/gFTk+x4OTt2/CrQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-r0xHO2cIN0CUiE3nifA5Ow-1; Sat, 07 Feb 2026 07:44:46 -0500
X-MC-Unique: r0xHO2cIN0CUiE3nifA5Ow-1
X-Mimecast-MFC-AGG-ID: r0xHO2cIN0CUiE3nifA5Ow_1770468286
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so13943525e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770468285; x=1771073085; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vnKfluWkbgWXVBr0wqEZT5Kz9iQa3HpHmsP4eTiwLRE=;
 b=HYN2wFvP5/haLJRNRlPXpizwjfXgcVf97HU5mCSZamezYg6rCd5Xo81yE3crTBhH3l
 Vzfaff2IjNMpzdRs0V8QMXdBgjFSnMuGoEsm9p+M3XcaansOA4rxbE80bx3Na6426Ool
 3l6F1jOjLtriHKEfXKrDXkz9rC31X8x/1B1jglvBdUk9ThjUM5EEdCo+UYu5+5lvJkUT
 aboz0SZ8Wy4avg+VOJLpUYXa0Q0WhekfTIyz+rC1guf+9QSEnIlGXTZUJtmpITKHyL2a
 8sGygA9E1+n3oLf+041Ejn6QXN4pI2pTkvO8YcjIhTSSIT9gBtRjAkRd4agWJwTpf2AT
 gNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770468285; x=1771073085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnKfluWkbgWXVBr0wqEZT5Kz9iQa3HpHmsP4eTiwLRE=;
 b=pGZiwxB3NFGPaXG1omNMQdLWl6/VGQ45gDkTTMOM/pRFoF2Do6FLhOTQO2ei5MMpRa
 ccmWbepP5RdvIjJnDLM2YWRkEOQefPQuM1OVtzpnPIxuhmc/2SefbTXEbF80qHLk7bNc
 S2uulGNaPlISGe/ime/uwFYBIZ7PNUjH5wPIWjygNlBE4uO2Jb0okWf301UVkSj/3Q5M
 Bb8/bP2mKOB5IEQRH1Q893W/3Wimvr8SpaXihLG1ahMJADpUt5ixxBdjb+2s3BFlurTw
 mJYgIlS8ewDqIRwlSI0/h6QJ+EDc5et49MTtfu7cAaaQNQIwsHkDrLRL6/SZVjkdYkNb
 PW6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvnyMo8JIT6Hc3d8e8TPwgi+wU9IWJq4DrhYf7WvnLKtHUD+o0iIZRdNCUY/0W1v/GjvlCPGwbM/I9@nongnu.org
X-Gm-Message-State: AOJu0YzSpQf7xtdl2WBzy9OuUnnBvYLqJD35eUXlHoALxT+Ifw2/sVsw
 dYMCiMMk2Czd7VcN3ZpqIWn/xRky3qJfNZu+3PIiOPG3oV2qZwfuag94uDNIqBL8/dXj1M2rk2p
 FLHg9eIqZXShK+drXYbeh2yaPw4USm43vgAgaMD50QwzUjSWZ0QUiYJfG
X-Gm-Gg: AZuq6aJxlNpn4i/77AMLcwf3k0UuZrTg4MCWZnrTmy2QlR/b7qfwIIOCFEJINWOQfon
 hF/F07cCbsQ+w91E5ShTfs/DqiiZWcGDzD+EvCLUsaACDL8JB//11hW1oIXsWgymW6O9nC+esTr
 MvnCQwlTy4QrvySxJKnDth58mF1Wz/+Uk4HogIsqCWxY8/TlbCl0uur63zcup7VcQZ3XYFWfimw
 fY7DI+NvI7goiPHNi15VFOJkAmn7hWlTTAm/ZCzJdM+z/nVDbSpnR+/aUHhcI9PZYCmkQL9NXYt
 pKVFrspJg6KEv3dYQI+dtYfNGWoEWBqLXM+IYWq84S/LvqbeLaecBpiKkD0uJuAbSNCQpmOuL1v
 I1yW7uh5OAGrYSYN3hh7jvImYfwD55kUnGA==
X-Received: by 2002:a05:600c:46d0:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-48320212c49mr80089325e9.19.1770468285422; 
 Sat, 07 Feb 2026 04:44:45 -0800 (PST)
X-Received: by 2002:a05:600c:46d0:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-48320212c49mr80089035e9.19.1770468284908; 
 Sat, 07 Feb 2026 04:44:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8341csm186633395e9.13.2026.02.07.04.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:44:44 -0800 (PST)
Date: Sat, 7 Feb 2026 07:44:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Subject: Re: [PATCH] vhost-user: pass GPA instead of UVA
Message-ID: <20260207074418-mutt-send-email-mst@kernel.org>
References: <20260204092339.211650-1-vsementsov@yandex-team.ru>
 <20260205031227-mutt-send-email-mst@kernel.org>
 <23c05b17-f993-48fd-bf41-06d358fd74d9@yandex-team.ru>
 <20260205033629-mutt-send-email-mst@kernel.org>
 <e69d5e72-043b-4ae4-915a-4b638503fca5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69d5e72-043b-4ae4-915a-4b638503fca5@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Sat, Feb 07, 2026 at 03:19:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hmm.. Seems that we need a feature flag to live without UVA addresses. In the long
> run, it's better than hacking.

Right.

-- 
MST


