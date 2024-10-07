Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4594CFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxoUu-0006Cx-6W; Mon, 07 Oct 2024 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxoUr-0006Cj-Rn
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:14:01 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxoUq-0008Su-47
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:14:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a7596b7dfso774177166b.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728310438; x=1728915238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tWqi1utrYhC9nyZC0H9Cc74iRnByuGQADF5ttqmo1tk=;
 b=SqmrVXaKZNsYq53vUlZ7hQxcPHmC/D2cwpY3nAEpXlMHHDBtElMVHmBQBA8zOV4xAL
 Op1qGBJSRsQ94oVRX7b6r2ik3+PC/uBcMt/erIzZVjJuGG307r6u12O9hTQ4T0cei3Sp
 S4vN/Osuuin93Xgq9paEmwBcwzyjv7skY2b0UCf0s2BT4S6/bQE7EoSpnygVTMNpcIR9
 xsUkZRZcDp6I/CiMRxbGFSulbQsEwLs+VqmvmxuUmlPY84s3wv82OhpxZZoPz5SvRugX
 HlOrJjcN8TIkDiavJn9mS790lJT6SN9tJi07MHkhgd5xmMlI3EP9ZVAG6t2DMbqxB6Ul
 0DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728310438; x=1728915238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tWqi1utrYhC9nyZC0H9Cc74iRnByuGQADF5ttqmo1tk=;
 b=c1XvKID5+L+97qzgm3bijmcRjiq75FwCjUjiwb3pUHUWNuDZRomnzc241wIITdmybQ
 a5bXcGWjLu84rS08O+S6qW9niWLPvz+rcnPwJsuuS3ydVywpIA8rTZ6WbXUypeagwmvm
 fFGiLh3K+TKeFEsl4CXzKPfQDyysWsx0BlQqzddrbBAKnWR6h6TwbfijK3l7i4amzklP
 gTkPgqWGpMyX0orRMm7Vuvg92UvhVa2JOxpeEwreU1zfgksvGQTD38xr64MpvNSgXFow
 M6GR3znAnE84LrMx8oPzPfRMkBxZCnlVVqaVQHx8jPaRAipD5ojxqGWSbQa9qW4I/xTr
 2coQ==
X-Gm-Message-State: AOJu0YwU/zc13sH4gzZ7Xskq7fx3iNBq4hVYOatwEKRG0tVprAjtyQzh
 7I3pI/Qx5KTN0EwfPxIP6jNiY4zMgZJIcl+Fdlgj7htjz9rEiAHsJNuxX9DPS0uK5U3+nTWSmin
 2Jd7FAHfHDvGsvfAfYVftzsqifgg1Hels6d1vrQ4l3ogU/2bG
X-Google-Smtp-Source: AGHT+IHhp8rK94QKD6SbW8K+fqcb3pEWZz4+KCUYP1wbztzThCB0wJiOTl68xEJ5uDOcVLnRsxmT1m/w9fU6bP4/cZA=
X-Received: by 2002:a17:907:7e82:b0:a8d:4c83:d85d with SMTP id
 a640c23a62f3a-a990a04e25bmr1822750166b.12.1728310437730; Mon, 07 Oct 2024
 07:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241007115027.243425-1-thuth@redhat.com>
 <CAFEAcA8C1K5jXvSAf_DpSFDDzj-hDSuduCsuyLa5N2M1Vu0_kQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8C1K5jXvSAf_DpSFDDzj-hDSuduCsuyLa5N2M1Vu0_kQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2024 15:13:47 +0100
Message-ID: <CAFEAcA-aCr8FAFQPJN4a96DPCQ5+7jrZZGvsX=EJdeSy3irH1Q@mail.gmail.com>
Subject: Re: [PULL 00/12] CI fixes and various clean-ups
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Mon, 7 Oct 2024 at 14:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 7 Oct 2024 at 12:50, Thomas Huth <thuth@redhat.com> wrote:
> >
> > The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
> >
> >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-07
> >
> > for you to fetch changes up to d841f720c98475c0f67695d99f27794bde69ed6e:
> >
> >   tests/functional: Bump timeout of some tests (2024-10-07 13:21:41 +0200)
> >
> > ----------------------------------------------------------------
> > * Mark "gluster" support as deprecated
> > * Update CI to use macOS 14 instead of 13, and add a macOS 15 job
> > * Use gitlab mirror for advent calendar test images (seems more stable)
> > * Bump timeouts of some tests
> > * Remove CRIS disassembler
> > * Some m68k and s390x cleanups with regards to load and store APIs
> >
> > ----------------------------------------------------------------
>
> This suggests it's moving back to the gitlab mirror for the
> advent calendar tests, but one CI test still failed trying
> to access http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
> and getting a 503 from it:
>
>   https://gitlab.com/qemu-project/qemu/-/jobs/8009902301

On the rerun it managed to download:
https://gitlab.com/qemu-project/qemu/-/jobs/8011303154

> The clang-system test also hit a couple of timeouts:
>   https://gitlab.com/qemu-project/qemu/-/jobs/8009902206
>
> 61/109 qemu:qtest+qtest-alpha / qtest-alpha/qmp-cmd-test
>   TIMEOUT 60.10s killed by signal 15 SIGTERM
> 93/109 qemu:qtest+qtest-arm / qtest-arm/qmp-cmd-test
>   TIMEOUT 60.04s killed by signal 15 SIGTERM
>
> which are presumably pre-existing intermittents, but I
> mention them here just FYI. Some of the other qmp-cmd-test
> runs in that job also came close to timing out:
>
> 102/109 qemu:qtest+qtest-m68k / qtest-m68k/qmp-cmd-test OK 56.56s 65
> subtests passed
> 105/109 qemu:qtest+qtest-mips64 / qtest-mips64/qmp-cmd-test OK 53.74s
> 65 subtests passed
> 106/109 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test OK 45.48s 65
> subtests passed
>
> so maybe we should add it to slow_tests with a 120s
> timeout...

As expected, these are all intermittents; on the passing job:

https://gitlab.com/qemu-project/qemu/-/jobs/8011303114

they completed in 19s, 20s, 19s, 19s, 19s. So we're seeing
factor-of-3 variation in job runtime on this k8s runner :-(

Anyway, I've pushed this pullreq; we can look at the above
two things as follow-on fixes.

thanks
-- PMM

