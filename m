Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A3EC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s945o-0000n5-4J; Mon, 20 May 2024 10:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s945m-0000mf-LE
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:34:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s945k-00077N-TX
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:34:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5cec2c2981so280703066b.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716215659; x=1716820459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euD1s9PyxtnETpDK0sKP2l9tsBj/ydNrt4RMXS6iFvU=;
 b=iF//f8nLAcwn6A0PjDESKJKkCN36sNqLu5G1sVBvl0RGAvIHyGrRni8IQlmyyvHSdv
 FQB4+5raFGPZun2SfDL5wwLFZdt7qylZn3n7mcWnaxhAmMASPZ20uucjkzpMIgkS9Rbj
 8INloHnQAiMkMVR36HTDQ9udyYLcaSOsqulCfxGfB0UKRi22Yf5+UTodpHiSEhJ18+mZ
 3jPQFyfex3AM24yEBCD0j4c8b06Z8MHbWG7nkAZC1htXpJfl+ZcWGJ4yHaA5vPeyjddp
 Qe3u3CJf2QyEM2nRoJxb6M4JQSaGu/yXDhkW6YY7QOo3L5c3IKYY4JMJyge9O0MzXsKQ
 zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716215659; x=1716820459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euD1s9PyxtnETpDK0sKP2l9tsBj/ydNrt4RMXS6iFvU=;
 b=TilqluBUKVBYZ6ygpWVV0IEPyXL3dlpsa1hOcxSb4Flt+gZBCEtAHgxpaiPW/5Lmpa
 bXWLLO0XgsAUidudebtBZRnY5LrThRC4Err+kav/YKiJU88VI2irGoXks4Nmc9lKGWqa
 yz9QeDvxh6P4gj+44v+WxSRJd/prvM4mnoEs6MqjNEINkynnROg6p1+fPfWBbNyQa4g2
 pbH2Cv/3yQFvQ7TTIbjXK6uMWd5gzzzbZv5jjdppOhAjDENjgqL6+VDwA7nK6An8qaVf
 A2+yeH/dnT2MC8xpb4lDqZYIz4IcdZsBCrMcRz9qJwZdsVGWQetKemp5nx/hT5/RPiKH
 7DJQ==
X-Gm-Message-State: AOJu0Yyxwqu0b4LdmC2qLIgizIfpECMr9gMry8hwJNyeYdhQwAnHwRxc
 qi4/uZoD8sK6G9KiZQnPkzuHG9ml0T334M+V7uKyzvAwNJVpiVNE0wtLtOK1YQYS12DaWN53i9J
 AB+Pf6Im/WNMFjKbL7v7L4pRDNa6bP7bzeZsvfw==
X-Google-Smtp-Source: AGHT+IHuG3vRveaTkzp5ed4+PECCBYgoIgX76TGlKj+lnxcA/wvDfZdcbpjDM/kgt/+AFLeivEi/qiwMDkS2OCUZ6vs=
X-Received: by 2002:a50:9e44:0:b0:572:cfa4:3cc6 with SMTP id
 4fb4d7f45d1cf-5734d597d84mr25344432a12.8.1716215659176; Mon, 20 May 2024
 07:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240508141333.44610-1-philmd@linaro.org>
 <CAFEAcA84CfdNZSjZ1R96=5P-VhxGXyaaujF1Y8AxKa+Wvpdp3Q@mail.gmail.com>
 <ba6c3173-12c2-45d8-ade4-b21598800f5b@linaro.org>
In-Reply-To: <ba6c3173-12c2-45d8-ade4-b21598800f5b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 15:34:08 +0100
Message-ID: <CAFEAcA9fZx9=SCRgZ9+S4dZ29yCnZ+i9aX+S8tt42GzP0nXVDw@mail.gmail.com>
Subject: Re: [PATCH] hw/clock: Expose 'freq-hz' QOM property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>, 
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Wed, 8 May 2024 at 22:27, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 8/5/24 19:46, Peter Maydell wrote:
> > On Wed, 8 May 2024 at 15:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
> >>
> >> Expose the clock frequency via the QOM 'freq-hz' property,
> >> as it might be useful for QTests.
> >>
> >> HMP example:
> >>
> >>    $ qemu-system-mips -S -monitor stdio -M mipssim
> >>    (qemu) qom-get /machine/cpu-refclk freq-hz
> >>    12000000
> >>
> >> Inspired-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > So I have a couple of thoughts here:
> >
> > (1) if this is intended for qtests, would exposing the period (i.e.
> > QOM equivalent of clock_get() rather than clock_get_hz()) be better?
> > A Hz figure has rounding so it's not as accurate.
>
> Indeed, simpler to compare from QTest perspective.
>
> > (2) We should document this in clocks.rst; I guess we want to say
> > "only intended for use in qtests" (i.e. if you're part of QEMU
> > use the existing function interface, not this).
>
> OK, and we can also only expose this for QTest using:
>
>    if (qtest_enabled()) {
>        object_property_add(obj, "[qtest-]clock-period", ...);
>    }

Yes, that seems reasonable. (I don't know if we have any other
qtest-only properties but I don't see any reason why we
shouldn't have them if we want to expose stuff for tests only.)

thanks
-- PMM

