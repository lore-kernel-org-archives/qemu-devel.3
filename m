Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02BBE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUozr-0003m3-PR; Mon, 06 Jan 2025 10:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tUozq-0003lb-6A
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:26:26 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tUozo-00056g-7d
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:26:25 -0500
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-215770613dbso155086735ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 07:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736177182; x=1736781982;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XF3FgtYVetN37eCpFJOcTyDP4OVBSK8Ubb35FdoFTkY=;
 b=JFLpSs8HpNOjjnN4smo5MdyZErTRITjtnNk6ZdsAi5sP3t95Zx++O2CLdhLpvuAqqs
 dZrG2AtsQStnfn1O/a8kbDsF/vAu0rEj8SE7/8xfRWzk5pQiipDz5+OfhBnM4TkUoW/C
 bKpwBI0AeKHEmIgAAgqifcvAgcjbwchUOVEq0gPYyM3Fuyy0cFvlxo3J3Mw82phWb2f2
 1fZAJvivHoiTFzo5dqhijOAYdJhty8tOjHmYo5xBP2om/TaatF27kerkK1sUaJlctcRU
 WKgkY3O6N/9aB6smX+5DWwi6iFXtpwpy9C5DTRms75K24UMH8bCnRLKote78h3Z8K4Zh
 Ljgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDCxoyIcuIpk2qupzSnynu/gSlYkH67/1gAjsnYvsLUaVKfYFAKoVcJBcdZzyt0laWQhRTro321B6y@nongnu.org
X-Gm-Message-State: AOJu0YxIcqZXPVnRRamZrapQ8EVnovFx9ee9P/VtMw8EGhIAtdGFlSkq
 xZUmxHMDH2ti5hzFDOKGN9xvplTofKwjfAollQTUCOKoz3WaHVcXRdDDAw==
X-Gm-Gg: ASbGncu85y5IJV5Pqeo+lnWEvgpn4TCEqBC8/VQjOcIJ7VbCxtxVQt4nqeb/yIpspbh
 vZ4RrasQgOAOEfRGg8iZtbAObC95qOtwlQgVTxxCh0u9EOve6c9IVwli5mOv4CorXzxoPcFWMBS
 eUQjYCSxd9szS266n9GoKMGhsFpOniw1QGaQbjNmGzVwEMMk+ohQXqtQzMJNv+r9lHQeYx2znWf
 qMju0EP8DyrJ+yawx9LY7bFpsqlJQsCQ2+nCmBR1mMJzEzTCg0yP4gAoHdj36qySFOIxef3zoVB
 mrVftx5jLMD1
X-Google-Smtp-Source: AGHT+IH8kDmgdQ+4rhOrk598RO3UbcM7T6ftBiabNexP0oV+6Cg6G/sPB3+nE+fgp4q5dLhxu4vMTA==
X-Received: by 2002:a05:6a21:398:b0:1e0:c56f:7db4 with SMTP id
 adf61e73a8af0-1e5e0447f3amr85504294637.2.1736177181879; 
 Mon, 06 Jan 2025 07:26:21 -0800 (PST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com.
 [209.85.214.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72b5bde56f8sm11321372b3a.162.2025.01.06.07.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 07:26:21 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-21661be2c2dso190504545ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 07:26:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNMzAeLeHGw/nvfbD4Y26IxEVNNEq+ScRNPutHESBYQ+kLt+2qmuoYoYFma1gbuyd1u9P4bQo3RjkM@nongnu.org
X-Received: by 2002:a05:6a21:3a94:b0:1e0:c378:6f5b with SMTP id
 adf61e73a8af0-1e5e081c6b2mr101234026637.38.1736177180921; Mon, 06 Jan 2025
 07:26:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:6709:b0:5c7:c9d9:22b0 with HTTP; Mon, 6 Jan 2025
 07:26:20 -0800 (PST)
In-Reply-To: <CAFEAcA9kzT2qwThGFvNmZ4VQgVEA189dmGYwHu-FZftfJFAU-g@mail.gmail.com>
References: <20241223040945.82871-1-j@getutm.app>
 <CAFEAcA9kzT2qwThGFvNmZ4VQgVEA189dmGYwHu-FZftfJFAU-g@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 6 Jan 2025 07:26:20 -0800
X-Gmail-Original-Message-ID: <CA+E+eSBMNgxptk0RzKVMuvuBJ9XZquooCxabDB8ezWjmTa4R_w@mail.gmail.com>
Message-ID: <CA+E+eSBMNgxptk0RzKVMuvuBJ9XZquooCxabDB8ezWjmTa4R_w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Disable unavailable features on older macOS
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joelle van Dyne <j@getutm.app>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000022dd9e062b0b40fc"
Received-SPF: pass client-ip=209.85.214.175; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f175.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.179, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000022dd9e062b0b40fc
Content-Type: text/plain; charset="UTF-8"

If the policy is macOS 12 or later then you still need patch 2-3 because
currently it is broken on macOS 12.

On Monday, January 6, 2025, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 23 Dec 2024 at 04:10, Joelle van Dyne <j@getutm.app> wrote:
> > Some features require APIs introduced in a recent version of macOS.
> Currently,
> > this is not checked anywhere and so either the build will fail (if
> building with
> > an older version of Xcode) or will throw a warning and then crash if run
> on an
> > older machine. The correct way to handle this is with availabilty
> checks. The
> > checks are a clang extension that only works on Apple platforms but
> these files
> > are only built for Apple platforms already and link with Apple
> frameworks.
>
> We deliberately only support macos 12 or later and don't want
> to carry code workarounds to build on earlier versions
> (see eg commit 3bf445fbb1 which removes old ifdeffery needed by 11).
> This is part of our "supported build platforms" policy
> documented in docs/about/build-platforms.rst.
>
> thanks
> -- PMM
>

--00000000000022dd9e062b0b40fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If the policy is macOS 12 or later then you still need patch 2-3 because cu=
rrently it is broken on macOS 12.<br><br>On Monday, January 6, 2025, Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, 23 Dec 2024 =
at 04:10, Joelle van Dyne &lt;<a href=3D"mailto:j@getutm.app">j@getutm.app<=
/a>&gt; wrote:<br>
&gt; Some features require APIs introduced in a recent version of macOS. Cu=
rrently,<br>
&gt; this is not checked anywhere and so either the build will fail (if bui=
lding with<br>
&gt; an older version of Xcode) or will throw a warning and then crash if r=
un on an<br>
&gt; older machine. The correct way to handle this is with availabilty chec=
ks. The<br>
&gt; checks are a clang extension that only works on Apple platforms but th=
ese files<br>
&gt; are only built for Apple platforms already and link with Apple framewo=
rks.<br>
<br>
We deliberately only support macos 12 or later and don&#39;t want<br>
to carry code workarounds to build on earlier versions<br>
(see eg commit 3bf445fbb1 which removes old ifdeffery needed by 11).<br>
This is part of our &quot;supported build platforms&quot; policy<br>
documented in docs/about/build-platforms.<wbr>rst.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote>

--00000000000022dd9e062b0b40fc--

