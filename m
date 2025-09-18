Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CD2CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLPy-00065g-7J; Thu, 18 Sep 2025 16:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzLPw-00065K-D7
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzLPu-0005q3-De
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758227984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p1n032cmrX/Gp4d8c4D+amtSwM5kKN1y9xGc3stMOZ0=;
 b=GOF5UFKsZrxtviqevtNVz1LNpIcHjitO5Y1+G9yyXUSVjIdCER5xcPRyAbIrxEOdTol3Sf
 ripIlqqHpdS1YzFf3tj4Qo6C17SX7A4lC3a1e15Z+pI3Dd4sz3vvd0h61U8CdFZrju4qit
 wmlMy0k6ka/KDIoAlVQHeJzTl/1cekE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-XAGlmgSYOcGM6ECNOXs7sQ-1; Thu, 18 Sep 2025 16:39:43 -0400
X-MC-Unique: XAGlmgSYOcGM6ECNOXs7sQ-1
X-Mimecast-MFC-AGG-ID: XAGlmgSYOcGM6ECNOXs7sQ_1758227982
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b5e178be7eso35226821cf.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 13:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227982; x=1758832782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1n032cmrX/Gp4d8c4D+amtSwM5kKN1y9xGc3stMOZ0=;
 b=PdKySF3hEAQrhZb7Ak60IUSzmWRvKYaO283jvg7vf878nJW6PU1wgW+JEKEiDCoepP
 v8COi1A+QcLEym/DyrF9KLR7kwyzwRsSrI4f1N4lBsO36owz+QmxLtf5AjIM0RX8O6Ol
 VY5arzYM68S/sdwLpgilPzpWFhqNRfHCaQdBACgo7yndEb9L6L8UcEWnmM6fgdeTBp8I
 StQVhVDKn+Q/RT915BCNICWoO5ZisZ+eVzB51GVvxO3IL4n8JIISYM3vHL+bQw/Oaowx
 oWQb5T23InTTuEm2h2RCQ5EP378gmxQVZ/L7gwGhlI+wisH2vxTjyEts2E3CMhcrSShr
 AMZg==
X-Gm-Message-State: AOJu0YxjMo4LFPC/G2QlO0CyFljgTkHd5plkhpPb+VQbnkcyomAQUM8c
 3kPVJ0wJvP7Y14pB3Dbd4ONuesYI84k5RHU9mA2V9Vk+k1Kf7hSPhqPxP5BlxHsPwkNhRIu3iGy
 l9BhayABMoMPa/hjCX0z/y03OmtEeqW8IB+YADKmdFvC9dBBRemum0WGhrALn9M+RtKJ2F3dysn
 0uQOb67ITckXmubZ3fKNsPd4FOdD3tbg==
X-Gm-Gg: ASbGncvmP0c62UGQf2elzZYGJ2Mh3Ql+PlG77Z7Qp91x3DRp7ugngIFDFvQpTEwaBAi
 NmUDFgN3FpNRAtn4M4jz4DY8ZqkfLuuzICNGogpETl52MjKtrq4UBwm+SSHUFdRMukyX9ZSNBwI
 OX0887IKrNjM0kw+O926iJLjWOcs3iwOB9yRi+tZ2F5LyXAgVsTV/a271A9n0lu3EP/UhdsHzvE
 w5kQb731U5XHGvcH5P7Cqlaou7qRsvBWHZkDFochVFfn56GLx5QlgSslIy+bxdqLL6DjFQ/rVIQ
 gFhmIo+yALVw1M1FBf0gCuERR1gffAvnWm8AZFAamiFVXvs9yxwfflt66cPd0AA=
X-Received: by 2002:a05:622a:1f0b:b0:4b1:247f:4e0f with SMTP id
 d75a77b69052e-4c072e27b63mr10827351cf.57.1758227980325; 
 Thu, 18 Sep 2025 13:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaEyKWvhmE7WECJBQ6jCOZ1GSpJG38uY5hxLbcAC/dHlA7+sDHpbLTFh61FPIVrJId8q3LhA==
X-Received: by 2002:a05:622a:1f0b:b0:4b1:247f:4e0f with SMTP id
 d75a77b69052e-4c072e27b63mr10827051cf.57.1758227979909; 
 Thu, 18 Sep 2025 13:39:39 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-836278b8082sm226276285a.22.2025.09.18.13.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:39:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v3 0/2] migration/tls: Graceful shutdowns for main and
 postcopy channels
Date: Thu, 18 Sep 2025 16:39:35 -0400
Message-ID: <20250918203937.200833-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v3:
- Patch 1
  - Update qcrypto_tls_session_read() doc to reflect the new retval [Dan]
  - Update commit message to explain the qatomic_read() change [Dan]
- Patch 2 (old)
  - Dropped for now, more at the end

This is v3 of the series.

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

Patch 2 is something I found when looking at this problem, there's no known
issues I am aware of with them, however I still think they're logically
flawed, so I post them together here.

Please review, thanks.

============= ABOUT OLD PATCH 2 ===================

I dropped it for now to unblock almost patch 1, because patch 1 will fix a
real warning that can be triggered for not only qtest but also normal tls
postcopy migration.

While I was looking at temporary settings for multifd send iochannels to be
blocking always, I found I cannot explain how migration_tls_channel_end()
currently works, because it writes to the multifd iochannels while the
channels should still be owned (and can be written at the same time?) by
the sender threads.  It sounds like a thread-safety issue, or is it not?

Peter Xu (2):
  io/crypto: Move tls premature termination handling into QIO layer
  migration: Make migration_has_failed() work even for CANCELLING

 include/crypto/tlssession.h | 10 +++-------
 crypto/tlssession.c         |  7 ++-----
 io/channel-tls.c            | 21 +++++++++++++++++++--
 migration/migration.c       |  3 ++-
 4 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.50.1


