Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8123DC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYT0-0005LB-JN; Mon, 12 May 2025 15:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYSz-0005L2-3T
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYSw-0007TR-7g
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/lv1O+Ic+miCqVDpB+5Xdy095FdO5xc4IkFRnyXMrgQ=;
 b=gqzuX60cuzbBYqTK7otQOmNAUIY13PyMNmiK9dwhyeCEAkOHREG31Sf0IhZ3lMjo7l0cwo
 vsJAq7pyvfUCtYQLsStyB8SKJvsYyWGdawj1/pIE8yUm3ldH2cWiwDad2G1/SVT+DFFG9x
 GYo+NToHE8D1RQu+Hw1FC0nqhceOBrA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-bm0qt9mjNymGn2FKCeUNfw-1; Mon, 12 May 2025 15:05:27 -0400
X-MC-Unique: bm0qt9mjNymGn2FKCeUNfw-1
X-Mimecast-MFC-AGG-ID: bm0qt9mjNymGn2FKCeUNfw_1747076727
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a205227595so675186f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076726; x=1747681526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/lv1O+Ic+miCqVDpB+5Xdy095FdO5xc4IkFRnyXMrgQ=;
 b=eo3rIh01xGkiRFNc2VHSSaNOmKXXKdSiq8teveuJ713fYa2+FJx3ETciHgMdrPLcjW
 MftkKBfp+iHYuCyUr/HWX14u0luIcFRx/hJ9XRq7PL19d9VB/QpQvBrO2MAtVqOQ7JiZ
 vbnAkoyAbcQJ2MCaiyaSzKVynrgU+xaI7ShBOXOLGugM95LBXuWMZxQUJwROX+Th4Q1d
 a0no5OSgzulEniNCw4X8EAdJaC8W+chFSFAD4NkQdK2t0O4E0G8lW4UMeiLocw3pFqOg
 YRc2ztc9lyU0p6sohjXgy5gGt43+ArrsgfH/FpheGZ0w5hZ5TEdv5RXmsWHzET5M1dCy
 icXQ==
X-Gm-Message-State: AOJu0YwvGOH+O8ijNLXVydQticolcrPNP1jsgIAdJRQEBC4kvsEvXxF1
 PgT6X3Bos+EWgZxHNZc7o8+JeHRk161jp4vtp6WYFPrZz/u8stYbl+iBqsDIKCxpCl+zsnMTuBd
 rZUfkYtX3RA2vjFpIVrGPpaEbTQ161y/LSoQIWC4TctWc5Ovt3AyBNkSmCBlgHm5SFES86V5JFZ
 tX251au6NzA1OTKfDs3dyffGgVHdh4ywyXPFTh
X-Gm-Gg: ASbGncut8PLvMFyPqNLR3eOYqooB7ll5yZ6RdG+KnHntwIw1hthdjycqRgoRYmKoh6e
 9BX2tFXcNFJp5UgWyRJ9DqXtOLTfotF7VNQ8ddS4xAX+MTdouj802F+61KciqRiH5OjKrkjTfVC
 gkpM1kmIILAty3KAzfrr6WaYwu+8OxU49ks/gC1QC0s/RBGf0abX12BJT2chV4ZCAug7p/Pbywx
 Gn+xjtWjaAGdz4V+DBsuSFPiEfJEXrMsS5nNYZqf6r2S7kkLbaLj6JxBSmKMZ4xKl6aUGkV7ghA
 OiFJYxDsUUvz8gU=
X-Received: by 2002:a05:6000:4304:b0:3a0:b294:ccf2 with SMTP id
 ffacd0b85a97d-3a1f649cc02mr12657075f8f.52.1747076725860; 
 Mon, 12 May 2025 12:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdQGsBoAkKxXYBSTjmTkRuRT74mhDAvhFAnfrU5xT5odj4S2V59k4lx+HCw5aUU4g3/y3Xew==
X-Received: by 2002:a05:6000:4304:b0:3a0:b294:ccf2 with SMTP id
 ffacd0b85a97d-3a1f649cc02mr12657054f8f.52.1747076725342; 
 Mon, 12 May 2025 12:05:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d30asm13306247f8f.76.2025.05.12.12.05.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Meson, x86, Rust patches for 2025-05-12
Date: Mon, 12 May 2025 21:05:08 +0200
Message-ID: <20250512190524.179419-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 7be29f2f1a3f5b037d27eedbd5df9f441e8c8c16:

  Merge tag 'pull-vfio-20250509' of https://github.com/legoater/qemu into staging (2025-05-09 12:04:35 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 74978391b2da0116b9109d52931f342118d5a122:

  target/i386: Make ITS_NO available to guests (2025-05-12 21:02:51 +0200)

----------------------------------------------------------------
* meson: small old patches (one from 2022)
* rust: pl011: forward port some changes from C version
* target/i386: small improvements to TCG emulation
* target/i386: HVF emulation cleanups
* target/i386: add its_no feature
* cs4231a: fix assertion failure
* update Linux headers

----------------------------------------------------------------
Paolo Bonzini (14):
      meson: drop --enable-avx* options
      meson: do not check supported TCG architecture if no emulators built
      meson: remove unnecessary dependencies from specific_ss
      modinfo: lookup compile_commands.json by object
      rust: pl011: Rename RX FIFO methods
      rust: pl011: Really use RX FIFO depth
      target/i386: ignore misplaced REX prefixes
      target/i386: list TCG-supported features for CPUID[80000021h].EAX
      target/i386: move push of error code to switch_tss_ra
      target/i386: implement TSS trap bit
      target/i386/emulate: stop overloading decode->op[N].ptr
      target/i386/emulate: mostly rewrite flags handling
      target/i386: remove lflags
      linux-headers: update from 6.15 + kvm/next

Pawan Gupta (1):
      target/i386: Make ITS_NO available to guests

Zheng Huang (1):
      hw/audio/cs4231a: fix assertion error in isa_bus_get_irq

 docs/devel/rust.rst              |   2 +-
 meson.build                      |  54 ++++++-----
 linux-headers/asm-x86/kvm.h      |  71 ++++++++++++++
 linux-headers/linux/kvm.h        |   1 +
 target/i386/cpu.h                |   6 --
 target/i386/emulate/x86_decode.h |   9 +-
 target/i386/emulate/x86_emu.h    |   8 +-
 target/i386/emulate/x86_flags.h  |  12 +--
 hw/audio/cs4231a.c               |   4 +
 target/i386/cpu.c                |  21 ++++-
 target/i386/emulate/x86_decode.c |  74 +++++++--------
 target/i386/emulate/x86_emu.c    | 123 ++++++++++++------------
 target/i386/emulate/x86_flags.c  | 198 ++++++++++++++++-----------------------
 target/i386/tcg/seg_helper.c     |  81 +++++++++-------
 target/i386/tcg/decode-new.c.inc |  36 +++++--
 accel/tcg/meson.build            |   2 +-
 meson_options.txt                |   4 -
 rust/hw/char/pl011/src/device.rs |  25 +++--
 scripts/meson-buildoptions.sh    |   6 --
 scripts/modinfo-collect.py       |  23 +++--
 tcg/meson.build                  |   2 +-
 ui/meson.build                   |   3 -
 22 files changed, 423 insertions(+), 342 deletions(-)
-- 
2.49.0


