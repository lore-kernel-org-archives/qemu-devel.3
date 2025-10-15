Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544FACCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zZx-0007vo-Ji; Wed, 15 Oct 2025 07:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8zZv-0007vE-I3
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8zZm-0002if-Fc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760527306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XLpvGGZ8WRVvDXCdQuGucaMwYXJnc6UP4bGICxPC5sM=;
 b=CqvR2K4XLi/YXwAlEmcWbws5lIYOY7Jp0NFx2gmse2iSypZ1v0VWMzCHg3AwraPMcMH78e
 cw7Z6vVS1J+z/Nog7SRrIvVMQXslXgg95FkvH+nh2IJ0xr5rSH3cEvxEPYBOuaU7wF4Gha
 aB3YT9KOBh4OrOKMRCXB9jYLz4S5alc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-ysD6kbr6N6GAb5M6mKcV9g-1; Wed, 15 Oct 2025 07:21:44 -0400
X-MC-Unique: ysD6kbr6N6GAb5M6mKcV9g-1
X-Mimecast-MFC-AGG-ID: ysD6kbr6N6GAb5M6mKcV9g_1760527303
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426ec5e9278so1210694f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 04:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760527303; x=1761132103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLpvGGZ8WRVvDXCdQuGucaMwYXJnc6UP4bGICxPC5sM=;
 b=OJCTk8B7msuyw1icoc7VlEeyYpjwYlJ6JZ9BS/B8dL/vqhiWiWuCBesBhCOUOBK7gx
 zqwX5kelgHdQU7rtbKXfobBPBdpd/OcKYIRRYOOw21coq6mVJ55eeXWbiETFJJAW1J9+
 NfYXTvI8odKqoh0pQixSmU/fiXjwpJVDklPifeLJBIvaq4suc8lK/IKGEN3mpUNCkXW5
 J7hR6UmqekGaLxYiqFhRVlarjMIFy670V4n3FWfl2jd8eglfVdgnXPxqsLVlTfqqbLLG
 8Rlcjb7OigF1ZXZIrZUASwRKRYIlSXJE30cqrNK6OqDI17meIZCOciVe/vtcM6eB+CnC
 wNSw==
X-Gm-Message-State: AOJu0YzAkgGTdeNu8UtJoSafejGuhty9p3Te75PP/WPXBdLzqPYIn9jc
 JNaQgi5slYH9kHipvkkDglPNt/Pa17frzW6yk5ndXSUCBTfpVKBtQVOx6F6NhhcrRJqkKDivB2N
 Rt+U64Vgg9vdHtoEPKPdfrC0jaCrrmeR2D7eWolxW2NA/cve+PqPuwJKpAE1PpMvP9Rod5kNVQs
 GoqI70QSl1J8kJ/e5DusVZ2cthXd7YjRZU7CldvcyE
X-Gm-Gg: ASbGnct7IT6qMKM7q0NaFTe7e5BepB0BCVwCE0PvypSaoAz7hzv9gYZxUvsJJ05C7nV
 EP3yO/S6XQA2Rb2Goe/EmztgF9CVDrbbMvCUsy17N2Qj8enmdp52HVvD40uwwWVZ0Cnq6Qsh4MW
 hosLy/UnUuHVeCH3QkX7IHQVCbid4sG2tZHNIkYN0sf4VDZS/dWhi58WML8DT56mbqbDqRgbT03
 DIDFo/PF6m4VuMigpwWLgQVVm+BXunoVpxEYo3IueOkpG0YQk9bu71SC9R3ze2k34mW8AxX5xq9
 UTKc/QyaRMYaUeUf5ARhw/uGD9Qd6JckxHHqJ/yri8imO9F07jH1Uejx7+9I5Y+IYL394BhU/Wu
 kLVz6LY09M7MV5Ge016ffAvGDLbKPf/fKxM8zQBu0fOQ=
X-Received: by 2002:a05:6000:420a:b0:3ee:114f:f89f with SMTP id
 ffacd0b85a97d-42666ac6b77mr17801193f8f.15.1760527302522; 
 Wed, 15 Oct 2025 04:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFooIK50no4b0wG7HjD1lDaI6srLJdrhWRRkPgsH0QPHEnZIX3v4Om50AOKZzyrK1xFeWqz0Q==
X-Received: by 2002:a05:6000:420a:b0:3ee:114f:f89f with SMTP id
 ffacd0b85a97d-42666ac6b77mr17801149f8f.15.1760527301795; 
 Wed, 15 Oct 2025 04:21:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e10e8sm28591233f8f.39.2025.10.15.04.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 04:21:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Rust in QEMU update, October 2025
Date: Wed, 15 Oct 2025 13:21:31 +0200
Message-ID: <20251015112139.1197033-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Summary
'''''''

Achievements
  Definitive code structure and MSRV bump; migration improvements and
  tracing merged; Rust enabled in CI for more host operating systems;
  initial bindings for QAPI and QMP

Ongoing work for 10.2
  Integrate Meson bugfixes from upcoming version 1.9.2; IOMMU support
  ongoing in rust-vmm

Future work
  More QAPI/QMP integration; enable by default; tighter integration
  between Meson and Cargo


