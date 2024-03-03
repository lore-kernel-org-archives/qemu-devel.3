Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C888C5475B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjR4-0002Fj-TC; Sun, 03 Mar 2024 05:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjR3-0002Fa-VZ
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:13 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjR2-0001hn-Mx
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:13 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso30963525ad.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463070; x=1710067870;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6F4s7SD+EbTcsUd3BOMfzMk3X1lfu/l+APGABisSNs=;
 b=IhXNzqVYGgCBUfTxc8jVMkcB9mjiGA7V+DkpTC1TY/cryNR/4GkisxyR+dDQf/s/kJ
 Dk2Tzo96uBXRUIkznVh/mG1HX7IovDSkA+dOhgERoqJXBEVKeMKMuGqhdv/v214Xa7HW
 oDE/kA08d+3GKymCOdwuAqLHWm0yJpmceoqdWnT2ktcdVwh7a15MkkY/2y/QMZdkIhrZ
 T6qTy+1Pk2slzLYqMz1h69fIePdCei4F4y0URRMMI4tC73UnbLqnGYHHNZ3TYoZ9d/tL
 ZrWTYOKNsUaM5RkyDC3/+6Y/Vncr7Z4g4Ye+fUpkr/iSSTFkptwYRR7ANYfGjAGgj1+A
 kKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463070; x=1710067870;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6F4s7SD+EbTcsUd3BOMfzMk3X1lfu/l+APGABisSNs=;
 b=Uj+6NX8AjgNaGCp/vuA+h3Wvw+qyONXIdJTCZ9qv9iL0LhH/Y79S+F0ENS9i292gdW
 +6oZzLDSCLf+FIOtGmNG+MKvCcdKI1VBHmEqeXYmZkug5GT+1BJBe9IqMi2X789DBL3t
 1WxLtzy54Pjk41qp0RKYcrtYyvjIBW8P/Z1j8bjcpaY+sdB9xXze5/n7O07nycmtDfMd
 MnRQbrZx/wRiGXHOWEuH+AsshProsAM9yV3xMKclRNtusoqU1Nx1+/LIV+n0dIDxicl2
 BS1M6KSw0+LY0MQem9btk7Q7ubVFz04GCzRhDT4tgce7ww94ygfxlIkyKCHhAsea8Xyy
 Tx4g==
X-Gm-Message-State: AOJu0YzC3WqQFEr1JEi4FSOGYHmb2Vf1Vgc4PiqbH5MSzWOjHoXQycWV
 grwF+0zHIyawXVpMOlDQkUEpAtqEZJZ3KO3mzvwqnQ2vZs55IvAAE91TaaWm9ue6B6ZtnQ8O4rK
 2
X-Google-Smtp-Source: AGHT+IG7ai09kxgh/fcKOSpEdrE9CpwvQNE6JDrtGnci3ayX851N7aWUWSV/Aqv3kYMeHvhTda43Mw==
X-Received: by 2002:a17:903:230b:b0:1dc:a00c:5442 with SMTP id
 d11-20020a170903230b00b001dca00c5442mr6701340plh.43.1709463070609; 
 Sun, 03 Mar 2024 02:51:10 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 ju17-20020a170903429100b001db499c5c12sm6439521plb.143.2024.03.03.02.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/7] contrib/elf2dmp: Improve robustness
Date: Sun, 03 Mar 2024 19:50:34 +0900
Message-Id: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpV5GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwND3dScNKOU3AJdw0SzRFNTwzQLMzNjJaDqgqLUtMwKsEnRsbW1ADL
 EuWZZAAAA
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

elf2dmp sometimes fails to work with partially corrupted dumps, and also
emits warnings when sanitizers are in use. This series are collections
of changes to improve the situation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (7):
      contrib/elf2dmp: Always check for PA resolution failure
      contrib/elf2dmp: Always destroy PA space
      contrib/elf2dmp: Ensure segment fits in file
      contrib/elf2dmp: Use lduw_le_p() to read PDB
      contrib/elf2dmp: Use rol64() to decode
      contrib/elf2dmp: Continue even contexts are lacking
      MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer

 MAINTAINERS                 |  1 +
 contrib/elf2dmp/addrspace.c | 51 ++++++++++++++++++++++++++++-----------------
 contrib/elf2dmp/main.c      | 25 +++++++---------------
 contrib/elf2dmp/pdb.c       |  3 ++-
 4 files changed, 43 insertions(+), 37 deletions(-)
---
base-commit: bfe8020c814a30479a4241aaa78b63960655962b
change-id: 20240301-elf2dmp-1a6a551f8663

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


