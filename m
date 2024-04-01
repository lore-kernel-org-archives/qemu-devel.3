Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6161CCD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 14:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrIgL-0004KE-Ah; Mon, 01 Apr 2024 10:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrIgJ-0004J7-PX
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:30:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrIgH-0000w3-Gq
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:30:39 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso4458541a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711981836; x=1712586636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GVN+lwHSohgXkQHEdJl/aOZt0jUvDhHv1XunQuVsDZc=;
 b=dvyXplyrFpLhkKvibCMIXNrkJbKQK88Fbtqd+v6mUQ7pfemLabrG3BXMBxGCKaNKKh
 vxP+zup/lyOEH9i/JA2PI7CSVXUFWRV3LSgMzAjnMCiJEOMA/24Fty8P8xYMkCA79FXG
 aplyTg1znifH3rhSOskeUA11C5akj58qXiDaPAWnyFw0tEIakRuCU1xfKgN3N/bajyDF
 MOum/337ZTkBiqytusZSGpED9XDW/59fxPgMMlONHOE8mv8mQdxdlZeg81bTiuaxQ2lR
 ZcDSgJHxasKVDk7ZpSSpK99st/OS5I9TLSzphN+5Bo+j1SSj21hZkoHuRWjM1K/JIGlH
 rAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711981836; x=1712586636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVN+lwHSohgXkQHEdJl/aOZt0jUvDhHv1XunQuVsDZc=;
 b=LU/4iNI6ztY5ckFAoc5F9V+7dbjYBFUDuMzft71baLgzoK42v41auRcw9XtuP9Ro3+
 APllZIZyWZXWN+6q0g85I65OJlTKpWatcR3JKVrBS3pJm/XJ+lwMeX/QItLKFjVHdUjF
 7fPkS6+jbfj+K0QFnjvyxc6a4CqEYAJvIkgxZ6jIKiloYXBrr1bZSP3myJlQuguYNs0S
 Z7jNG4FlNPPw7+yuEpIo7pxuHABYABYomIq4kTm0+DIplY4t3Rch0UygjJh3+UPX2TSk
 riXzlBogGJOZ6sPNr/RY5I93Y1IavIoU5ZzfzTvZO3FVatLlIjvTxhd5Pg0KVgGlg9ef
 2ucA==
X-Gm-Message-State: AOJu0YzWTzkhNEM2EqeB/Vl4sfXa6zUYs2f7WdlxGrClWtbG2GHm1pAy
 2ujFTOkS0lXGgHLbu9d/bT2DDghcCmSdJEYP4zPcZc3dxoaZbH3q34D1MpbTbNN8lh6s+AleVRL
 jlDjS2T3R44T6i3N5lqzecb3JS9WG9qpv6ieKYg==
X-Google-Smtp-Source: AGHT+IEZmr66Fj6IJDW97Ke7zvJXTbMZ+18EWddgfGFJriGq5wvUdjTKE9RkuAL1d0VEholgePEmEKlbDWlINq7IO9Q=
X-Received: by 2002:a05:6402:1ec9:b0:56d:c929:999b with SMTP id
 g9-20020a0564021ec900b0056dc929999bmr2787498edg.41.1711981836255; Mon, 01 Apr
 2024 07:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240401051633.2780456-1-mjt@tls.msk.ru>
In-Reply-To: <20240401051633.2780456-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2024 15:30:25 +0100
Message-ID: <CAFEAcA8MVD9CNOUs7m3XUx6efFWA7QhkhmVp+wgYW+L2RotVjA@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci/cirrus: switch from 'master' to 'latest'
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 1 Apr 2024 at 06:17, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Commit ab72522797 "gitlab: switch from 'stable' to
> 'latest' docker container tags" switched most tags
> to 'latest' but missed cirrus image.  Fix this now.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2256
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks; applied to git to fix the CI jobs.

-- PMM

