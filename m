Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C297C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 08:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh2DU-0001I3-Py; Wed, 30 Jul 2025 04:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1uh1pY-000276-9s
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 04:06:36 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1uh1pP-0008Jk-Nc
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 04:06:28 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-31ef50d8d57so2170005a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753862780; x=1754467580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ge6L4oGfLaHpfj3uC/1S5EHUWvHgeakjeQxfeFcNz5U=;
 b=RiXe00mmlkxIULCRh1Qb4e0/8gNo/vaboNXiPcn0oY5Y5LEVSrDhwCK0lhuM0oyahA
 jdG1x7hOCsYJjV3gCaL/l6jMTEeqJxZNgNaZZwSIPTKyJ8WgXyAdBgfJtFIAs6iXEyT5
 u5ExFIrY4qSYzYOlEGRRTiAPu7xt5PLWkOTL8prTif9JERs6jMzRqu9xqSy68lWWklmh
 Wp4P6oxmNd1IUeviE3s0sZA/A1lMdjt3+/3eerxwDGcPgZQTk34R0o9YRsPom8GZJ1+w
 XJRJDRxoICoMlY3DW/BPjseIbSaiEi+cfokbiKYp7M8qZsstqyT8anXmpTZAaAJtkOB2
 d9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753862780; x=1754467580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ge6L4oGfLaHpfj3uC/1S5EHUWvHgeakjeQxfeFcNz5U=;
 b=nXEetFyt+ly1PErFnV258d/I1LZlo2L1jKy+twT4UpeviVtZvxQMHQgMZxK+SyU1un
 G91tWqaNMfpdzFXwjS4imQkn7+fDA7ZlanofidPFkGtW6FhT628hQpIdBdnjyInEwUqB
 liFOGqqgO49BNCQmdHf/1wAvlOiQtzRGzHsYeYnRrsucCsHp3Xoh9Z2iUEma4v2xkxli
 yFGg0KknUr42ToS7AuQwQALNWBwmqljXBTClyhmCllVSZ8BUbY8nPZnbeUzy1F69rulE
 B7meeVbK0kIrSKy2I/2KjBUfdS9o/MyGIEDd6Ehtyu6KFubpi5uCytCULgIQD90Gs4WZ
 /20g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqmbT2XFTVK6MrGQ35BHmk92QlhpZZj+wihA6DL/0zTu87jMs/yULyizXTPz+HA0HYZHJ/t81Ctvm@nongnu.org
X-Gm-Message-State: AOJu0Yw8Ux1aTMIHFFe9+81W2vvHVDpMvfA/Rl9bMBubB6HEPmQ91LqQ
 1lXywLZdc03/25XG6UbjiGyDKj8eF36tG9HHZUTX9SM/uakHXX0PZO+5sByIUKs2NeYin4QbpvC
 YKWUt/EEpjdU2VaybopjRtSGV1Wcwf1A=
X-Gm-Gg: ASbGncuRzr4CSRSwyZSr18tzpSLiEaGM9WXqNPsQy2ngLkHuXbQzakFDTBDAIiXuSEY
 VUUSeXcP7FjoV1kfK0brQzzXdTu92UShcBOlztejhpvGR4XzJiOR7+Lj8TqkFd3odklnu1gGhbP
 8wN6tApsaXFvE+UxFH+0Slp29uce3e6lR/orczEHz+dwrVV9gmg720HFdumVSsKU7DB7GuX42ej
 SefwziQcg==
X-Google-Smtp-Source: AGHT+IH+bQ/wIaV6yMmRXYLmT3u+7TyZ7z/lC/GoLCPYCgxpS+Gwdx7PjEUQK8w2OLbNLEaKMfF8bwSOB573JDIZbqk=
X-Received: by 2002:a17:90b:1dc1:b0:31e:e3e1:3686 with SMTP id
 98e67ed59e1d1-31f5de31435mr3399477a91.19.1753862780478; Wed, 30 Jul 2025
 01:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMo8BfJw_EUUuGT0qVwhfgEi_tLzSmrOdwAip1E08XNZ4XF=6Q@mail.gmail.com>
 <20250730062142.1665980-1-frolov@swemel.ru>
In-Reply-To: <20250730062142.1665980-1-frolov@swemel.ru>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 30 Jul 2025 01:06:09 -0700
X-Gm-Features: Ac12FXxoVh5UEKZxDQvSqJLK2wivtcvq3KUxF8Hm1wf_2Clnv_AROJjVkRXYzsk
Message-ID: <CAMo8BfKtZPqP0VjNQJmKD7e9J-ZvscFM0ws_GMX3vEbt_B7=gQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/xtensa: Replace malloc() with g_strdup_printf()
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.244,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 29, 2025 at 11:22=E2=80=AFPM Dmitry Frolov <frolov@swemel.ru> w=
rote:
>
> malloc() return value is used without a check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> v2: Also replaced strdup() with g_strdup()
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  target/xtensa/translate.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

