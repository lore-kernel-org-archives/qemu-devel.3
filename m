Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460FEC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEF-0001eX-MA; Fri, 21 Mar 2025 14:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEB-0001So-HA
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhE8-000717-PV
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WIiFgnINXZ71uyJxAf0X6x5Y4veC8fFS8XnwmF9Y+SM=;
 b=aVpH7lZLkRZE/gYwhmlBMWn6+YE8tlD8ld40jklCbz7f8W2+ju/ywkvnZJmU8IYvdPTycZ
 vwlH4m/yNAvvKOC1YY4bajq7oSXXTzWlnQpRw7Y+fSbjSkuHVPoitS9Z6hNCKtaU2BW6gT
 TVgxDlLfmJPWmVnhA8UfBUbMgurP0ks=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-8zj7dEEPOdiCt1fAsTizsw-1; Fri, 21 Mar 2025 14:36:07 -0400
X-MC-Unique: 8zj7dEEPOdiCt1fAsTizsw-1
X-Mimecast-MFC-AGG-ID: 8zj7dEEPOdiCt1fAsTizsw_1742582166
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so11107655e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582165; x=1743186965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WIiFgnINXZ71uyJxAf0X6x5Y4veC8fFS8XnwmF9Y+SM=;
 b=UdbCgL3xYLN0kMfTfXS3ZjcM+Au0RRCeN7WHRgPaI8jwtdyujvbMD0Yh2Gdo80fKJ/
 qsSorSGsZzU0j8Ns8l9VX1ANzC5nxZ7k4v/t54ZU+XGVDhE0HQ8LRG5EHHci0i3hZtPQ
 0K1jCl/tpyKAoI7PrIenhHmTYWRdD+j34zb9MVN5IDlVx0HiXxxt8KS1LRTq2cg2Ompg
 hwFhqp44spZy8xaSPy0jqXBu2dIPUP9iT4XLSJ2PRz/PoShqIVymGz4pNQwSLLBKMvrR
 euV4KTdXgkebEA2Ht3brcQXMPw0ccCZP9ljbxA8p7Qg9/vtLjl68n3M7rFS3dCiIJ2VE
 7mog==
X-Gm-Message-State: AOJu0YwlrXyhVmZZe0ji1n9D0wWzRYGjqA+6M3tLewS0QrXMpBdM5tyX
 pwjH7qvflSsegPAtPbjI2a7icXHuB8kopcF9E/C6n4AzX3TGkT9JdOMxzmehIHdSSaI3h6YCAWw
 JcAMjp7CMm77ieDlUFHzVMRWlRfDEcmasM02BBfh8hQVZS9hwEJE347rfIL7l0zhMQmDjpoCx52
 lVQKU8IHowUxMJA341LRYekdZr5o86ocYzVcet
X-Gm-Gg: ASbGnctH4AFpH1uDNYnGMW6phkg+aCM4K8OeCQYw/+s+WRu2JLgHK5387E3Jjy7gyLK
 BnkB9UzJkOPYaeo7gox9i5dpvi7n4qjhd7J9efRdtdT93GidwzTO8iXsCOVD7aFp7vF7M/nu95Z
 dceZXvFVI4/XP2hcPWBfyguMC0JcTDql067m5TvmWNKHBpxhxQKolOfSfU54GJqMmTx/XCp4/mJ
 0SgHl18ALKvI1tU0Tqgu1GiFt3QwNH0jrZ7kP7FIGnKZNe+Q5rLHraC41EDNYNtqHVtqX9LS60D
 hFHaeE3FDqMXk5MUFNoS
X-Received: by 2002:a05:600c:1d8e:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d509f642fmr43144375e9.16.1742582165063; 
 Fri, 21 Mar 2025 11:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElOnFdDQtQN7jkuUxLcCbknkfAnfHScc6anDk+uKruy4hx5Z9uwpBfm9NTsqD+Z52hSieZyg==
X-Received: by 2002:a05:600c:1d8e:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d509f642fmr43144065e9.16.1742582164448; 
 Fri, 21 Mar 2025 11:36:04 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e674fsm2976714f8f.80.2025.03.21.11.36.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] Mostly Rust changes for QEMU 10.0
