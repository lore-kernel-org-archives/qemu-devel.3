Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AEBC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs47-0000Ps-QO; Wed, 04 Jun 2025 13:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs44-0000Od-OB
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs40-00033W-BR
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:10 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2352400344aso1048985ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749058686; x=1749663486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I1II+3YQnG90HksUR5dl1/2JKfZzGM6a2Go/eJtjLcU=;
 b=fzQZ9pcJ/TyY2ENkK+nJzyTWjCEsZmRoee7/LGm2EhguYvLmybROn16TDddx0uM/De
 BeBWoP0pNdn3DYv2Qbbig6APxK9rvTXnWiNUZG/AScX31xCaXowHO08mbPyaVrp97W3S
 9Nec6VHLq94D6vAZ9NKLqEoD7Na1asLj+m47A3Brpag6JfhNt3fiHdsOiub0OV7BwC+b
 mZqnsJ4aGVRNdj0srzR9nInY8KG+e46wtmqCjsscfxvp1nbRIdKNx+aDMWb4MFdoIhMA
 +/l3NyypA9a4dTER7jjRC0ckEj4KQOesplAyLP0umlaYTfcMKk3VXtx0B9TNK9A0bLMt
 K74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749058686; x=1749663486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I1II+3YQnG90HksUR5dl1/2JKfZzGM6a2Go/eJtjLcU=;
 b=gWM303p00qKJAM9L7q60Lm9ieWDSTQi1EwckxC0kojnh17iLfHjyv9BVlwfgooYDgr
 975p2+3ooaWIr2QiFz+VYRSmmeq3/0OQ9oaH7+axnX+hOViVi/x9cGtLFQp+sJ89A34l
 /GerR96iy5GNZheiirxx8lwC1vPRswQyZ6Ga+i1s7BCDWGj3rnH60yQgHeBQ+4Rby9tI
 mzQQLrfZZxCwk6dL7uvtVQbFKVYj0uYLcT8h+kgjseftkesb+6I88TPObykl8RysNEiX
 VZGCgpGx5cjIVz7KYI8YPfeTaJZEJ09N1qpvqbXhnzouf7VaDjNYib5FdhEqLN8JL7HF
 B9zg==
X-Gm-Message-State: AOJu0Yx8OIBUxlLjehnQfb0MHagM7+ZzXtNM462xcI0El2gAsCOHleAZ
 CNoeeF1E9daxDKYU3Gzt6LPlwqzMwwfvaoEXHfSonjuGEfgw/PU9JH+tTxuJNf6E02OLQg5MUDT
 lQ0c5sCnr/g==
X-Gm-Gg: ASbGncs0AMcSpJnXMMI1kYRL6qWG7aU5nigkb2cy9rta6jN4YpH/RKX3l1YgnRrhOoh
 viBloq+WovY41ojIYhTzPOS9OCIPn6ILRcLXoGpCKB7z74F9BjqLlUAoFT9DMBqplkj+0omptps
 /6Z/cWlxDGOPZ0T/0SOa065LBHGeCxj8+NkoLfiLg+K4hsBElWbyQ1/Ltcq4jbipedEh4qFe4R6
 CxB6gIv3xGAC8Q4qgE/4nBwVgId3IQZU3qeenjFD3evRQ8EDlSqj/Rh7MmITfvs2IOUVBYQrdnJ
 54n0f2hpiRLkA3BZtrXmH0FLGB04wSvWaF9U3LfxqLs/GASb3Mo9eH475SKRRDP5BYgmkKHLUxh
 5w+6WmQZuIJc6lII=
X-Google-Smtp-Source: AGHT+IHB22/IF/9lX/non3K2V4Yyxxe+IOmpKek42afG0wPqGvqX0FsqLmI/rPZ5dWT/7FPgi8reoQ==
X-Received: by 2002:a17:903:1b67:b0:234:c8f6:1b03 with SMTP id
 d9443c01a7336-235e1518a75mr48265395ad.47.1749058686564; 
 Wed, 04 Jun 2025 10:38:06 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cfcbb9sm106913215ad.208.2025.06.04.10.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:38:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/3] target/riscv: add missing named features
Date: Wed,  4 Jun 2025 14:37:54 -0300
Message-ID: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x642.google.com
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

Hi,

In this version I fixed the problems caused in bios-table-test qtest by
patches 1 and 2. 

A small change was also made in patch 1 to avoid spamming "Disabling
sdtrig due to priv spec version" warnings when running vendor CPUs
with priv spec < 1.12.

Patches based on alistair/riscv-to-apply.next. 


Changes from v1:
- patch 1:
  - skip the warning and disable of 'sdtrig' for CPUs that have priv
    version < 1.12
  - update bios-table-test
- patch 2:
  - update bios-table-test
- v1 link: https://lore.kernel.org/qemu-riscv/20250529202315.1684198-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (3):
  target/riscv/cpu.c: add 'sdtrig' in riscv,isa
  target/riscv/cpu.c: add 'ssstrict' to riscv,isa
  target/riscv/cpu.c: do better with 'named features' doc

 target/riscv/cpu.c                |  16 ++++++++++++++--
 target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
 tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 416 bytes
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.49.0


