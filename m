Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAB4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzHI-0003Lx-To; Wed, 20 Mar 2024 12:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzHA-0003J1-Sb
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:58:52 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzH8-0003QT-TL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:58:52 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56bb3343552so10329a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710953929; x=1711558729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dj2YzD7Oqzt+QMzgxqQ0kx9ft9DSRhJJmKzEQOhPi5A=;
 b=QAo+KiCvhEQn/j5zuNLrPQutFf5yyvP7fRhC9vq0vvYWet6j5obD7wL6IkRurXhqHn
 nUxJzgGTct14+mJzadkZ5Ml5JDD4xyCdsXeP+J3Fvn9wPYnlS5QgblRofMpsSI/obFE3
 V3aNUwIR46rqtnTJLffjtUp3VNnWTZgUNA5dOcmHf6mMe4GVA8+SuyUKKf1EBZ1sLOai
 RiUHjW7FaLX9E5816u43rzrEBiUPDBLcobBHSASg38PMPGay78kVvHs4WQ6stg5I+VaX
 OTrr/Irs8B4YmXygB5ZQGLEXWmFYhfnXUvg9ZHjcS09vicz5njGF4nUoId43nf03gyyu
 k4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953929; x=1711558729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dj2YzD7Oqzt+QMzgxqQ0kx9ft9DSRhJJmKzEQOhPi5A=;
 b=hAO8813NVz34x3jxNn8+rDTUcjpyxPuTSBN7MRimSOsgIP2Q7csaeVYhhvsIj1WRjh
 fGtHxBtOL8hWS6S4ts9hkncu4tPwKX1AfrEH/UahuCbo8jeBlGFGjoMCbkmHUfFkq3nr
 MAhbggG8ucVx8mX9P/RdNneMgIaf0EQ1UiZdXp1XqWSdi3DX9AkThyezas3aVyh1uMf2
 K0ZM4/vxU7prADNXW4RFJhLowlUddDd6e6kvWkY8EzTIKS2Ja9+SJqdPkX0vKVz9PL18
 gDH2IiGN/ddl4v20da9MEU7aJJ37fwjb2uTxrXU+5S0WP4S5HAeq+C4lTMz8Ez2iBGRq
 CgxQ==
X-Gm-Message-State: AOJu0Yxl5IHo9/pMFz1wxAGZVWuBya9C//4GG9XyHtaucErkGbZq/RkX
 2r6aI1UAueewr6jl+E61fyqUsNFYRVi0IjUBTSLh37kd+hEemXNzQjrkd2xVWdRBoenF51WMF0/
 bzt8a3OQrednS7wKjh6Z8WMa+Ezl5rES+lY0dag==
X-Google-Smtp-Source: AGHT+IE7Eu39nZOeyhbgn+Y7KW/l+kNquKhUyrBvjMVlkrjXlnX/d/sK+IncqD7+JCwe58iLcDpoKjgNN2/S3wSkESs=
X-Received: by 2002:a05:6402:e08:b0:566:aba4:7209 with SMTP id
 h8-20020a0564020e0800b00566aba47209mr5123563edh.13.1710953929324; Wed, 20 Mar
 2024 09:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 16:58:38 +0000
Message-ID: <CAFEAcA-f02uiAZ+bppYu_P1qhjcJnGM_YZPXMP3ECftHafnkDw@mail.gmail.com>
Subject: Re: [PULL 0/5] Ui patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 20 Mar 2024 at 13:54, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33f=
a7:
>
>   Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to d4069a84a3380247c1b524096c6a807743bf687a:
>
>   ui: compile dbus-display1.c with -fPIC as necessary (2024-03-20 10:28:0=
0 +0400)
>
> ----------------------------------------------------------------
> UI: fixes
>
> - dbus-display shared-library compilation fix
> - remove console_select() and fix related issues
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

