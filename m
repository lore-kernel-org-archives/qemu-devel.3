Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A495DD30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCF-0008C6-3O; Fri, 18 Oct 2024 10:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCD-0008Bj-Ml
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCA-0002aO-Sx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gh1BDtULSqtnwoO7AF7cH9oUZwnv141ocT916i6TCRc=;
 b=fCRq+tuE4+pW2wQtrq1CZAkZwCygkFtCZkvvi2RzJBtH74t7o84JM8ZnHwa+UQHEp1Vk2x
 ZA5gDmol8iTpPbbQnMmhQcL0EHVn9dIevRTaR/mkNimWAznGJQ9o1ZZ9r5nCYzIup7K6Dx
 ufJV+jGcZcyrgVNbfIS/YG/2vpKXn20=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-ofogmXSxMvqfYsUK0BaPJw-1; Fri, 18 Oct 2024 10:43:11 -0400
X-MC-Unique: ofogmXSxMvqfYsUK0BaPJw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43057c9b32bso15697035e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262590; x=1729867390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gh1BDtULSqtnwoO7AF7cH9oUZwnv141ocT916i6TCRc=;
 b=itmljYmaY1T41WEwKG2/3XumR/Ox2NkaxxDhiEFTDNwC6u8kjRUuYhXdsayLWEV7UY
 +h60CoKg0N9eMjbWv8uaJ6IEKeKY5264L9+hkpjABbAdnmvrYmCELBTB0DA36GeY1jM6
 cZLVufhWhlmLoKPSS+du9gz120699BZa3BwdfK8GpNlIYVYZ/TcPrEGRCZ0e+Mf1jlD7
 Tbj91IEIRFNn0/pZ3hdKC3zqoV6OLWvitF+3Xi6da7wmSMXh+6DSRujWiBvq2U/EfSYV
 R9YFr7hd9F6PGTxSSFcDKDbiIgcof/FCZyPsGx594Y54AlSe//DZvnszLmtWJKBs1yZr
 5Siw==
X-Gm-Message-State: AOJu0YwSWUL4NNP43qu/HNDTW4fOa7uF+CgZAqv5q5QY71BKwDuzDuUL
 O76CUPZOn5fChTLDwPvywm7Ai1R4uYqyykGhO1c0yVt6oCoQ9YJNpz7LYy5sCjfWqd3FPaXUnHG
 p0nePHD8VtAZtIZIWyjk6qrk4XnNh28Aaldt3gfRCI/ez6kTIx3ad6uHGRk/JAQttcEiEL4VLC2
 ber/hBlbJiF2ZRKJ8Dmk1xCcYv0ZJkO6zLmXv5wiM=
X-Received: by 2002:a05:600c:35d3:b0:431:44aa:ee2e with SMTP id
 5b1f17b1804b1-4316161fb33mr17693985e9.4.1729262589704; 
 Fri, 18 Oct 2024 07:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1fkpdYfEURuOYVIBJAOaacxSKSzAx3rzufNHj8EOBwEK8RQoUrs4lYsX98/GkETS4uGBiWQ==
X-Received: by 2002:a05:600c:35d3:b0:431:44aa:ee2e with SMTP id
 5b1f17b1804b1-4316161fb33mr17693775e9.4.1729262589203; 
 Fri, 18 Oct 2024 07:43:09 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431606c6a61sm29258825e9.36.2024.10.18.07.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 00/13] rust: miscellaneous cleanups + QOM integration tests
Date: Fri, 18 Oct 2024 16:42:52 +0200
Message-ID: <20241018144306.954716-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series integrates some of the observations from the MSRV patches at
https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com/.

The main changes here are two: first, build an integration test that
actually tries to create a QOM object that is defined by Rust code;
second, make the properties array immutable so that declare_properties!
is enforced to use only const-friendly constructs.  These are patches
6-11; the others consist of small cleanups.

Hidden in here is actually a C patch (#10) which makes the
bindgen-generated prototypes use "*const" instead of "*mut".

Tested with Rust nightly and (together with more patches from the
RFC), with Rust 1.63.0.

Unlike the MSRV patches, this should be ready for inclusion; the
changes should be mostly uncontroversial.

Paolo

Based-on: <20241018143334.949045-1-pbonzini@redhat.com>


Paolo Bonzini (13):
  meson: import rust module into a global variable
  meson: remove repeated search for rust_root_crate.sh
  meson: pass rustc_args when building all crates
  rust: do not use --no-size_t-is-usize
  rust: remove uses of #[no_mangle]
  rust: remove unused macro module_init!
  rust: modernize #[derive(Object)] for ELF platforms
  rust: build integration test for the qemu_api crate
  rust: clean up define_property macro
  qdev: make properties array "const"
  rust: make properties array immutable
  rust: provide safe wrapper for MaybeUninit::zeroed()
  rust: do not use TYPE_CHARDEV unnecessarily

 meson.build                            | 31 +++++++---
 include/hw/qdev-core.h                 |  4 +-
 include/hw/qdev-properties.h           |  4 +-
 hw/core/qdev-properties.c              | 26 ++++----
 system/qdev-monitor.c                  |  2 +-
 rust/hw/char/pl011/src/device.rs       |  7 +--
 rust/hw/char/pl011/src/device_class.rs | 10 ++--
 rust/hw/char/pl011/src/memory_ops.rs   | 13 ++--
 rust/qemu-api-macros/meson.build       |  2 +-
 rust/qemu-api-macros/src/lib.rs        |  4 +-
 rust/qemu-api/meson.build              | 23 +++++--
 rust/qemu-api/src/definitions.rs       | 50 +---------------
 rust/qemu-api/src/device_class.rs      | 83 +++++++-------------------
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/tests.rs             | 49 ---------------
 rust/qemu-api/src/zeroable.rs          | 23 +++++++
 rust/qemu-api/tests/tests.rs           | 78 ++++++++++++++++++++++++
 17 files changed, 201 insertions(+), 209 deletions(-)
 delete mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/qemu-api/src/zeroable.rs
 create mode 100644 rust/qemu-api/tests/tests.rs

-- 
2.46.2


