Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444B2C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCAS-0001fn-OO; Thu, 07 Mar 2024 06:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riCAQ-0001fX-BC
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:44:07 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riCAN-00066S-QX
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:44:05 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso911401a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709811840; x=1710416640; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+67t/DIhUi+iRSAoclJqpzn9k0fdVD2GemfHHmT5aE=;
 b=bplIbq0IyhmbKxDVUYtpjipmhPqfDM5qXJukWJA3cUzpZf9OPa0qa4I62ub1TSmlWo
 jxIE3+9wK2cm7XC4KiqASOhAh91cGRF37AfqRsUAOS1GunOxgGJRJsa31ThOxkyz5YG6
 QMXyJeEaCx0CBGOt53moM4KCd8ErNagY3m7LBAeK5ju4OnJfelN37WhqjtP1GAoNVYkY
 QacZ40kY6byt2Tji5/YGCJvScQ5sz643rySvpqtpJuf1KTY4RjmaQ1GantnZ/e4EOyZ0
 GgRd8L2ALI7setx1y+gQZgM6DljP/gw1Yw1c/TlSPqAikoRnhSR+nouHkyYX+joW29Kb
 BCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709811840; x=1710416640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+67t/DIhUi+iRSAoclJqpzn9k0fdVD2GemfHHmT5aE=;
 b=uTPHM+C5LYXNlt+1R9wb8ZS6LdGLKooOPVW177csuBn2qfAiJLK9TUY62Uy+GKN5cv
 vBNAUBUiDxudLSUJuQdXsf12Vu80Mfi+gW5SHjCnLXCPg6Me+OGY+uKkB3YnG1OGlGbC
 grDFUM7H+BAIT7/vSi2QLxB5qdBPE78avmH19IMVknvB9SRuTLbxXgQvZa+11zUEkq7N
 qsjVQvdE09pprpLVncNNygjvlzfsI33oqk6q6Q6+pdd/0BJtna8Jc8JdBP+0OQEuYIKP
 iQJdnybcZX/wLibKhUeN3+5/IPh+TERlg5X4n/Tg+Y1QnBFUQXTMn9a9r5lh9zDzRPbB
 Dk/A==
X-Gm-Message-State: AOJu0Yzd9eMo4qpYopImcHUwUbI1vuof7Hz3vvm7Ex1tul1oK2Xgk/8A
 8t8d08LzusYnQCe7E6PTxRrm4WaoidbB7O+4siQZt7Y2ZWLv4kNMOKgM/lNtgZyjaDbsi2LsOvM
 vrLa2ISCdUvn5HxvhwRD2QVqvVKok5kvSpQcsjEwrbXDGsT5U
X-Google-Smtp-Source: AGHT+IFzHvHnPYnogIF11sqWv7GeYN9tywOXH4MZaX3ouJMwt7hzNVGMc2J555LcrId4B2Wr+Vql4xA78ECUV8vV134=
X-Received: by 2002:a50:8dc5:0:b0:566:ef9:30ce with SMTP id
 s5-20020a508dc5000000b005660ef930cemr12675688edh.3.1709811839904; Thu, 07 Mar
 2024 03:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 11:43:48 +0000
Message-ID: <CAFEAcA8=zAsex4948_WkYrdeszgxvrhB+bT=BT8MA=8+khn8Ow@mail.gmail.com>
Subject: Re: [PULL for 9.0 00/29] maintainer updates (tests, gdbstub, plugins)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 6 Mar 2024 at 14:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit db596ae19040574e41d086e78469014191d7d7=
fc:
>
>   Merge tag 'pull-target-arm-20240305' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-03-05 13:54:54 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-updates-060324=
-1
>
> for you to fetch changes up to db7e8b1f75662cf957f6bfad938ed112488518ed:
>
>   target/riscv: honour show_opcodes when disassembling (2024-03-06 12:35:=
51 +0000)
>
> ----------------------------------------------------------------
> maintainer updates (tests, gdbstub, plugins):
>
>   - expand QOS_PATH_MAX_ELEMENT_SIZE to avoid LTO issues
>   - support fork-follow-mode in gdbstub
>   - new thread-safe scoreboard API for TCG plugins
>   - suppress showing opcodes in plugin disassembly
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

