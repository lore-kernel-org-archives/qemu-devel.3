Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8077BC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7yV-0006je-9Z; Wed, 31 Jan 2024 05:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rV7yT-0006j9-Lz
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rV7yQ-0006Yk-0O
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706697461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZ/5pXVh84yVqchUF8CdYzyQB86iKQFVoHBBNWzSgiI=;
 b=XpGgPi4B5KVpggXizO5WmMA86xlqdm9sPnPDmwElrbAm7jQeOjtocTsZvoRQiviGJEoUYY
 8+y8P9gL3U2UOnzVktHhJBdS6GogAbTABhkbtrrHaEytPMjJld6MkNYRvfbPnt13SM7zwN
 9a9EEgOFX+oOO+xFyR9iZzWzb76draA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-WyPKwZQ6MNSq_fbOhfx0_w-1; Wed, 31 Jan 2024 05:37:39 -0500
X-MC-Unique: WyPKwZQ6MNSq_fbOhfx0_w-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-602dae507caso84224787b3.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 02:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706697459; x=1707302259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZ/5pXVh84yVqchUF8CdYzyQB86iKQFVoHBBNWzSgiI=;
 b=cGN4P1fSOYgFbqqxacoK+6fgz+mm5T2ojFEk0B571zqqxVHbcx04YHGp7e0U7N0KWW
 xfEAnFmL2aHPLQZRJx2pwe4BcSShSfKQTNBE2GJnbv4KXLkcZy8zt3MsHGx/NzIxu2Ym
 T/eTFW61GdlcHLbrDU7GHVgnpVw56MgPTkaQNcNLJKfQJOG7t7VhplxxS2CiBcze4dyL
 O2S0VF2laPPHB9xdFA6rRWJp1nJ41Wtx/MZHj9Tt+NXjwwjN/q8i71+iMPftViSTekV2
 XceNsoecFPMn6JaN+yCo3HyuCYJJIateJu25TdhP6FJtMh62BUIJrX/dIemHBXzy8L3A
 aUzw==
X-Gm-Message-State: AOJu0YxDfEzIMV7wdawqUCWXsfWfGnDj9OBVzQmM+DduS1WfGfxFnOlx
 hTCgFXin0F+XbYiDdyTIAtwtZKUGvk6vVdrhEpqyccWx7zGmSiUwrPWsHff9tqiuP1oz3HqYugh
 gqsxvZ6sWSwxwEqaWcIGKcRtfBrKRCnaSrSTD8oyR9H2UXz6lvfS0CGeR+GwoHGoOOmLzag0cLf
 MV6ITsEMOQ+BsHEsxD6soe26PrSik=
X-Received: by 2002:a81:c545:0:b0:5ff:a52b:55ac with SMTP id
 o5-20020a81c545000000b005ffa52b55acmr880395ywj.34.1706697458847; 
 Wed, 31 Jan 2024 02:37:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFshBQqoErbhHyr+Q5zY2LZvsx8RHksCLXSGgFJ0TPShcaDyG/Hw1jQof6Jm0l0MKneEtOr/J6LhaNERDvbBZw=
X-Received: by 2002:a81:c545:0:b0:5ff:a52b:55ac with SMTP id
 o5-20020a81c545000000b005ffa52b55acmr880376ywj.34.1706697458615; Wed, 31 Jan
 2024 02:37:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAJaqyWdMNP3V=JL6C8SSbXV5AP_2O9SNJLUS+Go7AjVsrT1FdQ@mail.gmail.com>
 <CAJSP0QXMJiRQFJh6383tnCOXyLwAbBYM7ff-mtregO3MKAEC1A@mail.gmail.com>
 <CAJaqyWeKrjjMyRXo1LK4_2Q=HYKqd=omjDJ+by_=do9ppdCk3w@mail.gmail.com>
 <CAJSP0QU09UCkV6Q6HfsB8ozaE0mMC1tCH02e5CEBMPC_=eyUOw@mail.gmail.com>
In-Reply-To: <CAJSP0QU09UCkV6Q6HfsB8ozaE0mMC1tCH02e5CEBMPC_=eyUOw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 31 Jan 2024 11:37:02 +0100
Message-ID: <CAJaqyWfy7io-F5LQKOWP8tWj8tsf8wa2MwUnOXzhYqF35g_LxA@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Alberto Faria <afaria@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Bernhard Beschow <shentey@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Sean Christopherson <seanjc@google.com>,
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Tue, Jan 30, 2024 at 8:34=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> Hi Eugenio,
> Stefano Garzarella and I had a SVQ-related project idea that I have added=
:
> https://wiki.qemu.org/Google_Summer_of_Code_2024#vhost-user_memory_isolat=
ion
>
> We want to support vhost-user devices without exposing guest RAM. This
> is attractive for security reasons in vhost-user-vsock where a process
> that connects multiple guests should not give access to other guests'
> RAM in the case of a security bug. It is also useful on host platforms
> where guest RAM cannot be shared (we think this is the case on macOS
> Hypervisor.framework).
>
> Please let us know if you have any thoughts about sharing/refactoring
> the SVQ code.
>

I'm totally in, sure :).

Actually I've been thinking about adding multithreading to SVQ. Since
SVQ reuses a lot of code from the emulated devices in virtio.c, it
would be great to add multithread to net devices too.

On the other hand, I've not added indirect descriptor support because
SVQ does not copy buffer memory by default, and there was little
benefit because HW does not like indirections. It seems to me that
reuse for your proposal would enable a justification to finally add
it.

Looking forward to this project, and I'd be happy to help it for sure. Than=
ks!


