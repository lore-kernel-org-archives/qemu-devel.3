Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862EDD4921C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1gh-0004nE-Lu; Mon, 18 Nov 2024 08:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD1ge-0004me-HW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:21:05 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD1gc-0002Gh-R1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:21:04 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so4573546a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731936060; x=1732540860; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZRL82nACjZeHEn3zTfFNgDHsmHEaxj0UkIBt/Rf+rU=;
 b=fn0STWrtVHoR+aBmi4Sd6z4kyPQ5LYejqcDJ9tsGwDIXe4XI2evWl5kzagm+VR3JYS
 LtlwBGXyNxt85QBntsOfayHVyMRX3P4dEc8SWuQAixypSfWEy99f/N1KQaYoSGqAZBZM
 Y573gyMQ6/VRO3zGfI7Tng1hIcbLjr+mnb5enPpYIgKfeAqAbXUSXjsAiblesuq1Vk8A
 1nUVmyvjbMfKp8N7xys9TEa9CvTnOdW9OYhuT6/e1B88RDb1CPXwc4mrqqdEwhCtEIOl
 y++dSVDg1xKZqvBjWw802bDWh+KEtpGIOXCY7reVgqsXudbDzo4w2Unxuwf9H1SreFUG
 KGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731936060; x=1732540860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZRL82nACjZeHEn3zTfFNgDHsmHEaxj0UkIBt/Rf+rU=;
 b=wwNW6l7v0j393NKLlmAXeiaP9gEZp/WzylHFxk1Sq+vyHQFQAnhKrBSt5K1JHkNsFj
 PvmtLRW5FhqV12uIWihvyL0mFrTkQk/dYPZs7bxS+3rKAt8VhBCWzO5CNUQ4gzKypdCJ
 HkZTWWJz/xWA+yUudVhLqY0TijwsTq743cMnYdtmKecpyqubXWL0oJuScI5/HQY23kzJ
 WzPBCaG53lXLeFpE8AtPnfnbEilZmpiZELsP0fkBdhk8pYG3yF5WFuGN2jJFoSDvhZ1u
 1cuKEbr6eyND5+PWz085RP2/Z9+vHmvLtjJSY8Wjz71TMCwg3t0TGV9xJx6qkLL0U3a7
 x4yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSgOZWBkxGfVdlBz5UO50qE4FQe9a2LZb4YgVIk06Ul9DsomDxIQXQw0eFqKXvbuIB1B/Wqz0iMhO@nongnu.org
X-Gm-Message-State: AOJu0YyVio9bglT5a0zl8YnFv6q11YLbT1/YmTe9gMaRN/AsZvi4Y19J
 TOQl3cdxNFLLlH6G415G1YCVsqCC7KHzLaspzizWAysca+Kj9xy5tpXuD/hBQb+mYZkaTqEFMtX
 kwDU5VgtiPFFpKOa486yHDVDoq+cWIyk4Ly/Mkg==
X-Google-Smtp-Source: AGHT+IE0k1a5rH3VqgL3XM7XRJ5CoKiCj1MyozjqjhlFgO+CbTpwvGoPnPWKvbNEGwoejzyeeTHTozxwfYlwse50Fa0=
X-Received: by 2002:a05:6402:d06:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5cf8fc14246mr9277984a12.6.1731936060436; Mon, 18 Nov 2024
 05:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
In-Reply-To: <20241115160328.1650269-1-roqueh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 13:20:49 +0000
Message-ID: <CAFEAcA9-pusQVN7k8PkUvLvzpxvNEyRuK-A2iS_a_5W_WwNPMQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Make WDOGCONTROL.INTEN the counter enable of the
 CMSDK APB Watchdog
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 15 Nov 2024 at 16:03, Roque Arcudia Hernandez <roqueh@google.com> wrote:
>
> The following patchset tries to address an issue where the watchdog
> counter was running as soon as the device is out of reset. This
> created a few problems with the firmware under test. It was pointed
> out that the firmware under test was already working on an emulator
> using the real RTL. Further review showed that the WDOGCONTROL.INTEN
> is also expected to be the counter enable as it is defined in this
> page from ARM:
>
> https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model?lang=en
>
>      |       | Enable the interrupt event, WDOGINT. Set to 1 to
>      |       | enable the counter and the interrupt, or to 0 to
>  [0] | INTEN | disable the counter and interrupt. Reloads the
>      |       | counter from the value in WDOGLOAD when the interrupt
>      |       | is enabled, after previously being disabled.
>
> The second half of the patch is focused on adding tests for this
> behavior. It was required to modify the test to be able to run some
> test cases in the MPS2 since the the stellaris machine had 2 issues:
>
>   - The stellaris machine did not run the counter out of reset
>     because of the way it is reset. The function
>     ssys_calculate_system_clock is not called until the reset phase
>     stellaris_sys_reset_hold which is after the watchdog executes its
>     reset, so the watchdog would not start the counter due to the
>     clock not being set up at the time of reset.
>
>   - The Stellaris machine uses a derived watchdog and not the
>     original CMSDK one which has a special behavior where it cannot
>     be stopped.
>
> The MPS2 machine on the other hand uses the standard CMSDK watchdog
> and could expose the problems we were dealing with.
>
> Roque Arcudia Hernandez (5):
>   hw/watchdog/cmsdk_apb_watchdog: Fix broken link
>   hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
>   tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
>   tests/qtest/cmsdk-apb-watchdog-test: Don't abort on assertion failure
>   tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as counter enable

Applied to target-arm.next for 9.2, thanks.

-- PMM

