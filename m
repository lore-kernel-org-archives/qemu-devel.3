Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7657CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rb2-0003ab-19; Wed, 01 Oct 2025 03:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3raz-0003Zl-8O
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3raj-00022T-0d
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759304969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4LJlbTi89MWiCTkK6FX/aE1z7BsUo+V9Tk+ja/kMSkE=;
 b=b3NoIDa5+HJWoE4DLV2xTd5jata1lL/whY09F9qDHnnYy4TBhx4OKPDRmLTv1sHZGEeWZg
 YPYyvXKOK3mgb2wlUsSEOqLxwF7NFfovpcZKN9EclvsXXAEc9ZE5Wu5gvURQQSPgrwPV1S
 F3Bkn9FKs7LVt36mmbPRcR+v/b/aqTQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-KD3cxixtNGaGWSF44Nr3Jw-1; Wed, 01 Oct 2025 03:49:24 -0400
X-MC-Unique: KD3cxixtNGaGWSF44Nr3Jw-1
X-Mimecast-MFC-AGG-ID: KD3cxixtNGaGWSF44Nr3Jw_1759304964
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-61d31626b01so6326276a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304962; x=1759909762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LJlbTi89MWiCTkK6FX/aE1z7BsUo+V9Tk+ja/kMSkE=;
 b=B2sGDxQzOXfIDQMMR/5Lb5YYr0EL8LsHM5cx199HI9yj7CEy4SP6lViuMZ1wbkctOS
 LHeOBvdb4vYOrCjt2D1/fOHGBH+usT+6FASg4qOnwnhyPUibaerYVVoRNdjoIXu5ySdx
 /9+LEkPUyV3MV7fvwG++Yya8TR7zH1V8E9LBXau/fdyO4fxy3hP/oqR19KWO+kXGcFHA
 OX8vwolOnh6rEJSCMwv2ihHY0PoiH6gceHkbitTgZol0CC63FutylKev/RF+edqaPvw8
 Y0/ZGfL6a7Rxn8uwTExKtwrxrUpfyi5ykC19oaNaOMH/USBluMrLigeWsKWPKrRM27M9
 Esag==
X-Gm-Message-State: AOJu0Yw6OqbZ+BxzUg92nQ4DmgPfvayNG5Y638+o94n+/+d0V7VJmU4J
 eXrYhJ/8UPEXLsKmChadl0F3dEYkikju7PYBYLym+4zmVypJZ2n7QHo5647kDKvS6VLegrMUp9v
 yFV/c1pwb5mI8rwDQgqOHInPzjHg17qmZCEgafP9wDCPMgvmI1dCFkKXFp9WvRhx8RBC9Tc36rc
 2SeUIv9LuCMqVLFn5sknv7EYYz1IbowKEOqn6yBMOJ
X-Gm-Gg: ASbGncvbAy/Zm8J9pHiYKP0yP0RawabzXNFA26FTDxJkQHEf4njp2w+N5fCXpPlNNGm
 WCRi6llVJRc1pvYSA4jga+2t4rJcPLF8JVnEUi9I3cgsqj898dXpI4jSQmX/aa0w0tXrueNqdtG
 +CQk73bnqioGroX9GYb1F6q634kJk5bPZKZLErA6KAXwNNlQ2UMD0QlhnH0g5KlQtFJ/OWMrNtJ
 SVavS5dM4JgG46+H6kcB6H+UG/Ukk39fOngi7Gn0fgsZrMxfgt14mUFDZCqpGHfvtdt/o4MRHn/
 r54lY4sayKHQVyhR2ZODsrkTopW+L6/H2f12mTG5/deBY+WXp/IFZfeMjSm8KU9fMwVN1CiClzx
 9XemtGrFQRxlTvrh5JtDnNrnTFUyewmUF21Nv7bN2pfimMYZ645I=
X-Received: by 2002:a05:6402:358f:b0:631:d77a:57b2 with SMTP id
 4fb4d7f45d1cf-63678ba9b62mr3165419a12.3.1759304962491; 
 Wed, 01 Oct 2025 00:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuJL/aXe9TD4TmQR6Kg76QJ0p1hMwW5OyDyNZtGVJI4iFPbgjOqA/hRgjdYG71pssr0ZdwOA==
X-Received: by 2002:a05:6402:358f:b0:631:d77a:57b2 with SMTP id
 4fb4d7f45d1cf-63678ba9b62mr3165382a12.3.1759304962062; 
 Wed, 01 Oct 2025 00:49:22 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3671beasm11100065a12.22.2025.10.01.00.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:49:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] rust: do not generate GLib bindings
Date: Wed,  1 Oct 2025 09:49:18 +0200
Message-ID: <20251001074920.1041619-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Don't generate FFI for glib, rely on glib-sys crate.  This makes it
possible to limit Rust to the same minimum version as C code.

The disadvantage is that each bindings module needs to import from
glib explicitly.

The extra lines in Cargo.lock are all build dependencies that are not
used by Meson.  They are only used for glib-sys's build.rs rules,
when running e.g. "cargo check".

Marc-André Lureau (1):
  rust: use glib-sys
  subprojects: add glib-sys-rs

 meson.build                                   |   1 +
 include/hw/core/cpu.h                         |   2 +-
 rust/Cargo.lock                               | 182 ++++++++++++++++++
 rust/Cargo.toml                               |   1 +
 rust/bql/Cargo.toml                           |   3 +
 rust/bql/meson.build                          |   1 +
 rust/bql/src/bindings.rs                      |   4 +
 rust/chardev/Cargo.toml                       |   1 +
 rust/chardev/meson.build                      |   2 +-
 rust/chardev/src/bindings.rs                  |   4 +
 rust/hw/char/pl011/Cargo.toml                 |   1 +
 rust/hw/char/pl011/meson.build                |   1 +
 rust/hw/char/pl011/src/bindings.rs            |   5 +
 rust/hw/core/Cargo.toml                       |   1 +
 rust/hw/core/meson.build                      |   2 +-
 rust/hw/core/src/bindings.rs                  |   3 +
 rust/meson.build                              |   2 +
 rust/migration/Cargo.toml                     |   1 +
 rust/migration/meson.build                    |   2 +-
 rust/migration/src/bindings.rs                |   1 +
 rust/qom/Cargo.toml                           |   1 +
 rust/qom/meson.build                          |   2 +-
 rust/qom/src/bindings.rs                      |   2 +
 rust/system/Cargo.toml                        |   1 +
 rust/system/meson.build                       |   2 +-
 rust/system/src/bindings.rs                   |   4 +
 rust/util/Cargo.toml                          |   1 +
 rust/util/meson.build                         |   2 +-
 rust/util/src/bindings.rs                     |   2 +
 scripts/archive-source.sh                     |   1 +
 subprojects/.gitignore                        |   1 +
 subprojects/glib-sys-0.21-rs.wrap             |   7 +
 .../packagefiles/glib-sys-0.21-rs/meson.build |  33 ++++
 33 files changed, 272 insertions(+), 7 deletions(-)
 create mode 100644 subprojects/glib-sys-0.21-rs.wrap
 create mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build

-- 
2.51.0


