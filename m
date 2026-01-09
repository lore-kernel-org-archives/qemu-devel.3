Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9427D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFet-00083x-7G; Fri, 09 Jan 2026 11:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFeO-0007yY-HC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:47:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFeM-0006eq-QA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:47:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477770019e4so35182995e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977264; x=1768582064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zniQDSXNfJ4pWYDmzLQDIXZeRuLi67mD/NHN29Zhw/U=;
 b=qQxkv/xzwnU1en1ZsYlNxDAhpNb1yqYK3LTfsfVLzyoc5tPIv7/a/Pgk1FJMDFIFUU
 U1TeIks/vXdM4brWGc4MrNXJp3RtS34PFtBYED9raXfW1ny/svN61CulaYYntQb61cAM
 cYtdyP97arigQwWQ23Pri/2dApUBLUPifrNIMo7t/gl7xoyQmIe01ZXJUfWYXRT6PhFH
 obbAtFFPlN+x+QXLn09nifuqZ4HTzAG4hkwbldFFIltHMyUDbgdzlI6ZJ8msJzo2WUg4
 eLH/4F4w+8Oap4HkEwqo3Yxu+py9R+nC/wiBkZ8ySC92Ng+oYTuHCNKa4+cKxDR76gGH
 Vklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977264; x=1768582064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zniQDSXNfJ4pWYDmzLQDIXZeRuLi67mD/NHN29Zhw/U=;
 b=BpnKwAjzGYc44rvG7MQnPYxwDIFKa/HrX/nH4ungFnFj4OOGLk8/MOJZqL88RwFA+m
 cbcfZ12ojcxZM1DTM8fv3un1xmoKt2ZqdTK0zzOUKEQ8CMeJ8Nyprhe3d7vk1zkhXUzN
 wNNq+UnbZWQMtRmRsebs2LHkGT6xTRmEsO/nbfQJf88FXSn+CyDJdlA4vDGBJrVXfm6/
 YNfij51qFzpfiZbJshsiB16beddge6bndOqsb3qIA4o4YVdEDZnkha32/DdKYpoRaAH7
 Nw6ZbozvzWBIsy3wLaEzQKMM8LFDg5FOzXDkc3fPvvF3wdl1xX/cBDpfxlwlufiikS9W
 ZbpQ==
X-Gm-Message-State: AOJu0YxX18YOaIdWE5HOxjeCgcsdgHIn8tU8b0dVU9N1I15h70aRvrc5
 mLMEFbQbeXYReLWz0KCGKRXRt/yEo97nSu71mVcQEe42nLDLwR1HXjcrBd9AHjz8lAfqSY66TGT
 1DhgrxMg=
X-Gm-Gg: AY/fxX6BHCUI9vxezzSuulfxFUJAQlWKOHpJcb08ED0yEr25ZXE7r332tLlnF6uHm1R
 Jku3N6qdjm/DadniML7FwFF4r8p+lzoxLDTXv7VruOWsQGNARYG/dRkTYD5uzD7wIXW3WHQyLgV
 2sBceStkBPud8MMBP1aOb6TrqOJ5UmmCPh6P0HGNNOfQEqapdA+PD5nDqb8G+0PaLAOPGkFATPs
 T/Ru9StN5hbFTGhhD7mWJKFBQOCAz80+2lhbB5Dnp55lN1tELF6C94c289p6f6VqNQtQYZrm/I+
 aUBFDlE/nXILwDqjxlgMgnfzdAwBUNu5i6RRcVxxrr7Xmau+OHzbj3XtxiXMXvmUUpZz2SzlNi5
 9DpKi1B7/7KW/UVsk8dcr9HdyUulQtGfw8dAwiRDjGloVloMhroZOfXyipsGli4j8RZlrttQpab
 OshFVIWXvsxbrBhC8eQkjgNhBW1GxHXGJcGdSWxFusbIz3PRzGbM1i0OJZZy8TGvJwPtFn7SY=
X-Google-Smtp-Source: AGHT+IFqvzMQwBqNQoEU41pX21AI6Pa2+p5re99CemlH9dTarjKh0LFMISPIcXbUEZKCbzGIl2bqqw==
X-Received: by 2002:a05:600c:a48:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d84b08652mr120437825e9.8.1767977264082; 
 Fri, 09 Jan 2026 08:47:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87189e54sm65243515e9.12.2026.01.09.08.47.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:47:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/4] bswap: Cleanups around 'qemu/bswap.h' header
