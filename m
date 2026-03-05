Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B2EF3D315
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBCW-0002rX-RL; Thu, 05 Mar 2026 11:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rqmpaQcKCvsshiroh1jrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--pefoley.bounces.google.com>)
 id 1vyBCO-0002qv-74
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:16 -0500
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rqmpaQcKCvsshiroh1jrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--pefoley.bounces.google.com>)
 id 1vyBCH-0002Rw-Ad
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:11 -0500
Received: by mail-qt1-x849.google.com with SMTP id
 d75a77b69052e-504888a2a1dso524469431cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772726703; x=1773331503; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DVMX8TBKJABXn8+1Xy5Kx/LrCsFO8Qe5SMY5KxorYjQ=;
 b=pw51m91eo1ePL6x9oWtdyYWBLT4kB/odM5oF5XgJ5nL2t5H7Sy5kOwJlNj0zdVitQ6
 2S6DD0YP+YvH+UwIOszqOqvyNxWYw7+4gHmprIMR/gCA2ctuJPGnjrpe5eaAJhbICG6j
 X389iUyC/nG7LJq2wuJfCtZlUcOAMJyGBtlHXm8T/QuBQrfKrFHsuzyY/fWgm3VTQpnG
 Ahv17VAjPTBgVFPCpNjgbGgDgTrCwgLYalavlj+v65JwzsL/GYgbkDdR4r0SxLp5Gl+M
 fWbu1xenNC78UOADPMiAEa+vYLkmgjB87OxdV8n5SDQscrs+zsM3D59FCYfZZmFeRCgZ
 7//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726703; x=1773331503;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DVMX8TBKJABXn8+1Xy5Kx/LrCsFO8Qe5SMY5KxorYjQ=;
 b=VrALipTxLYNjxJKRuxEQNXsgrGSEnO3F3oO+4jnmtYOSt4M6WSgq1XJh3l1ae428+L
 31lpSv9s3N+7NPv2P8NZ4wIx1eduE9t1TkNOznYn6kBpCaPqU2zHpbWmttaWCiKNCbUK
 n7cM2KgcqU/d0QeVihCiUudLsIcUyYDEt88JArtsYf8gePMw3Ma+x8jVzTjDdsLVDXGl
 Gh9rIIPSJV4zUjcc6LfiEWOU9aboys8ipD2Jrqd7smPJvMXCf/NALaD7GT8sHVNj3mNQ
 sA9+22Ipp0vScRQR88UKPwDHssU6Q6l+oT+IumPDMDtQTiXObdk+ZFxmVCfnBNBvvxMw
 6DPA==
X-Gm-Message-State: AOJu0Yw3iJ4tgs2zkBcFDzUWhtgt5FmI+cvR7RhxmQfuyjZE3SC8y6ct
 sXNG4I1gZ6c5fDNDAMZSF7LQaLJzVWFVndJ81xKqznwiLWC3tdYAoMMaQvPGEaecZ/qw+TuLQim
 19l6aTZ8skrASROYADIpYqlXLmljwlOsRDUkAS/Ecb3cISj3ukkcujLD8OxB9oF4H1Z2gXhbxQl
 GaeqE09TO8vW7HgH8LbtHqH5FkGclX9KCXso1fUpQA
X-Received: from qtbil1.prod.google.com ([2002:a05:622a:6bc1:b0:506:a667:2939])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:241:b0:506:1fc3:dac7
 with SMTP id d75a77b69052e-508f1cf59f2mr1381741cf.7.1772726702649; Thu, 05
 Mar 2026 08:05:02 -0800 (PST)
Date: Thu, 05 Mar 2026 11:04:55 -0500
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKepqWkC/13MQQrCMBCF4auUWRuZpBqrK+8hXcR0TAe0KZkSl
 JK7G7t0+T8e3wpCiUng0qyQKLNwnGqYXQN+dFMgxUNtMGgsGtOq2YksCk/YWWwHfzgfoX7nRA9
 +b86trz2yLDF9Njbr3/ovZK1QadTe3p32XeeuIcbwpL2PL+hLKV/WeijmmwAAAA==
X-Change-Id: 20260223-passt-0708603dc495
X-Mailer: b4 0.14.3
Message-ID: <20260305-passt-v2-0-f0582198afc0@google.com>
Subject: [PATCH v2 0/2] Error-handling fixes for passt
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3rqmpaQcKCvsshiroh1jrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--pefoley.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Some fixes for passt error handling that showed up when
trying to enable support with an internal Google framework.

Signed-off-by: Peter Foley <pefoley@google.com>
---
Changes in v2:
- Fixed indentation.
- Added Reviewed-By.
- Link to v1: https://lore.kernel.org/qemu-devel/20260223-passt-v1-0-101c6ba1c88a@google.com

---
Peter Foley (2):
      Only kill passt if it wrote a pidfile
      Don't try to read the pidfile if passt got a signal

 net/passt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)
---
base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
change-id: 20260223-passt-0708603dc495

Best regards,
-- 
Peter Foley <pefoley@google.com>


