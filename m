Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A2606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xd15vyhd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbi-0006n2-3b; Fri, 23 Oct 2026 07:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3QEfbagoKCpkLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbh-0006mW-1n
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:45 -0400
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3QEfbagoKCpkLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbf-00066n-At
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:44 -0400
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-3adbc9a47fbso813999a91.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755520; x=1793360320; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KS5PcFPM6GuKNH6hmLQ8jUj/BZeM83VjdAF7SqSvQqk=;
 b=Xd15vyhdxZa+neB/hk8gtC9Gpc20cMsMP47eFy1f8HXYXDMgeEoj/BOHfO+ld5gedW
 aYr07mi4wGVCSotjoLx67IvZllJSbApbTdUbe7EDNunAUY22GnkKCoJx4QqT1lR10KIH
 ONCauVfLT8A7s7zssKJBzuOjfpwH+4fgR0TT4sXAUsfTfKJ3QjQR/r3iZtB09rD7w3vF
 tg2kxf1q/b5UkTmEirXizLkctyhASQ1AhQ64l5g+iyVBesxQ7HB4R9MJ17JevifUw01p
 ws7NlzGTEx27lYdl59InqBb12mPBNmuc/0YKVtJzHJ1ls+UU+die/Saw2+0W6RRE/rDQ
 1JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755520; x=1793360320;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KS5PcFPM6GuKNH6hmLQ8jUj/BZeM83VjdAF7SqSvQqk=;
 b=unp9H65/69XJqekFYhewUBJ8sr9G2ZUxetmvJk3xYqzMgddf6+LHVOIJ1s3x5iQe8A
 AocFi5ktapMAs4SXtLymF3Q9+xo6nDrcD1rAc9IX6ee0IOdqpA3E9Ptanh3zJpgjJGEm
 wL/B1pkUwcdmc7kpA1daWYSExUDSneKlz5mZHC+EPgmqu2S7gHqlEUEj0MtkKshX0qqM
 dWhfz4O5jzWDN9CTVztSk+WMHD8/KJCiDeKF0kwqv4lvE9kLAhxW2MjEwGQ/oMnOoscc
 tGkcbYgANjIvrMlMixMB/Xz6btpq3zqeZqMdNii3hTH7e6vn2x5akyaouUAka+EFe+1d
 jBLQ==
X-Gm-Message-State: AFq9FYLwhDEWdHIp3ma6AN5fm/7nK0vQEuBdNinpq5wzoZYDWw8RnvgY
 qUkGW8JuF5L61dbxXuwAOUvLDu6NEf2xaPsMRu0EsaWeHA8ULR7LQYN9kTYVDRpf7FKYIjGsGDL
 B+TsOF7r056RmuNAOri9WDg==
X-Received: from pjgs6.prod.google.com ([2002:a17:90a:4406:b0:3a8:74c5:5a5c])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:580f:b0:3aa:ff61:9504 with SMTP id
 98e67ed59e1d1-3adce5ebc44mr1472815a91.20.1792755520351; 
 Fri, 23 Oct 2026 04:38:40 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:26 +0800
In-Reply-To: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113830.3368902-5-stanleyjhu@google.com>
Subject: [PATCH v3 4/8] docs/system/ufs: Update task management request
 support status
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1046;
 envelope-from=3QEfbagoKCpkLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1046.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The task management request (TMR) handling implemented for UFS supports
QUERY TASK and ABORT TASK, while other task management functions return
TASK MANAGEMENT FUNCTION NOT SUPPORTED. Update the documentation in
ufs.rst to reflect the current implementation by removing the outdated
note under nutmrs and updating the Limitations section accordingly.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 docs/system/devices/ufs.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
index a76fdbe76e..36f5b958cf 100644
--- a/docs/system/devices/ufs.rst
+++ b/docs/system/devices/ufs.rst
@@ -51,7 +51,6 @@ Host Controller Properties
 
 ``nutmrs`` (default 8, maximum 8)
   Number of UTP task management request slots advertised to the guest.
-  Task management requests are not processed yet (see Limitations).
 
 ``mcq`` (default off)
   Advertise Multi-Circular Queue (MCQ) support. When off, the guest
@@ -136,8 +135,10 @@ Limitations
   link startup, DME attribute access and hibernation are handled; DME
   reads return fixed values, and DME writes, power mode changes and
   hibernation do not change any link state.
-* UTP task management requests are not processed, so a guest that
-  tries to abort a command or reset a logical unit gets no completion.
+* Only the ``QUERY TASK`` and ``ABORT TASK`` UTP task management
+  requests are supported; other task management functions such as
+  ``LOGICAL UNIT RESET`` return ``TASK MANAGEMENT FUNCTION NOT
+  SUPPORTED``.
 * The Boot and RPMB well-known logical units only answer basic SCSI
   commands such as INQUIRY; boot and RPMB data access are not emulated.
 * The device cannot be migrated.
-- 
2.56.0.307.g5fe7bd680c-goog


