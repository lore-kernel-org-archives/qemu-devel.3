Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EA0C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCWh-0002xV-Uo; Wed, 13 Aug 2025 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1umCWZ-0002x7-0S
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:32:19 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1umCWP-0006bE-Mi
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:32:17 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-32128c1bf32so8582217a91.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755095525; x=1755700325; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
 b=qImzVuuOa7cjXZW8Rn9QbrW1wbmj43TraabuE/zqI3Vt69964cfXWy0D2mkBMCFl2K
 cTDxuXmjg3NrqdSHpUC5XHTOcIAGnPpLCXp+ztzsauGz8QZDWvFgbXC7Rh79HbAze/7L
 8pRsDJL8OWCrulOKEE9BATRx1FcgJKS6zs81oPwvWvrvvAW2tBTgjf+XJ8enA/Zeacx0
 FybZdlSmiqzvbLF2fa041+tGRuoVZJ5kMODA7ok1daId5fAKInN8CZ48tfKbJNje6DYQ
 a7XAAnY1QIrTumztkMTgOozHUdqMGSho+JXIRoYB/G9lFxCGswxOLG3YIDxNfIltes/G
 81+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755095525; x=1755700325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
 b=XC5tM0S3lOuzU695Cv4MH3MEKq6x2KawpVtCHlGUZYd1HMTGRCufMZ1PYOLPwn98GR
 uhacHwPg4m12TYTLeAEsm7MXIpXcWIRyVjGYO3uyAbcAYl/E+lAhxpJA+cODtwTy+q9m
 npmnZ1ixKYbRxKvSQqFXT3PtlCUraW0vvbCdc3+NB0bgqNpAZLAvQxmv0JHC2ya4rnL3
 xJmc0ut+PzfhYRYSkHv8qlqJh3irayvHQFB7nsLhkyl3zG8wNmHArqG9fDIVmA+6yBBM
 y4ONOAj/HqEQilr/Ovm/dO6xX46fegAmf5wtB8f9Jgg2qPHPeRB4tVSOz/38MY3KH7Pm
 7G/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjKxiLenJwmVJj+vzFboMqu4Sa+PmMoDsZD1wSB2eDCvP73n9EP2hFbtGMufQCpgVn54EA/+2sC2ec@nongnu.org
X-Gm-Message-State: AOJu0Yz4OfZEjsmhG0wcvUQaNYoSoXxBTw0CIu6wfIyqvLaKS+xwKljN
 E2HhRhUdn63kCfOaMsjWH1zW+EZmYN9625e6K34eXzVHv84rN3htB2tQYABrdKdPKEmEmrw+pHi
 eV8qUOVIcBMsK1HPmQo3fOHDWGlFbRK2HqyqM+0IvfQ==
X-Gm-Gg: ASbGncukIoj6zPJUouXJ5hLVrN81K3UFU6jFtVzIbMeyobFl1pifbXWfz6zP3x+s2lz
 YCGtNO9jnf0tr9oOBwP69yHKUkt774zl0O2UpbO6KsHiC0dQpHb/ZQWQqOP2jGuN6CStAReps5w
 WpnseGHuve3WhF3lQEuYA6T8heIhUcvqWXhfIgmAW6GT2gqMjAMkWIewOTg2hg9HphT4vxlaKRG
 TZ1jQUEHnubhGzS+e6NTkr813R2eKAMkuSfe/KBtcBCY1dXOiYw0QUM4gq75w==
X-Google-Smtp-Source: AGHT+IFzsa7z2LB/NwMV+7ODMzwtQZ5c6SDjL/beKBH/4CiDe3n9MltwqzwrpDodhDWNKfzJI3ZmU6XpdnvXzSkeC14=
X-Received: by 2002:a17:90b:39c7:b0:321:cfbf:cbd6 with SMTP id
 98e67ed59e1d1-321d0d6912bmr4596811a91.6.1755095524619; Wed, 13 Aug 2025
 07:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 20:01:51 +0530
X-Gm-Features: Ac12FXzTlKbJUDUafTa4ZlpVkqfN8sdY7Wfx9w4NKXTaujZ4mJCVSf-u4y5vZP8
Message-ID: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
 broonie@kernel.org, achill@achill.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>, 
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, 
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
 Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>,
 Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, 
 Zhang Yi <yi.zhang@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 Baokun Li <libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-pj1-x1035.google.com
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

Hi Greg,

> > 2)
> >
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01
> >
> > Reproducibility:
> >  - 64K config above listed test fails
> >  - 4K config above listed test pass.
> >
> > Regression Analysis:
> > - New regression? yes
>
> Regression from 6.16?  Or just from 6.15.y?

Based on available data, the issue is not present in v6.16 or v6.15.

Anders, bisected this regression and found,

  ext4: correct the reserved credits for extent conversion
    [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]

Report lore link,

https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

