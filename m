Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CED0D43367
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 03:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTuI7-0004yY-LE; Thu, 11 Dec 2025 22:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vU87aQoKCpoG4L6GIL6IMAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--marcmorcos.bounces.google.com>)
 id 1vTppK-0005Mo-Tj
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 18:12:02 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vU87aQoKCpoG4L6GIL6IMAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--marcmorcos.bounces.google.com>)
 id 1vTppJ-0001mi-7M
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 18:12:02 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b609c0f6522so843267a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 15:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765494718; x=1766099518; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=X15oZySjJbSCrO2lEvrCvE6Z0EO7LBpy1DdZqpA1W8o=;
 b=wIdOBEaxmVO1BbsfAJhwYNp+JGkcAPAdnQwnTmRWrGzW+GPBtmO58jMJbIM4m9f/oq
 ZfdExjNugqHxcLua3LT3NvYFXM067/pw6IrINsasxk3EUZLnt6LmfefW/0CadU3zuoYz
 7/dy3UWXmIO75Iurl8FPJh/4rAWbHiDtlVwBhhZCQ0xKGSFGGkZkDopqHxUrC7mqneXJ
 vQ+faVjuXmFXYQG+TkyWs2eJhIBnOTyUEx8Jcz5qI3+lI7fM/qBPu/8O+ztE5iHXKWh2
 IHdB4E/sp3PP6UtsqqMFcOtwhiLDUCY9hUfNVhiwHGOqIK/ILIpGUUjgpyoDCKzsmDwr
 S/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765494718; x=1766099518;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X15oZySjJbSCrO2lEvrCvE6Z0EO7LBpy1DdZqpA1W8o=;
 b=NAWFi1gBhwjUW9S7IeKwmFmp9ZW23g1Njz+9lmiVwDSYWJO0Tjf/jOoJ3Kowu8FECo
 CGsTCYN95kdbbGMhM2dJDhJbq1h7UKSGVtu6Ks3BdlnsbvTmNHcQaSnRNGolxiQY/wmN
 oJBE7IrHOGO2J7k6yNzGk6jzCg/nafg4NCBHxQVS8CqqdYWi0BV3k2BLpvsXEfhqhwu3
 TK+grHpDpdfYWPchQLAWkKO9WTNk2tE+bHAqv8Ub3egrkNA5D5Cf/vcea2/HNyAE19sk
 zkNbAip9sRgnDBS4SS5ZU5eLfHRhoJTJ0NCIlLl5eyshSXQdn8Qu1xeba0Yy0Avk44Jf
 H8hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5xPjP/rWBnkC7lPk3ppEAc5OAk19mDhtQMuv343eI7nzIgJmEumi4stvqxldOb4WHqoBGaN9b7ncl@nongnu.org
X-Gm-Message-State: AOJu0YxD/CvqHD5bFZMori8/iki+7+xAvCZfn7MNO1Oj3DIG8f4vVr41
 L1WIGe1dn+PDRatZx1EfNprvNNwC1aZpqNAGHtrbmFvBZ4sNrWn1kf9twDvKp+X/r0+NQLCyQDn
 T+Be3NAfMf2KLw+WuciIHoA==
X-Google-Smtp-Source: AGHT+IEFcwVXn7FGL9EvmunUtSNjXQc5eStgYun9VoGblvSSr3zWfOpDQBfKsyUjtOAo0oG7RF2K9NdfZSKdlVGW
X-Received: from dycry20.prod.google.com
 ([2002:a05:7301:1014:b0:2a6:a0f0:d7bd])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:40cc:b0:2a4:3593:c7ce with SMTP id
 5a478bee46e88-2ac2f8b138bmr226286eec.14.1765494717614; 
 Thu, 11 Dec 2025 15:11:57 -0800 (PST)
Date: Thu, 11 Dec 2025 23:11:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251211231155.1171717-1-marcmorcos@google.com>
Subject: [PATCH 0/1] Clean up TSAN warnings
From: Marc Morcos <marcmorcos@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3vU87aQoKCpoG4L6GIL6IMAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--marcmorcos.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Dec 2025 22:58:02 -0500
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

When running several tests with tsan, thread races were detected when reading certain variables. This should allieviate the problem.
Additionally, the apicbase member of APICCommonState has been updated to 64 bit to reflect its contents.

Marc Morcos (1):
  qemu: TSAN Clean up

 hw/i386/kvm/apic.c              | 12 ++++++++----
 hw/intc/apic_common.c           | 24 ++++++++++++++----------
 include/hw/i386/apic_internal.h |  2 +-
 monitor/monitor.c               |  8 +++++++-
 monitor/qmp.c                   |  2 ++
 target/i386/kvm/kvm.c           |  3 +++
 util/thread-pool.c              | 24 +++++++++++-------------
 7 files changed, 46 insertions(+), 29 deletions(-)

-- 
2.52.0.239.gd5f0c6e74e-goog


