Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E1CCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqzh-0004ZM-FO; Wed, 17 Sep 2025 08:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyqzY-0004Xb-AF
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyqzW-00076f-0z
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758111024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GKwbMVwWZyQF+dYXyJH6rbD8PKesMLrRybRAS8Cobqo=;
 b=ELyx454lr73B04iE2Ox32x/RqZ2zxlUFbs/sYVeeHET6nRVPT3RGMCM9wSW+8Av2pBsniH
 YBoSDOGgj6QG5PiARUdnJL8sXUsXOQ7xmCR/tmPCPMCIGpAqpLKSJTP4ssGARiKDO8DwV8
 sbwRmFjdf0l7G3qtai8ORz2fr5gtOVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Qzvn3PmmO2OF0uxlXDuxog-1; Wed, 17 Sep 2025 08:10:21 -0400
X-MC-Unique: Qzvn3PmmO2OF0uxlXDuxog-1
X-Mimecast-MFC-AGG-ID: Qzvn3PmmO2OF0uxlXDuxog_1758111020
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45f2b9b99f0so5964515e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758111020; x=1758715820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKwbMVwWZyQF+dYXyJH6rbD8PKesMLrRybRAS8Cobqo=;
 b=I7suy331EGDWEC1dhYa2SB+wpJK+Auabwe6taE9y8CbyaTZHoH8GGL4Hx+mwxVHGyr
 kMbLwfSs9DyWY0FgKf1KKEYOP/CS1TF7f/1I4zbflHO4AATHZMhXnm8nEMoFuRPR1ncG
 JSO2KqduP5To4HDSn0f4JvPLPz0ZdOrQiZOYR2P2CGGJM1EvRPpuF3JFAYbuBTRUOwlq
 SDEKZZ8rN8819FyjdSocVO1xG8EsInfiH56KeGbdUOLJHswyH6+dbNt0gFNzBu2d8jKv
 TSGmuFloC75FlFMFYFxuLsQ9LANL1E31N+dopu2kuVurKovYhW2ys8TuXnV2yD34weni
 wJjQ==
X-Gm-Message-State: AOJu0YwU/LJ0X4aYtGfHPpEKjkwKavTi7CpkJ7rq14EMZLDcjCYPOVl7
 yU4snbK09qBdbTHeX6hDbp+uLiCxdtxHA3FW3z4S3K1GZ4pntr9vE9OiZoXTd2tkdhcctqXly9t
 yGqnRt5IJjOs/g0u90/CaUW46Paq3GHP7HoccD5pVqLLHKtxKlmbf+dCP
X-Gm-Gg: ASbGncst/q6KZ/b7DkWRHRq378sPa9nNXShpRv5YP9ZhJLmm5va3jWaRUWakUoTZHJ4
 Joh8gXWlpO9p8oHPklLJEjGYfWNhFU1u4FrrsW8Cez1LUoK43Jf69rjNAq3IMC+6iGpLy++ApSF
 ZqzVS0dWkZ3Pq0LUNztiHV6aZkw9B43Wej3Qf56H//g0LQ4bclg6dT1hyEzYIAc3T4t1r5JVvUv
 2DdCsZhyvpkO6xk5d/7BYdlw4ZwWmFCRggSZYkuBtJDXuVSxvtaqRiIF97MtUMQwfgfAEWggCUX
 HwdA05KLm39h3B16O8LZSKtX5Km0CSzjjlgyfprO+4ZL
X-Received: by 2002:a05:600c:450c:b0:45f:2ed1:d1b3 with SMTP id
 5b1f17b1804b1-461f8a2b317mr18171975e9.10.1758111019892; 
 Wed, 17 Sep 2025 05:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEckLbJkzuQC2Y6DVjMYoHRgaVqok/HvJHAa1Av+AP6GeCfN/77XGVsDdF8q+1ocvWDXsztSw==
X-Received: by 2002:a05:600c:450c:b0:45f:2ed1:d1b3 with SMTP id
 5b1f17b1804b1-461f8a2b317mr18171725e9.10.1758111019496; 
 Wed, 17 Sep 2025 05:10:19 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613dccb4fesm36334485e9.16.2025.09.17.05.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:10:18 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:10:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 02/14] linux-headers: deal with counted_by annotation
Message-ID: <uxfnphbm2iyxp5crxov27uxyw4gibvz3d5yzgajhzt3jwpc75b@ywoj355ppyjk>
References: <cover.1757676218.git.pabeni@redhat.com>
 <f2c4df8385c1682302e5847470cfe1df968fa35c.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f2c4df8385c1682302e5847470cfe1df968fa35c.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 03:06:53PM +0200, Paolo Abeni wrote:
>Such annotation is present into the kernel uAPI headers since
>v6.7, and will be used soon by the vhost_type.h. Deal with it
>just stripping it.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
> scripts/update-linux-headers.sh | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
>index 717c379f9e..64c0d7c4eb 100755
>--- a/scripts/update-linux-headers.sh
>+++ b/scripts/update-linux-headers.sh
>@@ -90,6 +90,7 @@ cp_portable() {
>         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
>         -e "$arch_cmd" \
>         -e 's/__bitwise//' \
>+        -e 's/__counted_by(\w*)//' \
>         -e 's/__attribute__((packed))/QEMU_PACKED/' \
>         -e 's/__inline__/inline/' \
>         -e 's/__BITS_PER_LONG/HOST_LONG_BITS/' \
>-- 
>2.51.0
>


