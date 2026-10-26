Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84562606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=rHau9cIs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOif-00051X-L5; Mon, 26 Oct 2026 13:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiO-0004f9-5u
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiJ-0001Xc-Uq
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so3058274f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793036544; x=1793641344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vaDKZpMXtUT+WDQ8nslLWtomle0gQHsSWByJS1W0RJA=;
 b=rHau9cIslo+9F8CsPkJYXACtGmUVd9wF/JgGSMUHbGC2Ae9tKO/4lULIyGT0ct4VXr
 91VMsKhsSIpqCCAnqAUICTW4IzIMEwBSMBW7UKL7tYwzHZr3AZzLqAcs/6gWfsjTt91F
 Dw/aO3BDUf+2bm2mjCZD49YRhtz9817/Tn+hYQwztiM+YihYQyqr5XQmZFtTFEgFTTpK
 TIojzlSqKdu0GFCfCqAmT7JyJwtYpGmxsIybEzx/P1kfEmwRaZVob+zSrcQKTsDWYiQQ
 BHRDUmVs7q2ZPbaV5aOlDQfd+LsIDcu/tFcvoChcT7yu/IEuIO58LqJutbcsV0v4T6ZA
 frEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036544; x=1793641344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vaDKZpMXtUT+WDQ8nslLWtomle0gQHsSWByJS1W0RJA=;
 b=rHddju1ARvUzqr9nc1sPInUHEFW4LHmeZWDjG9OBCqPrP4LGgvqe29GXn2F6Iv7fXJ
 LzP+55NSbniDKYmY6tSmtsxhfYh9BxeEdk2iTS1RjWy508ed6GLhJ2i0R+umvZA7xGrw
 POFSk47vn7r+F55jM2ZuLC+xCbKlAd1yWVi+j7InQ8uqELYO6YlHPggvXEuxxQzZdBUP
 iOpoY8NvTv2b6e4neEOvDbVhs8COodlY2MFPkrw0G2GlVorC9Mi7qhko9DJjZwxCgYJN
 +hH3HSKPegA0naI8bdH6Z87+E5ONIIelqmksmdrPY1tqag2xvRlo1PePj1NXLtGk2pPX
 0Qhg==
X-Gm-Message-State: AFq9FYLVSZPZSLqgPq0ypTyO+Dg8b6m8PQaQa8klXFAdnKDUgfG/1mbf
 lR/06Ed8pdHKMTyobBDMo5X3E0Do5lGaCnKtwWPL2hVvJ8pTWTgtn8UGhiIq1t/aS2MrWLH8NUA
 cgtbd
X-Gm-Gg: AYBFou3j82PIEBAG/k9ONo6J1ePNi3vtd48oWVi+fO+Qgt+Q3ACz5lGTFJkcD4h0i8C
 u7574vTI+RmTOzsyBOtLStS071r2M1aNl/v76Bsm/P0QYFph7h6iSnhU6QhIiXFKN6VZE3BGL0c
 vhPpTknaW1xLt2Sv4UoUgjOsWXM5k/wJbpDPJ18ENdxw++HqQY5Oywju0QAnB6pz//PDN9XA5j5
 dlfzbfZjxfxrJ+r3PvIz7bgUayY9BnRRGH23YeBYII+fidJiRvm7Ba0O20XhM49GM2U7TcNrxLf
 Maj4ZSUBPADJAq5/+ltHvM4ueVuGMyh98aen2qAI44zA/Yh7L5CkKAb8HEdUCTMj2+ZN5iucflA
 4IvZP6zXDGabiV8dPWEr5VfBXVtLqi+KMGPFHe+jmycG04X4O1eWsqIDQQi5ioyxXj67dkoOvwM
 d+W1rBwCUfi3Pn0xOAH92AtNUq9CKOrOClq24PB0byd++powfy/V0JMJAHTYRr5sumnIg6jvyUa
 inh1a/WLeRAMmRs9PZ2eDF8detQpauAj9f/Cg==
X-Received: by 2002:a05:6000:470d:b0:48d:facb:5937 with SMTP id
 ffacd0b85a97d-48e3eb3cc6fmr13803383f8f.7.1793036543602; 
 Mon, 26 Oct 2026 10:42:23 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1a6:7f7f:f573:ba9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm16169111f8f.22.2026.10.26.10.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:42:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 0/5] scsi-disk: fix UNMAP and WRITE SAME racing with
 inactivation
Date: Mon, 26 Oct 2026 18:42:14 +0100
Message-ID: <20261026174220.674460-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

scsi-disk splits UNMAP into one discard per descriptor and a non-zero
WRITE SAME into 512 KiB writes, submitting each step from the
completion callback of the previous one. A drain in between only waits
for the step in flight; the next one is queued by
blk_wait_while_drained() and resumed by drain_end. When the drain is
the one in bdrv_inactivate_all() (end of live migration,
blockdev-set-active), the resumed request hits an inactive node:

  bdrv_co_write_req_prepare: Assertion
  `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

We hit this in production on a guest UNMAP with 38 descriptors.

The fix follows the one Kevin did for IDE TRIM:
https://lore.kernel.org/qemu-devel/20260421161132.99878-1-kwolf@redhat.com/

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-stable@nongnu.org

Denis V. Lunev (5):
  scsi-disk: check all UNMAP descriptors before discarding any
  scsi-disk: fix UNMAP racing with inactivation of block nodes
  scsi-disk: fix WRITE SAME racing with inactivation of block nodes
  virtio-scsi-test: split virtio_scsi_do_command() into submit and wait
  virtio-scsi-test: test UNMAP and WRITE SAME during inactivation

 hw/scsi/scsi-disk.c            | 277 +++++++++++++++++++--------------
 tests/qtest/virtio-scsi-test.c | 173 ++++++++++++++++----
 2 files changed, 308 insertions(+), 142 deletions(-)

base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae

-- 
2.53.0


