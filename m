Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B134EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQQz-0007Ie-QF; Fri, 06 Feb 2026 13:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQQy-0007Hj-GW
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQQx-0004IA-4f
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f2599980so28889145e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401996; x=1771006796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Pn8dV0n+ZYComEO5IK/QNCCh7G+UzHwPjkdirZhzUw=;
 b=MsaIkPg2wO+4QNTwvcDAUj01xmDCTIndopybSxU3+/vI6BwYGfbGDw6cuzhb2KXPPU
 ubvMovf1X2XGr+KurXK9M8x3Yc3HAd12gRac72zGAI/jXocIzS2i90R8O9JxZWkYcYl2
 Uprq9J1ho0oF/Q6l6UNf542OZjuTnF1gBIl5jNWacGOwDDPjhIpSSBO5bjKTHutAVt3g
 Lwm/4pVmz7FTZMUe0hmeNIaIs9GoUTF1YUDNL+IgT/Fta4BB8PFkWfKuCH49iO/a8GDC
 tyoprb4mU7lzMEvSsflR8MJfI/1b53bUcH+ZkaLXbZzk/gtocy2jtZRXgKCtTCstdKQP
 er6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401996; x=1771006796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Pn8dV0n+ZYComEO5IK/QNCCh7G+UzHwPjkdirZhzUw=;
 b=lBKeHyoNbzACv1cHA89PI4XDYusqPtdWAFt07TmnD3MsQ6YUHPtUAz25tTLX+F4Bey
 xflA+VHH/j0SLgNboVewEXKPd9xxWcMOg+BsniDRP1cXLj0XYIKh+WKGQ49gClTrrPl0
 EVU8y4FF/OfMq3q04rhTTdM8ClXMbkrfEuBSa0UF+eQ5ukWCUxJ31NeaR62RuYD6yTQh
 tgyw7zT7mAekqbfbdOliuakPho7OZuyFqRUJ7quR5fW3iQoPtlohOtE+spGZA4gWAQES
 Parxz8v694HflWMXw+mvlClWa+sytzWJ6ass8GldqtPhJEOHfNNigzZAgRfLH9Q0x+Zj
 VHmw==
X-Gm-Message-State: AOJu0Yx2JOfKiXUuse9p1ow/JDSQhC7b1/L0/gpKwdNesoAr1VTYSm65
 5iCMz5OKg/fMLYsUZmspZNOriwB9T0igqzbhWENBLfuY1OFCVo3UjaX6VtHeb3HxLRwvBD7Dpsd
 guNRC8F8=
X-Gm-Gg: AZuq6aLUWJYM02+raGMyeHPm6G9LOuCIc6466qNKqAKXAWoNSp0zg5lV2EJ3xelSDJr
 S377dJvsWwyEyrcQZoZTk7F9lPSTdD9maskQQAVr1U478QjPaFZTfecJ0KZGZR4To/LKvuLVHgV
 NIn9q0iNfkhTjgBBX+Mzy98ORI25cAqTKIDZD4R7PDLOxG8wWHMcODKL1K8zaEl+cHuIkUJdsMk
 v9gZ3fcd/pBEKI2YsgyyNgm7Rs82ea92bWoqu1eea1saELGA0oX3fkw2p7IyFHmGoCgaS5QuSFA
 0j5hHIcXTXmBWIvZBKJqlgNLoxRSiRMm9a90yvSnQhuh6kuD8c8vLl4dIsftnBBEV6aj07zG6AB
 p2IXnmKcdroXmExoBAW7x/aMgiJ8SOwWydmq8o8TOwduTvvTvKd6A7KPrzfvNOKFeWJWUmIPU6p
 0jKHYWwFWzOOhmmpd9Q4zSkviMmUOnar1P3HVlAF6LTxutkDbjbDdxQvgvhEXiInMk8e13ar0=
X-Received: by 2002:a05:600c:8b45:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-483201e713fmr44959195e9.9.1770401996478; 
 Fri, 06 Feb 2026 10:19:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3e245sm145112765e9.8.2026.02.06.10.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:19:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/10] target/s390x: Prohibit target_ulong and
 TARGET_PAGE_SIZE uses
Date: Fri,  6 Feb 2026 19:19:43 +0100
Message-ID: <20260206181953.18683-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Series fully reviewed (Thomas if you don't mind I'll merge it
via my single-binary tree).

Since v2:
- Added R-b/A-b tags
- Use hwaddr in mmu_translate_real (Eric)
- Add gen_features_h to s390x_common_system_ss[] (Pierrick)

Since v1:
- Drop merged patches
- Added R-b/A-b tags
- Use address_space_ldQ_be() in read_table_entry()
- One patch for vaddr replacement and another for hwaddr
- Do not remove the TARGET_PAGE_SIZE use in ioinst.c
- Expand TCG definitions for fixed 64-bit target

v1 cover:
- Restrict WatchPoint API to TCG
- Replace target_ulong uses by vaddr / hwaddr / uint64_t
- Remove the single TARGET_PAGE_SIZE
- Remove CONFIG_KVM from headers
- Compiles objects as target_common_system_arch, effectively
  forbidding further target_ulong / TARGET_PAGE_SIZE uses.

Philippe Mathieu-Daudé (10):
  target/s390x: Use address_space_ldl_be() in read_table_entry()
  target/s390x: Rename get_phys_page_debug() @vaddr argument as @v_addr
  target/s390x: Replace %target_ulong -> %vaddr where appropriate
  target/s390x: Replace %target_ulong -> %hwaddr where appropriate
  target/s390x: Un-inline KVM Protected Virtualization stubs
  target/s390x: Add more unreachable KVM stubs
  target/s390x: Build system units in common source set
  target/s390x: Expand TCGv type as 64-bit target
  target/s390x: Expand tcg_gen_qemu_ld/st_tl() as 64-bit target
  target/s390x: Expand tcg_global_mem_new() -> tcg_global_mem_new_i64()

 target/s390x/kvm/pv.h          |  27 ------
 target/s390x/s390x-internal.h  |  14 +--
 target/s390x/helper.c          |  10 +-
 target/s390x/kvm/stubs.c       | 170 ++++++++++++++++++++++++++++++++-
 target/s390x/mmu_helper.c      |  33 +++----
 target/s390x/tcg/excp_helper.c |   3 +-
 target/s390x/tcg/translate.c   |  66 ++++++-------
 target/s390x/meson.build       |   8 +-
 target/s390x/tcg/meson.build   |   2 +-
 9 files changed, 240 insertions(+), 93 deletions(-)

-- 
2.52.0


