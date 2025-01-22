Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01732C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tac5U-00072p-Vb; Wed, 22 Jan 2025 09:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tac5O-00072T-QQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:52:07 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tac5K-0005si-Kg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:52:05 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so9639070276.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737557520; x=1738162320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKj6EHV3/XlFidv4VKWpVf6xQFnfob43lpLrjkCJUDU=;
 b=AyaMl8Qt04GyBJPGVFBoJ3fTjoqM5hQHTjxR8udWuNAEXy5VknRi19l2KmfWMunpHP
 y8iwJRhTSHutZ7wopwvfSmeQrIn8SLBmgi0iQMjQcbYTOy/uwzvh62Jm1W1uuFMiYULO
 +n1kJwr1xp2lUjdb9cBsLpgB3GIxspVmfnE6xT3sU62TSqZf4GcwLs+QskKVPhcnBb8d
 K2JsLiDCykKMMHjtWaAxYODGCPxcfodGrERC5hgnI85XA9wlZkc5mu0772x+ujB4Sqns
 PMYXcKIVebfy7I2ANVapIQTDEQUu/1Q6gUrSEe/UxY+IAW+gRalLWM3XB50LvaUcgUTT
 PNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737557520; x=1738162320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKj6EHV3/XlFidv4VKWpVf6xQFnfob43lpLrjkCJUDU=;
 b=k+wNPYxQ7nsO8PNWovOKn1FgRiioZTe6r+10fzlBj1/Xb77dBF67UY9xpzLUS+SVgZ
 uD/SfkfXO3DiwWkbifG2fdqsu46YSDjMSMAhnaatSqibOAkpXd4Tkb0KkWqMSYhYNxZ/
 DjRRMllVIZeD7zudIMUf1/0XDxXZxCLjQgK4aspGRsqllHsavxMoHzk/VFIKk0mmf36T
 vswkjYbWF35HVkTFctCVhXTDVRiA4WtIatso5tFtiC52xGjU6wTb4YRq8GFUGWhPkr4Z
 PU4091IHPFtcy2yh3OwW2qA7C04vAzIFMyxCAWNNvW8qB1PZbJh1jCsTbpBsJiwR/+84
 pxTg==
X-Gm-Message-State: AOJu0YwX60ee7KFYibEY63dlmqLLfUNnn4VxUyX5Ut2p6CL4hMkZ9q+H
 pTeR7KCvhSNf+GUzck87PwPbg4blDybsI2ZCOmqSBJL/kVgLhXpwQyVh/QPw8zl5GzEF6kq57Hu
 YnUbs37yX86TGtzdtLZLYw9+xo6PAQwQXYP1lCA==
X-Gm-Gg: ASbGncsmzMQXsROg5xKaLZIFvlxvM31Hjt5mHr3SmZXu32mI8yJ4yUijrNwKXR63dFu
 InF4XPbJKrOvnSg4ygazwG8DGWj5J8jQLJyrEk2eUWd+G6wy/0fjJ
X-Google-Smtp-Source: AGHT+IHgpBxcSo3M1Bxkxfd7LTijfUJ6dC04J9VUpXfLNup6Fi4o/wIBECj3nqawM3MUEc8izHoiQAJKxkiwPHbgY0Y=
X-Received: by 2002:a05:6902:110d:b0:e4d:25c6:c398 with SMTP id
 3f1490d57ef6-e57b1039e2fmr14495454276.1.1737557520489; Wed, 22 Jan 2025
 06:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20250117124136.3389778-1-berrange@redhat.com>
 <20250117124136.3389778-3-berrange@redhat.com>
In-Reply-To: <20250117124136.3389778-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jan 2025 14:51:49 +0000
X-Gm-Features: AbW1kvYxLoJnIFeQntCXwDjVICF5Te6u6cWPoBXmT-DE9qZznDdddwJdhuPL6ZA
Message-ID: <CAFEAcA-EcgVO1PeY11Nh2H7K65ST-QV9k8B6SfRnZ=SNaEUzJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] scripts: validate SPDX license choices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Fri, 17 Jan 2025 at 12:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> We expect all new code to be contributed with the "GPL-2.0-or-later"
> license tag. Divergence is permitted if the new file is derived from
> pre-existing code under a different license, whether from elsewhere
> in QEMU codebase, or outside.
>
> Issue a warning if the declared license is not "GPL-2.0-or-later",
> and an error if the license is not one of the handful of the
> expected licenses to prevent unintended proliferation. The warning
> asks users to explain their unusual choice of license in the commit
> message.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

