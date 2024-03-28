Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB67C47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 02:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfQn-0005GP-Mq; Wed, 27 Mar 2024 22:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rpfQm-0005GA-Mk
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:23:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rpfQl-0007kp-6K
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:23:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e0d82d441bso4418885ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711592629; x=1712197429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hIykPIYhtfAjI497q0sC+P7DqslN8xfGLgTXAyB/No=;
 b=BsB0yER3o3A+k/2iOPYPzC3HglzNreJ+NbY3ylGEhBE4uSXwTJ9rp4wb8ou7mMV9OV
 JnnF5v1nhXxYFsPp8vyZ1aPCcT6I16cqEatnvrpf+XCsGg0kr7nM4tTZol+nlk6pN9v/
 eK/oy7fdzlrTO9q0cWmL5p4QeANp7a76pTO3yeUeR0iuFeulTRVMhM46zEHR+JAbhBjp
 /ypdo1iyNja6MJFJH0Z3V4vBUfQiMn2yMMUQSSwxJXVmrm57KnAsjJCT0fqO8MVSLrHm
 xFzoyZj6zPu/+Ega0rh9wBy2R5wE4TRY5FEymRIPQOq+WCWTBdyXdSmfJdJaX2D+R9gJ
 t6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711592629; x=1712197429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hIykPIYhtfAjI497q0sC+P7DqslN8xfGLgTXAyB/No=;
 b=FP1NPwDM+lA7c0PuTzft+elr4KeWRuB3qt3IyWuhoy6GyLUcgp2KnkdGI+22ccjEPM
 nhBLNuhtzLwvdbh04dLScLCB6AhXNcYIluqu1KWSmX/ip0mjWBOCpt83pLTR2P87hF4X
 VReUpCngNGz04Ec/DSsQX7tJ3upVQeC4qZdNvvFo2FvWM8lYsOcoIVlti1Hpj4Tu+73Y
 04q/wFYqI3r6Xxl6uyd6mzNy9weiudKSvpSW/818DxKXreBDXXAeM/wC//9dsi4pKQJa
 MRKhRLc1sB4ouxY/Sq67sobFZuHWUi5/3mIhiZywcXLqt50qYm0RC42VMTjG+ZJxkUod
 VPbg==
X-Gm-Message-State: AOJu0Yz7yBikzHO4mYikfHbZ1EkPkQxAQcBlR7qyZK1t4L2Vuqkpgupp
 9E5JcGfwVCvpIxyOxIexBgcsItP3X+ng8oprNS98JG0wKsagi8CJXWSXyahecM88i53vKayDzI4
 xnNoi9o8b/pG6XAluFt1ThXmeYrY8x+c0nvcxR1Cwx8kjs9LC13LR6RdH1Vgwfr4S8wSQjMpSAR
 ng5vNxPlB1JBo135BrTHTFbv2xeVOWyDGD16B+TCY=
X-Google-Smtp-Source: AGHT+IHAXm04ubDxv3FdQPG88fwwJIOHKVOrE/NP0mbJEKqb8qhjYX1H+ZxVZlXPNagj0E+sR+p+HQ==
X-Received: by 2002:a17:902:db0e:b0:1dd:878d:9dca with SMTP id
 m14-20020a170902db0e00b001dd878d9dcamr1913596plx.48.1711592628859; 
 Wed, 27 Mar 2024 19:23:48 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a170903230900b001e14807c7dfsm247424plh.86.2024.03.27.19.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 19:23:48 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v3 0/3] target/riscv: Support Zve32x and Zve64x extensions
Date: Thu, 28 Mar 2024 10:23:09 +0800
Message-ID: <20240328022343.6871-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x632.google.com
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

This patch series adds the support for Zve32x and Zvx64x and makes vector
registers visible in GDB if any of the V/Zve*/Zvk* extensions is enabled.

v2:
    Rebase onto riscv-to-apply.next (commit 385e575).
v3:
    Spuash patch 2 into patch 1.
    Spuash patch 4 into patch 3.

Jason Chien (3):
  target/riscv: Add support for Zve32x extension
  target/riscv: Add support for Zve64x extension
  target/riscv: Relax vector register check in RISCV gdbstub

 target/riscv/cpu.c                      |  4 +++
 target/riscv/cpu_cfg.h                  |  2 ++
 target/riscv/cpu_helper.c               |  2 +-
 target/riscv/csr.c                      |  2 +-
 target/riscv/gdbstub.c                  |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  4 +--
 target/riscv/tcg/tcg-cpu.c              | 33 ++++++++++++++-----------
 7 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.43.2


