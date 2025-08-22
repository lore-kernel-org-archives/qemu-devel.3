Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C936DCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrT-0004ne-9V; Fri, 22 Aug 2025 08:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrP-0004ma-9b
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrK-0002O6-Dw
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ih3TeQsWVbzgbpL3DG1NgNzT/OnGGkYdr8cnBJyUJsI=;
 b=SSdWNhvUIeY1u+EUeEv7iEBOksle7hlicA0JecwgMI1NLzPY/VO8IFcoXhI4c48ywcq6Kh
 yjPqlDPV/bFXHImTq4lTpCkP6oNNhOFhM3s8grpPd4yDRRtj+hfUj+XyAEdhPVLvaXWzqt
 6GfJpYBPvdLk1i2yNRbtFlofw/M3sXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-tnpqz0-HMT-U7p3hcvm8fQ-1; Fri, 22 Aug 2025 08:27:00 -0400
X-MC-Unique: tnpqz0-HMT-U7p3hcvm8fQ-1
X-Mimecast-MFC-AGG-ID: tnpqz0-HMT-U7p3hcvm8fQ_1755865619
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b05d31cso10846865e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865618; x=1756470418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ih3TeQsWVbzgbpL3DG1NgNzT/OnGGkYdr8cnBJyUJsI=;
 b=cAoFt7PoW+LUV3yXKqaHb7pn2PrzaJHOOC6A7R5+4wZ0U+NYf4JJoJDFadr7uNLVH6
 LVlZ6pkSL7XDRNArf0Itl98TMII8M2mRwLLGtG6Nr3HpD6e589wIf3HSxEVbpvr4Ek+t
 q0HcbI99KMAmm6Xx/nR3IPMJo4HAlsoy6/x1JJfa2e7BSsw8RAJqblJBdW+cHVn2wnEd
 2/4gLzUpdUTXcPCocxfGtoFfjsgrc0H1f4mFuYgRH9igDiPSbDZsEydByVmJXwPAbBL0
 yFhFLdGNYmL88j2Ny3RCrBZkoq66sY2njnIX3StOpQH4iJ/IdYbvxnXKaht/RShfNicc
 b4Yg==
X-Gm-Message-State: AOJu0YyCPKxtewKYIG25h8BjxlPp4GA4LBjApfI+ts02a2XLzw4SQLe/
 JPcXxIrH5FAeLR/6zLzZjCTOyN/hSW9HKFo59HnZCRdIP/ebInuCuYivaXP84BBPmhgKhYfU5+Z
 +F7H0qYa8TGWleOq1AjXQc6BMDoJRrQFQLnGpUxVuFxrYTyQwWjk51upRkdc9T9LL56NjYaH/by
 vtDqIA+q2RPttmrV4kQkiVLCJhMw3WDH2vUUepjp80
X-Gm-Gg: ASbGncuO0b5JQZj6USTQF5Rf4bMZiDSTKLCFKYXx//t27wAsyFVbzEAeoEln4Ffhl5X
 01Wj8YLWZY5Q4cXbs9vozrZ5mfjWv1/9CKA1U5iI9lc9avUdYTfyP209tnmbCVUPfQBjMo1gdIH
 9GShDjvFf2+YHUUjbwKW3DdcDShXA4ZO0hxLANMVNKUYqHsxzi5ffkdgWdX9NW7TS2rq2y1I7lx
 +CHImX8fv9sGDYHPRD8PhULwTYxy4kHEufMgjdcaeU/3eZjZmK5DI8TYpyDd/D/vF34/AGpzKrp
 8jGngpBE86VfG7nRE7cAg/jJxCmB4pRlg791gVr3TmSevwLmAGZDFUI1VQy4IkVg9Wy813ZUARK
 Dg0ks3Rpb/88eTeQWMs+hGxUN+IKEyGcvtIIvLuJ7RQ==
X-Received: by 2002:a05:600c:a344:b0:459:443e:b180 with SMTP id
 5b1f17b1804b1-45b51f30f97mr23833615e9.8.1755865618397; 
 Fri, 22 Aug 2025 05:26:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpHWt1iViDpgZe9rM+O2LuN6tlKn3tIOEgUT5Mf9BlloTWvvCDzQcet10zFmXDCoxM7VyAGw==
X-Received: by 2002:a05:600c:a344:b0:459:443e:b180 with SMTP id
 5b1f17b1804b1-45b51f30f97mr23833295e9.8.1755865617797; 
 Fri, 22 Aug 2025 05:26:57 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50e3a323sm34281125e9.17.2025.08.22.05.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:26:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [RFC PATCH 00/14] tracetool: add Rust support
