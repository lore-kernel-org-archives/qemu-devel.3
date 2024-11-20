Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071B7D6E2C9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfQD-0002Oe-9T; Wed, 20 Nov 2024 02:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQ8-0002OA-I5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:40 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQ6-0006Ow-VH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:40 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20e576dbc42so55611015ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088797; x=1732693597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lx8gSsMPcpKaXpF+fhiy9ywM3N36Ncsg9WggqHtgxks=;
 b=M1RoZ/C1rO9drf/gYVe9taJQ8urJ2Ov2EHxUhYfOLhbLmG3GAS5IA0HAY/ZMd5sXO7
 owd6Hu5clHRkqtvlWd5zEneqjrF319NWuRtbaPREOLBrre2LlRixvRYeCdACwOQ8eV1A
 9TWZtdySiIJz+0n0ux1gitF8Hu6JmfQVByQI7w7zpvUqQnvSlsQBC5Ap3+VrJQ6u7yRV
 PcC7kdopFxFj2+LdfZ+xRJZX2qzw/RqT37hZJF4sagUpprRzlDrQRYw0HaG3FatdoTh3
 4I5zc0rvDm1NlVKC7B0zUzw/lIAdtDLlw/V6Kx+5FNHebnIQyM603orS4UcBTwdaVo7c
 qB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088797; x=1732693597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lx8gSsMPcpKaXpF+fhiy9ywM3N36Ncsg9WggqHtgxks=;
 b=Sp0cKXZMGcYfM2/4wbdghHMDtNVb+67TBPP6FGIMpcawo7rumaNULW+XsCUDDp7URy
 VqiG8bH1Kii/7ZKKcN/hJpu2tiQBBHpegIkaiXWCDWVudsHPefgc5rr9UsxlNAfyDol1
 pM8bbELrZgntQ4A1qn6xhuWJFioJKexJQqHdfNcHzfFDrjKGRAb+y9H9HNFRVCHXeUXO
 nYSKozmrf80R2EFd8lZlUWI2tYWzEWbFjrKS3uOaNteEmrY50Y4j9uQ7CZLQ438BJTcF
 xx7Z+/YCP1xl0Kw3Iw7BBxK/ZbNfFqB+MfCJnmQZlQ5ZiuQneQZFHfD2z78dO5CItwfp
 ADeg==
X-Gm-Message-State: AOJu0Yyu+NGr9JNj+7OJo255ceubO6+uVYjfcaOrSn7Mh2VBads3e6iJ
 pToLdxY3+6UEL1+jUXDyZrTRzboSdPtasQHCp/IKKZQDYq9FsxPMbUX1JnOR59NctkPCE8AKhkx
 kUIzN3OLzRVajAwGcJfsN8f6aBmyK4PMxbM3mzkBsru5Ec8Vo7kgupK5JbkW2gGHYzoPYpBbMYH
 k6C2JDUvTYsaUww8QygzydirnMPm4hH9g3fzc=
X-Google-Smtp-Source: AGHT+IHSHlTb44sxmtteY2yu7zB4YRpSgArDtHjN5OWK0brMlghjgOmQ900lTESYzbKqLTQ+Uf7RQw==
X-Received: by 2002:a17:902:e74a:b0:211:6b23:9aa8 with SMTP id
 d9443c01a7336-2126b0139c5mr23095335ad.36.1732088797123; 
 Tue, 19 Nov 2024 23:46:37 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51fe0sm86206255ad.233.2024.11.19.23.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:46:36 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v4 0/6] Introduce svukte ISA extension
Date: Wed, 20 Nov 2024 15:48:48 +0800
Message-Id: <20241120074854.1767780-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x635.google.com
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

The Svukte ISA extension has been approved for fast-track development.
https://lf-riscv.atlassian.net/browse/RVS-2977 
And there are Linux patches for the Svukte that are under review.
https://lore.kernel.org/kvm/20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com/T/#mf70fcb22cd2987ad268c0efee9b8583197d3cb4f

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

base-commit: 27652f9ca9d831c67dd447346c6ee953669255f0

[v4]
* Add a svukte extension check in RV32.
* Refine the code.

[v3]
* Fix some typos
* Refine code by separating a function into two dedicated functions.
* Follow the riscv,isa order

[v2]
* Refactor the code

[v1]
* Add svukte extension


Fea.Wang (6):
  target/riscv: Add svukte extension capability variable
  target/riscv: Support senvcfg[UKTE] bit when svukte extension is
    enabled
  target/riscv: Support hstatus[HUKTE] bit when svukte extension is
    enabled
  target/riscv: Check memory access to meet svukte rule
  target/riscv: Expose svukte ISA extension
  target/riscv: Check svukte is not enabled in RV32

 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu_bits.h    |  2 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu_helper.c  | 55 ++++++++++++++++++++++++++++++++++++++
 target/riscv/csr.c         |  7 +++++
 target/riscv/tcg/tcg-cpu.c |  5 ++++
 6 files changed, 72 insertions(+)

-- 
2.34.1


