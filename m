Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A30DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4F7H-0007e2-7a; Tue, 07 May 2024 03:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7F-0007dk-SO
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7E-0003vq-Bi
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rQ6NUGv6/rMNdPHUeGTtxCGheZ7NPFu62C7ytlGqWxI=;
 b=HHpWYAqRo1PKTV3+mwjNBoUssB98YMOcZ0NjEJd3BO+8uWm/KaKvMcMRA39W1UadVvsvhr
 gc0CoQav7UVNeglsAIrAVqI+VHJZXtZ1HcXOitKwnAVUufekzVqmMb8CpOoPVJ627kuyh+
 XQm6Yxf53mSNY+dnI/S2UOZE7anXuls=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-h-vqt0ttNeCyaOhjY37xgg-1; Tue, 07 May 2024 03:19:52 -0400
X-MC-Unique: h-vqt0ttNeCyaOhjY37xgg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572ef3eb368so154705a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066391; x=1715671191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rQ6NUGv6/rMNdPHUeGTtxCGheZ7NPFu62C7ytlGqWxI=;
 b=QCQ8344pbofO217u8WWYwPbzFxwys3Xzf32etf+ppNiHJ6aqePBHrKGiYOjOTqnH5M
 GVwMiYDrfXP1BwwGQxOEHQ+3mPEg6R4c81wArafb61EK+q74HwLxaPA1g712uxdAKCIs
 FG9An0tFp7d4oYyODe13RTyq/zR28Wl4C3zuv6gRuRF+bla/kw43pjeuhgyuaNS26zIG
 YWTHbGUGSnJvOGuZaMnjmYnzrCRhtkQnglY1PhQhe442X3yNWfigYgYwGXNXpKtTWSpN
 QNsIL5EhWWhXTpOQJSzrPyTDfMGWF+iir9hbQBX/l8deaUta6h24F4r8NSd5mrssRn3l
 6Wsg==
X-Gm-Message-State: AOJu0YyUnV7mGVvx1XXARycJP3KyrUDkalTRMv+qfnVMlIuiDIms4v21
 WWkzOa0KLcFGMurKCvQgqY1N26WLXzeTv8drmbK/VlTX+wkUolPbBYNUoUbGnokWpfMZOobKytd
 JxQojlvsWBkuLsYBHliNOXemmE5Uz6D/C75KDeZOEQFde/SfSStDYTzPyg1xWm+DM9On4QwQtDP
 E+fAHfSUhTcBqL4M+WV5FGQfVmb2PbK7qDvYCN
X-Received: by 2002:a50:9b18:0:b0:572:4761:1947 with SMTP id
 o24-20020a509b18000000b0057247611947mr7621325edi.36.1715066390962; 
 Tue, 07 May 2024 00:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGwL+KdxAgz26yYbOKxuSfD6hI2Asjdw/TYldMUgbonWbdpryfR5F0Po081txgYI05enAw3Q==
X-Received: by 2002:a50:9b18:0:b0:572:4761:1947 with SMTP id
 o24-20020a509b18000000b0057247611947mr7621308edi.36.1715066390588; 
 Tue, 07 May 2024 00:19:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ds9-20020a0564021cc900b005705bfeeb27sm6031389edb.66.2024.05.07.00.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 00:19:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 0/4] express dependency of individual boards on libfdt
Date: Tue,  7 May 2024 09:19:44 +0200
Message-ID: <20240507071948.105022-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just like we have boards that depend on TCG, not all boards in a
target may require libfdt.  Express one by one which boards do,
using Kconfig "depends on" and "select" directives, and use the
result to include system/device_tree.c in the build.

Some binaries do require libfdt altogether.  In a normal build without
--target-list or --enable-libfdt, these binaries will be disabled with a
message printed by meson.

Paolo

Paolo Bonzini (4):
  meson: remove system/internal distinction for libfdt
  kconfig: express dependency of individual boards on libfdt
  hw/xtensa: require libfdt
  configs: disable emulators that require it if libfdt is not found

 configs/targets/aarch64-softmmu.mak      |  1 +
 configs/targets/arm-softmmu.mak          |  1 +
 configs/targets/i386-softmmu.mak         |  1 -
 configs/targets/loongarch64-softmmu.mak  |  1 +
 configs/targets/microblaze-softmmu.mak   |  1 +
 configs/targets/microblazeel-softmmu.mak |  1 +
 configs/targets/mips64el-softmmu.mak     |  1 -
 configs/targets/or1k-softmmu.mak         |  1 +
 configs/targets/ppc-softmmu.mak          |  1 -
 configs/targets/ppc64-softmmu.mak        |  1 +
 configs/targets/riscv32-softmmu.mak      |  1 +
 configs/targets/riscv64-softmmu.mak      |  1 +
 configs/targets/rx-softmmu.mak           |  1 +
 configs/targets/x86_64-softmmu.mak       |  1 -
 meson.build                              | 82 ++++++++++++------------
 hw/xtensa/xtfpga.c                       |  9 ---
 .gitlab-ci.d/buildtest.yml               |  7 +-
 Kconfig.host                             |  3 +
 hw/arm/Kconfig                           |  5 ++
 hw/arm/meson.build                       |  2 +-
 hw/core/Kconfig                          |  9 ++-
 hw/core/meson.build                      |  2 +-
 hw/i386/Kconfig                          |  3 +-
 hw/loongarch/Kconfig                     |  3 +-
 hw/loongarch/meson.build                 |  2 +-
 hw/mips/Kconfig                          |  1 +
 hw/mips/meson.build                      |  2 +-
 hw/openrisc/Kconfig                      |  2 +
 hw/openrisc/meson.build                  |  4 +-
 hw/ppc/Kconfig                           | 15 +++--
 hw/ppc/meson.build                       |  4 +-
 hw/riscv/Kconfig                         |  4 ++
 hw/riscv/meson.build                     |  2 +-
 hw/rx/Kconfig                            |  3 +-
 hw/xtensa/Kconfig                        |  3 +-
 meson_options.txt                        |  6 +-
 scripts/meson-buildoptions.sh            |  4 +-
 system/meson.build                       |  2 +-
 target/arm/Kconfig                       |  2 +
 target/microblaze/Kconfig                |  1 +
 target/openrisc/Kconfig                  |  1 +
 target/riscv/Kconfig                     |  2 +
 42 files changed, 112 insertions(+), 87 deletions(-)

-- 
2.45.0


