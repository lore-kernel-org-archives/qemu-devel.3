Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318C5C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP5V-0004FP-4q; Mon, 29 Jan 2024 05:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUP5S-00048C-1i
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:41:58 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUP5K-0005sw-PJ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:41:52 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a9008c185so4352111a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 02:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706524909; x=1707129709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tCYzQLIPc8M/y1EZDs3TkG1IamJ8CfRCvmmR66j5Kbs=;
 b=CnGNKs0XQs36J+d6S8ayEXgSM7SraiTEHODXrQ9wYPA8l9d6Z8NC0bFQ6D7LJyjcBe
 CO1D3cKdQDQFH8c7B908TuSU4u7umfEOVxyGWZRyeT7iusYyqqD7s3D6gIgAkvEl+hve
 Do5U3YNzpfOmf+HagCXWJf7YSeiWG+CBmkgbnOAL03QBWGW1sNtbtMisdo/biM5wp/GP
 YrdiEll8GY1lX9/NuIfJE63QUCDqd1xzuvOfofQHL/pQJhSpWTvG/JyHBrshvGwqMYAR
 Sv6QJCnBAsZ40zGPBz3dl/Wa+dCL6mYUbmeM9hNI4njj0RZQ/S09YumFC49KmNzSP4L0
 oA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706524909; x=1707129709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tCYzQLIPc8M/y1EZDs3TkG1IamJ8CfRCvmmR66j5Kbs=;
 b=kTQ9Lgbjje3gre9hHl3B0fNa/Lx+9CEzTFQNdkWZSIHU6VZGq+TR4FLEEpIsQQKFvV
 Hy4HkuEaSwd+5TDkqP6dnxckvoosxroKuO5wdZlM0T+0FQojL1EP/KUi8y70bPyw6UeH
 i++f0L5CT9SvS2ODJ5jJKMVahbZm86V550XWvhlQHGxQk4ZwDDp29A/1ibIyknKmgkHA
 Dib6JDJciORVo1vltmW6Jw80hwWhpU3fgZkLn2O57CvYrpJ1HGQJOJYBUFky/IwhYUYc
 4orUuqY7MghOjUNYkRWhFQDCJkZltGBXrxfe5VIQPy8Rrd9VCNkGV8xqCh5OvEnKy4Di
 JDPQ==
X-Gm-Message-State: AOJu0YxPhScRNsR8Jgym6ahouFa8ZhQZeW+FfGarsn3sk88n8AkaGHf+
 44u/KTN0Ptukp59Un4aESgX2lwFdrkCn4o2U0eLyNpK4T1ua0a5Mr0MvMNQ/Kr3a3/Lc2W/87j4
 taD6tQ6A7pfugd7rRQu4pZOgjC+USzdJjju9/Iw==
X-Google-Smtp-Source: AGHT+IE0DAcj2zlbgXb+032Q5Nbt4LtO3CQDZW9YzKGz1YS8Yl2GdvoKw0iFLdx6pY2Uqw/K2wfea/MTz5AGKheUc7E=
X-Received: by 2002:a05:6402:2690:b0:55e:aca4:7378 with SMTP id
 w16-20020a056402269000b0055eaca47378mr6738037edd.1.1706524909269; Mon, 29 Jan
 2024 02:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <ZbUU6CTgxgCLG0a9@intel.com> <ZbdwhR6h6T97vR8J@redhat.com>
 <8734uglbe5.fsf@rfc1149.net>
In-Reply-To: <8734uglbe5.fsf@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 10:41:38 +0000
Message-ID: <CAFEAcA-JMCj2wVRv0JmDmmmLZiMDa1PZ2yU1QUpgiJxnaVQJ_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
To: Samuel Tardieu <sam@rfc1149.net>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 29 Jan 2024 at 09:47, Samuel Tardieu <sam@rfc1149.net> wrote:
> However, this is not what QEMU has been using as far as I can see,
> as S-o-b tend to stay in their original positions. I even opened
> an issue on b4 a few weeks ago because of this
> <https://github.com/mricon/b4/issues/16>, and I reverted to using
> git-publish. But if this is ok to use an arbitrary order for
> non-S-o-b headers, I can get back to b4.

I think QEMU doesn't have a specific existing practice here.
What you see is largely the result of people using whatever
tooling they have and accepting the ordering it gives them.
So I don't think you should stop using b4 just because
the ordering it happens to produce isn't the same as
somebody else's tooling.

I think trying to impose some subtle distinction of meaning
on the ordering of tags is not going to work, because there
are going to be too many cases where people don't adhere
to the ordering distinction because they don't know about
it or don't understand it.

As Daniel says, as long as the Signed-off-by tags are
in basically the right order for developer vs maintainer
that's the only strong ordering constraint we have.

thanks
-- PMM

