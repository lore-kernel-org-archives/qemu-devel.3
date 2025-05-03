Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A448FC3ABAD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 07:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mH-00083p-5V; Sat, 03 May 2025 03:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mC-00082j-42
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7m9-0006bz-4e
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jeYJjnFtTENIkLESDSV7ilHvdJgjKlyq/qrHzh9J9dI=;
 b=hw9tvkeESpuc48Iv+SVgjPh41/kmYd+Iv7bY10FWdEJ5mol4FUaBdeguoRE6og9TSRt1/7
 YHqsk7TaLy3hBpNWcA6ZRqtsyQ3YcrkZ0Z65Ru6Hg2swmUu6JnI5X/1xZKz2+9VI/QJ1Lh
 Ky9Pf/fNq7B78zzPRf2C7Jzp3fI1SgA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-K8-m3nJuOjyUbeL3Bx9-YA-1; Sat, 03 May 2025 03:59:02 -0400
X-MC-Unique: K8-m3nJuOjyUbeL3Bx9-YA-1
X-Mimecast-MFC-AGG-ID: K8-m3nJuOjyUbeL3Bx9-YA_1746259141
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so20804315e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259141; x=1746863941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jeYJjnFtTENIkLESDSV7ilHvdJgjKlyq/qrHzh9J9dI=;
 b=H0U2PCIb9Ym1dj3DpZs2luSUPiTil3fm5TOnCgXG/OtLipZUcGG03PfNXcsWN1Iu1T
 OUCCliwUVj06ymVxRdDycsr26Wu4SUHXX2xmYWxtu9+pPMOkm6o6v7Ek4z9O4OfV3uOW
 rVAmqpoUa7ek7GasQmiHVg9XTPDPMNiSQJKloggcqR7kQ5vkjVdlNYMZJ/kw3J63k0N8
 iv7Enu0UuutQ3KxNFNbI3FZ7YFDfHiE1LC+0K3LZzHV8KbhjbSA1n22QWOUwqoaB+CNT
 gRHaZ5rRxk5ANNP4qkqQx8WCxrW5bhjKpB9DR+QkwygXiVpilxMQFawMa5w2RUMKEFFM
 /VwQ==
X-Gm-Message-State: AOJu0Yzmq3kh81tUuJdRXbAPiJebWcnTxg2iZ/cVt6RYHmMnDf+yl6JB
 dVH4UXkPndjp2dutZQLF9sym71/JBm3PzV0bKkQbsY1vw+IzafZ8UB+uItH0vHbEzzaahS3bNJJ
 Z9hPhz7ljXQCP99wd21byKqky16ASqOHUGm4vTTUTIrfzPHvHLs+vgdVrLqslmKd8eKjpay6PQa
 9wN0Y6viHQc0XuouC16lHGZYvhxZr6pU4PD9jx
X-Gm-Gg: ASbGncsdx2VhxS+xsUOtfSGDzIdy4/182sWxTUanACLBhs+1kFioDGIwGOkYcZ86fE7
 jthmwKUlbuBlOHal7B7saGjslNZCJE45SQOGLMurBtXaQe8QHkHO5zD+c80UYivMfqfQ2h7T9Bv
 PemPeIvbBFYq4qPdaEyEiwC3Q4KSDwO+RXFCgIYAOGhY9ZawDu47L78ALYjlGtv+XrP7vY+h8IX
 rj5WBZBd7anb4wR/S946LWbd+KEGYgNFfRIhQNaA3RCrM8v8H5JzYJc0pgdAPb3Qrjp66WlTsVb
 Beh8HxpGUgrhGrY=
X-Received: by 2002:a05:600c:3b85:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-441c1cc41admr13092385e9.7.1746259140722; 
 Sat, 03 May 2025 00:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoX4X2r00OjdiIVLiLM9QDmIgWSVVVQM3w01nZEocGquttJzAaYwzLP0OZqtHZ+c0uhsG7og==
X-Received: by 2002:a05:600c:3b85:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-441c1cc41admr13092265e9.7.1746259140298; 
 Sat, 03 May 2025 00:59:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20aa6sm114066015e9.27.2025.05.03.00.58.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:58:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] Rust, i386 changes for 2025-05-03
Date: Sat,  3 May 2025 09:58:45 +0200
Message-ID: <20250503075858.277375-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073cf:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-04-30 13:34:44 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 03f50d7ee756eecbd4481c3008b5e01e999729c7:

  monitor: don't wake up qmp_dispatcher_co coroutine upon cleanup (2025-05-02 23:51:30 +0200)

----------------------------------------------------------------
* rust: support migration of HPET device
* target/i386/hvf: fix compilation errors
* target/i386/tcg: fix some interrupt shadow cases
* hw/char/serial: remove unused prog_if compat property
* rust: centralize config in workspace root
* monitor: fix race on exiting QEMU

----------------------------------------------------------------
Andrey Drobyshev (1):
      monitor: don't wake up qmp_dispatcher_co coroutine upon cleanup

BALATON Zoltan (1):
      hw/char/serial: Remove unused prog_if compat property

Magnus Kulke (1):
      target/i386/emulate: remove rflags leftovers

Paolo Bonzini (4):
      vmstate: support varray for vmstate_clock!
      rust: assertions: Support index field wrapped in BqlCell
      target/i386: do not trigger IRQ shadow for LSS
      target/i386: do not block singlestep for STI

Stefan Zabka (1):
      rust: centralize config in workspace root

Wei Liu (1):
      target/i386/hvf: fix a compilation error

Zhao Liu (4):
      rust/vmstate: Add support for field_exists checks
      rust/vmstate_test: Test varray with num field wrapped in BqlCell
      rust/timer: Define NANOSECONDS_PER_SECOND binding as u64
      rust/hpet: Support migration

 docs/devel/rust.rst                  |   3 +-
 hw/char/diva-gsp.c                   |   6 +-
 hw/char/serial-pci-multi.c           |   7 +-
 hw/char/serial-pci.c                 |  10 +--
 monitor/qmp.c                        |   3 +-
 target/i386/emulate/x86_decode.c     |  17 ++--
 target/i386/hvf/hvf.c                |   1 +
 target/i386/tcg/translate.c          |  33 +++++---
 target/i386/tcg/emit.c.inc           |   4 +-
 rust/Cargo.toml                      |   7 ++
 rust/hw/char/pl011/Cargo.toml        |  11 +--
 rust/hw/timer/hpet/Cargo.toml        |   9 ++-
 rust/hw/timer/hpet/src/hpet.rs       | 146 ++++++++++++++++++++++++++++++++++-
 rust/qemu-api-macros/Cargo.toml      |  11 +--
 rust/qemu-api/Cargo.toml             |  15 ++--
 rust/qemu-api/src/assertions.rs      |  25 +++---
 rust/qemu-api/src/timer.rs           |   2 +
 rust/qemu-api/src/vmstate.rs         |  83 +++++++++++---------
 rust/qemu-api/tests/vmstate_tests.rs |  41 ++++++++--
 19 files changed, 307 insertions(+), 127 deletions(-)
-- 
2.49.0


