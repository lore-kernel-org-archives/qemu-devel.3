Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183D1C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkkDd-0003n7-BM; Thu, 14 Mar 2024 08:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rkkDZ-0003mR-HJ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:29:54 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rkkDY-0002R2-2Y
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:29:53 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a466a27d30aso115261266b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710419390; x=1711024190; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjXbgRvqLh+Z2qvq7iRFjdTU/gRC9bFpHEUW+cUPfG0=;
 b=GfMF8MkRfu5/ftZROzF7s5erJ3YyISXAUcJCmeJA7Hl9ZZeGfXG5yw0c8u2hMjRdhK
 y5GgRsNmyTygJIHXb3XNV0rzYE2eeSV1wUdNLrvivTxxwsvpOBNyF1EtkQVVxQdlWRQD
 Hoe4cLHe2uZRZrLWvmMtRRH0wBv7/qrNCuD9JlHBUc5o4I9QpLTg9ylKOQsoD0cH0SM1
 +/BJevegr1F0Yn22nRoHwWzPdcyn/SzdxoTvBJjKIELtTdnuE2EjntPqAu9X/NfWEZcg
 BMEqReNoPpXhGHjo+m59wguju/RwxiXK1AWWgvDucIxzf22zBWTtmZhyw6oE8qY+SqIY
 ri6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710419390; x=1711024190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjXbgRvqLh+Z2qvq7iRFjdTU/gRC9bFpHEUW+cUPfG0=;
 b=ZCv3YKX5b7XWT4pCnDWBzP/cVGfGQguuFIjrUVbmV8hyli84BFP1Tu9uDxSVuRjSw3
 bhCoQhRB2zQekMr8Z09eR1gRkLuaPDzvPU9zqVdNSdFt4utlO2RJR4SaEtsU97IJ2tMB
 7HOjj+shtf6yxY5C2zcn3Eza5wdg7AJ2ZexBewyPWHkJyYtF2fFkxB0Dz0Inu99MIGMC
 oCTvVkINmODdZ7vdULqDBJlnu+cB4hGgC/xkz1I3YAT2ZZcE7zOgQHsDJB1+HWOrTisk
 xw4Iqy0LU/UBFGWMKwEjWTHjoKuUdEW2wpK+bYVoKsJ7UtnwZMGoWinnoBKtJzT9SZiU
 su9A==
X-Gm-Message-State: AOJu0YytRz3vbbTjSn5vwd6+jXbQDvKSZxWdVTFHHCmwu5/EIU1txlU5
 2mZiS98AQxYAZE1uqFJ8yb9CIjRcQh6tn+byaAn2Mqc08HrgTX9gosFU2QNfQklAvxkZkbZTLQ/
 lTe08NpDeym+//LV1AT85UJuBZ4Q95dvrMiR7Jw==
X-Google-Smtp-Source: AGHT+IGWZiZ6kVlMU4/mBnGLxx5CYKbo4K4D45pvBI4Ebhnt8OVUKQXfdronNn/hFpSD5sCdx4ees6fuq6e8ehkbbLk=
X-Received: by 2002:a17:906:24cc:b0:a45:ab16:deea with SMTP id
 f12-20020a17090624cc00b00a45ab16deeamr961282ejb.55.1710419389851; Thu, 14 Mar
 2024 05:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240312170011.1688444-1-alex.bennee@linaro.org>
In-Reply-To: <20240312170011.1688444-1-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 14 Mar 2024 14:29:34 +0200
Message-ID: <CAAjaMXaVG818tqGU20gsbpZ8CpAqhaXPAdnL5+Ph==c6TiWDbw@mail.gmail.com>
Subject: Re: [PATCH v2] gitlab: aggressively avoid extra GIT data
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 12 Mar 2024 at 19:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This avoids fetching blobs and tree references for branches we are not
> going to worry about. Also skip tag references which are similarly not
> useful and keep the default --prune. This keeps the .git data to
> around 100M rather than the ~400M even a shallow clone takes.
>
> So we can check the savings we also run a quick du while setting up
> the build.
>
> We also have to have special settings of GIT_FETCH_EXTRA_FLAGS for the
> Windows build, the migration legacy test and the custom runners. In
> the case of the custom runners we also move the free floating variable
> to the runner template.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - make custom runners follow the legacy options
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

