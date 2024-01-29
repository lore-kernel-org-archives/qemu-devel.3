Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A34C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUVLM-0001Xk-V1; Mon, 29 Jan 2024 12:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUVLH-0001Vd-8E
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:22:43 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUVLE-0003Ic-Vc
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:22:42 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55f0367b15fso1547386a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706548959; x=1707153759; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arpamylKw5ifaFOeLHJXkO74r6cEYhnLuAcH21BRXas=;
 b=Q+ND4cp3JOpzs52tQlnCN/wnuxz2PPGc4bkORbeySv1JsOmSQ/ucOd0oFkSkKqY4Dm
 3NceFe6azcCfznZUWvSGzK3fQ1whw8t9aWUjQeX3fzOCEDLyoWL9Qdky5A98zXYJMkC4
 d1lZzOakP/PMDX04Mkfp5ed5p7hTpch4OlUGZw7tHqrJduhxyTaItFM+Xq5od7l1vC9I
 B03golEVrleeUGAFiTP9tMHFkyCpg1HccD+y9A2/qWEUMkotMX0cntGhyHeeZJbDyWhg
 Uo9vvoEZSdBbbK1tswKeMNSOEExhg2UEKtK33Ql3sB6WbFmyfyBg6CXkOAvmR8Q8d2Yn
 Lhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706548959; x=1707153759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arpamylKw5ifaFOeLHJXkO74r6cEYhnLuAcH21BRXas=;
 b=OCmDjiz0pDoXodLDF+SOhZcyqvY3WXqdMA4Rl2lu8u+YD5/FnHiffj1goBtzYGQXMf
 nwgY9wRqygfbgvqtm3xLNf4E2jpjraQ1/Zogua/LYX3A80ZYod7YM3s3Twh/d/xRKs9F
 WtZ5I64f2H31eeOK1ouvwXvCnokzOvwQsmkUufdYp29qdVfqpeSWygPzMtfOPaH4ziN3
 VZdy/zM7tMQRczX+oCgbdP7kvkHhOnnz5C4fivHCKBJZVd5ruXmfdiMFRyshCKFHoQzn
 kO8Hx/oIiXVPY4FSCBDVIBl2f9Jz/MiIF7lk4G4nuBOaGMT54ykAvIa8yxU/mn+Sfcip
 k6lQ==
X-Gm-Message-State: AOJu0YwQAePlQvEx6byW7bKCuSWQO9iLX1Efv3Aky5mZ7aVrG08nsjmv
 jIG7nLyMaD76g4y1pRlBcmV4C3cgK51JMYQcPEyPfJWIzF951GVf/bR88kv6nL3YJw4ajvefmR4
 PtOKyJZAUDWlY65Fw8bMx3C3SUSTrkG2acdPeAQ==
X-Google-Smtp-Source: AGHT+IHjd7qQiLzeW/mL51TO4zNiKjqM9DWbZqqXXOTNG6cKD/ZF4RC9/CC4ePAM5GNp/Tw3+PnQKFmTW86OQEvISG4=
X-Received: by 2002:a05:6402:430b:b0:55c:7ab7:d349 with SMTP id
 m11-20020a056402430b00b0055c7ab7d349mr4707956edc.3.1706548959744; Mon, 29 Jan
 2024 09:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20240129084150.134050-1-clg@redhat.com>
In-Reply-To: <20240129084150.134050-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 17:22:29 +0000
Message-ID: <CAFEAcA8aChxJ9nPZwPY+ERFmWiXd34Z5BZ=vs1mKJroTTGs2SQ@mail.gmail.com>
Subject: Re: [PULL 0/2] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 29 Jan 2024 at 08:42, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 7a1dc45af581d2b643cdbf33c01fd96271616f=
bd:
>
>   Merge tag 'pull-target-arm-20240126' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-01-26 18:16:35 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20240129
>
> for you to fetch changes up to d2b668fca5652760b435ce812a743bba03d2f316:
>
>   vfio/pci: Clear MSI-X IRQ index always (2024-01-29 08:26:25 +0100)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Array type cleanup
> * Fix for IRQ enablement
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

