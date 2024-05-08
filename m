Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6356DC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c57-0006nl-Md; Wed, 08 May 2024 03:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c53-0006n7-QI
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c51-0003ck-Vo
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Hawqc4eKsuRoEeNzhNfF11fxC7Y1Ie12gJ5KxWupCw=;
 b=SnXwVbQu0qjL5c/tf69tQwEMkywkfz0xEEinlFGzO9cZH1IkrL/V1hOS16hVXSyftDBBkn
 D3iJR69G6g1zgNLgtMpySuPXcx1XyhmGx0O6sBKpSasrkSTBrp1DDbspMfIp97yQReK8My
 kNz15uzqbEB9M8UlQnMP4iEzcSmt5RM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-e4iGkeGwMyuuRl-Y_8D5Gg-1; Wed, 08 May 2024 03:51:09 -0400
X-MC-Unique: e4iGkeGwMyuuRl-Y_8D5Gg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a524b774e39so53104466b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154667; x=1715759467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Hawqc4eKsuRoEeNzhNfF11fxC7Y1Ie12gJ5KxWupCw=;
 b=AQbfAjjnjxPps0+XMNA3m1bJ8tJnFiMse1Q65L3UMTNQ7VOK2tFvi6qr4oncEcU3mb
 e7+2GFg5UNdFspFRpJqUH3Y6jT5qa47xc/0pLpgUIKyndMPo9OqJnxJZj8yUYMLALKGn
 QFxsKrkqjbDnkFx1NWCNw9EgNU3ZBPG915c9hB8sdYIzu2RBXi1gUz7CtPzVXZ9x+w+p
 0OdS/FOQT8ioQjMSTFjIN3AvD5V9Yc3T57Hf89M+jC4e/y/keO8ksKA5FlVN4duTMqmB
 2YwO560G4fLQG7FVu9iaTkZr0zbwNEapUCBc06P1gp4034TllKqHgLJHduXtaShGMSWy
 n64w==
X-Gm-Message-State: AOJu0Yw0flenSn0r/otcuwbtCE2h3Mz/eSjT2xl22IWhoHgg9kwSzgkd
 oUanyIPf9IUsQDKMGgamaIYtQmyM57rF7UNsmbcAqgjEbU9sYr0QgTMJ0HSQQJIlSqd1OyeO5cd
 F5ak9smWUFWoXZoVK0/sAe5keVEVPoAJQ4CRhdjpQY5QIOFmUHOH9eB17wKs6DPEe2uEuNa4Fwg
 G+gp3pL7/Se+RvV6kSzbsdwUEwMIDv1Rs8kDu/
X-Received: by 2002:a17:906:d295:b0:a59:a85c:a5ca with SMTP id
 a640c23a62f3a-a59fa863e37mr167404066b.7.1715154666924; 
 Wed, 08 May 2024 00:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9QGeQ7yhzoEWxc+hlgs6NRytazIsVpcOfJ74tQL4zTXaUVxJxbcg2QwrjtfI7c3HAzHpipA==
X-Received: by 2002:a17:906:d295:b0:a59:a85c:a5ca with SMTP id
 a640c23a62f3a-a59fa863e37mr167402266b.7.1715154666442; 
 Wed, 08 May 2024 00:51:06 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a170906834800b00a59b126af69sm4678727ejy.159.2024.05.08.00.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:51:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 0/6] kconfig: express dependency of individual boards on
 libfdt
Date: Wed,  8 May 2024 09:50:59 +0200
Message-ID: <20240508075105.15510-1-pbonzini@redhat.com>
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

This is a follow up to the "default y" patch series at
https://lore.kernel.org/qemu-devel/20240423131612.28362-1-pbonzini@redhat.com/
and shows an example of what that series enables.

With this change, individual boards will be enabled/disabled depending
on whether libfdt is present or not.  In particular, x86 will simply
disable microvm and build the "traditional" chipsets if libfdt is not
found.

