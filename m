Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83313C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzGh-0002xx-QO; Wed, 20 Mar 2024 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzGg-0002xZ-5R
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:58:22 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzGe-0003Mw-4A
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:58:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso171010a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710953898; x=1711558698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jKtII4c2DDPJdzQEvjeziL2qfN7YH+yrGDSBf6hDSrg=;
 b=HmU3kfkUtR7GcLyubwEFGVX7/fYe0pDx/1BvZyYw0Qgf/Nn5zT4zpqUSYx8s6hgPQV
 ZkKuY+Sz6MtdY/EqZd3lmNWTkOAqHx4jZA1zBfN6WYkZCp+OFPIoxXslXjJUyxQbjSr2
 eJrhd8urb0tgR1RGz5yne5gCku1d1TKenyHsO1lVhpFq/pjgcrRBClSGmRG6ZEGhDvOf
 I8n+vyFpMAnlJ+zq/EtyMP3yNxnnO8YtbtpYGB1Idm/esUzTobOwddlp0KYBdT5EGED+
 40Zql7PX/8HuKBNXFXR7gBPpj7qiozWykFUlt7rrGtDn7Pw7pDylkLvi1KFv6JljBypz
 XqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953898; x=1711558698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKtII4c2DDPJdzQEvjeziL2qfN7YH+yrGDSBf6hDSrg=;
 b=BvCgQoRL/NvBDaz0JGJCvXZMd8HP4wAnuDFNHz/H3tHVjTpoE9JpaQexovJqzKCllT
 UN0BsxCwdVrJkGUs6yJ9ArfGB0vz5W5UcB7gB/hElhaA+Ay6syMuQoFWXLmlEeGiuz4d
 GQGh2fB1VGNY54/EvIgm1CfpJt4Cc5keO/ziNv4aYnUUF1blXj1JUnvYOlmMTq2/A0Ui
 5P9PqRrr8OyZqXmuD335wFqswfYP8KV597eGUO7luVcZ3x2dQ0ipoNs8Y/oMrdYcLifG
 hB+Ua0CIy113GszfKZdvGtYVpq+lihUjrQOgEFNgEdXKXtsp6A6X4iSAniex9c3RVfMb
 XeUA==
X-Gm-Message-State: AOJu0YzoFb73tWZOBGaXECen4xJlhs9IThY09pIolPy7kT8ikRXG2y07
 q0k+tecGHEY8xecM0bir8R534qbIp3ENKV12ylStP0acQft7mQXeccyyIZucT0aSXdNiDGIjG8+
 Rav78OvPNGs8ptNkoRjtzxSpZ7R4kf1xh27Xseuu4l10HNJXD
X-Google-Smtp-Source: AGHT+IEbgSlzZoXz0EObQMplQJpVxoouSKhA/BV17dhL5+3DEEJ6xSck6+RWsGVeiGdoTxPufc4vF9RVUPhQSge+IK8=
X-Received: by 2002:a50:d5d3:0:b0:568:d6a2:716 with SMTP id
 g19-20020a50d5d3000000b00568d6a20716mr226809edj.7.1710953898547; Wed, 20 Mar
 2024 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240320070851.18933-1-kraxel@redhat.com>
In-Reply-To: <20240320070851.18933-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 16:58:07 +0000
Message-ID: <CAFEAcA9y34vDEwy3tvv3h6PndZCjkyoVEPPchvkY2hoJQaif1g@mail.gmail.com>
Subject: Re: [PULL 0/5] Edk2 20240320 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Wed, 20 Mar 2024 at 07:09, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>
>   Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/edk2-20240320-pull-request
>
> for you to fetch changes up to 4a1babe58a1b3cd2c493ee6e0d774e70f62ad9c3:
>
>   update edk2 binaries for arm, risc-v and x86 secure boot. (2024-03-19 16:42:10 +0100)
>
> ----------------------------------------------------------------
> edk2: cleanup fix, update build config, rebuild binaries.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

