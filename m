Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E04C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9ik-00030o-T3; Tue, 26 Mar 2024 12:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp9ij-0002zv-Ey
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp9ig-0004eM-Q1
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711470731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+2Hzor6IfRqz7tK7yeM0QBlJqC5jEiwaqlRvNFPuKg=;
 b=GbUCiZ+kNv0+VbA29NwTL6d8d/J2ncp5j4Q47p0K5R+9sk8TTfHCi0a26upP//4HikYiEZ
 IEcU3J0bLcQwwlor5eKdrB7l2OjYCqeiR8VRyr5rU8RAiItWZFX+0zSJ3RlIR9kn0gX2kV
 cmoMe4h0YWljpW4VQ/zj2L/fSbPq4zI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-mhwKiMwWOOyB75LzBQeiaA-1; Tue, 26 Mar 2024 12:32:09 -0400
X-MC-Unique: mhwKiMwWOOyB75LzBQeiaA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4140f58ac00so30207485e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711470728; x=1712075528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+2Hzor6IfRqz7tK7yeM0QBlJqC5jEiwaqlRvNFPuKg=;
 b=S3SHjLbNw/VcgACgudImaT1rUQVRjQ7PbqyL5QNP5BR9pxO3QPwzEdwRpuXM57NaPl
 85PoK4iIng/nV+f/vqEfLOE+boshLoRsRNnqkORUnfZKud3jYN0QZd8dhmwvwARGpHBz
 WBLNWRfLuvnKJEfeVNHtmkOT7u2z+k9jjvtFSNP6khZW6JaDsl8TtLhQ3cUN5VigzAdF
 GOixB8UPIiUnESiC2Fo2MpYVzzyxROGcKKqJ0B3hlzO2WZIh85rVvyOUtT6lxCHTTp8f
 JeI6ZoHjRWsgGlXWOjdl90mCOrUP9TPcoVZ1wXAIRCAKuVNEd4BBzGVCShPdduLkwzYd
 a1vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXotveHiRjiJ64fvbfs690uJIEcDCg60vjcIYzSIdkpO1pQ5EesPXAzj9D5iK6AHqUIFnl5QDXSTC0AgxujUvLQ1MKOBfA=
X-Gm-Message-State: AOJu0YxGKueYnwGBZubchf+i7PuNvvzQdQCkXogD/qOdWnDtkNw3woyM
 kY9g31TFLX1pW6fnOJVsoCIvHIEzyd4l+herhxj50VJFAs1oqNzVTrxiYcB5XUuqxAmstZVRr4c
 CIv7SSMChqKV66XgRn/qgy4q5/ueLOpk9vUBbdUj+YKPGdg2nHFY4
X-Received: by 2002:a05:600c:4e8f:b0:414:8ce5:9e47 with SMTP id
 f15-20020a05600c4e8f00b004148ce59e47mr2520528wmq.14.1711470728533; 
 Tue, 26 Mar 2024 09:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLY7Ikzubust2ejZ8RIxYApQaz0I/YhIpcL5qFoQAOfI8QmY0TP9B/PUOh5zuCY14Mh31vAA==
X-Received: by 2002:a05:600c:4e8f:b0:414:8ce5:9e47 with SMTP id
 f15-20020a05600c4e8f00b004148ce59e47mr2520508wmq.14.1711470728142; 
 Tue, 26 Mar 2024 09:32:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z2-20020a05600c0a0200b0041477d83499sm12073326wmp.16.2024.03.26.09.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 09:32:07 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:32:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Ani Sinha <anisinha@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.1] hw/i386: Add a config to only build the microvm
 machine
Message-ID: <20240326173207.10191eba@imammedo.users.ipa.redhat.com>
In-Reply-To: <1788e23b-1681-4d4e-a281-df5c9ba330e7@tls.msk.ru>
References: <20240326131410.93866-1-philmd@linaro.org>
 <517935ff-6f0f-4ef8-878c-9778f6b1bb98@tls.msk.ru>
 <d5ff6e5e-963f-467a-9d5b-3e2d12e16695@linaro.org>
 <1788e23b-1681-4d4e-a281-df5c9ba330e7@tls.msk.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Tue, 26 Mar 2024 19:01:50 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 26.03.2024 18:58, Philippe Mathieu-Daud=C3=A9:
>=20
> >> This is not enough.=C2=A0 This step is good already, but it lacks defa=
ult machine
> >> type selection.=C2=A0 In debian we carry a tiny patch to make microvm =
the default
> >> machine type or else it crashes at startup not finding "pc" machine or=
 one
> >> of its required devices. =20
> >=20
> > No crash here, what is your base commit?
> >=20
> > ./qemu-system-x86_64
> > qemu-system-x86_64: No machine specified, and there is no default
> > Use -machine help to list supported machines =20
>=20
> Well, this is definitely better than a crash.  I haven't looked at that f=
or
> a long time, initially it just crashed.
>=20
> Still, this current behavior isn't nice, - in my opinion it should select
> microvm by default in this case.

In arm we also don't have default =3D> consensus was to let user pick poiso=
n explicitly.
Would've don the same for x86 modulo that would break user's scripts
expecting default machine.

If it's something new like microvm, I wouldn't set default machine
that way there won't expectations and won't be a discussion in future
when new shiny not-microvm is around and one want's to ship both
(like we had with pc vs q35).


> https://salsa.debian.org/qemu-team/qemu/-/blob/master/debian/patches/micr=
ovm-default-machine-type.patch
> is the outline (from more than 4 years ago), - it's a hack but shows what
> I mean.
>=20
> /mjt
>=20


