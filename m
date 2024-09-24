Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42DECF9C72
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 02:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssvY9-00057E-Tu; Mon, 23 Sep 2024 22:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexjlzheng@gmail.com>)
 id 1ssvY4-000538-Cr
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 22:45:09 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexjlzheng@gmail.com>)
 id 1ssvY2-0001an-Ry
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 22:45:08 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e1a80979028so4957771276.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727145905; x=1727750705; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Go996ja8pnME94dYqTEfeEJM1TlbQCtq2FuhI7Uc1PM=;
 b=hBejaqU6KSWFXuiBs/yVJ9jDMUDiYfp2So8TjTHf302KJQ8Z4Rvje7DwQf5ze+cWGV
 gddcWUt33p8wk0PP9cez4YKvs57YFVyHj0tz3WBr0PyFYVLt8FDhbj6NiwrvYUZd6v85
 16J9wEDXskr9LsI7u/MljzUTyG8oHV5Jmj8wnbeewN3MhffKCe9SgYdjXYDHA9Yuy/2R
 s2i7xQyA+ahg/a0FP3NVGux+OjGQADrUvlpb2oZ829sdpaF1D1tWqpZWhd8WkELH/1A8
 KPnPlJiQ/Bn+gn79y4/r5/LgGdvXuDIomUQbBrPvH4Wp/wxX1pdxqroZTO3jevavRfIy
 +dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727145905; x=1727750705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Go996ja8pnME94dYqTEfeEJM1TlbQCtq2FuhI7Uc1PM=;
 b=E2Vq0XhuuYSfPQqcf2SChRZ6k98GQ1PEoeJULrBKKoUoaNrqR+ZLN1RhawsF+A91EH
 omougGoSW9VE4Z+2N6gWBTvS3T+LC66KvvASte3FXWAtolsa7C+OOHbctA4d4Uyvrica
 UVmPv+UgOElwQkxULBk784OfxKTo7cyEgNGpCqLpQoehgRmlUKeFxc1ZLuXEMkwPegDU
 GNUC/38MCpqgNyl+8PGV6KQ90urmEcyoKQR3FnguhsLpLnDhHUobzTMb5bqaNmQQQ9v9
 A/2P0WZXz9SB4VOF2gk2rZgc/yDW3yJHjsUHl7NlBWhwLwiuKV/WeFrPZgO2jvGosWoS
 NTug==
X-Gm-Message-State: AOJu0YwQToR5680mNWkJsMLncXTJlLWjM1k+haWe5gRHje1oo8WdH2os
 +XaM78yOH8yhAEWctjuVkYsmISTuqitQ2SBDiypVkQ/E29VOuEnHp9BL9yqTMN00kQo3cr1auyL
 gLCYm6nLPOy2v33NwX2ICsAAUHauVgQ==
X-Google-Smtp-Source: AGHT+IHjr1f60UbjdJBwB9IA6nzrcXABlT+CfC2gj+gxSEEH9bAMTIhiYf5asfI745j4um/JKZjvnSB+mnl2Yno0/A8=
X-Received: by 2002:a05:6902:e0a:b0:e20:2031:c86e with SMTP id
 3f1490d57ef6-e2250ccd4b9mr9832703276.38.1727145904968; Mon, 23 Sep 2024
 19:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240915145339.1368029-1-alexjlzheng@tencent.com>
In-Reply-To: <20240915145339.1368029-1-alexjlzheng@tencent.com>
From: Jinliang Zheng <alexjlzheng@gmail.com>
Date: Tue, 24 Sep 2024 10:44:53 +0800
Message-ID: <CAHwU0gC-Kna-eJzBaqfe2nzft_iy4rd7FR+evdqJgBBORz3hVA@mail.gmail.com>
Subject: Re: [PATCH] qom: fix NULL pointer in object_initialize_with_type()
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net
Cc: qemu-devel@nongnu.org, Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=alexjlzheng@gmail.com; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

<alexjlzheng@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8815=E6=97=A5=E5=91=
=A8=E6=97=A5 22:53=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> Currently, object_initialize_with_type() calls object_class_property_init=
_all()
> before initializing Object->properties. This may cause Object->properties=
 to
> still be NULL when we call object_property_add() on Object.
>
> For exmaple, if we extend DEFINE_PROP_ARRAY() to a version with a default=
 value
> other than 0:
>         #define DEFINE_PROP_ARRAY_EXAMPLE(_name, _state, _field,        \
>                                 _arrayfield, _arrayprop, _arraytype)    \
>                 DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),              \
>                         _state, _field, qdev_prop_arraylen_virtio_net,  \
>                         uint32_t,                                       \
>                         .set_default =3D true,                           =
 \
>                         .defval.u =3D <non-zero>,                        =
 \
>                         .arrayinfo =3D &(_arrayprop),                    =
 \
>                         .arrayfieldsize =3D sizeof(_arraytype),          =
 \
>                         .arrayoffset =3D offsetof(_state, _arrayfield))
> We should have:
>         object_initialize_with_type
>           object_class_property_init_all
>             ObjectProperty->init() / object_property_init_defval
>               ...
>                 set_prop_arraylen
>                   object_property_add
>                     object_property_try_add
>                       g_hash_table_insert(Object->properties)   <- NULL
>           obj->properties =3D g_hash_table_new_full()             <- init=
ializing
>
> This patch fixes the above problem by exchanging the order of Ojbect->pro=
perties
> initialization and object_class_property_init_all().
>
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 157a45c5f8..734b52f048 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -556,9 +556,9 @@ static void object_initialize_with_type(Object *obj, =
size_t size, TypeImpl *type
>      memset(obj, 0, type->instance_size);
>      obj->class =3D type->class;
>      object_ref(obj);
> -    object_class_property_init_all(obj);
>      obj->properties =3D g_hash_table_new_full(g_str_hash, g_str_equal,
>                                              NULL, object_property_free);
> +    object_class_property_init_all(obj);
>      object_init_with_type(obj, type);
>      object_post_init_with_type(obj, type);
>  }
> --
> 2.41.1
>