Table of contents
'''''''''''''''''

* Status in QEMU 10.2
* Improvements and cleanups
* Other work in progress
* Next steps


Status in QEMU 10.2
'''''''''''''''''''

While the project is still in a "pupal" state, a lot of the individual
bits are less experimental, and the overall structure of the Rust code
in QEMU is clearer.

The minimum supported Rust version is now 1.83, with no extra bumps
planned.  The only unsupported platforms are Debian bookworm mips64el
(other architectures remain buildable on bookworm too) and Ubuntu
LTS releases, for which newer versions of Rust are planned but not
available yet.

We have enabled Rust in CI in almost all jobs.  Once some Meson bugs
are fixed, which currently prevent enabling Rust for Windows and macOS,
all targets should support Rust.  Both Marc-André Lureau and Martin
Kletzander have already identified and fixed some bugs in Meson, and
their patches will be included in Meson 1.9.2.  Meson 1.9.2 version
will also make it possible to use rustc to link emulator binaries, which
makes the resulting executable smaller and the build system a bit simpler.

Over the sunmer, Tanish Desai wrote most of the code for tracing support;
it is now merged as well, closing the biggest feature gap between Rust
and C versions of the devices.  While support for the ``dtrace`` and
``ust`` backends is still missing, ``dtrace`` should be added soon via
the existing ``probe`` crate.  For ``ust``, the plan is to deprecate it.

With these improvements, there is already a practical benefit to writing
*new* devices in Rust, especially if you don't need other APIs than those
with bindings.  The build system boilerplate is still substantial
for the time being, but this is a temporary issue and the existing
pl011 and HPET devices provide a model that is easy to follow.

If any devices are contributed that are written in Rust and do not have
a C counterpart, it may be worth splitting "enable Rust" from "enable
all devices written in Rust".  This way, the C versions of the pl011
and HPET devices can remain available until all platforms have a new-enough
compiler version and no build system issues.


Improvements and cleanups
'''''''''''''''''''''''''

With the recent merge of ``VMStateDescriptionBuilder``, there is no
remaining need for unsafe code in devices, outside the QOM ``instance_init``
method.

Migration support was also improved to support thread-safe (non-BQL)
devices.  The plan is to apply these improvements to HPET, which recently
became BQL-free in C.  Thread-safety may also be a good reason to rewrite
other simple devices from C to Rust, for example interrupt controllers.

Rust<->C interoperability is now split across multiple crates, each
linking to the corresponding C code.  This should simplify work on block
devices, as there is no need anymore to build the support code twice
for tools and emulators, and it also makes documentation less daunting.

In addition, GLib bindings use glib_sys, which makes it possible to use
only features present in our minimum supported version of glib (2.66).

There are now a lot fewer loose ends in the ``meson.build`` files.  The
files are still pretty large, but they are homogeneous and should be
readable.

Zhao Liu is looking into cleaning up HPET to separate the registers
struct, as is already the case for PL011, and at the same time enable
lock-free MMIO.


Other work in progress
''''''''''''''''''''''

``vm-memory`` integration
  Zhao also looked into using the ``vm-memory`` crate in QEMU.  Because of
  QEMU's support for IOMMUs, this required changes to the crate.  Hanna
  Czenczek's work on IOMMU support for rust-vmm is very close to being
  merged, and we'll wait for that before continuing with ``vm-memory``
  integration in QEMU.

  Nevertheless Zhao's work provided some insights on what the future API
  could look like---for example, a memory store in safe Rust could look
  like this::

     ADDRESS_SPACE_MEMORY.store::<Le32>(addr, 42);


Meson support for Cargo
  As mentioned in the earlier updates, in parallel to QEMU work I'm
  looking at improvements to Meson's support for Cargo and Rust.

  The thrust for these improvements is to let QEMU use Cargo subprojects
  for the crates it depends upon, making it possible to add dependencies
  simply by adding them to ``Cargo.lock`` (the file that is currently
  sitting in the ``rust/`` subdirectory).  Hanna was particularly vocal
  in requesting an easier process to add new Rust dependencies. :)

  Meson 1.10 will already be able to read a superproject's ``Cargo.lock``,
  but later on it will also need support for reading QEMU's ``Cargo.toml``.
  This has two objectives: first to resolve the set of features that are
  required from the dependencies, and second to enable adding new simple
  build targets (e.g. devices and tests) with one or two lines of Meson
  code.  The first parts of the work are at:

  - https://github.com/mesonbuild/meson/issues/14639 (specification)

  - https://github.com/mesonbuild/meson/pull/15069 (first part of the
    implementation, covering feature resolution)

  This is longer term work.  I'm seeking to have it merged over
  the next few Meson releases starting with Meson 1.10, but it does
  not block further work on QEMU.  Right now we have roughly 20
  dependencies, and we're adding about 1 per month on average.


Next steps
''''''''''

There is almost feature parity between C and Rust devices, other than
for the following items:

- dtrace support [Stefan]

- lock-free MMIO in HPET [Zhao]

Once the above are fixed and Ubuntu gets Rust 1.83, QEMU can enable
Rust usage by default.

Integration of QObject and QAPI with serde is on the mailing list.
It enables QMP integration and it also helps supporting QOM properties,
but is not planned for QEMU 10.2 since there are no users yet.
One possibility is to resurrect more of Marc-André's 2022 work
on QMP commands, for which he used qemu-ga.

The cleanups to the build system should be enough to restart work
on the block layer.

More hands would be welcome in adding bindings for more backends
and bus types, for example (respectively) block devices and I2C.


