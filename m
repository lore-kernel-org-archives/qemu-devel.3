Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151CEC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSfA-0006Fm-4F; Mon, 14 Jul 2025 19:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubSde-0004bs-DB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:31:18 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubSdY-0001fi-CT
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:31:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-608acb0a27fso6718034a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752535866; x=1753140666; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+q6JDKW6ffOwKsdLKOn7mz7nOnnpKSBfqn0q4Cb+uI=;
 b=E/jzN32oajcypK+Kd0+X8yD2bS7C7iEDcxbpLpHeBLDG8IAjfS82AghuN6ZgP5VpBx
 gzS3rQVXRsDIzPgsa532r68GHnGGakpQ0JQOcoiInLhIvGO2VFkbKvQ0wKX4K6hfk9C5
 oOMOtYbkc3c8YJZLUN2j6Zcp3REMELKewrnZYXYw/aMLMqxP5JgbAm3PvUz/0xxrk0tI
 44iq9f/FahkOOlcqmjuS3QxseRJHYukCIlQotBk3UAxyHpNBD+gh+/t4AhRX80pCYcwt
 gr5KzBETwqsE6YubwKF45FdaVlvmoKvNQfhKKO3x60mneApecLuqBCIbsA+mbZlsfvCT
 PCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752535866; x=1753140666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+q6JDKW6ffOwKsdLKOn7mz7nOnnpKSBfqn0q4Cb+uI=;
 b=kc/Tz2CV46Q3egu1WfOoPU79OBkJpGwbyjKSPXGkKjwu2GVbX1JPeYGfgv0EyiFVB9
 FtmNt2daokb8sZxl4dP/nh3OiFtc+9VdUusPWlymiJd3mZ+N0kEw66w4xJ1ebwdLRCxN
 VfbQCex/BmJRYPX0OUE3w0laFU1AkdTk7EVCrn3QZOg2hvztrMOkaIEX7TTwlUwtABI9
 ipuMIn+HEg2FwSeEljH377NPJg4JMPcohVGN8v22VNlnVkdLgA7cEVFNYdqPkw17Wusq
 vGw5Oyam8zIa9jiX6yPCq6t54PMhx9LpLLVy7/KW10mvEkXxPjkWQ6YNVuICan6wHIn2
 w9Bg==
X-Gm-Message-State: AOJu0YzvQd6PXpdEUfxYtP2X4fig4ONr7FEWibHHoqz2x+mR/SVXPE8z
 G/O/CP5Yy22vcJBcZXO0j058UwZS5zgX/hKD+kaoLHVCugLhc6SjVrIcMWCwzo2c27T31yoIOHI
 HzNuFjke6XZ0zEhXuj7ZHfm3KOonsGjR6Hbcbt9Wt6A==
X-Gm-Gg: ASbGncsObREx34KfFr8FK+KpBqzx47oaEnEsbt+xIqCbjol5OgM0D7FasJ0KQoIAUMs
 oQrt8nuzsv54gNS4t0hXbNu8k9MDkZrtEorcawzQ1KL5VylU7F6Fw8dFdR3M9Auguw4XjFobKSA
 flDrBTFObBxOlKykg3rSYVELACtM2LxROTvfucuMXfBiQXw59HaCXXGVkFikzVPqtAXZqokQKkv
 wm9pVU=
X-Google-Smtp-Source: AGHT+IHcmk0rQdoqrVFraBYv8z31RPYVHHKuvgAH8P8RlwzX5g2sEwJcIdcx/psu7vAbzMnV+G76mAdoKFj8NB7fMts=
X-Received: by 2002:a05:6402:909:b0:609:9115:60f8 with SMTP id
 4fb4d7f45d1cf-611e847f9e0mr12086347a12.21.1752535866191; Mon, 14 Jul 2025
 16:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752534227.git.mst@redhat.com>
 <04130b3dc5af620213a90d300933517b39f43bba.1752534227.git.mst@redhat.com>
In-Reply-To: <04130b3dc5af620213a90d300933517b39f43bba.1752534227.git.mst@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 02:30:40 +0300
X-Gm-Features: Ac12FXwXkhQG4WaUD4BKsRX_QTxHaJLBMpYUF5zCdV8wz0-5eENAQ2dqUkSRLsU
Message-ID: <CAAjaMXb5khPeO5bXGZ_2EALVWRg3i+GPimJygrik83f12JvFjw@mail.gmail.com>
Subject: Re: [PULL 28/97] rust: bindings: allow any number of params
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, Jul 15, 2025 at 2:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
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
> I didn't want to disable this globally, so I just shut it off for this
> file.
>
> Message-Id: <a4c65fb2b735740bda2874c86de31d29a5ae24d2.1752530758.git.mst@=
redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.r=
s
> index 057de4b646..b4692f9b4b 100644
> --- a/rust/qemu-api/src/bindings.rs
> +++ b/rust/qemu-api/src/bindings.rs
> @@ -18,11 +18,15 @@
>
>  //! `bindgen`-generated declarations.
>
> -#[cfg(MESON)]
> -include!("bindings.inc.rs");
> +#[allow(clippy::too_many_arguments)]
> +mod gen {
> +    #[cfg(MESON)]
> +    include!("bindings.inc.rs");
>
> -#[cfg(not(MESON))]
> -include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
> +    #[cfg(not(MESON))]
> +    include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
> +}
> +pub use gen::*;
>
>  // SAFETY: these are implemented in C; the bindings need to assert that =
the
>  // BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
> --
> MST
>

Hi Michael,

This patch does not seem to have been reviewed.

The clippy allows are in the top of the file, not above the
`include!`. This should be a one line change and the `mod gen` wrap is
unnecessary.
--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

