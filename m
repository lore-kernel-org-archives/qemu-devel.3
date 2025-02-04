Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE22C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJS5-0003Yl-Oh; Tue, 04 Feb 2025 08:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJS1-0003Xx-8m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:58:54 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJRz-00073x-3G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:58:52 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so5037808276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738677530; x=1739282330; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6efHAvOJyoEpbzEUaqrMfnmPVymr0WckrU7+WiQ2eM=;
 b=LwJGpv7JabL401AJEfxyP6j1DIdHsqqBQ3GQnFsyon9OBLsjj6dsrg8KVkuNzt3vZY
 EnaIccgLXyPYjOoLW3lS34q0LlsmYswcUexc59w8b6grzWu8kgwTwA97yUugl+xK2L+W
 xuPgoV9yK1X38TuNTPT8b4eiCZAxgK0gowwIdRl4x4P/0n+dFLBFgSE0rHdtwtiZa2rk
 qQ4Dtr4R9D0F4ZxzBkxsvn+vrWmCYzW5wZCYZZ6tzj9IKunJi3AduSnpSdG5o90xHRLu
 QImVzfkVdYIHwTz4SBqENeVtKRFqhDHsCSveoIql/ADNiqioTfRVJbZcKiGjU2iTfMQC
 z6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738677530; x=1739282330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6efHAvOJyoEpbzEUaqrMfnmPVymr0WckrU7+WiQ2eM=;
 b=uKEusB2vG2eNi3P2ZI2619q+mHg1m6W3N2D9Q9wDFllB4AdVmTwvcqJQAO+2lUB8V6
 Zebep/GTy0vWSAvZVVR46o0H9hCZrn6Z89iG72uIXK4+FfRZnSpObblzH1te9DBC2Gcf
 IpEsLW600icmM8Mt87gowMIbyHWmhSI7NiJomEjog/4qY1KQCDKbvb35ToZaDXsfsNeA
 sT2OXKafNmvG/RdCDxxDcZ6cikIiaTWLPmAucu7Fk08j8k8FSgVpX3mptlPR1eRA8DD2
 bT90REXHos1lsqvC9FashW5vW114lhi+ieoiTyo5U6c4842Lb9KX2Y2tWuZB1pyjrIo1
 2Lbg==
X-Gm-Message-State: AOJu0YyhoGmQZAU3v5Be2Vxr1BXic7QcQILuKEHBv+46cyG4hqVg0CKc
 qbtnlx0nj7esaVJaJL3KzI7jEqP4kaoQjpG2WDqIga+Z2rBTsHMAN40vqmQVirK5ApqCNdPjnGa
 qRbwj3YjXFFZSnTV67dAa11KQvXZWXt8uv01SBw==
X-Gm-Gg: ASbGncuizFWt6FZjXUVx9GVjbIasJQBJvcmSZGHXoSxryXkjAEGtJIAESFnKmbc17+B
 iOVAuf7YyH3n93txE5PqbFOeQCB9cKJSkV0Pan7r4mGK4JzqCxebGk8QLtgig+mOuYjlFlbE6Jg
 ==
X-Google-Smtp-Source: AGHT+IEs/TMT37UW4yQkWEE31L9bUTwoMnUGXGr2Laf8l5yza9GjLgoQHY5xze/fg/+thwczhRQ/IE6Jq3aproYbkEY=
X-Received: by 2002:a05:6902:1b0c:b0:e5b:16b3:ed02 with SMTP id
 3f1490d57ef6-e5b16b3ee5emr2023106276.30.1738677529893; Tue, 04 Feb 2025
 05:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20250113173604.46931-1-philmd@linaro.org>
 <20250113173604.46931-7-philmd@linaro.org>
In-Reply-To: <20250113173604.46931-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 13:58:38 +0000
X-Gm-Features: AWEUYZmhP4eni8W8aF6Lx5IxW8i26lpB8_tW5XkAXZU1zFjgcOQSGCrSw3KVAcE
Message-ID: <CAFEAcA9aFTCcZTWUJhBisuaKWS5dEDkv1QnU_hgK4+1zPWcH0g@mail.gmail.com>
Subject: Re: [PULL v2 11/55] hw/qdev: Check machine_hotplug_handler in
 hotplug_unplug_allowed_common
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Mon, 13 Jan 2025 at 17:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Commit 03fcbd9dc508 ("qdev: Check for the availability of a hotplug
> controller before adding a device") says:
>
>  > The qdev_unplug() function contains a g_assert(hotplug_ctrl)
>  > statement, so QEMU crashes when the user tries to device_add +
>  > device_del a device that does not have a corresponding hotplug
>  > controller.
>
>  > The code in qdev_device_add() already checks whether the bus has a
>  > proper hotplug controller, but for devices that do not have a
>  > corresponding bus, here is no appropriate check available yet. In that
>  > case we should check whether the machine itself provides a suitable
>  > hotplug controller and refuse to plug the device if none is available.
>
> However, it forgot to add the corresponding check to qdev_unplug().
>
> Check the machine hotplug handler once in the common
> qdev_hotplug_unplug_allowed_common() helper so both hotplug
> and hot-unplug path are covered.

> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index e27d25c5859..861c25c855f 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -684,17 +684,9 @@ DeviceState *qdev_device_add_from_qdict(const QDict =
*opts,
>      dev =3D qdev_new(driver);
>
>      /* Check whether the hotplug is allowed by the machine */
> -    if (phase_check(PHASE_MACHINE_READY)) {
> -        if (!qdev_hotplug_allowed(dev, bus, errp)) {
> -            goto err_del_dev;
> -        }
> -
> -        if (!bus && !qdev_get_machine_hotplug_handler(dev)) {
> -            /* No bus, no machine hotplug handler --> device is not hotp=
luggable */
> -            error_setg(errp, "Device '%s' can not be hotplugged on this =
machine",
> -                       driver);
> -            goto err_del_dev;
> -        }
> +    if (phase_check(PHASE_MACHINE_READY) &&
> +        !qdev_hotplug_allowed(dev, bus, errp)) {
> +        goto err_del_dev;
>      }
>

Hi; Coverity notices a NULL-check related issue as a
result of this change. Here we add a call to
qdev_hotplug_allowed() that assumes that dev is not NULL.
But in the code at err_del_dev we do check whether
dev is NULL. So either this code is wrong (and could be
dereferencing NULL) or the code at err_del_dev is
doing a pointless NULL check.

Since qdev_new() can't fail, it's the err_del_dev
code that's wrong, I think.

thanks
-- PMM

