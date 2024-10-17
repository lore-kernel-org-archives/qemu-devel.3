Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1214DD374B6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1T2f-0002LN-F1; Thu, 17 Oct 2024 12:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1T2d-0002KZ-M9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:07:59 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1T2b-0007Dr-Nx
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:07:59 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so1407917a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729181275; x=1729786075; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dRuk12QHv6ps7aNLPKYR+/znjdtbp5GFRMiK+/8rOSc=;
 b=XoF6XudvlXNAC2P6Wu+8Is/cOa8A8XjYDjPDB17ENu2uWbR1MelRBQ9AXjya0DyoA0
 VKHEpbJDN9meUQKmph26OO8pJfzk51iDaLSMlo+0ex8H5Lzs3PNFXI09gCllsoV0JopF
 velUIf06eDd2ODsV63sL8S3nvtS29K4Oo3u6YBSaDOVNil/lMEwCDbyVOtlcAiRSE94O
 ubCxjHu6yW5hUtM3oZQP/O7AVTuhh6xDcDa4WME2EWNKAVq62T68RG4gX51Fy+R2dSKE
 FTd7Rd7gR5yJ5mEPbhl6H9jIdURxj5+7noiFhtueQJM3wJLNOd0hLQB5H5FC2m4Pu1b3
 becA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181275; x=1729786075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRuk12QHv6ps7aNLPKYR+/znjdtbp5GFRMiK+/8rOSc=;
 b=jrVRB0B/pSJcijk2EpT/I78RQLHNAX3TUFv/ZiS0VOnLZi5QCCkylMJJoxT+eV8n7i
 JmAJZYzVof4oD/6hGaV9NaSZ95LZJE/HRS/hmBj6r7vbqwlZA6LBYQK/ZtNQllwrIxmq
 A3ws3NDvPidfuB0cCNHfwKFqCx4ZTKgw29ZjXaUypRksWlw5LXxNCXUA67MS2alQ/Nmw
 A1SX6taWgJQb7hLYTjSy4hWj8Btm3AQA1r/EexAHv4hu8UwRyB1yfBORl9Do9xdgUTE4
 9IWPV2bKEpDDiSUw3XyZ+TrA3Gqlc2QXbSOVeAR9dHaMl8McpZK/V0I8Nhwn9arDooSk
 I4/A==
X-Gm-Message-State: AOJu0YzPtb3bhwJaWv6iBsCSvzFkdmukfTDJlvUDfrqevZousFEmzoxV
 ZkXzBodSK3DL1b248u0YNx83tO+70Y3NUkmFNGCmRpNI6k48N2B2VDakG7ikanX2NH+e4Uwb3VK
 ob/uoSQ6T2iUu8dyrycDBU6Pfxbymhax3nrdaXg==
X-Google-Smtp-Source: AGHT+IHnqRPUFxMsxpUc6xNTucKBv1HPPKb9a15BqgxeA4o/UszURdq9L6szLULYtYWcPRZOXLQhdJp9uUm/wjBx530=
X-Received: by 2002:a05:6402:350e:b0:5c9:5bcf:db95 with SMTP id
 4fb4d7f45d1cf-5c9950618a8mr6873634a12.16.1729181275258; Thu, 17 Oct 2024
 09:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
 <CAFEAcA95QmpcsrgCj5uE-Ng8ahNir3MuVEHWBCvjb3UwBbOFRA@mail.gmail.com>
 <ec0e8a75-c59f-41b3-b559-43c057fca8fd@roeck-us.net>
 <CAFEAcA9AZS1dGaLG85zZE8U0d7AcrLgKXNbhxkCoP+PLmbFn2g@mail.gmail.com>
 <cf7c8f57-22d5-4a40-bd87-0f15f5457d48@roeck-us.net>
 <CAFEAcA98=2OdT9ykg5ibDuVLtSXuq4g0PLmSbxkYmt1SyKe9iQ@mail.gmail.com>
 <c354e331-39c4-4520-9a69-b62a8ecdddbc@roeck-us.net>
 <CAFEAcA-NreDmpCoFgrTJ5dEto5jQbjRg1eCfqg9Ns8VwQ9-Qzw@mail.gmail.com>
 <2e8046a2-c229-4ed5-add1-d31f437325b9@roeck-us.net>
In-Reply-To: <2e8046a2-c229-4ed5-add1-d31f437325b9@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 17:07:43 +0100
Message-ID: <CAFEAcA9AfH7cTO8TYSh9E+FnYN8SbTLDkXW8W5Jwi9Kfcddr6g@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, 
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 17 Oct 2024 at 16:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/17/24 07:29, Peter Maydell wrote:
> > On Thu, 17 Oct 2024 at 15:12, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 10/17/24 05:42, Peter Maydell wrote:
> >>> On Tue, 15 Oct 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>> Please let me know if https://github.com/groeck/linux-test-downloads.git
> >>>> meets your needs. For now I added 'collie'. I'll add more after it is
> >>>> in a state that is useful for you.
> >>>
> >>> Yes, that's great, exactly what we need. I've put together a QEMU
> >>> 'functional test' case that downloads the collie rootfs and image
> >>> and checks that they boot. (I'll send the patches for that out
> >>> in a bit.)
> >>>
> >>> (I've coded the test case to pull the binaries for a specific
> >>> git revision of that repo rather than always-from-head, so
> >>> we're testing always the same thing against head-of-QEMU.)
> >>>
> >>
> >> Sounds good. I now also added information for sx1, so you should
> >> be able to use that as well. Please let me know if you need any
> >> others.
> >
> > I think sx1 and collie are all we need currently.
> >
> > By the way, it looks to me like QEMU has a regression
> > somewhere where we can't boot that sx1 test for the SD
> > card version -- it hangs during kernel boot waiting for
> > the MMC card. (An elderly QEMU binary I have boots OK.)
> > I'm looking into what's happened there.
> >
>
> Yes, you are correct. I did a quick check; the problem started with v9.1.
> v9.0 boots fine.

It's an issue with commit 1ab08790bb75e4 -- when we did a refactor
of the SD card emulation we didn't notice that the omap mmc
controller was also using the sd_cmd_type_t enum and relied
on the values of that enum matching the meanings of the
different values of the controller's MMC_CMD register Type field.
I'm just testing a patch.

thanks
-- PMM

