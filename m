Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E656C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seC3S-0000i3-0k; Wed, 14 Aug 2024 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seC3O-0000gf-Pg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:20:34 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seC3M-0005gL-VN
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:20:34 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so7800983a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723634430; x=1724239230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rPHo4qIf+PODNS2953SxUj/B6hWkDwsprlzBWxKDNY0=;
 b=ZYP9ny0nVM7mOxGbajalnH/Px0+xVLvoTUi6rEuOvWMzMiQLyHxuET7SLXSJ0MmybS
 1OokkQVnr+zkGMPAytqKGcxn4T0nZKED5zx68CGE1c06aMv8WAe5RRMosv/Fe07aRNOj
 xEzLjY1YOiqN9vpOnM8LaG/8vrEkj5hr51QgM3CgpbAt953QC6mjgYo/5oZL2p0wmHCJ
 CMjrfymraScZQxuxk3E97q6gfjnYSTko6hLAXRCjzFRfgundhkawE0vseA8iiecn1NzG
 NKG3+78x6x7oIw5AX5UXsAaNU1J1Mnz0GYUt0L/G7LHbKVrywtlCek08bOxz9dlMnuGa
 YXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723634430; x=1724239230;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPHo4qIf+PODNS2953SxUj/B6hWkDwsprlzBWxKDNY0=;
 b=J915y5fq+Tt9V8pzYdeo8ZgfsENYYtQCL6PQMrmNztOjJELevn4Nv2e2oLoRMwBAxV
 q9RXYFUJspvTOfZPaCRLf1qQ1i6LGcic9yBO5joesshQuYXbSfEC8A9oo5m3iQMzg+EK
 8XB0ALKnpXHxGBL94y3fVPE7nBK0xpjFpmOUReLg3D/8Iv+aqaGFTg5KWaZ3dsUsd3ss
 K6uja6F4xjkfOtFMJD3cmgSNmvHDFJ4SjPryk5LNCQ8SJh95pUHmI6UdMk8DVwFKyAxc
 YbNwNE0JDLvszypJXPiCzAJ+spIcg3ikzBeYK0JsTb7UPsioPSoSJp/GFX/S7E5Xodgo
 EH0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJHBTHAUCW3Evir/bFGJNi2yne1oFnB1+kxD7xFwzSE8pcEeCSD/9q519qwRS30+UF19FQ7KWdinxIBUn5vUBe398itGM=
X-Gm-Message-State: AOJu0YyKGGktBVIj6+93Ciu+CP+f5b/sm6sLaSLZFIHtvPnN5s+9e2iZ
 QA/nTgescdvGiVNAsfeANuf7xIe/6nI+g5kmN+5tK11IiOe2hduZpPmFNmeS1ag=
X-Google-Smtp-Source: AGHT+IEqb64zeFn8ESlig7HtnrVL5Wi3S5jZqdXNnsSAHIQtaYEWs2rq1eXGjwd0BBJ+0FJOxgAl0A==
X-Received: by 2002:a17:907:c88a:b0:a7a:a2e3:3737 with SMTP id
 a640c23a62f3a-a8366d42d8amr160215666b.28.1723634429884; 
 Wed, 14 Aug 2024 04:20:29 -0700 (PDT)
Received: from meli-email.org (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f48ecasm160914266b.43.2024.08.14.04.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 04:20:29 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:19:19 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Junjie Mao <junjie.mao@intel.com>, pbonzini@redhat.com
Cc: alex.bennee@linaro.org, armbru@redhat.com, berrange@redhat.com,
 gustavo.romero@linaro.org, mads@ynddal.dk, marcandre.lureau@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org, richard.henderson@linaro.org, rowan.hart@intel.com,
 stefanha@redhat.com, thuth@redhat.com, zhao1.liu@intel.com
Subject: Re: [RFC PATCH 0/2] meson: Specify Rust edition by rust_std=20XX
User-Agent: meli 0.8.7
References: <20240814090820.1251026-1-junjie.mao@intel.com>
In-Reply-To: <20240814090820.1251026-1-junjie.mao@intel.com>
Message-ID: <i7gu3.q2sbbwkiiqsk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 14 Aug 2024 12:08, Junjie Mao <junjie.mao@intel.com> wrote:
>The official way to specify Rust edition in meson is the rust_std build option
>[1]. It is used for generating --edition rustc options and filling
>rust-project.json which provides project layout information to
>rust-analyzer. Specifying Rust edition by rust_args instead causes meson to
>generate "edition": "--edition" in rust-project.json, which is invalid.
>
>Replace "--edition" rust_args with overriding of rust_std and build.rust_std to
>fix the generated rust-project.json.
>
>The rust_std option is part of the build environment and has two forms: rust_std
>for the host machine and build.rust_std for the build machine. Specify both in
>meson.build for completeness.
>
>The default_options argument of project() is not used because it does not work
>for rust_std in subprojects in meson 1.5.1.
>
>This series is based on Paolo's refinement [2] to Manos's rust-pl011-rfc-v6
>[3]. Feel free to squash these changes into that series.
>
>[1] https://github.com/mesonbuild/meson/pull/7934
>[2] https://gitlab.com/bonzini/qemu/-/tree/rust-for-manos
>[3] https://lore.kernel.org/qemu-devel/rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org
>
>Junjie Mao (2):
>  meson: subprojects: Specify Rust edition by rust_std=20XX
>  rust: Specify Rust edition by rust_std=20XX
>
> rust/hw/char/pl011/meson.build                                | 4 +---
> rust/meson.build                                              | 4 +---
> rust/qemu-api/meson.build                                     | 2 +-
> subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 4 +---
> subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
> subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
> subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
> subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
> .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
> subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
> subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
> subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
> subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 4 +---
> 13 files changed, 13 insertions(+), 21 deletions(-)
>
>--
>2.30.2

Thank you Junjie, I have applied the changes to the next version I will 
be posting. Cheers!

Manos

