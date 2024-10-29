Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F04D3A698
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5s8G-0002BN-Pg; Tue, 29 Oct 2024 15:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t5s8D-0002BD-2N
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:43:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t5s8A-0006Bw-Gt
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:43:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so75797625e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1730231032; x=1730835832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lFEXZxJ0YG5w2mjcHdnNumpjQ1Pxoj+3fOS8dRlYHaw=;
 b=aUwRI3DsIVXr9vB5aupUdFePGuyBtsA0maY5Bnc4ZMw3kJq0N1x8+Yxeyh1iQW193A
 QukO+V31uGgsXuSo7YMg5tZug31O4SBrMr392cEXkK9cMiQB/mpPQLOhiTjq8dAlQQeY
 4RC9Nh/f85PlyZbQZxYnW0Wvyf8hs944SSSNYfgVOo3P/LS8bSELSOpe2Xr5eGJHd79D
 DkqkGMitNkrNU4M0zcrTnpcHjy7rs1vt3rNZNJbaijVKVaWOMcRXJxTJwkXC21u1+das
 k6q2b/VSUzQ1ODxzKq7XlUjudlBcChGmbM04E7lZITVWwNAkoKeKI9C4lIOpA+BN2wHr
 QdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730231032; x=1730835832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFEXZxJ0YG5w2mjcHdnNumpjQ1Pxoj+3fOS8dRlYHaw=;
 b=IRA2JQuffa4G+NmP0KfV6lRoeToepLY9EaSkkWrnzqtzTt2B6XyYCAa3AoCuPp5OfS
 cD195toeZ/rhr8TK/OU0ePDQHXHMuVBITzAFr/36Lw/0VjmqvawlDNFdXnLGSmEgZ7Hc
 KSqgEChh0KusNLVV/0eQdqU8J7r2rq5Bae6Dhh6DZKp8WZD7PLnptwCyJwjd4RJklDh8
 hVNLCcvBsujlltt9jYm0sAu37BRQpxhC2scNsjNmnUHjxvXGOnHKBv1/FaPjt+LuAK9D
 mrgq3XaKPYqC0UIjKkChX5VF1vr/RFwTJgpCWfj0U3NrfN8m4TD0TYWJve7XTLk6DKvV
 2hsg==
X-Gm-Message-State: AOJu0YwkIG4ZNuAeQUI1Ewl+4+lIGrpPOOLjsZmaGm+0dfjWFh4tgoy+
 eI/rD7W22ZImu22hv9uLgEMfeDefSZOD612N63JtwcplYMHA1N7yCmxn79syzAVNU+Ejg7etkkb
 WJntftA==
X-Google-Smtp-Source: AGHT+IG3E7I0lWRjUurZwtb9W7tKyKITyXMa7/G8hOHwatFJqtSyCKkU/X2kljjFhivH7RILQkCnLQ==
X-Received: by 2002:a05:600c:5248:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-4319ad065b6mr114297985e9.27.1730231032438; 
 Tue, 29 Oct 2024 12:43:52 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:2972:f115:541a:90f8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573551sm154348445e9.6.2024.10.29.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:43:52 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC v4 0/2] target/riscv: add wrapper for target specific macros in
 atomicity check.
Date: Tue, 29 Oct 2024 19:43:46 +0000
Message-ID: <20241029194348.59574-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x334.google.com
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

The version 4 of the patch wraps the host specific macros used to check
the support for atomic 128 bit memory operations into generic macros.
The patch also adjusts the indentation of the if/else clauses and the comment
about the above mentioned check for atomic 128b load/store to reflect better the
code.

Changes from V3:
- patch 2:
  - add generic wrapper macro to flag host 128b atomic mem op support.
  - fix if-else indentation.
  - improve comment about the checks for host atomic 128b mem op support.

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/

Cc: Richard Handerson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>

Helene CHELIN (1):
  target/riscv: rvv: reduce the overhead for simple RISC-V vector
    unit-stride loads and stores

Paolo Savini (1):
  target/riscv: rvv: improve performance of RISC-V vector loads and
    stores on large amounts of data.

 target/riscv/vector_helper.c    | 64 ++++++++++++++++++++++++++++++++-
 target/riscv/vector_internals.h | 12 +++++++
 2 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.34.1

