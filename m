Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83393C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhXJ-0000az-M2; Fri, 22 Mar 2024 12:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXI-0000ad-Cd
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXE-0000kw-AR
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711124062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9oFpckqYNbmEnfFJ0YLkhBdrwqdkYifI03VCLlMi2vM=;
 b=Q4E+i1XBbW3KpzfqfHL4nCuLQUQoha2fQNakXf8PafFyDNvDPCfMBSXFFeMI4v45wyt/Fs
 huMAWWNPv88JtKCrxDsQG1DWCmVBHg/xx9oXJniiAuyoTpqXWJJ3TUY6Omjth5BJJOgnyf
 QX2lKswqRRkx6UeMa0/yV7vtoaCAo1g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-mPqhJg4GP02bBnf5yNDw4g-1; Fri, 22 Mar 2024 12:14:20 -0400
X-MC-Unique: mPqhJg4GP02bBnf5yNDw4g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69651ab4c4fso5976966d6.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124059; x=1711728859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9oFpckqYNbmEnfFJ0YLkhBdrwqdkYifI03VCLlMi2vM=;
 b=rsia+iSZ1zrSwihiTbVMSiDe/Ao1rV1HW2ou5zvnEdl7fedRuzmxz60w2/hxs5MGxD
 IitaDL6pTA7AeTj9F8fZuJFZirK+tkn8Y4gbHxZ65Uz8c4zZuptWgVBi7rGVyTjruZrT
 onkpDEq9aq/iuhwl1+2OJOvUyEQmOoGzhw/pJznjfE89JpzxktdAiKDS+NQPwWfqxbVq
 Oa643JxcIDUC5aBdCglCT6AJYLij7osxqrqebZi/PaLBpzvKxI8BuplMJ++2SP9kiPDQ
 oQS3mmnDHMEsbwuGGepxyzxVTMJB7LZA2fUDGUl6Wft0Z6Ly3nZq/oZ0En9kbUOg6FTw
 9pdw==
X-Gm-Message-State: AOJu0YwPJ36rVqWIdbx7446J3sR1KsKAasABXb6zJXX/bZysHq4xDVOe
 e2iFOC4I0fKt2bXCn/ZgT/rv/U0qa57Zdii1fATkmByL8zetCLoGxSsWwVzNxYCWdW0a7o1TGpB
 SDdjuxYYNerU5I7C+QoDw3ODY77bhv8ZtzwdzwH7fx7iLP+4NO87JMaDAdFbn9XNfzXBoGFjgBv
 ZOywtn8q3H1+WlEEDuCqngYQmiISLkOQNiTw==
X-Received: by 2002:a05:6214:4198:b0:695:c55d:fdf8 with SMTP id
 ld24-20020a056214419800b00695c55dfdf8mr2520176qvb.1.1711124059384; 
 Fri, 22 Mar 2024 09:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyZBXIYvlAN7Ek0OHo+XW0s2OLL+PEKVFOCr5EcEY80oHLPMp3eQWBjQxkUKE6oyQePPXYRw==
X-Received: by 2002:a05:6214:4198:b0:695:c55d:fdf8 with SMTP id
 ld24-20020a056214419800b00695c55dfdf8mr2520141qvb.1.1711124058782; 
 Fri, 22 Mar 2024 09:14:18 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05621420e600b006904c34d5basm1202708qvk.64.2024.03.22.09.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 09:14:18 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PULL 0/3] Migration 20240322 patches
Date: Fri, 22 Mar 2024 12:14:14 -0400
Message-ID: <20240322161417.759586-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:

  Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240322-pull-request

for you to fetch changes up to 8fa1a21c6edc2bf7de85984944848ab9ac49e937:

  migration/multifd: Fix clearing of mapped-ram zero pages (2024-03-22 12:12:08 -0400)

----------------------------------------------------------------
Migration pull for 9.0-rc1

- Fabiano's patch to revert fd: support on mapped-ram
- Peter's fix on postcopy regression on unnecessary dirty syncs
- Fabiano's fix on mapped-ram rare corrupt on zero page handling

----------------------------------------------------------------

Fabiano Rosas (2):
  migration: Revert mapped-ram multifd support to fd: URI
  migration/multifd: Fix clearing of mapped-ram zero pages

Peter Xu (1):
  migration/postcopy: Fix high frequency sync

 migration/fd.h               |  2 --
 migration/fd.c               | 56 ++++--------------------------------
 migration/file.c             | 19 ++----------
 migration/migration.c        | 20 ++-----------
 migration/multifd.c          |  5 +---
 tests/qtest/migration-test.c | 43 ---------------------------
 6 files changed, 12 insertions(+), 133 deletions(-)

-- 
2.44.0


