Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BECC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYjW-0002GN-3e; Mon, 26 May 2025 10:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYjK-0002FO-3H
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYjG-0007Vd-73
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bxqeLQVo0Kujn36yDQudboPctz4ZtJ/9EVd+TOLjtVs=;
 b=eULhoSJgYwKBorUNVy3fxD2W8BiFsHY+tXsouq37faZruu+FypTTs0KI1C4fIT0p1cSqC3
 fDeqI/SZEN1KhD2jgfztE85VJF4N/oDJJn/vIqQe5kBEgteV1aqlgzgqsMU3wDv03vH2rm
 Gk67OroQ9bO0qqwpjwyRgey5Ym54nys=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-rzWMJkp3Pn-DEojKl0c_gw-1; Mon, 26 May 2025 10:22:57 -0400
X-MC-Unique: rzWMJkp3Pn-DEojKl0c_gw-1
X-Mimecast-MFC-AGG-ID: rzWMJkp3Pn-DEojKl0c_gw_1748269377
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso844482f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269376; x=1748874176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxqeLQVo0Kujn36yDQudboPctz4ZtJ/9EVd+TOLjtVs=;
 b=i487sNufjvLFAHY/RVNEhzt01cjutwF6kA9f9oE3+zd8VerV5LQ/05kS5tjOA44QSl
 8MmlcJgyIppnxwohbhEiTGPFuyJeWLEywZeFjDfXQZq0ssHiWcgH/cGZPuLpkV4fMjsO
 pgK5NTXFfO+9x5QMVsc3NRH+YxqZfmQVWp3RRonL4M/GNFEYP5yc4FnWt0fnRC6lzCup
 2PC48Wc1kI3ssqaz3nJdzDKmN9Kj4oiGa5yf412DE7mC8UmIJ9cIL11kDdQCY7bezLvT
 kLFXHMtp7w0f1/Ac7HOKgqMGIDwz5pvue7Qp5SCblI09R63MMyYZJwGrV2eS8njSG7VK
 7O5Q==
X-Gm-Message-State: AOJu0YxTP0p4RSuZMQQHAtmL1gNWd2x3z7CDnkHgCZ9SsJLOCfVNrXSY
 IoGSVVtVH+7UusAv+oAupSeoCQbSytsC5DLmhbEn1vDtEQ0LJV28bCixZeE0PvXY7SqR+H8A5BO
 ODcZiUZYDIHoB5gTLxlzcIji6Z1eCSjaeBpn40V5ld1SC1Ninv6R/Q0mAx2NMN6Hibj2BqPD52V
 Hacxj2aaX1ElqpmU+diggc6lFAJVQyzwcUmMJe9bnC
X-Gm-Gg: ASbGncuJsQ9I7H2qh9J609PDv+QgS8Y2ju/i1iKhM7/EbJeliahbPex/zCQVegQGeDr
 ozxupxjBYmDLG+T+z/htLk2htZn7pE5lLgcWuZDj/Zo3wqV5ygBt+9T8hpFSsNv8uyLJCRMxdbp
 pnw/2Gzrrrqkn740xaJW27tTNiXrg2iUE0EQgGEkDlwYZwb69osgcziavf+r+OPoTwuWhFgP0ww
 bSxXuo8v8QbDOHm7J5D6PWI1Sth8LCqtz7BeSwCM2oP0scwvJ5uuL3sPFMxTSXngKkrr/eq/+l7
 g86yA2iEz9iymA==
X-Received: by 2002:a05:6000:288a:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3a4ddde1605mr1611347f8f.58.1748269376299; 
 Mon, 26 May 2025 07:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEipE+xjfIR3h8GU+SFkEC155OoBGi7oAMHcd52anCIJBBRtukxUVqn30Rgr2Ti0l2JLt+3mg==
