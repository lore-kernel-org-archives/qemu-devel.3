Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEC4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1L4g-0006tN-EZ; Mon, 29 Apr 2024 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s1L4f-0006sh-7Z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s1L4Z-0001Y9-Tl
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714374309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AU3OvV0FGZBdlDBgUS/9ZSJ5+OV25xDSllpu0lckNQ0=;
 b=FlCU08K36T8MMays4geG+nK//VUbDRq7XL2KOY0Qnlgom01igJTCG68gJY3LaIHJdzkdDU
 19uxT7al1FUwtAzkgTutMZeroSlQanAgtEnY1zF9TpscJ4LYb2W4xi9wCBqCgSuPWsDGt0
 QMRCfNnB0R+b0Od1nSkFBfyIlP64710=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-sUn-P-6rMYans1NReSz-DQ-1; Mon, 29 Apr 2024 03:05:06 -0400
X-MC-Unique: sUn-P-6rMYans1NReSz-DQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41bf05377abso5210235e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 00:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714374305; x=1714979105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AU3OvV0FGZBdlDBgUS/9ZSJ5+OV25xDSllpu0lckNQ0=;
 b=g4/d4uo1q7W8LwZcZ1uU1tQmZFSZo8lFjNA0fGIjHKPr75FWBXSkErj9uP1BXuK0kd
 rC8Sk2GwiD72wI7vHuP9c1SIg4zPwnQDpaUzCOCjTfQ8wBdZuw7iaFE6RhP88p+qX8mF
 uXYCvhMbM7Kynj8N/7o2krH3JsVlScxtA4Y2LvE5Nh8I2zXG0+23/4sgENINdHJQXkO7
 nNoHT019tnhLVoqeFtQ2T5xmPLoSFr38L0EwF/Vo6YxGCEiVXnARa7bsos0nLBk8C2Ji
 uzAZ40zxSvKF1LM6sHqGXm25kN0dI4akN0cy+j/QZ6Qbs5penOJBmt/tCe2MkbgGk0Ke
 6cKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpqrN6Vv/1ThIQHQnnvZF3ktI1epxhwrzXDY2yhPBQiad8CJuJCeAzpY6wX245UDp5boxOCKCvHIEz9Xgpw9APFboNMAY=
X-Gm-Message-State: AOJu0Yx2/G0RxOITs24g33QsD58gsvz8F3/F2Z+hNu2NF05zvWyXMNeq
 w2GnpkCV98lV3doSEl+mkQupRYelOj46AftOHVhQJAPwJJYbdnZc9CicxHLpe4APhT5fHj+7Fzt
 0FTyjWaxneiUf3FRZRMbO2JoUewv76ArjcK2ZAsobvA06IDExPLb2
X-Received: by 2002:a05:600c:1394:b0:41a:8b39:8040 with SMTP id
 u20-20020a05600c139400b0041a8b398040mr8600762wmf.20.1714374305480; 
 Mon, 29 Apr 2024 00:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKVm9bW2/soqmIbhxiWWyPWj9u2ybbEd9+0mxqnrmyp/kWIzp3phiIV5TT/tb94AyK8xVe1g==
X-Received: by 2002:a05:600c:1394:b0:41a:8b39:8040 with SMTP id
 u20-20020a05600c139400b0041a8b398040mr8600736wmf.20.1714374304949; 
 Mon, 29 Apr 2024 00:05:04 -0700 (PDT)
Received: from redhat.com ([212.116.168.114]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b00417ee886977sm44442695wmq.4.2024.04.29.00.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 00:05:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:05:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 20240428-rss-v10-0-73cbaa91aeb6@daynix.com
Subject: Re: [PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto
Message-ID: <20240429030329-mutt-send-email-mst@kernel.org>
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428-auto-v1-0-7b012216a120@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 28, 2024 at 04:21:06PM +0900, Akihiko Odaki wrote:
> Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
> ("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements")
> 
> Some features are not always available, and virtio-net used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
> 
> Convert feature properties to OnOffAuto so that the user can explicitly
> tell QEMU to automatically select the value by setting them "auto".
> QEMU will give an error if they are set "on".
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Should we maybe bite the bullet allow "auto" for all binary/boolean
properties? Just ignore "auto" if no one cares ATM.



> ---
> Akihiko Odaki (3):
>       qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
>       virtio-net: Convert feature properties to OnOffAuto
>       virtio-net: Report RSS warning at device realization
> 
>  include/hw/qdev-properties.h   |  18 +++
>  include/hw/virtio/virtio-net.h |   2 +-
>  hw/core/qdev-properties.c      |  65 ++++++++++-
>  hw/net/virtio-net.c            | 259 +++++++++++++++++++++++++----------------
>  4 files changed, 239 insertions(+), 105 deletions(-)
> ---
> base-commit: ec6325eec995018983a3f88f0e78ebf733a47b7e
> change-id: 20240428-auto-be0dc010dda5
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


