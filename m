Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7429C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzTj-00078W-AA; Tue, 11 Mar 2025 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzTO-0006xu-TN; Tue, 11 Mar 2025 09:16:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzTL-0003Kf-CD; Tue, 11 Mar 2025 09:16:42 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso9078144a91.1; 
 Tue, 11 Mar 2025 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698997; x=1742303797; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHSz3gYU7FuYTpcHCulk2CPBRntGpOCB9sgjSWQ75vI=;
 b=HkTvi4EMurn215yVWE/o98ImAnied1g1nKzHkjMt3S9lo9ATD9KkwBcCw2PTpkceZh
 aOa/H3mB+51EchIya9V9VQ2jMG4COcsX1nLmFcCA72RbT/DcdktCBzwl09QaC3DzBvLv
 7UbeYasQiDpzEsvc6xKmf7jt8JLC0k4B4asTtNJ74jGgBsGg+3ifEyF8ZV3eofk6daLi
 XhHvwyyfcf9h6+0UXt/UMyR8GDhBx0TwuD0LXAFLVmg+M9RlCNU/ACXcguzbxr2GIJm1
 KvdAvS+BmVviZY3WJOsYlZ65kw9NiDR992yj1fH0OJo6XHjtV7/n2QrO0L9btL4CjZnk
 Y9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698997; x=1742303797;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qHSz3gYU7FuYTpcHCulk2CPBRntGpOCB9sgjSWQ75vI=;
 b=ZdE9wcmjOa4OLmu0PYRDzFsPzzpUTp1wj0nMQi8ix5QnnpGDvGRdQPuK/oa30wDMVD
 3VxKEnehKBXBoAMmFhEHbGqaMUxueKIex4ICAtndRuaBx7XWwHqgwYKECi80Np5Ti/Cc
 ZV4lO20O9XVhCJdaezYx567NsI26Dd50dzgcuYAn39yOW0awI7atAmkw+VSoaq+VkE5m
 eMWSWK7Ig9wdEYLIyWCAD+2xqmdXNLlYSauKd3XGFNaXXi0f3T3WsqqHoPk9tau2KzO+
 eAzseqgVVCyYjnwqgVirL02hGy0DEMGa43JwOhIX+IgNxiEvWf7Q9MWsFZ361pdZhzRe
 SONw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAV+tg3sJaG8v9AWTikg/CvcTJ2PNsgkZcAYJ3kRWi65n+LoPvDwEQM34RIlOCTg/MZnDsIkvDPD74@nongnu.org
X-Gm-Message-State: AOJu0YyzWJj3Lysbtbq4HGI8SrgJEwNOKkDS04b+FtUiA2PnUfS36JX2
 m0LUeexBwlSWYEVYYZhLs7XSEfh6bFJ4wTStw7+yS8sm3RVUKdqz
X-Gm-Gg: ASbGncv3CR/G6tO92TxPepCjQfPfwpQvcfixtqVvZ033pi8YNOyunuMRtxRpTp7pZTv
 uC3DfRHPzkiAeoK2pL/qmPwT1+fL4HYIYiYLbZRojJTSpxZk9wJgD65fbf5GCRrb78CwraJq8/h
 H+PPEDnjB7INdACijLLSYB/QXXFcmnF2pROMrx+cpUJxs91L3ObTDv35DKzY4w1t8oF9Qv6PYwE
 uYP7i627Akf6w14/7O6u3WiArX17258vz9O48pR2kyjr/w/gHwOtfy4ZBp1BlYeqCxbwyyWCLmZ
 WPxk2Qxix2xDdt8rpt22UzADewcX/Rov/mykqhlrX2qT353z3ic=
