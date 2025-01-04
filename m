Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBFAE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz9E-0001Xo-UG; Sat, 04 Jan 2025 03:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz92-00017y-Lm
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:04:29 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz8p-0000Ii-Oh
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:04:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21675fd60feso239089765ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977854; x=1736582654;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gKyALILGIA57coCwNkPBcKsLKOvRR+KB/LHDEoGgyvA=;
 b=WdpW/M81Lib9fmi8HLMes5VUYr4+ESQthJpzQrgk19hEaRnsmryfLbm10pwASQzsHF
 sGL6RaPVA0dXOP7KAhijwxUcpe0A+r+s+2y1jlaQcLti0xl6JHJyw3ZP63FyU4EcCRSY
 O2PG1KzHlof3pqZflRASIWCuDWCyUKt/i9c+uRQrgjRy+VWB5I9/HyH03FiS8C/Bf0qz
 /prXwoGcKRtSgFBcK1maHMKG2mYqFQOswi9V9c9cJ0hlq3hEJ4udYwkLyN8SsL9MmXmV
 qoV+QIlg4HqPJiE+8SqJOyVJXfVMwl5J+FUWrRx8SecaVIU39OLKv9nd7zIwePjh3Ck5
 KROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977854; x=1736582654;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gKyALILGIA57coCwNkPBcKsLKOvRR+KB/LHDEoGgyvA=;
 b=oBKB5rh0nKHVANYkqnUxHgRruiAf1dtrsjOnN+5xGGRnOr9BOOT7HV2AGqJoioj3Ij
 QchORbCa9TjhoKyRMOdvNCV8xbmK2Nkex3zUdoQ9P+ulCiQJrRI2XQkSB21I6kd4W+jO
 x6SbXtU/S+PklYMh1HBbw3RGQ7EQLMgjmLZDcPIR4YGmA6kY8P8v//Xn5L4nT9FncH2P
 jcSGSHD7zVk9BG5q4HXeWNG5C3MM3KVTIR0QhDgDOy5VRkbHYenG92siW6wL2H5OJJIP
 QhPslygjfuFtnDdq5biAMZKhdW9w4Xib3nfRQaSyRtrhEf/DpQOLJKzm0wfmq0DggR9i
 QZgg==
X-Gm-Message-State: AOJu0Yx0RFWwCmXXhD1DdYE8Rh18cJuxBvUBrpXhBUkI2hkmFUu2dzm4
 sQzxtUah4mlL+LjCuWqpXlL+9yKGKIJaZaVzjDkLP8ezj6Avsn7gA/om2fKG3R8=
X-Gm-Gg: ASbGnctIMR1E8SrTz5Np3FUqURR6UlA2Arxme2P5vi7MUnVjeihv2Zhm58WIs+X2DHo
 Q9FXXK3o+anXppNpS7Mj/go+TAx9OhlyL4hdzwfigkB1KaXN6YNlbfqMAcX5abBQiyAr1YAnDET
 tklFiM+X1HhxHeELLKgPHYelHTR9kOiY1MaNWBCj7/3cUFGNnjXxU8gRlba+0/wJXyiZA3KhY0q
 l4l4M5pSuC7brLuBV2OG0axeMR9YO6KdUsyM5QmgR3RCC7cOkM00JrXYwVl
X-Google-Smtp-Source: AGHT+IHP2meEMEx6gX4xZfuFWzpqkHEd2BsYOg21CrbSQ3H8okXTZKt7lpfw8bA7whr2L/4hW54HTA==
X-Received: by 2002:a05:6a00:114b:b0:729:49a:2da6 with SMTP id
 d2e1a72fcca58-72abdd3c2a4mr79007481b3a.3.1735977854066; 
 Sat, 04 Jan 2025 00:04:14 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8fd2bfsm28372519b3a.148.2025.01.04.00.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:04:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()
Date: Sat, 04 Jan 2025 17:04:06 +0900
Message-Id: <20250104-glib-v2-0-12013f3e5782@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbreGcC/13MQQ7CIBCF4as0sxYzA2haV97DdAEF20mUNmBIm
 4a7i126/F9evh2Sj+wT3Jodos+ceA415KmBYTJh9IJdbZAoFUnqxPhiK1Bpo7S1eHEt1OsS/ZP
 Xg3n0tSdOnzluh5rpt/4BmQQKsqjRyfZqO7o7swVez8P8hr6U8gWNdnBzmQAAAA==
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

g_spawn_sync() gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20231219-glib-v1-0-1b040d286b91@daynix.com

---
Akihiko Odaki (2):
      glib-compat: Define g_spawn_check_wait_status()
      tap: Use g_spawn_sync() and g_spawn_check_wait_status()

 include/glib-compat.h |   2 +
 net/tap.c             | 169 ++++++++++++++++++++------------------------------
 2 files changed, 68 insertions(+), 103 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20231219-glib-034a34bb05d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


