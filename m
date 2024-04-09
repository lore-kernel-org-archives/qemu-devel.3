Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E46C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBix-0004rp-H6; Tue, 09 Apr 2024 09:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBiq-0004j7-Ce
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:41:13 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBio-0000S9-GB
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:41:11 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516dbc36918so3907402e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670068; x=1713274868; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4D3FSC9ddaqc6WPgOycbKu85N6QxdHBgLlA9EjGP3hc=;
 b=LMXC9g01p0azmO+mrose5NdJdXfyejKXIdmZDH0f8qFD9GpA59/enAWmgXq7jKVA0B
 o2UoA/WEcOPW5YiujPRTz7giT7htZwfj3OpkMQfLgsU4A/VkocvCzmeqRJ+Yb3KjY5W4
 hvkiMfmKnKyfgJlXFnLKpEcMrDfvwHpa8uM5IjMRkGI3C9p8Cs3XXLP6vj0yW70vOVOA
 Gq6q1KF/na+AgCAoXVidDGqerBNukNJuwD0h8+2t6CF/G0n+XkmUe8W72Hnc881pLvx5
 4SpCNbScTkgl8VcnIg6FrDAsl5UXaCY86fTVrIJqddpNNXAWDcLf7GcD5m41ueuH2TMi
 SM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670068; x=1713274868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4D3FSC9ddaqc6WPgOycbKu85N6QxdHBgLlA9EjGP3hc=;
 b=THKsF3vnY4Qewab876ANQR4eDkFpWWTidOEBUsx0QYPMPxznPCQdksbk+oH8zA9OF0
 fFiM/SupBDnYJbOAJq4G5H+XazBvv3jD4YoxWdUy6rJDavtJ4Yo3McvkPxIHzxunRiph
 U76tDs7N5Jl8cFYMFBpywDml70PWlnDiT3YthpotvYRTomAp5AfUr1JLp38aVZMO2Hes
 zfXWgznPN48OgsyHzUQ/I2N03Ug33yTjiM96nOpRefv6SSRHCJ5c8satFdGd9ffzqU96
 DGB6oP7Ecubdjg80cqaIGsmdUHNwCUOhzCE+iJZx4xgB+WP3jcvp7fbPK2SE3mEvcYAd
 mdAw==
X-Gm-Message-State: AOJu0Yxomj0PlI3rWQmusS/YQ2q5IzAqu4sgioNQvEDMHVLvGCDXAEq0
 n0fZ7YgXlBIzoHrL0wTSS+/l6JGJje4DmRlxPDLVgYzP4haoOjxmwP0uVgxjJRojw8MiC404C6Z
 rR20rly0vt+oEyplHECWPbUDeipyIa1l7dLnzLQ==
X-Google-Smtp-Source: AGHT+IFtqvydzATUTkgYNIRluPWXAbi+QigsX485PSVqCKx8MVpzi50SzerBqqMPKP7MKGNr3H627OhqdEXRNLsb9wo=
X-Received: by 2002:a05:6512:3da7:b0:516:a978:7b06 with SMTP id
 k39-20020a0565123da700b00516a9787b06mr9593784lfv.5.1712670068446; Tue, 09 Apr
 2024 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-2-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:40:57 +0100
Message-ID: <CAFEAcA-CVN_5ZFbd_j3_b4cKG1xpggM6sPmeGxWJs9r1oL5iLg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 01/11] hw/net/lan9118: Replace magic '2048'
 value by MIL_TXFIFO_SIZE definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The magic 2048 is explained in the LAN9211 datasheet (DS00002414A)
> in chapter 1.4, "10/100 Ethernet MAC":
>
>   The MAC Interface Layer (MIL), within the MAC, contains a
>   2K Byte transmit and a 128 Byte receive FIFO which is separate
>   from the TX and RX FIFOs. [...]
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> (Not including Peter R-b from v1 due to semantic change)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Though the use of the constant in lan9118_receive()
reveals that our implementation is using the same buffer
for both tx and rx...

thanks
-- PMM