X-Received: by 2002:a05:6000:288a:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3a4ddde1605mr1611326f8f.58.1748269375839; 
 Mon, 26 May 2025 07:22:55 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c7afa815sm9340890f8f.63.2025.05.26.07.22.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:22:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] rust: bindings for Error
Date: Mon, 26 May 2025 16:22:42 +0200
Message-ID: <20250526142254.1061009-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This was one of the first bindings that I wrote in
https://lore.kernel.org/qemu-devel/20240701145853.1394967-1-pbonzini@redhat.com/T/,
but there were a few obstacles to clear before including them:

1) cleaning up the *foreign*() functions (patches 3-4 from the above
series) or deciding not to use them.  The functions are now part of
their own crate, available on crates.io and imported in this series.
For this series I am including them, but if people prefer to stick
to "normal" Rust FFI I'm open to that as well.

2) cleaning up the "cause" member.  This series uses the anyhow
crate instead of Box<dyn std::error::Error>.

3) cleaning up &error_abort, because Rust does not have a NULL-terminated
filename and does not have an equivalent to __func__ at all.  The
preliminary code did not pass file and line at all, while now I am
using #[track_caller] and making the C code collaborate with Rust
(see patches 5-6 of the series).

The final driver for fixing all this was to enable the removal
of BqlCell<> from HPETState::num_timers.

Integration tests for the new class are still missing.

Markus... this is your first exposure to Rust in QEMU.  You may find some
information at https://www.qemu.org/docs/master/devel/rust.html but just
to be clear, there are no stupid questions, only stupid answers. :)

Paolo

Paolo Bonzini (12):
  rust: make declaration of dependent crates more consistent
  subprojects: add the anyhow crate
  subprojects: add the foreign crate
  util/error: expose Error definition to Rust code
  util/error: allow non-NUL-terminated err->src
  util/error: make func optional
  qemu-api: add bindings to Error
  rust: qdev: support returning errors from realize
  rust/hpet: change timer of num_timers to usize
  hpet: return errors from realize if properties are incorrect
  rust/hpet: return errors from realize if properties are incorrect

Zhao Liu (12):
  rust/hpet: Drop BqlCell wrapper for num_timers

 include/qapi/error-internal.h                 |  27 ++
 rust/wrapper.h                                |   1 +
 hw/timer/hpet.c                               |  15 +-
 util/error.c                                  |  24 +-
 rust/Cargo.lock                               |  17 ++
 rust/Cargo.toml                               |   1 +
 rust/hw/char/pl011/meson.build                |  12 +-
 rust/hw/char/pl011/src/device.rs              |   5 +-
 rust/hw/timer/hpet/src/fw_cfg.rs              |   7 +-
 rust/hw/timer/hpet/src/hpet.rs                |  62 ++--
 rust/meson.build                              |  20 ++
 rust/qemu-api-macros/meson.build              |  14 +-
 rust/qemu-api/Cargo.toml                      |   2 +
 rust/qemu-api/meson.build                     |   5 +-
 rust/qemu-api/src/error.rs                    | 273 ++++++++++++++++++
 rust/qemu-api/src/lib.rs                      |   3 +
 rust/qemu-api/src/qdev.rs                     |  10 +-
 subprojects/.gitignore                        |   2 +
 subprojects/anyhow-1.0-rs.wrap                |   7 +
 subprojects/foreign-0.2-rs.wrap               |   7 +
 .../packagefiles/anyhow-1.0-rs/meson.build    |  33 +++
 .../packagefiles/foreign-0.2-rs/meson.build   |  26 ++
 22 files changed, 488 insertions(+), 85 deletions(-)
 create mode 100644 include/qapi/error-internal.h
 create mode 100644 rust/qemu-api/src/error.rs
 create mode 100644 subprojects/anyhow-1.0-rs.wrap
 create mode 100644 subprojects/foreign-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1.0-rs/meson.build
 create mode 100644 subprojects/packagefiles/foreign-0.2-rs/meson.build

-- 
2.49.0


