Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADE8109C022
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5PHZ-00050Y-90; Wed, 25 Mar 2026 10:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5PHW-00050L-1j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:32:27 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5PHT-000558-IX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:32:25 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b97ed4ad579so777214166b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774449142; x=1775053942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faguxbi313ZwgM1cUu9QJKWko6tPJUGz3JYLS+WqCrQ=;
 b=CPcajm6aiKYqFxByf7QS0wMsjRSVjP/FnB7Udh08u1xzSlQikPMTfnepcFFQ8oIFY+
 DK1dQNnQiQQdXqLWTxB2k3i4ZdEKRy8RjvK8td+z4abKAO/ciwndDlUU42uggiLGl+w7
 oyPLFyR5jjNRueH4VjVeTzEeCgEx8hlSApkgfhodyVG1JGZR1jNo36Y77GkpioHL2V4n
 gEFdiaePG3fci43tiTxHtw1KGFqh8lua3+IjsocRoLu47EuchVpLgPImRNCXauMXWFWr
 bOriKjfe+E3GHoczmKJTVbSeJRw/PhbTOKOlOKMOVgdNWgao59frlPXcxWWQlqQAdz7C
 twIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774449142; x=1775053942;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=faguxbi313ZwgM1cUu9QJKWko6tPJUGz3JYLS+WqCrQ=;
 b=LR+BoMSyK/CHPsPcaKx1oLMBqaWI7xKnb0qTkg/fLfjlI00+Jz7yM8YeNR7YPEHCKe
 Pmue/ERWi2eth8uaJfw7q/lR4n/vcxkd2IoXEFzo4IG9tFfoUUPcbOVXN7xlUfx9N51a
 Gl0lXzpjaLSvdm05aXk5H7Q0gahBiHv48l03iC7D/O9X7hEt/0KAbjN+oN71Lb34y1Ys
 cRCt90Rnz2iL57uf8mze9bo7E1yclU2XLOzXB5NDDjRZPGnuXf3gR4GEa49Yve4JtOYk
 hY42sVnXKesjE2jfM8qiaIlNKko/yWH+6j0wbc2qmLGJ4NdeZEDwLax4AiELbbhy8eZm
 W2iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKIr52b8T9I0Ft4wUa62FPBi7kMX6JSugDYVHCeAe0gV089bJx6zCcT5nksVEfz4KE/Pp86HcU+ph8@nongnu.org
X-Gm-Message-State: AOJu0Yw790TYqTr2m5Q0Nt6Z7xAOeyqHmfuwlTTvsWwo/C2VDIVFGL9m
 sfyC+n4HcxjSrPs6td4a7yzvP02zAvBeeWSYDvLi/c7Hp4eQut7zvYSXrpM1EQ2GRTo=
X-Gm-Gg: ATEYQzxGbb7g3w0sD5tFW6qKFIiSmobNRVDQV+GGcMObSq6EA/n6nsM2k93uf2onUvW
 7j4H6H73yOzf7FfbojQC1zp0SgdEsy1054rHYhPM+LdAS01aXxeRaRWKfMuewc0A7fktS2dBUEN
 NP1vPaIC2oSbYpUDcPW6x2zTf+zn/KFa6vjgwJGyuGF7UBylzu2Y6cE1lCv5+f7oqA0lQPehKBS
 ljjHVEYeurQw/eFCCOHt7FaNxPumjPQQn786Zj/bE3wrkknQVlhTjXKg6tOWtflfD7s5ccvvMlF
 HBztgM9Mow0kkXFMpTCLRs4THUhgsALmbE6WyWv11e7PbJB/bkyvcn7/WTbuak8NRiEyd0q8fkX
 +2+xp1n5dbP4kUyy/xv06WycP4YbUGPvnkt9eD1eW/Kt7Y/hXgNO0EHfbs3uqa/8HK+j6YRzH5/
 ax0TJmDuM/EnANI5MXORJ81IU=
X-Received: by 2002:a17:907:3e89:b0:b9b:171e:baef with SMTP id
 a640c23a62f3a-b9b171ebdbbmr139544266b.6.1774449141513; 
 Wed, 25 Mar 2026 07:32:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98b20c8c7bsm215362066b.63.2026.03.25.07.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 07:32:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AEF2D5F878;
 Wed, 25 Mar 2026 14:32:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  QEMU Developers
 <qemu-devel@nongnu.org>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: Cleaning up contrib/ and tools/
In-Reply-To: <87tsu4m8w4.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 25 Mar 2026 12:43:55 +0100")
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <87tsu4m8w4.fsf@pond.sub.org>
User-Agent: mu4e 1.14.0-pre3; emacs 30.1
Date: Wed, 25 Mar 2026 14:32:19 +0000
Message-ID: <87341o3rpo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> We have a couple of directories in our source tree which have
>> accumulated things in them that don't really belong there; this is a
>> proposal to clean up by moving things to more appropriate locations
>> (as 11.1 work, obviously).
>>
>> Firstly, contrib/ has a tendency to be a dumping ground for stuff that
>> we didn't think hard enough about finding a good home for, and for
>> things in a weird "not really maintained" state. We should either
>> (a) care enough about something to give it a correct home and to
>> maintain it, or (b) not care about it, and kick it out of our tree.
>>
>> Secondly, tools/ exists but is very under-used. I think it should be
>> for the set of standalone tools that we build if you configure
>> --enable-tools and which we document in docs/tools.  Currently it
>> contains two things, one of which doesn't match that idea...
>>
>> So, starting with tools/:
>
> [...]
>
>> And for contrib/, easy ones first:
>>  * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>>  * contrib/elf2dmp moves to tools/
>>  * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>
> Absolutely not.  This is example code, provided in the hope of helping
> people understand the protocol, and experiment with it.  It is entirely
> unfit for more serious use, and that's intentional.

The rust-vmm project has gpu, input and scsi vhost-user daemons which
are actively maintained. I don't think there is a blk device although I
guess people should be directed to use qsd for storage?

>
> If somebody contributes something fit for more serious use, and there's
> interest in maintaining it in that role going forward, and that code is
> still simple enough to serve the example code's purpose as described
> above, we can drop the example code from contrib/.
>
> We could also drop it without replacement just to have an empty
> contrib/.  I think that would be a disservice to people trying to use
> ivshmem.  But then I'm the guy who keeps telling people *not* to use it,
> so why should I care?
>
> Perhaps contrib/ is not a good home for example code.  It seems to
> bother people whose judgement I respect.  Can we find a better home?
>
>>  * contrib/plugins moves to plugins/plugins (or a different subdir
>>    name of your choice)
>>
>> For contrib/, ones I'm less sure about:
>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

