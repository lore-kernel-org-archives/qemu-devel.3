Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F6C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC73M-0005J3-Kj; Tue, 28 May 2024 20:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC72w-0005Bp-TN; Tue, 28 May 2024 20:20:03 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC72u-0000Wv-R5; Tue, 28 May 2024 20:20:02 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2bfb6668ad5so1205090a91.0; 
 Tue, 28 May 2024 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716941999; x=1717546799; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3IUFNgFjlJrSgFyuJHlPykVuBvjwdB4vnJNYiukNmg=;
 b=KGYZk+dUumxozGKjKaGr1OHvwA/CSkxTDfiOWsjw4pzAiKwNv4g/O2rlwCSCa5u/6q
 0cshxY9Ku/yaDwUgKyBX9sXeVf8U4XLdk2DAQVy94szlnF/5oDdN50eexxNtITL8FAJB
 O413l1cQTUB5S9eJCEYd224QJrwgg4JC4nbPjRmuBFNtGERJxg7Ox3TWpLl8S81f9xv4
 Xa896wy/MD9NgDOdpu+C6K53jUUERxTo6lCMzUMSJWzRhus72mJeKsBskICw9R7J49c/
 BslO69K1r38jEc2X4/HlMWW/fUWa0cS907HzT6P8Oflhd15kMquEAfijwpQyzKmoVFWu
 +FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716941999; x=1717546799;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y3IUFNgFjlJrSgFyuJHlPykVuBvjwdB4vnJNYiukNmg=;
 b=ou1hUp6zmsnR61kCHyuTosKJuyeBMHhkXxneOyRRWmFjBb/G4yebxcSDcjhK2lbGkF
 3zPNmqIu8pJW8mZHxL8/4ooFSbQFBvwto3OoqlSQYbqmQvufeTAkvQJj2uzafNSlldph
 QVdMJaacIHOx27Hy5ggD52aAaCM87MzIEIohK/ZFSnL+a4dKuYHtPwFLx2TC63HeCcpg
 8GB2C+V6cWqVQKzz/rvVsUaKa/7zkKI4nt2c3cUQ1dzHvVGmdiEG7nH9XOnqA/3QhuYl
 1ijn3U9uYDePrFB7OBDvU6S73k5ioTzuqSTsCDjfVBDYFx+0foxa8KIBpUYkLCae8raf
 orbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSV3Jb7PaE0rxRvbpUEYsL56Kk0R8HzboIX1BhJK+qRDdacRTA8nvKWq71TVeuJHOahqhyty0UxSp1irO3JwCpwPrIu0FS/h9+K0IBJx4TKZs8CStZzie4EW8=
X-Gm-Message-State: AOJu0YznwTqlSKJO6Rc7EumoBNVghC9YPW7JERnmlcr1LzHOHjgzapMw
 a2yd6O2BlEa4xuoxsTwMp50d1zhPebULXN4+haDjheM40Xi93oWY
X-Google-Smtp-Source: AGHT+IHsA2rIsMMkOXu/om7XY2jKihQdsOPGE9vHBqJouCqoA1ZswHoi3UtIGNfmcfWi1HYwEwPVPw==
X-Received: by 2002:a17:90a:e295:b0:2bf:1962:ea08 with SMTP id
 98e67ed59e1d1-2bf5f74d855mr10743035a91.45.1716941998225; 
 Tue, 28 May 2024 17:19:58 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f989871sm8265182a91.40.2024.05.28.17.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:19:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:19:52 +1000
Message-Id: <D1LP52PCE3NS.71SEY8XILT96@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 02/10] ppc/pnv: Move timebase state into PnvCore
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-3-npiggin@gmail.com>
 <5876e49c-9912-4979-9613-c60d40eabd41@linux.ibm.com>
 <c70671b1-26e7-46a6-8651-99777ae27f36@kaod.org>
In-Reply-To: <c70671b1-26e7-46a6-8651-99777ae27f36@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue May 28, 2024 at 5:52 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/28/24 08:28, Harsh Prateek Bora wrote:
> >=20
> >=20
> > On 5/26/24 17:56, Nicholas Piggin wrote:
> >> The timebase state machine is per per-core state and can be driven
> >> by any thread in the core. It is currently implemented as a hack
> >> where the state is in a CPU structure and only thread 0's state is
> >> accessed by the chiptod, which limits programming the timebase
> >> side of the state machine to thread 0 of a core.
> >>
> >> Move the state out into PnvCore and share it among all threads.
> >>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >> =C2=A0 include/hw/ppc/pnv_core.h=C2=A0=C2=A0=C2=A0 | 17 ++++++++++++
> >> =C2=A0 target/ppc/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 --------------
> >> =C2=A0 hw/ppc/pnv_chiptod.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 6 ++--
> >> =C2=A0 target/ppc/timebase_helper.c | 53 ++++++++++++++++++++---------=
-------
> >> =C2=A0 4 files changed, 49 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> >> index 30c1e5b1a3..f434c71547 100644
> >> --- a/include/hw/ppc/pnv_core.h
> >> +++ b/include/hw/ppc/pnv_core.h
> >> @@ -25,6 +25,20 @@
> >> =C2=A0 #include "hw/ppc/pnv.h"
> >> =C2=A0 #include "qom/object.h"
> >> +/* ChipTOD and TimeBase State Machine */
> >> +struct pnv_tod_tbst {
> >> +=C2=A0=C2=A0=C2=A0 int tb_ready_for_tod; /* core TB ready to receive =
TOD from chiptod */
> >> +=C2=A0=C2=A0=C2=A0 int tod_sent_to_tb;=C2=A0=C2=A0 /* chiptod sent TO=
D to the core TB */
> >> +
> >> +=C2=A0=C2=A0=C2=A0 /*
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * "Timers" for async TBST events are simulat=
ed by mfTFAC because TFAC
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * is polled for such events. These are just =
used to ensure firmware
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * performs the polling at least a few times.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> +=C2=A0=C2=A0=C2=A0 int tb_state_timer;
> >> +=C2=A0=C2=A0=C2=A0 int tb_sync_pulse_timer;
> >> +};
> >> +
> >> =C2=A0 #define TYPE_PNV_CORE "powernv-cpu-core"
> >> =C2=A0 OBJECT_DECLARE_TYPE(PnvCore, PnvCoreClass,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PNV_CORE)
> >> @@ -38,6 +52,9 @@ struct PnvCore {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pir;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hwid;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t hrmor;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 struct pnv_tod_tbst pnv_tod_tbst;
> >> +
> >=20
> > Now that it is part of struct PnvCore itself, we can drop pnv_ prefix
> > and just call the member variable as tod_tbst ?
>
> yes and rename pnv_tod_tbst using CamelCase please.

Okay will do. That'll look nicer.

Thanks,
Nick

