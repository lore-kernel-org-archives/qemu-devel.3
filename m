Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D0D68BFF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 19:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFHxj-0007q5-CE; Sun, 24 Nov 2024 14:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFHxg-0007pp-5T
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 14:08:00 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFHxe-00018S-HP
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 14:07:59 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d036963a6eso1900233a12.3
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475277; x=1733080077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKIQ3LzmcR97WFlRxXQEyr0Tkkpt4MhzS2zAfcdZuN4=;
 b=q+2B4tgLII/I04K0DXDyWk+pel0LUuuudMt0UJj8GieMFpp9xyFvHVXmm7GYw2P9zV
 CxeyDaartG6XJMGhOaCVGsGvwP+6SfGn0zedl9yoCenyExSmwFADH3P6nMbudTvRDFwg
 Vryca+L5Oo63J8PF+/vUMjdXhbDmh3uHHfAY1GWpgRcuavMEINMyf6dXl9pgfFJ+1K1p
 DHnGy1r82eC7sc6qhqVfstPIijd3bMKMJsLULkAos/UX7Cur07T2F4nSXF5RkDe9GX/D
 heSztp4hrHLSRIem6RYPMckRnNKCMebo2ACHrjO7dx7NT8kT0A2cjOU7HXYeZ3VAStsd
 uNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475277; x=1733080077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKIQ3LzmcR97WFlRxXQEyr0Tkkpt4MhzS2zAfcdZuN4=;
 b=FtomNKSMxp/OUto1ZRpLxu9jV1EF9G8HWtFvHI0mfvfynU1yTD5y5h0/Y0yTfBtUER
 g9LQu/INxeOVyVa0EhBAY2Ipv5uA4V5ZOkr/78gtBQyJFqgb8R2njEdGYMVTQ5G1gb8o
 SpcXahXxObwygsVXfwTnL0GBypvQfwubqekiwjyhbMd4AfQdXsybmOxvr7289VatS6c5
 +Tc/ASOm19W4Y8ICLpVhN/bcSU1+eZknIG8toAy0LPqJ4gp4+qKWq/v9pnCtAvnd4xGb
 R3Rr4lyvqvzXMkmGCh4/3JNAT1G3/Nj6Xt/jyTvyrlkySXx7dYBmM10JrOagl7BKr+gf
 ZPLw==
X-Gm-Message-State: AOJu0YxmDPc5YZPm0OxxgnW4VD8f7joSrxp2vdZ0eEozstd0MlUi6kQQ
 k1fOweO7BScShjVKj3jzgd4T19LPSPvJcskP/RODbM4I0txIcKw+nNpid32YhOjI3Fg9uox9Htq
 GsnwmFy0cxYMZhkTNF2FLhfykptf8XTgiKx13jA==
X-Gm-Gg: ASbGncsII+IoPlcQ0+0gC08BPK+OP0SIUZXkvfov9fwxerx2L6/0rHZGMSmZcauFcHo
 nAL2zejAfceutZntMl7wD7PLsucRp33/B
X-Google-Smtp-Source: AGHT+IGreAeBUtGaOoMA0csCGyDHDsuGosGnTauH4wH9EhTercw7I5AVrrb6zlwwsTnnB2ItuIKsZ7x4OJvBXS/YLNk=
X-Received: by 2002:a05:6402:2692:b0:5cf:cb41:3610 with SMTP id
 4fb4d7f45d1cf-5d0205fa45fmr9130606a12.8.1732475276786; Sun, 24 Nov 2024
 11:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20241123150706.19740-1-richard.henderson@linaro.org>
In-Reply-To: <20241123150706.19740-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Nov 2024 19:07:46 +0000
Message-ID: <CAFEAcA9fn5b=YY0qPhASdqqbbPBVSu0n-cPCW_RwCKVnYwemUw@mail.gmail.com>
Subject: Re: [PULL 0/2] linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 23 Nov 2024 at 15:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5:
>
>   Update version for v9.2.0-rc1 release (2024-11-20 18:27:48 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-lu-20241122
>
> for you to fetch changes up to d95fd9838b540e69da9b07538ec8ad6ab9eab260:
>
>   linux-user: Fix strace output for s390x mmap() (2024-11-22 14:20:38 -0600)
>
> ----------------------------------------------------------------
> linux-user: Fix strace output for s390x mmap()
> linux-user: Print tid not pid with strace


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

