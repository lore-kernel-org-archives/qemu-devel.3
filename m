Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30256E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 08:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFnO-0005d8-VK; Mon, 13 Jan 2025 03:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1tXFnG-0005Pl-MP; Mon, 13 Jan 2025 03:27:30 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1tXFnE-0002qr-6x; Mon, 13 Jan 2025 03:27:30 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 905E080026;
 Mon, 13 Jan 2025 09:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1736756838; bh=171NA4ObttKY54K4Vx01NswlNwiQJc1fA9xz2eOSMCI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=anu4XebCVxT05MPQvgD1RoT0loY9qgoaT8ztj2Yy0RkohVkvQqnvNGEoAj16ZvF9D
 mkEDCxYOMdocxZ/AAu0LMdN9H89RwGoDJCjh8h8WK3g8dpHm06PAbStDuYmjqkX4zy
 yDyQjmg+orvUESL6u2INKtRatOZ1pEW9vA/B4//DV0XwifqlaCKX3NFod/gVR3dVFo
 vbQWTzfjDoUEJGgbcvslg2Z6FZBqGeCXwU1AA2PC4g7KWS8tuYVusYNRynrGLcvJSx
 /pnN/GW+dzs+ukFKDKlSm93uPXsHT9em7tmUJ8turrgoiHLmkcKa2XT/CvbgocfaHn
 k532XryGCtZKg==
From: Samuel Tardieu <sam@rfc1149.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,   qemu-arm@nongnu.org,   Peter Maydell
 <peter.maydell@linaro.org>,   Felipe Balbi <balbi@kernel.org>,   Subbaraya
 Sundeep <sundeep.lkml@gmail.com>,   Alistair Francis
 <alistair@alistair23.me>,   Joel Stanley <joel@jms.id.au>,   Alexandre
 Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 3/3] hw/arm/v7m: Remove use of &first_cpu in machine_init()
In-Reply-To: <20250112225614.33723-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 12 Jan 2025 23:56:14
 +0100")
References: <20250112225614.33723-1-philmd@linaro.org>
 <20250112225614.33723-4-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 13 Jan 2025 09:27:18 +0100
Message-ID: <8734hnt8yh.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> When instanciating the machine model, the machine_init()
> implementations usually create the CPUs, so have access
> to its first CPU. Use that rather then the &first_cpu
> global.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Samuel Tardieu <sam@rfc1149.net>

