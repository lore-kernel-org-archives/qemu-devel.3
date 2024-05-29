Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF38C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKDW-0001jW-SM; Wed, 29 May 2024 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKDR-0001iU-U8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKDP-0000GO-Gf
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716992622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLHSSzEkKQa//WnfxsNbDnkLzcKOi8i3sxjHdngeMlM=;
 b=Rg5T+S+u1wDNDV2MRpSn7mnq13SfeBTSOlrYp3En9t7Uw2C7RDt2TrxGeJi+5Dg/JnjuMf
 xImtCjEbpt5rx7297hMr0FYS0iUCyAfEwF2rOwDS4fgP/X08bfxKfbSBq1JlTwlQ7TlbJQ
 u9v7sYtjOQvrOMrTtGvvLdLVdFIj/Rs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-eb1KHFJ5M9ih8w0cS22_vg-1; Wed, 29 May 2024 10:23:40 -0400
X-MC-Unique: eb1KHFJ5M9ih8w0cS22_vg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42109a85f5cso18398655e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716992619; x=1717597419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLHSSzEkKQa//WnfxsNbDnkLzcKOi8i3sxjHdngeMlM=;
 b=oMcrVZ3N8jhl+CXSXCgXTLZSDv4Zl49H2WRa9nu9jgP6taTeN9nyW5D4ttdZqwwqqT
 iC0lFtkFGTQw5jRQFNBYYOfaFii1YbZ13e0EZf4VfHa0PcX+mB+46Uswhbbzk/Lczbl2
 2/e0cIbt8qhEITZcFekOVWa0730vpKRHJ7rzuhME3N727C4Xu5DnPst48d6GuCtjdU0N
 7aYwDMDfZ2EeggzjtYMtAZEe6+sQ/bXulWAryR3qqk1dcTn+ILc8gnGIjKx7S9wW7aaD
 c/vjkD2Jq3qrrT/xarenOko9ufGmwtcvNTnyBDdPexhSkJYnBKNXFzrzDAi56Mgn3WNX
 u8Sw==
X-Gm-Message-State: AOJu0Yxm6zIzKZJrsphEYjqpxdFEvt+4ocFzCuheO0W1XRHxaTDd/QHG
 a6ad3RGjjPstBDl3wzvTy5kYNE1eQxEajwLn0tUiYD/9m4gix8rryHhe4sH+X8+8xFaJ6NM2lDf
 LwDpCbGsUHXUsuDXnERBGzwDa1Q0y24kl5g6a62ncSqA38egAFRcA
X-Received: by 2002:a05:600c:1c02:b0:41c:23f3:65fa with SMTP id
 5b1f17b1804b1-42108a99cf6mr136990335e9.28.1716992619297; 
 Wed, 29 May 2024 07:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSZIJ/YrdZ0udBcnHuMu/JDcyXye8rX7FpnecL+2/+ckU7F8Xf8ijE+17MK5hmnLNV/ySg4g==
X-Received: by 2002:a05:600c:1c02:b0:41c:23f3:65fa with SMTP id
 5b1f17b1804b1-42108a99cf6mr136990015e9.28.1716992618875; 
 Wed, 29 May 2024 07:23:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210896676bsm183917165e9.4.2024.05.29.07.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:23:38 -0700 (PDT)
Date: Wed, 29 May 2024 16:23:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 09/23] target/i386/kvm: Remove
 x86_cpu_change_kvm_default() and 'kvm-cpu.h'
Message-ID: <20240529162337.30755055@imammedo.users.ipa.redhat.com>
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


