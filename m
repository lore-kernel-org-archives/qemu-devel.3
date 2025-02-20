Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB90C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6kZ-0006sP-Ps; Thu, 20 Feb 2025 08:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl6kQ-0006rO-J6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:37:50 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl6kO-0000Hv-KB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:37:50 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso1117691276.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740058667; x=1740663467; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fa4LnSpmWM+FWDXKWITXcQ+buHuFTcP2Sh2OxmYGuSM=;
 b=VO4wUZv3ns5hB/lEaINmfNgIozQJrxXBA24/Sn4+Z03KsAimLJ5LUViaJVgImwqlFb
 quDyTW95JcDeict+5WgOjdfH1Sn79fE8XB6OMGxc90ILdRiuSh/tiMB0xQJ6AmwMqe1D
 NVBs7AN/rcXAhbcZstGu91VFpwbK1FcttyxBao0Nl0A7e6/hwC1Awtw7cojtSpEjFl0f
 dXwj3q8LuDQ5mqO+JpauXAvg8tWgHhS9wXKQj18XTR8z9RZya+G/eyo3qx+RrNARi4M3
 Q6btdVPkQUtwe/OAxJwNdUYtYC4Shs0jDzdqnCcKy7DkPUKK+7Zkav+Hddueh2NblyPT
 w55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740058667; x=1740663467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fa4LnSpmWM+FWDXKWITXcQ+buHuFTcP2Sh2OxmYGuSM=;
 b=nj7N7T0k0L2sV0bPzsk2qwwGkdAhHtXemet7C9XSyaleVQvrdO1kW3HE3cVQYXgxgD
 mlQzn3dcmT/GJdOBp/Oq8ok3v2a6z8T1o/I+BoTz5luaf+jsVupfMvllNkBm3v9o8sX4
 CuaUQJiIngTqCmBgVaxYsOnwRIHZQGbt23mLkupbeyF+V1vpfGOvVaBKbBVL7H+IAsu5
 82/nNZWmOPz9RlAvEE/ZMyPOqbHThZ/YbL7Lcr1vktpj/KdMjBavEIC2lW9/ffIDpTJ1
 Li8aoaPYCbYVU5AhB7kjIvlou+oAAMtqBbIn+UXqlSUsXMfaIDEMBl/+pGSx06xZDgRl
 KFNw==
X-Gm-Message-State: AOJu0Yyqak1cyUKx1Cq0zIJwcpUXtkrRVRWdvlrGa9eezXtjm1ycyMf7
 NVNHE+WdvNCUDAHEAD1omEaD76HBrbbft8plfV2vbrBrrojS3g7MDskTdDCk1mpUr9vWmel0V6i
 DJqHn3k4Nv5D2p/lmK6TGIv8nCWSaWpfwRyiuDQ==
X-Gm-Gg: ASbGncuMXMGrGu9DkogDNNIsZqbx1UYj89jXTkWs4wXlq9AxrOdWj5DTsqOnwbxknYs
 uJyDUAEmsX8+b/XshLcxGPywonKlv4TBsJkRQvd3GWTMW/tUmEWWz3R9bAt6Xwn3PE9JZGR+JnA
 ==
X-Google-Smtp-Source: AGHT+IFPGY9bQskzA+16G70k25BejPSkx8Hkhy1eJCAFVRVYIPSAPZ7T9bQEIpQXGjyIjCuRgNXZ+Q72FMkx0S4Xzk0=
X-Received: by 2002:a05:6902:2b02:b0:e5b:248a:bf2f with SMTP id
 3f1490d57ef6-e5dc92ef7ebmr16790092276.31.1740058666981; Thu, 20 Feb 2025
 05:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
In-Reply-To: <20250219150009.1662688-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 13:37:35 +0000
X-Gm-Features: AWEUYZlkaRug_jNCoWmm4s1_5JiREgJ4pWCXtTkgYFaAmG84oaTcEoeoMFXzxBI
Message-ID: <CAFEAcA8Tz97tUBLXD00XkzrbWu3ncOS7tciwkY_Pjq2-jCtBpw@mail.gmail.com>
Subject: Re: [PATCH 0/4] testing/next (aarch64 virt gpu tests)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 19 Feb 2025 at 15:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Hi,
>
> As I was looking at the native context patches I realised our existing
> GPU testing is a little sparse. I took the opportunity to split the
> test from the main virt test and then extend it to exercise the 3
> current display modes (virgl, virgl+blobs, vulkan).
>
> I've added some additional validation to ensure we have the devices we
> expect before we start. It doesn't currently address the reported
> clang issues but hopefully it will help narrow down what fails and
> what works.
>
> Once I've built some new buildroot images I'll re-spin with a while
> bunch of additional test binaries available.

Running on a non-sanitizer debug build, I found that
aarch64_virt_with_virgl_gpu hit the timeout. Looking at the
output the last thing printed is
2025-02-20 11:46:36,864: [shadow] <default>: FPS: 45 FrameTime: 22.585 ms
That timestamp is 4 minutes into the test run, and the same
[shadow] test takes over 2 minutes on the with_virgil_blobs_gpu
test, so it looks like it just hit the 360s timeout and might
well have finished OK if it had been allowed to keep running.

Actually I'm surprised the other one didn't hit a timeout,
because its log timestamps show it running from 11:35:03,896
to 11:42:26,468 which is definitely more than 360s.

Is there a less time-intensive test of the virgl code
we can use? check-functional already has way too many
tests that take minutes to run...

-- PMM

