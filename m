Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8510160A2624
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gxfcb3M0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUZ8-0005an-W0; Thu, 12 Nov 2026 08:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUZ7-0005Rm-Lm
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:10:09 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUZ6-0001K5-3l
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:10:09 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67c58f18765so2153618d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:10:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489006; cv=none;
 d=google.com; s=arc-20260327;
 b=RkJhYFfXSqTpL7wZYkSVgqyPAmsrj4ir84x5JMbYgoEP09OqgI91MwXWeEeFrTbnqA
 H/LSs48YC9abEuyCv3Bf0TdDfV+Znw9iO8817i/ng/ja5T+RWZXplzFVjhKwy8XkAb+G
 qux4ww7AziPPgzJy2Q7ncAYxQqIzzCS979RsjJ1v6RvUhm4keEw+E85lC0iCVdvZLAWf
 4HgiBYCZsfP73B2CoOXiNifEB6zO5/uVjU0GsvJkctfBLI5ga7lDwYoTJCiJZgK/aiCk
 wvIMRcWF5aZiBFoXZRlEzwgB4idZhTVhKhcvO0hYl4CGzurgWHe9pPNaxNm3gKIX0Fds
 aKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nMySanBpzNXfKjFd7aBQpGBvl+mNf1G+VUmyrU87fNY=;
 fh=xbolnpngYKBk2bdOqpUMvYyceghjRAVxcwW6iR74abI=;
 b=J24RyUPsnpOg2UdRag9QvKnHKw2HuShQm9cGbdGUwnQcinY7IwFb0ATs5HnMdJ+/bM
 1GvzjVg9OF5zU/l/lZnODr/zYOBTHYqVxi7hGIFxkslZenqOAu6+0QXA/W1vEjSSI6ax
 UyYA+KjVcDIQ2Q1YZhHPmh6c3WtCSXDFClGFfAP3+9uxt93hhiZTSn8V2dOGE8+5prR4
 BfvgJUmZyiZCRJ/KIkytaRX7x9KloD/41rjM6VGAYzk/Ho6Ezfo5dxd3VJq3s3kxMMDk
 0e4NMAqTLUgbEstY3ly8nwQ3XM9A8VSR+WG9c09sGGmyoHh+6y2BLOnbjQV9smXScxYz
 Ddqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794489006; x=1795093806; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nMySanBpzNXfKjFd7aBQpGBvl+mNf1G+VUmyrU87fNY=;
 b=Gxfcb3M0qNg0nS6qw6JcrOsqJ1lJ/SPjMDROt1QMu2nfntK19mikC01ojlRziX9fzM
 6MR1+7oMo1TFOuWywaK0yPe1ilYIsr79NsJDx3KRGVyGI69ra+VJ7+e2Ko8G2o1UEHre
 p/S9zBtz/i4rGa+LIZMTgNyK/5Z3mlXD+cxj/9PPw6jXelyvFvHGSY+Q4eyYlGk5V8nk
 H/TqUT6lwwHec6XP/uZmsrGSPOweJI8wT08x6+8ZB+kDBXDnYhHm2gVDSsvKCvHKRmIH
 Yqev3ZbCdZaazr3xLVn5DIMTsO/t/9UUP/HjeV+bYk3Tia/d55ZTLqPctv4VATXYnnGP
 qK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489006; x=1795093806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nMySanBpzNXfKjFd7aBQpGBvl+mNf1G+VUmyrU87fNY=;
 b=oaaH0yVaCj78KAJ92bnhvdUr3DgKS0s5wIV/QVNn00uUa1JHHPLP+p6C7eO+LjZkap
 2kP1d2pG6iThJZMqMvgxpYU4sK2UEGB4nSi6ovmyrI3OzE1wTnmugbgruCtxMr+Mf4Vv
 bPokoumiw3M2MYb6m7tK+4N+dspFIsglUUkT3HJ0DZ39774Afwjt+OVcSoa/x4K0LkYk
 4ed6D2bwMq7cWkwtp6B2yfgqeoo9xI7mYJszVqy4UPX14c0aHMWqtdSpEQuIpo893CvL
 PMD8GivBPsR2khd0fKSU8I4y9PV9Fuk3M1JOV1nmo1oTQ3mPayjKAB0nei8kpSbVENqO
 vDgQ==
X-Gm-Message-State: APuU4Z/ouqnYXY2ykTzb+kiv2UBi8iiUYjCRF8V0W40/QTEj9I9ZTGQv
 KpRoNet5nVXPjkLVyLZSJXU2GbDF101x7nAZpKV6CI76q5qmp78UqxfxRHHH0a23UplWqTpy4Ir
 OohJeyDIuFvySFEmabTtUqn0Vi1bo9fdpiwIhWPiveg==
X-Gm-Gg: AYBFou2AAxptp2p1hXaVka7tWDllMP7HVr2QiOD5c381yQMtbiYRrDiQKc3q2d2bjvL
 MWI2YF4BjzYM32x4/6K11YruO1NJv93wE2+L3xqZmeRS2VkhhQuONA3SJNHRPiAMuV6jMpoSnwQ
 dMkpvAf/Hqa3GslMHrMvYFybaq4wlOgD3PgWy23lwJ6yQOnmks29GbQk95GaHYzbX5YhUWkhWrJ
 yOCLPoriB25ffX1Q8BqbnM+MkjgISz+IkcAjdla59DWR9aW856t2px/kDZsPiqnngNoQ1NCqAqq
 v0G+3VD/MDIR7u9G/HM3BwvwS7C7Aw7aTV3FZE09Nmn902A1Qa/iyfrzgb5v6H+Qw9l9aXTKQNP
 lgMHP7u1tVXtBgX6Kjtt8wnIkUtei46cirpyiCCUjqpmlUjqlvTkjTAMXPNloRXL5YmOaGTHUbj
 ZLF1j0UbW/WHpiGSg4MMVd
X-Received: by 2002:a05:690e:12c6:b0:677:aee1:9f2b with SMTP id
 956f58d0204a3-67c67ca7a90mr3362603d50.12.1794489004820; Thu, 12 Nov 2026
 05:10:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021065238.15220-1-conti.manuele@gmail.com>
In-Reply-To: <20261021065238.15220-1-conti.manuele@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:09:53 +0000
X-Gm-Features: AclHuK91k_404xGNPKVDV0IIvjhlkMoTqmp0kq7EQAV1TyitwzdpdyAmAk6MtHY
Message-ID: <CAFEAcA9=pt=81YWPXEZ+UEnL5iVbqFAjxbMYtH_aoJHy4iAf_A@mail.gmail.com>
Subject: Re: [PATCH] hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads
To: Manuele Conti <conti.manuele@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 07:52, Manuele Conti <conti.manuele@gmail.com> wrote:
>
> Writing SPI_DR already performs the synchronous SSI transfer and stores
> its response in spi_dr. Reading SPI_DR performs another transfer, using
> the previous response as transmit data, and returns the new response.
> Consequently a normal write/read pair clocks two frames on the bus and
> can skip bytes in a peripheral's response.
>
> Return the response saved by the write and clear RXNE without starting
> another transfer. Repeated reads then leave the peripheral state alone.
>
> Add a qtest using the upstream netduino2 machine and an M25P80 flash.
> Check the JEDEC ID, RXNE clearing, and repeated DR reads. The test requires
> no board changes and reproduces the unwanted extra transfers before the
> fix.
>
> Fixes: 5ae74402d1f ("STM32F2xx: Add the SPI device")
> Signed-off-by: Manuele Conti <conti.manuele@gmail.com>



Applied to target-arm.next, thanks.

-- PMM

