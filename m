Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C1C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 12:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnHNe-0002Ua-8G; Thu, 21 Mar 2024 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnHNd-0002UM-93
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:18:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnHNb-0007qX-Gs
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:18:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56b85146589so1613694a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711023522; x=1711628322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z38XsICzg8NngTOWu59+gtaH+NJn8WE68QxXnJY/5Ps=;
 b=PO4omP/Vdzz2f8T1rLsyNIq9c8VxDjqCcoSU5kZny6hNJcMITVZhKW8KkyjYTAEuIN
 rdI9J0Hv830WSApUXoxl1ttjtiAoKyu3qnPIAHnR0/JBle2OSI1jYsG9Vg8054a2s6P+
 XEddVg8RAd9FxcM+xnXnL+wDZGyTTUzYrpcUdx6zlbgRT10/l2yPCX7xSqXmf2q7Ev6B
 kGL3K0eJ6EEcag7DFhgQN1SBMuEeoOUNsNVkjpTIE94WlzEyV9ggrBeN9SezUoNS62FE
 ldtpK0ST5OlNBBVk1XUPR5ZGKgXl/qM1/v0bAAyAi7pK/VcwT/1J3yjqAL/YyTUGMs1F
 YM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023522; x=1711628322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z38XsICzg8NngTOWu59+gtaH+NJn8WE68QxXnJY/5Ps=;
 b=QU/798nEiN7CPDI8zJbYPxIgPyLRiiW7Q1AFHPhY4wBhgvHvNyySxzxX1QJnYqRNrp
 m4Tfyw/mg1wj3VhYn2lGCKVsSMUPl0MDhAIGNfRfSGoeM1SbZ9iAtyIEFNuYIZcXfnSY
 JNOBQs+GG5Hpxwce5bJEtd4mxQ2apgufu52TwjhLp3JwumniLIHHW4wpDf+v9xVzM1JM
 dszzMaOKGxYmyatjBNsmhNTa/AABDs07krUqypnED1v0zu+urWIq4EzdZ2R00S6a0zRp
 NzBCyM4+eQpnKbiIN4O8wtDrotSkqC1XUt+llrpF9NsvZJml0WPsSObtPXuyt7EMfS5/
 9mhg==
X-Gm-Message-State: AOJu0Ywn6tqIB9z97NfzmmjuT/ZdTg+YVwtx++5L0FpZ6URa1oTA9Yi5
 RByTRgW9eFUEZXo5ipvHFxh8C9duRhLqCD8iiylNRVLD5HCB1vjCoCQRNGtliH7sDY8TAWWi9N5
 gq4/B1aUTvpzIzRyXQMSVRGC25LayNPeSu98j9A==
X-Google-Smtp-Source: AGHT+IHWGZ4Pi0jphLREug+bhNQU+mBR4ppSIHRig4EyKC9SU6XNoowVlMmEDWQWf9eP4Kxrj3tR++nazZ5tQg0edhU=
X-Received: by 2002:a05:6402:3205:b0:56b:9ef2:eab5 with SMTP id
 g5-20020a056402320500b0056b9ef2eab5mr2635080eda.2.1711023521687; Thu, 21 Mar
 2024 05:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240320161340.391798-1-alex.bennee@linaro.org>
In-Reply-To: <20240320161340.391798-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 12:18:30 +0000
Message-ID: <CAFEAcA9QDj8vxK6HsDuv57mWfLgLfbSOkw90tnFy6nPC24WVqQ@mail.gmail.com>
Subject: Re: [PULL 0/5] more maintainer updates (git, avocado)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 20 Mar 2024 at 16:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33f=
a7:
>
>   Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-for-real=
-this-time-200324-1
>
> for you to fetch changes up to 55900f5dcc3205b87609d9be452c6c76c48b863b:
>
>   tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max' setup (2024-0=
3-20 09:52:27 +0000)
>
> ----------------------------------------------------------------
> maintainer updates (gitlab, avocado):
>
>   - avoid extra git data on gitlab checkouts
>   - update sbsa-ref tests
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

