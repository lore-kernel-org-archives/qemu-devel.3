Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACDBC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitFw-0002k3-Er; Mon, 04 Aug 2025 07:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uitFK-0002Ag-36
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:20:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uitFH-00057H-VB
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:20:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2406fe901fcso28398525ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754306446; x=1754911246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H0+XvFAHaRsjvBfEDEIu48JTCB1Hkd8of5URqlXP/ao=;
 b=XA/qak0C7RZ4C5p7dJE2/q9hE1w0WXURXfbwSToVKUSyJe3SwxFfs4F0KdvR6kdYTM
 mWHm4U3tB1wVKr5nXQHqQ5kZTddXGR4obYb4HNZnxOJ+8Y3N4jdky3gzjNDo1SQbhIdo
 cggQuHbIgx4wN9Xwv/TG6Ad0dK81/O6xm6aGsUiz3dA/PBLbfyPz6voShwzu9kpEfnwq
 ocgwY13RRUczPf4qmjTWr3wKaIQVfRvuRn8fA66PK4i3X8LEfo5x5oHat5JsWfzZ0bep
 QCrAbDeKFou1BcOg3SNEmcdH1n6CS3vxOM3lfEhtjSHduD+sWdr7KYevpJozCwIbLRhm
 vNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754306446; x=1754911246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0+XvFAHaRsjvBfEDEIu48JTCB1Hkd8of5URqlXP/ao=;
 b=UReet6ty0wEBuAksl1OCw5HcoLOuqvqQ7UKaXB/sxeAySx7C+JomXSelN2TTITg2tv
 vPWolfCq7HLzk3t2g3XhYHwIxQGZhGKtbKnZy4aoxOgGUD+wywqasessZGRtNq1fSz/W
 QBIqrQdtgKG5kUPk/rGI50GzZsYI+MLLnFrSzuhI9UGp4vbC+R+1SBHkP6xlcyE8HJgp
 F+ODM+37v7kdk7seYp6wxbJ/OexLo85KmyXrRhi3k+izd436+Hhtb/COP6LObNEmgUdz
 uFRideUBdr6l+xTJbNJ2z5sWG7CCOzhhUp8v+fSuQ3q56b6fb3sCMijfiTbZICddry98
 vrfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzbRxxtvFwnrPzc9i6gx8kEyWTY+z9vcByHG67jCD91eo/Lwvrn5+/dQ84KpAcjW5csj1+TAZWdQ2a@nongnu.org
X-Gm-Message-State: AOJu0Yyq6kF2QlCi1DMNxt5AVCs/svejTP2FF3SIRugBx/kXwGqtjaZN
 F4rhpU+Gi57BmNQdB0RH3/rPP79uwbIWAqwoE4TzmwlED3eVmEHE1co0gmfZ0YxOuw0=
X-Gm-Gg: ASbGncvrbJr9Lrh9gfdfkCSCNWZjB2LHbQn6LxRvXDyCaolOwT+AKaRR4mH5LzewAuB
 YXJfYGqgRxKa+kufQBu62DkR9LnSRF7chxmg/nI0A74G/stObwD1YCeGA/MAAls7RwROlkdLu9A
 +X6yKeC9+Z+VPfVKBqXOH02uJdfilZvdTT0x69GGFMamiTXzSf//ke1hb2iykrC/A1atagOyAoI
 vuQudM34gDIAq2zz71SnaUTnktrr8bajh9gozDYQpJF2qp9yUx/Y0m9HRPTBleU9T8A27HPMevq
 r9bXsm/hgCD74oNX3WMoZkI0o/HLXZqiaAjotcruisVzUXyY2CegL/sFYhfDQdnHZjDH1oCsAR4
 +8PRhy1yzk0lwW5FyXH4Gwih3LaS/HR5dhCwDAXBJx4fBsiDhUAIb
X-Google-Smtp-Source: AGHT+IFrVpJHt/xeSYRQ1wRES3J55PEBPoX5HPiklXErzwA3jg169mDaX854u/09EDI4VgJ0+6rUUg==
X-Received: by 2002:a17:903:2351:b0:240:71a5:f30 with SMTP id
 d9443c01a7336-24246f86a58mr133770055ad.22.1754306445530; 
 Mon, 04 Aug 2025 04:20:45 -0700 (PDT)
Received: from localhost.localdomain ([106.215.159.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e83esm106901675ad.49.2025.08.04.04.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 04:20:44 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: tanishdesai37@gmail.com,
	qemu-devel@nongnu.org,
	pbonzini@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 0/2] tracetool: remove no_check_foo() and if(true){..} blocks
Date: Mon,  4 Aug 2025 11:20:37 +0000
Message-Id: <20250804112039.16377-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x635.google.com
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

This patch series eliminates unnecessary
if (true) { no_check_foo(...) } blocks and
integrates the no_check_foo(...) logic directly
into trace_foo(...). This results in cleaner,
more maintainable code generation.

A new backend attribute, TRACE_EVENT_GET_STATE,
is introduced. When enabled, it automatically
generates conditional block :
if (trace_event_get_state(...)) { ... }. The
generate() function emits code within this
conditional structure for that backend.

Previously, without TRACE_EVENT_GET_STATE,
each backend was required to manually implement
out("if (trace_event_get_state(...)) {") in its
generate() function, leading to code duplication.

Tanish Desai (2):
  tracetool: add CHECK_TRACE_EVENT_GET_STATE
  tracetool/format: remove redundent trace-event checks

 scripts/tracetool/__init__.py         |  1 -
 scripts/tracetool/backend/__init__.py | 26 ++++++++++++++++-------
 scripts/tracetool/backend/ftrace.py   |  4 +---
 scripts/tracetool/backend/log.py      |  6 ++----
 scripts/tracetool/backend/simple.py   |  9 ++------
 scripts/tracetool/backend/syslog.py   |  8 ++-----
 scripts/tracetool/format/h.py         | 30 ++++++++++-----------------
 7 files changed, 37 insertions(+), 47 deletions(-)

-- 
2.34.1


