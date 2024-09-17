Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F02DCAC580
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqZVl-0005Vg-H5; Tue, 17 Sep 2024 10:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZVg-0005Uv-UR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:48:57 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZVb-00034g-Ht
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:48:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c40942358eso2400203a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726584530; x=1727189330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SIR4EvAo4tNusM1zYueuWaochL43ANKixQdOpeqgaeI=;
 b=nvknh+6d1tJcNWMCeL5CT8flwUhBhTsEHdbw8u8KOJmZk/vcDcW1rl1Lme2CWG8h4p
 AWhPwCLQMqIxIEKSMUnJtkcTZ71FiJXHEPgxfkLFRVqLE844ua+hHWZNBdHRuL54qUxU
 YA0sH8DolgomVuWenBaheMKTIpwMkHpvjKn7mevOCBZNQtYf4gINdEQA4BsWcUdKieD5
 nObMA9wKeWeTs+FSOk7GWfhX6c7UBAbmA/3z6mYVJNaxfxISuF+H30/da4m4XdrKkm6q
 frekszFQocz93CPqg+6B/t87+Oo7JjWHFODKRrWthy28lEyQn4e2Zrqmdffd6x5oU4Vm
 z29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726584530; x=1727189330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SIR4EvAo4tNusM1zYueuWaochL43ANKixQdOpeqgaeI=;
 b=Qq0BMe1XaYxIumOyjMb78TvouBa3vtUDiFraSfyqcRaFZpycdFraCaAV3H5nbCKPlT
 4wyrOfZbkaF4eAULJkPX+kTYrQwIt5OPVzle7ZI1GA5auIsr/5AlrTghQgGP/ghp3uzg
 5p65yy3VWFtc7tXEmG5WKAoQ8FwFwwyBlN0zSRKcaDCDrsdQ3qWJXnYpqAiPRAg/ifmW
 t9v8TO/GzN8Pyd0CZM7VapVCijtf/kNqDJPd6r0G8o1i7ggi6zdZgVv+IozSZM/FImQ1
 oRDOtyOabOD5CJHSdFHgHxfUmQKcjHBWYTdqQV7ddHPK6bRX36Zbjj9w7R7aDmAc29kU
 ELzw==
X-Gm-Message-State: AOJu0YzXau8aid+SstzKwFBmotaV9CA7oDXjXstrmGdcPGIIrHOvcgE2
 oOq+mHKLiY1b3HHfPiyoOR122P041hY+6mWKl/ImYSYpRBmWC5D1MQpbkE4dVdAILWCLBZqTwMN
 Ty5NP9jXHv7YVbD2MFgJOtnoGNOAyXT9danBz3w==
X-Google-Smtp-Source: AGHT+IGz+UMosRCtxiBg5CWwh46TFRTT97S5zJ8W4TY9uw0AIxfAEKKb6AR0ESNSbb/3Ko82WykWnhznIFwGaF/5E6Q=
X-Received: by 2002:a05:6402:1d49:b0:5c4:367f:2780 with SMTP id
 4fb4d7f45d1cf-5c4367f289fmr9578298a12.16.1726584529758; Tue, 17 Sep 2024
 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240917103540.149144-1-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 15:48:39 +0100
Message-ID: <CAFEAcA9=J=ULtvyYgRZFktehdMoS0HeWzoajbUVGEU+b-sk8Fw@mail.gmail.com>
Subject: Re: [PULL 00/17] s390x and test patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 17 Sept 2024 at 11:35, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi!
>
> The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a:
>
>   Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into staging (2024-09-15 18:27:40 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-17
>
> for you to fetch changes up to 66659fe76d3577b2cc3aa36d3935e3a2e9558e82:
>
>   .gitlab-ci.d/crossbuilds.yml: Force 'make check' to -j2 for cross-i686-tci (2024-09-17 10:53:13 +0200)
>
> ----------------------------------------------------------------
> * Make all qtest targets work with "--without-default-devices"
> * Replace assert(0) and assert(false) in qtests and s390x code
> * Enable the device aliases for or1k
> * Some other small test improvements
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

