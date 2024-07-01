Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C675C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH5O-0006lF-B5; Mon, 01 Jul 2024 09:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOH5J-0006j8-63
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:28:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOH5E-0003A2-4d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:28:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5854ac8168fso307560a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719840518; x=1720445318; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o5KUOm90kQ5N7lbN4ikpYskcNqnWwSXy68bgG/lHBic=;
 b=iYafof8CG19FYrEsux5BZKTE+gCfBL+q9oa87jZRlknDbA0e8Ot43jUHv9NfcnS1c1
 a6NuOpnvsCQtyN968oQBTctJ4s7QHErTmPNGmcaJxJUOympPYVEwOyz4KfspZxLmBZ2G
 jQIdl+kV4GKO1p9Vo1kOQx4ZITgQv7aiYPSPGWKBMP4mQAvhBamAqmczTP8bhy/OhYzs
 nJYk5K9HiwyPHVXxAZWrCKgGSIhsxJktB40R0Vjr76FmxuXZ9H0gD6SJABJRzePGTReD
 GBTKRK3LrUChyyG+57auxY2fx/8thHc8WBW50HP+08f5zlmpo8vCDTKtSYZh3d9GFenJ
 bYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719840518; x=1720445318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5KUOm90kQ5N7lbN4ikpYskcNqnWwSXy68bgG/lHBic=;
 b=SUokR0fiF2hJV8v79AGJUnFxrCe0VZhZFyjsBDtJq1U8jGiEyJr7mb5QVtb3IvgH3k
 dAx6dlM7OYzkNrX0JQXMzRH19YUffUU8Gy6GOsLp32fWOr3IdedWCLYtcDJ2uhBLaVFM
 wHchcVgNmT5YvCeEnnd4kiZY6vvmJzpiq3+D47OzP/P7M4ghUoq7E8S9mLwtkIghTzih
 0z4zDtGVmC3mVkh+6sploNGKWM2LppX5tn1Wrcjc3JZBIi6GYJtcB2JRT2kfM1yUcbC7
 MdgXaYxw/TtrCMZl16TJj4EEwVSVbgcMiUjF14jpYFh6/AXYmC8o0DV/x8MyR7GQDF4b
 FGyw==
X-Gm-Message-State: AOJu0YxFu0al5HYGpFMudSnGZ1/to5aROCsRC0quOZoogF/kJaeAT+RI
 UotCkWNF7yHd9sQgR6p7iUp1x31+IHy5ndY+YstEv35078ljucGhK+S5OLD33a0EBeIDbytmhds
 HJ+7dXK+fAzPx2NlSQ7Qhx9TT1igrJwiQDIIsGg==
X-Google-Smtp-Source: AGHT+IEIm1OWkEOLfofos8ykrMMGmuJE+SAPswSRMnPqFvsRNw9etsssUaG/Szo0BpcPYMgyBbUN8EO/8Hm8rkoCFI0=
X-Received: by 2002:a05:6402:5187:b0:579:e6d1:d38b with SMTP id
 4fb4d7f45d1cf-5879f0cbd59mr4558216a12.2.1719840518360; Mon, 01 Jul 2024
 06:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240701132649.58345-1-thuth@redhat.com>
In-Reply-To: <20240701132649.58345-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 14:28:27 +0100
Message-ID: <CAFEAcA-VZN0Wmwm5-6fy+gNfAofbCytfw+HbTWNQ_O8EiQm5VA@mail.gmail.com>
Subject: Re: [PATCH] Remove inclusion of hw/hw.h from files that don't need it
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Slaby <jslaby@suse.cz>, qemu-trivial@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 1 Jul 2024 at 14:27, Thomas Huth <thuth@redhat.com> wrote:
>
> hw/hw.h only contains the prototype of hw_error() nowadays, so
> files that don't use this function don't need to include this
> header.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

