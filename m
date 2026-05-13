Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E955CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN0ew-00057V-RM; Tue, 12 May 2026 23:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0eu-00056e-OB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0es-0006mQ-S8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:53:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-836ebdeb969so2940275b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778644397; x=1779249197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/sHoYy+CdnM4l3KtcEmY2+FMW8nJ+An51X3GR+zu5uM=;
 b=I26wgKuOAoky5Ijf6CWyMnTJ9oukYS50GI7Q2O8O6oWtJzWsbzulGtnx93LKt/CDcl
 Ryxo0Vp+alz7wqeWbq8tqcy22Zif93VieGYe57+5nqbbVifeqIesKItGHZwb5GnuiGA9
 aKRAwfVo+3a4f9j6VOHlRT67PbhD/rC0cEwXCF7Tk4uhKepMMoC9q7ZFp/KpHfgyIrQ6
 FJdf7WtED9yt6NUdBex4OyQL4SYxarHg/BYpV7O1O/xZ2j2d6aBF8wK8IlBnaGfBnUI9
 PK5BzUdskzmMrjNrSHdynYwvGtx8iEOW7Z5eWIkRRGN00IKaCGm+4PAeeY6lBjC93eig
 spnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778644397; x=1779249197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sHoYy+CdnM4l3KtcEmY2+FMW8nJ+An51X3GR+zu5uM=;
 b=idzVNRBTLGxJdVTgNy1DSLnIrkK+Mra6By3anz/mkT856ylk3DH7c+YFa/624NL+62
 oEmiPBqvHIirSjyaYtipZKY+IymkAJbvfEyrtGHHO21miw41a929AW+myJoOgwF5IbOG
 FlhOGAIEzYbe9EKdR+en7A4o+nqzUThcQ73zHivc6ygDzae/Okc9KvckG8xBFKjooyMk
 1k8ytXmqctop+UTVDHIXNgWlAFMak54zVCPyaJc2PuH2LQkH92KG+g46eJmwzmoi7fjE
 Ghn+8289kXASDNLnmQ6i1HUt6vfERDJ4kqQxBmfXHsMBH1045oo1mi403LCSI072KpxE
 lKmA==
X-Gm-Message-State: AOJu0YyX+VsAD4vu3ulmKQJR8qsg7jp2wHhzH06D5MmYTcoAEYH8e2ds
 imrGisK4WVuiZRD9ukjO6O5Zm5kZ7jYSikEnnk3JZlu04+52AFbw97Yf2pRV436vkSiYfjoVAun
 q5YlTKANGkwqH14CnHNgT+1PbSpAXHqjApBzTFBNuwTb14X+gn9h+jSoBzwwf/QUv5OS2VqFkgS
 NmhLjXMA8Zi0GOGdnziBHk49HKkXQ2aFmwgCk+3bojlMIwdCuC
X-Gm-Gg: Acq92OFqjXEb3dgHV3QBYVxzFXnerXVcf1KvOU8eygiyZHUG2pTDRoZS/s+ndZ9LcqC
 jqKype9jVJzLu3lPq+w9a2LCpkW2LbISRKIhx73DE90URLfjmq7FWtDd8yUx8G/rAStTYajqQd1
 qU0W3KQUHp7jxlMNWrE3SfVzFGZ3yTF3/6XB17l3FQBTCWhbJphSOyR6fSJfIFmgJdyqFNRm+eo
 CuIt0W1/yGjDde25Cv7YhtPOudqvWuos3ToQFcAPPs4xO04LeBarlmVDTSieVsn/xYiFHPg4R4t
 TNzo5/EcdhBCXq5RIXaVvzhXSDFTve1Tv7K8tI8mGrj8qDdTwKaY+cuB4nb08Smt9OPDwGwxjEG
 AHe4chONn2a8hjVSoTk9RO/IcQdn/KFUP97n3a7l2SopaGSWDFzXZA2LnEAsOI6tI8+nZ4yS3VT
 YAYmJAgp5rs9lWQvwzny6P5txTyDZwhPpLd5mh76ETiA2uwoVcZg==
X-Received: by 2002:a05:6a00:1943:b0:838:af72:fb1f with SMTP id
 d2e1a72fcca58-83f0547ad3amr1243021b3a.2.1778644396236; 
 Tue, 12 May 2026 20:53:16 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbdfb0sm24317872b3a.45.2026.05.12.20.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 20:53:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 0/4] Support the true Zicclsm extension
Date: Wed, 13 May 2026 11:53:06 +0800
Message-ID: <20260513035310.3764218-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x432.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Support the true Zicclsm extension so that we can trap misaligned accesses
when the extension is disabled.

Zicclsm is set to true by default to be backwards compatible with the old
RISC-V QEMU design.

To disable Zicclsm, simply set zicclsm=false, e.g.:
  -cpu rv64,zicclsm=false

QEMU will raise a misaligned load/store exception when executing misaligned
load/store instructions.

Changelog:
  v2:
    * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
    * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
      vector load/store whole register instructions.

Frank Chang (4):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Expose Zicclsm extension as a CPU property

 target/riscv/cpu.c                      |  4 +-
 target/riscv/cpu_cfg_fields.h.inc       |  2 +
 target/riscv/insn_trans/trans_rvi.c.inc |  6 +++
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
 target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
 5 files changed, 76 insertions(+), 19 deletions(-)

--
2.43.0


