Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AA7C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpO-00005n-Ei; Wed, 17 Jul 2024 01:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpK-00005G-VO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpI-0001we-1F
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wU87ke3kOXD38ex2bz80+cl6jTUHNbwjJEWtQxmyp+c=;
 b=HW9ayuU1asDYMHKjJFxXOERSFVjI+Ds6u/ynhea5y6Av8EAnjINQux9p8OWAMeCs+Vd8Mk
 oIql2l4LneMO28YM3pzMhyXuAGy41vZNa6hLe0fJOyChuhaXrXVLeMOVI3lXhlEijm9+TB
 rP7MhvA16zsnf0P43eJCFQb+4fICYao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-u_H_klMrM0CKr6eDPPKdWw-1; Wed, 17 Jul 2024 01:03:35 -0400
X-MC-Unique: u_H_klMrM0CKr6eDPPKdWw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426654e244dso45269955e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192613; x=1721797413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wU87ke3kOXD38ex2bz80+cl6jTUHNbwjJEWtQxmyp+c=;
 b=AxcWWNS7ijec0oLbxnM33G58soKLobGWqyqKW7cfyXqofXBtOUZ9O6/YotW3a3J1sS
 prqiTOkyHS7EamNQe9HG6Nzyo8q89ywX3//c+jQBJRUiLvJYCYPBdu/3L8Q8gaeJw3Zn
 LZReom7C/8mL3LAfuj65En2EiybKZNvFLcNoy2T3aKcbbwVsAL9cCJ+FuyZ+PUjgWNJC
 BrR7wSRTz2aahhGLSxyLEZ9jy4wJBuKk7QeKppbXqNW8qUnzGZM055nfrFpuOZUge6SV
 q49bovNvPDXWYqEjaeTlJNvQrIX+HoNVNIvvlSZKqxfiQNvrgOPvy2QgQJhqvpQ9YPUh
 xHMw==
X-Gm-Message-State: AOJu0Yzga5B8tYayULsGfS3zM+ps2PTwwKcCkSc1rhdfJBQ6MY2Dz2aD
 wYn0Oacua+iImxYRgFabge/d+NsX7813D2lnMl66Y3Ch4Y/XdTOE2Mor+fvQaq5/F8hHg9QHvbL
 Zs070N5lkO+XVo69VLYsrSZ9bU8FXva2Xqz9ZpELqbWlL2ZGmIWJQnJtrNy+WPiGiO8e/Ty8mS2
 hchRfJF3QRp3Y1GP5YFbbvFpTK/EVxLLe7c/X9
X-Received: by 2002:a05:600c:5113:b0:426:5269:983a with SMTP id
 5b1f17b1804b1-427c2ca77b9mr2972175e9.8.1721192613577; 
 Tue, 16 Jul 2024 22:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG14ukVBGPrODUrZs691fGqAQfsMRYyfb47TBEM6Fl6wnUZ9ZoahduvIYOhcaLvQVbdsiOW5A==
X-Received: by 2002:a05:600c:5113:b0:426:5269:983a with SMTP id
 5b1f17b1804b1-427c2ca77b9mr2972045e9.8.1721192613098; 
 Tue, 16 Jul 2024 22:03:33 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bf84d71asm36411565e9.31.2024.07.16.22.03.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] i386, bugfix changes for QEMU 9.1 soft freeze
Date: Wed, 17 Jul 2024 07:03:10 +0200
Message-ID: <20240717050331.295371-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 959269e910944c03bc13f300d65bf08b060d5d0f:

  Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into staging (2024-07-16 06:45:23 +1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6a079f2e68e1832ebca0e7d64bc31ffebde9b2dd:

  target/i386/tcg: save current task state before loading new one (2024-07-16 18:18:25 +0200)

----------------------------------------------------------------
* target/i386/tcg: fixes for seg_helper.c
* SEV: Don't allow automatic fallback to legacy KVM_SEV_INIT,
  but also don't use it by default
* scsi: honor bootindex again for legacy drives
* hpet, utils, scsi, build, cpu: miscellaneous bugfixes

----------------------------------------------------------------
Akihiko Odaki (1):
      cpu: Free queued CPU work

Boqiao Fu (1):
      docs: Update description of 'user=username' for '-run-with'

Fiona Ebner (2):
      hw/scsi/lsi53c895a: bump instruction limit in scripts processing to fix regression
      scsi: fix regression and honor bootindex again for legacy drives

Gustavo Romero (1):
      disas: Fix build against Capstone v6

Michael Roth (1):
      i386/sev: Don't allow automatic fallback to legacy KVM_SEV*_INIT

Paolo Bonzini (9):
      hpet: fix clamping of period
      hpet: fix HPET_TN_SETVAL for high 32-bits of the comparator
      target/i386/tcg: fix POP to memory in long mode
      target/i386/tcg: Allow IRET from user mode to user mode with SMAP
      target/i386/tcg: use PUSHL/PUSHW for error code
      target/i386/tcg: Compute MMU index once
      target/i386/tcg: check for correct busy state before switching to a new task
      target/i386/tcg: use X86Access for TSS access
      target/i386/tcg: save current task state before loading new one

Richard Henderson (3):
      target/i386/tcg: Remove SEG_ADDL
      target/i386/tcg: Reorg push/pop within seg_helper.c
      target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl

Sergey Dyasli (1):
      Revert "qemu-char: do not operate on sources from finalize callbacks"

Song Gao (1):
      qemu/timer: Add host ticks function for LoongArch

 qapi/qom.json                    |  18 +-
 include/disas/capstone.h         |   1 +
 include/hw/core/cpu.h            |   6 +
 include/qemu/timer.h             |   9 +
 target/i386/cpu.h                |  11 +-
 chardev/char-io.c                |  19 +-
 cpu-common.c                     |  11 +
 hw/core/cpu-common.c             |   1 +
 hw/i386/pc.c                     |   2 +-
 hw/scsi/lsi53c895a.c             |   2 +-
 hw/scsi/scsi-bus.c               |   9 +
 hw/timer/hpet.c                  |  25 +-
 target/i386/cpu.c                |  27 +-
 target/i386/sev.c                |  87 ++++-
 target/i386/tcg/seg_helper.c     | 662 +++++++++++++++++++++------------------
 target/i386/tcg/decode-new.c.inc |   2 +-
 target/i386/tcg/emit.c.inc       |   1 +
 qemu-options.hx                  |   7 +-
 18 files changed, 535 insertions(+), 365 deletions(-)
-- 
2.45.2


