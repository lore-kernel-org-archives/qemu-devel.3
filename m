Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40924C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmviZ-0007NN-4c; Tue, 25 Feb 2025 09:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmviS-0007Kr-LO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:15:23 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmviR-0006Wq-2v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:15:20 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ef7c9e9592so46625947b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740492916; x=1741097716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vz0ABdgSxp6SALma5ub9VzcI6UoyNasetIN7p0P5FA4=;
 b=bDD0Wvdy41qF1esrU6aDHv2k/x39DeOB3ZeNxiUB4GUmBuDCfLMehyCYKeZMO1HpVh
 hPBakGtVMFMGTTKmgHacw5WbrMozZOpxGqP/ue5xhXGOxpsyFN/K6x3uUl5a5jJ76A2/
 J6pOaruzWtrs4nCvap/hy4EpbKsesglIA4nxrRYSTqKqGsNGchjg5rm+nNTeJhIL4NR1
 qyAjTltOVqlCSnkJrME+T2kPPBwn4b26EJ4G+LO2XCkx3BjNa1oJX1p/8rO5oJwiJkM6
 dvxXR7zlOvkjIHGYkkRhEReDjGm+YAeRaqc2+bJOnglndDiyWxKDj3vmHha6qN0TEI5M
 e+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740492916; x=1741097716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vz0ABdgSxp6SALma5ub9VzcI6UoyNasetIN7p0P5FA4=;
 b=rK52PrjEY/8EIhJylrDX4k9gNgB+mAyK2wHz3YTSkoW61iEjPQNrt5+0g3QW9Zo6l4
 uOjTt5I6vvqvCLwYQKCJs4ObFO0VRUSEEkmdphD8aPZ+izGQxedJTijxRunH7A/ZGNKL
 h+ol7DK10F8jxOA1G7MNCI2zIawHBy0aX978Y/NCmoxdX2KGpDEWL64+Fu6cvEXAwl5v
 wLELlzcXczEblPg8IL4EQU6Z6WNpW7YcbTTJJ/jipCjExlHqY0BWwXngtOL8TlvGgtFY
 CNRAXjTCqeRy39kHhx615m464N0DJOpuPtNET2IRSXVQymEk4IPc2rEJbclod1kyekSe
 9bOg==
X-Gm-Message-State: AOJu0YxJr6wiRmhQAwttIt53c5oErTBhAbvzX8D+74BBGcpZ1WB/dVXk
 PugngvkVbVqZiVYK+qscEJBFR+hEksVJT6rmwsmLKRtORYqf/1dKbrTCzhpm1AekjKvdn8jdu3R
 oRSxKKtKeMpI6LlnZqNfrqOoPz1ulbDa9Zuomcw==
X-Gm-Gg: ASbGnct4ilsKCulwrmGS87K83RYMewPSJTNSWIAOvDxozbexcejxz9mjkhp7TM15Yph
 41dqB4dZOOYjW9X9RTgFF0ALNt3jTaZCt+xCY6qll7KWkJrICh/WoSfc99h7hlLbmRyzODkwSKZ
 BofEQj+hxQ
X-Google-Smtp-Source: AGHT+IHK1FvgAwdJHSXeZZYwFyqJmdcB5CJdXLBMNVzjtw0CJWF8q2erqyOaXTwH6aILmiPQLe+tJFIKj2IyRXhB1xM=
X-Received: by 2002:a05:690c:6912:b0:6f9:88f2:b8d with SMTP id
 00721157ae682-6fd109e6973mr28813827b3.11.1740492916301; Tue, 25 Feb 2025
 06:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-4-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 14:15:05 +0000
X-Gm-Features: AWEUYZnSEcCA3kgccc7Jtu6vQvHIlb63F9n9zhBuYv13_m2vXiYQr_X5ozJPh3Y
Message-ID: <CAFEAcA-_z3E0wee3BNPpsxHOq29g+BKYJF7DEYBkPfPYNe5a5w@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] hw/gpio/pca955*: Move Kconfig switches next to
 implementations
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The move of the Kconfig bits to hw/gpio is fixing a bug in 6328d8ffa6cb9d
> ("misc/pca955*: Move models under hw/gpio"), which moved the code but forgot to
> move the Kconfig sections.
>
> Fixes: 6328d8ffa6cb9d "misc/pca955*: Move models under hw/gpio"
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

