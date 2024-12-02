Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA33EE69E8C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICXD-0002Ws-DA; Mon, 02 Dec 2024 14:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tICXB-0002W1-6i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:56:41 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tICX7-0001Qn-Iz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:56:40 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0bd12374cso2165086a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733169395; x=1733774195; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rjPEVeVubv7yo9F0QbP9XQRaClcIjjwTcST8R9WFH8A=;
 b=xfRcZgBTdMtSprBspQZ2mudsSC25i8BRzAUsP0+x65CsQxQ0cE1eAx6rnS0xDbR0yy
 rO7079PkDI3196V3H3NXcDO6IUAptYabAZxNetPlwUexvIrNWlAiOCzrjg/30OCK+PTs
 iRv8Nl9ThjNJc88awPntsRbZNdG7QK+ImOAup62pSoz04EyhgfhzETu+88zVZ11SeCJg
 pD7y7CiYnDiYfMfxGSyqZJNlMuCeEZ9JmdLzeWb/O+XbTPrrl509UxxE6bkM4LlnNwhU
 HZz/JAyh7rzqgS6HI0cY9DID6N044jAgSavVhIAjj/p9oayCYeE93FmkGaXXhVq5ocNs
 rc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733169395; x=1733774195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjPEVeVubv7yo9F0QbP9XQRaClcIjjwTcST8R9WFH8A=;
 b=qU5SB7pia/Bf3UgvMrj8dvmI+YujcTIHf1MpHDu+dWk/g12HvXq1s48UnL5rR2g8Fw
 ynIQDOZIJGZU4+/3C5SumDewXJ2jzI0o2qM801KNmMZcRL4kFs3uKCQRUHx4e/89GksQ
 5ThlNw5H0eV4WAycFzAbLI/Ip4Zk8bIPd42BWfWN6yFXp75VLOQl1tjTTK0+yJI14bae
 4Lyy36AjWUMLUxNQWAdhYoBlqg4A/ynOL6dV60YtDswPkFBdlsDmXYNazAp1xA5yHMBH
 RKpEGxY7FOrzdVCsfWPVvLzcUHv4sUD8Cc0Ln0i2gkPA831rDSFX7Xe1dz6Px4SRX3pj
 kAJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdPsgcf2H7M6Sp7YJlgL8CzeSzYXCH6XQ/KX/o5pa77GU5y3KUQ/NalE9SQsQ6xQupwE7ROpfUpRm3@nongnu.org
X-Gm-Message-State: AOJu0YxeA2lvAbPFSDr8d8Oc1sTUdB65MHgD0XDf22Bnx8+gfjTC1ZK/
 XG7KdiWSXRgmniqFpCeYXI20MRHtQj17ZsJXtV+a5C0sql4jed7lnYLgklccugryC6lLETswQzr
 YHIxrxNMooa8p80hdL7UeOCz1pN0/hYlEfnzpaw==
X-Gm-Gg: ASbGncuiuJuxWlIftNkn/PMMUIZVGqXRUrEwJSx/BxXmbXv4RTamvl5pWNimliOikv9
 YSjX6V/JREkpO4Gq96e0pNExiWZ36Pi0W
X-Google-Smtp-Source: AGHT+IFflGrprTtDbxqXzbEW4DIiE8vusR6V+C+y0rTvEJsEGVYNetc97vEsnOhfyyeM84pTlPAlAkEM92XAiaI7yxM=
X-Received: by 2002:aa7:ccca:0:b0:5d0:81f5:a398 with SMTP id
 4fb4d7f45d1cf-5d081f5a877mr25790407a12.1.1733169394972; Mon, 02 Dec 2024
 11:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
 <87ser6c5be.fsf@draig.linaro.org>
 <a26e2a3d-d915-4e84-9b8e-dd5935049f31@linaro.org>
In-Reply-To: <a26e2a3d-d915-4e84-9b8e-dd5935049f31@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 19:56:24 +0000
Message-ID: <CAFEAcA9q7advmbws+xx6Mgcg-=072tBfdRReSSqymYz6p9zENg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 2 Dec 2024 at 18:36, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> Maybe our enable-debug should produced optimized builds by default, and
> we could have a new --enable-debug-unopt for the "I need to use a
> debugger" use case. Would save a lot of time for devs, and in CI where
> minutes are precious.

The whole point of --enable-debug is "I might need to use a debugger"
(or a sanitizer, or anything else where you care about debug info).
If you want the optimized builds, that's the default.

thanks
-- PMM

