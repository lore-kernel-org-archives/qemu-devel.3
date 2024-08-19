Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52362C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4Ml-00086s-HY; Mon, 19 Aug 2024 11:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg4Mk-00086N-Mp
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg4Mj-0002MD-4X
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724081535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozxUPVSJI6kso7t+QsOJshko8hZwmEb+We/ntxe7yb0=;
 b=ieXwifA85xNqRwx5zioPNn8PY3SXNCDIma63kHlSCb6zFJzXiZIk66EdvXcFWD8SI+ajif
 /gTZuYNEFX0gg84p96eGBfcfygs6rDo0wUyQ1frVrnbxAK35BD5U/6w1Nx5OOzSGlxY9OX
 8r9pPUcjvaTPDEKXx9ist3XT4iJs4Bk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-a7N0bDtiMDO6l804beWa5w-1; Mon, 19 Aug 2024 11:32:13 -0400
X-MC-Unique: a7N0bDtiMDO6l804beWa5w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427ffa0c9c7so49373415e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 08:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724081533; x=1724686333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozxUPVSJI6kso7t+QsOJshko8hZwmEb+We/ntxe7yb0=;
 b=tukeHY7MSLRsl9XJ8aQncmmJY8EfAyWLjW8DmsvCAxtcaASWEBi2lrQWOUjkltfbdn
 98xdyISYL3EED1b7xxvxkxE7itpjN8guLXpE6OF4A7Kcu4u89k6WD1VvR21qWXkqKVgS
 NkLL2tpr0+3uWUeH3ybrKMw1lcK6MNDmHf7oCmBgniFFOMo9KdSAgYZk/FW0+cYDxms0
 LaYcTtFjjFU2rbRu6ZwGki7ooudxbYStyA7r5tqS46jsjxUJWjW8rvusl3SCj7Su3PkI
 4dReSJmYVPO5gEbNQ5TVf/wVUytbyW03q5C0gCuPoKQOXca6VA4R8txvBau544jLwZlL
 2AWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6coXJdYXA9ZdpcMt2WtxK1/3XpJvnvhO4vSfj0ZydnIkJZPBQC5jtEHeOFKwZXEHu0HYLaNozNyEBIbixpxXJEPKrzag=
X-Gm-Message-State: AOJu0Yw3vftspgEu+v9qoYwA0fW6kiuyzqmQHN0no6pZgelMNitfF6YK
 wQLxFmn0XnMNxHAsUzgRYiwBwCbFJ4b5YT5q8geY6N49cY7IAxSeaepsiELvRzm4XjEGP1ZTzKr
 NRsgzD2eZbICGkwm6WBisa8gwBIbEbq7CjJwb2DVCYu2unvIQJebk
X-Received: by 2002:a05:600c:4584:b0:428:e820:37b6 with SMTP id
 5b1f17b1804b1-429ed7ed57emr101663945e9.31.1724081532667; 
 Mon, 19 Aug 2024 08:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjJOVz81cDAWeYCRV7PLYOVDP2aNnS/w1vJD/KxzLitEulR2NEIOYvqqOKNzO3RWG2Lnjmog==
X-Received: by 2002:a05:600c:4584:b0:428:e820:37b6 with SMTP id
 5b1f17b1804b1-429ed7ed57emr101663645e9.31.1724081532143; 
 Mon, 19 Aug 2024 08:32:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed649019sm114501175e9.8.2024.08.19.08.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:32:11 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:32:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, zhao1.liu@intel.com, John
 Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>
Subject: Re: [PATCH v2] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <20240819173210.7db4ca33@imammedo.users.ipa.redhat.com>
In-Reply-To: <985da2cc-5281-4986-b1bb-0334179ece6d@intel.com>
References: <20240813033145.279307-1-xiaoyao.li@intel.com>
 <20240813112734.6b2394b9@imammedo.users.ipa.redhat.com>
 <13ab0652-8223-4c04-be63-09a7a81467af@intel.com>
 <985da2cc-5281-4986-b1bb-0334179ece6d@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 14 Aug 2024 00:39:57 +0800
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 8/13/2024 10:51 PM, Xiaoyao Li wrote:
> > On 8/13/2024 5:27 PM, Igor Mammedov wrote: =20
> >> On Mon, 12 Aug 2024 23:31:45 -0400
> >> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> >> =20
> >>> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> >>> when topology level that cannot be enumerated by leaf 0xB, e.g., die =
or
> >>> module level, are configured for the guest, e.g., -smp xx,dies=3D2.
> >>>
> >>> However, 1) TDX architecture forces to require CPUID 0x1f to=20
> >>> configure CPU
> >>> topology. and 2) There is a bug in Windows that Windows 10/11 expects=
=20
> >>> valid
> >>> 0x1f leafs when the maximum basic leaf > 0x1f[1]. =20
> >> =C2=A0 1. will it boot if you use older cpu model? =20
> >=20
> > It can boot with any cpu model that has .level < 0x1f. =20
>=20
> I realize just now that we don't need to introduce "x-cpuid-1f" as the=20
> workaround for buggy windows. We can always workaround it by limiting=20
> the maximum basic CPUID leaf to less than 0x1f, i.e., -cpu xxx,level=3D0x=
1e

I'd suggest to add this to change log into 'known issues' section.
(I mean Windows bug symptoms and suggested workaround) =20

>=20
> I think we can ignore this patch for now. I will re-submit it with TDX=20
> enabling series, and with "x-cpuid-1f" interface removed.
>=20
> >> =C2=A0 2. how user would know that this option would be needed? =20
> >=20
> > Honestly, I don't have an answer for it.
> >=20
> > I'm not sure if it is the duty of QEMU to identify this case and print=
=20
> > some hint to user. It's the bug of Windows, maybe Mircosoft should put=
=20
> > something in their known bugs list for users?
I guess you've answered your own question alredy we have a workaround
and there is not need for yet another option that user won't know how to us=
e.

As for configuring workaround, it's upto upper layers which know what OS
would be running in VM. =20


