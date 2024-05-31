Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45BC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6Jb-0001iP-0g; Fri, 31 May 2024 13:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6JZ-0001hY-Sq
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6JU-0007TP-Di
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f61f775738so15500005ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717177510; x=1717782310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ/qTMMKNgK+dp6A1jFbcUwntV+jWxExmtDXGcpbERs=;
 b=bxTtpEjhKCj2b29J7DzUzBrjFEVLedKwruPF8Ld7oDxcr6aJRXphQU2xcstLdWfXMX
 NQpP4PNw6Rqw+4ZTC1wA1qM3ZOwhS3Tzh7sAUEuKS9YvXja93DJxhOZVWr1G+CIBBc68
 RyHEm/CKlymv28DkkfbGH8i/Zt8flvBjNajAAn6Gxp1PpnSDuD2KejPic5QjkchEuKSd
 G78NkH4z4KXlCzoBmtmpajsHv3luYqBnEfmCpbLNQctjYO3sAps6EvcS34e7sFt3Hp5g
 JaR5uAZxIDJ/FgidtR68v+9SXjf0E/rySzBZ+b/D13458YNCjB4PEdolAnkzL+ktDhqm
 PnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177510; x=1717782310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZ/qTMMKNgK+dp6A1jFbcUwntV+jWxExmtDXGcpbERs=;
 b=bqo2pLLYCTPU+mgqmPwM/h1BIdqee00WALCwRgr49rk+z0MQrsZb53velKUA3x0q8C
 sMWiGCWhogsJZqT3Pf7filPRb0H0w/eQCIKI2QFIAlcRDjrJxzuabhGB9P91T98qOjEP
 GG07vdt6BayJMSUZx2MmVss8yz6R+OOngE8CtIZ1ktrv9ar8qaUFXC2A/opJiuxcsBsa
 XjALCs5U/yCSJmbUfT8xLt4yiM8ApxhL73A3zgc/8mMkcImrUM3A2BPq1k09SP/1fBfa
 /+Tu/B9FP5Ya46E4i7xtwZubG0j+ABuDQfRQyx475ynFI0Vgrin7ZQxAUZ2Id/TWwJXD
 NUAg==
X-Gm-Message-State: AOJu0YwQtXKr02PQMdJ1IBexpIFFIO/JxMiRaZvFn45hz/Xe/QhpoAZR
 z5GwU1vuOno0Cwu+UjNQtBGWw+RZQG4NnAHOHKsC7oYpA2kPIH4MKg1VKihJlL0hM6cSOQfubrG
 Rj4bjqCoPLMdSeSajOl6cCMNWVnIwiKC04wK3hqvyW1bopJVF1Sil3YUvRMhCUAnLnPF0tSLgpP
 /7gSkr2py+lbqpVONk5KV7QSkpMsOCq+5fgX9A/A==
X-Google-Smtp-Source: AGHT+IEN9hu2iTSqwTZabNlDWu7CSLk+EnGW3JFSyETJ1d2kM2fotv4ylCDw7cxdO0VISCu57TlIpA==
X-Received: by 2002:a17:902:d4d2:b0:1f4:ac10:3ee3 with SMTP id
 d9443c01a7336-1f637019b4cmr18534935ad.20.1717177510110; 
 Fri, 31 May 2024 10:45:10 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63236ce6dsm19389875ad.95.2024.05.31.10.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:45:09 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com,
	Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v2 0/6] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
Date: Sat,  1 Jun 2024 01:44:47 +0800
Message-Id: <20240531174504.281461-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

This RFC patch set tries to fix the issue of
https://gitlab.com/qemu-project/qemu/-/issues/2137.

In this new version, we added patches that try to load/store more data
at a time in part of vector continuous load/store (unit-stride/whole
register) instructions with some assumptions (e.g. no masking, no tail
agnostic, perform virtual address resolution once for the entire vector,
etc.) as suggested by Richard Henderson.

This version can improve the performance of the test case provided in
https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369 (from
~13.5 sec to ~1.5 sec) on QEMU user mode.

PS: This RFC patch set only focuses on the vle8.v/vse8.v/vl8re8.v/vs8r.v
instructions. The next version will try to complete other instructions.

Series based on riscv-to-apply.next branch (commit 1806da7).

Max Chou (6):
  target/riscv: Separate vector segment ld/st instructions
  accel/tcg: Avoid unnecessary call overhead from
    qemu_plugin_vcpu_mem_cb
  target/riscv: Inline vext_ldst_us and corresponding function for
    performance
  target/riscv: Add check_probe_[read|write] helper functions
  target/riscv: rvv: Optimize v[l|s]e8.v with limitations
  target/riscv: rvv: Optimize vl8re8.v/vs8r.v with limitations

 accel/tcg/ldst_common.c.inc             |   8 +-
 target/riscv/helper.h                   |   8 +
 target/riscv/insn32.decode              |  11 +-
 target/riscv/insn_trans/trans_rvv.c.inc | 454 +++++++++++++++++++++++-
 target/riscv/vector_helper.c            | 142 ++++++--
 5 files changed, 591 insertions(+), 32 deletions(-)

-- 
2.34.1


