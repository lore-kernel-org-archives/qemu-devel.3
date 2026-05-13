Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8336CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3zr-0004Jf-5w; Wed, 13 May 2026 03:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3zo-0004JV-TO
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:27:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3zn-0001A9-81
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:27:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3719498f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778657225; x=1779262025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gEnV532rSiiXdp0X8T2gku2dCPzc8U41AyiQ506XzWk=;
 b=ihHRhYv1fEOcApTXSxmvPw2go33jUAp9cMKMYIt0a9wyqdL2yX9eyxdFv5tVQUmDPf
 fEfKgc3KCsnr7ieoPkpHia8sximpcmL3lZ64ZdQ9kJY3YUV3XE/ofuwYl5xDNqqoZ900
 CwRM4w5/4Bp6f5qeXq1Xleo9IInwyrGc3tBNCk/Zcc/SikiDZVoY893mOQNx/2SNoPkJ
 5Pw7F2sRZKRwdyjwGwSZSKnysgfehB77t7trmJ1duLF2P1uHjeGP2RFLXMuIAMjRBwba
 jJL1Re6ppqfhPyFGvd2ISxLvcFt0LvtrbFzj0CWrDpt/68Y+fzzBF1UMJRFViBfF5OOO
 SKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778657225; x=1779262025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEnV532rSiiXdp0X8T2gku2dCPzc8U41AyiQ506XzWk=;
 b=fL97NUNmcI9gaUKIMbVJ8WPagfHiMHM3eIdVOw85RuZVskqmtGLrhZQu4JDeInfyFH
 qpaQfDzNM7/DN3cRy00u8U/wf9ExLRIy7UkKenYKaZ9lEusbHZCe6viNEWDIfEYOVXEd
 d6FtPygKZk+nVMmIcLEVlktID3WWF60aUD/QGYRa4nvOJaVsVwMQaEfxr8HsTk8qZCIF
 skfBZeqN5sX4VUCsUMsf4ykChL/jqlQv6xM/0jwGoMXMiKpptrSW3lEiVvJwrw31jM6C
 pCBctcMfn1UEdDUbP3eGO3yZx5yPUgn1cVy5+MYGvCt0dFRty9xXEI3PCLjJKPlKuLcV
 3Jqw==
X-Gm-Message-State: AOJu0YyP/Uy9sA98URpWzQm0Jgjj3nIAMhW28WmVFNTreloAoNbRmTMV
 uyUl8SdWkQdsjltm1Kny4VKuvX32m4g0PfgzofN3jIP5PruV0vHPs1z7Dqr0nmrnfcEhwy9KyOp
 b+QL9GjE=
X-Gm-Gg: Acq92OE7eV1JOzy/CPMdNbd0npe3Njo/n77naS1hL4UNkS6eW+S37aZN4V49Atk61b2
 9uoQKJLFaPIhC+0RTM/SC+miyND9yqFySl3HLptVn52nnCbO3IkeGLhGvL5HKcAs0XB5UBKLNpi
 hkZl2d56b5Jrgi7z62zQi/1El+TpnuZa+mMd86d3eY6GReiOtqnn26YxLefVtNvf7YhpIq9wJTd
 AzsoqNYv/OFEAbn9IR+wHR3gmvDIzpy4c05a8towGqS/nwCNL3/dug4wouhmwSOuqCf5GBOkTfc
 q2wZvHk5FbRcHGxvnqG2EW2RETy68LtLDLa3gcc7Jd4Z0yorqjumJQ+CNnsad4Xb3CdR5LkXCW/
 +gmj4A/84QoL+hHOJocIowXZ31fH9GYzd8oPrDmRdwZRAiIflxjJswquWPRCtHOeLyz5Voe45a2
 htDyil70XhMj4T2t4jYqHO5QumK4uYR+5zsbzQbrdXWTT6DBiJbc32VtmTrNbEF4ZR0RVTqRfh
X-Received: by 2002:a05:6000:2910:b0:452:2834:c690 with SMTP id
 ffacd0b85a97d-45c554747bbmr2845667f8f.0.1778657225260; 
 Wed, 13 May 2026 00:27:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548bb51d40sm37481973f8f.0.2026.05.13.00.27.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:27:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuri Benditovich <ybendito@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: [PATCH] MAINTAINERS: Remove Yuri Benditovich bouncing email
Date: Wed, 13 May 2026 09:27:03 +0200
Message-ID: <20260513072703.9710-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

 Final-Recipient: rfc822; yuri.benditovich@daynix.com
 Action: failed
 Status: 5.1.1
 Diagnostic-Code: smtp; 550-5.1.1 The email account that you tried to reach does not exist. Please try
  550-5.1.1 double-checking the recipient's email address for typos or
  550-5.1.1 unnecessary spaces. For more information, go to
  550 5.1.1  https://support.google.com/mail/?p=NoSuchUser ffacd0b85a97d-45c62bf01dbsor217235f8f.7 - gsmtp
 Last-Attempt-Date: Wed, 13 May 2026 00:02:47 -0700 (PDT)

Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0790d13505c..64849c6e866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4487,7 +4487,6 @@ F: tests/functional/x86_64/test_vfio_user_client.py
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
 R: Andrew Melnychenko <andrew@daynix.com>
-R: Yuri Benditovich <yuri.benditovich@daynix.com>
 S: Maintained
 F: docs/devel/ebpf_rss.rst
 F: ebpf/*
-- 
2.53.0


