Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFE5C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSeB-0001TW-V0; Fri, 21 Feb 2025 08:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlSe5-0001Qs-Ie
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:00:47 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlSe3-0003lY-Uw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:00:45 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e6020784c29so352486276.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740142842; x=1740747642; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CLNG081HcF1X/Nj4rhOxIAHxkibNg8/jsIrqDnETVFQ=;
 b=qheXEbwFLYWUqUja5/hYLiCMCTFIlOaRN3A1mvCTfpCSjCvjtjnzCq/15DcAXdKIMU
 uXYiXrGtQ+6qXQM9t80Y11zhhyc7aFyMhHztdYeO/wei0pK6wwzNa5/SeBgQ9MPEVzJ5
 bdhgUdNO73XpItC59HFSs7lf7UUeQLZF3/s3DP8h3iG/aMOrSKlZZZnVGGq1odaZzCh9
 zo7H0GxbWzXGJMOOeZ/FdkhFqgzA5wdrk0R5lA//jB/6syYQ2jNY41iwmdnnBnQtzgC5
 O+fQ6Ch/R2ny92U09n4VBGNEh6yTBNVWPl7EQPAiy6gaeooxepKF0Ks+zvc8W4xpZ9Yu
 11sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740142842; x=1740747642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CLNG081HcF1X/Nj4rhOxIAHxkibNg8/jsIrqDnETVFQ=;
 b=Jb6mSZZJjxGGT9Ips53LOwpNJqPBnhjQN7Hb5rV9R3b9zuRbF94mK0T2fyfBfACsCN
 QvPpoh0ZMDTSiZY8m8BmIClsy+5z7cxkB4hWwrFSf4sQxwLREMrnkABMhBRlTWJ8gsJZ
 /91xaTCfxD0nZfziEvDLN24vxjrYtOfy07QhuD6aVWYIO3wI2EOtd8hV9CC/+e7uDIBS
 Dlh/8NDaxpu8lpuIUdE+QCit9Y5P8nRIkH0CIrNLINPUNgHRXsPdQHDKc7vEnQpv40jC
 dkKBKBUFSwHbHzPUVHrNDiZ9dELVl8VJ5zAtM1IFqfVhXp2rfMd691uAqPh+EhXntznm
 g6Jw==
X-Gm-Message-State: AOJu0YzAAm4LPOD4cdxS59n3KVjE2O9rY/Wq5ByQNB6iYgEI9L4R7olk
 kJ9T58/xSHyPOtulNUbMFpDYjXTSBWugfY9Fw6qcZl9nWXBJ1DaqLLEJxUQxkZlnAZ4azcQU02y
 hWDI61G1bEPGh9UzWeWAb7bLsUoN0lwL5i8C/Yw==
X-Gm-Gg: ASbGncuyIlApdMOvGk1gos9hx0G7wTpNJdmnPu9PheFHz6A2HWlayoXys2xe+4qEVNZ
 Q/dbgzZZ/nRGQTjGqDzuwWbPoERsrLOZ9sCzPutqPTu+oB0tNLLkI62KGGDACMhqYrY+bsdqHEo
 VhXkzCwK5X
X-Google-Smtp-Source: AGHT+IFy8v55+AzOk/y2rqBo/U625AdknbsgTJSWN6SXSfFq+KuQ2XSRMK0zVC3eQvmOsWGEdIG8AUlprUjWlzxYFbU=
X-Received: by 2002:a05:6902:238a:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5e248fa128mr2694586276.16.1740142842080; Fri, 21 Feb 2025
 05:00:42 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-u+TMgQV8G8LvQixE95BGhfN5hyYdxcZTnxu5StVBKRw@mail.gmail.com>
 <014caf20-41d1-437b-bd0a-6ef263a709d1@redhat.com>
In-Reply-To: <014caf20-41d1-437b-bd0a-6ef263a709d1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 13:00:30 +0000
X-Gm-Features: AWEUYZmIH_HlNhhlbqhsB60TGk-LD5BjiVf7EnW2Eu8dsqe6e0dGuDe5NRcVsHY
Message-ID: <CAFEAcA8pgAGfDUAu45fDur91auFY2O18YDir_RALMojK8FCx8A@mail.gmail.com>
Subject: Re: debugging functional tests that only fail in 'make
 check-functional'
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 21 Feb 2025 at 12:54, Thomas Huth <thuth@redhat.com> wrote:
>
> On 20/02/2025 19.39, Peter Maydell wrote:
> > Any suggestions for how to debug?
>
> Some TCG-based tests are slowing down very much when running on a shared hyperthreaded CPU ... Do you have 8 real cores in your system, or rather 4 real cores with 2 SMT threads each? In the latter case, have a try whether "make -j4" works better.

Yeah, it is a hyperthreaded 2-threads-per-core setup.
-j4 is a bit better but a few things still time out.
I'm currently playing with bumping the timeouts.

> > (Also the console.log is empty regardless of whether the
> > test passes or fails; this doesn't seem right.)
>
> I think we only log the console output when we look for strings
> in the output. Since this test does not look for any strings,
> there is no log.

That is very surprising to me. I think we should always
log all the guest output, because it's often an important
clue about why a test failed. (Ideally we'd log it in some
way that let you match up guest output with the logging
in base.log -- currently because of the split into three
different log files you can't tell what the relationship
is between e.g. QEMU stderr output and the test's progress
or the test progress and the guest console output.)

thanks
-- PMM

