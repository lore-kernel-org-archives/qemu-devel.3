Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C43C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE7C5-0000yd-AO; Sun, 11 May 2025 09:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE7C2-0000xp-Ng
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:58:15 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE7C1-0003uU-68
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:58:14 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6df1419f94so2870528276.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746971891; x=1747576691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DymOizHJz6ZfCWnGwL888QZa3scm7WEzJt+b/qAC9+w=;
 b=NueyoE2JRXUVeF7I3XB564JM1jQazs8SZp80emFtM4zOiephqclhrKDPtQDQA2tZUr
 3KuMhB37k9k3t4mTpZ3uOnsZl2m0iUaU2xD/+VcFz5/26xcZeeKLoybbqjftvxl3c0mW
 WWvjtm0OOMR8OLJSUtMsbOtQUcTpSK18v+im4rMkw2YOf7u511LuZ0gT9XtgNTJbVfQC
 GmUBxdi29CfOIcHe0kt0EnHwCkw9uwkKMR5mfiMZqs6xMSHkvtb9imTJ6sQI3z8b1hcp
 3Si9v0rXG3vFnAsYZ8h86dVjyBnHrX3CE+sMVOZep4OSgNJ9kIOqjM2FjIv/N2HI4jT5
 4L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746971891; x=1747576691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DymOizHJz6ZfCWnGwL888QZa3scm7WEzJt+b/qAC9+w=;
 b=JQx5HaCcEIB2aPU4tGg6hlffvpO9jNKc8odGcbYFkd/1YFSaWLTXbepQYjl5zNM19V
 877UusCJbpwxx/z1u+lkcxMt1VKur3Rlzs5K7ZN4OkHaqFygNPxdPYCjFtJ5XsDGozpw
 uI+hSTFU6Qmt8JJyRpZ20/gQUCFAyfsEmVO/EmJnW4Tp3JAQ4JRFU6AINkbMVAoxZzPC
 IQGaGBKSUP+KNgHh6Dx3tqqJtDMXpXEgQ+hb2kNvPSMIBKQaTpJPar0Z2E4KNqvKp1Vd
 8thljcJeaOFhgOISOncVO7QHXzeFJkBUguEAYhCVj/BcDpchbwvxJLiz2kAWi1kD+JR6
 TWHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxFwJ4Yt4UcsqCLbV4Xj/ug3+CGOcOxTgSF4zfog4Lk1T2gb+A3O4hY/OXExuLRz7I5JonGZd3zmM@nongnu.org
X-Gm-Message-State: AOJu0YwzJNw65U7J1TQKsyiEIm4jrCUHGEWH1akLJvC9aXFRWgKIVZFe
 W0Vl9F/0217NZmEeu6F+BCrQ94aaXa1EmoU+R1t74obIcpD1TVPqwUVWg7ImzgHQcUxqS6RmkPF
 2OExX1PxlQt3MfKMduv6s+cbEwjKFf5YtKpaY+bEuABmGstWSr7w=
X-Gm-Gg: ASbGnctEHF32q+cLmQZHRsVqM7LGcOceViLvctwaUFAkdUFCMezbzK7GSFJm2JQjuH5
 Y5ekDXAbzj6ncdDxCUrRBvM3R5MCimgNA58RD5LHq0SWld4eTfuTBLrveZzesMJXbqLNsrHDO/s
 DcQipTSfMc4S/e/y8pQGyPicWk2ENoUhz2ig==
X-Google-Smtp-Source: AGHT+IGNLRulOQWthqxbv3n0ncLX/iCrBwEnDGMoGvVCzKlhkkYcNJC91HgpbYO/s9b/OXvKEfCkQyLQbr08EukEtzQ=
X-Received: by 2002:a05:6902:2503:b0:e78:f1e2:8f25 with SMTP id
 3f1490d57ef6-e78fd9bcf66mr13752766276.0.1746971891287; Sun, 11 May 2025
 06:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250507091859.2507455-1-timlee660101@gmail.com>
 <CAFEAcA82=0Pp9U=W5EAjcVkR0GL_o1iVPuUPA=w2SFy4mwd_5w@mail.gmail.com>
In-Reply-To: <CAFEAcA82=0Pp9U=W5EAjcVkR0GL_o1iVPuUPA=w2SFy4mwd_5w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 May 2025 14:58:00 +0100
X-Gm-Features: AX0GCFvImpE51QOD9twAeL6evaG7etqOtzehgfZin8mrFtvCsefGZHHF6I2eECQ
Message-ID: <CAFEAcA8qYRa+CHD+z687ATYwOBenrm_c1hg=yvVq-hzRDxMdRA@mail.gmail.com>
Subject: Re: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Tim Lee <timlee660101@gmail.com>
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Sun, 11 May 2025 at 14:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 7 May 2025 at 10:19, Tim Lee <timlee660101@gmail.com> wrote:
> >
> > - Created qtest to check initialization of registers in PSPI Module
> > - Implemented test into Build File
> >
> > Tested:
> > ./build/tests/qtest/npcm8xx-pspi_test
> >
> > Signed-off-by: Tim Lee <timlee660101@gmail.com>
> > ---
> > Changes since v1:
> > - MAINTAINERS file not need to change
> > - Add comment for copyright/license information
> > - Correct CTL registers to use 16 bits
> > - Remove printf() in test cases
>
>
>
> Applied to target-arm.next, thanks.

...but it fails "make check", so I've dropped it:

not ok /aarch64/npcm8xx_pspi/data - ERROR:../../tests/qtest/npcm8xx_pspi-test.c:
80:test_data: assertion failed (output == test): (0x00000000 == 0x00001234)
Bail out!
----------------------------------- stderr -----------------------------------
**
ERROR:../../tests/qtest/npcm8xx_pspi-test.c:80:test_data: assertion failed (outp
ut == test): (0x00000000 == 0x00001234)

(test program exited with status code -6)

thanks
-- PMM

