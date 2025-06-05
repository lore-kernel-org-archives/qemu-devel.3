Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DDEC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7dk-0007Lq-O4; Thu, 05 Jun 2025 06:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7db-0007If-FT
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dW-0001D8-Lt
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hyKz6nWErMiubgubQFr6FKvLFAmnjsB5MvJF4fUeC4E=;
 b=buteH5+8+/rN+lSY7U+6MaQ4LhZ/WTGmgt7T2yFmzkd9F9XBymOKG9RGJ0kWKxdF98WByg
 S+DuMIcMJ5V/iFst8hwWlTmD6p/Ks1yB8lQsIGJ4xsLlXarf3oE+uu7GMtpRKRhtnmRDDY
 LRmYDktCkcooRnZGhKn0wx63KcBvQXM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-FT5oi6NUPxSPoVeXSOTDnQ-1; Thu, 05 Jun 2025 06:15:48 -0400
X-MC-Unique: FT5oi6NUPxSPoVeXSOTDnQ-1
X-Mimecast-MFC-AGG-ID: FT5oi6NUPxSPoVeXSOTDnQ_1749118547
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f55ea44dso369202f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118546; x=1749723346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyKz6nWErMiubgubQFr6FKvLFAmnjsB5MvJF4fUeC4E=;
 b=kRjHV/PnabQMrmlF4t8miaw+h12UQjQcHlNNlefVZasjw/O0VsPrh+LRNc/8V18Rds
 r6lFDbtOW72F8FsuShTCCpgtIejMXXdAfE29mA3edctjw75ZFd+JamrfX29OXZRJa/de
 KOfx5cfYFMEjZcNd/XnDoBa1gEYJ18+HPt0nshQICCNcSaRdquVlaoXAjGiU7la3wY51
 ulRNuMQhhGMQ6kSug8tulHzIl0pkhvhtyKHMCjpR/iUP94PsleGo9HTmsY6p5d4A/JkF
 yc+v2jLaAe2S0jun4fKbrpE34+wSyQ20dgmW5RtRYh4ZzuzF/CE0JTu4AMnEVoLaYwTG
 Tpnw==
X-Gm-Message-State: AOJu0YyhiZoavQbIt7IgZHe1bh0Yt5ye4dtiyz7wYLuCLviYZ2tgIhFf
 bm+tM77RlB5PaprtQHZ7+el1Z5ZQBwdAKFZKJgA75exGOLwQ+n5I/ilmhUre6tjuPu1RzY1SlG3
 QE2kWIEBLVcrWQ9vlzMSMCwmi5q+WIGCR0OfoPVh8Dgf9a00+BxBoRRapMkh8fpJtb44ZhVZYXO
 gcVHwZ8EB8GNIfhqTRsLrFeyRsCU/W8i1zg3StwdDU
X-Gm-Gg: ASbGncuEqiY1mfDMcUw2IYWmjpUH+qT/WTdXVvox67I+2zO763uq0Fva58nFgtNLHuO
 Ys/o7lZvZZ3NbXA24n8UqG1392zLK1D2HN0LuY+jckUH/qs6o3AVC7R6HeyztCMdC1P/q+IUHIO
 kMq7Aa8dsJMlbsFvdiCkDafRn+Y44wc8H8EOKDvqk2tICMrXxLs5JeGVQ8s0Xc2lrG/b3ox3yRJ
 LlEJMwnxN+GqWEWC6xZOWXqzfGihPZAJEJgXeF6Nd5PH0kQOz+Abf3uD2Vb+3V6gJVs3YZY4dU4
 C4erVAe78noRcQ==
X-Received: by 2002:a05:6000:230b:b0:3a4:ca73:75e3 with SMTP id
 ffacd0b85a97d-3a51d8f9ea1mr4995304f8f.12.1749118546462; 
 Thu, 05 Jun 2025 03:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEdukYa7botr0/VdyTX3jqMqLBr7Rz+hpbSnXCUZDyEesLGjcaXT6aEnu8SD6qTpdlxlZszA==
X-Received: by 2002:a05:6000:230b:b0:3a4:ca73:75e3 with SMTP id
 ffacd0b85a97d-3a51d8f9ea1mr4995269f8f.12.1749118545945; 
 Thu, 05 Jun 2025 03:15:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b8f0sm23797310f8f.6.2025.06.05.03.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:15:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH v3 00/14] rust: bindings for Error
Date: Thu,  5 Jun 2025 12:15:29 +0200
Message-ID: <20250605101544.368953-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

As explained for v1, the impetus for this series is to remove BqlCell<>
from HPETState::num_timers.  However, it's also an important step for QAPI:
error propagation is pretty central for example to QMP, and the series
is also a first example of two-way conversion between C and native-Rust
structs (i.e. not using bindgen-generated structs or their opaque wrappers).

The differences from v2 and v3 are:
* documentation
* correctly using error_propagate()
* panicking on errors with no message and no cause

Based-on: <20250603214523.131185-1-pbonzini@redhat.com>

Paolo Bonzini (13):
  subprojects: add the anyhow crate
  subprojects: add the foreign crate
  util/error: expose Error definition to Rust code
  util/error: allow non-NUL-terminated err->src
  util/error: make func optional
  rust: qemu-api: add bindings to Error
  rust: qemu-api: add tests for Error bindings
  rust: qdev: support returning errors from realize
  rust/hpet: change type of num_timers to usize
  hpet: adjust VMState for consistency with Rust version
  hpet: return errors from realize if properties are incorrect
  rust/hpet: return errors from realize if properties are incorrect
  docs: update Rust module status

Zhao Liu (1):
  rust/hpet: Drop BqlCell wrapper for num_timers

 docs/devel/rust.rst                           |   7 +-
 include/qapi/error-internal.h                 |  35 ++
 rust/wrapper.h                                |   1 +
 hw/timer/hpet.c                               |  21 +-
 util/error.c                                  |  20 +-
 rust/Cargo.lock                               |  17 +
 rust/Cargo.toml                               |   1 +
 rust/hw/char/pl011/src/device.rs              |   5 +-
 rust/hw/timer/hpet/src/device.rs              |  62 ++-
 rust/hw/timer/hpet/src/fw_cfg.rs              |   7 +-
 rust/meson.build                              |   4 +
 rust/qemu-api/Cargo.toml                      |   2 +
 rust/qemu-api/meson.build                     |   3 +-
 rust/qemu-api/src/error.rs                    | 416 ++++++++++++++++++
 rust/qemu-api/src/lib.rs                      |   3 +
 rust/qemu-api/src/qdev.rs                     |  10 +-
 scripts/archive-source.sh                     |   5 +-
 scripts/make-release                          |   5 +-
 subprojects/.gitignore                        |   2 +
 subprojects/anyhow-1-rs.wrap                  |   7 +
 subprojects/foreign-0.3-rs.wrap               |   7 +
 .../packagefiles/anyhow-1.0-rs/meson.build    |  33 ++
 .../packagefiles/foreign-0.3-rs/meson.build   |  26 ++
 23 files changed, 628 insertions(+), 71 deletions(-)
 create mode 100644 include/qapi/error-internal.h
 create mode 100644 rust/qemu-api/src/error.rs
 create mode 100644 subprojects/anyhow-1-rs.wrap
 create mode 100644 subprojects/foreign-0.3-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1.0-rs/meson.build
 create mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build

-- 
2.49.0


