Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68973D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFgB-00017z-6j; Fri, 09 Jan 2026 11:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFfu-00011w-R8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:49:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFfs-0006r9-Ta
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:49:22 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477770019e4so35192255e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977358; x=1768582158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2MerhSNz7Vn8RRCjmFwVg6a9IkrqyERaiCl6lwgb0h0=;
 b=Mra3MF59nwWFEvFRkrwPD4/iqKhfIyJ664nWOjt1adTCYsnjb+680s1tUuEDX69KAa
 x3N3cQDNClksqmC6r+nTEAaa7K/3gdqlV5XJZW20IQuNXDKnhNpi4aC9PqR6cvm4rPFG
 aJAkoS4gBFKpdlMI8gPUFt1uU6HsMsB2Ve1AOp7Wk4ARR6NCs3Pf/2O9uiPEoaV0Py6j
 Geagw9b9LDbKee5lfibVwmgyKDKLR7f2mxOtsZbF6bcWvLrcD4spjwANoS+WN9aILSK/
 17SeAnQ9bmzhJOOKspqcVBo+8UXpfaeW0wd7khaiAJFhinSdKYwHT6E69Xcp3hUEpuCf
 MJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977358; x=1768582158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MerhSNz7Vn8RRCjmFwVg6a9IkrqyERaiCl6lwgb0h0=;
 b=uLXXfxz/rI3vn1mBX/AgKFBcpPz1w8UR0vFXW5a40SGFOfJ0vbjt7ExfC7UMTz76DO
 M64kokDT41tDQXwfL04TGS0mW3N/p0TjCurf2Cc8/7QmyQcWkEMh9oGviTnQWifXZbo1
 Ok7SWO2SJFXAVbei05B2R1YXedN3iKiDkQoAuwnPRhFp0cFolwU9wRNbznrtksJKpe12
 QOgjV7Pusy3ZosOqDZw15wJrABZZzDiYC67Wt9Oipg96cG9QhFFDcHt6WEzek7KJ3svz
 it14jzqlW/3FnPonhEV81hhx+PYQ2smTAq7zBS4d/DyvWe3gi/5Hdismr5gEjoMPMU4x
 NPOQ==
X-Gm-Message-State: AOJu0YyNxvfcnaF8Yu53DsxTrZ1WtWOlC2OhAHg/RL7et1d6B5KcQ6J0
 o46J55nGX1HZ/TSZbsplKWDQGpCRsuo7FKx56IXBqt8ND8ejEjCIwX2rbVor4RTUnzuywhetd3N
 hxaNaclw=
X-Gm-Gg: AY/fxX6WkDgw0mPE9iWudcEXlO6O4hHlLu3GH2souKUYgF+zRuWlt+H7CMVW8f2Gy3b
 0SWDoYNONTaJuoIb80dVdirdDPOT/rWu1zpTypxuvlolo72sSb+wK6EU32q09wAkq4xY1hJoyR6
 2JEZlX5ThibedqR6TfZir58RuWC02pnRf9UHBdaDryGliPUoITEM9bwGat3oaxeWG9UJgewsr7J
 sNKegRR6k3B3BtmEM4aLypryiFnYReUQds1XVKb1UZAyWC9m3AaqRrMg659r1HMOMhmCERaMWAj
 SILrYL3dbeOu91/UExR/to02K9C1oFIyHJw++6E3F16ZxH+q4DtxIOk6dg/h0540RC58QihfHVF
 bvlfvDm/3oIan2G3rpWfhXcY1ESjHf9y51tYF+RXzSz8n2Sr1cZJXARrTwdjb2gPbkqOJPPpDeY
 xPAYXfJ6yFfmtXoac8ALR7RlgNLkkVlE6N8GpPcR1oEY+tlMgqEt3jJ4fpZYmobJCj5I6a77U=
