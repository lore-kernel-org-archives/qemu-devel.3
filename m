Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B68C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 04:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFRAv-0004kQ-Vy; Fri, 07 Jun 2024 00:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAs-0004jj-IX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:25:58 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAq-0004zK-Tx
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:25:58 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-374a342cf47so5424205ab.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 21:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717734354; x=1718339154;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l7/+IkkpESOSSDQRDDoCw+nHDaiQ2aFBSYpOxkRArm0=;
 b=iBh6kalnneMcaNwjMjI+Nyz0KnLTWIcywzu3erp4reyBEXKlaKeIdDuTx2lhWzdoNX
 sOM8hVxKZJRcr++hin3Ni9LYXlSv1+lSIh90CK8PcTSaxNFcMARCOBeq3BTVdF1TTwfE
 T0Pq9Rc5zqnEVRrzFRVYuz7qlgnnDX3jrQl5MAYS5tfjRjI7BeAc+c/jMIDN8CaNXR1y
 ZT5HF4izUP8i0ozorvGCeL6VB+K8DK5JwbtDBJuGct63KCYrD7F2tkQju5fnaEjiutTr
 FsY+xE+IBBvpnnukM9mDfZXvqQ1E5vEQRWmk4uCIOouu1yXgf3Z1H1xEktUnzDsb29c6
 M0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717734354; x=1718339154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l7/+IkkpESOSSDQRDDoCw+nHDaiQ2aFBSYpOxkRArm0=;
 b=o6CTyaQ137GFQXx3PdHkGttzoCBYCdWL5SjLElCNXTDNSQrYHl/k+MS2zULd9/zXTa
 /tbDe1slbbLc0n7RvzhImLRYKel4eVTLkWFcxn+pECvou8/gNsfae2u2jZ386x00l2KQ
 wBAzUE++bk7/4/eyvWiCew0P2eIES+d8F3vtYswvUIGXAn+49gJwvsVUwnQ7xfDTy225
 gMDd0tfTAVfu6uLwBXTunmx2Lbo8/D6QcU0YdMez4AH28iJXOWw7DoQ6rP1npoc3tbDO
 Tc/95gBLJrSMxBGH40s7m65C97tRDbeHBAaZnMwwpQ0hWNzet7hLAOqvBvdkfTOsAAHp
 QxjQ==
X-Gm-Message-State: AOJu0Yz5aVQgWl6HS/Q+K8w0ONkXTwY3SFqCRB8PXMuL2oJ4cpQUYuXP
 WQv+q2J4xK3gA3mFgy0M/fzaTDw2XLsppbEtpSyONBVEjhe5wOG+QCy2CLZK3rMXsH3scU5J32I
 zG5o=
X-Google-Smtp-Source: AGHT+IEHt4OQEE2pg1d2iJL67XbNDrb5ETihax8L35NmZiPRpTLIaa/xpWeSiKyTaLJKRQA9NxP7Kg==
X-Received: by 2002:a05:6e02:13aa:b0:374:ad98:2a2 with SMTP id
 e9e14a558f8ab-375802f0d6emr18837075ab.4.1717734353907; 
 Thu, 06 Jun 2024 21:25:53 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc15d9d9sm6162585ab.37.2024.06.06.21.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 21:25:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 0/3] bsd-user: Baby Steps towards eliminating
 qemu_host_page_size, et al
Date: Thu,  6 Jun 2024 22:25:00 -0600
Message-ID: <20240607042503.25222-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

First baby-steps towards eliminating qemu_host_page_size: tackle the reserve_va
calculation (which is easier to copy from linux-user than to fix).

Warner Losh (3):
  linux-user: Adjust comment to reflect the code.
  bsd-user: port linux-user:ff8a8bbc2ad1 for variable page sizes
  bsd-user: Catch up to run-time reserved_va math

 bsd-user/main.c   | 51 ++++++++++++++++++++++++++++++++++++-----------
 linux-user/main.c |  8 ++++----
 2 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.43.0


