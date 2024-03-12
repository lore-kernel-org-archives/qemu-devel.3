Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5622C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1xw-00080e-Ag; Tue, 12 Mar 2024 09:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xm-0007s4-KF; Tue, 12 Mar 2024 09:14:39 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xf-0006n3-Jx; Tue, 12 Mar 2024 09:14:37 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-21e45ece781so3203669fac.0; 
 Tue, 12 Mar 2024 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249268; x=1710854068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U8mUkOfDMMvwgfB6KZK+pbHjVX8aCyYauBRRcWhOhYU=;
 b=JNXYhXNYZaUxoGy0xx9tZzgLh/FHnPf4Jx+BnRlHoPyGTtXGUtah2cliDhTf8cLo4S
 vLQ03cYiEBfUyExEKR+tf3OnFEhz49pdjKrR7raymVBUKS6vrmjDlVAXcUy/JNm34bxi
 a6ssdzqo/DbLRcbspkonNStnVFxgb1KP5OUgnC/ZjjCDJjokH++BJEZB0dm7zupl5v1E
 5i95VL+ai+yuEM7pcWC4s4oeGlgVlNYhKEzYXm6bqtJgAXfJ/E7hzK7I2SVDUbQB1p14
 4tagkGz330ltoXOH7qRDGQ7Mbs67gnaxLS50bqCWFTnR3BeZeOBXHPvogjBd+26WN05K
 qUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249268; x=1710854068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8mUkOfDMMvwgfB6KZK+pbHjVX8aCyYauBRRcWhOhYU=;
 b=HwjwfrgHfYYZaz4x9s082gWwzJ3ekJ0L8hf6ycWXgOWjUhlExm/G5NEEvzCgyUAlXT
 MtrP8A/v/DL9vLB1rfycKU/EhTketXLPtE/kSzSZYhjt0j0AaEAVBwfMGtsvySaptP3P
 X+4/o1t5ktj24okeEnEMmdJWIZB7brUEOFhUjE0ywvdou5xQV51ak3n4pixV5CD4Mx2n
 3E7yj/pkldQYlCelJIa7Qig8Z3zGN+lrg6vW7ztkFsLrIK+vhGXYm5iTU8LX0UAPvC+9
 GIMiq+BhWGTIpx5mjxPYsRQy6VmDUjZYADXdv7HfRYYMNCFcCsRttNb4jgPGU79ppfaL
 YI5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmBx7Ar66lu8ktDyG/9yCrva3DViHEdFWPBelyck7lcc3x7FHT0qen6SC4hMj80POJnKfn1bfPLG6ttvbtyGfzczymkcA=
X-Gm-Message-State: AOJu0YzbyTfs3+wViJBeCk0mg5zrcWeBdizFGKzO+i9jqCMOiClxB9Ri
 FbsNnLEPvAbu4sW8Rew/1CcylfQ8l1Mx/Ais8OoI7oU4rgNU7VwhNOMLRMYHxbQ=
X-Google-Smtp-Source: AGHT+IEcZLIfBXl1e6/VwdnhDvZ1Kvuk7+hgFhQFvJL9bPxlxO4IlBai8dv8Q/CuDKLzfEpLpwL0zQ==
X-Received: by 2002:a05:6870:32ce:b0:21e:df09:fbb6 with SMTP id
 r14-20020a05687032ce00b0021edf09fbb6mr10281836oac.41.1710249268616; 
 Tue, 12 Mar 2024 06:14:28 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 00/10] misc ppc patches
Date: Tue, 12 Mar 2024 23:14:09 +1000
Message-ID: <20240312131419.2196845-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This accounts for comments from v1, and drops the attn and
checkstop patches. Will try again next release for those since
they probably fell off peoples' radar this time.

Thanks,
Nick

Benjamin Gray (1):
  ppc/spapr: Add pa-features for POWER10 machines

Nicholas Piggin (9):
  ppc: Drop support for POWER9 and POWER10 DD1 chips
  target/ppc: POWER10 does not have transactional memory
  ppc/spapr|pnv: Remove SAO from pa-features
  ppc/spapr: Remove copy-paste from pa-features
  ppc/spapr: Adjust ibm,pa-features for POWER9
  ppc/pnv: Permit ibm,pa-features set per machine variant
  ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
  target/ppc: Prevent supervisor from modifying MSR[ME]
  spapr: set MSR[ME] and MSR[FP] on client entry

 hw/ppc/pnv.c             | 104 ++++++++++++++++++++++++++++++++++-----
 hw/ppc/spapr.c           |  63 ++++++++++++++++++++----
 hw/ppc/spapr_cpu_core.c  |   8 +--
 target/ppc/cpu-models.c  |   4 --
 target/ppc/cpu_init.c    |  12 ++---
 target/ppc/helper_regs.c |   5 ++
 target/ppc/kvm.c         |  11 -----
 7 files changed, 160 insertions(+), 47 deletions(-)

-- 
2.42.0


