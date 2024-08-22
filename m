Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B156C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh7cU-0007hy-7C; Thu, 22 Aug 2024 09:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh7cS-0007gs-RU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:12:52 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh7cQ-0004mz-Lo
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:12:52 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f15e48f35bso6370131fa.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724332368; x=1724937168; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA1+K8xb7SbNuH9fDYzKiR617D8ngODnLVxW/DQ9Sjg=;
 b=P/72DYAzX5occJKjGlTyCxiFSjkirMoW1tjPZ/Fc5IxoxXrpy8i3WqBJnFV3wP8kJD
 wkiqavU7qoIZoQIkOzwZLHrrUO41+dnu1xLJ+ji2GMPjsUuP4n8FR+fabGhJY57XZmJ+
 guO6M35uuaHRxgdHUaPtTGQypojglgR8RUJLvh02eeghAGMd+tFsJ39177IEkJ6uHsiT
 R7pYKXwNkhbuxKSonY9UEGiiP9MdVhH3+yUMdqZ5dFlnYWMuopdllgRXYfTPpsHNxhqU
 hU1XcUbTG9g58ESldyC5hPieXKs0JMPxwpss+CIPBWlykQeJISarMCvcA1BcnNWBvL+8
 zQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724332368; x=1724937168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wA1+K8xb7SbNuH9fDYzKiR617D8ngODnLVxW/DQ9Sjg=;
 b=vRMl9uY58tcvEfBgMO3s0q8mrgdScbz4QNugDmFP8CYHKfKhXi+OxwoylTPhwPQ9Ys
 eUyHljjMGPfNxFvPLhOvYSBVmdkjAi5QS5EzlUO6vOvB0kLYnREQgQF5l2NYPnbL16wr
 lF+deIeX9JtvaRVh2INFjww6Ka5bnWLBn944FyOxqK2lRdTqv8QSEhz7RLiuxO/214TJ
 uzmoPkPeDJSjNfscXRbH1EWXgBNvJ7cAFPWaF25fjkI1iBy/1PSwExJi242+NcjeiPq5
 ORm8Jcltptcl8itI6KoYfCyOcpWxw9pRchV9gy15QQMjN7sy92o9wtMALLuxRlNVc13x
 CR3g==
X-Gm-Message-State: AOJu0YxjyiWTXoTYfc3zxpQIv2s1AM11Oq/ze/axI8LSCg5iDndmTk5I
 dGAzzRNvc3uR0Yj6hlV2UeUdyCrRcnlaaQPC5jIjfOg5CQnm/hAr2UL7EAQxWGt8e0uY4HZfPaF
 eiAKx+xeRu5nVl47wqHn79+5l8teAIZlHGOygZQ==
X-Google-Smtp-Source: AGHT+IFvAN2BSRlqu6MZ8owIh0DP4mRQYw66/9alc1SdKj/XuMF2BmNvggwTYjn9BW4mA8tiwwHc3OIgV3pjJFry9js=
X-Received: by 2002:a2e:9945:0:b0:2ef:2cbc:9072 with SMTP id
 38308e7fff4ca-2f3f8b7ce78mr33038991fa.49.1724332367982; Thu, 22 Aug 2024
 06:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
 <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
 <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
 <CAFEAcA_wpbEaX+iEz7syNd1tB7A77UVT75vzups=yZogJmiEaQ@mail.gmail.com>
 <CAGMt57d7f1WwfvoCoOtFSEDm8eqMZAEP17DsZuo09dLi0j-A9w@mail.gmail.com>
 <CAFEAcA-Tp8v-DTOBVfyJApb8-Wv=RuO_Qda1zHN9-jSgVW7g0A@mail.gmail.com>
In-Reply-To: <CAFEAcA-Tp8v-DTOBVfyJApb8-Wv=RuO_Qda1zHN9-jSgVW7g0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 14:12:36 +0100
Message-ID: <CAFEAcA-c1yUa3W_bTQ4f8zESrdyFggCYrieEjrvEdYV-wMwavg@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: Arman Nabiev <nabiev.arman13@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 21 Aug 2024 at 20:33, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 21 Aug 2024 at 19:56, Arman Nabiev <nabiev.arman13@gmail.com> wro=
te:
> >
> > In my example in https://gitlab.com/qemu-project/qemu/-/issues/2522 the=
 .needed function returns true for vmstate_tlbemb, but not for vmstate_tlb6=
xx. I tried to do some tests without fixing the typo. When I changed the .f=
ields in the two structures to the same value so that the size of the data =
they stored matched, everything worked. I also changed the order of vmstate=
_tlb6xx and vmstate_tlbemb in the subsections field of vmstate_ppc_cpu, eve=
rything worked as well.
> > According to https://www.qemu.org/docs/master/devel/migration/main.html=
#:~:text=3DOn%20the%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20send=
%20the%20subsection and on my own tests I think the problem is that when re=
ading saved data, qemu uses the device name to determine an object that ext=
racts a certain size of data. Since the names are the same for vmstate_tlb6=
xx and vmstate_tlbemb, it uses the functions for the first one due to a cer=
tain order, which leads to an error, since the data from the second one was=
 saved.
>
> Aha, yes, that would explain it -- the PPC CPU has both
> subsections in its subsection list, but they have the
> same name, so we pick the wrong one when we see the
> name in the incoming data.
>
> In that case we can take this fix without worrying
> about a migration compat break, because clearly
> migration has never worked for this CPU type...

I did a quick test and indeed migration doesn't work, not
just record-and-replay:

$ ./build/ppc/qemu-system-ppc -drive
if=3Dnone,format=3Dqcow2,file=3D/home/petmay01/test-images/virt/dummy.qcow2
-monitor stdio -M bamboo
QEMU 9.0.92 monitor - type 'help' for more information
(qemu) savevm foo
(qemu) loadvm foo
Missing section footer for cpu
Error: Error -22 while loading VM state

So I'm happy that this patch is the right fix, and
it can have my

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

provided that we fix a couple of things in the commit message:

(1) For QEMU, Signed-off-by lines should generally be your
full name, not a pseudonym (as I assume "armanincredible" is).

(2) We should give in the commit message details of
what has been fixed and also a Resolves: line for the
gitlab issue, something like:

=3D=3D=3Dbegin=3D=3D
target/ppc: Fix migration of CPUs with TLB_EMB TLB type

In vmstate_tlbemb a cut-and-paste error meant we gave
this vmstate subsection the same "cpu/tlb6xx" name as
the vmstate_tlb6xx subsection. This breaks migration load
for any CPU using the TLB_EMB CPU type, because when we
see the "tlb6xx" name in the incoming data we try to
interpret it as a vmstate_tlb6xx subsection, which it
isn't the right format for:

 $ qemu-system-ppc -drive
if=3Dnone,format=3Dqcow2,file=3D/home/petmay01/test-images/virt/dummy.qcow2
-monitor stdio -M bamboo
 QEMU 9.0.92 monitor - type 'help' for more information
 (qemu) savevm foo
 (qemu) loadvm foo
 Missing section footer for cpu
 Error: Error -22 while loading VM state

Correct the incorrect vmstate section name. Since migration
for these CPU types was completely broken before, we don't
need to care that this is a migration compatibility break.

This affects the PPC 405, 440, 460 and e200 CPU families.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2522
Signed-off-by: [your name here] <nabiev.arman13@gmail.com>
=3D=3D=3Dendit=3D=3D=3D

thanks
-- PMM

