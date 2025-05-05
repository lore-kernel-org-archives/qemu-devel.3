Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B061C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBskz-0005OR-DG; Mon, 05 May 2025 06:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBskw-0005K5-N5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBsku-0007BU-92
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mo6VTAvR/T9wtlPyBhOf4b3ONNglD/nqFYKB9OjuyRo=;
 b=RTOumtH/1PqkQAoxbS4Uct7z71HOA3fXtjFAZUojFBjQ1pU7gSfwe3RmLJntYCEzuJGSHP
 ItrPHdrR8/19OeIaTvUI8N7deKqJ2GVnwNWs26XyKpXlSSZjHYuCsPN/K8q0lUXyZFmU+q
 U5kvY0BP8J8D2kQHeFeayc7U1x8/Yfs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-og7rv724M7ScO1WNrNHbkg-1; Mon, 05 May 2025 06:08:58 -0400
X-MC-Unique: og7rv724M7ScO1WNrNHbkg-1
X-Mimecast-MFC-AGG-ID: og7rv724M7ScO1WNrNHbkg_1746439737
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a08a1c0fc5so2204771f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439737; x=1747044537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mo6VTAvR/T9wtlPyBhOf4b3ONNglD/nqFYKB9OjuyRo=;
 b=uKt+vSyRQInnI975Og2ryHtJVXKASnxcBOxORuu0ANcWY6H6eMbL68VCCDU5tZO+WW
 xuLNkxZN7Pe8RBRI7lRu3Zw6miiCTDWZ5fopDqsTHkMHDTfrRHON6kTY2olVzVK/dwym
 TQ5/RKhSNyzc93pK2VcmGgmx2wosabiGuk6VR7UXcHDJ83v+ezielVgTzQjjqRshd4sb
 S0cxSamIIPzLNb6TrqayB6WFEe1y7W+9zVV2GlmvtN4+UamIDkOhIbK+F2mzNHmun3t0
 ApqHDIGkTBGuEXSdT6a1cD4Ne9LTeH9uN9GOrpyYdx0632oeH62i1ufJ3ZRV9043FKpv
 16Ww==
X-Gm-Message-State: AOJu0YyOe7sVfNCrilAGtRqvV980lRoNx8Jwe2iRZwzvcr6DsadnBL6a
 XdSiOFfCb3NzaodUq5WxXTAUG7ABVxtaJUODS2dL639lM1z8uAfSs+hQrcyF8+N3ypJmcuD0T/e
 U4ssOuJHL6V1nuddAHX8pc/2ytoUSy9Qax7chHmTVBruzqs+LhiovI7rdJQLqnrWywOs7BbvyqZ
 1hE8zmGSR341wJHdnesma1952Hp7xfHBJlyicl
X-Gm-Gg: ASbGncs4L2V2xcJqZAYMIFZtzP4oWc+fPVXndd/YfI18cL6NVuzjM4Ab+iEZmeTTD3P
 5BRE1DsYd+wkwkETKmCk91JKpqjjdCCeBo0KkBdLkNm0WYOvDguDOonvgM+yxJWuSKeDXWm7A9k
 nQFE3Xj2wNxU1D/HHDbpLXkVmeSl5JBsl6B3iRDCANKzUNOegO9JGitYRHID7PNyCtifXaKnw3q
 qz/tgrtxPEIw/uUti5fQ6RbsgGOR47E8ZLWGQ8Dj+TrF8pXIjFE+5DuGYPDxVi3dxA8KZEVAlZQ
 ulbOtd5N7/nPEjQ=
X-Received: by 2002:a05:6000:1a86:b0:39a:c8a8:4fdc with SMTP id
 ffacd0b85a97d-3a09fd748a2mr5434740f8f.16.1746439736695; 
 Mon, 05 May 2025 03:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmrEjlsgIrPyvig3b24aLxAf+x6R1gNsAKigw2FTA63NlpLi/uRqJVDUTyyvJBYmVrrGbQ3w==
X-Received: by 2002:a05:6000:1a86:b0:39a:c8a8:4fdc with SMTP id
 ffacd0b85a97d-3a09fd748a2mr5434710f8f.16.1746439736179; 
 Mon, 05 May 2025 03:08:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0ff5asm9947256f8f.75.2025.05.05.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 03:08:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH preview 0/5] rust: allow minimum version of 1.83
Date: Mon,  5 May 2025 12:08:49 +0200
Message-ID: <20250505100854.73936-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is the preview of moving the minimum supported Rust version
forward to 1.83.0, which is the target for QEMU due to its support
for the const_refs_to_static feature.

Being able to autogenerate all the reflection-like structs in qdev and
VMState improves the type safety, but also requires annotating the
types with the information needed to generate the structs.  The
const_refs_to_static feature is needed because this information resides
in constants that refer to global variables (of types such as PropertyInfo,
VMStateField or VMStateDescription).

This series does not cover enabling the newer compiler in CI because,
while both Debian and Ubuntu have a new-enough Rust compiler to support
1.77, they pose problems for this further bump.  For Debian, the bookworm
release probably will not have new compilers and is supported by QEMU
for roughly two more years.  For Ubuntu, the situation is a bit weird
because while Ubuntu 22.04 had new Rust compilers added until the summer
of 2024, Ubuntu 24.04 is not adding packages for new versions.

A possible plan here is to split the configuration between "enable Rust"
and "enable all devices written in Rust" as soon as new devices are
contributed that are written in Rust.  This way, the C versions of
the pl011 and HPET devices can be used but the new boards/devices would
only be available on Debian or Ubuntu by using rustup.

This series does not use *all* features enabled between 1.77 and 1.83;
in particular it does not replace addr_of!/addr_of_mut! with "&raw"
expressions.

Paolo

Paolo Bonzini (5):
  meson, cargo: require Rust 1.83.0
  rust: use inline const expressions
  rust: vmstate: convert to use builder pattern
  rust: vmstate: use const_refs_to_static
  rust: qdev: const_refs_to_static

 docs/devel/rust.rst                    |  30 +-
 meson.build                            |   6 +-
 rust/Cargo.toml                        |   2 +-
 rust/clippy.toml                       |   2 +-
 rust/hw/char/pl011/src/device.rs       |  20 +-
 rust/hw/char/pl011/src/device_class.rs | 123 +++----
 rust/hw/timer/hpet/src/hpet.rs         | 173 ++++------
 rust/qemu-api/src/assertions.rs        |   4 -
 rust/qemu-api/src/callbacks.rs         |  27 +-
 rust/qemu-api/src/chardev.rs           |   2 +-
 rust/qemu-api/src/qdev.rs              |  16 +-
 rust/qemu-api/src/timer.rs             |   2 +-
 rust/qemu-api/src/vmstate.rs           | 432 +++++++++++++++----------
 rust/qemu-api/tests/tests.rs           |  20 +-
 rust/qemu-api/tests/vmstate_tests.rs   | 155 +++++----
 15 files changed, 517 insertions(+), 497 deletions(-)

-- 
2.49.0


