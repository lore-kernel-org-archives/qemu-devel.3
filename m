Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C42D767E1
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 16:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Y7C-0002Yi-1E; Thu, 31 Oct 2024 12:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6Y75-0002Y3-9I
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:33:36 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6Y72-0003XR-PX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:33:35 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso1355903a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730392410; x=1730997210; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aOnP5kSk9F0m1RRBTQfYEC5+vbo9OQCaCNQBmkX967g=;
 b=gdktMZxJQbjKWMPXDQPmvVHKdd6CbKpZwoT+OQRAd4NCHFPSovEnNBSafGIbDKfzDv
 7FIPGPedsHyQ7gCVGgJVxIwlBFHnUJ47cbH6k0nLaebqIoAQxIPiDrnWz8Yzrk/oxIqp
 d6Rt8oWK6IPhSElS1iL6bddA7yyiaD5/uqWnkIjTVFWh08v1g89my4tFM6N5Km/hn0b2
 7aK3CKJa1PcvfPdhMQ1gDHTR84k7Sw0ju8wJwoK3+Fil95NnQcY7hpl7Z19ZDgpFIbM4
 OW64UDy2GRlGXI3T2gxi7QP6E3GuwdtrmqCmmrIacGKqDCE6CyXqWdLTOpFaaT/A/zTK
 NY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730392410; x=1730997210;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOnP5kSk9F0m1RRBTQfYEC5+vbo9OQCaCNQBmkX967g=;
 b=JbztULTOBr9GOtEiYx+zNRJXU4/LtwyKdbldBY4FpRwgY/CuSrTN48kw5K/95DdGKV
 QuRNZSls/Sqzn3t3h2Sq/8XRQoK84UzEmeEE64GgDIM7eA63L0jM/P6CzSSZ6XCMPxiQ
 b6iCWIADvfus5TfFhyeOYSUFdrWbDcXD654Mty/OROpZPfo4KZaABZx5i8OH8g+5mu2O
 7JwsbvJP3rImsT+FFJoT8BmuDxST5NFQ91fGdyzVfEo/za58K5lRtVFov1QvoXisbVAV
 GhIyUyIm+Jx4uP1i8EV0P2/yc6pbR3Ra7rT/YlXgy4iYKvGr8xnxPTt/NVWVQgpbC6LQ
 TvJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0C49JsLnilvuoGGS8T1voVhkUvA0oCOTQteieoxLKcn6ZIn6X5vIV4N3umdYbh2JZ+ikO99bahe9H@nongnu.org
X-Gm-Message-State: AOJu0Ywy8FFzF48D9T9xThWZt2/n+hmeNep6R3cZb45odwLkr2TM566X
 Z7Hzgv+50YR0HwUsv7THFA+U+Hh0apf7dq5bISZGdFc5zTUZeY+QWWizxPxeyu5IirlcsrQbCxq
 KU2Anzezm9BYsbOjylPXTuPBH2Pki1YEEDkENFw5f3B0MZZ0z
X-Google-Smtp-Source: AGHT+IFFwzFZZYB5kBYw7WvE4JzRr3TDoUF2hV1ESxkkC6tSmGCg8yQ/TK6DAxb+LO6DC9vMEe35PhJAgzW5iUtFg4g=
X-Received: by 2002:a05:6402:254b:b0:5c9:4281:4515 with SMTP id
 4fb4d7f45d1cf-5cea9687be9mr3044678a12.17.1730392408282; Thu, 31 Oct 2024
 09:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 16:33:17 +0000
Message-ID: <CAFEAcA8C6vZvQ9qymGehfMswfZQ3hT7DGP0f2Qg5bgj44iOz3Q@mail.gmail.com>
Subject: Re: [PULL 00/18] target-arm queue
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 29 Oct 2024 at 15:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit fdf250e5a37830615e324017cb3a503e84b3712c:
>
>   Merge tag 'pull-maintainer-oct-misc-241024-1' of https://gitlab.com/stsquad/qemu into staging (2024-10-25 19:12:06 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241029
>
> for you to fetch changes up to 84f298ea3e2f0627c09871561e55068db9ff9180:
>
>   target/arm: kvm: require KVM_CAP_DEVICE_CTRL (2024-10-29 15:04:47 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * arm/kvm: add support for MTE
>  * docs/system/cpu-hotplug: Update example's socket-id/core-id
>  * target/arm: Store FPSR cumulative exception bits in env->vfp.fpsr
>  * target/arm: Don't assert in regime_is_user() for E10 mmuidx values
>  * hw/sd/omap_mmc: Fix breakage of OMAP MMC controller
>  * tests/functional: Add functional tests for collie, sx1
>  * scripts/symlink-install-tree.py: Fix MESONINTROSPECT parsing
>  * docs/system/arm: Document remaining undocumented boards
>  * target/arm: Fix arithmetic underflow in SETM instruction
>  * docs/devel/reset: Fix minor grammatical error
>  * target/arm: kvm: require KVM_CAP_DEVICE_CTRL
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

