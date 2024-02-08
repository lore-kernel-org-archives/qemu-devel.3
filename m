Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231D0C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6wi-0005cg-IG; Thu, 08 Feb 2024 11:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY6wc-0005cA-2A
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:08:11 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY6wa-00016V-Cv
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:08:09 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55cca88b6a5so36522a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707408487; x=1708013287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mgy1HpYNlGIX3G3NTLbwdcJvojkiWvkdzj/GHjBy2Tc=;
 b=mUrMkYlzNClNVSy30FDVME+C5rXcRVqHEcTVmGL6+2GZgMLSqSP2LCQ3j3kRIRTtuC
 K/CFCje8CDXJlWaBfkSXyAV7m8l7RI9QA15aEqlIpV5mldy284CUsXv4fi/80sXXKsOo
 IjQvqIru5zgIYZ8XhUdol9JmvuqUGnt8DaobJTflHjqi2DyWAyNRf9WaWaYsdYqvwor3
 8LhWHqhS85til0u7xEcrm4Xw6SV0wz43qMBcYloLLhcafH2GLwyeYK8Mv5wfOR+UN+9d
 oJh+SWBw4BHPUrzKCgs6RukG3225EbFwwcFG1dNLvmsyvhVnLT/3FqVirlCe7Ecbonj5
 1lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707408487; x=1708013287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mgy1HpYNlGIX3G3NTLbwdcJvojkiWvkdzj/GHjBy2Tc=;
 b=A3l7fyZZLC7Kuj4o9cLAMGIJdOPAmdYoArLOXiEjw6I1mQg2lYnYip+i6xdUQ+kcSY
 6uKPxyDxYheCZP5kFA4sWkAW2KPIAkS+j1gHRzsEZ3OMv2O2b3gpdB/NzsK5sdW63JKC
 r+RsHuNnJE3pp9qHNwP+ElrJ9bj89JKWOmPZV2NWEVy3ytfJhbLeAMarcBvQIiD1jEjV
 jEO3HS/UETlLYmlpXAdfyclAGzwIgZExygkapDtCS6gmVgh8lbfoSgxJ6kUZK/MuKjvv
 I+LEpWhwEzguAbP9AY81UOmYXIuA6w6S/2TUgyIp97tUZMgsoCjga/O3RX2XxEiV/6+z
 e4Nw==
X-Gm-Message-State: AOJu0YzizbL8jRCdWiNXb/EKKATX+06EsGcRT4D22LOsAkxycY27nWr8
 +N99kn/Q69+pUtrdGLcQovhQy+E/8Cxb2xOPGRJm9hTqkRoAwOWhMtjDa6YQZIVtjenrL1COFGh
 sxupBfk9WVxWFF/Dp5nf1u3GynJ/B5YbwfRye4YO4ky7kQfJc
X-Google-Smtp-Source: AGHT+IFcmbFleVT0RPtHHKcXRj7gtLNIAe7tEDCfitSnIMT8hV6WK6SHIEZMk+cbOIwVEAmDRso751Fl7MwScNISiO4=
X-Received: by 2002:a05:6402:14c8:b0:560:d8f:7def with SMTP id
 f8-20020a05640214c800b005600d8f7defmr7225104edx.17.1707408486768; Thu, 08 Feb
 2024 08:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20240206104347.238825-1-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:07:55 +0000
Message-ID: <CAFEAcA-q-2mUHxTDnBEYMvpCN3TfM9qXXf9gwx2YSjH0DUJCYg@mail.gmail.com>
Subject: Re: [PULL 00/12] s390x, tests and misc. patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 6 Feb 2024 at 10:43, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-02-06
>
> for you to fetch changes up to a1a9800e9721f7a4b0762b97ff8961473870bc54:
>
>   meson: Link with libinotify on FreeBSD (2024-02-06 10:27:50 +0100)
>
> ----------------------------------------------------------------
> * Emulate CVB, CVBY, CVBG and CVDG s390x instructions
> * Fix bug in lsi53c895a reentrancy counter
> * Deprecate the "power5+" and "power7+" CPU names
> * Fix problems in the freebsd VM test
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

