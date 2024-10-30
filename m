Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA2ED6B6B3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BwK-0003q6-RO; Wed, 30 Oct 2024 12:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6BwJ-0003m0-Nk
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6BwF-0007Q4-Mk
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730307174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgkuY4T5m99477EkANXffUSLfPH6t2XcxKOdY6QmfVc=;
 b=LCPUPVMAZRGgpURX41VvVysUtK8LkuckaC1MnfPmCTfmB0mt2AWBAuY5zdfEu6GvAPfF9J
 TC4ODLwmOxunNF2IQJoPG0WtQic6gbzZhqiVIt1DEm1WJGfMncF/xCY6lZ8XciV/QwefkT
 1jG8YfawpC1eE4Epxuee0RSbcDT5NgQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511--_qCmQc4Nb6QV87Pti_Alw-1; Wed, 30 Oct 2024 12:52:53 -0400
X-MC-Unique: -_qCmQc4Nb6QV87Pti_Alw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4922d8c7so49104f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730307171; x=1730911971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgkuY4T5m99477EkANXffUSLfPH6t2XcxKOdY6QmfVc=;
 b=NuhRdPyjYqW0oPrsdxA6m+rAcRgn8//wLvUzI7xec6r0zQtDrVT/7kWe44OfnK2QH2
 E4KuMSLYta59ZqCFYrlqm1Hi2jTgflVR72/5lpWSxp+zY6iLeDuiOTVY2ccuQGUKvpiv
 qrQfVDcFx+DeQCkwA7pU1yq3TIlKiulqi1Ri3JuruyXJrR0NEMtRD/nyx2KMpFSc5sRS
 DrSG7Zi/6h0nmrTAxxmnMPWeMgkQF4lWtZLgdPIy05NwdMlv97/+FHNs6Ek+ivMu9NkY
 1NxEN6dVrPsUKp4zkOt61b0ULwFRzMqtNofy+jFw5vQft0WyVeoXPYRPVvDIzNtRU1+7
 I04g==
X-Gm-Message-State: AOJu0YzlzWMFJuzLIKhlSFxyjfBeOaBpdbRFihwycdaZPx5FVoLoVhW5
 dpEsIkqSa33AfCQ4ueuPMHfz+CyQSr70nY+Rkg6KoNb6t54fCx+kdgbJtDfc6fZoPqTXIaqBm+/
 4cCAGJpkz1Mr8NlkNv/ph65V6+vOn83evv0HpCwiDngqpDpz8X60VenLS4ymbFrc989S4GwzP69
 rSZvMrsphG9w01ciQo6lxntLEUDC0/TQvxWMPMLYUC
X-Received: by 2002:adf:e345:0:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-3806115937bmr11138918f8f.26.1730307170826; 
 Wed, 30 Oct 2024 09:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOq4L1KO/AMKJrkLIbj4t/K/KMoXk6tjLGH3pnHMyDAzB8BXEv5hfj/8aaUjiWthvvl5LOjGIRHzxa5gxY7vQ=
X-Received: by 2002:adf:e345:0:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-3806115937bmr11138905f8f.26.1730307170375; Wed, 30 Oct 2024
 09:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Oct 2024 17:52:38 +0100
Message-ID: <CABgObfaMXaEisB4S_8mQDMLYWHWqu=3A15Uk_egcw9+Gc6cqzw@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, 
 junjie.mao@hotmail.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Ping for missing reviews; particularly patches 11, 13 and 14.

    https://lore.kernel.org/qemu-devel/20241025160209.194307-12-pbonzini@re=
dhat.com/
    https://lore.kernel.org/qemu-devel/20241025160209.194307-14-pbonzini@re=
dhat.com/
    https://lore.kernel.org/qemu-devel/20241025160209.194307-15-pbonzini@re=
dhat.com/

As to patch 19, which is the ugly --generate-cstr workaround for
old bindgen, I've played a bit with refactoring the QOM bindings and
adding a new trait even for types defined by C code.  Such approach
would make the workaround considerably less ugly, since you need
some kind of

pub impl ObjectType for bindings::DeviceState {
    type Class =3D bindings::DeviceClass;
    const TYPE_NAME: &CStr =3D bindings::TYPE_DEVICE;
}

anyway; then the only difference introduced by old bindgen would be

 pub impl ObjectType for bindings::DeviceState {
     type Class =3D bindings::DeviceClass;
-    const TYPE_NAME: &CStr =3D bindings::TYPE_DEVICE;
+    const TYPE_NAME: &CStr =3D
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE=
) };
 }

which is considerably better than having a random TYPE_DEVICE global
somewhere.

Paolo

