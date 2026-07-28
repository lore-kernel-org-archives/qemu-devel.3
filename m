Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3942CC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZ9q-0003Xn-1t; Tue, 28 Jul 2026 00:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1woZ9P-0003VB-OV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:10:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1woZ9K-0003hT-KS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:10:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc891373e0so35444285ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785211836; x=1785816636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PTCCDxCcqdsCUJTmXssKttH+fJ5nk/KFidckyqJ3KJw=;
 b=Ol/BKGqaOlXnvePn2ylJ+JFK644/diQblOY2E5UPGYL8FnOp+vloL4NUNMlI1foigv
 eb/S0HmJ8tUzAVqZPkT3PjrrnslL6EJFudck55NpjPfad3VUJVFSKDT+7E8JpcbmGQ8/
 IDTU9CCd1m3nmkDYr1OzbwMzDIkCztrkEynKBb0LtK0/r0rt18FvfW0A/ESizMKiONIi
 AGayaSf/lezNINVHEbx4SPjae+7JkrqE7u8rI6rVElZDuzjm1psawYDyjauSveNnpY3j
 fAtPIjOLNjb0ZJcpVgQFiplo5toSeVaqko99mkb934hpcO+on6THg3mH1ohvRZl2M8qE
 4mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785211836; x=1785816636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PTCCDxCcqdsCUJTmXssKttH+fJ5nk/KFidckyqJ3KJw=;
 b=AkRLarVqrE3vYUNhmm+QwsNwWyK0ZfFqMdBFwT4RKG4Ye8nCAyAx9i4uFpRGZvxC7k
 M5+vuagiTs1bNpRUphAXiXWWVIuXTk9adaL+3q4o46VutZMWBqh9WyaZB9pF6kgZTsDC
 uZdksoLDmllQ53VuoznReYaH9tOCBjXoCjduQVMv6w1hO51FCyhvxTIzcqwXa4eV3Q9o
 r4v4wiELZCnIuVrAL/SycrqUvVByNTGAz9BrgyVlC1/T63ohtNTdZq5AU2v8TQmRVPyX
 aQ0He0ekwwINjtzBaeP1hSBSr/3Y1Ikvl4BQmyryGQjRoSaqnI0qcXoE0eGrb6tBzFYL
 QjHQ==
X-Gm-Message-State: AOJu0Yyxz77KtipHR7fsi+VrWed7rDxlYUCExGG3vEamDeVrvgs6wU9U
 iI232LuB5voao49H61d+nyQCcocgYgzxd3T2azLXQU/OExJEhQ1dltovR6kjYC/dXyI=
X-Gm-Gg: AR+sD10HDQ7hfQYLy9cnQunk/tLJ3IT/y50T3gLCaBkX5q+MM+/J53fb44mR+ZDLuuv
 wO84R/6J5l/JgQ5btqxrT2eBQZfh8aQDsZEBfgZ4zkwRcu1js2JY3cqfBxCl8pNw6sXxhw4w05m
 5uUq1bLIjCRbKPtB6xXXRUZKtSwlDyEMa6vL/4z/rzYe3HmLhFsjohxvmRbpG8n835irxCKThcO
 6HdIcMcDpJ+wDfRD/Skf0yApMiQ9FTzDaWqhC2RK5dsqE/x32Lx/LP3OKlAQSyrFln+SJJvEG/d
 B+nC/NTesCsVmB4iRtFjSxkFRsPBEe2tFabmDm7YfR7Y1as/UWvl6sbla8mm79kmOIGhXhFeBjs
 Wvaqh4RYiriYEC6gg7vsiXh5cCVAa0EkQukJyXmdwq2ZvAcnDnvMofUP22bAnHOyPcxzoFnQPAX
 xwCEt2nPZQrXvCVzeMg5I3n7tMneI+ibmQzC9xb2xoWxtcQWeWwA7JxeuBvGrfsTwHPCtv9Y9Ow
 pST1uoqk5F/eQjH
X-Received: by 2002:a17:903:4b46:b0:2cc:a853:1311 with SMTP id
 d9443c01a7336-2d015eddc78mr9089285ad.47.1785211835949; 
 Mon, 27 Jul 2026 21:10:35 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([27.115.61.146])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde80ee56sm44378785ad.76.2026.07.27.21.10.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 21:10:35 -0700 (PDT)
From: lanxiaoyun <dubdublan1987@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 lanxiaoyun1 <dubdublan1987@gmail.com>
Subject: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Tue, 28 Jul 2026 12:09:21 +0800
Message-ID: <cover.1785210445.git.dubdublan1987@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dubdublan1987@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: lanxiaoyun1 <dubdublan1987@gmail.com>

*** BLURB HERE ***

lanxiaoyun1 (1):
  hw/intc: resample level IRQ on PLIC completion

 hw/intc/sifive_plic.c         | 5 ++++-
 include/hw/intc/sifive_plic.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0


