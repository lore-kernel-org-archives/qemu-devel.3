Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B545C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Wfm-0001Nf-Iw; Mon, 29 Apr 2024 15:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1s1Wfh-0001ML-Vz
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:28:18 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1s1Wfe-0007Xw-MC
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:28:17 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5aa28cde736so3203676eaf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714418889; x=1715023689;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WyEiUPA8bIj4Xi/U98owUDeYtfdrkRsuHYwmaXoEJcM=;
 b=bah/PPb4weLJ+0p+iN2Q2bim8fM5r15Q16Z8cqr5i2cChTGz/XnYKNFnLewE3ZRmBg
 NxHkGDcPgD6K3lpxZbOVqxk3z+i5TI3XC55phpgN1nKFNf4+Oy9BPsVqJOP815N9c85g
 7XWywEJBciUCaggDlbD4Wdyx6ZO7EgVRqEkJ2pYByt+0282+rx5Orlx4Y+Jj3IEcUHJi
 gDXepbpJeyWbPJth2xGzTXk+weFlE4Dwu27hKcDEMw7x1XTxv9u9JJsSmIomjDvAuw9c
 WxTEdUfDSsHCBQ9SmiVLekgQ5G2fpNjg3nrCHMqo84C1cOWdTTbnm3ajGSaWEkWNnXXW
 HOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714418889; x=1715023689;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WyEiUPA8bIj4Xi/U98owUDeYtfdrkRsuHYwmaXoEJcM=;
 b=ZDwOfCGdBaSDAjqY4qa005VHtc751h0Qx8O9vPp9EUJm0VhC2LCBnD0Bd9O4sj1wPU
 hPZykPK8qtO8fs+KExPzg+yKIu4WQklhBxdLDxzgMtN9rq34rxhIz11G0U2w4+BdhD7R
 PETzmaaMB84yXDuo7w2aHwcJbyutYn1UdXxmL+VOAUsjt3STnI+qd6JibjIG4eVkD3UY
 dgV7so3TlHqJvc+jB5Dh7XriPRgay80xW2TXh7i7niNO0zNuyvLbD5KRS4bK0SgY8hYg
 AYvo0Jl3Ir1pfBCHSRbrAzwCuZfZR1X93qJQ2OfaITlpaabu9ONX2kNaKwRM7IkteISi
 Zxag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXz83rYv2PzFAuczBVMAS5rru268yPbPaKBQ1dqyda1C6oQLSP2Zy2g4PVo2f7CcpAiSuobpVl6qNoghpZRokJhpYLBA=
X-Gm-Message-State: AOJu0Yw/byuokJ0qELj9604AVHUSgDmegq+mvWqcNjGnquLlh0ikxhlD
 0PuUKFluztMQvQcBb90IQnTSw53/F/0Uf0YYrNFAzLswuIalEbKRFFgeqVKzC34=
X-Google-Smtp-Source: AGHT+IEwL329nmuvT5Z5h3eFPR8fIp+Mth6t9qV2NlPHiUN83PxIW0kE0o+NyrDiU3gYTXSMAclYUg==
X-Received: by 2002:a05:6358:1911:b0:186:c06f:435c with SMTP id
 w17-20020a056358191100b00186c06f435cmr17847762rwm.24.1714418888977; 
 Mon, 29 Apr 2024 12:28:08 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a63e44d000000b005d8b89bbf20sm19293887pgk.63.2024.04.29.12.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:28:08 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/3] Assorted fixes for PMU
Date: Mon, 29 Apr 2024 12:28:03 -0700
Message-Id: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMP0L2YC/x2MWwqAIBAArxL7naBmD7pKRJStuT8aWhGId0/6n
 IGZBBEDYYSxShDwoUjeFRB1Bdqu7kBGe2GQXCqu5MC0v91FztJG12LoZbpbhRbCqKZvoWRnwKL
 /5TTn/AFmQrAiYgAAAA==
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.13-dev-f0463
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=atishp@rivosinc.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series contains few miscallenous fixes related to hpmcounters
and related code. The first patch fixes an issue with cycle/instret
counters overcouting while the remaining two are more for specification
compliance.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (3):
      target/riscv: Save counter values during countinhibit update
      target/riscv: Enforce WARL behavior for scounteren/hcounteren
      target/riscv: Fix the predicate functions for mhpmeventhX CSRs

 target/riscv/cpu.h     |   1 -
 target/riscv/csr.c     | 111 ++++++++++++++++++++++++++++++-------------------
 target/riscv/machine.c |   1 -
 3 files changed, 68 insertions(+), 45 deletions(-)
---
base-commit: 1642f979a71a5667a05070be2df82f48bd43ad7a
change-id: 20240428-countinhibit_fix-c6a1c11f4375
--
Regards,
Atish patra


