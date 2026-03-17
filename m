Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A75FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YgO-0004Xn-HM; Tue, 17 Mar 2026 13:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Yg1-0004Vg-N0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:57:59 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Yfy-0000if-9f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:57:55 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2c0e3a2605fso663837eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773770272; x=1774375072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R0+vg4g6JYciaNeJIqrvcEs7H09u3ru29AsSFHs7Kb0=;
 b=JciuzSGiYl4+/oYD+P0imeAkrkbOqmvkAm7A9Skg5HRhoPwRNkkPlivfCA6DpTEsaQ
 9b56GMsm+wpwSs4z+otwuSCdSVZjLJMLxzR1YUyJS/nPmHnanfvKzjFsPsXduiDHWmZb
 XWpdKLr2ON6utkZCu4HpyIOIaz8/+S1/K/C25lFmWP7KBfqUlK45UX7BJChuSsQJg6Oo
 Gewupi9IuhbmDuh8p1tny1+U9DWV2oUIGRtZaitbGuovwUPfC/O+N8wGc8yUfjj426WN
 9oJkmF4vtLJyhIFgh1BPoemCXFVUsxGZbyxciwM5FixrssqKpQyXcZNFZiCgf+jkEK3j
 ba4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773770272; x=1774375072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0+vg4g6JYciaNeJIqrvcEs7H09u3ru29AsSFHs7Kb0=;
 b=jJETGTfCAYHICHpcwRsgkxCUcweDgx2KL8k8Ssz4Fn55Vxw88Q/euwLVs2DQq2+WYH
 TkxHgiv2SvwOxAJU8DSds8lAtSJ/+mOi3YJbJsFCBvVed01vbqPxtz8UmCfatK4tx5A4
 wdJiaT8lzkCazRjIHf9eijMJyDabYTDE0s0x89cjEwYSywSAJID0G8Z7qDY7VVVe5ZD4
 z7fIvkqEvdlnaVUmzYCXUXG1jYoG3Ek7AQweM6mrZNiYPkfAehZNgKL+HkbI8v0sZYFE
 buOZVYKNQe7UDhu/8MkLHKGlKajwi71hHOUKuZakBFkV3D26DZIssw0MeU4PXNnUMG7p
 4vvQ==
X-Gm-Message-State: AOJu0Yzyt7vefjbTONJnE4wiEAerlC0eLMz4dTiID7qydJcQYmXZpsq5
 FviF17hbaCVeLizpcLmbRnkx9PzcGj93RZwhe8hT5E599y1p3xyzWDIorbu3ibMt
X-Gm-Gg: ATEYQzwKEgps6ORV/HvdnPz9xg562EVcLOxY1oZesmGS1i9n3A09Ux8c9xc/I5XRYTE
 1AeNllSnp2gTTP9bViUuM/wc4poXkC8WCA3GRwVCZfoTWjgWmH1NutqUS8EUZC+iLl43KDll0Pd
 /LDV95jc5ByCQTQ/ToRpV1qNaf/MJh2v3kbQIH7/jZU+GM613fftUjrYdwmQZi9dq1P8DIJyzoZ
 k1VwkKapddM+LbGxiWEFWWiKcnsX3dijEtORpZKik4jUiTVZi5KT1s1PYEAUb9dL8F39Cnt0myQ
 b5eHGy9J+2V49/aFE/L7IBWBrJH079jf7kVduN2vVW9VVSdOIUBY2eW2ODWp0qdAJdwswv1EeB8
 w87SQbze11yeBp4JoiKbvXjNrQhxOXAQ3QS92WCkO4z8hktm1hezdDfsGSzNSK6zVYsbDNzQo6T
 l32B/8aMVtfdXIty7ywRtOGdSMkB9qkRje4kM6csAKoRrkaPYAB5ONI3m3V7mwjQw=
X-Received: by 2002:a05:7300:cb0b:b0:2c0:cabf:7e55 with SMTP id
 5a478bee46e88-2c0e50a9228mr156252eec.20.1773770272024; 
 Tue, 17 Mar 2026 10:57:52 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55a2be4sm237884eec.22.2026.03.17.10.57.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:57:51 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
Date: Tue, 17 Mar 2026 14:57:41 -0300
Message-ID: <20260317175744.32469-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix a bug in the MAP_FIXED blob mapping path (introduced by 4eb0aace)
where non-host-page-aligned offsets cause mmap(MAP_FIXED) to fail with
EINVAL.  This affects any host where the page size exceeds the guest's
(ARM64 with 16KB/64KB pages, macOS ARM64).

This series introduces:

1. MAP_FIXED alignment validation in virtio-gpu: check that both
   offset and blob size are aligned to the host page size before
   calling virgl_renderer_resource_map_fixed().  When not aligned,
   fall through to the subregion method (which works at any
   alignment).

2. A map granule abstraction (hvf_set/get_map_granule) replacing
   hardcoded qemu_real_host_page_size() calls in HVF memory mapping.
   Non-aligned regions return early instead of proceeding with
   add=false (which attempted an unnecessary unmap).
   An 'ipa-granule' property (auto, 4k, 16k) on the HVF accelerator
   object allows opt-in configuration:

     -accel hvf,ipa-granule=4k

   The property follows the kvm_arch_accel_class_init() pattern:
   ARM registers the property in hvf_arch_accel_class_init(), x86
   provides an empty stub.

3. macOS 26 IPA granule support via hv_vm_config_set_ipa_granule(),
   reading the ipa-granule property to select HV_IPA_GRANULE_4KB or
   HV_IPA_GRANULE_16KB.  Falls back with a warning on macOS < 26.

Dependencies: none.

Changes v3 -> v4:
  - Rebased onto current master (no code changes)
  - Fix Signed-off-by email in patches 2/3 and 3/3
  - Resent as new top-level thread per Alex Bennée's feedback

Changes v2 -> v3:
  - Rebased on current master
  - Add MAP_FIXED alignment validation (new patch 1)
  - Move #ifdef __aarch64__ property code into hvf_arch_accel_class_init
    following kvm_arch_accel_class_init() pattern (x86 empty stub)
  - Use MAC_OS_VERSION_26_0 named constant
  - Remove Venus blob mapping warning

Changes v1 -> v2 (Mohamed Mosaad review):
  - Replace hardcoded 4KB with configurable ipa-granule property
    (auto, 4k, 16k) on the HVF accelerator object.
  - 'auto' defaults to host page size; explicit values opt in.
  - Add fallback warning when macOS < 26 can't honor the request.
  - Add Venus blob mapping safety warning.
  - Use KiB constants instead of magic numbers.

Lucas Amaral (3):
  virtio-gpu: validate host page alignment for MAP_FIXED blobs
  accel/hvf: introduce map granule abstraction and IPA property
  target/arm/hvf: configure IPA granule on macOS 26

 accel/hvf/hvf-all.c           | 30 +++++++++++++--
 hw/display/virtio-gpu-virgl.c | 45 +++++++++++++---------
 include/system/hvf.h          | 15 ++++++++
 include/system/hvf_int.h      |  2 +
 target/arm/hvf/hvf.c          | 72 +++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf.c         |  4 ++
 6 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.52.0


