Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD5C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCI1m-0001VI-I6; Tue, 06 May 2025 09:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCI1b-0001IR-HS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:08:00 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCI1Z-00057c-Ap
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:07:55 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e755cd8c333so4324211276.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536872; x=1747141672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9lahmpkY2o0aOdjXCYPpJPe+QbiQQIocXSQ2WqFHww=;
 b=r5zgtg8RBmRS60W0w/c4INzZR29Wo6KaQ/qLWUAvYvw3AzKpeGUzXzSx1ncAOqMJM9
 w3h0YzX0JRbfyCX40f8/f2fRE6nlJZ+gVDYEHF6grNr7XhAywV4kOoFR0nzTKnBQJegh
 ELjo8KoR86L17YwUujQ+PzQZalDsIEUfUWmYUavhqsacyH8BflsvGYlaF+fiDjR1XpL1
 HPYJVe0fWGCroHLywtMwSOFkTYod8tLowK96U6xBbyxjpQt1K9QIbYzuxtFr9tMgKo8D
 nQJPGwBLEAr5+4hY9bhWQB/qPWy01ggUEk6PNRK20X4FrscRK7FIN99cpFo7/NYfO8m0
 FdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536872; x=1747141672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9lahmpkY2o0aOdjXCYPpJPe+QbiQQIocXSQ2WqFHww=;
 b=UgYpGd+XqiCAxTtFBeEuGOuqFjKJoPJQesIBB8eldGENZptHRsCQdj/k1dY/gjEg37
 6X5UFYlGpJCGLEjQQxOVEQ1fdl2P4sMHgTKNqHlnuKjaLcU5d81FZxQIR1K1GPqBQ7eN
 lVuBTZVz8kc/IGITWH753a1fasm0pBsiQ5EOFy7HnodRLYijnZq3ePPEfT9XnaIcT57U
 IGnfZbsbVZG4Q+YPN0di7MDX8BhZsLncbLcvCHbNwTRVLPtZ8s7miA3RMpJtzzayLCJL
 P6Um1/0s6iOQ+xALBXy4jw8zu6QUhv8K7h7uVpQG0vrFF5tUgP6zu8Ad1mvq+CSeO20P
 nCrw==
X-Gm-Message-State: AOJu0YxCDGz8FvGUgtfNKS7gSOHFg988q5EzEx9ydda/303mYEn7YBjD
 ci1eNYuhD37RRuSdhxcR1riAWglACj4nk1hYzvhkIwusFv7jj3X/kFvOs/g670mREdpo50SZd1x
 tVOEpr3Gi4oN7mQSjaIX3A7jN5tSUAhgPaVBz5KvTBq+eQJaI
X-Gm-Gg: ASbGncuM09LwLAIU3eU0qwLk8JPUJIvP2B9LvK764TPUlRzfGmgAkjVJYzP/xz5SryJ
 7WLlg/NIWY5yluQ9YynEa60zysWTP4KfI8pWFP4As+agHV6qBqnT4lHcIkjSdeTYZjFlNMjTqf3
 0q3lK2PnpVEZtuNovMZD7XyxU=
X-Google-Smtp-Source: AGHT+IFVsgwsuriTMKXi/VyIDo1GLBJx2WaoT3xSMirttOm6Q8XPJamjlOZzKL7lZ1fQ7atWDuFkeJQpbev1gDu4F8A=
X-Received: by 2002:a05:6902:e03:b0:e6d:f6f8:69db with SMTP id
 3f1490d57ef6-e75bf7c1d43mr4105189276.32.1746536871567; Tue, 06 May 2025
 06:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250429153907.31866-1-philmd@linaro.org>
In-Reply-To: <20250429153907.31866-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 14:07:40 +0100
X-Gm-Features: ATxdqUHnkt3NKEDwl6us9aMvgMjwV5PdtA2-DRPH5vIBSHGHSg-U2zWHKPMJbJM
Message-ID: <CAFEAcA8gaGCScMMzee-b_NabLZ9MARxcPuCF13hdKvyrDRkpHQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/arm: Remove deprecated virt-3.0 up to virt-4.0
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Tue, 29 Apr 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The versioned 'virt' machines up to 4.0 been marked as deprecated
> two releases ago, and are older than 6 years, so according to our
> support policy we can remove them.
>
> Based-on: <20250116145944.38028-1-philmd@linaro.org>
>           "hw/arm: Remove virt-2.6 up to virt-2.12 machines"
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/arm/virt: Update comment about Multiprocessor Affinity Register
>   hw/arm/virt: Remove deprecated virt-3.0 machine
>   hw/arm/virt: Remove deprecated virt-3.1 machine
>   hw/arm/virt: Remove deprecated virt-4.0 machine
>



Applied to target-arm.next, thanks.

-- PMM

