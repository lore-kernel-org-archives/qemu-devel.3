Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141ACCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwomB-0002i1-Hc; Thu, 11 Sep 2025 17:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom7-0002gz-Uy
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom5-0008Pl-9f
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757625849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q0xCKdtfOkP1YdIfm/iDbGYi4yla/eBs9AhWC8h0XX0=;
 b=UtMszfEuUDgGWffP/cnSg0ZsCKQzo56n28bgwxvfSn5O+R1m7V+iLmC5mV7e1sXnGIUxaj
 ndxKLMa7vEJ1KEM2vZnAfXjdILtm9fPk8uzSAv4kDIbV9LS+ugNFLSRyGEIBJd7VVada1k
 GnqsFtobdCQUMzQw+I8QXtYdR4Cve5c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-adlWEkl3OWOicMZjj0BmOg-1; Thu, 11 Sep 2025 17:24:08 -0400
X-MC-Unique: adlWEkl3OWOicMZjj0BmOg-1
X-Mimecast-MFC-AGG-ID: adlWEkl3OWOicMZjj0BmOg_1757625848
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b633847b94so32567871cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757625848; x=1758230648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0xCKdtfOkP1YdIfm/iDbGYi4yla/eBs9AhWC8h0XX0=;
 b=kGTdllvZMs4M5AW+pIPK4AXD/TL1K0rVZeo0JPiwekfbbLDlUx35A17H9hcp50de7S
 AnaP7EXy7SVHTCv0wjFnB0VuZCVZ+RpR2GLfg+K/ATia9ukFcOSyU8Di7M+9RQcDY7ty
 4RFS2wemmIvwX51Hj1QFdP1sqqEYT8OenHvvTbYT3LWqEqh0aernw32596hEG7BTlNJF
 MNJqCpKgK42Feip1cXesVtgYmFzD6emyxwkCQyZvqDbhGp38qXF5cem75A9cASxeYSVb
 RJyHTrzOjt7n9+NYuhNUSls1n2Mt4Re7mt0wGvkPzE+FC1dK8/jRYu4Mam/tTJAbmtlE
 Lsug==
X-Gm-Message-State: AOJu0YyLEZN/T8c98WuqIGDE0+76l4emnbdrPthMmQ0gy43qNaSgbbqX
 0T5tvPRUin3z86cRjhgAiBtxvuCUn6C9ZvTpgXgiJjfIBk4NVUF8et/niq2J89s7z4/X1tN7ejt
 TZAwqdkJLX4VxTzzYxW5eHCVclr3rfBtguWYhUTteVe1jOpm+VeLFpGT52hb/5+EjqVYi63HwtP
 EEyIzoCkxTgwoj54t0PyzfzUZD8hFC+9ncYroWcg==
X-Gm-Gg: ASbGncvlQoIvA/zXoTKc+A/puc62BdZ5LhxZQ7GPfwUg6AgbU/nfju8Oz65fVkQba3N
 orKvibbbDp2PI5SxzIrGRkt82ulddGkoQIqhbs4AWZvx4pzgSCDRcLRWnjr9Jzq/VWdE0o4vgEC
 0Lqf1cEQpH7PcCtHbWd8SiA9BpMcAYJhKQn21JuDWAsDGoSqP2fM0WveSUOxd2WPbdrjc4ncQsX
 9VhVmoK9mW4O64K8KjIGnLJslTXDlGp4fXs0UYKpU/IIiJP9eHqBBHKOCPDLIAQ72On/qVH7buu
 LIVobT0JPTuQt9pplA0Tn1rm57BO3w==
X-Received: by 2002:a05:622a:480b:b0:4b2:d865:3e5b with SMTP id
 d75a77b69052e-4b77d079e0fmr9299861cf.68.1757625847760; 
 Thu, 11 Sep 2025 14:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb2KzXoU/9eMhJlDf+NxCYiIm4huSeIhRKjt4sK6imblmm1sxosHRiAWwto83g3ySf/5HnIQ==
X-Received: by 2002:a05:622a:480b:b0:4b2:d865:3e5b with SMTP id
 d75a77b69052e-4b77d079e0fmr9299491cf.68.1757625847287; 
 Thu, 11 Sep 2025 14:24:07 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c9845c47sm166032285a.28.2025.09.11.14.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:24:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 0/3] migration/tls: Graceful shutdowns for main and
 postcopy channels
Date: Thu, 11 Sep 2025 17:23:52 -0400
Message-ID: <20250911212355.1943494-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is v2 of the series.  Note that v2 is almost a rewrite, so please
ignore v1, and there's no changelog too.

Fabiano fixed graceful shutdowns for multifd channels previously:

https://lore.kernel.org/qemu-devel/20250206175824.22664-1-farosas@suse.de/

However we can still see an warning when running preempt unit test on TLS,
even though migration functionality will not be affected:

QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
...
qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
...

It turns out this is because the crypto code only passes the ->shutdown
field into the read function, however that value can change concurrently in
another thread by a concurrent qio_channel_shutdown().

Patch 1 should fix this issue.

Patch 2-3 are something I found when looking at this problem, there's no
known issues I am aware of with them, however I still think they're
logically flawed, so I post them together here.

Please review, thanks.

Peter Xu (3):
  io/crypto: Move tls premature termination handling into QIO layer
  io/tls: Make qio_channel_tls_bye() always synchronous
  migration: Make migration_has_failed() work even for CANCELLING

 include/crypto/tlssession.h |   7 +--
 include/io/channel-tls.h    |   5 +-
 crypto/tlssession.c         |   7 +--
 io/channel-tls.c            | 107 ++++++++++--------------------------
 migration/migration.c       |   3 +-
 io/trace-events             |   3 +-
 6 files changed, 39 insertions(+), 93 deletions(-)

-- 
2.50.1


