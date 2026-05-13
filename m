Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF583CD484C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzpL-0002Rx-MH; Tue, 12 May 2026 23:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wMzpI-0002R8-Mf
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:00:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wMzpG-0000td-QC
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:00:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so42206395e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778641197; x=1779245997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CF5t1leIppzIAZYZUY8qi097ozA9ziZF6e7gO0ObDOY=;
 b=TSNuG7jCTOXIqlM9yX65b2S7eDb0a3T3xoJTLWZMb+Z62DUrsKBkbDD7jPBpo6+lJy
 fR2ij/Sw/mfjDZz9UVGKtSvyfMSdU/4xQ6XL0aI74cKNzCJgL7mlAx8lyEBKDi10eI9S
 P7ZC3mbnaUDPtMSoKvTnd8MG/mGNUYjVSJMFv7vqwRQ/BsEZN3HMFD1hahJvDjW548qQ
 vJffJ0KXwmnGB7vI+M8yet4n/aDDFTvq1mNJpAmwHGUThTvpUAUFOeRdR7ZVpRkenR9E
 8TuL+AYCtmPdDrQDigca9BFT3uAL2TaPFecA6jIuQHuWed2Y49nA/dnY+p1cuGmvSi3v
 Tm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778641197; x=1779245997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF5t1leIppzIAZYZUY8qi097ozA9ziZF6e7gO0ObDOY=;
 b=cNzpkWZpp6dIXKAs2Vf0M9Vp4hdKN4z6g+KRXq8LW2fQzRbS44ErkdP7b1c9wISj+M
 wSmaHUXr1YdA543fJ77c7XyInSwihEC+H33eV59Paa8mHzPEX9GEWBees45NFlf2mnOO
 1nOXxhZnJSaJ1kqm0VRAOFux1nIQ87NcmQnlE1PtHlGqm6IdDlmstAVxtcAWIz7l8EWG
 9ze8EoCfeJbmawxVPi2rD4tF17uft4By57PB+9M7NYFi1kJeSUetErCHtWRBMhFqc/A3
 8ANCUH8jGWL46qCitu90DxvUOl7h3AcG+aDIAiv2xeVwQiqqHB/VhQYbpcb8Vjn6K4/J
 CKtQ==
X-Gm-Message-State: AOJu0YzvzM4l2cuxWR6sZWNczuXKfnf0ZSEkfKFR2ByV3ZSUikNpOzZK
 xUPLswJ5mOInQPB76WHctu8oCBqozL4iueq15T6umgxB4IEelvBSMaDGDYHHnCDg0JH2MQ==
X-Gm-Gg: Acq92OFKhwdZBnXIkFKnWLI1HMA4pLL2lOHq+FQJflrOyivHx1O+eFGpna5kldHavvU
 Nzpl7rTZpHHfdouVJsLdTdhpPlAC4E1OyZs8Sfx3b+NmESv61zpV4kuaATg5Pqmf37bRetzTj4b
 SnSCnqQqZjL8/eN3ivf77jvD5yCcVXtDGAzzbsAAAYmJ17mSoUIcPr6hYvr1KL6FVD6BGyBPE9x
 plo7+zFTqb6xXTk+n3d+ND2WIdbjBB/i7xP9FRaH9d/+95Lyb+VL13WmTg/+JjJevtMKUBRw4VK
 Zw1ptpxDg4fYCqHHpCa7PJ5Tk6chvWLrkZEbVpkRraYBJg6xk4C9U0uVE6su0lkbsJxv0D5rbb8
 ZKd4g32JAQcUR6LSppGbYlZJ+6fI0rQTQgsBRx36Vc+kUqN+9zWr+Q2Oa+piPu4QNAjXuC5+4u8
 aJCFEUUV6gE2ifXDHUtRECHBmZ+OE=
X-Received: by 2002:a05:600c:45cd:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48fc971f0ecmr18017295e9.2.1778641196787; 
 Tue, 12 May 2026 19:59:56 -0700 (PDT)
Received: from fedora ([197.211.52.69]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f447166sm30308275e9.30.2026.05.12.19.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 19:59:56 -0700 (PDT)
From: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, deller@gmx.de, Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Subject: [PATCH 0/1] hw/scsi: add initial SCSI tape device emulation
Date: Wed, 13 May 2026 03:58:53 +0100
Message-ID: <20260513025854.76594-1-emmanuelugwu121@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=emmanuelugwu121@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This RFC adds the foundation for SCSI tape emulation in QEMU. 

This patch implements realize and unrealize only. SCSI command
handling will follow in subsequent patches.

Feedback needed on the overall structure.

Emmanuel Ugwu (1):
  hw/scsi: add initial SCSI tape device emulation

 hw/scsi/meson.build |   1 +
 hw/scsi/scsi-tape.c | 221 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 hw/scsi/scsi-tape.c

-- 
2.54.0