X-Google-Smtp-Source: AGHT+IG/a+FC6douDBV45Uzzi5i4lLHvFS3XKKroM+JcRvKzH8ZBfqMC1Jkjj0pQiCHctACk/0MNFQ==
X-Received: by 2002:a05:600c:3143:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-47d84b179f7mr127677535e9.13.1767977358266; 
 Fri, 09 Jan 2026 08:49:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm229043115e9.1.2026.01.09.08.49.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:49:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 00/23] system/memory: Clean ups around address_space_ldst()
 endian variants
Date: Fri,  9 Jan 2026 17:48:53 +0100
Message-ID: <20260109164916.58713-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Missing review: 2, 12, 20

Since v3:
- Assign device_endian enums (Richard)
- Add/use ldm_p() and stm_p() helpers (Paolo)

Since v2:
- Changed opt-out to opt-in approach (Pierrick)
- Split big patches in smaller ones
- Mark ioport little-endian

Philippe Mathieu-Daudé (23):
  MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
  util: Introduce ldm_p() and stm_p() load/store helpers
  system/physmem: Inline and remove leul_to_cpu()
  system/physmem: Convert DEBUG_SUBPAGE printf() to trace events
  system/memory: Split MemoryRegionCache API to 'memory_cached.h'
  system/memory: Inline address_space_stq_internal()
  system/memory: Define address_space_ldst[W] endian variants via
    template
  system/memory: Define address_space_ldst[L] endian variants via
    template
  system/memory: Define address_space_ldst[Q] endian variants via
    template
  system/memory: Factor address_space_ldst[M]_internal() helper out
  system/memory: Pass device_endian argument as MemOp bit
  system/memory: Use ldm_p() and stm_p() helpers
  system/memory: Directly call address_space_ldst[M]_internal() helper
  system: Allow restricting the legacy ld/st_phys() 'native-endian' API
  system: Allow restricting legacy address_space_ldst() native-endian
    API
  system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
  system: Allow restricting the legacy translator_ld() 'native-endian'
    API
  system: Allow restricting the legacy tswap() 'native-endian' API
  system: Allow restricting the legacy MO_TE* 'native-endian'
    definitions
  system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition
  tests/qtest: Remove unnecessary 'qemu/bswap.h' include
  system/ioport: Declare x86-specific I/O port in little-endian order
  system/ioport: Do not open-code address_space_ld/st_le() methods

 MAINTAINERS                                  |   4 +
 include/accel/tcg/cpu-ldst.h                 |   2 +
 include/exec/memop.h                         |   4 +
 include/exec/translator.h                    |   5 +-
 include/exec/tswap.h                         |   3 +
 include/hw/virtio/virtio-access.h            |   1 +
 include/qemu/bswap.h                         |  11 -
 include/qemu/ldst_unaligned.h                |  25 ++
 include/system/memory.h                      | 193 +-------
 include/system/memory_cached.h               | 212 +++++++++
 system/memory-internal.h                     |   2 +
 include/system/memory_ldst.h.inc             |  52 +--
 include/system/memory_ldst_endian.h.inc      |  33 ++
 include/system/memory_ldst_phys.h.inc        | 113 +----
 include/system/memory_ldst_phys_endian.h.inc |  57 +++
 system/ioport.c                              |  34 +-
 system/physmem.c                             |  35 +-
 tests/qtest/endianness-test.c                |  10 +-
 tests/qtest/libqtest.c                       |  13 +-
 tests/qtest/vmcoreinfo-test.c                |   1 -
 util/ldst.c                                  |  69 +++
 system/memory_ldst.c.inc                     | 449 ++-----------------
 system/memory_ldst_endian.c.inc              |  70 +++
 scripts/make-config-poison.sh                |   1 +
 system/trace-events                          |   6 +
 util/meson.build                             |   1 +
 26 files changed, 599 insertions(+), 807 deletions(-)
 create mode 100644 include/system/memory_cached.h
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 util/ldst.c
 create mode 100644 system/memory_ldst_endian.c.inc

-- 
2.52.0


