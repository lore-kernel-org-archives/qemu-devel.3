Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FDECF6482
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIrS-0007td-G7; Fri, 27 Sep 2024 17:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrQ-0007kY-69
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:50:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrO-0004Th-JM
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:50:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso21652085e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473844; x=1728078644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KwyOBWgKRxjhWiu7QIvta7//yqQEevEr6etIlSQgKiQ=;
 b=mgQfl0rojAa8XRZkldlxDy8xWFF37KLfBSv78l8X3YxifqBYkLMy5t3TgURVpupmMm
 YbGPmp3hbAgKoc2hV7Ozj1+N/Wt9RoByrnXv7uNaF0dZ6D1lu+uuG1hODshBTjlsVwLi
 V2iRDonK8sd6zjbwoiG4Rix8XZ5no4OOVF0rj/6qG8GlupEuKlBh7hv+vBNITpqfYN/7
 H5/lnU399FTyNpi11RCagN+YkZNobkKy4SOzlU93TYXyM8KFGtD6lT+jnaWg0UG+yWD8
 j9IsBnbWsSLRmqedXWLhCVygo2D4H3NSWtKBSwdF8Vp0m2eWJJ+jVAhzZd/C5/pEvVWL
 m63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473844; x=1728078644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwyOBWgKRxjhWiu7QIvta7//yqQEevEr6etIlSQgKiQ=;
 b=Kqbi8GUF6lfWaZKVVlAil7X+SDEmpeyvYFrpGh5Qv2fjVOC589G/8qstna+HqFoGnr
 xfm57wquMcORwIRVirpIn7HXfU/mtZ59U7otZhoNOj1h6VRVlXSmIhVoZ9s8eKyKKj66
 Q9kppDOt2j2VzxL2qLP7vQ1bIl9Gng1QiGMjQGsyL0PBO/yj8oNj4zoK+OzTjcZEWHIS
 KBST1mwSY8vGGT0kiV4dFVPPc9d1LxqeYsIaTQxmO6WsxmmhDAu1+bXGwY2ohe5TXKnb
 V7o57jfzgxXsKRxaUlzhuKR6meRrthMySbop0H4X31OnjDRy+iwZBPCG0lQC44YPSz6K
 O1fQ==
X-Gm-Message-State: AOJu0YxmaShQxCwev05vJm3had2uQbxnhleeju6oY9wQjT9dm7BcqK7T
 6k1mJBCq/xCHuJpa33t5Vbw9QEQMPIg0/sMeV3zclWEp1cOogsoiR839aycfe0kQ+HMwXDxc3bR
 s
X-Google-Smtp-Source: AGHT+IHye2PScAxOqH1iAfdFV0cYS3Dp+B/I1sg/4WK3rfGAOxeXM7AGRPpw5UZUnBpYfETw8U8s8w==
X-Received: by 2002:a05:600c:1c9e:b0:42c:acb0:ddbd with SMTP id
 5b1f17b1804b1-42f58409e2cmr35789925e9.7.1727473843846; 
 Fri, 27 Sep 2024 14:50:43 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddfc9sm84690035e9.5.2024.09.27.14.50.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] hw/ppc & net: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:50:36 +0200
Message-ID: <20240927215040.20552-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use ldN / stN methods to access variable lengths.

v2:
- Include unstaged change in vof.c

Philippe Mathieu-Daudé (4):
  hw/ppc/spapr_nvdimm: Simplify LD/ST API uses
  hw/ppc/spapr_vof: Simplify LD/ST API uses
  hw/ppc/vof: Simplify LD/ST API uses
  net/l2tpv3: Simplify LD/ST API uses

 hw/ppc/spapr_nvdimm.c | 47 ++++---------------------------------------
 hw/ppc/spapr_vof.c    | 27 +++++++++----------------
 hw/ppc/vof.c          | 26 +++++++++---------------
 net/l2tpv3.c          |  6 +-----
 4 files changed, 23 insertions(+), 83 deletions(-)

-- 
2.45.2


