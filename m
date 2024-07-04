Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E8AC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEL-0006Rx-Il; Thu, 04 Jul 2024 05:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEK-0006Rf-FD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEI-00085t-OX
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=slf3JlT9Ki235quSaIGjyx/R7fsjuK4UD3wvGiUiUBA=;
 b=EywLIMiasiZd/rVIq+yrzeIUD23fZNOr1lPoktzWyJil9LK4qsm8Rj5GsHIpPNaSOM80Lg
 lOGAZevcK8vfWnY8T7yeUvEYV/anbWAq7ZLI5R95nqunBiK0Rl36sZZNU94LDtHcUqrSlx
 1K2Pz8tC/CkdFiprlKhb8cr4dbMMJAs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-4KMqoXwQMomC3hojiXdvDQ-1; Thu, 04 Jul 2024 05:58:09 -0400
X-MC-Unique: 4KMqoXwQMomC3hojiXdvDQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678f403afaso306743f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087088; x=1720691888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slf3JlT9Ki235quSaIGjyx/R7fsjuK4UD3wvGiUiUBA=;
 b=CjfmOIEcRvFDFPvghafGlEbDyIl4r2tryoSlhvmIh8i07b4OvBLRwffBTapWjokyj0
 bqIFDIWhPEDB0EGUExIix7MSXo3zQ90AgeOuESZfbbDjd/lLuM+FDXO94sDNJ2vhZFXc
 c+Few9OeZfFlMd54QNDpetudfA+GoRrm3Wl3l0C60x7DVhR9CUeJMlkXNyB2vB3Vv9AO
 aaA0cwqSvnu2LW6g1BblfSofAotBcm1oxA7QO19dihlK+op0Vig+PFrg/uhE6kSfuzFr
 31No5kI1G783g5H3/CInB1zFzwQdzre0/Ko6pDkyoy2N/DqpdL1B9b8bcb4+Ep/8n3zG
 uvPg==
X-Gm-Message-State: AOJu0Yyl/TN1Y9IYNmxN0NP9I9FYh2qd+P9Pfa78oNyHZCDZfY5FAK61
 s5doT/qQjpNOa1X5liImljuKraOsyok8c0p7k9ASJ/gLzzoDiRLI4N+uetLMymECeCNt68TBVHH
 CQOin/c1EJqvK7s5Le3pLEQUS9vTmYEyL8GY9dMH2Jy20C5a8tw6+7UUFr5Z88uVnJtO1mMW8XV
 FtElJG/2NZnQLT9iCBPlCwS88MOirvk8IrytLb
X-Received: by 2002:adf:fe8d:0:b0:360:775d:f909 with SMTP id
 ffacd0b85a97d-3679dd67443mr1053900f8f.55.1720087088374; 
 Thu, 04 Jul 2024 02:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQNs7WTVvOfILI2JhJ/Z+lTzAmfjO7/4D/Bqw6kR7cqkrr84sv+AEVglBcPD4nLQ3cUrnHkA==
X-Received: by 2002:adf:fe8d:0:b0:360:775d:f909 with SMTP id
 ffacd0b85a97d-3679dd67443mr1053882f8f.55.1720087087912; 
 Thu, 04 Jul 2024 02:58:07 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36797bff8cbsm2482392f8f.14.2024.07.04.02.58.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] meson, i386 changes for 2024-07-04
Date: Thu,  4 Jul 2024 11:57:50 +0200
Message-ID: <20240704095806.1780273-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768:

  Merge tag 'pull-request-2024-07-02' of https://gitlab.com/thuth/qemu into staging (2024-07-02 15:49:08 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 188569c10d5dc6996bde90ce25645083e9661ecb:

  target/i386/SEV: implement mask_cpuid_features (2024-07-04 11:56:20 +0200)

----------------------------------------------------------------
* meson: Pass objects and dependencies to declare_dependency(), not static_library()
* meson: Drop the .fa library suffix
* target/i386: drop AMD machine check bits from Intel CPUID
* target/i386: add avx-vnni-int16 feature
* target/i386: SEV bugfixes
* target/i386: SEV-SNP -cpu host support
* char: fix exit issues

----------------------------------------------------------------
Akihiko Odaki (2):
      meson: Pass objects and dependencies to declare_dependency()
      Revert "meson: Propagate gnutls dependency"

Maxim Mikityanskiy (1):
      char-stdio: Restore blocking mode of stdout on exit

Michal Privoznik (2):
      i386/sev: Fix error message in sev_get_capabilities()
      i386/sev: Fallback to the default SEV device if none provided in sev_get_capabilities()

Paolo Bonzini (11):
      meson: move shared_module() calls where modules are already walked
      meson: move block.syms dependency out of libblock
      meson: merge plugin_ldflags into emulator_link_args
      meson: Drop the .fa library suffix
      target/i386: pass X86CPU to x86_cpu_get_supported_feature_word
      target/i386: drop AMD machine check bits from Intel CPUID
      target/i386: SEV: fix formatting of CPUID mismatch message
      target/i386: do not include undefined bits in the AMD topoext leaf
      target/i386: add avx-vnni-int16 feature
      target/i386: add support for masking CPUID features in confidential guests
      target/i386/SEV: implement mask_cpuid_features

 docs/devel/build-system.rst         |   8 +--
 meson.build                         | 100 ++++++++++++++++++------------------
 target/i386/confidential-guest.h    |  24 +++++++++
 target/i386/cpu.h                   |  10 +++-
 chardev/char-stdio.c                |   4 ++
 hw/i386/pc.c                        |   1 +
 stubs/blk-exp-close-all.c           |   2 +-
 target/i386/cpu.c                   |  40 +++++++++++----
 target/i386/kvm/kvm-cpu.c           |   2 +-
 target/i386/kvm/kvm.c               |   5 ++
 target/i386/sev.c                   |  51 ++++++++++++++----
 .gitlab-ci.d/buildtest-template.yml |   2 -
 .gitlab-ci.d/buildtest.yml          |   2 -
 block/meson.build                   |   2 +-
 gdbstub/meson.build                 |   6 +--
 io/meson.build                      |   2 +-
 plugins/meson.build                 |   7 ++-
 pythondeps.toml                     |   2 +-
 storage-daemon/meson.build          |   3 +-
 tcg/meson.build                     |   8 +--
 tests/Makefile.include              |   2 +-
 tests/qtest/libqos/meson.build      |   3 +-
 ui/meson.build                      |   2 +-
 23 files changed, 183 insertions(+), 105 deletions(-)
-- 
2.45.2


