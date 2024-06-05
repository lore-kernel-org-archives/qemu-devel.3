Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEAC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl1d-0007EO-Ks; Wed, 05 Jun 2024 03:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1b-0007Dv-LZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1a-0004ZR-8k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1sh2IyJdUWGJERi0Eqw48ze6hArP2qCwvSHGaXadPRs=;
 b=WSyoRb4c0vEblVSX8z9ScEdSUWAjQrUkc3nH9NZV3fDNaKrYHNNcThjYJ8k4OOcXWHoONf
 6Nsi38aahJkr/bK1//q0WUEK0OWeYjm1TdBAE27TbXPdN2Nk9HOPavlr8is58MzBmSWo4b
 jU2xoLNh7T22Js6ejw5zvZ4d6/M0+LI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-OwcFbYIfPC-d70SnKhELRA-1; Wed, 05 Jun 2024 03:25:30 -0400
X-MC-Unique: OwcFbYIfPC-d70SnKhELRA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c24109ad3fso2724909a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572329; x=1718177129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1sh2IyJdUWGJERi0Eqw48ze6hArP2qCwvSHGaXadPRs=;
 b=H4xY760n8bAqFrzxlXxSYs5dqk4G5LU5b7h7a2xpSCduMz0qCOBHtOZD8aLd9kr/Q/
 1LC9Gc4VFwAqCMGKcSP/iVfJPbaVNeWRx0nuC8joBMZA/9/rvIe5IAJvkESOkiKcBNf2
 vOptbRqDMG2EdV/RbiIL6P/u49u7UYmYrZ6pj73S7yckWgbvVu/J3UZiZhdCEc7EeVcW
 912VjJyokHB9ChKOo/Uw4HlosOWAuCmhuPZuPxYFBba9K56oPMCBBY/LnBFqdnmTrJOS
 3s29AV5OqwmRuBR7vnMJntjDm8Z/0Mx0S2q0/PCLUX9XpXxNqHEnPFcctggeuU+XFnCV
 T+NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpTDn5IYSfHBaEW9IC27gi/HYoS14oPug3oilEsiewoU4eLFHwtNjwRjE526p3f4y8l903FluHiBaqbZlajI+fHLqsBQ4=
X-Gm-Message-State: AOJu0YwZ2SvD21mRkgeasw5QgdJoXv+/rtmVPFYTUgBe7uLyElkHka5D
 E2g4j0gNNQGhiOSL1H5k8vZd5nUv/pB0E++UPkQQVvC6GTZMtTuvtuvwuHtDm68Zp/k1RL0Cnl6
 4mE0VKPrbTGXjumbFA0Vlh2b41iT5aEBOJqJLZhKxCM6nE3Hhzq1T
X-Received: by 2002:a17:902:f549:b0:1f4:5278:5c19 with SMTP id
 d9443c01a7336-1f6a5a5ca41mr19608315ad.49.1717572329627; 
 Wed, 05 Jun 2024 00:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL4ZANc3KsvHwi4jXSR19V7p8O6fRRXQ96U2BCG2iFVxmEFyE31uM6F9SjBENeonJtP3LDjQ==
X-Received: by 2002:a17:902:f549:b0:1f4:5278:5c19 with SMTP id
 d9443c01a7336-1f6a5a5ca41mr19608185ad.49.1717572329203; 
 Wed, 05 Jun 2024 00:25:29 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6703f7673sm56329335ad.210.2024.06.05.00.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:25:28 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, thuth@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com
Subject: [PATCH 0/3] x86 cpu test refactoring
Date: Wed,  5 Jun 2024 12:55:08 +0530
Message-ID: <20240605072512.67692-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a new library api to check for the support of a specific cpu type.
Used the new api to check support for some older x86 cpu models before
running the tests.

CC: thuth@redhat.com
CC: imammedo@redhat.com
CC: qemu-devel@nongnu.org
CC: pbonzini@redhat.com
CC: lvivier@redhat.com


Ani Sinha (3):
  qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
  tests/qtest/libqtest: add qtest_has_cpu() api
  tests/qtest/x86: check for availability of older cpu models before
    running tests

 tests/qtest/libqtest.c              |  84 +++++++++++
 tests/qtest/libqtest.h              |   8 ++
 tests/qtest/numa-test.c             |   3 +-
 tests/qtest/test-x86-cpuid-compat.c | 214 +++++++++++++++++-----------
 4 files changed, 221 insertions(+), 88 deletions(-)

-- 
2.42.0


