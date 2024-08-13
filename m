Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF2C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoz2-0005Y4-KQ; Tue, 13 Aug 2024 06:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdoyy-0005W5-Gq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:42:29 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdoyv-000134-1l
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:42:27 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f136e23229so56205061fa.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723545743; x=1724150543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C5fQ45o2J+U/1zCwYss2nCd9u2Euo0dkvZvhMtBhwz8=;
 b=lsFs0TIsWjh7e63pWHWA+8NEEBzirnAISl1DCYLYkc8fEUMiA97C0o7yzQOszfIGHy
 DIbwIc3SVOg2qIDOoemgC8Lrdhci+cBDC4zVK+pONm98HvQD+8J1EgMURFjuEmeyARWl
 +O51oqssjxAot3Gwv1IAGnldzhgDvbm8Tt15/GsyuBBNR6405aN/vB1ipHFn0cBRJWA4
 7+WamNT6ZYw1BJdrLBJHeH1rvnUP14IpFy+WMg6tTt7aUVKRhThjjsO/PDKyTotG7m2d
 z1UvD65y3Jyl2BK/GYqraBzyn0hy4HmFUCv5yPYdz/jUdGvQXSvraCx7gX6kQYYroTKV
 /Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723545743; x=1724150543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5fQ45o2J+U/1zCwYss2nCd9u2Euo0dkvZvhMtBhwz8=;
 b=ofWTPEsRaPnzJIDoXoRre343g2632XwdFXvpowbot+r1gXIDhgDdnF4xwKYVcRuZUc
 5BazkU717yPzxWBflNcgcUNcVXgPWvarDtPYCXlkoSXeZKrRRDLi4bRfk9Ood3HlUao+
 /IASF2uZWxVMsS70/UJjaM2RiBos7JivoWg8K0qQoAv4cP+SbyWXUHgNIdy9A/jOV9uj
 0WBi7ktfP1bIdUzPK3R6pup97o+myuzzJoFVCoxV3KghOEvYBq5WSutyzGQr2LsckACp
 H8TiqlGpTp/OZxZdVLTYmb0lf+M3z5u56qie1bGvSyDTnj6F9JSCRsoZ2oCPHBycquAs
 jROA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNbISelI0I/xDNJ0F3LVX+puEZPYItl0ubvum9ga8gtaWcf5UJh5CpwlPbsEEwbDZWRBdoAKUzHegKgGZ8XugKUqcnBA=
X-Gm-Message-State: AOJu0Yyja/AmuGcKVKCChYiVP16I69fiv4grmgCbvjULEw7MzP1dUWCt
 qdIrhUC3fBqTQtMX29bNjIGXZJu6XHTt1OM4OXLKJpgIHrY8r5h6FsWkmzbuNr0mupSY3dhTwXz
 4ASGQXJoB4utkc5/5VbfTAwfpAvMWCzv6SdDi8A==
X-Google-Smtp-Source: AGHT+IG+Ytg7c21UeRhGfnlrUy5mlzGP1OyWf37Du3lUn/fmtXmQOzD947P2J175YdF9G+h2SzHl8+7TN7/8CHq0KhI=
X-Received: by 2002:a2e:9e88:0:b0:2ee:8d04:7689 with SMTP id
 38308e7fff4ca-2f2b7155478mr19797521fa.20.1723545742541; Tue, 13 Aug 2024
 03:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135550.3108739-1-zheyuma97@gmail.com>
 <CAFEAcA8uf-hSP7=w3om6XX7u+v_bQs_qvR1k=XhBp2bzF40Z3g@mail.gmail.com>
In-Reply-To: <CAFEAcA8uf-hSP7=w3om6XX7u+v_bQs_qvR1k=XhBp2bzF40Z3g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2024 11:42:10 +0100
Message-ID: <CAFEAcA8PuqAJX8Dk-6BYxGCNtTRKp50cRU0CUoCTG2wFec7CCA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and
 MCOSEL values
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Fri, 21 Jun 2024 at 13:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 18 Jun 2024 at 14:56, Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > This commit adds validation checks for the MCOPRE and MCOSEL values in
> > the rcc_update_cfgr_register function. If the MCOPRE value exceeds
> > 0b100 or the MCOSEL value exceeds 0b111, an error is logged and the
> > corresponding clock mux is disabled. This helps in identifying and
> > handling invalid configurations in the RCC registers.
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display \
> > none -machine accel=qtest, -m 512M -machine b-l475e-iot01a -qtest \
> > stdio
> > writeq 0x40021008 0xffffffff
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  hw/misc/stm32l4x5_rcc.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
>
>
> Applied to target-arm.next, thanks. (I added a line
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2356
> to the commit message.)

I've just noticed that although I said I'd applied this
patch it somehow got lost and never made it upstream.
I have applied it to target-arm.next for real this time.
(This is the second patch around this timeframe that I
discovered I'd somehow accidentally dropped, so I just
did a check through all the patches I claimed to have
applied to target-arm.next in the last three months
to see if any others slipped through the net, but it
looks like there weren't any others.)

thanks, and apologies for the delay
-- PMM

