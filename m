Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC89CC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK0P-0002vq-HA; Tue, 06 Aug 2024 09:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0L-0002iP-Te; Tue, 06 Aug 2024 09:13:34 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0K-0003U4-7A; Tue, 06 Aug 2024 09:13:33 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70f5ef740b7so465205b3a.2; 
 Tue, 06 Aug 2024 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950008; x=1723554808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qlAsZT4AulQJCTyqDzqJuYc0MJQ/i/89K4mepYy3Dcc=;
 b=gxm75Hr3/gnPBsFAPR9M1jz/phqxeBl7CRA162qCrmwTy+eTAh8HSrc78QSctVmxeR
 NfuJVAwyGn9AhnwIblOkNalHVNgmBc2/Cl91KStAQP02fIoKfQ6w6nMoQNKYq3blHVv/
 fiadAspuUJu4MjJOFT2uFSVvo0d1q3BGdo1KUNKXFGp3Fud6QhpEnL5QVobJ2crPYdEt
 fKeEhox1QBOikWAhC22fRtc2m/n8eRyCps83FHAUvTnj4Q3FfyWWemqqmi9B7hjmk7+O
 6/pWkmRItDdRBf9ghpPzljeaEl0zdHodlVuYjqHHl3607+b/b+hZvVm6i4qlhhk/5tMN
 NwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950008; x=1723554808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlAsZT4AulQJCTyqDzqJuYc0MJQ/i/89K4mepYy3Dcc=;
 b=IhiUm9geIB7ZQXlCgET4PiBZmFrDjhKOkg3CywoLGfCZfaRBMAa7zYXkVzrXKfkjYi
 IxGar1Ak/mcTWL6qH8iVAESqEgBSk8OkHHzPMi76625IXGlwwBY3ThgWXX/W098GjTGg
 LxsQkYNzkygWWcDfwL0fa4yxccmFemN3fYE8tpWDbA2qxsNmlBg3ylGwiws/e5yGv52j
 uQIPXw8ZOmhpbI7NSuJAdAh+P2rXpHD1ARJE+ay36Ixasu0n1w7AT5+3iwC8wDDlnbuB
 NE/osVRXA9lUmQpDQA7YzzF3I3aG12I9YDx79ZNquDwzWxjyNiXqS//aMUmQJKwsLPEp
 paNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX7PEXHllvYlId8MQixvTpekJRCFDfcM/yYy0dl8KGd0OnLZyfSPK5cYMiZGUerQo+tNFrijAdkP+SWdrPiH8hSCJli0o=
X-Gm-Message-State: AOJu0Yyr5cLXn75EHRtLYIr4OmmTjrUe7hBKqb1oHjKqxmffzhCHu+/+
 0qpMw4lBj8oKlI61Ij2UzAIAA4TWIWNlRMxqTI1gUT/Dn9VTwgAZQGXLQcF9
X-Google-Smtp-Source: AGHT+IGeW8y6gkuGjKe53Zv2BJrnusZSo+B8HeCxlMNBC+E/LMIxfUqt8e57voYp8cIq96CI4VWvMw==
X-Received: by 2002:a17:902:e5c2:b0:1fc:6740:3ce6 with SMTP id
 d9443c01a7336-1ff572592f9mr189276275ad.20.1722950008023; 
 Tue, 06 Aug 2024 06:13:28 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/7] various ppc fixes
Date: Tue,  6 Aug 2024 23:13:10 +1000
Message-ID: <20240806131318.275109-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

This fixes LPC serirq Coverity issues introduced in the merge
window that Cedric reported. Also fixes for an assorted bunch of 
emulation issues recently turned up when running PowerVM firmware
on the model.

Thanks,
Nick

Nicholas Piggin (7):
  ppc/pnv: Fix LPC serirq routing calculation
  ppc/pnv: Fix LPC POWER8 register sanity check
  target/ppc: Fix mtDPDES targeting SMT siblings
  target/ppc: PMIs are level triggered
  target/ppc: Fix doorbell delivery to threads in powersave
  target/ppc: Fix HFSCR facility checks
  target/ppc: Fix VRMA to not check virtual page class key protection

 target/ppc/cpu.h         |  5 +++--
 hw/ppc/pnv_lpc.c         | 14 ++++++++++----
 target/ppc/excp_helper.c | 21 +++++++++++++--------
 target/ppc/misc_helper.c |  2 +-
 target/ppc/mmu-hash64.c  |  9 ++++++++-
 5 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.45.2


