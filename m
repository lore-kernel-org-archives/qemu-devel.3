Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8229DC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRt-0000D6-P5; Tue, 20 May 2025 13:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRj-0008St-Tb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRh-00016i-S2
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg57tDr1hLSW4EBlF63M1IEQEijGGkMw39lQFkGM4v8=;
 b=iMZiNr27Xnn4Bg23jkiedz/5aFA1vyTc/IpGcdz7BHHapFMc/w5AlTR6jCjMb8mSzSCDmE
 Nb2ohYUfchK9OkEfD5oUSu6gBlkYPi4Wd7mT7SH2expBeJXrdB9KAI+ZXdS3v8d+znTWJI
 xBk3O4Tm/RiGQlj2QKNEf8TtUTt3EWs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-4bkymGRUNOyustuN5Wk0jg-1; Tue, 20 May 2025 13:08:03 -0400
X-MC-Unique: 4bkymGRUNOyustuN5Wk0jg-1
X-Mimecast-MFC-AGG-ID: 4bkymGRUNOyustuN5Wk0jg_1747760883
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5f876bfe0so1067329385a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760883; x=1748365683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg57tDr1hLSW4EBlF63M1IEQEijGGkMw39lQFkGM4v8=;
 b=YGG06IUfKPHj2Octz3rMCbGXEjjV6m3ZJUVJWoBj57zLmuvR+YSZbVWGu/rmdF6Xr1
 ElcCpQIqkgcb6MutYk5iKPV94vqSQvCjoql/r9ptYBP5VDs0EYNeZVVnhGCUx2Ln1or3
 0iKf0+sg85EgcT10CUhYGvpPGMd28GdQ9hWzNfRR74wkURatG/gg+1y6GT8JmB9nhVZD
 TXYWV9wvf3vUOcVdbODLhX8EdkQnluaUyNdcgeeGI2C6x9+X60v4FAG/YEFIRmEJqsr0
 lqKigKedLCDXdUQNczDz0glhLOjyUiETDqd5B4100tsiVKUxLpmqzNw1zVu8lcLXqzf5
 eCjQ==
X-Gm-Message-State: AOJu0YzCv6SDQ/9+gvmRTR9tdBwe3wnemkTHRB4m0Hz/sXlpTwSAlzMS
 qUKk0SQ+dTGcyQ84UFgbkskDk/9AoNs5jwvY/NLSSmGLbw8URJgGLLvz6lE5tdEp+7bQoCq8D5C
 Z+RpZoB++s+vNc8x5C/s9w68TRbBy2tshdiEr2Ihj+ByJCUNXuSuEpVlq1agUvRj6sUclYC4ZcU
 0QDXVNNRWNlTeT9Pf31jhV72lLXLTfsvQxlaWFYQ==
X-Gm-Gg: ASbGncsJ7gu7N+4h2/iOal9sXYdAPmhmrCRYgstdTYW1mIfCKw2GjL7MAXFUJoSJGdp
 0jfeXylHrQbQU4wBdDB0RMT11YsKzO4nrUKepzbVvr+M9kgyspTtIJQbDMUchqA6UW9H//3ou1s
 KrHJzppDhI8nfp/L1e5NA+tlQk7oUxbSDLHve/J4Q6lfz8B6vnLFK7XFnoucwKrZ4eNyPpwCVK4
 f2hTCjDv+YStfPm1f/HYnRcpi48hg/CDj35bK07DwBr/QTgyZbbchpjzcUrq/u91nTD5bmTsKLg
X-Received: by 2002:a05:620a:430b:b0:7c9:55b2:c3a with SMTP id
 af79cd13be357-7cd4670815amr2286949085a.11.1747760882816; 
 Tue, 20 May 2025 10:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSX+ZuU2hGc6nYq7kRIuJRV91HuIIRauMHdPEm3A/L3UNohg7zDV5wTFzCibGN197HyNtaLQ==
X-Received: by 2002:a05:620a:430b:b0:7c9:55b2:c3a with SMTP id
 af79cd13be357-7cd4670815amr2286943985a.11.1747760882273; 
 Tue, 20 May 2025 10:08:02 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com
Subject: [PULL 05/12] ci: Fix build-previous-qemu when the version tag is
 absent
Date: Tue, 20 May 2025 13:07:44 -0400
Message-ID: <20250520170751.786787-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Stefan reports that during QEMU release, pushing a series with the
VERSION bump commit, but not pushing the new git tag in the same
command will cause a failure of the build-previous-qemu job at the git
fetch step.

Since the job is intended to produce a build of the previous QEMU
version for consumption by the migration-compat-* jobs, there's no
reason to produce a build of the release commit because the migration
job would end up testing the release against itself.

Skip the job when VERSION contains the newly release version number.

I'm opting for 'exit 0' for both the build and the test jobs because
allow_failure would mask any real error in the jobs. It also avoids
having an orange ! on every release pipeline.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250513133353.23022-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index fbad34138c..b4e39fd7c1 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -203,6 +203,11 @@ build-previous-qemu:
     GIT_FETCH_EXTRA_FLAGS: --prune --quiet
   before_script:
     - source scripts/ci/gitlab-ci-section
+    # Skip if this series contains the release bump commit. During the
+    # release process there might be a window of commits when the
+    # version tag is not yet present in the remote and git fetch would
+    # fail.
+    - if grep -q "\.0$" VERSION; then exit 0; fi
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
     - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
@@ -223,6 +228,9 @@ build-previous-qemu:
     IMAGE: opensuse-leap
     MAKE_CHECK_ARGS: check-build
   script:
+    # Skip for round release numbers, this job is only relevant for
+    # testing a development tree.
+    - if grep -q "\.0$" VERSION; then exit 0; fi
     # Use the migration-tests from the older QEMU tree. This avoids
     # testing an old QEMU against new features/tests that it is not
     # compatible with.
-- 
2.49.0


