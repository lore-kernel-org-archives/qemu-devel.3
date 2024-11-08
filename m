Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4100D64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SwR-0003cb-KJ; Fri, 08 Nov 2024 12:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwP-0003az-25
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwM-0007ZL-Pu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HRQlLEKuUjdRqZQeOMskkxAI/jdXKEPQv2oog1DAxk4=;
 b=ZF2/UzcAw1uapfzkJKMhfQI730XZZrtE8GNFA6B72YoAm3sqL8hyH0N3sikI1i1U6Pjk9j
 3J7WZOyuTCjv3NNPBD6arbLr0QN+k4w+F2aXf2WH067aB0ooY9H0YOvRjoDCRYumdWZTZI
 yNSM3G7R7lTYNzTSPgfcmdnwoPQEXp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-CoAulT4DOACgrYycv0arwA-1; Fri, 08 Nov 2024 12:38:31 -0500
X-MC-Unique: CoAulT4DOACgrYycv0arwA-1
X-Mimecast-MFC-AGG-ID: CoAulT4DOACgrYycv0arwA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431ad45828aso16426505e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087510; x=1731692310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HRQlLEKuUjdRqZQeOMskkxAI/jdXKEPQv2oog1DAxk4=;
 b=VrRkYaVJAaMV+w7fj1iPYZ+PlQCqqBVvEgRxXCDGw2Ff5o0xuUNYCZ0jsyPCmFWoSj
 h0M31SRrNSNvXfw3IZ/Bk6k6qN7uV4fi/TWFid7RnGt9h6nCKBY7qkAAPchABf7H+Ht0
 /8XIysMtjRR8Tb2R+8I5KXFwgGgpGSlJXOOj5aLrBGByMCSgeNZLEvKRJ4lxKBO720bS
 2TbucKBqFHoSJQ6naty33QtvJu7AqFU+kKR9RC20k8GJ4YRXrtX1CexIIfEPq33hhlKK
 pxrCDuZNsJA69mqTt0Mkd+M9z3eEig6H23lAn6ri6wf1GJ2hAb9kEnOXNCW0/hlrvyw0
 ocPQ==
X-Gm-Message-State: AOJu0YySUoFN3IlDbDQdgf7jlwSY86ndYunJ1Bc3+WEICeogZkbuW055
 E4+Hi45AnFcU0yAxqZ//DxzSQ8INyhapK3HEuK/9NobZDBF1wdax6oKI9x1ZaHySNSfWL0TjFn7
 2jKDMc6Zcy8oFEkis/q8N8RSFb9sT1yOuKc5RjHt7+IOZdodL4dww8v7F72GGk/d0fU3G4H1gXC
 ce+ToSk5Zw6v8WL2gAny1vw2q1mK02lw313Z3BkOI=
X-Received: by 2002:a05:600c:4e8b:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-432b7501d2bmr32193285e9.13.1731087510329; 
 Fri, 08 Nov 2024 09:38:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEVk8s8yAyZbaWLjWrX71eAYu/c7IcfPeUNALqEO+JpqvE8rTudrNifKVYSzA3muT+rr8ofg==
X-Received: by 2002:a05:600c:4e8b:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-432b7501d2bmr32193045e9.13.1731087509724; 
 Fri, 08 Nov 2024 09:38:29 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053ff08sm79183555e9.10.2024.11.08.09.38.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] (Almost entirely) bugfix changes for QEMU 9.2 hard freeze
Date: Fri,  8 Nov 2024 18:38:15 +0100
Message-ID: <20241108173828.111454-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit a1dacb66915eb7d08a0596cc97068a37c39930d3:

  Merge tag 'for-upstream-rust' of https://gitlab.com/bonzini/qemu into staging (2024-11-06 21:27:47 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 37d729ee75fd035b1a8995b51b4e0d182c909c0b:

  hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus (2024-11-08 09:24:52 +0100)

----------------------------------------------------------------
* i386: fix -M isapc with ubsan
* i386: add sha512, sm3, sm4 feature bits
* eif: fix Coverity issues
* i386/hvf: x2APIC support
* i386/hvf: fixes
* i386/tcg: fix 2-stage page walk
* eif: fix coverity issues
* rust: fix subproject warnings with new rust, avoid useless cmake fallback
----------------------------------------------------------------

The x2APIC support is not a bugfix, but it's small and it was posted well in
advance of soft freeze.

Paolo

Alexander Graf (1):
      target/i386: Fix legacy page table walk

Paolo Bonzini (5):
      target/i386: add sha512, sm3, sm4 feature bits
      rust: add meson_version to all subprojects
      eif: cope with huge section offsets
      eif: cope with huge section sizes
      rust: qemu-api-macros: always process subprojects before dependencies

Peter Maydell (1):
      hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus

Phil Dennis-Jordan (5):
      i386/hvf: Integrates x2APIC support with hvf accel
      i386/hvf: Fix for UB in handling CPUID function 0xD
      i386/hvf: Fixes startup memory leak (vmcs caps)
      i386/hvf: Raise exception on error setting APICBASE
      i386/hvf: Removes duplicate/shadowed variables in hvf_vcpu_exec

Pierrick Bouvier (1):
      target/i386/hvf: fix clang compilation warning

 include/qemu/osdep.h                               |  4 ++
 target/i386/cpu.h                                  |  1 +
 hw/core/eif.c                                      | 52 +++++++++++++++++++---
 hw/i386/pc.c                                       |  4 +-
 target/i386/cpu.c                                  |  2 +-
 target/i386/hvf/hvf.c                              |  7 ++-
 target/i386/hvf/x86_cpuid.c                        |  8 ++--
 target/i386/hvf/x86_emu.c                          | 42 ++++++++++++++++-
 target/i386/tcg/seg_helper.c                       |  2 +-
 target/i386/tcg/sysemu/excp_helper.c               |  2 +-
 rust/qemu-api-macros/meson.build                   |  4 ++
 .../packagefiles/arbitrary-int-1-rs/meson.build    |  1 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |  1 +
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |  1 +
 subprojects/packagefiles/either-1-rs/meson.build   |  1 +
 .../packagefiles/itertools-0.11-rs/meson.build     |  1 +
 .../packagefiles/proc-macro-error-1-rs/meson.build |  1 +
 .../proc-macro-error-attr-1-rs/meson.build         |  1 +
 .../packagefiles/proc-macro2-1-rs/meson.build      |  1 +
 subprojects/packagefiles/quote-1-rs/meson.build    |  1 +
 subprojects/packagefiles/syn-2-rs/meson.build      |  1 +
 .../packagefiles/unicode-ident-1-rs/meson.build    |  1 +
 22 files changed, 118 insertions(+), 21 deletions(-)
-- 
2.47.0


