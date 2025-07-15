Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB444C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uba0z-0007Ec-IR; Tue, 15 Jul 2025 03:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uba0w-0007D4-VY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:23:47 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uba0u-0003dz-Qs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:23:46 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a16e5so9788099a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 00:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752564222; x=1753169022; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UN1P7wXWdQjECtU3dVq1DC7zxXQJBQQB9IdVTomSwR4=;
 b=nQQY70zngZcrGp8TEeNiEwVaB4ASeAa1xBmWMpDBMYDP8DD7uaSPKjlQySMRQBjVZ0
 d1D6cwJPD/YSAGKr265suyk5KCT3a6uIbvg/fLZ0+b+H/LQUaE7lWror+j/sdmOItVlJ
 NutWqGu+Xim9RjTLoAZmJbu7cQtt1nEHSLs0QDbXtgi7PMstaid6B/8tOde2yUhkifG+
 /QAa3Sx2kmygbWaaFjrYKcSCqPh4ZrQpsoErocNkfDEcH51xMbRn6rrpL68nm7IFqQW6
 GBZEA6dCwJSaj7XTCMHc4aO61KXPeldmsv0iJsue9LrZBPwTs2J7ZglBrRpsfDHXaPqX
 n9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752564222; x=1753169022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UN1P7wXWdQjECtU3dVq1DC7zxXQJBQQB9IdVTomSwR4=;
 b=qRokldf0+udr3mDFenca1RKT8BFO1dPo/5Syqfmb6mQvYg2M0K08FrkU3WaP4vuXGS
 0jzG0D+lOkwOmE4492xt8pXtyN5HINCc767qv1yK0ahZYkBaYNDSNuc36KRfBsJSRhfg
 qGbJ0et8PrDU8RUONKou/5D7K/Q2Xph4zeRPIdCNcrZZcC2cgwCNEwkQ4grf8oHC+Fns
 DQ9oL0E0dJ2iOFYOzt8qzFPMxsz2yQmrefa2Z3mM8C04IUAfk6KP+AZjUuz8+HfbtTQV
 0vaG2Tni8BiwFFajzJ6pJovks5IR7yObkEgdqB6HdQfRyqkW4XWp5Th32zLQCJFFe0BT
 1pQg==
X-Gm-Message-State: AOJu0YzyPO7/zVLzW+5ZsPvP6KFK7rQzRYRNHliCr/cMSqb6Ug7Q162J
 Wm8RECA3INRHDqCqX6qgkpBM6TwBm5DWjBabhpQDi3MSt/gmv5MAD6GbYocxnNSrAyYeGgwleXy
 WpxJ365/FjxTko6HphTtKhkO3IRXGls7xY60O0D4Ftw==
X-Gm-Gg: ASbGncvgq8Jg06N3mGwpmiRstIjy8/6kQ1KYatogMX5bl3N8g4X5vj5QqRveOCMfUCQ
 V2bkz1GiisGWlS0syVcuj3d4dbd5OjylEfzvXJoa/1YwtKMxQUI7C9Vivbh6Q/Z4knBcAK2NaFI
 ZMxkwblSCKX1ZHbO6YMhhoyHT/8QPl97rv+lsqZvNtDtjXAcxiKJS9qWWnImVQZjwVF9IW7hzu+
 Df/5Qk=
X-Google-Smtp-Source: AGHT+IFkPbE5xNZZG95Q3SKrElAfzAAmTR+dvzwbAhFfwYxu8ShPJbhR9Ta2rRniMI3YiOH4ryrufuC1sTrn78+ICao=
X-Received: by 2002:a05:6402:5255:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-611e848f84dmr13955242a12.16.1752564221512; Tue, 15 Jul 2025
 00:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
In-Reply-To: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 10:23:15 +0300
X-Gm-Features: Ac12FXyusC6k6XN8M6XIpB9GBXO_0cqLsHdz3RTT_XV6LIzW9TETpwx124NjMFU
Message-ID: <CAAjaMXZ069X5b-1VF0ZA1+NWBoHRdrBZmimSZADsrY4A7k+P_A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bindings: allow any number of params
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, Jul 15, 2025 at 9:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> We are going to be adding more parameters, and this makes
> rust unhappy:
>     Functions with lots of parameters are considered bad style and reduce
>     readability (=E2=80=9Cwhat does the 5th parameter mean?=E2=80=9D). Co=
nsider grouping
>     some parameters into a new type.
>
> Specifically:
>
> error: this function has too many arguments (8/7)
>     --> /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-api-tests.p/=
structured/bindings.inc.rs:3840:5
>      |
> 3840 | /     pub fn new_bitfield_1(
> 3841 | |         secure: std::os::raw::c_uint,
> 3842 | |         space: std::os::raw::c_uint,
> 3843 | |         user: std::os::raw::c_uint,
> ...    |
> 3848 | |         address_type: std::os::raw::c_uint,
> 3849 | |     ) -> __BindgenBitfieldUnit<[u8; 4usize]> {
>      | |____________________________________________^
>      |
>      =3D help: for further information visit https://rust-lang.github.io/=
rust-clippy/master/index.html#too_many_arguments
>      =3D note: `-D clippy::too-many-arguments` implied by `-D warnings`
>      =3D help: to override `-D warnings` add `#[allow(clippy::too_many_ar=
guments)]`
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.r=
s
> index 057de4b646..c4f1f755ce 100644
> --- a/rust/qemu-api/src/bindings.rs
> +++ b/rust/qemu-api/src/bindings.rs
> @@ -13,7 +13,8 @@
>      clippy::missing_const_for_fn,
>      clippy::ptr_offset_with_cast,
>      clippy::useless_transmute,
> -    clippy::missing_safety_doc
> +    clippy::missing_safety_doc,
> +    clippy::too_many_arguments
>  )]
>
>  //! `bindgen`-generated declarations.
> --
> MST
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

