Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3880D2ED0C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigln-0007eo-DG; Wed, 21 Jan 2026 17:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglm-0007e9-94
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglk-0003gX-Cv
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UtSAEbSm0kZnEbNa2SgKxnUlG9+9HV0sHHNKWeTiP8w=;
 b=C/fvIqkO1yGTGjmKNCAoLSt2xzP4cHVVmstGwK5Piz3u+MLv+iwluH7C4nlBuGLLyKnDBP
 wmq974SlEGZ2bRRK5KBKc0CF0N3Wf43zW9OmF6KiQgo5lnffx+g8Pww3V4Y4Sc1xb2bz3A
 tDbDSFeITGj6RI2jhyqGS0oUhiB4Ie8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-OosUX8CyMxOEBFtbfGigMA-1; Wed, 21 Jan 2026 17:33:40 -0500
X-MC-Unique: OosUX8CyMxOEBFtbfGigMA-1
X-Mimecast-MFC-AGG-ID: OosUX8CyMxOEBFtbfGigMA_1769034820
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a2e9e09e6so16767346d6.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034819; x=1769639619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UtSAEbSm0kZnEbNa2SgKxnUlG9+9HV0sHHNKWeTiP8w=;
 b=rB+nEjM7sfEXtDjDM23csjddGAi5ObDnRECFvQ3Ubr4L4JsF9nybqnF3yH+uc1+dyh
 jN58bylELYEJr1k6481FwD11FOGa0WIRXZpWaiPiqd8+P9gxYBYnyu40L2ilB5bComa3
 XeyuuGkJILdHRJx1giKAFp6OobQCdPLCl924MWcp4chOysLTMjRBz3Q5oHepFlA8gaWb
 d+aj1gG7mE7usZpXldJNMLMjaBp+06GFkmRq5zViYaSbHQYGXxwrnfizDQT2odJsTx3f
 y93PYVs9G+/1w/fStsMzGL7AuO1OHz70e9YcFwBdMacnYOymU6Ek7wkEofiZoBIaNvnu
 fvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034819; x=1769639619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtSAEbSm0kZnEbNa2SgKxnUlG9+9HV0sHHNKWeTiP8w=;
 b=g37c62Z+PsgK9PB2kiZ9SPeQRDpHPQYjevBODrxKHhcUswPErrC5sqswgwvaL8iDo0
 RCHZVec4akWEYMTxAmjfM64dW5EObVH13HYs+8V/4tBPUu+ppLt0Uo3bSXHVA2UInq95
 jm9sR7XY+c8c0A0EDIG16po0vTobf1w25X7AJbsx5KCl5ZJv/IChjRBDVvUM2pZV83P7
 wD897CgQjjFYR0qSrhvSp72Hs2D6gpHNQQAUQKozMXlfTniowjKeNjGEBbQJ73EsYSvp
 uj4HJDXnXcW0uGj0GuXdH/WQy38VB0N/nkotjIBJ1J71+sgpbsuRW5VYm/37xiUEffDG
 KOHw==
X-Gm-Message-State: AOJu0Yz2qrO4xvh70d+OHxlePGUk9wKNapbmjc0YNchBOYor32Efn+Kz
 fKMl1LIkGndiJS4rLSo2MyiXGfLqC6rOz/zBtj70S4C4RAdmPpaeMOU9DyMKUpBvzTgZvdxEWPQ
 R8nU97FeTbx1qPtRmG0rXeVO5uZT0ywDT/XT3EYA1eSKs2mwJvQvRbSIwiFPoyPW3szGbEdhuBT
 ENKovnJK4jW2H4aZxH3OGH00VScqbnPU/6mFe9OQ==
X-Gm-Gg: AZuq6aLtb8dHacQ2L8Bz6Fsbi2ubtgxLn2ZSO1dKqqqPeburBKZRaDL7t5b+eiN65ER
 E6DONFJsKLXekomhNoZ0MGEIKoHifTdhCiHOuf/8I9TBro6MHRqrY82b0LcA61ZPIr5+IksQseb
 bwZbt5pOl6mvy+OvhnuDjc7cCCAVm2E0TT8+GnaV6uQ5aU8QSiDW74qx9bXW9rAFRr/5nZjQx1k
 DB5Z3McrwEMlAwX5nbWH2WHd6rcXLg2TJAa8qC6RkEwSX4l6fkgBOG75NRFRmtwhM5IXpjas9Su
 2oeSKSGSCKnlWQcGOA4khw7Ih/q0u7Io/wfkpW9LVXr+tAe3XHAiL9Ipx1gCJehHrmE06To608p
 i
X-Received: by 2002:a05:6214:1c82:b0:890:195c:9626 with SMTP id
 6a1803df08f44-8942e4f3380mr266118246d6.50.1769034818874; 
 Wed, 21 Jan 2026 14:33:38 -0800 (PST)
X-Received: by 2002:a05:6214:1c82:b0:890:195c:9626 with SMTP id
 6a1803df08f44-8942e4f3380mr266117936d6.50.1769034818438; 
 Wed, 21 Jan 2026 14:33:38 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:37 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 00/10] migration/colo: small cleanup series
Date: Wed, 21 Jan 2026 17:33:25 -0500
Message-ID: <20260121223336.3381912-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2277445319

While reading COLO in the past two days, I got a few small patches to clean
up here and there.  I also ran this with the COLO qtests [*] and it ran all fine.

Comments welcomed, thanks.

[*] https://lore.kernel.org/r/20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de

Peter Xu (10):
  migration: Introduce qemu_savevm_send_* helpers
  migration: Use qemu_savevm_send_header() in qemu_save_device_state()
  migration: Remove one migration_in_colo_state() occurance
  migration/savevm: Remove SaveStateEntry.is_ram
  migration/colo: Unwrap qemu_savevm_live_state()
  migration/colo: Remove call to send switchover start event
  colo: Forbid VM resume during checkpointing
  migration/colo: Use the RAM iterable helper directly
  migration/colo: Move qemu_fflush() closer to its user for fb
  migration: Drop iterable_only in qemu_savevm_state_complete_precopy

 migration/savevm.h    |  4 +-
 migration/colo.c      |  9 ++---
 migration/migration.c |  2 +-
 migration/savevm.c    | 91 +++++++++++++++++++++----------------------
 monitor/qmp-cmds.c    |  3 ++
 5 files changed, 55 insertions(+), 54 deletions(-)

-- 
2.50.1


