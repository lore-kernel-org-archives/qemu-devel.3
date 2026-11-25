Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60146606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=VPzK2t9i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIiB-0004i6-Vh; Wed, 25 Nov 2026 14:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xWIi1-0004do-US
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:31:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xWIhx-0001BX-OO
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:31:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so39031975e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1795635065; x=1796239865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nEYlAACBUs144uff5Gl8HzSjVBPIkQ6olCL9DPatFmM=;
 b=VPzK2t9i7+vZm7RdzaGxNgNtF29yVgEHIuKHzoA4JDXy9XVi5VbFtRB8n8ZdEHTdp2
 fGz1FaH/ItT0z1HziUMjEP0IFTxaS6rvjH7ONszuJNpQ/fICCNiUb1D5qR7k2rWLtY6i
 3CB1L2V7grz5NUtGCY8YyFgbo5+bQZvmPGFMb4EZga0ZRenrTJa/cmiKuOn9D8KVWjrR
 EL3837sG5qLZlfcCptbQHl5Cco03bzxmzTWmX8fP9cFnyMk1MWX3CPIUmDbojSvKu4gr
 YrMY6jGqJM9O4l5e3oUmWFxDjnlkCQVIVh6Tycz/ZEcPOzXWvz7fVSJdPhUtAN90itqz
 4k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795635065; x=1796239865;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nEYlAACBUs144uff5Gl8HzSjVBPIkQ6olCL9DPatFmM=;
 b=yC8qKVpezP0i+x9h046DTnN06D2716oEX07d7DVsG16M15O6UoDr4xvdtWR8sAgaoz
 BakUmCE9hGiX9Q5WfpHUjIsun0kguGFwx+leJABLzihjudQr0Horp+IwBKudATv4Suig
 Qq5iwqIwyxNR9mj5fAFlnjnYLBH4Xrra701s29tzFxAzlfAgWdD6u4DMJuGzdtXzKSBL
 b6HXSiVzsduTBErV70Aoh3+2cIATtKA1DYojptc+E810C6Jl9HKztC9z9am5B3kmzLhi
 Oaix3K12Dl0BmOvJpSg1HToSH8jvkHP6CTC1zFPqjU1441ncu5jxTxewa90meJFbTG6T
 r52Q==
X-Gm-Message-State: APuU4Z8uRHXsAZV04upbVrclnRoLgTlB4eWGCgwhrajqS6MZXaFhVPtH
 O7YGUedhtHOxtm5X1kS9FBLA1SCMKpWsWDFCc3Ow8QXvnZZcH26u+F1tFeLFl+U/lo2HaEE1O03
 breJd
X-Gm-Gg: AZFdTZdpMRxX9dRcIHyPbnZ3NAy2JoWWVUoQQ1qNGZS4V873DATuARle+itam799R+9
 oxscXq2eMsDb001siNIZZBWTkN/2+F+Fj+xa1FOff0VYdancFgRSzh1zITd2B7AbcfUnrkINZNZ
 DobwRASXOtczhO8MUnYP/ulydVcjqe4Snx5gaj0wrwT8OqO9FdEBvE3t2wS3ywv3msR/PDeT3/Z
 fAQziLlF8x9xLaUfeFAn2TRG76NRilsgLAuq1jPBzxMW2n2/CLnzHtMZNBpTB/34CDO/CuGfTG6
 2aJESyKtuZcn6Cxn7+Ys9i6fI+quSOzTHTLmyROvEOQfq77XJAxjOf8aPcOIQK+x0dnPLfN1UZ9
 hnASFLJhc7BWaUQZOdSlrasq8+3F1lJkkJpSslh93z5afZ5M5ujmnkAf7Zz8PdoZhf+fdc5wu8t
 3SgWsc9Xutns7Muhg6Mst73MPvZzHIdaUc02T0nAGMO5usKXSHaBZMDW6QsRWC0/mut0wrJpVh8
 nzAV6HI3bBHmrzAAgOSKOgnZxG5IaNsfC0GAmdFPqCh1/sneHNMYbgRjRx1uvNGgaIqkBsMTfHz
 vAZtAEJ4ilUV7lUBXLC8ALXvp/g=
X-Received: by 2002:a05:600c:5901:b0:4bb:5e8a:7c9c with SMTP id
 5b1f17b1804b1-4bb861467c8mr329348495e9.7.1795635064854; 
 Wed, 25 Nov 2026 11:31:04 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:73c7:7c5f:a985:743e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm18133069f8f.43.2026.11.25.11.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:31:04 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/2] migration: fix a source hang on cancel before the channel
 connects
Date: Wed, 25 Nov 2026 20:31:00 +0100
Message-ID: <20261125193102.1423555-1-den@openvz.org>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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

Cancelling a migration right after starting it can hang the source
QEMU forever. This happens when the cancel arrives while the source is
still connecting to the destination and the connection then succeeds.
The source goes on as if nothing was cancelled, then waits for a reply
from the destination that never comes. It waits with the BQL held, so
the monitor stops answering too, and the only way out is to kill the
source. We hit this in an automated test that aborts a live migration
right after starting it.

Patch 2 adds a qtest for this window, which Peter left for later when
fixing the early-cancel crash in 4f08b870f8 [1].

[1] https://lore.kernel.org/r/20260421175820.302795-1-peterx@redhat.com

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>

Denis V. Lunev (2):
  migration: fix source hang on cancel before the channel connects
  tests/qtest/migration: test cancel before the channel connects

 migration/channel.c                   |  6 +++
 migration/migration.c                 |  2 +-
 migration/migration.h                 |  1 +
 tests/qtest/migration/precopy-tests.c | 66 +++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)


base-commit: 2bfbe39d0fff8af881cffe2bab9b615e77807c35
--
2.55.0


