Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C65C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVm6J-0004fF-DN; Mon, 22 Jul 2024 02:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sVm6F-0004eG-CT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:00:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sVm6D-00046T-Lb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:00:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd657c9199so451115ad.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721628039; x=1722232839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l8axijnN9Wodtc11TosQyZSjUyoik0S6FXisvK9BDdw=;
 b=KbMsTucf0wJOWf8BwcqcqEXynWrgcbUcGVhsPAFcxkoWud0JDhil2g5S6nJeK+jXHk
 Hdo5AkdZxFZM0hyvRRCOrRTbkikcreeYHOgupnunJT6i6So4b2jYaZpcGAyaOR98vyPj
 BmIXmGcqTjPqOh6YM39VYT/3uHftRESirkuQpuCeMi5H6VlWVTGCQXS9GMhWbaTw6a2m
 fuPTtheiwkzmjQBGacDIvGTijcYRxOYNhMuLVHrIpBpwSZEFoGK0F+lVsdkWcS8O8oTc
 f4asJVJNG9dBf6S2GYkMjMAUFaFmYDiqShUwMTBmSSgC1GooV/bU4I6G+yq9Rlb1PiUr
 RH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721628039; x=1722232839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l8axijnN9Wodtc11TosQyZSjUyoik0S6FXisvK9BDdw=;
 b=eafhNGC07XNaPV+GxzoEfm2KztiLgC04ErWwEyr1H5FG96ob3y8BUqKWWhNdsOga86
 gyugtsyAzyRojhR730PrjUECxMdzU/lULrw8cGnF5/XzRkdeeHMCLzoFlBikUz+Kmx7D
 Rg53ILa7FuuOqoYi2hw/vdWmYVrt1t1OiB+4ERPForGQz/XXJpkKRzJt7dj8XjHYZyGC
 RaSg5nftHLr/bg7uCAZ+Q7SoA6gw3Gw4sFFoIkEXuHoq+b2K37rNZ/bs6krJwx1HyvJL
 JGoM4PkyOxynsGi4hAvjb5nEBGvTj+z9SbaFxX9qfqZ8dyyX37QEI2Bre6086m2NW2BJ
 J6ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP8DqQbWWEzUxO77FmuZoQTn7Koyg23hTS7owL74XCBwHc5p+YFlScpcbMCqdAdrREPKnM/6tMFAmysmZe8eytndJINCY=
X-Gm-Message-State: AOJu0YwOjmTCqL4LYj1KwrqEfw/fCnyAF14fPUO/iKp1GlF/w4KiFJeW
 uFymFs8CHiP7snCAAz1sS0Q9pM8za7ZW9mzwmcRGNdQ6OZsC2JeiS4GnpXSTMxCdc6qCWhZnkyj
 g5fmUX1DEILouWW8l9ImLpmIBegM9WXxZP1Ei
X-Google-Smtp-Source: AGHT+IH5bCDpw2SO416GlhjfNRbLRIE/z2Fsd/FFUH1EYMaw7OT2jf9nb4eQIYCJKeT6kXoBBbckwnteVkMrek8lOA4=
X-Received: by 2002:a17:902:e84b:b0:1f6:5bba:8ea3 with SMTP id
 d9443c01a7336-1fd7ff62be7mr2720085ad.25.1721628038863; Sun, 21 Jul 2024
 23:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
 <20240701211531.97637-1-rkir@google.com>
 <CAOGAQeq_s3iT6m9m4gwhuD5BFc1FwM7hHTNvq9htAB4NA1u=kw@mail.gmail.com>
In-Reply-To: <CAOGAQeq_s3iT6m9m4gwhuD5BFc1FwM7hHTNvq9htAB4NA1u=kw@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Sun, 21 Jul 2024 23:00:00 -0700
Message-ID: <CAOGAQeqMMu49uuZC9od10tesyL_y9NRs+Us-hFeEsMx3Xa+J7Q@mail.gmail.com>
Subject: Re: [PATCH v4] Add timer_join to avoid racing in timer cleanup
To: pbonzini@redhat.com
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org, Danny Rosen <dannyrosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rkir@google.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Paolo,

could you please take a look? If you don't like my patch I will be
happy if you suggest your solution for this problem.
We can help with reviewing it.

I grepped through the QEMU sources and found timer_del is called from
a separate thread in accel/tcg/tcg-accel-ops-rr.c.
It does not use the opaque pointer, so this is not exactly the same
issue I sent the patch for, but QEMU already has
timer_del inside a separate thread.

Another solution (to adding timer_join) here could be guaranteeing
that the timer callback will not fire after timer_del is called.
This would be beneficial for accel/tcg/tcg-accel-ops-rr.c.

Regards,
Roman.

