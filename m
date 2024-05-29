Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15515C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCK8R-0006ps-7w; Wed, 29 May 2024 10:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCK8G-0006YL-FG
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCK8E-0007ia-9E
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716992299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLHSSzEkKQa//WnfxsNbDnkLzcKOi8i3sxjHdngeMlM=;
 b=GUCX0euqpjC84gORBtsiDEH7KnbjmUfkK6cfeo/IfubapSkFt5KeCccjypyn+yg3ynktLj
 3R/1kmp6j3M+iVhkC6Esn/n8jvrybiAP8545P7fkZvD/Bl7/aaDOiN9WdjRZFOzGallPLF
 FR+YnaVeMGvCVMcc/bblJpUeTIYg7Vk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-qW2gN7AwOEWOaU2ToXnEsg-1; Wed, 29 May 2024 10:18:17 -0400
X-MC-Unique: qW2gN7AwOEWOaU2ToXnEsg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95a1e65c2so18921591fa.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716992296; x=1717597096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLHSSzEkKQa//WnfxsNbDnkLzcKOi8i3sxjHdngeMlM=;
 b=MtZlbB0RfQusrl5iU0UL25ZJsdLgLcStnrcLMN6maD0e0B2T62SIgrixKGlG3cxxup
 oT0jNyk2LuPahnvURx4Z5ce3uB2A3DDzRpGtaCYuBXfgLpVhIuIw74JB3x/X25fzuRT/
 vnskrQ/NqSQxlninh3koHfjBAkXeSUNG44qj71Kou7tZrEk6NdpUmzThsiyYp4dZnY8d
 LQ0eqbqcX9GVLqy/gPzQHPRgxsfi/WfWJ+RFampN7LM3nZ0X3f7dxf/gf3CoMZaBR1fQ
 Nmf5nsOmK4BGuHoea9gWs9Zhz39HmN790xYZGgsNIaqHDmU07LAp/sMy+xr2WMc/ONBE
 nBGQ==
X-Gm-Message-State: AOJu0YzSoY5fAPPZUclYhqhKLYqRSfwoVBMW0UoB3ynxxiUD6WjaxyPJ
 d7x+bcAgJza+IpAQAwuzHHpOjVIJKMZJyIFSi26ehEzjdhCCXB0KEMocnxOByW/jjMuQhpTcuQl
 7gQ7OpEPSXdVqYd3jAb/n4KJRd7Ydqmz6ErDc2C3k/EqSUde0o7ap
X-Received: by 2002:a05:651c:1a12:b0:2ea:807e:2cb0 with SMTP id
 38308e7fff4ca-2ea807e2f74mr6260031fa.32.1716992296202; 
 Wed, 29 May 2024 07:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEKuM6yVMhFBGHGau3z6NGEksl3bZkEVueNnWfcLIJaAn68qui/GsRqSXiOOdX9w5FnasbZw==
X-Received: by 2002:a05:651c:1a12:b0:2ea:807e:2cb0 with SMTP id
 38308e7fff4ca-2ea807e2f74mr6259841fa.32.1716992295697; 
 Wed, 29 May 2024 07:18:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210896f442sm180709985e9.11.2024.05.29.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:18:15 -0700 (PDT)
Date: Wed, 29 May 2024 16:18:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 09/23] target/i386/kvm: Remove
 x86_cpu_change_kvm_default() and 'kvm-cpu.h'
Message-ID: <20240529161814.3091ea4f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-10-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-10-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 29 May 2024 07:15:25 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> x86_cpu_change_kvm_default() was only used out of kvm-cpu.c by
> the pc-i440fx-2.1 machine, which got removed. Make it static,
> and remove its declaration. "kvm-cpu.h" is now empty, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/kvm/kvm-cpu.h | 41 ---------------------------------------
>  target/i386/kvm/kvm-cpu.c |  3 +--
>  2 files changed, 1 insertion(+), 43 deletions(-)
>  delete mode 100644 target/i386/kvm/kvm-cpu.h
>=20
> diff --git a/target/i386/kvm/kvm-cpu.h b/target/i386/kvm/kvm-cpu.h
> deleted file mode 100644
> index e858ca21e5..0000000000
> --- a/target/i386/kvm/kvm-cpu.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - * i386 KVM CPU type and functions
> - *
> - *  Copyright (c) 2003 Fabrice Bellard
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> - */
> -
> -#ifndef KVM_CPU_H
> -#define KVM_CPU_H
> -
> -#ifdef CONFIG_KVM
> -/*
> - * Change the value of a KVM-specific default
> - *
> - * If value is NULL, no default will be set and the original
> - * value from the CPU model table will be kept.
> - *
> - * It is valid to call this function only for properties that
> - * are already present in the kvm_default_props table.
> - */
> -void x86_cpu_change_kvm_default(const char *prop, const char *value);
> -
> -#else /* !CONFIG_KVM */
> -
> -#define x86_cpu_change_kvm_default(a, b)
> -
> -#endif /* CONFIG_KVM */
> -
> -#endif /* KVM_CPU_H */
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index f76972e47e..f9b99b5f50 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -10,7 +10,6 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "host-cpu.h"
> -#include "kvm-cpu.h"
>  #include "qapi/error.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/boards.h"
> @@ -178,7 +177,7 @@ static PropValue kvm_default_props[] =3D {
>  /*
>   * Only for builtin_x86_defs models initialized with x86_register_cpudef=
_types.
>   */
> -void x86_cpu_change_kvm_default(const char *prop, const char *value)
> +static void x86_cpu_change_kvm_default(const char *prop, const char *val=
ue)
>  {
>      PropValue *pv;
>      for (pv =3D kvm_default_props; pv->prop; pv++) {


