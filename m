Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ABFCFD62A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTH4-0000St-Oq; Wed, 07 Jan 2026 08:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTGs-0000OI-QY
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:18 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTGn-0008Lv-Lj
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:15 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so352366f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791290; x=1768396090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RLptu5fY3BsEtpcA+/3p1BCm5F6S2/6BZIH7JHxIXmM=;
 b=M0H8Fe+5ZoLjpwXIteNSlXQ8LbVHlpZ5JPIZoySQoC7eG5QXMl70eBpdoguH2Hd6Xw
 oqsgztBiuWPXyYcS30vbDjbcbwtMuZNmg0+Oup/E3MEoNwTKE3F8nht9zCsOWKvzyC+b
 c+h6dsPdWUc9Y+uC1olapAd2MirsFGrWt/H6AMeVRPgpC3nIh7LSMz0FH9cbwpfiirYu
 agMuAmiUF/X/tQy72SjNn9rtBs/iSaGL28gBmL82SAyhJR8gt6WlaKi2ObVibXnl+opA
 7TVuEVku61xV4GWPEurYjZYm4vF+zr9P8hsLEZ5Hq4ZXENEymYJ35rIyNnBCT4Ldpdnm
 Mgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791290; x=1768396090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLptu5fY3BsEtpcA+/3p1BCm5F6S2/6BZIH7JHxIXmM=;
 b=EesvmBNWdlyVjJYr4lxuD8NWbPc/6vs5TbeE455crESCXDf1JYOQ9tvcgql1M5PV6u
 beDck93ehf6KHkHt2rY47/EFype4n+HhQ97ui/abjLm0HlU0ZNWKcixOPn+rrUgXYqJC
 8N6gxVNy5FoJjy0M0JQPK9Af/JZkUcOuCSpjS2Q4meqEnxSxV9l+w/Y2j9OUXonrfVzA
 Z8qX7oIiTYBCOiNT4WKo5pQmYjbg1j6XHsZRV0CXBaRgFTRk0jPf3svh4okgAHmHayy2
 Va6YgJo5rB8587jn5MQJVX/DCi/gffzrH5KW9BwY3RIFpR6lEzIM44WY7ThuU/DM8tZg
 OQxg==
X-Gm-Message-State: AOJu0YySKfZgD/Bp/6e9OpJgVlK0G4CbxrGVa4g18bOkLtsnHXeDXfNU
 SkP2hK0J+T+qsAnENtqvg5PW0w5NgYq3nDSSMhqtggISlFJmYxQuA13+r647IrZ4Cfua6Y+XLMg
 Cdw94zrw=
X-Gm-Gg: AY/fxX7OgzPxr7n9ImeANzwHZse6zxlymuGeN1vZEfT0vPmFgqpSpt7d0wIPkBhGFO7
 KcOebOnbKKSCbY0WtMuo8A55nU2FuB2vw05mAf9gFE+26th8e+PUe90fOTeDLye47xU3E09HPNm
 iu2tMRlgFKGpwui+7gX3Tjj2gCbKJER3dwm6mpaClCCNeiXztFdS0sUEFdY+wCCzQdBJOSgRkwM
 du3HwBFwfmf4KTr7FrnQpLnKBblqJlVaVQLqz0qVKdUmWsE5raxn9+wQxujpnUqsRRdjEDaZANc
 nYLwZh+jJdyUwHo9SbJRdbvnuql0fDCk7BgdQfaoAGYwt5aMAD6ZGal+MO9vGSA36xxmXRPvovH
 nnhk4YBMVxufQxC4m6V9hAtOmrlyuRHb6z83H9nSZrMoaCJktqjG0NbZ5tFJRhrrq7THCjctM5Y
 3C014kUhuBzODaP/GejcpsE51RYkLCRJc1aLnGOkPu+xMABvHbiHWfPzfHHMjl
X-Google-Smtp-Source: AGHT+IHbaj59qiRBSUSw6iYQgZzI6L4kWVvFAMdCYVJWxRIFGKh012ARW4NCdZCJqkHJZDQ+d3G88g==
X-Received: by 2002:a05:6000:430e:b0:432:b953:b02b with SMTP id
 ffacd0b85a97d-432bcfd3d7cmr8006502f8f.16.1767791289618; 
 Wed, 07 Jan 2026 05:08:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm11135309f8f.24.2026.01.07.05.08.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/18] target/s390x: Prohibit target_ulong and
 TARGET_PAGE_SIZE uses
Date: Wed,  7 Jan 2026 14:07:48 +0100
Message-ID: <20260107130807.69870-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

- Restrict WatchPoint API to TCG
- Replace target_ulong uses by vaddr / hwaddr / uint64_t
- Remove the single TARGET_PAGE_SIZE
- Remove CONFIG_KVM from headers
- Compiles objects as target_common_system_arch, effectively
  forbidding further target_ulong / TARGET_PAGE_SIZE uses.

Philippe Mathieu-Daudé (18):
  target/s390x: Restrict WatchPoint API to TCG
  target/s390x: Use address_space_ldl_be() in read_table_entry()
  target/s390x: Use vaddr for $pc in get_next_pc()
  target/s390x: Replace target_ulong -> uint64_t in gdb_write_register()
  target/s390x: Remove unused 'gdbstub/helpers.h' header in helper.c
  target/s390x: Replace target_ulong -> hwaddr in get_phys_page_debug()
  target/s390x: Pass vaddr/hwaddr types to mmu_translate_asce()
  target/s390x: Use hwaddr in mmu_real2abs()
  target/s390x: Pass hwaddr to mmu_handle_skey()
  target/s390x: Replace target_ulong -> vaddr in get_phys_addr_debug()
  target/s390x: Use hwaddr in translate_pages()
  target/s390x: Pass vaddr/hwaddr types to mmu_translate*()
  target/s390x: Introduce CHSC_MAX_REQ_LEN definition
  target/s390x: Simplify S390_ADAPTER_SUPPRESSIBLE definition
  target/s390x: Un-inline s390_is_pv()
  target/s390x: Un-inline KVM Protected Virtualization stubs
  target/s390x: Add more unreachable KVM stubs
  target/s390x: Build system units in common source set

 include/hw/s390x/css.h         |   2 +
 target/s390x/cpu.h             |   6 --
 target/s390x/kvm/pv.h          |  51 +---------
 target/s390x/s390x-internal.h  |  16 ++--
 target/s390x/tcg/tcg_s390x.h   |   5 +
 target/s390x/cpu.c             |  30 +++---
 target/s390x/gdbstub.c         |   2 +-
 target/s390x/helper.c          |  49 +---------
 target/s390x/ioinst.c          |   5 +-
 target/s390x/kvm/kvm.c         |   2 +
 target/s390x/kvm/pv.c          |  18 ++++
 target/s390x/kvm/stubs.c       | 170 ++++++++++++++++++++++++++++++++-
 target/s390x/mmu_helper.c      |  33 +++----
 target/s390x/tcg/debug.c       |  85 +++++++++++++++++
 target/s390x/tcg/excp_helper.c |  35 +------
 target/s390x/tcg/translate.c   |   5 +-
 target/s390x/meson.build       |   5 +-
 target/s390x/tcg/meson.build   |   3 +
 18 files changed, 340 insertions(+), 182 deletions(-)
 create mode 100644 target/s390x/tcg/debug.c

-- 
2.52.0


