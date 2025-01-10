Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE997E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBQn-0007Kt-MB; Fri, 10 Jan 2025 04:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tWBQm-0007KM-1O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:35:52 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tWBQk-00017r-HE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:35:51 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aab925654d9so360463166b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736501748; x=1737106548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pETirQ8gMZHueGENb+NbJKwsttVKoOOQHvJbKrUYGcU=;
 b=SZGlB7sryzq7T+23lhpbsPgIJFJyuM9ePwCvtFPzaD/w/dtjOgZbU/+//5+L0pDGWF
 gwp7ts8+hYIiWUj5GkICk8piB5L1hHB0U0FATaHndG3BdnRzmAC3DPW4i479OVPMXFQQ
 Vr3UHugrTKRFrvK77nB0baWcE7Yv/rLgHShJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736501748; x=1737106548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pETirQ8gMZHueGENb+NbJKwsttVKoOOQHvJbKrUYGcU=;
 b=XtQCah0tBQ2OcGW7ollfBpvau8Sl+XCZCmUAY/Tt9mxjooVkj4e901ATkFTQN7ANCF
 3sfb4eWY14y9a4GE0VmFdGlceB+WpC4Qy0QgauWpQ1vqusJndwW74AzkpKgD/tzrGvxH
 M1cHG3I2U0saOgXmx/DYZTsTBbyPbJbzxVP8N2XYuZ9ZvUM72vHwZXcEEZb+j6694vsz
 AB+CkgehLztgaK4CQmX064rxii6XW1xBmfRXDwPldvCE0DXrtu9c1J2N53JKb1M/CrmW
 rCESZpBqJiOydaOQ8xrPB94N61L5UWVAARUUvJu8NkJXRTkjCvlw6JWELZKbtfBlFUOU
 08Ug==
X-Gm-Message-State: AOJu0YxYSRbEapMujMpdvYjbMJHBPJA7NwCrIw/WOCXQWcPgZ2L9SFLE
 1CWv3CZCQ5fj/U6ZCH0iUC1Rr87s4hvaaL7ZceOQ7UJuVluB/ZVyScjeucgGFoXaX3f/ZXVMvqB
 V
X-Gm-Gg: ASbGncsot1RezzUJYL9+C5klaiFVeigajgZsvd40dHzj/azD1xkPSXKRDtCYBWWwtLL
 4YEq6MEubDSMAFWlKS0EiCRbHVPlaudISRXBlqXd2urEg+D4wva+oN8iRgbU4PxQEDVcq68dMLH
 uCdCJzz9z+JEjcRfXNDiJRzZzQG7bNU8g2zdy6WDOvgWCVPRQo+KHmt+JGlm+I7eOnCbhq/Oqmj
 nTe4YncPOuJNlrdJMJarqt2RffUJLrZFEPiSSb0Lez2e6c/8QOg10apN0fMDXle0/k=
X-Google-Smtp-Source: AGHT+IF9Q+tc7zeQFkrp5t8due6zm/61UjY1kpKR16BTxlfnx3CZQHqRQ9rAy0+5QTUyBVAxonI8fw==
X-Received: by 2002:a17:907:3e24:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-ab2ab6fd036mr73135066b.15.1736501747665; 
 Fri, 10 Jan 2025 01:35:47 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905f0c9sm151901366b.19.2025.01.10.01.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 01:35:47 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: [PATCH v2 0/2] xen: error handling and FreeBSD compatibility fixes
Date: Fri, 10 Jan 2025 10:35:29 +0100
Message-ID: <20250110093531.23221-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=roger.pau@cloud.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

First patch from David introduces a new helper to fetch xenstore nodes,
while second patch removes the usage of scanf related functions with the
"%ms" format specifier, as it's not supported by the FreeBSD scanf libc
implementation.

Thanks, Roger.

David Woodhouse (1):
  hw/xen: Add xs_node_read() helper function

Roger Pau Monné (1):
  xen: do not use '%ms' scanf specifier

 hw/block/xen-block.c            |  3 ++-
 hw/char/xen_console.c           | 14 ++++++++------
 hw/xen/trace-events             |  1 +
 hw/xen/xen-bus-helper.c         | 22 ++++++++++++++++++++++
 hw/xen/xen-bus.c                | 14 ++++++++++++--
 include/hw/xen/xen-bus-helper.h |  4 ++++
 include/hw/xen/xen-bus.h        |  1 +
 7 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.46.0


