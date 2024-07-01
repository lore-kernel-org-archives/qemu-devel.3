Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86655C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCkR-0003q5-7i; Mon, 01 Jul 2024 04:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOCiW-0002rN-J7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOCiU-0004y8-3p
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719823731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGULnVzcpI8jzaIWqxlHtEMGdelK1jaDjxgMatjjCug=;
 b=aG80VNZBsGVQ20fKuV0VsnSrvyfizSx+P73sP0DmbeGtGUIsPJYhbLy46e4MBvmmNO8KI8
 kwdvO3H+OGZGpFyAd5RSNh54O1RGiRYRpgJBK8EHrilS3s2n1EoRnaM5XNoRW65Z3qTTXl
 vVB9awUj2Z0O487IemMmnAOEKrXJ4M8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-EXS8meMKOK64XdqAhBKyDA-1; Mon, 01 Jul 2024 04:48:49 -0400
X-MC-Unique: EXS8meMKOK64XdqAhBKyDA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4256849a9f4so19954925e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719823728; x=1720428528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGULnVzcpI8jzaIWqxlHtEMGdelK1jaDjxgMatjjCug=;
 b=UmOOYzJwr12KaEtNYotVdKNNuU7mVNEtsQ0tLvSQr4mLaiDLYMCHKUuAXtKxLZPfFq
 W0Tz7gykC5wvLnSWiCp0Q5Gcud5P4Rr6DNnmUSXCcSGbwJ0R3GDYbuAq4JRiwjJsusyi
 BR3/uYzZE9RktetGGQfCcxYvvkVb3Ew912stpqdlqS1oMdQiMTqWU8nLgVhmz3xsNZJj
 3sfjnKP2Coqucy3s3GHe2I6GgAk+faBQq2w+/1mWVCZ3bPz3sLgJmYGxWWETHzmyzi3z
 Hxdji0X7qwRzp+s932ALIXTy0zBbJb2ZrfYxMRNtABsojRHNOgoKaeQcFeH5DqkLJ23l
 aVvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzGA3pU4UfRPPD9Pv0S+fED6soSSu7Jlu1d3RQ+/AjIP67vZ0ChVUGIAwImbDsYa2dCXkHP9j0Y4KQswxSSE3mGEo0Ptk=
X-Gm-Message-State: AOJu0YxhMO8wO9hAU7X8InWhVZmx9LTPoJqSS7n3BQK7KkbYuUbx/8F7
 GTFtGGv1VtvrGZPonwVBFg8AVauyoytkYCs4jT/7k0zNwBNeUf9OZSir9YxipHMI6FkoBxt7Lef
 rziS2wNHslw8CqrDNzIsPn9La6DW3FqZnHcjvO6jjdFUaiGk6Nre4
X-Received: by 2002:adf:ea4d:0:b0:362:ed39:c1e6 with SMTP id
 ffacd0b85a97d-36775730a4amr3370359f8f.62.1719823728424; 
 Mon, 01 Jul 2024 01:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGjbb5teUwdhZ8fxa8+Jw6l9rJiXiTDZ1/IrUhl6v8jIbYiTmFaxe+/BVQCUeeMuLClAuprQ==
X-Received: by 2002:adf:ea4d:0:b0:362:ed39:c1e6 with SMTP id
 ffacd0b85a97d-36775730a4amr3370333f8f.62.1719823728038; 
 Mon, 01 Jul 2024 01:48:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d90casm9318235f8f.32.2024.07.01.01.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 01:48:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:48:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V12 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240701104844.32e0207b@imammedo.users.ipa.redhat.com>
In-Reply-To: <eb5880984ddf41aabca9d036e7ad445f@huawei.com>
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240602180241-mutt-send-email-mst@kernel.org>
 <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
 <CAJ7pxeYehVhPWfbEqRMMSCVHk31JQhtQhRSM_4e1WqBhqv0UHQ@mail.gmail.com>
 <b36e0d64-9653-4d48-b72a-00a1aee86629@redhat.com>
 <eb5880984ddf41aabca9d036e7ad445f@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 26 Jun 2024 17:53:52 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Gavin,
>=20
> >  From: Gavin Shan <gshan@redhat.com>
> >  Sent: Wednesday, June 26, 2024 5:13 AM
> >  To: Salil Mehta <salil.mehta@opnsrc.net>; Igor Mammedov
> >  <imammedo@redhat.com>
> > =20
> >  Hi Salil and Igor,
> > =20
> >  On 6/26/24 9:51 AM, Salil Mehta wrote: =20
> >  > On Wed, Jun 5, 2024 at 3:03=E2=80=AFPM Igor Mammedov =20
> >  <imammedo@redhat.com <mailto:imammedo@redhat.com>> wrote: =20
> >  >     On Sun, 2 Jun 2024 18:03:05 -0400
> >  >     "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> =20
> >  wrote: =20
> >  > =20
> >  >      > On Thu, May 30, 2024 at 12:42:33AM +0100, Salil Mehta wrote: =
=20
> >  >      > > Virtual CPU hotplug support is being added across various a=
rchitectures[1][3].
> >  >      > > This series adds various code bits common across all archit=
ectures:
> >  >      > >
> >  >      > > 1. vCPU creation and Parking code refactor [Patch 1]
> >  >      > > 2. Update ACPI GED framework to support vCPU Hotplug [Patch=
 2,3]
> >  >      > > 3. ACPI CPUs AML code change [Patch 4,5]
> >  >      > > 4. Helper functions to support unrealization of CPU objects=
 [Patch  6,7]
> >  >      > > 5. Docs [Patch 8]
> >  >      > >
> >  >      > >
> >  >      > > Repository:
> >  >      > >
> >  >      > > [*] https://github.com/salil-mehta/qemu.git   <https://gith=
ub.com/salil-mehta/qemu.git> virt-cpuhp-armv8/rfc- v3.arch.agnostic.v12
> >  >      > >
> >  >      > > NOTE: This series is meant to work in conjunction with Arch=
itecture specific patch-set.
> >  >      > > For ARM, this will work in combination of the architecture =
specific part based on
> >  >      > > RFC V2 [1]. This architecture specific patch-set RFC V3 sha=
ll be floated soon and is
> >  >      > > present at below location
> >  >      > >
> >  >      > > [*] https://github.com/salil-mehta/qemu/tree/virt-cpuhp-arm=
v8/rfc-v3-rc1 <https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rf=
c-v3-rc1>
> >  >      > > =20
> >  >      >
> >  >      >
> >  >      > Igor plan to take a look? =20
> >  >
> >  >     Yep, I plan to review it
> >  >
> >  >
> >  > A gentle reminder on this.
> >  > =20
> > =20
> >  Since the latest revision for this series is v13, so I guess Igor need=
s to do the
> >  final screening on v13 instead?
> > =20
> >  v13: https://lists.nongnu.org/archive/html/qemu-arm/2024-06/msg00129.h=
tml =20
>=20
>=20
> Yes, thanks for pointing this. =F0=9F=98=8A

I have v13 tagged,
Sorry for delay, I'll try to review it this week

>=20
>=20
> > =20
> >  Thanks,
> >  Gavin
> >   =20
>=20


