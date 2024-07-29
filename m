Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102EC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMmm-00006O-8b; Mon, 29 Jul 2024 05:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYMmk-00005U-MN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:35:18 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYMmi-0002VK-Rq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:35:18 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso44804661fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722245714; x=1722850514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=If7VzGeDlPi3kEFY7/4NDlmmwVdFTFW+FmBsIS3GrTw=;
 b=NHkpZvpxmSqsVsMT1vSTyZJOFwohGiSDGhBBrMn9QmVIsKUg9Yk6vLX335Tb8gK/vJ
 wujYxO0fsnUQ2zDQrGqCZfieqoPkahSjnY5zQc6r3Y4+XMqkjPVItqkOYmq6Pgu+qR1j
 3cKu1Yvr8R/pezKEPZMsCc4TOBPcihLi3d8zh0RiVOTUuaGgQnNRX6vbBFsvQYyOz22r
 3Z97LlIiRqMgfbgw+mZjNFW37rYavGS3T4s690ManOxYArrzF95x2QULp9ORyqrqNY+B
 Ruc3APwCPqXjsJCwoToJLkQ/r57mLZNT7Fyz077cfHZepNmMU+YJMFgnvUA/+30a5S8j
 vXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722245714; x=1722850514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=If7VzGeDlPi3kEFY7/4NDlmmwVdFTFW+FmBsIS3GrTw=;
 b=E54ztkCF24NsrhTho3TJElBhl5ejVArb8pJ/mlnMkx/Qlvhwra8j4HGr45jfyNd2dH
 KEpZwP/SNcIPbOP6V8Y2tXhqGPOMJ0vB7H8aoAXEQ3IhMg9u3+pqs1mxGzXh1Algn3jF
 mVYhKIEk2Br1whJm/AIHx9UXbUQljkyy43Hngh6KYSGFr6a3oSE9fOSuyCUr8J2qz03t
 BJ2cX964iVP/Vnkbd/K2J9UjZumc8T9NUns1glq6PCLI5t0qESV1cj3v9MNTONkl1LVR
 6cPlWdiffogQjOJiS8BPElOf+gmDUvwAHK5fwjKj/DqMTRAggoGdim+nnn4sDcqyINh3
 cNyg==
X-Gm-Message-State: AOJu0YxdwWDoup/ToKhJPs/19eWjXjRbddlOlqesKY4via9MeQh3Naxc
 lM1AbAZLnMCNpkrrHmf8RCkqTNfE2ng+Af+FLYWb9FSWk0c3I+3yTWwMi//16GGRFrkAfAgOo2h
 ri+zY39cW7BuMkCqOQ0dux0gJESyyR6O4/PL30w==
X-Google-Smtp-Source: AGHT+IGeaSALdCWJgy0lY9jO/vIjfuEElgIJlxzllalyIiUJxdbUaDh1iX0xWrpypJ8AOhi8LjY2yDci/ggll2in+kc=
X-Received: by 2002:a05:651c:10b0:b0:2ee:8d04:7689 with SMTP id
 38308e7fff4ca-2f12ee068bbmr45667581fa.20.1722245714141; Mon, 29 Jul 2024
 02:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240723070251.25575-1-kkostiuk@redhat.com>
 <20240723070251.25575-26-kkostiuk@redhat.com>
 <CAFEAcA831S0wGbyLwDK7yVeEoi1SFPD7gpYribNqP6AmyQHN5A@mail.gmail.com>
 <CAPMcbCpfP-XX0RsTerdrSunb9Z772efCGKf5h2ju7JQdygvDtA@mail.gmail.com>
In-Reply-To: <CAPMcbCpfP-XX0RsTerdrSunb9Z772efCGKf5h2ju7JQdygvDtA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 10:35:02 +0100
Message-ID: <CAFEAcA9CyhYRZz0kK_oB6WKQF-3EZsEg88mdFWoDzQoF6ZfYAw@mail.gmail.com>
Subject: Re: [PULL v2 25/25] qga/linux: Add new api 'guest-network-get-route'
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Mon, 29 Jul 2024 at 08:40, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> Hi Peter,
>
> How to see the full coverity report? In https://gitlab.com/qemu-project/qemu/-/artifacts, I see only job.log
> Do you expect to fix these errors for the 9.1 release?

Coverity errors are in https://scan.coverity.com/projects/qemu
 -- you can ask for an account with the project if you want
to see them directly. But I think you have the information
you need in this email: the actual coverity issue isn't
much more informative.

> Do you expect to fix these errors for the 9.1 release?

No, I post these emails to inform the people responsible
for the original commits about the problem so that they
can provide fixes -- after all, it's the original author
that knows most about the code and how to test it.

thanks
-- PMM

