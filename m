Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD30C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4L1G-0003Ek-Da; Tue, 07 May 2024 09:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4L1C-0003De-M3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4L1A-0000bV-PS
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715089083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKT5UnOT/5vyTS7t9rbW5Au9msmDhWcOEtYuYcLd/ec=;
 b=C35JgGypDFyj8yVtnizHtTgr+kVPrl3tUVKO0rhSwMt8iF0zfaRct7L9RsoGKMDHgnoK7t
 rYDM11bJudgbsJipwsmXEA3wMCf4HYEJ/DRaOn7mE4XwC2Lf7US/GrlC7l0tJlAFbfprO4
 pmkfVqyt+CtbKGU8kC7Ixvcwc5ECNZo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-XkPYmNBQOBC4DwShCVTIyQ-1; Tue, 07 May 2024 09:38:02 -0400
X-MC-Unique: XkPYmNBQOBC4DwShCVTIyQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59e5292be1so35160166b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 06:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715089081; x=1715693881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKT5UnOT/5vyTS7t9rbW5Au9msmDhWcOEtYuYcLd/ec=;
 b=IvOxkiusymYz9SJoPOHbbzm2X7r3G9lRyhzL61OK5VBrRsMm8B3FQmMkWNVxxKZ/Os
 8LnakmHJLdyAk51qFsWSRRlmcHFZVZnf+UzH5ueDteuY5+LTi/HP8Y/c4EpongTsxoEm
 Us5dAi1zRBf0Jh+TBK97KqNIiEM4b93Ng+Ysmg3Njvz7ouLJaZc786ZKJYuWj63xkyKj
 qle/QY0odhCzyjw+yHbUh6DXss3Ol7qETIkUd4kvteVetILEVUee3ZZrCeJ8rW/7A7Mp
 GI6p2nwltH+zk3U4qMbXNkyis2m12sjTDZ4gjGk4jOqFM8tzXr2btHWebXsgPM7oM4aU
 TWXw==
X-Gm-Message-State: AOJu0Yxd9Mp86c1Sp4MzjPYa4Wj46j5LSx4Y4I0hVwvcfP4CXAqfCntt
 k7vmL5RH9PJ8qr+O3uUA6TFxDB8c7WCTjablF5EBnSvkCz7RMeZH+rjXWpzdL/JzAThrpQZsx1v
 O2FygMbNqy58/Ck5Bhrpiwm0fzN0IscwhfFy8Jm4+1VEofCTwA9Bmi3hP4e3p9MqCHsNhUVuK+z
 siwbgTcTit/EbGztmxUiOvpt63RHw=
X-Received: by 2002:a50:c349:0:b0:572:983e:4aaa with SMTP id
 q9-20020a50c349000000b00572983e4aaamr11888151edb.31.1715089081110; 
 Tue, 07 May 2024 06:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu5q/8QBmmWzS/oBkIl8clIcXJ7HxRk0/SChwvcOYXhWGMmMZy9WNMff4PIa4fXoMf4YZrkPu3Y6rK97p2t50=
X-Received: by 2002:a50:c349:0:b0:572:983e:4aaa with SMTP id
 q9-20020a50c349000000b00572983e4aaamr11888141edb.31.1715089080765; Tue, 07
 May 2024 06:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240425015342.1033815-1-dongwon.kim@intel.com>
 <20240425015342.1033815-7-dongwon.kim@intel.com>
In-Reply-To: <20240425015342.1033815-7-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 May 2024 17:37:49 +0400
Message-ID: <CAMxuvazn_+Yg7+vc34D=ewo5Swz--d6cKH41F9A3QwkyePWxHw@mail.gmail.com>
Subject: Re: [PATCH v12 6/6] ui/console: move QemuDmaBuf struct def to dmabuf.c
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

On Thu, Apr 25, 2024 at 5:58=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> To complete privatizing process of QemuDmaBuf, QemuDmaBuf struct def
> is moved to dmabuf.c
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/dmabuf.h | 19 +------------------
>  ui/dmabuf.c         | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> index 4198cdf85a..dc74ba895a 100644
> --- a/include/ui/dmabuf.h
> +++ b/include/ui/dmabuf.h
> @@ -10,24 +10,7 @@
>  #ifndef DMABUF_H
>  #define DMABUF_H
>
> -typedef struct QemuDmaBuf {
> -    int       fd;
> -    uint32_t  width;
> -    uint32_t  height;
> -    uint32_t  stride;
> -    uint32_t  fourcc;
> -    uint64_t  modifier;
> -    uint32_t  texture;
> -    uint32_t  x;
> -    uint32_t  y;
> -    uint32_t  backing_width;
> -    uint32_t  backing_height;
> -    bool      y0_top;
> -    void      *sync;
> -    int       fence_fd;
> -    bool      allow_fences;
> -    bool      draw_submitted;
> -} QemuDmaBuf;
> +typedef struct QemuDmaBuf QemuDmaBuf;
>
>  QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
>                              uint32_t stride, uint32_t x,
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> index e047d5ca26..df7a09703f 100644
> --- a/ui/dmabuf.c
> +++ b/ui/dmabuf.c
> @@ -10,6 +10,25 @@
>  #include "qemu/osdep.h"
>  #include "ui/dmabuf.h"
>
> +struct QemuDmaBuf {
> +    int       fd;
> +    uint32_t  width;
> +    uint32_t  height;
> +    uint32_t  stride;
> +    uint32_t  fourcc;
> +    uint64_t  modifier;
> +    uint32_t  texture;
> +    uint32_t  x;
> +    uint32_t  y;
> +    uint32_t  backing_width;
> +    uint32_t  backing_height;
> +    bool      y0_top;
> +    void      *sync;
> +    int       fence_fd;
> +    bool      allow_fences;
> +    bool      draw_submitted;
> +};
> +
>  QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
>                              uint32_t stride, uint32_t x,
>                              uint32_t y, uint32_t backing_width,
> --
> 2.34.1
>


