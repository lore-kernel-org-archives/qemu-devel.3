Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7380DC25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 13:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29dq-0001zk-Vz; Wed, 01 May 2024 09:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dp-0001yU-4k; Wed, 01 May 2024 09:04:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29dg-0005sB-AE; Wed, 01 May 2024 09:04:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ecc23e6c9dso974625ad.2; 
 Wed, 01 May 2024 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714568684; x=1715173484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj6xnVmK8WcFCFhqAGrau7xCSmb+6Pszpmo/oxonmBo=;
 b=ggKh6Mnby1uttjlAhSxMOeH0erRUjvJUscvvIHuAP8nrYbMPo4FEvR1jQtdv4lhE9k
 S5zbU7cZUZYYhnucArgszFXxZHcpkh86KmXHqtwjXzoNDthfv7JU3GbmJT3qW1qlMY8h
 nRfeZmLBg9DYKb38nadOgYbNkhqGi43KzqmXbd2N/jKX3nWgjaL8sppxo3V0UmSh7Gh9
 yfwbS9n/a4sZAvm3Dgsn7I5yTCOnqukscqvd4QbT1wl5Qt7JiSGKWfgHNlAatERO4OmJ
 z3w3FW8Y7bu411ZFFP32QRz15clUNT2E46cnO0cV7gcuyTqwmXJAAzhl65vdZWVRhtR/
 3Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714568684; x=1715173484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xj6xnVmK8WcFCFhqAGrau7xCSmb+6Pszpmo/oxonmBo=;
 b=V2Znk5Jge4LbhoEDbWsNAeF/492dUidgoGGsJsVv1CQhnQ25HE/n2X4IzRV4YQP9do
 9jI8meDl0ZBzMKaE7ZGRvG5/SCCimJ341hblximxhqBkF7ztuDiyAd9CiT8Cma6Cqs/6
 askJ+OzkSFqbjZoq7aUTf+ztPjijdgEB5tbOA+FfnM+SCEJUtL47l5oYgnPun8dCLqtf
 i7En6QD20uXSIHQwaI4HUGMEI6+PouCDz4NZEgsZAJsHwYB8m1sBkrs7Nc9Ou7N6KWSM
 Q6RCQM5aR/mpSJ5aFWSOtjYbDiDftqyQPCGfwOoja12pclUQr4DoR5fEaiHb2Ozlc/MI
 OOpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV79+VKmtdfF6KjEnACmQPkD52Sce1UCb+SyFaRTl7I6dtzx2Cu77wsT9HvCXon5BH1Bg6iDJqKHIjhgADZOk1wCpgWmQM=
X-Gm-Message-State: AOJu0YySMC1UMpFXXs2T7nmQwJgpBSOyIQp1Xj3tLnD2Clnwr0PrV5d+
 7U2Ikg0FJJEnXTedTT8ntidPfGxLPt+ANnGfU+4qUhAV+4n24Fgw7PR9YA==
X-Google-Smtp-Source: AGHT+IEl4snAiyntWHHnYCgXCDs2o+c64+YnVRS9MZsiRyNQLg6y7jMvt7t5YiYYq0lwdZBr8pOUtw==
X-Received: by 2002:a17:902:bb17:b0:1e5:8769:aadc with SMTP id
 im23-20020a170902bb1700b001e58769aadcmr2206594plb.22.1714568683634; 
 Wed, 01 May 2024 06:04:43 -0700 (PDT)
Received: from wheely.local0.net ([1.146.40.196])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a17090276cc00b001e41f1dda43sm24064471plt.75.2024.05.01.06.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 06:04:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Chinmay Rath" <rathc@linux.ibm.com>
Subject: [PATCH 0/3] target/ppc: Fixes and updates for sync instructions
Date: Wed,  1 May 2024 23:04:31 +1000
Message-ID: <20240501130435.941189-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I forgot I needed to do this, I tried adding new POWER10 sync
instructions to the kernel and patch got nacked because it crashed
with TCG.

Unfortuantely I don't think our old decoder does a great job with
handling reserved bits like this, but decodetree makes this kind
of thing much easier.

I'll probably add at least patch 1 to -stable, so the Linux changes
can be upstreamed a bit sooner.

Thanks,
Nick

Nicholas Piggin (3):
  target/ppc: Move sync instructions to decodetree
  target/ppc: Fix embedded memory barriers
  target/ppc: Add ISA v3.1 variants of sync instruction

 target/ppc/insn32.decode             |   7 ++
 target/ppc/translate.c               | 102 +-----------------
 target/ppc/translate/misc-impl.c.inc | 152 +++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 100 deletions(-)
 create mode 100644 target/ppc/translate/misc-impl.c.inc

-- 
2.43.0


