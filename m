Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEADD68B01
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZO5-0006sw-MJ; Thu, 14 Nov 2024 07:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZNx-0006qs-P5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:55:46 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZNw-0006UT-1x
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:55:45 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso801701a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731588935; x=1732193735; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5MvH3s2lSF0+0zasS3GpvyupzRWEqKzpJ6G1VW6KDyg=;
 b=LGvR90Cd4hdiAlJUnWk84FbPfu+1JbKZ7Dtz3lLxYwBK9sp3iUgmGcHtm3kNvLPNB8
 cJ62f3p2BfITQdoZ0mTnurx7RTQD/XbQbrbv9FkAzxGb7mFAqtH5LAHblnnhg7GyxxHq
 xlXDQQM4AzlSepc/zqQkYbF4c4zKCxAH9ko/25GJ0cZKWdf1e+oolLza2lL/Uzq1kwhv
 NHsOmJNqsF2zVkF77f0Ftv+D922kFM4d5uj1syUvx1dvb8Yv5RhMFBC9Idav4NHgcNIq
 j3STbdOtDTc0rUbv2eVDlmQvfQQQlEwUI526DZH7Us28UHHB59tvoboqfh8aJSqZ/91E
 X1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588935; x=1732193735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MvH3s2lSF0+0zasS3GpvyupzRWEqKzpJ6G1VW6KDyg=;
 b=Sfv9vh4pvyWQXM7AsL67FBoykxJwd/M9O3netMrHi/+62kaYy9b3evIaHLe7phhmvU
 Hl+/Sut15erMTf6p3FIxqBG3hXOEcM73dACfZt2Fg9+UI5tk4kD37yQwv9RaSVaP0Idw
 EgRUUt8gwGIYBfeaUL52XX8mBj7gyzZUQ9+Ie5+qmWT76DFpei9iDxLGN0oQP2eA/Ymt
 8ygBcLHaPj1VzmFRcUTqWx80YWo2q/kkDp/QKN2pfen6cHHXqo4F7YI1ggD5TvGJUvx3
 JQQGoJcTKRZGytEB6G5kJdPNBw9nXCn2uTNLRk6p9mn5eVE60jh0mh8UZSX5H+5RAx+E
 ys6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhvA9ZU8VmlC/6hVczlr/mjstcGw68KNFtpPzMPOzVLn7cpIs/PkA0252hHWEhXnGP8UZtBuy10ooj@nongnu.org
X-Gm-Message-State: AOJu0Yza8YCSnKt+Y4KgFNv3A5QzGjZyXtLRcvwykprTBbUVbWM/JX5r
 WyWzGS8L8zch/RHxCNK5+Nq6tOW/pN3HlHYsX/PaMReEwrhD4RnDyPqyvk2oX11w1weZAwS8psL
 OMieYjQ3qacxtntIuQe5Sqwx7wxy5lUC7GqpXfA==
X-Google-Smtp-Source: AGHT+IHQTULj/yRFasl/nLj1FQFEbwljrly6BqONPlvRjOzGfgVOIihqMqMo9X0suotmtRO10Osnibi25Nco7K6SWjI=
X-Received: by 2002:a05:6402:5cb:b0:5cf:255e:1919 with SMTP id
 4fb4d7f45d1cf-5cf77ed46d1mr1626965a12.24.1731588934601; Thu, 14 Nov 2024
 04:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
 <20241108191024.2931097-3-roqueh@google.com>
In-Reply-To: <20241108191024.2931097-3-roqueh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 12:55:23 +0000
Message-ID: <CAFEAcA8W2nfhmB8o3ECMwkj3_v7e0bz=Qxs=LCEui4LdBVHQNQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests/qtest/cmsdk-apb-watchdog-test: Parameterize
 tests
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 8 Nov 2024 at 19:10, Roque Arcudia Hernandez <roqueh@google.com> wrote:
>
> Currently the CMSDK APB watchdog tests target an specialized version
> of the device (luminaris using the lm3s811evb machine) that prevents
> the development of tests for the more generic device documented in:
>
> https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model
>
> This patch allows the execution of the watchdog tests in an MPS2
> machine (when applicable) which uses the generic version of the CMSDK
> APB watchdog.
>
> Finally the rules for compiling the test have to change because it is
> possible not to have CONFIG_STELLARIS (required for the lm3s811evb
> machine) while still having CONFIG_CMSDK_APB_WATCHDOG and the test
> will fail. Due to the addition of the MPS2 machine CONFIG_MPS2
> becomes also a dependency for the test compilation.
>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Reviewed-by: Stephen Longfield <slongfield@google.com>


This refactoring mostly looks good.

> @@ -116,16 +164,21 @@ int main(int argc, char **argv)
>      int r;
>
>      g_test_init(&argc, &argv, NULL);
> -
> -    qtest_start("-machine lm3s811evb");
> -
> -    qtest_add_func("/cmsdk-apb-watchdog/watchdog", test_watchdog);
> -    qtest_add_func("/cmsdk-apb-watchdog/watchdog_clock_change",
> -                   test_clock_change);
> +    g_test_set_nonfatal_assertions();

But this addition of g_test_set_nonfatal_assertions() is
not related to the refactoring and not mentioned in the
commit message.

thanks
-- PMM

