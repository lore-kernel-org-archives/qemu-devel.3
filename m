Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C02C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 10:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZRkh-0003UJ-O0; Wed, 09 Jul 2025 06:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZRkf-0003Ni-Fc; Wed, 09 Jul 2025 06:10:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZRkd-0002oy-4U; Wed, 09 Jul 2025 06:10:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453647147c6so50868875e9.2; 
 Wed, 09 Jul 2025 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752055804; x=1752660604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3JR7wZY1F3KxPkuQKBsORQAo/RXZVimMrLFlqEbXQc=;
 b=SO0Bz1ctBcRCJSBZzbd576M8wHHBdiZPjwSWdYPWGnFztKt02qLHbI1QMNzwJgsQd4
 07or7zHgYnplyDAIl04ODfKkKys9pIEqEYVwNYV3XoX6yV+qVOtg2HfBfIjaoSvTuHa5
 u134av+LjbNfKZGZAuG6dOhQhhSptEV1I1GGSSuMqaQAM2bW7Z9Y3aGETBiLXcJ2blcI
 MoMRiJFuKo5s6fIppJNJXFVQp8/k4tUTAZ+1M3WoLBxJXWMSdl3/o2vL+jY0F117hS76
 h943wDePBA4tu+dsZeR8ltkHvE7t+YGylUISf0X9Hf2f+7mJjwcE0cgkii0zH76Ks5Jh
 AEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752055804; x=1752660604;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3JR7wZY1F3KxPkuQKBsORQAo/RXZVimMrLFlqEbXQc=;
 b=sV/5K/Edw0/avg1vOG+qZdngFg0275Jt7qLHSXuffN4Cj5Q+/Um3B3tM1+/53xJePD
 T7klasLRV8rn2IfDUUSt9iQvcUfzxJAlO6MEK4/N/aZ5097s2q6RL0rGHtsBJXL/l0v/
 cxCBdSnTM6mTspRxaqYBiKVlaqyuefkszeYuVNuNKRGylnE8VDKI1zYTWQJ0mLeasYrv
 CjfMe+ByFFVfHuGxz9Y0tpPEx4OmETa7lSu9lbwpyDAUOKtRmC3PwE9wAEZ4N2tizLYN
 gEDprpv7JW4sNQLialmp6CTrbchhs9Zu5Axs3KcwQWMIHqM6GdBAIKi5vlHxJiROmlxj
 9B3A==
X-Gm-Message-State: AOJu0YxgOfr9e4D9+VSU5PyApncOJ3Ec39n93kVTc59obK+9Q2c+tYwu
 crOKFTvlepMaRJTnJaIj0krtYc7GWypJWDIsLtvM7TvOamD6A1XxRRuEnG4zwA==
X-Gm-Gg: ASbGnctkfU3B6D3xp6HufhduPnHs42hUfBt58kzt1G2xrsOSRYFoZ0VP6R7QAX215iF
 gZZFidRPqt4FG5X0HD+hQLqzDOnp/SQG7ZAm7zDIu+zGYemJc4e1jUtzRfCOwE7h3dph/kbZgiF
 a9IKrZdE1aAh3MFpOoaSm/dhlwj3LZUN0pPRwUUaYlgOB2Yzi+7SFRWjfEpvuTXinN8ofWyi3NT
 inKHSAQkYG6NTKRQ//s47VEfZpLOW4z01ht/DdEAtK0IaeoCN+TuFH5PvkGfjUItD8J9VE7MvmI
 pAwhGZoa7EKOA6kZtxCJm8Vn3ilrrTDwoyMgaCe3+jlFl5qRzzJRBWO/hQ==
X-Google-Smtp-Source: AGHT+IEyOWc/AC5g2a7zcvhAB+tC5c4sfFf/gJFJkC+Q4r7upoFpC/0d+2nlPCXEvLLHeFw3Ep/o3g==
X-Received: by 2002:a05:600c:3f0a:b0:450:b240:aaab with SMTP id
 5b1f17b1804b1-454d5318572mr17831145e9.8.1752055804267; 
 Wed, 09 Jul 2025 03:10:04 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5133183sm17724495e9.40.2025.07.09.03.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 03:10:03 -0700 (PDT)
Date: Wed, 09 Jul 2025 10:06:22 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] rust/bindings: allow unnecessary_transmutes (1.88)
In-Reply-To: <20250703-rust_bindings_allow_unnecessary_transmutes-v1-1-692ca210d331@linaro.org>
References: <20250703-rust_bindings_allow_unnecessary_transmutes-v1-1-692ca210d331@linaro.org>
Message-ID: <BB0E766D-CB22-4155-AC0D-07A7566164A2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 3=2E Juli 2025 14:20:22 UTC schrieb Manos Pitsidianakis <manos=2Epitsid=
ianakis@linaro=2Eorg>:
>This is a new lint introduced in Rust 1=2E88=2E It does not affect
>compilation when using a previous version or our MSRV, 1=2E77=2E But with
>1=2E88 compilation fails because we deny all warnings:
>
>  error: unnecessary transmute
>     --> rust/qemu-api/libqemu_api=2Erlib=2Ep/structured/bindings=2Einc=
=2Ers:729:18
>      |
>  729 |         unsafe { ::std::mem::transmute(self=2E_bitfield_1=2Eget(0=
usize, 24u8) as u32) }
>      |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^ help: replace this with: `u32::cast_signed(self=2E_bitfiel=
d_1=2Eget(0usize, 24u8) as u32)`
>      |
>      =3D note: `-D unnecessary-transmutes` implied by `-D warnings`
>      =3D help: to override `-D warnings` add `#[allow(unnecessary_transm=
utes)]`
>
>Allow this lint, which even though it does not exist in previous
>versions, it works because we allow for `unknown_lints` in
>rust/Cargo=2Etoml=2E
>
>Signed-off-by: Manos Pitsidianakis <manos=2Epitsidianakis@linaro=2Eorg>
>---
> rust/qemu-api/src/bindings=2Ers | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/rust/qemu-api/src/bindings=2Ers b/rust/qemu-api/src/bindings=
=2Ers
>index 057de4b6467c50ecc5acb6b51e6fde87ef5fa67f=2E=2E3cdad0f0ec640880bc74a=
942bbcb303be4cda775 100644
>--- a/rust/qemu-api/src/bindings=2Ers
>+++ b/rust/qemu-api/src/bindings=2Ers
>@@ -6,6 +6,7 @@
>     non_camel_case_types,
>     non_snake_case,
>     non_upper_case_globals,
>+    unnecessary_transmutes,
>     unsafe_op_in_unsafe_fn,
>     clippy::pedantic,
>     clippy::restriction,
>
>---
>base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
>change-id: 20250703-rust_bindings_allow_unnecessary_transmutes-d614db4517=
a4
>
>--
>=CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>

FWIW:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

