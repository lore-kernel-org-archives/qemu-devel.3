Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026EDC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIm6-0005Vx-QU; Wed, 29 May 2024 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCIm4-0005VM-1r
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCIlq-00084Q-Vb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716987068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq72rFv/+nztBx0v343vSYFPzl75WogeWX20Ado6ZGc=;
 b=DeF/DK59UHWkf31WgiRgSmoEyLEZ+JtglXQDSTlQc4rkNNv+IoPsQptMyuztZR9cvN//c4
 93+KApZpUyNVCWwNuG8vNHmNLX0glc7zk1J3fTTHt4Ir8F92PVlVR/Pr4aTP8o4kp5scAW
 REMb51/o0TARy85U0/ySlXZggIDMWkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-e_OaabaVO3Os1cHWkFJbNg-1; Wed, 29 May 2024 08:51:06 -0400
X-MC-Unique: e_OaabaVO3Os1cHWkFJbNg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35508103145so1630435f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 05:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716987066; x=1717591866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vq72rFv/+nztBx0v343vSYFPzl75WogeWX20Ado6ZGc=;
 b=YzOSQHn7FPsd3VkTM8paPewBz7jRkJzHae6suDmP6Kxi9Euq+2r1RZNMKCiKkcvJ9x
 UOrIx9NIL6WEKnDElZU9hFvVl3Iv5W2PSsezrPVxtUMPSn7wxY3NREpjbVwCqgruUO8L
 3l5rGerBSX7HcrKfpbweWc4f+rsnNYpeGzFpx910L7HVtdgrzL/rx6APhpdv59M58QQe
 AFkEwJH6j2B1yVJgYArEUojamii/fI4Jcjv3/Ba/85uEQHcrNcx1zaGZBBoUNPKdWAVq
 C4t48aUirjJeraVvK9NCsbK5MxzL2adliQBigk+DMaXzFvH0VjokCk8OKC2ERECfIATy
 dzsw==
X-Gm-Message-State: AOJu0YyrPJvI46oyArGTSyJ0AZbmN5eI6OnCs6F/Yu6SvXfYBDW/Ev3O
 w19Wdhj/CmumrL3Q5KVsSGyjQIFHtKerb9H8MUV6JriGhOh1mk0x9o8ybZvJmbCm3RpWfb/vHJm
 2Ps9r2r3Px1QK9shWn48stAgJpwFUcp1Qo+2p23kFbp8e2oIE5hZp
X-Received: by 2002:adf:ea8e:0:b0:346:bc1b:4e7c with SMTP id
 ffacd0b85a97d-3552fda821fmr12786277f8f.35.1716987065832; 
 Wed, 29 May 2024 05:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTkl5Li04LvWzN4qOa2bq5hdeAFVr2TpGwmYOJ/NP0oFSu8WGcM1GjGDa5DkHoZ7XivVPhYg==
X-Received: by 2002:adf:ea8e:0:b0:346:bc1b:4e7c with SMTP id
 ffacd0b85a97d-3552fda821fmr12786254f8f.35.1716987065361; 
 Wed, 29 May 2024 05:51:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421088f9d3csm180431595e9.0.2024.05.29.05.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 05:51:04 -0700 (PDT)
Date: Wed, 29 May 2024 14:51:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 01/23] hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx
 machines
Message-ID: <20240529145104.3955ba82@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-2-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 29 May 2024 07:15:17 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Similarly to the commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated",
> deprecate the 2.4 to 2.12 machines.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/about/deprecated.rst | 4 ++--
>  hw/i386/pc_piix.c         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 40585ca7d5..7ff52bdd8e 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -228,8 +228,8 @@ deprecated; use the new name ``dtb-randomness`` inste=
ad. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
> =20
> -``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.=
4`` up to ``pc-i440fx-2.12`` (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''''''''
> =20
>  These old machine types are quite neglected nowadays and thus might have
>  various pitfalls with regards to live migration. Use a newer machine type
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ebb51de380..02878060d0 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -742,6 +742,7 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
>  {
>      pc_i440fx_3_0_machine_options(m);
> +    m->deprecation_reason =3D "old and unattended - use a newer version =
instead";
>      compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len=
);
>      compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len=
);
>  }
> @@ -847,7 +848,6 @@ static void pc_i440fx_2_3_machine_options(MachineClas=
s *m)
>  {
>      pc_i440fx_2_4_machine_options(m);
>      m->hw_version =3D "2.3.0";
> -    m->deprecation_reason =3D "old and unattended - use a newer version =
instead";
>      compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
>      compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
>  }


