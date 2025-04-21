Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC89C369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 10:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6o5m-0004hg-2f; Mon, 21 Apr 2025 06:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u6o5e-0004h8-Bs
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 06:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u6o5c-0003NU-L5
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 06:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745230163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34j4x9/QBppr8tsmdXP00LpKtjOlVQKZeg4V5DhuP9I=;
 b=WUtEWjp58VN1bskytQp0PjUvnfzl+AUKiFF4DD6z/qsaXjKDA9qQjnyfk4u3bntU5HECmR
 pOB+MT0P04dStvMtZ6LUczRHu+01zpEDXDM6sDew6iJ6fYvCPq0AsApS56xt2QzjeaJeEs
 fEtmlMsHtJQZqe6AfrTZ7ML39/8Lwe4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-l-c57tt3Pw64FIGn1F8aYQ-1; Mon, 21 Apr 2025 06:09:21 -0400
X-MC-Unique: l-c57tt3Pw64FIGn1F8aYQ-1
X-Mimecast-MFC-AGG-ID: l-c57tt3Pw64FIGn1F8aYQ_1745230160
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-476b2179079so78950161cf.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 03:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230160; x=1745834960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34j4x9/QBppr8tsmdXP00LpKtjOlVQKZeg4V5DhuP9I=;
 b=smyIjphZDTHy6vkJ1EBnEEYMJyzZ9RRIS7TxXQO8wPhNwLKc9IoKo1NM7VDQZPUTsu
 M7vc5BjuWibkazsOmzcFTAw+7FGS29yoJ+8bT+lQugJaBPwka5Q+xh8FagMXxa6KgkSt
 DT/d/mws6HqkhBcoL3e6825FnvdXitgzupgFTXD/s9gBKCse0k6sCLf0/5Pt39DXgEHp
 38uCvcuJ/B0YEgHbi20NG+L1Z3mmpBMpZ7Lkem9Nqix4099AebO0t3vOOzh4rOmjZCXA
 kcFaMnZrsJi33LjVWFQJmSwwS7Asj9S3jxpLhmuEE5zcXshym15xHqHEDw86mY8ifap1
 jfWw==
X-Gm-Message-State: AOJu0Yw8zjJj6UCa3tN6iKYPSszcoX7SmUzlGVtrE5wkrczR7yXS1Gq0
 8zClOUzhj73ASyqLrDqj8StPyIv24i+3OWnxEiNd3fAx94fmBQgYJqsmUZq4DXulxvzngfWAuh0
 XuUeSOpgq19k4OHn9mRmc7u7o3jUqN6ONtV5qiKN5//ujOHLwPsyZvdw1qJ08ZDmRFvhkRH/8Nf
 O5JEX9AbDhT4QkakXbkWxX6TK+mYvt3Qt6Vhk=
X-Gm-Gg: ASbGncvRCkP8yadQsSQ4HNjgx2viDB7MQXXrtJ5Ll25JtBYI2X5kVZlVaXXIcYek93S
 O7o2N07AE9H81paWPGjmGdhuC85HQ/3MzstB/ttFxyIIs9W+etWr0V307X40IBoqBnbT42g==
X-Received: by 2002:a05:622a:1a17:b0:476:9474:9b73 with SMTP id
 d75a77b69052e-47aec4c3d9cmr195165021cf.42.1745230160545; 
 Mon, 21 Apr 2025 03:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGDxf3Zm3rLEAFpsnm5yill2GixtD7027U9xTWujcLKPOEOvWWEquTbbV5yQ81YRjld5VCHEH2QDAvJdkqm8c=
X-Received: by 2002:a05:622a:1a17:b0:476:9474:9b73 with SMTP id
 d75a77b69052e-47aec4c3d9cmr195164811cf.42.1745230160313; Mon, 21 Apr 2025
 03:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-9-dietmar@proxmox.com>
In-Reply-To: <20250418112953.1744442-9-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Apr 2025 14:09:08 +0400
X-Gm-Features: ATxdqUFkiFelsSUQ7w7_hDZw4k3_0duQZaPsUzJI9Rq-8CfB8crU_h4GBIZ327o
Message-ID: <CAMxuvaxUnRY-gBgAVc39mpDJr2_0yA6X6XXm2xbxa5szA-2wtw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] vnc: initialize gst during argument processing
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.69,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi

On Fri, Apr 18, 2025 at 3:30=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
> wrote:
>
> So that we can set --gst- options on the qemu command line.
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>

Nice, could you move that up in the patch series? As a second patch
after linking gst seems fitting.

> ---
>  system/vl.c | 8 ++++++++
>  ui/vnc.c    | 4 ----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03..c7fff02da2 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -140,6 +140,10 @@
>  #include "qemu/guest-random.h"
>  #include "qemu/keyval.h"
>
> +#ifdef CONFIG_GSTREAMER
> +#include <gst/gst.h>
> +#endif
> +
>  #define MAX_VIRTIO_CONSOLES 1
>
>  typedef struct BlockdevOptionsQueueEntry {
> @@ -2848,6 +2852,10 @@ void qemu_init(int argc, char **argv)
>      bool userconfig =3D true;
>      FILE *vmstate_dump_file =3D NULL;
>
> +#ifdef CONFIG_GSTREAMER
> +    gst_init(&argc, &argv);
> +#endif
> +
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
>      qemu_add_drive_opts(&qemu_common_drive_opts);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 6db03a1550..8f6287e2e6 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4350,10 +4350,6 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Er=
ror **errp)
>      Error *local_err =3D NULL;
>      char *id =3D (char *)qemu_opts_id(opts);
>
> -#ifdef CONFIG_GSTREAMER
> -    gst_init(NULL, NULL);
> -#endif
> -
>      assert(id);
>      vnc_display_init(id, &local_err);
>      if (local_err) {
> --
> 2.39.5
>


