Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A79C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsES-0001qx-6h; Mon, 05 May 2025 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBsEQ-0001pt-1U
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:35:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBsEL-0002oW-Qa
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:35:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso9603275a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437719; x=1747042519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyMWrC5qS38VUa0+bmY23Us24bG1Dv5J8ZuqIqrJ9/8=;
 b=R7M4acfmoBcR+unm7aK2bPpmGG3zcZNynZniRSk715T0/c99HwTQZcAhXVfRTs6vF9
 skomzQAvryv7ijofrqBJF3TfKqGEME8Tmivyny3utc5bMQoHDrSbNZug+WKViATiWDE3
 5Hh5WiPiqlIkbS+daj3qFY4mD4yL0xSwLLXWNK++U8ZseJSM+m+BPs4OO3VjJWqg2hoa
 KNBPLRp7l8TyROAaK0LuRw+sNOLpYAhwZGshSkEVbBcBgHKs7HEcK/93WijQrj73uXnO
 cYbRCrQHEaY9xXO0AJG4ruX0fuC7ZldGCSS60WV5S2bGM02pV+oTsujQ0/FWxXJWo0qi
 XpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437719; x=1747042519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyMWrC5qS38VUa0+bmY23Us24bG1Dv5J8ZuqIqrJ9/8=;
 b=v33PoeICDHX5juDX35XTQS6Z0U0PBCxefSdm7nmhGnsQ/q//fcShJHGcWTBLJJKIHn
 fWcRFJ0kY/w6O32VA4kXbkp9lNlfOwtI7WWfLqUFvYJYhilQrcilfu4cPgHrF6rO82av
 FEPpC8I7jFg6Ko8peSCXE7oYmeAzAfrs7e3lEBm3UKHt9LoSEHjiNnvwuz+MUqYCSuhI
 x+lRpyRETXhK4cGgbpgsOuV8hb07y98g/tO/gWVEge0H0Dzp/ia8UmN3elGmCWRvCesG
 LKQR652Kf1sMvIGKU90ztccUuZPQkDLpnDMNLccYQ7FG5+imOyvAoeWu0y/nRS1HkBI/
 3Q2Q==
X-Gm-Message-State: AOJu0Yxr9qnb9ypSrK8USXAC0rSSAYQc8MK095qd8N1S7dDVTbBJG+d6
 K4rkYJYHF6a+bftxWMBIw66khHbCvIaznIHIVG+FueaubFi2XAkDXGixGQ8Xb3bpXZxrcnVb3nv
 +GoCkbBIXz3T9dQlAV+ZWLsdVBb/VSrxbDWCkSQuX/STxHKh3XYJIYA==
X-Gm-Gg: ASbGncs5OjPRUd3lD6gzuhJucR9f3bU14pb1+SLJYrrswJsfBr9FfcTzbPXSdwanM/N
 miWgpSAkDmvVpzRV3YcXaOsjlABTCP9KqwcLwGvC/orNXxxd0bwLJwAR6s6EtaPs2TO0tVTjQl6
 QY4Sqj7V4r4NjccOPrIkiN
X-Google-Smtp-Source: AGHT+IFpQVE4OZB8N9SCwjdpHK5PxLl/FS0YM9tFkww/4o4H2eHARn+wPesycDPzrEGra+/ddsHzuG+zMw+fa8hkmos=
X-Received: by 2002:a05:6402:40cb:b0:5e7:8e5e:4467 with SMTP id
 4fb4d7f45d1cf-5fa7327256amr11012816a12.3.1746437719616; Mon, 05 May 2025
 02:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-10-pbonzini@redhat.com>
In-Reply-To: <20250505090438.24992-10-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 5 May 2025 12:34:53 +0300
X-Gm-Features: ATxdqUGMrnMZvRn6Ty4DyAW3IuABvmsqenfr46G3u7Q57WSv2U7y5AWy7-yq9cw
Message-ID: <CAAjaMXZoOd+fyzfdhE5ewsn==e0+C2M8rCYQSvdeb5ysPA7b2w@mail.gmail.com>
Subject: Re: [PATCH 09/11] rust: remove offset_of replacement
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 5, 2025 at 12:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> ---
>  docs/devel/rust.rst                  |   6 -
>  rust/Cargo.lock                      |   1 -
>  rust/Cargo.toml                      |   2 +-
>  rust/hw/char/pl011/src/device.rs     |   4 +-
>  rust/hw/timer/hpet/src/hpet.rs       |   4 +-
>  rust/qemu-api-macros/src/lib.rs      |  29 +----
>  rust/qemu-api/Cargo.toml             |   3 -
>  rust/qemu-api/build.rs               |   7 --
>  rust/qemu-api/meson.build            |   4 -
>  rust/qemu-api/src/lib.rs             |   4 -
>  rust/qemu-api/src/offset_of.rs       | 168 ---------------------------
>  rust/qemu-api/src/qdev.rs            |   6 +-
>  rust/qemu-api/src/vmstate.rs         |  10 +-
>  rust/qemu-api/tests/tests.rs         |   2 -
>  rust/qemu-api/tests/vmstate_tests.rs |   5 +-
>  15 files changed, 16 insertions(+), 239 deletions(-)
>  delete mode 100644 rust/qemu-api/src/offset_of.rs
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

