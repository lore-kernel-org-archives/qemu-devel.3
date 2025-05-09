Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5E4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOTR-00084y-U5; Fri, 09 May 2025 10:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDOTQ-00084f-Pj
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDOTM-0005oG-Gy
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746799987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8IYM5UblGETXDqR5Q91AxvEzgYT52aLlAJqy1uz/lfg=;
 b=IvTtMfkwOPxHtdLg8WyKiYYYprQGUwBF/e0jsGF6A1BotgEipgWndcS0CnvoWHSNyRUG08
 Tz4VHXIUtXyWVuw7sMWYNvYgQoPpmZKvaXi6IO4zpFSHI+MGxjd+jcMIQyPxlG0bvqueAg
 9nd5KUXVUZo2q6xUub0uENDemV12rp8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-LfW6Ycn5N2G9OFgzFjXHAg-1; Fri,
 09 May 2025 10:13:05 -0400
X-MC-Unique: LfW6Ycn5N2G9OFgzFjXHAg-1
X-Mimecast-MFC-AGG-ID: LfW6Ycn5N2G9OFgzFjXHAg_1746799984
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 677691800873
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 14:13:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.167])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC85B19560B0; Fri,  9 May 2025 14:13:03 +0000 (UTC)
Date: Fri, 9 May 2025 10:13:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2, part1 00/15] Rust changes for 2025-05-06
Message-ID: <20250509141302.GA82958@fedora>
References: <20250508155439.512349-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VZ+uyQ7gTEqN7H30"
Content-Disposition: inline
In-Reply-To: <20250508155439.512349-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--VZ+uyQ7gTEqN7H30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 05:54:39PM +0200, Paolo Bonzini wrote:
> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2ea=
b8:
>=20
>   Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu in=
to staging (2025-05-05 11:26:59 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to 821ee1c31427a4e08af030469311c2d8ed96f1d1:
>=20
>   docs: build-system: fix typo (2025-05-06 16:02:04 +0200)
>=20
> ----------------------------------------------------------------
> * ci: enable RISC-V cross jobs
> * rust: bump minimum supported version to 1.77
> * rust: enable uninlined_format_args lint
> * initial Emscripten support
> * small fixes

Hi Paolo,
v1 is already merged. I'm not sure what the purpose of v2 is. It looks
like you dropped the wasm patches but the reason is unclear to me?

Thanks,
Stefan

>=20
> ----------------------------------------------------------------
> Paolo Bonzini (15):
>       lcitool: use newer Rust for Debian and Ubuntu
>       meson, cargo: require Rust 1.77.0
>       rust: use std::ffi instead of std::os::raw
>       rust: let bilge use "let ... else"
>       rust: qemu_api_macros: make pattern matching more readable and effi=
cient
>       rust: use MaybeUninit::zeroed() in const context
>       rust: qom: fix TODO about zeroability of classes
>       rust: enable clippy::ptr_cast_constness
>       rust: remove offset_of replacement
>       rust: replace c_str! with c"" literals
>       docs: rust: update for newer minimum supported version
>       target/i386/emulate: fix target_ulong format strings
>       rust: clippy: enable uninlined_format_args lint
>       ci: run RISC-V cross jobs by default
>       docs: build-system: fix typo
>=20
>  docs/about/build-platforms.rst                     |  11 +-
>  docs/devel/build-system.rst                        |   2 +-
>  docs/devel/rust.rst                                |  38 +----
>  meson.build                                        |   6 +-
>  target/i386/emulate/x86_decode.c                   |   2 +-
>  target/i386/emulate/x86_emu.c                      |   2 +-
>  .gitlab-ci.d/container-cross.yml                   |   3 -
>  .gitlab-ci.d/crossbuilds.yml                       |   5 -
>  rust/Cargo.lock                                    |   1 -
>  rust/Cargo.toml                                    |   7 +-
>  rust/clippy.toml                                   |   3 +-
>  rust/hw/char/pl011/src/device.rs                   |   4 +-
>  rust/hw/char/pl011/src/device_class.rs             |  13 +-
>  rust/hw/char/pl011/src/lib.rs                      |   6 +-
>  rust/hw/timer/hpet/src/fw_cfg.rs                   |   6 +-
>  rust/hw/timer/hpet/src/hpet.rs                     |  28 ++--
>  rust/hw/timer/hpet/src/lib.rs                      |   4 +-
>  rust/qemu-api-macros/src/lib.rs                    | 123 ++++++---------
>  rust/qemu-api/Cargo.toml                           |   3 -
>  rust/qemu-api/build.rs                             |  11 +-
>  rust/qemu-api/meson.build                          |   5 -
>  rust/qemu-api/src/c_str.rs                         |  61 --------
>  rust/qemu-api/src/cell.rs                          |   6 +-
>  rust/qemu-api/src/chardev.rs                       |   5 +-
>  rust/qemu-api/src/irq.rs                           |   6 +-
>  rust/qemu-api/src/lib.rs                           |   7 +-
>  rust/qemu-api/src/memory.rs                        |   3 +-
>  rust/qemu-api/src/offset_of.rs                     | 168 ---------------=
------
>  rust/qemu-api/src/qdev.rs                          |   9 +-
>  rust/qemu-api/src/qom.rs                           |  14 +-
>  rust/qemu-api/src/timer.rs                         |   4 +-
>  rust/qemu-api/src/vmstate.rs                       |  14 +-
>  rust/qemu-api/src/zeroable.rs                      | 106 +++----------
>  rust/qemu-api/tests/tests.rs                       |  11 +-
>  rust/qemu-api/tests/vmstate_tests.rs               |  27 ++--
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   2 +-
>  subprojects/bilge-impl-0.2-rs.wrap                 |   1 -
>  subprojects/packagefiles/bilge-impl-1.63.0.patch   |  45 ------
>  tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-i686-cross.docker  |   2 +-
>  .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
>  .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
>  .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian.docker             |   2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker         |   3 +-
>  tests/lcitool/mappings.yml                         |   5 +
>  tests/lcitool/refresh                              |   5 +-
>  51 files changed, 183 insertions(+), 622 deletions(-)
>  delete mode 100644 rust/qemu-api/src/c_str.rs
>  delete mode 100644 rust/qemu-api/src/offset_of.rs
>  delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
> --=20
> 2.49.0
>=20
>=20

--VZ+uyQ7gTEqN7H30
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgeDW4ACgkQnKSrs4Gr
c8gRhAgAjGWJimTNZ10io4e065mu8vzZcoTY3F/bY/ri1LejJW2HXDotQ4Z/PUgZ
rcaXzor3jScL1uVwkK5r5kHJDN7L4WOMqGkgB0Z60A/C19Tx5AZAFH98E8hCg3Ot
1LMvG5G0uSgYlrfpMZb0H7+4BvYj1NtL18Xur4SnzQZ12QL7CYKgkfksShdpG5su
Lgg/6oSKwhXhouoF1bWTUreXxwdY8CfYWzl7pZf6t//28CVI2rZneUetb8E8TtvV
r6KZc5fy+LXpbDqqGqHWpStOKWxtJd4pnS1dvLDvYK9CIp/gedL3ZCPQCNj7Plx7
N/LOXoDt+WC1+X5SUe6vni4d8tuBzw==
=WwoY
-----END PGP SIGNATURE-----

--VZ+uyQ7gTEqN7H30--


