Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2987BCF9C5B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 11:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sry86-000466-2n; Sat, 21 Sep 2024 07:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1sry83-00045c-Gh
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 07:18:19 -0400
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1sry7y-0002Pu-Jm
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 07:18:17 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 9304A80024;
 Sat, 21 Sep 2024 13:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1726917482; bh=dK/yPxXPauAEim6HBUPxRz1AFv3b62eYEFHJAy5aWEo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=DCPyiKfG7O/zAlM7trar3sh7c6wszT3vUtuRdcHVUbGWVbLWgrxkHK0f356nF4dro
 mD3XjA3AUZ8jPlrTL3znf7NuGB77WtZGT1vwaX1UYUD9vSlj/pnkcFkAsZtmEwuv2s
 +1Adh7aGhxHQlmabozY05RyfQ6h/D1T+LTc5yhHPqnKjxEerkmgpByZ0pgZWEpcqJT
 U5Dd/LLaOWVqQlE6/E03orETt4WTnWmyzCdOip8gIttd30GpTxlM1TKe6k+Cdanngn
 VSbbVBF/eVp/++csOwjeBBPtuq2frfWSUQ4QPiGBZMTr1i01uhO7PEYvCG2B48soQ/
 BL3YnZk89EU8w==
From: Samuel Tardieu <sam@rfc1149.net>
To: =?utf-8?Q?In=C3=A8s?= Varhol <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org,   Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,   Jacob Abrams
 <satur9nine@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A
 maintainers
In-Reply-To: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
 (=?utf-8?Q?=22In=C3=A8s?=
 Varhol"'s message of "Sat, 21 Sep 2024 12:47:16 +0200")
References: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
Date: Sat, 21 Sep 2024 13:18:02 +0200
Message-ID: <87settdzmd.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
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

In=C3=A8s Varhol <ines.varhol@telecom-paris.fr> writes:

> It has been a learning experience to contribute to QEMU for our
> end-of-studies project. For a few months now, Arnaud and I aren't
> actively involved anymore as we lack time and access to the hardware.
> Therefore it's high time to update the maintainers file: from now on,
> Samuel Tardieu who is behind the project will be taking up the role of
> maintainer.
>
> This commit updates maintainers and the list of files, and places the
> two devices in alphabetical order.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

