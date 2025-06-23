Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F8DC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeWY-0004JP-UG; Mon, 23 Jun 2025 06:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeWX-0004JG-Tw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:35:37 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeWT-0002IC-Ng
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:35:36 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-711a3dda147so40611227b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674930; x=1751279730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nl/T1HN4gMljf1MMB4hIuu0EUCO20D2saFsY4/mlfUI=;
 b=kMhqsQfEwHx6Q3Ca+xP7xhEESuo5yMY+6WvH7H2Nt4PuiEXLqZQ+U8/+5Ahi6t8KvU
 x6RnoJXU5C33om5gdrjUtmxK9uY7xBFAT58pdRDT49Qexi+9RPJ7C62z36qOHVTiyzdV
 cW41ssLRI6ob2LwpZckufyZnWHAbwoxQwIg0aULj7AGyOusFHv7dF7qbe7THlfmNPqrt
 md10hU4bnUd6pRYDnl6e3OcDCjporrbgLCcXD9oc/dhP+B+RjfugPNf8msUpJ3ODtNT7
 V4l0LNXHfbDaOf8Cspo2rcAydiMRk3jY33FkSU50+uTbBxhYyV0TTLE5HqXd6o/EpPzZ
 gRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674930; x=1751279730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nl/T1HN4gMljf1MMB4hIuu0EUCO20D2saFsY4/mlfUI=;
 b=utrhb6CamX1s3Df/NQmkbCzm+7wLWBhqAyE05k8QN4E1X0ZvHCIAmnIiC7fbEhTCqm
 YgDpYAca8e6nJAqD8igBwLACiiyhEeJMsphZHHxf8DoIrDrWlcWBKviIg6hvkVoulk6p
 pIG6+jc4Bem+yI3aFVKysGglK7OujsIni6IB4Mt1v+ypntk9j9muWKZ4hd43fiKsVavv
 6ec1y6+SHZ1yAma//n79SfECzvyygUG7SNYyqU+/QVDUsyC75XdYVxcOn2VtCHrsN7Jv
 pW4N2VHSc6ifxoA3yLCBSJOedYCIjLcsA9DBj0kVjTVHV1P/7lRA4dIWZ5c1Sn2SOjXx
 eR/g==
X-Gm-Message-State: AOJu0YyIwIbE6lO80RrUgSR4Jcsuj/2gj4n2ohinMIKfdaWNgFnDDSc1
 syYFro5keQuLBPe7JUz8pC5f9YyhDWGcOdAliMa4+RO1pHtZ/sE6H4w8m2nq4KprD09veos+H4n
 B/Q4zDDySHQp64i96hnPzjl64wis2g4rgAr2TYsfJ1ZMRFIqFA3Sp
X-Gm-Gg: ASbGncsRkdAgudOVE6CHbZfirTJ7u+oJPsdi7wDjOgMufNllRyshVVY1I5z6CAksVeQ
 seykCftGCH5ozq7BIZrYyzhQJC3bWwu1o72Hw7MMMWW85HKAeQTj0K/GIyU3Sgfn8L7Yl15Fuyr
 HLaDY3kRwNjW844fy1PjlKS6npL0ZYY8E7M7Rsd6tQifuZ
X-Google-Smtp-Source: AGHT+IGn8BN/n0nTWVz3tiKLINqOgWYrnPWq4NlXjInAag/ltbVdVKh+LJLTzShXWBfYk/gPkHgi9rGmgjPuxtxIq6I=
X-Received: by 2002:a05:690c:3586:b0:70e:17ec:ce52 with SMTP id
 00721157ae682-712c654c97fmr179300637b3.26.1750674930432; Mon, 23 Jun 2025
 03:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-15-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:35:19 +0100
X-Gm-Features: AX0GCFvVp2V1OVAoUvXGQ2kluojiotGbwyqymMy1GXTfRATix7EpHC1PubwZdwU
Message-ID: <CAFEAcA_rq=047yKY3VnitrRy_aTtYSze=jtsYmMx92QNWF4eEg@mail.gmail.com>
Subject: Re: [PATCH v2 014/101] target/arm: Rename zarray to za_state.za
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The whole ZA state will also contain ZT0.
> Make things easier in aarch64_set_svcr to zero both
> by wrapping them in a common structure.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

