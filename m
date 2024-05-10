Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F1EC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5M49-00034O-JN; Fri, 10 May 2024 04:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5M48-000345-Dw
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5M46-0003ih-7j
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715331437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBYHZ8mKSQNhJiAWDvBUxh9cyqP5h+shfEIOsNlQhbk=;
 b=cLtltbCk4YCOfRbCx0DMs5joh2n3kwYCxNMmLQlhcKRAd67EG27cjVb01qcxc5H2yyZ9Un
 AD6tJH2WwnAYGPwOuq4D689ACtTiC0WNTL8L81gWvCRG/ONDKXxyzEF1tMsHr5X4eI0Grt
 OskrVkrZ3IlemeV48O7Dp4TNyzQUl5o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-cog8pHKeMjyofITcGqS9yw-1; Fri, 10 May 2024 04:57:03 -0400
X-MC-Unique: cog8pHKeMjyofITcGqS9yw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e233a3d4b0so18262621fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 01:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715331421; x=1715936221;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBYHZ8mKSQNhJiAWDvBUxh9cyqP5h+shfEIOsNlQhbk=;
 b=CCdgbd7QXE1WE6UTexoTJJ0fC0+nlG1GmS8yPiZ3ohWKgc0kZ7MnAdgVZapL8IYXx1
 Oz3D+QaRyY8cHyrrapHiOd1uIzVAJCywB/w+udXlP4IbhZzb+tKJWHlv1O2B3eoyohuo
 lIJ+QQTLL0iziDPFHiiPRrS2Va7xmERHASsVLBBUmLOTpiJf29RCohkvcG7+Eu+uEAdb
 8zgjhCFMHK0zYuOoc8YtRlSmg+OKpYRBathR+PsNPNVmJWyzijH9pwweCNsXtrojUrxZ
 BYOC92d8so+gKVEhC+zv3H2zfrTAPvAMUi5YhLb/ps0F+kG8P7aFQIYX7xjOKGiWVsPz
 81Vg==
X-Gm-Message-State: AOJu0YwRp5lHp8Y2XPgZWiwLUEi5ol4/8QxyOuFmWfXF4V9NwTD63TeV
 SWjcYGdXPWSqCkX6K5JbzSc8va9FipeoN+RKDxzCYO5vba1TYMqEREeYlwXkgotNyR8+UmZIxZ5
 o72/dTkg60udJ8MItsR0zaW4wV0P8YA6HZR2gIMAu7D8qSNj3WKyG/gUJan/R
X-Received: by 2002:a05:651c:14f:b0:2e4:e02c:a0bc with SMTP id
 38308e7fff4ca-2e51ff65d1amr12943481fa.31.1715331421376; 
 Fri, 10 May 2024 01:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1o6goYbj4LuoZJPxnBf1McS9iaMtidCmPsV/X5Mrwg3z61Ns7B2apYm4Xwc4juPN4prJkZg==
X-Received: by 2002:a05:651c:14f:b0:2e4:e02c:a0bc with SMTP id
 38308e7fff4ca-2e51ff65d1amr12943141fa.31.1715331420939; 
 Fri, 10 May 2024 01:57:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87d204c0sm89908355e9.28.2024.05.10.01.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 01:57:00 -0700 (PDT)
Date: Fri, 10 May 2024 10:56:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com, 
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 gmaglione@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 08/12] libvhost-user: enable it on any POSIX system
Message-ID: <mxo4rug3bs4nnce3jdhcjpt2pzavpdh4m6wkxsydfel7p6e226@hcrtk37vnx3c>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-9-sgarzare@redhat.com>
 <74f4593a-eada-40cc-8371-0f53a62f39ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74f4593a-eada-40cc-8371-0f53a62f39ad@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 08, 2024 at 12:36:30PM GMT, Philippe Mathieu-Daudé wrote:
>On 8/5/24 09:44, Stefano Garzarella wrote:
>>The vhost-user protocol is not really Linux-specific so let's enable
>>libvhost-user for any POSIX system.
>>
>>Compiling it on macOS and FreeBSD some problems came up:
>>- avoid to include linux/vhost.h which is avaibale only on Linux
>
>"available"
>
>>   (vhost_types.h contains many of the things we need)
>>- macOS doesn't provide sys/endian.h, so let's define them
>>   (note: libvhost-user doesn't include qemu's headers, so we can't use
>
>"QEMU"
>

Good catches, I'll fix them!

>>    use "qemu/bswap.h")
>>- define eventfd_[write|read] as write/read wrapper when system doesn't
>>   provide those (e.g. macOS)
>>- copy SEAL defines from include/qemu/memfd.h to make the code works
>>   on FreeBSD where MFD_ALLOW_SEALING is defined
>
>Alternatively add in subprojects/libvhost-user/include/osdep.h.

I like the idea, but we also have other things already present before
this patch (e.g. G_GNUC_PRINTF, MIN, etc.) so do you think it's better
to add 2 patches (move everything to osdep.h, add things from this
patch), or after this series is merged, send a patch to introduce
osdep.h?

I'm tempted for the last option just to prevent this series from
becoming too big, but I don't have a strong opinion.

Thanks,
Stefano

>
>>- define MAP_NORESERVE if it's not defined (e.g. on FreeBSD)
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  meson.build                               |  2 +-
>>  subprojects/libvhost-user/libvhost-user.h |  2 +-
>>  subprojects/libvhost-user/libvhost-user.c | 60 +++++++++++++++++++++--
>>  3 files changed, 59 insertions(+), 5 deletions(-)
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>


