Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C47C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 23:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUwN5-00060p-IF; Thu, 26 Jun 2025 19:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUwN3-00060R-Vj
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 19:51:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUwN2-0002I6-9O
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 19:51:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23636167afeso18038355ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750981866; x=1751586666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N9A4F/pysQIdrEzx82t2iSqmNp8R/qNKmwZe+pGGDwU=;
 b=fWPgt9eMLjb5KRdUF1aMqD+Jf5VKVb3X9Kyslsp7kCaRxwl5ExNI+ZPKJfkh0nWHv3
 +1klEAKmorN+SEXSe7xsMh/eVMP4a09ZqWq8VZwKJdiobSwP6FGr5mkK+BheI4I2pug0
 4Uz18rsFByn9b7cBERgn0PbuMPlWG7ICk5p4b7fxDIkt6Zp2Cfb5Shjg8CK6ei8HBAvh
 WfkpEj3jW8LcmcLMSIa5chLvqhKs7gUJgXn6BUe5pKM0pjf7veXmFupyvVMuF3upKRcF
 OaFu0yn5cCGlmVlSRshJx3KE4uitqJeMI5xSH4rySJif1VtE/gmFpBBP7YwD2y+nYXso
 ff/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750981866; x=1751586666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9A4F/pysQIdrEzx82t2iSqmNp8R/qNKmwZe+pGGDwU=;
 b=RUyPLTWSDFDw6cv3lixTlzSMh1ASDnlT17ChZ94At66FUgPH6qu1y3k0JG1tVmz4XJ
 GS/Ys6BP6Hq20Uqg9mQvxXOhFI7Kaj+NoR9OQLvbZQe8ZlKIKiUfzQHiPBdBfWpzXe3d
 2l1Z282+JN+uOsXdCNIPwQbJ/mPmPL21GqiqdWBhLwA1cUSmPIp/FxiBtw4peD0v1AEp
 ZRVhdywr0vGLnTtnFUnAoCESDz9PM+xJ/jr0Ye7kAHScEBiKjiBdhptWQtDea3vLJcRB
 ajJZ97mDXI248678bM+ukqJmCRcF4xyGYB7QbYNQc2CYGYvjbpMFTOZOgF6F9PP9YDnQ
 aSPg==
X-Gm-Message-State: AOJu0Yzyam9oVfOwERViZRdOHL8tt7wPq6Zl9TFHMppj9tOFrb47/OQu
 YCQKBqV8WlLv1keXNylHZ82PivoSFBWG96rQxKALkyXgBwN+UPqIl2rplyZ1Bw==
X-Gm-Gg: ASbGncswbUBiv7aOinTLvmG2ooB0A0lRl1EictJOTjGxqu7lAiN9iVz+p3+8DrjPiMi
 8Lw5ZpC/7swzFGqHnmNT7VkxSJrlBgMQYBkbAH1re32YkCfqGnuHfrloiL1jxqfw4iL36ts914b
 g6S7Afva6/p4EefSaaxqGoR8mHIdYlP1nGbiqi8EL9E0PLUIZlV/2YtDO14SDwgZBSYjSz4GtWO
 C+VPEXXeEuykP50t0prLNROCPJjaP/A177OfNyltcqsZkUQx4LGgjULYNgPB0jLYnpymKp1eEhG
 5aUy79ICeq53tYKS2gjAT1xgUdMSFY67tXFe9ZRsAyhl3fOCxMPoerBMw+ioMQLtnVVWwQ34WFI
 FTKuIkzs=
X-Google-Smtp-Source: AGHT+IGG7MtzH54Hxom0e6Qb6sVQmCrOFC7DVeNVIOWZYUX9CuGQ7/yKVByZCMNvJeOhkIeEJND28g==
X-Received: by 2002:a17:903:2c5:b0:234:bca7:2920 with SMTP id
 d9443c01a7336-23ac45e262dmr22084745ad.24.1750981866158; 
 Thu, 26 Jun 2025 16:51:06 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f1845sm2081055ad.70.2025.06.26.16.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 16:51:05 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [HACK QEMU PATCH v1 0/1] CXL MCTP FMAPI Binding Fix for MCTP over
 i2c/USB
Date: Thu, 26 Jun 2025 23:41:14 +0000
Message-ID: <20250626235102.1902427-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x630.google.com
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

From: Anisa Su <anisa.su@samsung.com>

The FMAPI DCD Management patchset (https://lore.kernel.org/linux-cxl/20250626222743.1766404-1-anisa.su887@gmail.com/T/#t)
is based on upstream, which does not include the i2c MCTP hack or the new MCTP
USB support carried in Jonathan's tree.

The commands are accessible upstream through a switch-cci. Thus, to break the
dependence on the MCTP support patches, the commands are sent separately
from this patch.

This patch is based on Jonathan's latest branch
(https://gitlab.com/jic23/qemu/-/tree/cxl-2025-06-10) and fixes the if condition in
i2c_mctp_cxl.c and dev-mctp.c to allow FMAPI DCD commands to be processed.

For more info, refer to previous thread from v2 of the FMAPI DCD patchset:
https://lore.kernel.org/linux-cxl/20250530152655.00007132@huawei.com/

Anisa Su (1):
  hw/cxl: Fix MCTP binding check

 hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
 hw/cxl/i2c_mctp_cxl.c        |  6 ++-
 hw/usb/dev-mctp.c            |  6 ++-
 include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 77 deletions(-)

-- 
2.47.2


