Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4364FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfiw-0003QL-6r; Fri, 04 Jul 2025 08:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXfis-0003PQ-5t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:40:58 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXfin-0005XK-AW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:40:57 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e81a7d90835so720840276.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751632852; x=1752237652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi+QwgFyUTXPn1NiJvGnj1atO4ZVxhr1ZCjf+8aeKe8=;
 b=eDmK1JJ+foxfmVOqoSmm91cxLnNV9MUkSNDR1/c4s4lwKeHm4tAd8bJXot7sPNFZ2Z
 3hGz4tWtZuJY9VpjIzL2OSczSWeO3D257KIPm5VhJWvlvfVIdpmdkTZ2Ll6hF1OMixfn
 98ct0rJjwjBnJ0jw0vcm48S7Uiw02noTWarTAXVppLzerXe2o/gfzzm4kGnIvT7tjqlR
 O7KeCmBYK0mZ1/6rjmOir+WcSm+I7NjjMdcxG84pmQ0hi2Fm2y4p3uZxPMTrSYj1MdFq
 9pEjwQ4/zX69UXVAVNrkcNFuzlr1bXCNkgYePTYNRxQa/DAO5BD5ASKwRChW3vW5VyEy
 /tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751632852; x=1752237652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oi+QwgFyUTXPn1NiJvGnj1atO4ZVxhr1ZCjf+8aeKe8=;
 b=V893bSykTrI+qjkhjOMepVAYg3qS6j8mR+XZ4lCkR1pYH4GFsBBe+Zn3aj67c3iAak
 1v1JBP0ESLkIUn5qqvIkee8azizklJooirw4fpH14HBT3h+3LZ+gLD7mcvOWTiaHlnaV
 no5bwuAYffUHivFH3fPW8AN0S1bMftT868UrXQVJ4uM35ChkMe6JudrSbsVIUgd8NGpz
 tDp5aMCY3gPs88ZdBnq4/uZTjULPbVdj0B4XZcgdvYxXq8jD43yYS6VJSxhlETfXS6Ed
 zUnxSmmOuiHzhJJ5QopBSa+kdieKc1nFHC7Z40SbpqGBqMmCDn5NOaCf+J9DT15DksqB
 MluA==
X-Gm-Message-State: AOJu0Yyjskvu5mUmlFMTi2byVTMYFm6udNJvB2SPwn8y1KZ0gkqlw8ON
 wSBA8BdNYIt+SYu+ZflfbUdXuDyNH59xeZcOnB2u5QUJsFFo4mjbKmm8+sHJpw63E7SY7xE1O3T
 YQFS3xOOA1lLtMyBR8PZ+eIH4TQb6NgmR0A+QkuQA7w==
X-Gm-Gg: ASbGncuMO1HX0OGBfCQv063/KG5jq6osYEpxEX3lQLdf/PDeb5wz/YMEv60rQ9tQTwo
 z0dBoEvkXm9BUAVbpzq09nyTeKuwQmISxqqFqnAPtyTSELCOXuGXBNUkFrETxL+0liw5MWAqpM7
 GQt7FQqi0Uwvv5RJ2udiTAwmxuaQyqYUFPEW7imvx/5JJI
X-Google-Smtp-Source: AGHT+IHhmNrp+sKEwZN46UY2pwI2Xf6dOQEvJTuk75d33NUNqeuDCXDRa5PYDcGesFF/eTlhP4o3uAwrA9FSnCEtarQ=
X-Received: by 2002:a05:690c:388:b0:70e:2d77:3cfe with SMTP id
 00721157ae682-7166b59391fmr21731377b3.2.1751632851568; Fri, 04 Jul 2025
 05:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250702113051.46483-1-thuth@redhat.com>
In-Reply-To: <20250702113051.46483-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 13:40:39 +0100
X-Gm-Features: Ac12FXwAQy-fGZxl-rZPBqEozJPVINFPiXiYb--VfE338vSNvFl3U_AX-A4dhzY
Message-ID: <CAFEAcA8_D035si+3n-A=px4nF+2fVvPqRvq7A9HcwSxW6rpx4g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/highbank: Mark the "highbank" and the "midway"
 machine as deprecated
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 2 Jul 2025 at 12:30, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> We don't have any automatic regression tests for these machines and
> when asking the usual suspects on the mailing list we came to the
> conclusion that nobody tests these machines manually, too, so it seems
> like this is currently just completely unused code. Mark them as depre-
> cated to see whether anybody still speaks up during the deprecation
> period, otherwise we can likely remove these two machines in a couple
> of releases.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Here's the preceeding discussion on the mailing list:
>  https://lore.kernel.org/qemu-devel/CAFEAcA_0Hu8+G50sy0FJ2rX-=cNymLddDdrS2nN5ZY-doKiT8w@mail.gmail.com/
>



Applied to target-arm.next, thanks.

-- PMM

