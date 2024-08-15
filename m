Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF579C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebIo-0001Fw-0t; Thu, 15 Aug 2024 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sebIm-0001FS-7B
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:18:08 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sebIk-0003MI-2n
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:18:07 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so1223911a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723731484; x=1724336284; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p0baqdfrh5sYCuHyOSIqoPgx1xZ61orTgdUJ39jYQt4=;
 b=D0hGDBM162JfVBb0SlEVluFu66RfawGXijQZ1XWmy2v4zpFjQRiG+rcjbV0tjjoMMh
 mlLbtmwYeckcDoIOKCmzU2L2WIHwiMMlv+yH2ulNcYM1hIQWb3XCIpC0XEhhy1IJEVjJ
 H3aJ4PvxQxnmhcRRPNxB3QrZtyHL5FZGpq04Us/64lFhWStKZDaxwE/MJujvOm7pRh0/
 ahR7kmROMrTafs9uzulJzlIvr5KgTyIMMhfj6lUq74y8hl2B0W55rt8TCgkURshd99tk
 DCgt9uUlOOK8Vm5qpIbm1eYSE5qAX1V+CPYSv3ldN7QeJ/12vlgmvOR7tLOkelY2HxSb
 wRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723731484; x=1724336284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0baqdfrh5sYCuHyOSIqoPgx1xZ61orTgdUJ39jYQt4=;
 b=TAS7thoY4bLf09xZCdkJpNyE76OneMPysyzPkrrCQCAUNuFVSL1m+bAhIOAHbCL4U+
 xk+TkNUAbhza9qSdgkYpi+HJm5i06VECqdww/HLwOlalwP+DcouHHihi4rD3sN0ntOw0
 ynqr/380eGS35pFejJBF1DNDzSIXyCrOIvUOhTrtnpVCGSmt83mcVyt6GbHKLKQbSPzW
 QzbqXS1TQOvjb2aWxl6yI7Yn20aahZN5oNJRIcZV5yZX4YeO0i4B2aN8jell5T06yWKN
 HIeTwDQAbPKPAiJlzWTY1aC5LTOS5K3LL1o/0mcRAwSk8njDGKgZwsbO3FLF51TrVFVQ
 dgXQ==
X-Gm-Message-State: AOJu0YwLV8YRtaYGeVaZUQqz9JJANv9QMOvOfX8VCG8IDPyn0f4xQUYZ
 XguhGBrRyzHGWLlA+g6PVZJc749uyYJEgJJZ/NZqkv9LhAyM2F9kFkCAP1uNHgWi9kcWCufNVUL
 GuQ83Gb/xqN3ts8d304b5wO8E6eSYr0rlPPGUhQ==
X-Google-Smtp-Source: AGHT+IEJdR+P2C7CjfZehXNXXULg1scJabnzY0ppbSC8xZ56/2q+RbqovHB04IitkOZSx9zI9BBje+hcuT+k8hSXWG8=
X-Received: by 2002:a05:6402:1e88:b0:5be:9c56:3ab with SMTP id
 4fb4d7f45d1cf-5bea1cae111mr4487388a12.27.1723731484226; Thu, 15 Aug 2024
 07:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240723070251.25575-1-kkostiuk@redhat.com>
 <20240723070251.25575-26-kkostiuk@redhat.com>
 <CAFEAcA831S0wGbyLwDK7yVeEoi1SFPD7gpYribNqP6AmyQHN5A@mail.gmail.com>
 <CAPMcbCpfP-XX0RsTerdrSunb9Z772efCGKf5h2ju7JQdygvDtA@mail.gmail.com>
 <CAFEAcA9CyhYRZz0kK_oB6WKQF-3EZsEg88mdFWoDzQoF6ZfYAw@mail.gmail.com>
In-Reply-To: <CAFEAcA9CyhYRZz0kK_oB6WKQF-3EZsEg88mdFWoDzQoF6ZfYAw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2024 15:17:51 +0100
Message-ID: <CAFEAcA9v2An2=P3aTNbv+z_a2nk6xQ+f-b4B6Ci0rWO2Q=C18A@mail.gmail.com>
Subject: Re: [PULL v2 25/25] qga/linux: Add new api 'guest-network-get-route'
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 29 Jul 2024 at 10:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 08:40, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
> >
> > Hi Peter,
> >
> > How to see the full coverity report? In https://gitlab.com/qemu-project/qemu/-/artifacts, I see only job.log
> > Do you expect to fix these errors for the 9.1 release?
>
> Coverity errors are in https://scan.coverity.com/projects/qemu
>  -- you can ask for an account with the project if you want
> to see them directly. But I think you have the information
> you need in this email: the actual coverity issue isn't
> much more informative.
>
> > Do you expect to fix these errors for the 9.1 release?
>
> No, I post these emails to inform the people responsible
> for the original commits about the problem so that they
> can provide fixes -- after all, it's the original author
> that knows most about the code and how to test it.

Konstantin, are you or Dehan planning to write fixes
for these bugs?

thanks
-- PMM

