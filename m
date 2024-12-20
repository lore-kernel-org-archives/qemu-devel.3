Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A89E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe15-0004Ku-DL; Fri, 20 Dec 2024 09:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe12-0004KR-E1
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe10-0005gm-6A
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7VjbDovra7r9p6yXDbMrRyvB5sFdSrgSFuI+Vz3h+9A=;
 b=fn/3vh6+HaOHPWVeOwVFX3WvL1SQr9TLBLDAIPIMg2RY1QuqTZc+RsS7IpTS0OzpqJXoVm
 pQa2RNIV5NTV2e1gD/Zl7KoKgNRAIRO/UICgQsWQ5q4TJktaa+K5SZyP702Z00r5gfOvCy
 uPpVgInHASGL888n+qpwXEcCRLp+D8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-jbmkpD94NFW8m8hx1S5U2g-1; Fri, 20 Dec 2024 09:29:59 -0500
X-MC-Unique: jbmkpD94NFW8m8hx1S5U2g-1
X-Mimecast-MFC-AGG-ID: jbmkpD94NFW8m8hx1S5U2g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43635895374so15423975e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734704997; x=1735309797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VjbDovra7r9p6yXDbMrRyvB5sFdSrgSFuI+Vz3h+9A=;
 b=INIAUe4dWMnqp8rH8ZN4/j0QdE+LVKhenLH9IMSx9MK0oWBMkAtXB6k6lwySZNNpjQ
 Fui8rAcOCPw1VzJJvwqVmacdVIwMsade2jPwB0DMTITi+9HkLYgYllAtjb+UOEd69qlq
 tP1IFaHHjJ+HkjizUW0mrA8WaHoNTcHNey1QvvvCB/OEts8Rm4c5JnXTvp6nqsNfx5TA
 Y+uQncm0gXH4FhfMzow+XICzWyAMXN91cvaumxwwNkrPk4Wt8EZIDXWvummCVwpBe4xx
 En8SIqFog8xnO9fpb7sboV3XE1zwVsq0VcyElHU3AG13AFIICM5a57U8A5E80DIqYt5I
 y3fA==
X-Gm-Message-State: AOJu0Yz9Xu4dyLbP5+7x8e4AY++IU1dXEVV2aO9wUUx+L0yjTygUiBEK
 8tjwlGTfRehiUgmjS54jj/eAAILFnuwiwT/BjLSSElTiThZQkT/Kgj+hZX94+XHdP/G+VY2iwFu
 2HbPWjNZ0MsgQHCLaFrbAfq7JwawLzrTR3Uvk3b41ZQKPjxGid380NLL8vsC3Fz2ccTt4JgZIle
 d9UlUuRNP3uC7eJ9UOp+GP9A9cDjdXyY2PtCIG
X-Gm-Gg: ASbGncv98ntJ0MxfHwNyTS5nrfHSIHEkfaNywGt+555InKWfwdykzDIHfxstjECadFI
 MEHPr/mVc9wbjYn+fmVHwaNY0rmBwwJAe2+m5CH+Y+KY1modkpmSX+u/k1rgUeGZrOYWk05t5Iu
 B0/aWBlNrGfnliPKCm1dyP3cWYaAmA9I3KW4as5EtPg68LIs+F5qdLziSMnwMQqzFquSrx7aRyK
 V5MTGHtjoR8t9R/MLeJv2UGVzX9DaYLOvUfAO/MXGb/w3VO41a2ET/4qmqE
X-Received: by 2002:a05:6000:2202:b0:385:e90a:b7de with SMTP id
 ffacd0b85a97d-38a229ec5a5mr3102640f8f.5.1734704996990; 
 Fri, 20 Dec 2024 06:29:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPBBC5hHabAkZp0rlfFa7fRRsBaGMABMSFJ5AbeqkFTWaFnsiYT9cfBUqqPrV88h2F0MOh5w==
X-Received: by 2002:a05:6000:2202:b0:385:e90a:b7de with SMTP id
 ffacd0b85a97d-38a229ec5a5mr3102612f8f.5.1734704996445; 
 Fri, 20 Dec 2024 06:29:56 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828e3fsm4241860f8f.5.2024.12.20.06.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:29:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 00/12] Next round of qemu_api patches
Date: Fri, 20 Dec 2024 15:29:42 +0100
Message-ID: <20241220142955.652636-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

