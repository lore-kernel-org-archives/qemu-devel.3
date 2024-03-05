Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A379FC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUuz-0006K5-T7; Tue, 05 Mar 2024 08:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUuy-0006Jt-JJ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:33:16 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUuw-00022B-1r
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:33:16 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso8170361a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645592; x=1710250392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7tKGWIW+fFOvHzcdRyQ+OAZJL8lUHfcHX3y8hGNnSQc=;
 b=nWwpHmgRMJWXcobUlznjHkEcZL9eJhQgXIZOhTwW6LO5ZnAmBpsxXHbK+oo5Si9UwR
 b19sDsCcFf/cRpD0oqG+IxL1OCM/fGvPqyP2zgrwOYykDxHxLQb68W6dsTg/PhorsUlB
 bnFgbcjp9CXHcd36ipYeqUwFMb83Xy1A3kC6ZKq0dfSpAMYWvYgFCLfw4MOyy/B3Qh/U
 w1q3JF3Im1kri8cKqKQ8JcrE1fuWlGnXR8L06p3vCO2z8zFsos1cT2fiUGYT257NnP3Y
 5kP1cjaxRzFVVCsvnyoPIlcGWtYlFuQ+maSVWTePVjostF4ZSA/vLm5kgHso4fk0kX/v
 ZKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645592; x=1710250392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7tKGWIW+fFOvHzcdRyQ+OAZJL8lUHfcHX3y8hGNnSQc=;
 b=ggH2RW8oCw/yqztXDZWPadw01DxhUHhfldF9P1OhszMynvY3RF/SS3iP56X0z8xQyW
 ROvVKv474IByynmiMt0NOyx6Pkm9msS3z2ZafqpKBdtPCkWTJf3C4NIK2db5Wcsu5C+2
 yJvmY7doIJtUdhNmrx4HcpOlciyMGmIJwzrBvUWMayM1CUy1yI3DNmJ5GsxFMbZ/mANo
 3vZZ1E9W6RdnNp4z5esZez6BPvvR6aH/oYygT6Saq9G5QEPcQCMTNnV0IctkcSu8V0qu
 yEgr2e/EMqgmr4T4FbDwB/1loUkpmWrF8UFG2wPBsEolsFLdkpjJ3Z72565oCM9gg152
 Wkag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7YVjYsr5+oNLvASNV/9RoRB4k39p7ZDYxXWpYBTRXIIalP4RJFdprUUfGaIHNXOlvSlQTxex8BEgu3f70HaUdca81se0=
X-Gm-Message-State: AOJu0YyDvjfo6fjXfnM0orgvGvauySMPLP05MFsUjUhZA/S0M379ZYg6
 5glswg7dQTwB3HxR9Wl/j0kyTViTuMO87Bm1FM8konlNVtvLeMTV1Oavt6HdihwaS0f5RDp3AU3
 JTB14hWpIY2GKwvUnBQzj2hCona383UqCX63H+A==
X-Google-Smtp-Source: AGHT+IEbner3InpQvXmclITIEgoQs4iruhgqBjIj3iucmw4pBF9bDBTpCXSOr1pmWoBXFzZpxqK3DQj/c90bwdMYMTs=
X-Received: by 2002:a05:6402:2267:b0:565:6bbc:39d1 with SMTP id
 du7-20020a056402226700b005656bbc39d1mr8069391edb.5.1709645592642; Tue, 05 Mar
 2024 05:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-11-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-11-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:33:01 +0000
Message-ID: <CAFEAcA8LoGjtzeh9DYurbb_xEOuKzYMPWG=3ucOkNVvdVTd_=g@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] contrib/elf2dmp: Build only for little endian
 host
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 5 Mar 2024 at 07:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> elf2dmp assumes little endian host in many places.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
> index 6707d43c4fa5..046569861f7a 100644
> --- a/contrib/elf2dmp/meson.build
> +++ b/contrib/elf2dmp/meson.build
> @@ -1,4 +1,4 @@
> -if curl.found()
> +if curl.found() and host_machine.endian() == 'little'
>    executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'), genh,
>               dependencies: [glib, curl],
>               install: true)

If it assumes a little-endian host that is a bug and we
should fix it, not just disable building the tool on
big-endian systems.

thanks
-- PMM