On Fri, Oct 25, 2024 at 6:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Since Manos helpfully posted his vmstate patches, this series is all that
> is needed in order to enable Rust for at least the Debian, Fedora and
> Ubuntu jobs.  I took his patches and isolated them from the procedural
> macro experiment.
>
> There are quite a few changes from the previous posting:
>
> - new patches to bring pl011 mostly up to date with the C code (1-7)
>
> - remove unnecessary .gitattributes file (8)
>
> - apply rustfmt throughout
>
> - add "rust: create a cargo workspace" to ensure a single version of the
>   dependencies is used for all cargo commands (14, based on a suggestion =
by
>   Junjie)
>
> - add Junjie's syntax checks to the offset_of! macro.  I added a small
>   struct with a From<> implementation, to make compile errors even easier
>   to report (15).
>
> - add final patch to enable rust in the Debian and Ubuntu system build
>   jobs (23)
>
> Note that this requires "meson subprojects update --reset" in order to do
> an incremental build if you have already downloaded the Rust subprojects.
> While I have a solution for that (modeled after scripts/git-submodule.sh)=
,
> I first need to check with the Meson folks whether my script is using onl=
y
> stable interfaces.
>
> This series can be found at branch rust-next of my git repository
> (https://gitlab.com/bonzini/qemu.git), which also helps with the
> problems in applying patch 8.  Everything up to commit f6a46d2a4eb
> ("rust: do not use TYPE_CHARDEV unnecessarily", 2024-10-25) will be
> my next pull request, which I will send early next week (to give
> people some more days to complain).
>
> Paolo
>
> Supersedes: <20241022100956.196657-1-pbonzini@redhat.com>
>
> CI: https://gitlab.com/bonzini/qemu/-/pipelines/1512732399
>
>
> Manos Pitsidianakis (6):
>   rust: add definitions for vmstate
>   rust/pl011: add support for migration
>   rust/pl011: move CLK_NAME static to function scope
>   rust/pl011: add TYPE_PL011_LUMINARY device
>   rust/pl011: remove commented out C code
>   rust/pl011: Use correct masks for IBRD and FBRD
>
> Paolo Bonzini (17):
>   rust/pl011: fix default value for migrate-clock
>   rust: patch bilge-impl to allow compilation with 1.63.0
>   rust: fix cfgs of proc-macro2 for 1.63.0
>   rust: use std::os::raw instead of core::ffi
>   rust: introduce a c_str macro
>   rust: silence unknown warnings for the sake of old compilers
>   rust: synchronize dependencies between subprojects and Cargo.lock
>   rust: create a cargo workspace
>   rust: introduce alternative implementation of offset_of!
>   rust: do not use MaybeUninit::zeroed()
>   rust: clean up detection of the language
>   rust: allow version 1.63.0 of rustc
>   rust: do not use --generate-cstr
>   rust: allow older version of bindgen
>   rust: make rustfmt optional
>   dockerfiles: install bindgen from cargo on Ubuntu 22.04
>   ci: enable rust in the Debian and Ubuntu system build job
>
>  docs/about/build-platforms.rst                |  12 +
>  meson.build                                   | 102 +++--
>  .gitattributes                                |   2 +
>  .gitlab-ci.d/buildtest.yml                    |   6 +-
>  meson_options.txt                             |   2 +
>  rust/{hw/char/pl011 =3D> }/Cargo.lock           |   4 +
>  rust/Cargo.toml                               |   7 +
>  rust/hw/char/pl011/Cargo.toml                 |   3 -
>  rust/hw/char/pl011/src/device.rs              | 158 ++++++--
>  rust/hw/char/pl011/src/device_class.rs        |  71 +++-
>  rust/hw/char/pl011/src/lib.rs                 |   5 +-
>  rust/hw/char/pl011/src/memory_ops.rs          |  14 +-
>  rust/qemu-api-macros/Cargo.lock               |  47 ---
>  rust/qemu-api-macros/Cargo.toml               |   5 +-
>  rust/qemu-api-macros/src/lib.rs               |  81 +++-
>  rust/qemu-api/Cargo.lock                      |   7 -
>  rust/qemu-api/Cargo.toml                      |  10 +-
>  rust/qemu-api/build.rs                        |   9 +
>  rust/qemu-api/meson.build                     |  17 +-
>  rust/qemu-api/src/c_str.rs                    |  53 +++
>  rust/qemu-api/src/definitions.rs              |   2 +-
>  rust/qemu-api/src/device_class.rs             |  43 +--
>  rust/qemu-api/src/lib.rs                      |  19 +-
>  rust/qemu-api/src/offset_of.rs                | 161 ++++++++
>  rust/qemu-api/src/vmstate.rs                  | 358 ++++++++++++++++++
>  rust/qemu-api/src/zeroable.rs                 |  91 ++++-
>  rust/qemu-api/tests/tests.rs                  |  29 +-
>  scripts/meson-buildoptions.sh                 |   4 +
>  subprojects/bilge-impl-0.2-rs.wrap            |   1 +
>  .../packagefiles/bilge-impl-1.63.0.patch      |  45 +++
>  .../packagefiles/proc-macro2-1-rs/meson.build |   4 +-
>  subprojects/packagefiles/syn-2-rs/meson.build |   1 +
>  tests/docker/dockerfiles/ubuntu2204.docker    |   5 +
>  tests/lcitool/mappings.yml                    |   4 +
>  tests/lcitool/refresh                         |  11 +-
>  35 files changed, 1166 insertions(+), 227 deletions(-)
>  rename rust/{hw/char/pl011 =3D> }/Cargo.lock (98%)
>  create mode 100644 rust/Cargo.toml
>  delete mode 100644 rust/qemu-api-macros/Cargo.lock
>  delete mode 100644 rust/qemu-api/Cargo.lock
>  create mode 100644 rust/qemu-api/src/c_str.rs
>  create mode 100644 rust/qemu-api/src/offset_of.rs
>  create mode 100644 rust/qemu-api/src/vmstate.rs
>  create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
>
> --
> 2.47.0


