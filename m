Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C2BC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGbaI-0003FU-8h; Mon, 10 Jun 2024 05:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGbaG-0003Em-It
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:45:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGbaF-00078D-68
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:45:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6efacd25ecso113185366b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718012696; x=1718617496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0NFYCIKqTZgwbQIGQ/4PJbgTlziDtsWEZQH+G8HZYc=;
 b=XDQDqTuxGnPjl6/hQGDpqm2iGg0+KzRBv2Jo1aRr5Vg29K6A5UHslzmBP47qOok4Ra
 kQD/+RTtyI4R6mdEqcbn8DmAjKmgQ0H0vND1TTH5CPrf8/ykxjHXz5kKjKeLlYmWOb/H
 5whXNSTkyQewHwdJsu6wmiJEkdeSRNhN9Ia8eloB9aMN26bhkk+ZaZdcXeAwtTHifLa5
 Ic2/S+YfbUirQjzZlP9RoxwXRyolrsIUjnEd7Y2fvjcSIqoxYpJAt4VKYemEHkTmjBJ7
 v7rqvvU9rUlf757C6xFPmjD91xWP36CcmZq7G+KMb1bnEjiW6FqxQ3OpovgL3oycjzeN
 L/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012696; x=1718617496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0NFYCIKqTZgwbQIGQ/4PJbgTlziDtsWEZQH+G8HZYc=;
 b=JB6nljSVp+UHBRndn+Fx5eqkf2r9iRRoAcLKtqUt8QkwIYN3LzLtQEupHmqBRfBJqY
 xuFzRGrjCpWNBtjiYTsuJUBE1LKm5ZPu/q5Qf44HCO/LEchdNT1Z+RD9j/PjuM6GO8a2
 EDfMqdYT8+J9iHmxHonh02KNqJCHJvL8Bc6SV0/3e9mcS5jbiITwHP+m7jWsXx5EKEth
 2cxMBM3grNixACQisUcmAL4rhwaGTG7BDuPFrElowp1vYic+4Es/hklLKif0LZVNFA42
 vkYLaVF4MB2BKkWvSfsaEMjaIQAYciYFzTej9gHuhPmIPjVhwP8Fi4+gqFazC3zN6dv0
 F5Tw==
X-Gm-Message-State: AOJu0YyvfOCoAkotZxmqv2ANWvo5MaAO4/UnDmef7LnfzdRpiJPY1lvZ
 EHgl1e2jmEtTXxJxzsCN/K6ZZyBwhon+HKTc0AJfRuk2A5IdVQSPaZyeqNRexXIfZ5rKzbzpdjU
 whl5qUEzffaD6EZc4j4zeAWPxZ2Jyns8TrrHGMg==
X-Google-Smtp-Source: AGHT+IERwIuRrjbVPEb1ym5Xm3fIUD+rdCuar13TjIIxoeVYirGlQUGbQcI36Q+yQN+I8YUFfhAqJ+yIdl9q6k7rmlA=
X-Received: by 2002:a50:bb28:0:b0:57a:4c22:b3 with SMTP id
 4fb4d7f45d1cf-57c5085e6ecmr7783108a12.1.1718012696391; 
 Mon, 10 Jun 2024 02:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240610094049.851127-1-berrange@redhat.com>
 <20240610094049.851127-2-berrange@redhat.com>
In-Reply-To: <20240610094049.851127-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2024 10:44:44 +0100
Message-ID: <CAFEAcA-d3ZRLY24p_LGw0_WvqZaNYgQbR8s_1f_tK7y159TYqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: avoid leak of ctx when bad cipher mode is
 given
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Mon, 10 Jun 2024 at 10:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> This fixes Coverity CID-1546884
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