Date: Fri,  9 Jan 2026 17:47:38 +0100
Message-ID: <20260109164742.58041-1-philmd@linaro.org>
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

The point of this cleanup series is to avoid a circular dependency
problem between "qemu/bswap.h" and "exec/memop.h", since I want
to add a ld/st variant in "qemu/bswap.h" that takes a MemOp arg.

Otherwise I get:

    In file included from ../../util/qemu-timer-common.c:25:
    In file included from include/qemu/timer.h:4:
    In file included from include/qemu/bitops.h:16:
    In file included from include/qemu/host-utils.h:33:
    In file included from include/qemu/bswap.h:6:
    include/exec/memop.h:182:19: error: call to undeclared function 'ctz32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      182 |     return (MemOp)ctz32(size);
          |                   ^
    In file included from ../../util/qemu-timer-common.c:25:
    In file included from include/qemu/timer.h:4:
    In file included from include/qemu/bitops.h:16:
    include/qemu/host-utils.h:236:19: error: static declaration of 'ctz32' follows non-static declaration
      236 | static inline int ctz32(uint32_t val)
          |                   ^
    include/exec/memop.h:182:19: note: previous implicit declaration is here
      182 |     return (MemOp)ctz32(size);
          |                   ^
    2 errors generated.

Philippe Mathieu-Daudé (4):
  tests/qtest: Remove unnecessary 'qemu/bswap.h' include
  bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
  bswap: Include missing 'qemu/bswap.h' header
  bswap: Consistently use builtin bswap() functions

 block/qcow2.h                         | 1 +
 include/qemu/host-utils.h             | 7 +++----
 include/qemu/int128.h                 | 7 +++----
 tests/qtest/pnv-xive2-common.h        | 1 -
 audio/audio.c                         | 1 +
 block/blklogwrites.c                  | 1 +
 block/export/vduse-blk.c              | 1 +
 block/export/vhost-user-blk-server.c  | 1 +
 block/export/virtio-blk-handler.c     | 1 +
 block/parallels-ext.c                 | 1 +
 hw/9pfs/9p-local.c                    | 1 +
 hw/block/cdrom.c                      | 1 +
 hw/block/hd-geometry.c                | 1 +
 hw/net/can/ctucan_core.c              | 1 +
 hw/nvram/xlnx-efuse.c                 | 1 +
 hw/scsi/scsi-generic.c                | 1 +
 hw/sd/sd.c                            | 1 +
 hw/sd/ssi-sd.c                        | 1 +
 net/l2tpv3.c                          | 1 +
 qga/commands-linux.c                  | 1 +
 scsi/pr-manager-helper.c              | 1 +
 target/arm/tcg/arith_helper.c         | 1 +
 tests/qtest/acpi-utils.c              | 1 +
 tests/qtest/ahci-test.c               | 2 +-
 tests/qtest/aspeed-hace-utils.c       | 1 +
 tests/qtest/aspeed_smc-test.c         | 1 -
 tests/qtest/ast2700-smc-test.c        | 1 -
 tests/qtest/bios-tables-test.c        | 1 +
 tests/qtest/libqos/ahci.c             | 2 +-
 tests/qtest/libqos/fw_cfg.c           | 1 -
 tests/qtest/libqos/generic-pcihost.c  | 2 +-
 tests/qtest/libqos/i2c-omap.c         | 1 -
 tests/qtest/libqos/igb.c              | 1 +
 tests/qtest/libqos/pci-spapr.c        | 2 +-
 tests/qtest/libqos/virtio-9p-client.c | 1 +
 tests/qtest/migration/framework.c     | 1 +
 tests/qtest/npcm7xx_emc-test.c        | 1 +
 tests/qtest/pnv-spi-seeprom-test.c    | 1 -
 tests/qtest/tpm-emu.c                 | 1 +
 tests/qtest/ufs-test.c                | 1 +
 tests/qtest/vmgenid-test.c            | 1 +
 tests/unit/test-hbitmap.c             | 1 +
 util/bitmap.c                         | 1 +
 util/hbitmap.c                        | 2 +-
 44 files changed, 42 insertions(+), 19 deletions(-)

-- 
2.52.0


