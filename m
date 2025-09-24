Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3460CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoH-0004XZ-PD; Wed, 24 Sep 2025 05:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoC-0004X8-9i
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lo5-0004ke-Dv
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8FT/+Iri/F8gWSaSylVxcoTu5TqOYZEu6JshArakoVo=;
 b=WwY+FBWIkCvAzXMLaahrYz/uPPJGEFXx4dCQN4ZkkKyfdPsSvr1UdYq0RECwM6igASa1XB
 lFYhlNpocRGrTM54mf/mq0lg+t6AuQNZQ3QC3ppxYRd97CNr0He37sI1HVzxSy1Fp/6pvT
 SOZrAg1ziZuWjVtJqm0qSa2v9QDqsRg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-wlHa56TeMWeAeojR8iWufQ-1; Wed, 24 Sep 2025 05:28:54 -0400
X-MC-Unique: wlHa56TeMWeAeojR8iWufQ-1
X-Mimecast-MFC-AGG-ID: wlHa56TeMWeAeojR8iWufQ_1758706133
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b2fca156551so75305166b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706133; x=1759310933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8FT/+Iri/F8gWSaSylVxcoTu5TqOYZEu6JshArakoVo=;
 b=h3W9Rb9+rrkKURNz8xKfYzS54nH0JJM8cDOjgJ/Nu/EWSj2dXEdzk98rgYT4CWfImw
 a6Q1g46dSwRLcpSTzhuA8t7GsKr0sfNF0ymMlq+lTMzCxUHF2wz2Yops4zFd44tS5yyG
 pzBiciVwEbG28pzsbKr5VFUgLrgFAwaQGu+BD+cr83WUQL1gpyoLa5PFOXqx4LK+RY2B
 OazzFpodcu2ukLFqbjtWsKIp+6wFsIhMoEtqKNVjitR1ApjhS+3sQDUUN0AhW9HK1DuI
 EPq64lpxXiBw20OU+vjvppAl4NrFWqCzeuz3hAup2/nGN4Cm5NHzBmx4b32EADG+PtmV
 svug==
X-Gm-Message-State: AOJu0YxvpdaePIp5M5p5TdLJjREH2BrdXKDBzGngW6Hz+9Uhmk3YvFo8
 zA8KY1CnFth/3sqpkt/x+0AKDp2luMu7hjrMjVS9oPlnepCdAYqXHBYH/zbrbgZHJIRizIKQZHW
 NpZXZIBoImV8lVpZlU5+5vkpNrLPz5s2Lq7Jj8sCZP7gUTzqZUDuFNQoXGCuk3bMr5fELufHRfs
 mSGjvQrSZ8iOQ5YCR44uMXgck/zrPRSGptoqlPro6m
X-Gm-Gg: ASbGnctSB6imh0F9TDPXj+8x3koDOQ19FCD3Dbms5p2R8WNrfP3HF6OhODK6ntXHADf
 5vuVrwiEC61LXsX/yg97xEgdJCdVTpuKeQxvKqJF/dT9n+pPWKSY2L0UGjwUDp2KahU/wpvGZ1o
 B4cf1+jmhd64yRX/aVQJE4uX0OlPg0nz74acHsZKyg40CBXc8wCkqholbEIzeOABC6Zv8exjkMn
 DI7q2MoIxyK7sdv+73bWo+MDT/scVbUO2ArJln8xTiCi/3nmX4NCZfgCGQs+WfckF2xbAsa6puA
 o6SPJfJDh0Z42hHdHg+E9PqoR8ZE/tF7O504+JnkHBC3s73CWQ0W2hu/EirRXo0TH7pnXGi3iYl
 g8hpwDEse4JPEGTo0I2iXywgwBHCrDeK2M1Tju+wLOW4+mQ==
X-Received: by 2002:a17:906:3b45:b0:b33:821f:156e with SMTP id
 a640c23a62f3a-b33821f18c2mr81022566b.12.1758706132664; 
 Wed, 24 Sep 2025 02:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKxRv+/h8le2Nz8ib3JlqNamu3Q70F2IHC6FYTO8pjaZgp/UrlyafmcVMz/FXl9SvRGRyVFw==
X-Received: by 2002:a17:906:3b45:b0:b33:821f:156e with SMTP id
 a640c23a62f3a-b33821f18c2mr81019166b.12.1758706131911; 
 Wed, 24 Sep 2025 02:28:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a2a5f6cb9sm834714666b.36.2025.09.24.02.28.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:28:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] Rust, QOM, docs changes for 2025-09-24
