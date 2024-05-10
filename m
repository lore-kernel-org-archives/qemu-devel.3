Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32D6C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q8P-0005tg-S7; Fri, 10 May 2024 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8B-0001b3-7z
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K89-0004mY-Di
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1edfc57ac0cso13697935ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715323999; x=1715928799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wbcoTGQsQfhcqpzVKOMYAv1z76MuqWF+V8w8d6q9KQQ=;
 b=OA0TdMaSg/vQqI+reFp1mH28ZHvFESw0yJhQN5o4PiMWFFF/GIlh3YD0v0MJoPmnge
 ZfUOuN0i+BKa91WQTXCKnxaTZrUoHF+qMYGDbi95uQ9ZouRYKRc746vhAGbQVN5GtwUY
 2VeBTVevLsq6jrjNOJU2oe5slJvUXnyKbng9RwWIOgNeJSSua1+nFaMXWL90Wg9UaNdb
 Iw5a6aHtx//FQ71floSGyoC1oo7ziLyoeBUGzO9Z1HF6RsgmBy/disC1NYgNbVOifOER
 w5lMMTIGk2aQVgqEXXYsJNiCMgNsusrrXfYfpm/xBrtpvBOFHCMLs8QKRNELMyNeG9lz
 wtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715323999; x=1715928799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbcoTGQsQfhcqpzVKOMYAv1z76MuqWF+V8w8d6q9KQQ=;
 b=H95WfaTuwlYcXzahT2gvVttluLF2OF8kxVqWEFKWJm7X0eAIBcHsTyqU6GEvUW5NvW
 xK2Y2TeB9uKBZmhagbm+k7izybcFhZkJtpMblRevH+5CIu6FfWG+ulA8fu9Umc2/f3+8
 ZVOCNkiUrxDS7ENwnTR8mxqy6Dd2aBzHmkHiIDHzxi9qC3tDxZyHD+sqA4RIZ/Wegvbv
 7k7kbF1asMtGWwDlt46ahq0uxuISUKhDj05xwcFCad5baDJX/NmCCaoZQmdgmCrRGCO6
 ZnS+Xo2vJIB4DD/eNTjWZKmD85qMwSiGaLF7PEVgQoK+mCxupO3Fj0S9ifG1zD/GQjzj
 Q6vA==
X-Gm-Message-State: AOJu0Yw65AX3mvs7VoPebZObOK53ghCV/a8uWxcCa1V87eyaucSlXZis
 PS8DUyZ1vlS/Ce/0voUV8ndEevGbnTl4vGp2l+deI3D7xmCqvQKAjsgQ8EEeOYW4b+aKo+D4Wes
 YJeX355EH6NmYgpjJUWlSGxHft9pcCLacwx+ksQEGCpB+A4RR43cs2FJIQAOu6Wuhc4fA7kss3F
 +PVnDKNopGY3/kbmfQn+NGBEn+biIqeEa2X1w=
X-Google-Smtp-Source: AGHT+IE8joIeoUVz7wGyavTcn9xUfFz4cHOKKVRGpXif9rBaeHBu9+DaVuMJx5F+Dpf5oT5Acw7SpA==
X-Received: by 2002:a17:903:110d:b0:1dd:bf6a:2b97 with SMTP id
 d9443c01a7336-1ef4404b5c8mr19964485ad.60.1715323999306; 
 Thu, 09 May 2024 23:53:19 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31a7asm25579175ad.140.2024.05.09.23.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 23:53:18 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 0/5] target/riscv: Support RISC-V privilege 1.13 spec
Date: Fri, 10 May 2024 14:58:50 +0800
Message-Id: <20240510065856.2436870-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 May 2024 09:17:57 -0400
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

Based on the change log for the RISC-V privilege 1.13 spec, add the
support for ss1p13.

Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72

Lists what to do without clarification or document format.
* Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, implementation ignored)
* Added the constraint that SXLEN≥UXLEN.(Skip, implementation ignored)
* Defined the misa.V field to reflect that the V extension has been implemented.(Skip, existed) 
* Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches)
* Defined the misaligned atomicity granule PMA, superseding the proposed Zam extension..(Skip, implementation ignored)
* Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed) 
* Defined hardware error and software check exception codes.(Done in these patches)
* Specified synchronization requirements when changing the PBMTE fields in menvcfg and henvcfg.(Skip, implementation ignored)
* Incorporated Svade and Svadu extension specifications.(Skip, existed) 

Fea.Wang (4):
  target/riscv: Support the version for ss1p13
  target/riscv: Add 'P1P13' bit in SMSTATEEN0
  target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
  target/riscv: Reserve exception codes for sw-check and hw-err

Jim Shu (1):
  target/riscv: Reuse the conversion function of priv_spec and string

 target/riscv/cpu.c         | 10 +++++++---
 target/riscv/cpu.h         |  7 ++++++-
 target/riscv/cpu_bits.h    |  5 +++++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/csr.c         | 41 ++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 17 ++++++++--------
 6 files changed, 69 insertions(+), 12 deletions(-)

-- 
2.34.1


