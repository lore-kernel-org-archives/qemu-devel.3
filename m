Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B219C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 11:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSxWz-0000ez-QZ; Thu, 25 Jan 2024 06:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSxWx-0000ds-W2
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:04:24 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSxWw-0000MP-A6
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:04:23 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so1285582a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706180659; x=1706785459; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DElJdwkJ4Jd916Jz3aAhSW19N2hTUUTK7AhnNkymAtE=;
 b=ARjlap3ycR2MLa0HufS0I9ONCGhQZc7VAI8hEad8DPXQFVx0UaTNfoEJsSIGrue/V3
 QtaR6CiX4AAe4Vmh9uo+Ww3Ou3q6GnZx3K0U9QDM3hb2dHYv8Y1uvB44BkpOnOo89Ns0
 rzpvc++8WIeZ8/nhQC9VhwGOoO2VkVSm4WWMVXDk5OIpms8e13F4FWEOKH2QVEo9filF
 zNSdkNU375HJ8sqStQi7SnA9BoX0umYtZH6yiE4jloVNcQv7BCjgaci+JqjOwFywG4Do
 7KlPTlg5rCC6aXZoKkwrYJELZW9oXMQ2oDlT17CnUFd29TjlT2FbsXLQF8SFVPgHbLKC
 D4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706180659; x=1706785459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DElJdwkJ4Jd916Jz3aAhSW19N2hTUUTK7AhnNkymAtE=;
 b=DBlOyriz8qyac3Pfo185vmuBh/nTyEb6DNc3o56bh1a5mjBYci1jwOZWjkXgTZ4HBC
 boXQUIAu+JIaMBND5aN3vhVsrHucd30OcZQet4Q5xKmH3ki/iyDaL7vM5Sxn4GixMGB+
 44mvjiY8C7rh/kmyhI1Jon8OhcedsiSCD5R7e5uWxghtuiY9YhM+kJsZp6f73K3B0YDv
 Z046R7uvGTm6Sq5Lj5pZD4cfVoLPlb8AW1FJKQChunzHk96tLz/dcZfDO7WEKtkr5Opl
 ArAaxI8qCTOJtRCexpt/8q8F3AGxM/6crVH2GhMkwyqLv/lGKpYRoxVhVRZLCOzSyq8/
 nmSw==
X-Gm-Message-State: AOJu0Yykdxe4BME9ybfDqmjD+ZyXdCO+gB/sxF5J3UmWBzXRMQbFe1nA
 cdvgoEtbRhyfAu3QBehVdDCIsYrvoffYNRXgiOkmgeEqC0Wv1apSzWqVppF8V7EqK8b8Q6e0RoM
 UtsgEcXVuI0hD1gm5TZ4aXqWb8UqBfMGObGgWeQ==
X-Google-Smtp-Source: AGHT+IGJ4bo+kk0gGxvkd4SKL0SlafhV1GwtyOsX8KYZXSSVQUDpfKIxiNdssBFE1EF3CfnDSNcCLAW27kF//TmEP/4=
X-Received: by 2002:a05:6402:1609:b0:55b:7fd6:4daa with SMTP id
 f9-20020a056402160900b0055b7fd64daamr757828edv.8.1706180659369; Thu, 25 Jan
 2024 03:04:19 -0800 (PST)
MIME-Version: 1.0
References: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
In-Reply-To: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 11:04:07 +0000
Message-ID: <CAFEAcA-fnOjEOWGjw1vqyx3Evnf6U99-Yo-mqMkXD87J_ZdTgg@mail.gmail.com>
Subject: Re: Do we still need pre-meson compatibility hacks?
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 25 Jan 2024 at 07:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Right now configure contains a couple hacks to preserve some of the semantics of the pre-meson build system:
>
> 1) emulation of ./configure by creating a build directory and a forwarding GNUmakefile (requested by Kevin)
>
> 2) creation of symlinks such as x86_64-softmmu/qemu-system-x86_64 and arm-linux-user/qemu-arm (requested by Peter)
>
> Neither of these are a lot of code, but if people aren't relying on them we might as well delete them. Do they have any users still?

Personally I have moved away from using the old $TARGET/qemu-foo
so I would not miss the symlinks if they went away. Can't
speak for anybody else on that one.

I suspect that "just run configure in the source tree" is still
popular with the kind of people who don't frequently build
QEMU, though.

thanks
-- PMM