Date: Wed, 24 Sep 2025 11:28:20 +0200
Message-ID: <20250924092850.42047-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ab8008b231e758e03c87c1c483c03afdd9c02e19:

  Merge tag 'pull-9p-20250918' of https://github.com/cschoenebeck/qemu into staging (2025-09-19 12:21:35 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to cd64320e1e27168d3796a847bbfde66c8b1116f9:

  docs/code-provenance: AI exceptions are in addition to DCO (2025-09-24 09:26:24 +0200)

----------------------------------------------------------------
* qom: Do not unparent in instance_finalize
* linux-user: avoid -Werror=int-in-bool-context
* docs: use the pyvenv version of Meson
* rust: parse attributes using the attrs crate
* rust: complete conversion of qdev properties to proc macro
* docs: clarify AI-generated content policy

----------------------------------------------------------------
Akihiko Odaki (7):
      docs/devel: Do not unparent in instance_finalize()
      vfio/pci: Do not unparent in instance_finalize()
      hw/core/register: Do not unparent in instance_finalize()
      hv-balloon: hw/core/register: Do not unparent in instance_finalize()
      hw/sd/sdhci: Do not unparent in instance_finalize()
      vfio: Do not unparent in instance_finalize()
      hw/xen: Do not unparent in instance_finalize()

Manos Pitsidianakis (2):
      rust/qdev: use addr_of! in QDevProp
      rust/qdev: Refine the documentation for QDevProp trait

Paolo Bonzini (10):
      docs: use the pyvenv version of Meson
      rust: build: add back common and util tests
      rust: vmstate: use "cast()" instead of "as"
      rust: build: remove "protocol: rust: from doctests
      subprojects: add attrs crate
      rust: qemu-macros: switch #[property] parsing to use combinators
      linux-user: avoid -Werror=int-in-bool-context
      docs/code-provenance: clarify scope very early
      docs/code-provenance: make the exception process more prominent
      docs/code-provenance: AI exceptions are in addition to DCO

Zhao Liu (10):
      subprojects: Update .gitignore for proc-macro2 and syn
      subprojects: Ignore .wraplock file generated by meson v1.9.0
      rust/qemu-macros: Fix Clippy's complaints about lambda parameter naming
      rust/common/uninit: Fix Clippy's complaints about lifetime
      rust/qdev: Support property info for more common types
      rust/qdev: Support bit property in #property macro
      rust/qdev: Test bit property for #property
      rust/hpet: Clean up type mismatch for num_timers property
      rust/hpet: Convert qdev properties to #property macro
      rust/qdev: Drop declare_properties & define_property macros

 docs/devel/build-system.rst                       |   2 +-
 docs/devel/code-provenance.rst                    |  33 ++++---
 docs/devel/memory.rst                             |  17 ++--
 docs/devel/rust.rst                               |   2 +-
 docs/system/devices/igb.rst                       |   2 +-
 hw/core/register.c                                |   1 -
 hw/hyperv/hv-balloon.c                            |  12 +--
 hw/sd/sdhci.c                                     |   4 -
 hw/vfio/pci-quirks.c                              |   9 +-
 hw/vfio/pci.c                                     |   4 -
 hw/vfio/region.c                                  |   3 -
 hw/xen/xen_pt_msi.c                               |  11 +--
 linux-user/strace.c                               |   2 +-
 rust/Cargo.lock                                   |  11 +++
 rust/bql/meson.build                              |   1 -
 rust/common/meson.build                           |   4 +-
 rust/common/src/uninit.rs                         |   4 +-
 rust/hw/core/src/qdev.rs                          | 105 +++++++-------------
 rust/hw/timer/hpet/src/device.rs                  |  55 ++---------
 rust/meson.build                                  |   2 +
 rust/migration/meson.build                        |   1 -
 rust/migration/src/vmstate.rs                     |   2 +-
 rust/qemu-macros/Cargo.toml                       |   1 +
 rust/qemu-macros/meson.build                      |   1 +
 rust/qemu-macros/src/lib.rs                       | 108 ++++++++++-----------
 rust/qemu-macros/src/tests.rs                     | 113 +++++++++++++++++++++-
 rust/qom/meson.build                              |   1 -
 rust/util/meson.build                             |   5 +-
 scripts/archive-source.sh                         |   2 +-
 scripts/make-release                              |   2 +-
 subprojects/.gitignore                            |   6 +-
 subprojects/attrs-0.2-rs.wrap                     |   7 ++
 subprojects/packagefiles/attrs-0.2-rs/meson.build |  33 +++++++
 33 files changed, 306 insertions(+), 260 deletions(-)
 create mode 100644 subprojects/attrs-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
-- 
2.51.0


