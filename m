Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA2C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2NM-0007sO-Ok; Mon, 02 Jun 2025 06:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uM2NK-0007rf-Up
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uM2NJ-0006Op-Et
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748859996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjUTSvOng+W7JEAyCf/KH/itZzV9YwnTBi8GIOhN5NY=;
 b=IVHFRfJ40z4OR89MwBIpmstx6+dSvxHymfGVv5KJzWm/A5eLdN72VktxN9rRoSFk61U+fV
 x1uZ1ZJ/Rq7AXDJYiSysyQ8k0k5a0JkiqM9lHgGa0WHhcZGe7YdOk5a1VNCkoGryKUqhd6
 gd7wl5wfiwOx7/SNxU+pUS4OTNajjmE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-CQPuJi1XO9OB4eAe5LAKtw-1; Mon, 02 Jun 2025 06:26:33 -0400
X-MC-Unique: CQPuJi1XO9OB4eAe5LAKtw-1
X-Mimecast-MFC-AGG-ID: CQPuJi1XO9OB4eAe5LAKtw_1748859992
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2068197f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 03:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748859992; x=1749464792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjUTSvOng+W7JEAyCf/KH/itZzV9YwnTBi8GIOhN5NY=;
 b=URsLJy+yuDk+jhsIsviOmr9Kw7S99zq1Kz4vyAfJ34ynzxA0r09PS3SO0Cj6pSuHUH
 sNU3hUNDaSRyARPi3dAl6iynsdJG+brOo+uQyvJaI91qC3hCB1oEr314WWLnAPATyhP2
 W18VhrvBG0IcXHy5eundoVhfLvadDsh/ZlyekGgfrwcg2tAe0u2v3mJIBp45mqQvH3GR
 vHNwMamrbj9TaXiDs6tNKZ3XQpqm41z6hHbdd4I8w6M1Y7D/IB0uLvEV9Fzsmi07aU1j
 AHESYWqd2zdPzOGD1n18pIe7/iKXlxwbW5iA7j0JLGJRI4uV5SoSctxa48F+JNokGF8W
 M2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzAqm+LZoSK0rMhG6g/TZYXfJP4q8h4AGZeXhkYguY6ugcCfANCpHvVtDosEbQpDTFgPP/1Ulb2XBF@nongnu.org
X-Gm-Message-State: AOJu0YxLZaREUgdcQJ8DTFhbaPlxJwhBLtz3UuHxywaMH4+yMpS5DToI
 AjYAXSwv4aTOFDd7C+TW3npyZR0IRoKZoF/CKWvIp1mzDfnB5Iy1irkXO325kyF7IqMjtOGvXHK
 A6VMcynW2lzGNaWpl8XxzsJlYUwVMJJ/nxITN03rMzvRkkAz/FV65HWRB
X-Gm-Gg: ASbGncsWhPn5Zw8xvJA8cRZa983ATBb50YDsp+OMu+fyBbVMDRl+mRfxDxfjlM5k+bc
 LYkIk6OP+o8YrIH9+IYQbQVEGvDff4kUiq4vKx9VdeyvxoQV5uJafg8jbD4nGKxVK1+hy8ChrQu
 8KXLA2S0Lw0gRusJi70eFwYbRjDmZBJ1WElEKS7wE3YSmvY90bJJiQ0grjBYCp28yJ689UXtY4o
 xFbNVx6YpvEELGaApV07cbMnQ5sLj37rG7V3tV/WNNdaTHxTaSB6K5S4gljxUmYK6/BeXC2+08g
 C2fOis0bwji77yhjZyG7M6gL7v1TeBFS
X-Received: by 2002:adf:eed2:0:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3a4f89a47dfmr7990732f8f.10.1748859992271; 
 Mon, 02 Jun 2025 03:26:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqfnK734UaQP4TQvGO+uFhkNUwUhX1mcxR/v3N9c0C0yY3xZbMEl/zvBP9EavzY06cA2KKrA==
X-Received: by 2002:adf:eed2:0:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3a4f89a47dfmr7990708f8f.10.1748859991844; 
 Mon, 02 Jun 2025 03:26:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006ff8sm116094735e9.34.2025.06.02.03.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 03:26:31 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:26:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, kvm@vger.kernel.org, Sergio Lopez
 <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, qemu-arm@nongnu.org, =?UTF-8?B?TWFy?=
 =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v4 01/27] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Message-ID: <20250602122630.2d28a9b8@imammedo.users.ipa.redhat.com>
In-Reply-To: <c2999ee1-c0a1-4a09-85f8-6c10ede14584@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-2-philmd@linaro.org>
 <20250509172336.6e73884f@imammedo.users.ipa.redhat.com>
 <91c4bf9f-3079-4e2f-9fbb-e1a2a9c56c7b@redhat.com>
 <c2999ee1-c0a1-4a09-85f8-6c10ede14584@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 2 Jun 2025 10:53:19 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 2/6/25 08:13, Thomas Huth wrote:
> > On 09/05/2025 17.23, Igor Mammedov wrote: =20
> >> On Thu,=C2=A0 8 May 2025 15:35:24 +0200
> >> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >> =20
> >>> These machines has been supported for a period of more than 6 years.
> >>> According to our versioned machine support policy (see commit
> >>> ce80c4fa6ff "docs: document special exception for machine type
> >>> deprecation & removal") they can now be removed. =20
> >>
> >> if these machine types are the last users of compat arrays,
> >> it's better to remove array at the same time, aka squash
> >> those patches later in series into this one.
> >> That leaves no illusion that compats could be used in the later patche=
s. =20
> >=20
> > IMHO the generic hw_compat array should be treated separately since thi=
s=20
> > is independent from x86. So in case someone ever needs to backport thes=
e=20
> > patches to an older branch, they can decide more easily whether they=20
> > want to apply the generic hw_compat part or only the x86-specific part=
=20
> > of this series. =20
>=20
> Yes, it is clearer this way than squashed.

ok, let's leave it as is.

>=20