All boards or targets that need libfdt now have an explicit "depends on
FDT" (sometimes the boards delegate that to the target).  TARGET_NEED_FDT
is only used for targets that absolutely cannot build without libfdt,
or for which all boards require it.

For simplicity, patch 1 simplifies the libfdt handling in meson.build,
removing the ability to force use of the subproject.  There is no
use case that I can imagine, if you want to use the subproject just
delete libfdt from your OS installation.

Paolo

v1->v2:
- use libfdt CPPFLAGS when building target-specific files
- limited scope of libfdt detection changes: keep it enabled when building
  --without-default-features (see commit message for 0577e84d374,
  "configure: Disable capstone and slirp in the --without-default-features
  mode", 2022-02-21)
- patch 6 does not 
- split patch 3 in two parts
- fix compilation errors due to missing qmp_dumpdtb/hmp_dumpdtb
- make MIPS_BOSTON depend on FDT

Paolo Bonzini (6):
  meson: pick libfdt from common_ss when building target-specific files
  meson: move libfdt together with other dependencies
  kconfig: allow compiling out QEMU device tree code per target
  kconfig: express dependency of individual boards on libfdt
  hw/xtensa: require libfdt
  configs: disable emulators that require it if libfdt is not found

 configs/targets/aarch64-softmmu.mak      |   1 +
 configs/targets/arm-softmmu.mak          |   1 +
 configs/targets/i386-softmmu.mak         |   1 -
 configs/targets/loongarch64-softmmu.mak  |   1 +
 configs/targets/microblaze-softmmu.mak   |   1 +
 configs/targets/microblazeel-softmmu.mak |   1 +
 configs/targets/mips64el-softmmu.mak     |   1 -
 configs/targets/or1k-softmmu.mak         |   1 +
 configs/targets/ppc-softmmu.mak          |   1 -
 configs/targets/ppc64-softmmu.mak        |   1 +
 configs/targets/riscv32-softmmu.mak      |   1 +
 configs/targets/riscv64-softmmu.mak      |   1 +
 configs/targets/rx-softmmu.mak           |   1 +
 configs/targets/x86_64-softmmu.mak       |   1 -
 meson.build                              | 100 +++++++++++++----------
 include/monitor/hmp.h                    |   1 +
 include/sysemu/device_tree.h             |   1 -
 hw/xtensa/xtfpga.c                       |   9 --
 monitor/hmp-cmds.c                       |  17 ++++
 system/device_tree-stub.c                |  10 +++
 system/device_tree.c                     |  14 ----
 .gitlab-ci.d/buildtest.yml               |   8 +-
 Kconfig.host                             |   3 +
 hw/arm/Kconfig                           |   5 ++
 hw/arm/meson.build                       |   2 +-
 hw/core/Kconfig                          |   9 +-
 hw/core/meson.build                      |   2 +-
 hw/i386/Kconfig                          |   3 +-
 hw/loongarch/Kconfig                     |   3 +-
 hw/loongarch/meson.build                 |   2 +-
 hw/mips/Kconfig                          |   3 +-
 hw/mips/meson.build                      |   2 +-
 hw/openrisc/Kconfig                      |   2 +
 hw/openrisc/meson.build                  |   4 +-
 hw/ppc/Kconfig                           |  15 ++--
 hw/ppc/meson.build                       |   4 +-
 hw/riscv/Kconfig                         |   4 +
 hw/riscv/meson.build                     |   2 +-
 hw/rx/Kconfig                            |   3 +-
 hw/xtensa/Kconfig                        |   3 +-
 system/meson.build                       |   4 +-
 target/arm/Kconfig                       |   2 +
 target/microblaze/Kconfig                |   1 +
 target/openrisc/Kconfig                  |   1 +
 target/riscv/Kconfig                     |   2 +
 45 files changed, 154 insertions(+), 101 deletions(-)
 create mode 100644 system/device_tree-stub.c

-- 
2.45.0


