Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEABC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEUzG-0003Se-CN; Mon, 12 May 2025 11:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEUzE-0003SI-Hi
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEUzC-0005KM-9h
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747063353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fDbveoy634fX30HQGWyRUGP5YagE3FENcZZx4UjSE4=;
 b=Bf6jcUby7njrVX8s/a01LBYJ9k/WsQZHoCAyFPBt5DBT0Ar2uBS6oRCkCILQF5DZTzetPy
 dE86pgwQdOQ0bnO13EqMMPJ6WiHXNBs8m2C6UHtYS+weFeQdwmiW2BjkQeg+lOHjR1ic/f
 z5tZDyFlzn3+sWDMcA8sG2Vivqc8RZw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-aDKC2IcpNW-WvCNjhFnT9g-1; Mon, 12 May 2025 11:22:32 -0400
X-MC-Unique: aDKC2IcpNW-WvCNjhFnT9g-1
X-Mimecast-MFC-AGG-ID: aDKC2IcpNW-WvCNjhFnT9g_1747063351
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso33414615e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747063351; x=1747668151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fDbveoy634fX30HQGWyRUGP5YagE3FENcZZx4UjSE4=;
 b=in/LguBv+t5OWwEel8pcsw/gsYjxQFf+8hHMr1/vAFqYn4229rHWAy0N8WAS7jjG7d
 77YzunN/dWPYzvUTEOAiQN+RL/9fcLTWZfugKJWNlIvYUld42NRQA3Zxgg2wPTO/6wa5
 2eSZ04apaDyLczEYRak6kdulfzUJxWhP/WVFNSM6JIhZVqVGSj2FEd0kqjZgMFhg3FOE
 W2Ekf4Zhgdvl/rHUHO3m0vo9tTi2rm07yZ892Dcsl47nAvK+tWawuVU8wR4p0Qt114Qy
 I6qE0CF/b6fSgA59UhTSg4+v+ozouAG1K90t3sLlmsrth/gCnhkDXYG297cfTwr6SA1u
 UuAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdJy/m4nkYP4me1YulTROVL3sVXFhR+8Em8Lz9LY/UwJPUurJWxFbVycNRcYOxpdhYhioGSEJha2B7@nongnu.org
X-Gm-Message-State: AOJu0YyiZqYYaod4pEiXMDWU7zyn0+Ukd7sxYusy6H+P54fyMyN8KuYI
 dp/5rxTXGVWUA+J9aCgzqerwl0IihrjkFRLg3vKMhQe6eQ98LFUGD1joV/79EAbyBnO+YhDbhwA
 VI9f4Ntjn2XUsfR2i35CG+0JAq+fj0NCusTMIWF9cxKdEQMbxKdDP
X-Gm-Gg: ASbGncsM16OmXnvbzf8uET5TGkIU6xAotxWac+a8DF9Hb1LboG8ejPvaCQsZdyvqeWk
 RYz6KT8G1fX4PUbPtFSjKjIAC7h21fUTyGdDYVrhnvTh6xHk5E06+oKqJmWaRiKN3c7kUi9gYUO
 ME8czazozTR2j6Vy7/++Qb9zPGJ6zOu36w1OrM587iU5v9yPBpFYCOEpbhFA/ISBZKeX8jZ6BI/
 MB2qtl7eAuokMfSD2TC3sxJNiqiWnyc/f3lcFJdHk25Y3k86lGtqWakqhQBtj/S2G1LFSGvSJE2
 +VXAalQf2HJm1pWwaeHID1L0ZqytS5Ki
X-Received: by 2002:a5d:64cb:0:b0:3a2:56f:e931 with SMTP id
 ffacd0b85a97d-3a2056fea7bmr4650592f8f.19.1747063351072; 
 Mon, 12 May 2025 08:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpfuYUF3ZtquPfDbtUbsIXdvtVrYdxS4GjvinNAdEoeVjZYWPtRk7OTMzvGsodv9XiY0XPiA==
X-Received: by 2002:a5d:64cb:0:b0:3a2:56f:e931 with SMTP id
 ffacd0b85a97d-3a2056fea7bmr4650532f8f.19.1747063350573; 
 Mon, 12 May 2025 08:22:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67ed1bcsm127891875e9.18.2025.05.12.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 08:22:30 -0700 (PDT)
Date: Mon, 12 May 2025 17:22:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Zhao
 Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, kvm@vger.kernel.org, Gerd Hoffmann
 <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, qemu-arm@nongnu.org, =?UTF-8?B?TWFy?=
 =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
Message-ID: <20250512172226.433900f8@imammedo.users.ipa.redhat.com>
In-Reply-To: <87jz6mqeu5.fsf@pond.sub.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 12 May 2025 12:54:26 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Mon, May 12, 2025 at 09:46:30AM +0100, Peter Maydell wrote: =20
> >> On Fri, 9 May 2025 at 11:04, Thomas Huth <thuth@redhat.com> wrote: =20
> >> > Thanks for your clarifications, Zhao! But I think this shows again t=
he
> >> > problem that we have hit a couple of times in the past already: Prop=
erties
> >> > are currently used for both, config knobs for the users and internal
> >> > switches for configuration of the machine. We lack a proper way to s=
ay "this
> >> > property is usable for the user" and "this property is meant for int=
ernal
> >> > configuration only".
> >> >
> >> > I wonder whether we could maybe come up with a naming scheme to bett=
er
> >> > distinguish the two sets, e.g. by using a prefix similar to the "x-"=
 prefix
> >> > for experimental properties? We could e.g. say that all properties s=
tarting
> >> > with a "q-" are meant for QEMU-internal configuration only or someth=
ing
> >> > similar (and maybe even hide those from the default help output when=
 running
> >> > "-device xyz,help" ?)? Anybody any opinions or better ideas on this?=
 =20
> >>=20
> >> I think a q-prefix is potentially a bit clunky unless we also have
> >> infrastructure to say eg DEFINE_INTERNAL_PROP_BOOL("foo", ...)
> >> and have it auto-add the prefix, and to have the C APIs for
> >> setting properties search for both "foo" and "q-foo" so you
> >> don't have to write qdev_prop_set_bit(dev, "q-foo", ...). =20
>=20
> If we make intent explicit with DEFINE_INTERNAL_PROP_FOO(), is repeating
> intent in the name useful?

While we are inventing a new API, I'd say that _INTERNAL_ is not the only t=
hing
on my wish-list wrt properties.
It would be also nice to know when a property is set by internal or externa=
l user
or if it still has default value.

Basically we are looking at different flags for properties and INERNAL being
one of them.

Maybe instead of specialized macro, we should have a more generic
   DEFINE_PROP_WITH_FLAGS_FOO(...,flags)
So we won't have to rewrite it again when we think of another flag to turn =
on/off.


=46rom previous uses of x- flag, some of such properties are created as
temporary | developer-only and occasionally as a crutch (still no intended =
for end user).
But then sometimes such properties get promoted to ABI with fat warnings
not to touch them. Having stable|unstable flag could help here without
need to rename property (and prevent breaking users who (ab)used it if we c=
are).


