Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE723C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9nq-0005ep-MI; Thu, 20 Feb 2025 11:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tl9np-0005dv-Bn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:53:33 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tl9ng-0005ng-L2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:53:32 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5461a3a03bdso7659e87.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740070400; x=1740675200; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGueGLJKjxjk0mP/vtDKATK7kGCq/pQ/lzWMFb9XyBo=;
 b=Ns+3uil5p4Kkc4hsWNr6r83ClRZvKMbYAsIbxa1AddMJgapGy0ond/0yPv50Xxf4aI
 SugM5zdsNCqc29GemN3G8jAZnnZJLdqMXf3Dc0vxzN9baIMNy49BQdK+8LmU5GIh5J5K
 t58dlKjcDIvXf51mrGtR1JLWoGhaHCVrv4G+wbFI1qtgSJHRedR1rn1QiVOFF8yiNhck
 oCcU6PHHEyos2YBgcCap9mvmUgWweEEBbpSLuLq5AIn/Wpn40QpHyeqDSqdB6AVZa4h5
 wwTvozoHVzenp2UKz3G5cL7nxY7PRPGKS/sg9X0HFeZHlshq7aDl05en8lvxe99jN+5h
 jG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070400; x=1740675200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGueGLJKjxjk0mP/vtDKATK7kGCq/pQ/lzWMFb9XyBo=;
 b=my7d+bBloWMja1W51LECK9XEtN3ymdtbpxaZ3GygfkJUizRMV11QGhMv0kdHqO49HI
 +JhJFC9TE0P/HnJnFwEFF0O7QssHW6XpfMAO9ehwUahc085SgVafuMqJNguYlnujOuWc
 1J6tTjsbOD+xZWpZppVgEtMa3X4pAe+2+2SO3Z3AwviWbSnmWc+iFHuW2gS39VcG4VZc
 LKu01b5plwArCzUbmT246y6qtceXoi3Ap2P0hSeDQcWW2OpAKF8QLCYEtSBSe4TJrIM2
 gPz7cwftC3mao45BGp6Bi6qdrmEIere0QkVLReU0CQajc61iNynh422gaD5ZC3SIpAvu
 /eYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsyLR0505GbqIX23RHkAg5siGpgwuZXpcV0MAF5Bc7V8+JeuJ0RWg90IgzXyUlsv2BjXX4NGTtrEhN@nongnu.org
X-Gm-Message-State: AOJu0YzNXS6JlwCIucpWw15OPVUHqvSAlp6ovBb7N+uvr1UtFeNQVcVd
 +Cux78wGjTFDkKMbWuXq/GauDuRjlBZN0n6kJPAGsvW0tClaURI8xmLozgb670CuU181ogMl84W
 XhNTar5bsODfUXQYCVpckv07PiaAfHtYj78se
X-Gm-Gg: ASbGnctFqdz7DuT/rwHM6/flykJGzwaIs4ubDhcCmOanq4ibi+e3TpbGShdtCi+2wnF
 c7bMFppRBbbntrM5U7gVjk0xE0lCSxyl7fhcZobCgSJ7UE3+/B3Z2vJRUxB09+tegzG8rMd84wy
 RljveEYtDqMHsPOAmCNe1PNrp2LOo=
X-Google-Smtp-Source: AGHT+IErQ2WBQLTHOzrN6v2roCS7LnqdlF1CbntXsMyqLxZpCxf+8M1DhYzlSc2/SrpOePio8SOM44icGN4Sn/hYtZ4=
X-Received: by 2002:a05:6512:1054:b0:545:38d:ffd9 with SMTP id
 2adb3069b0e04-5471c9ba747mr205794e87.1.1740070400341; Thu, 20 Feb 2025
 08:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
 <CAFEAcA_3FOHVo6q_tiOEE7dHZNDw7_0emdCR5=5cEt7fdKVkTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_3FOHVo6q_tiOEE7dHZNDw7_0emdCR5=5cEt7fdKVkTQ@mail.gmail.com>
From: Hao Wu <wuhaotsh@google.com>
Date: Thu, 20 Feb 2025 08:53:08 -0800
X-Gm-Features: AWEUYZmP1Zv0kYij9jFDGl1PQ-YBD2nsQoseCAyE1URO_xpdh6oEOH_JnloHAyc
Message-ID: <CAGcCb10OPzQhjMQ0dc06AQt06Y2x2syQURSC26bx=mUsyNir3Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] hw/arm: Add NPCM8XX Support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com, 
 titusr@google.com, chli30@nuvoton.corp-partner.google.com, 
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000001935c2062e95b628"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--0000000000001935c2062e95b628
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much!

On Thu, Feb 20, 2025 at 8:18=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Wed, 19 Feb 2025 at 18:46, Hao Wu <wuhaotsh@google.com> wrote:
> >
> > Changes since v4:
> >
> > 1. Bump vmstate versions on NPCM CLK and GCR modules.
> > 2. Remove "hw/boards.h" include in npcm8xx.h and add it in npcm8xx*.c
> > 3. Use cpu_to_le32 instead of tswap32 in npcm8xx.c
> >
>
> I've applied this to target-arm.next with the fix for the
> type of flash_size applied.
>
> thanks
> -- PMM
>

--0000000000001935c2062e95b628
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you very much!</div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 20, =
2025 at 8:18=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Wed, 19 Feb 2025 at 18:46, Hao Wu &lt=
;<a href=3D"mailto:wuhaotsh@google.com" target=3D"_blank">wuhaotsh@google.c=
om</a>&gt; wrote:<br>
&gt;<br>
&gt; Changes since v4:<br>
&gt;<br>
&gt; 1. Bump vmstate versions on NPCM CLK and GCR modules.<br>
&gt; 2. Remove &quot;hw/boards.h&quot; include in npcm8xx.h and add it in n=
pcm8xx*.c<br>
&gt; 3. Use cpu_to_le32 instead of tswap32 in npcm8xx.c<br>
&gt;<br>
<br>
I&#39;ve applied this to target-arm.next with the fix for the<br>
type of flash_size applied.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000001935c2062e95b628--

