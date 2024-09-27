Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10001CDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 16:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suDwr-0000jw-0j; Fri, 27 Sep 2024 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suDwh-0000j1-1n
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:36:00 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suDwe-0005d2-Ru
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:35:54 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f759688444so22497681fa.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727454950; x=1728059750; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2GAq7tB+L4IAzwWfPYqEMrwyNYstQi+2hV5jhbNtlQ=;
 b=cyarNA5jypGVrhOXcaWN/a5mS1MpiTuDerfHDx5+Mfw9xos6WszkX7kZVXD1GHOMA4
 UfY5WGgH7yxt1Fz1miq9u/gfp4hCf9aErEPqTIBIneS3Mgiryjg5+IFJ274R+oKfyCVR
 sz0BakKEsQyOwfQeV070+tr0q9zgR5L5JRsh5XPOB2tx7Ks4YRHIE7mQt0iCQt4401N1
 pUNFTC3RDi0ruWTRCw9D83pKvvrUn9j0erRwFmFece8cH0D6Yx1OjtXXKSnJi3gR+fQI
 CV0k+6PQEeuT+N4BqtpdBxV0ZnTpU4Q5ozoo2fh5PIA6JX6yjQJzY2TRRYZG0jHJnPjA
 oMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727454950; x=1728059750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2GAq7tB+L4IAzwWfPYqEMrwyNYstQi+2hV5jhbNtlQ=;
 b=A8bbIsBJwMlmIzgz7diLWzC2QX55lsjh2NqNZwQBJScsmXqMU5r2W1QwXWPkLzLRJU
 yjb4o9996uIceRchpx8OODMwRuy71Kj/zXD23TlWv/4coIN0JnrJWb+/05wzGz3fmMeO
 VrSZPucfuE9CdOY3hZ4XuURQLoHd3RbKtbtcyhq8Xe4lNiQPq8KAp18LJwE2tQfFvbOL
 IxqRTMs7ADZ93dn6dddhkSXMyqBw2/Y4x/LENT2tkLN9rTGqHZAi42kvC+FplNFKWAKu
 UyDGBxje7tMzAq0aq7eTfMIqqLUy1Sh+XJkDJjKLFQjroR8yVj4GbBxKKlSiqvph0elp
 SeYw==
X-Gm-Message-State: AOJu0YxfQSeogajKYsO83cBbHCnZI2z/w2fh29PDSSgMplfIE22WB1Fn
 4/FF2wQQ5gXcK4+t49nhTJN4UDTBTvNL+/8kQuK5t0pBZIErHaekw2rBRyiE51Nt59ZGQIulgC0
 aUvlETbfhgjOgHlrHfkMpfRceKUREe0nnZ0EduQ==
X-Google-Smtp-Source: AGHT+IEZdgm1YyY5YWJ/IWOaN88s+bHW77FKWmhFA0d7ZJw/DY1AXOLmEFTDGTDs1Rqa9KPJQNCANt+f2bMZpC4pfpc=
X-Received: by 2002:a05:651c:1a0c:b0:2fa:bba7:2691 with SMTP id
 38308e7fff4ca-2fabba72790mr12239611fa.14.1727454949812; Fri, 27 Sep 2024
 09:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 17:35:38 +0100
Message-ID: <CAFEAcA-e719+Rg7Y_8wiOVVOFaaazUfPCfZDYdG6TCaEpa4djA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A
 maintainers
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Jacob Abrams <satur9nine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 21 Sept 2024 at 11:48, In=C3=A8s Varhol <ines.varhol@telecom-paris.=
fr> wrote:
>
> It has been a learning experience to contribute to QEMU for our
> end-of-studies project. For a few months now, Arnaud and I aren't
> actively involved anymore as we lack time and access to the hardware.
> Therefore it's high time to update the maintainers file: from now on,
> Samuel Tardieu who is behind the project will be taking up the role of
> maintainer.
>
> This commit updates maintainers and the list of files, and places the
> two devices in alphabetical order.

Thank you for your contributions to the project; I hope you
have enjoyed working on QEMU.

Applied to target-arm.next, thanks.

-- PMM

