Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2411D5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 07:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9g0t-0002rC-NK; Sat, 09 Nov 2024 02:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9g0s-0002qv-7K
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9g0q-0007xp-IH
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731137763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DuxkIr8RzF64YJ2wgGFfao4HZXoLFGARotGep685iPA=;
 b=O8w8pg8APBeb83bAySjhSwtd/mwa3y/NDTRM4u3RDuwWOR6CrIDkLaNSLvEJO5nS6AwyCT
 8bEdGey7sslhSo5J5IrjVeNFJypqodrAego/AmuLPA++7bM2Lg48Kmkkn2wRpauklpbqUC
 zLKFUVsuoWA51OJC8W4eXz8T1c0+WLU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-yM3EX51HNESBoPn55uNvyg-1; Sat, 09 Nov 2024 02:35:59 -0500
X-MC-Unique: yM3EX51HNESBoPn55uNvyg-1
X-Mimecast-MFC-AGG-ID: yM3EX51HNESBoPn55uNvyg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso20676685e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 23:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731137758; x=1731742558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DuxkIr8RzF64YJ2wgGFfao4HZXoLFGARotGep685iPA=;
 b=rVqlt01PZ6o4tx8HRmBw/U+nFAzCMXkI/r1T39h+bU5ZW/bpOWPLur4DP6OWxAd1Sb
 NGdTkAzzBXhM6TM+YaDNP7nauP4bRbCPuEtB5MmMnQR0qsxXx1y/oRvalXjEPc9Ypirx
 fgOQjqwfG4meVf1sdT55PrcenR/oCG55gZDHVdhmvREsU7SBb9t4EdRgmIChGivQh6KO
 hlo2yMIy5n8n81P5KGIV6tI+OdG8Ehg6+TJ8CaxSDfVZwUUVk0yrTS2W9QBd2Anq5Tck
 hOwHE5ieUTRaYy4P7EVNU9Muw1uzld6Eq2njA3fk/T5JrnN7jd+wZHMrR00Ci3Sfrobn
 YZIA==
X-Gm-Message-State: AOJu0YwMnuYJ3Fkz872F3ArODSuP06oYmvas0HlfxFVnmudWfkv6GGU1
 JPNXthgjYjS8BUHMpl859gUtWrzOBv1EKDdgcJQzmGM32dbwDdm+wovO6PymY6gq4anxxw6gAgx
 Fqz1mHMCR6rYfSMFLbnywBPWn4nQe79Jsv2szP29g1HDhvkY47UCWiA3i+pxD9LV07MUxGlVdcA
 atr52V754/XQQ4kznQvwwM7j1L+y6AEeqBKgo9/aI=
X-Received: by 2002:a05:600c:358f:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-432b751e38emr44621255e9.27.1731137758026; 
 Fri, 08 Nov 2024 23:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeEUmGc+47iJ7PEKspF1jG4vN4tsuN6xILQM4Qw9VXesGrIW17qw0GxYvOp7q9lZDp8yBfnQ==
X-Received: by 2002:a05:600c:358f:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-432b751e38emr44621005e9.27.1731137757492; 
 Fri, 08 Nov 2024 23:35:57 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b054b3fesm95102225e9.17.2024.11.08.23.35.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 23:35:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/13] (Almost entirely) bugfix changes for QEMU 9.2 hard
 freeze
Date: Sat,  9 Nov 2024 08:35:54 +0100
Message-ID: <20241109073555.162151-1-pbonzini@redhat.com>
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

for you to fetch changes up to bd0e501e1a4813fa36a4cf9842aaf430323a03c3:

  hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus (2024-11-09 08:34:07 +0100)

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