Date: Fri, 22 Aug 2025 14:26:41 +0200
Message-ID: <20250822122655.1353197-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the result of the summer project of Tanish Desai.  It mostly
consists of changes to tracetool, which I used to add tracepoint support
to the pl011 device.  All the backends are supported except dtrace and
ust; support for Linux in dtrace should be easy using the "probe" crate,
the rest (ust, and dtrace on macOS or Solaris) less so.

Patches 1-2 are cleanups that could be committed separately.

Patches 3-5 are tracetool patches that have been posted before, now
rebased on top of the "make check-tracetool" series.  Their purpose
is to simplify .h code generation for tracetool backends, and these
simplifications translate directly to the new .rs code generation.

Patches 6-7 add the minimal support for adding tracepoint functions
in Rust, albeit with no content and thus no actual tracing.

Patches 8-9 add back tracepoints to the Rust pl011 device model.

Patches 10-14 finally add Rust code generation to the supported
tracing backends.

Many thanks to Daniel for his tracetool testsuite.  It was very
useful and did indeed improve reviewability!

Paolo

Based-on: <20250819161053.464641-1-berrange@redhat.com>

Paolo Bonzini (6):
  treewide: write "unsigned long int" instead of "long unsigned int"
  rust: move dependencies to rust/Cargo.toml
  trace/ftrace: move snprintf+write from tracepoints to ftrace.c
  rust: qdev: add minimal clock bindings
  rust: pl011: add tracepoints
  log: change qemu_loglevel to unsigned

Tanish Desai (8):
  tracetool: add CHECK_TRACE_EVENT_GET_STATE
  tracetool/backend: remove redundant trace event checks
  tracetool: Add Rust format support
  rust: add trace crate
  tracetool/simple: add Rust support
  tracetool/log: add Rust support
  tracetool/ftrace: add Rust support
  tracetool/syslog: add Rust support

 include/qemu/log-for-trace.h          |   4 +-
 include/qemu/log.h                    |  44 ++++----
 rust/qemu-api/wrapper.h               |   1 +
 tests/tracetool/ftrace.h              |  28 +----
 tests/tracetool/log.h                 |  16 ++-
 trace/ftrace.h                        |   1 +
 crypto/pbkdf-gcrypt.c                 |   2 +-
 crypto/pbkdf-gnutls.c                 |   2 +-
 crypto/pbkdf-nettle.c                 |   2 +-
 hw/display/exynos4210_fimd.c          |   2 +-
 hw/misc/imx7_src.c                    |   4 +-
 hw/net/can/can_sja1000.c              |   4 +-
 trace/ftrace.c                        |  15 +++
 util/log.c                            |   2 +-
 hw/char/trace-events                  |  14 +--
 hw/xen/trace-events                   |   4 +-
 rust/Cargo.lock                       |   8 ++
 rust/Cargo.toml                       |   6 +
 rust/hw/char/pl011/Cargo.toml         |   1 +
 rust/hw/char/pl011/meson.build        |   1 +
 rust/hw/char/pl011/src/device.rs      |  57 +++++++---
 rust/meson.build                      |   2 +-
 rust/qemu-api/Cargo.toml              |   6 +-
 rust/qemu-api/src/log.rs              |   2 +-
 rust/qemu-api/src/qdev.rs             |  33 ++++++
 rust/trace/Cargo.toml                 |  19 ++++
 rust/trace/meson.build                |  19 ++++
 rust/trace/src/lib.rs                 |  27 +++++
 scripts/tracetool/__init__.py         | 156 ++++++++++++++++++++++++++
 scripts/tracetool/backend/__init__.py |  39 +++++--
 scripts/tracetool/backend/ftrace.py   |  24 ++--
 scripts/tracetool/backend/log.py      |  20 ++--
 scripts/tracetool/backend/simple.py   |  15 ++-
 scripts/tracetool/backend/syslog.py   |  15 +--
 scripts/tracetool/format/h.py         |  11 +-
 scripts/tracetool/format/rs.py        |  76 +++++++++++++
 tests/tracetool/ftrace.rs             |  41 +++++++
 tests/tracetool/log.rs                |  45 ++++++++
 tests/tracetool/simple.rs             |  41 +++++++
 tests/tracetool/syslog.rs             |  41 +++++++
 tests/tracetool/tracetool-test.py     |   2 +
 trace/meson.build                     |   8 +-
 42 files changed, 718 insertions(+), 142 deletions(-)
 create mode 100644 rust/trace/Cargo.toml
 create mode 100644 rust/trace/meson.build
 create mode 100644 rust/trace/src/lib.rs
 create mode 100644 scripts/tracetool/format/rs.py
 create mode 100644 tests/tracetool/ftrace.rs
 create mode 100644 tests/tracetool/log.rs
 create mode 100644 tests/tracetool/simple.rs
 create mode 100644 tests/tracetool/syslog.rs

-- 
2.50.1


