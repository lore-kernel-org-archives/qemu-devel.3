Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E62F106F311
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gtb-0000dx-Is; Thu, 26 Mar 2026 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gtZ-0000cL-1C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:20:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gtX-0000J9-Ak
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:20:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so6655755e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quobyte.com; s=google; t=1774516849; x=1775121649; darn=nongnu.org;
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DyHR0HRkqXdCXirZ0a5a3vv9reSIjx66xb7d3/MeYYQ=;
 b=Qv7VPMC0C638VNKLIbjRiEOwXpO4Ks0Wg8vXntuqRGM3JmjjDZeqP2U88iTeIfX6ng
 UbU4Z6URx1sqIXZJmkpDSE8bALmcrxDJy+rt9wpUNyxESEiD3qsQkkQuCRUtdQwMjuY+
 q6vYlyK2dLTJgXkZOUWDXNfUj6H1RbT7sLoDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774516849; x=1775121649;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DyHR0HRkqXdCXirZ0a5a3vv9reSIjx66xb7d3/MeYYQ=;
 b=eXtL6TMiJpl6CAc6AGrH4PGUt4kF17CzYHKbxml5vsOPh10SLadlKh/BDT4w/tOTIZ
 cuofttEV6m5xbdgOjofb28jN6Yrfxemh9wyua0DyM/3eRdDC27ssSQ+NME+vFhjz7N3E
 Wt6MwkF7Uq0mY0vG6dHXKJ4cVNIjutVn2ky19HGq8WkU82xrDQL6vaehIokCk1Fp22JR
 WMNlSrlDIkGfCqZQvtTt4VHflbiAYOQTLnMrCLw6ks9HGQCVn7ON8S1dwBmpcy9KuSNa
 C8L4Z/cHy7k9toBTj+s6LD6dpwg31vSGfsEKg22lmbE59UhZy7nwfSh2/5CB94+QPCmq
 rO/A==
X-Gm-Message-State: AOJu0YyujMw0xsWrhVvdNZRUtDdCslW8aAex3EGRQE3x6PXFVZ+98ODH
 PTlnU5TsVUC9aOi4f5HfWibNukuPBYBdULMe0osGBe1LrPvUHFEbWvYMyEbfjyX/ogvzL3M8nV6
 jtsQAw1xUutJ936+vmaJx2pUo0dUUe1442kSg9ld/HNNnrxYqbEMcBBECsN0NyR9OMdec
X-Gm-Gg: ATEYQzwBKbAeppFzSpkWQ8vd6HXHNu5SVuU+uzMCyQEcez9vLn1mkPHEaqLChhyI4C7
 wq4rYQzAfWoGwCmU5GSVvcu905PeYrCbSovvHgzR7OUsCJnivQTgzYWyBxu+fhpUMHPICaH62zB
 3xZs4gfW0++6rVEmjPxmYhlWAlrYVtxLHX538QeX/wVWYX2ojbc66RNwuGSCnKVSjS9NU0fHVpT
 4LNDXRyTPggT4JZ8zciLCNThozN2x0G4UsE1TiqTrngaxBWSg6gt7az3t2h6UgVRAoya/iLVntR
 10S1ze9rwvl2eBsQPdpH1kPXKeBC4/kalY8Bja/IJPi2W03Kb+Px00b/RmaVxPguSA7OKWd7TjK
 A9oMJCJQh/2XiBOnT+grg5brL+H5VZPbv+nuZ9r8tS1cyuRACHhnvhr/GNqmGSBaekiPeXEZ2Wy
 hjyrPhIt064Y0AujnJsTSkQGLAmxYJQ3XnhPS4nGOBhPuJThzKv9EPj89wkaVTnL10NoC+Q3NAf
 J4kQ2qsZAjocClT7pxPQPCWOlW15XtIusKQDzMnlOtle2Qr1P/+rLBJwZE=
X-Received: by 2002:a05:600c:45c4:b0:485:3dfc:57a with SMTP id
 5b1f17b1804b1-487160717d3mr100682155e9.32.1774516848951; 
 Thu, 26 Mar 2026 02:20:48 -0700 (PDT)
Received: from kaisers.corp.quobyte.com ([24.134.167.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm16474295e9.7.2026.03.26.02.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:20:47 -0700 (PDT)
From: Silvan Kaiser <silvan@quobyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 pierrick.bouvier@linaro.org, eblake@redhat.com, armbru@redhat.com,
 Silvan Kaiser <silvan@quobyte.com>
Subject: [PATCH v1 0/3] block: Add 'posix' option for file locking
Date: Thu, 26 Mar 2026 10:19:45 +0100
Message-ID: <20260326091948.194529-1-silvan@quobyte.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=silvan@quobyte.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU currently supports three values for the 'locking' property of
file-based block devices: 'auto' (the default), 'on', and 'off'.
When OFD (Open File Descriptor) locks are available, 'auto' and 'on'
use them; when they are not, 'on' falls back to POSIX locks with a
warning.

This series adds a fourth value, 'posix', which explicitly forces the
use of traditional POSIX locks (F_SETLK/F_GETLK) regardless of OFD
availability.  The motivation is that some userspace filesystem
implementations (e.g. FUSE) handle POSIX locks correctly but do not
fully support OFD lock semantics.  Issues with OFD support detection
on underlying file systems and some OFD guarantees not being fully
supported can prohibit users from using the default OFD locking.
Previously, users in this situation had no way to force POSIX locking
without disabling locking entirely.

The series is structured as:
  1/3 - core implementation in block/file-posix.c, util/osdep.c,
        include/qemu/osdep.h and qapi/block-core.json
  2/3 - documentation updates in qemu-options.hx and
        docs/system/qemu-block-drivers.rst.inc
  3/3 - new iotest 315 verifying the option is accepted without
        fallback warnings and that POSIX locks are applied

Silvan Kaiser (3):
  block: Add 'posix' option for file locking
  docs/system: Document locking=posix option for file block driver
  tests/qemu-iotests: Add test 315 for locking=posix

 block/file-posix.c                     | 18 ++++--
 docs/system/qemu-block-drivers.rst.inc |  3 +
 include/qemu/osdep.h                   |  1 +
 qapi/block-core.json                   | 18 +++++-
 qemu-options.hx                        | 10 +--
 tests/qemu-iotests/315                 | 88 ++++++++++++++++++++++++++
 tests/qemu-iotests/315.out             |  7 ++
 util/osdep.c                           |  9 ++-
 8 files changed, 139 insertions(+), 15 deletions(-)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

-- 
2.47.3


-- 
Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, Dr. Felix Hupfeld, 
Dr. Bjoern Kolbeck

