Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA6EC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8B-0004ZW-TK; Sun, 14 Jul 2024 07:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx88-0004Vp-QH
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx85-00022M-0D
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5JX5ELR1NtHHCLybeAN9sOd7BdgMYgtwGtyVuWSLGQ0=;
 b=S15ZZX6l7Zv+vKnFBkDhVYUB6QoSXZ5T31skZRCc4xrteh+PmA3QjbP9AB8G/zRIg2NK+w
 VFiNe3fI0VikJkxiIssSPDtriDm6UHtOZI6Ifh18hXFwCUlWTo0nRUD3Acvwe53DXHvneg
 DV8x54Gg7iCpACxn1nfMZtkAmMrB1eQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ZLcm6ijQN8ibVreJLgSUtw-1; Sun, 14 Jul 2024 07:10:48 -0400
X-MC-Unique: ZLcm6ijQN8ibVreJLgSUtw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426724679f0so23471835e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955446; x=1721560246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5JX5ELR1NtHHCLybeAN9sOd7BdgMYgtwGtyVuWSLGQ0=;
 b=v1h533G0gyyPm8zMciT3jCRlSP4ZJL0graEPtfrgo8mUIY0LoSg7qUFLxMmF/uaOMF
 xPKS6NKcDXWDuzjiEwAJaW08j4L/myiHRxugBoKKDxY8E1BoCIGehry2Pc3RUxcZg5cq
 bfJGIEIjCyOxCTLX0HXFbgCbpQb7LBu6ihRcBqksTRiIq80eZx7FdI1hjA1DcTB/zcL7
 nkE3xHLPGtM7eVxUUHZvC3sWmpG5YGX12o72E3XCFU1gtnxUZuVvfLHoOMNJlz2LyQoT
 egZn5vCuaR+wwlmWBnZm9QUg/CsMdnFGAkKfcXrAGI5Q+STC166T0je1YisewibsYFLW
 yUoA==
X-Gm-Message-State: AOJu0YzB3yJolDYtGxipWsZxIJ5HIAb8fh0qOxTFRAYCbBN9b7g3oN7q
 pv/ZaCkPbX+qHYOvoOt8SlfUDxufWHu9hbKqxEg9/0yJJQ5ugtHifeH9D6cGw//vTf0UqZJaAhv
 L1vkVHWGI5nV7HTjMHCP7N8WmXV1AHaJW8Lqe3CMTfGevMQb4y0FzHnU1MQ8sHxxmmStNag0oyu
 Ca6iU5+JZrdctRocWq5aIgt/VQ9KcUmdZ5RhFk
X-Received: by 2002:a05:600c:4883:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-4279da0240dmr62950795e9.6.1720955446595; 
 Sun, 14 Jul 2024 04:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcM3QOrpdfxv+Z22nj5P2uV7FXiAOngELHtJlca4a0hIFg55bw12haLBsPcriCp9BWOlMRrQ==
X-Received: by 2002:a05:600c:4883:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-4279da0240dmr62950685e9.6.1720955446094; 
 Sun, 14 Jul 2024 04:10:46 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2397easm83771595e9.6.2024.07.14.04.10.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:10:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] target/i386 changes for 2024-07-12
Date: Sun, 14 Jul 2024 13:10:30 +0200
Message-ID: <20240714111043.14132-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 23901b2b721c0576007ab7580da8aa855d6042a9:

  Merge tag 'pull-target-arm-20240711' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-11 12:00:00 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream-i386

for you to fetch changes up to cdcadf9ee9efef96323e0b88fccff589f06fc0ee:

  i386/sev: Don't allow automatic fallback to legacy KVM_SEV*_INIT (2024-07-12 15:35:54 +0200)

----------------------------------------------------------------
* target/i386/tcg: fixes for seg_helper.c
* SEV: Don't allow automatic fallback to legacy KVM_SEV_INIT,
  but also don't use it by default

----------------------------------------------------------------
Michael Roth (1):
      i386/sev: Don't allow automatic fallback to legacy KVM_SEV*_INIT

Paolo Bonzini (8):
      target/i386/tcg: fix POP to memory in long mode
      target/i386/tcg: Allow IRET from user mode to user mode with SMAP
      target/i386/tcg: use PUSHL/PUSHW for error code
      target/i386/tcg: Compute MMU index once
      target/i386/tcg: Use DPL-level accesses for interrupts and call gates
      target/i386/tcg: check for correct busy state before switching to a new task
      target/i386/tcg: use X86Access for TSS access
      target/i386/tcg: save current task state before loading new one

Richard Henderson (3):
      target/i386/tcg: Remove SEG_ADDL
      target/i386/tcg: Reorg push/pop within seg_helper.c
      target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl

 qapi/qom.json                    |  18 +-
 target/i386/cpu.h                |  11 +-
 hw/i386/pc.c                     |   2 +-
 target/i386/cpu.c                |  27 +-
 target/i386/sev.c                |  87 ++++-
 target/i386/tcg/seg_helper.c     | 665 +++++++++++++++++++++------------------
 target/i386/tcg/decode-new.c.inc |   2 +-
 target/i386/tcg/emit.c.inc       |   1 +
 8 files changed, 472 insertions(+), 341 deletions(-)
-- 
2.45.2