This includes:

1) the outcome of reviewing
   https://lore.kernel.org/qemu-devel/20241209123717.99077-1-pbonzini@redhat.com/T/,
   especially with respect to instance_finalize implementation and
   Rust-defined subclasses (patches 1-6)

2) the beginnings of separating instance_init/instance_post_init, making
   the latter take &self (patches 7-9)

3) extracting pl011's logic to convert an integer into an enum into a
   #[derive(TryInto)] procedural macro (patches 10-11)

4) a one-off change that I noticed while reading Cargo documentation
   (patch 12)

Zhao: I have placed these in rust-next, but feel free to ignore them for
your next HPET submission.  I have also included in my tree your test
additions for usage in CI, but I'm not including them here to give you
the opportunity to post them with a commit message and a signed-off-by.
If you don't have time, it's in safe hands. :)

Paolo

Paolo Bonzini (12):
  rust: qom: add ParentField
  rust: add a utility module for compile-time type checks
  rust: macros: check that the first field of a #[derive(Object)] struct
    is a ParentField
  rust: macros: check that #[derive(Object)] requires #[repr(C)]
  rust: qom: automatically use Drop trait to implement instance_finalize
  rust: qom: move device_id to PL011 class side
  rust: pl011: only leave embedded object initialization in
    instance_init
  rust: qom: make INSTANCE_POST_INIT take a shared reference
  rust: qdev: expose inherited methods to subclasses of SysBusDevice
  rust: qemu-api-macros: extend error reporting facility to parse errors
  rust: qemu-api-macros: add automatic TryFrom/TryInto derivation
  rust: hide warnings for subprojects

 rust/hw/char/pl011/src/device.rs              |  79 +++++----
 rust/hw/char/pl011/src/lib.rs                 |  28 +---
 rust/qemu-api-macros/src/lib.rs               | 150 +++++++++++++-----
 rust/qemu-api-macros/src/utils.rs             |  26 +++
 rust/qemu-api/meson.build                     |   1 +
 rust/qemu-api/src/assertions.rs               |  90 +++++++++++
 rust/qemu-api/src/irq.rs                      |   3 +-
 rust/qemu-api/src/lib.rs                      |   1 +
 rust/qemu-api/src/prelude.rs                  |   2 +
 rust/qemu-api/src/qom.rs                      |  77 +++++++--
 rust/qemu-api/src/sysbus.rs                   |  23 ++-
 rust/qemu-api/tests/tests.rs                  |   4 +-
 subprojects/arbitrary-int-1-rs.wrap           |   3 +
 subprojects/bilge-0.2-rs.wrap                 |   3 +
 subprojects/bilge-impl-0.2-rs.wrap            |   3 +
 subprojects/either-1-rs.wrap                  |   3 +
 subprojects/itertools-0.11-rs.wrap            |   3 +
 .../arbitrary-int-1-rs/meson.build            |   1 +
 .../packagefiles/bilge-0.2-rs/meson.build     |   1 +
 .../bilge-impl-0.2-rs/meson.build             |   1 +
 .../packagefiles/either-1-rs/meson.build      |   1 +
 .../itertools-0.11-rs/meson.build             |   1 +
 .../proc-macro-error-1-rs/meson.build         |   1 +
 .../proc-macro-error-attr-1-rs/meson.build    |   1 +
 .../packagefiles/proc-macro2-1-rs/meson.build |   1 +
 .../packagefiles/quote-1-rs/meson.build       |   1 +
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 .../unicode-ident-1-rs/meson.build            |   1 +
 subprojects/proc-macro-error-1-rs.wrap        |   3 +
 subprojects/proc-macro-error-attr-1-rs.wrap   |   3 +
 subprojects/proc-macro2-1-rs.wrap             |   3 +
 subprojects/quote-1-rs.wrap                   |   3 +
 subprojects/syn-2-rs.wrap                     |   3 +
 subprojects/unicode-ident-1-rs.wrap           |   3 +
 subprojects/unicode-ident-1-rs/meson.build    |  20 ---
 35 files changed, 402 insertions(+), 146 deletions(-)
 create mode 100644 rust/qemu-api-macros/src/utils.rs
 create mode 100644 rust/qemu-api/src/assertions.rs
 delete mode 100644 subprojects/unicode-ident-1-rs/meson.build

-- 
2.47.1