Date: Fri, 21 Mar 2025 19:35:32 +0100
Message-ID: <20250321183556.155097-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 64acc23c9793e86f2811345f3c122bf3ece8088b:

  rust: hpet: fix decoding of timer registers (2025-03-21 14:23:11 +0100)

The bulk of the changes here are fixes to the vmstate bindings,
also including test cases, and to the Rust devices.

----------------------------------------------------------------
* exec/cpu-all: remove BSWAP_NEEDED
* pl011: pad C PL011State struct to same size as Rust struct
* rust: hpet: fix type of "timers" property
* rust: hpet: fix functional tests (and really everything that uses it)
* rust: Kconfig: Factor out whether devices are Rust or C
* rust: vmstate: Fixes and tests

----------------------------------------------------------------
Paolo Bonzini (4):
      qdev, rust/hpet: fix type of HPET "timers" property
      rust: assertions: add static_assert
      load_aout: replace bswap_needed with big_endian
      rust: hpet: fix decoding of timer registers

Peter Maydell (4):
      rust: Kconfig: Factor out whether PL011 is Rust or C
      rust: Kconfig: Factor out whether HPET is Rust or C
      hw/char/pl011: Pad PL011State struct to same size as Rust impl
      rust: pl011: Check size of state struct at compile time

Pierrick Bouvier (1):
      exec/cpu-all: remove BSWAP_NEEDED

Zhao Liu (15):
      rust/vmstate: Remove unnecessary unsafe
      rust/vmstate: Fix num_offset in vmstate macros
      rust/vmstate: Fix num field when varray flags are set
      rust/vmstate: Fix size field of VMStateField with VMS_ARRAY_OF_POINTER flag
      rust/vmstate: Fix type check for varray in vmstate_struct
      rust/vmstate: Fix "cannot infer type" error in vmstate_struct
      rust/vmstate: Fix unnecessary VMState bound of with_varray_flag()
      rust/vmstate: Relax array check when build varray in vmstate_struct
      rust/vmstate: Re-implement VMState trait for timer binding
      rust/vmstate: Support vmstate_validate
      rust/vmstate: Add unit test for vmstate_of macro
      rust/vmstate: Add unit test for vmstate_{of|struct} macro
      rust/vmstate: Add unit test for pointer case
      rust/vmstate: Add unit test for vmstate_validate
      rust/vmstate: Include complete crate path of VMStateFlags in vmstate_clock

 configs/devices/i386-softmmu/default.mak |   1 -
 include/exec/cpu-all.h                   |  12 -
 include/exec/poison.h                    |   1 -
 include/hw/char/pl011.h                  |   5 +
 include/hw/loader.h                      |   2 +-
 include/hw/qdev-properties.h             |   1 +
 linux-user/syscall_defs.h                |   2 +-
 rust/wrapper.h                           |   1 +
 bsd-user/elfload.c                       |   6 +-
 hw/core/loader.c                         |   4 +-
 hw/core/qdev-properties.c                |  37 +++
 hw/i386/fw_cfg.c                         |   2 +-
 hw/i386/pc.c                             |   2 +-
 hw/ppc/mac_newworld.c                    |   7 +-
 hw/ppc/mac_oldworld.c                    |   7 +-
 hw/sparc/sun4m.c                         |   9 +-
 hw/sparc64/sun4u.c                       |   9 +-
 linux-user/elfload.c                     |   8 +-
 hw/arm/Kconfig                           |  30 +-
 hw/char/Kconfig                          |   6 +
 hw/char/meson.build                      |   2 +-
 hw/timer/Kconfig                         |   8 +-
 hw/timer/meson.build                     |   2 +-
 rust/hw/char/pl011/src/device.rs         |   9 +-
 rust/hw/char/pl011/src/device_class.rs   |   8 +-
 rust/hw/timer/Kconfig                    |   1 -
 rust/hw/timer/hpet/src/hpet.rs           |   8 +-
 rust/qemu-api/meson.build                |   5 +-
 rust/qemu-api/src/assertions.rs          |  37 +++
 rust/qemu-api/src/vmstate.rs             | 100 +++++--
 rust/qemu-api/tests/tests.rs             |   2 +
 rust/qemu-api/tests/vmstate_tests.rs     | 477 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build                  |   3 +-
 33 files changed, 705 insertions(+), 109 deletions(-)
 create mode 100644 rust/qemu-api/tests/vmstate_tests.rs
-- 
2.49.0


