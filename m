Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD33DD11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ksz-0002dp-Ma; Sun, 03 Nov 2024 19:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ks8-0001N7-9B; Sun, 03 Nov 2024 19:23:08 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ks6-0002r6-SE; Sun, 03 Nov 2024 19:23:08 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-720e94d36c8so636969b3a.1; 
 Sun, 03 Nov 2024 16:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679785; x=1731284585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ytsSfhdxBdIAcqYl8as4jIuZNHrehynxTj/kQNDYMQ=;
 b=SRDMGAKQ74IsvkvaR9iMm5GJZWcoDr6S8m/nqu4I8BKKdaEJNmC7+P+jSnhzfk8MeZ
 s6UFYYFw1UK/56APDihKzJIrztWZKv8bQLptdRlzo54n1mXSM6Eyi3o5fNlHO6CAbiuA
 41vFoAofkm6jOIL/1mV0vGZ3ijvddM0ATZkvqlUvVeB2z2VFZ0AcfRGYZRyUDxK74Kdn
 u7YgnAutG3sBCluLRkN6IUtt9/0wLQnm3ry9d/t9EalS532tss7kSPubT50oNfDGnLss
 nKRjoU975E4hmP7WKiL/iQ9SgK1SJmEHQ0oQ0nEjAleCaWyXUKqqlPVV85ODYdM2Azgl
 HiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679785; x=1731284585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ytsSfhdxBdIAcqYl8as4jIuZNHrehynxTj/kQNDYMQ=;
 b=hSPRu5r+kq52WrlW3YMIBaR11UOVjlsI2winwZApy3KKnAOVoaeQWhVxjR5A9nIEJq
 +mjAi87P/cccSD2V1GdvDUtlur1R2AiyQKiOglxQx6DtEvQtdcOnaxUaMYO12gN5hxwq
 XPFEPsphVay8mUuOI6upamaozJZVpsDkvSfQg2SIdR3YjjEFRfnCl9zOOlC/HpEegla2
 hDgflCCYyj9h770VeS/T4F+dsvWJzgR1e6Xga1nwhrlMKMLBqccYSZNxjsgGaQEu8OUt
 ed6Q32F7Qtv66C1adtqBDdPXqmmAEyw4Z2FDpTU3M9P4K3qNcwyMoz77gcvvq31XqtRq
 UAVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUrto1YFJgJH32HofYZHPVUZVAis0jAaZAZaacWNNvGsZNA9UNJue1eEYPLMwrHtTuwQYownHUbw==@nongnu.org
X-Gm-Message-State: AOJu0YyQqbDHZLRs7n82xor7whDNqftnaPxREPQLj5CndPspeaPkkQjJ
 J5/M130DstpAEl2BPVxzua484f0vwWYZnQ2DL+6BVBYFB+LFCX6hRWiK3Q==
X-Google-Smtp-Source: AGHT+IH5au29n2xLYrzcRRQueELx0Bgf+Qhj9j0oHAy0SzInxfC8CpR2XH/cqLWL17Hh2m7oLaSfPg==
X-Received: by 2002:a05:6a21:7883:b0:1cf:2d22:564e with SMTP id
 adf61e73a8af0-1dba4139851mr18406390637.6.1730679784857; 
 Sun, 03 Nov 2024 16:23:04 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:23:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 65/67] MAINTAINERS: Remove myself from the PowerNV machines
Date: Mon,  4 Nov 2024 10:18:54 +1000
Message-ID: <20241104001900.682660-66-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

It's been an amazing experience working on PowerNV systems all these
years. Now it's time for IBM to take the lead on the QEMU machine and
shape its future. I'm stepping back as the maintainer of PowerNV.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64b4ffa91c..baf8c9b379 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1495,7 +1495,6 @@ F: tests/functional/test_ppc64_hv.py
 F: tests/functional/test_ppc64_tuxrun.py
 
 PowerNV (Non-Virtualized)
-M: Cédric Le Goater <clg@kaod.org>
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Frédéric Barrat <fbarrat@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.45.2