X-Google-Smtp-Source: AGHT+IFLz+uucpe0DwgCho/MKBWkQSqGGmeSXoVlto+Kg6yl6fuJnCI4qhoowq+/ckROQMqGIrmOKQ==
X-Received: by 2002:a17:90b:254b:b0:2ff:6e58:89f5 with SMTP id
 98e67ed59e1d1-301005260a7mr4589099a91.6.1741698997315; 
 Tue, 11 Mar 2025 06:16:37 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff72593715sm9264585a91.44.2025.03.11.06.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 06:16:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 23:16:30 +1000
Message-Id: <D8DGRIFZE0F3.XV8TOZX11ELS@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/14] XIVE2 changes to support Group and Crowd
 operations
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

Thanks, I merged this series with some tweaks, except
for patch 12 Support ESB Escalation because it has some
outstanding problems as commented.

Thanks,
Nick

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> XIVE2 has the concepts of a Group of interrupts and a Crowd of interrupts
> (where a crowd is a group of Groups). These patch sets are associated wit=
h:
>  - NVGC tables
>  - Group/Crowd level notification
>  - Incrementing backlog countets
>  - Backlog processing
>  - NVPG and NVC Bar MMIO operations
>  - Group/Crowd testing
>  - ESB Escalation
>  - Pool interrupt testing
>
> version 2:
>  - Removed printfs from test models and replaced with g_test_message()
>  - Updated XIVE copyrights to use:=20
>    SPDX-License-Identifier: GPL-2.0-or-later
>  - Set entire NSR to 0, not just fields
>  - Moved rename of xive_ipb_to_pipr() into its own patch set 0002
>  - Rename xive2_presenter_backlog_check() to=20
>    xive2_presenter_backlog_scan()
>  - Squash patch set 11 (crowd size restrictions) into=20
>    patch set 9 (support crowd-matching)
>  - Made xive2_notify() a static rou
>
> Frederic Barrat (10):
>   ppc/xive2: Update NVP save/restore for group attributes
>   ppc/xive2: Add grouping level to notification
>   ppc/xive2: Support group-matching when looking for target
>   ppc/xive2: Add undelivered group interrupt to backlog
>   ppc/xive2: Process group backlog when pushing an OS  context
>   ppc/xive2: Process group backlog when updating the CPPR
>   qtest/xive: Add group-interrupt test
>   ppc/xive2: Add support for MMIO operations on the NVPG/NVC BAR
>   ppc/xive2: Support crowd-matching when looking for target
>   ppc/xive2: Check crowd backlog when scanning group backlog
>
> Glenn Miles (3):
>   pnv/xive: Support ESB Escalation
>   pnv/xive: Fix problem with treating NVGC as a NVP
>   qtest/xive: Add test of pool interrupts
>
> Michael Kowal (1):
>   ppc/xive: Rename ipb_to_pipr() to xive_ipb_to_pipr()
>
>  include/hw/ppc/xive.h              |  41 +-
>  include/hw/ppc/xive2.h             |  25 +-
>  include/hw/ppc/xive2_regs.h        |  30 +-
>  include/hw/ppc/xive_regs.h         |  25 +-
>  tests/qtest/pnv-xive2-common.h     |   1 +
>  hw/intc/pnv_xive.c                 |  10 +-
>  hw/intc/pnv_xive2.c                | 166 +++++--
>  hw/intc/spapr_xive.c               |   8 +-
>  hw/intc/xive.c                     | 200 +++++---
>  hw/intc/xive2.c                    | 750 +++++++++++++++++++++++++----
>  hw/ppc/pnv.c                       |  35 +-
>  hw/ppc/spapr.c                     |   7 +-
>  tests/qtest/pnv-xive2-flush-sync.c |   6 +-
>  tests/qtest/pnv-xive2-nvpg_bar.c   | 153 ++++++
>  tests/qtest/pnv-xive2-test.c       | 249 +++++++++-
>  hw/intc/trace-events               |   6 +-
>  tests/qtest/meson.build            |   3 +-
>  17 files changed, 1475 insertions(+), 240 deletions(-)
>  create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c


