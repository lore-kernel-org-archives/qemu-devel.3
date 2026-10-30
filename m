Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F6606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xjjit7SC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhlz-0006Vg-6s; Fri, 30 Oct 2026 04:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlm-0006Pu-EM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:30 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhli-0001bU-H3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:25 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so749531c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348121; x=1793952921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZTk+bWZv9HgKLG3yBi98N6JwFOQooDFPJWrumdsr+A=;
 b=Xjjit7SCWObbJtbSAfxPAbc6J8DVvpFE4MyRUlbo+j48s3C7pKBSEe29cnOi+2mR7w
 QlnzryDsmQWQShRcAcnDnpAffnLQqLZwp3qmv3mO0ew17lVH+i7/SVmiUzamUHLOCqAc
 SopPUZB+ST68ofTjTMmvEOe0b2hPEx848AfFnRluo+98kNGvnSnH5W0MqbW27qJAyo7+
 OZr7P1JwdoLiEy03eDLuDNaL53X97vTwgQTOhAw6phlJKPRs3jiviH60ccRTkat/Gdfg
 q7kO+dK5YltcND4vQCYu/itLPr5DoJYUCcThAEM1tRhTsLYajzINl2SvyE5JPvbR5V9n
 t17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348121; x=1793952921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VZTk+bWZv9HgKLG3yBi98N6JwFOQooDFPJWrumdsr+A=;
 b=FI1P3FOs0gW0G4JR3p+ILTlJgJuLqk+vWMJgyCD7/W6/ILNPsNLtsnBZ9K4nylivZ3
 2IxMRoY2TMXdHRd6izntmcMc6LlO1HljLX9SWJ7VblfA4JOVm0o5F29D/KLSduCt+3AR
 f+ffLuwQUCAxcwjvXDKUeGr0/sA1MhoMQ/iWLU+mnfQGMi6FRB2sHboDSdA3dvuAISE9
 g3wbEcyZVlNo2qqg+3aJBHbEr1vtF0w9tStshMAcn1UN5CVQe26tvJu92ujwjDLNca/e
 a0GUvCxox7PvN0eyDGUbKXgcTBXxi0JuNqJOB+nRvWb8RSy1269lJUdfEE2H0G7cNEWj
 G4JA==
X-Gm-Message-State: AFq9FYIjdSPPfZM/R5QudVZquQW0myMfV5QHGsdZdXYJHtty0HmlP2A4
 JSb9s/irMzCK388b6+BRB4aFNnVoUzHOHZRXNn8scrMfPrlVCaJ66g5m/7B9AQ==
X-Gm-Gg: AYBFou0WqnneNSVTInE09fw+S+TJSnkHPQXWiZUX35VOgw7PtnqrKgWIXVASObIjD+4
 4iQSUlALImbJ6gTtxwUlgBjU9v19SRI2YZKgfQ88BS5L7W8qcuMLMdcNJPGjkJp6zP4HzTxVbzJ
 vuWMQl3OQXENBR/E3Bibpasm1B5zrlZoq6nMc0q2aK+MZRXgUGPcRsqPFDyZB1C+duWKk4Njr1Q
 +CBQd0TPH9i0/9MKsRB1m3QIjBJ5ncHSG0XZbMllV4AyoqJo3A2yPbg871AzwkkZiW7ebZZ0o1E
 qHeuyx+r6pPj8z9qB4bVDQJOhqC3OiEaZPbb+5BuO5PkaaYQTEY+5ZrjcDm6uDdBtp3klJEGd9V
 drLo8KubWtg1yIO2WmVEj0997xoPgADXGF3Xym3PwGPZ0wyrvKKCiWM7fKosKH//Ci4MdPKOago
 JK3A22SrA4Be8V5tmuwwMH1GY+Dy7KoypbA+Dnuo5q7n4Mlae6L4scIlj9LfQvzpQLjrTh7lEwZ
 H+REmcSAD4NPQNF45xiUotP+ilCUpqF2JgQZ/gTi0ogiJZ9AmZQ3W9TM1Y7Xj4rDy9N7yqHeovW
 PxNOpo5q66isoteAptgrkK6lqjyBWfaa2d/Og43L742nOh5zrIgeqmSmutwjSWsjnQ==
X-Received: by 2002:a05:701b:4213:20b0:1ab:aaf3:389d with SMTP id
 a92af1059eb24-1ac55968e30mr2413189c88.1.1793348121118; 
 Fri, 30 Oct 2026 01:15:21 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:20 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 08/12] docs/system/ufs: Update task management request support
 status
Date: Fri, 30 Oct 2026 17:14:34 +0900
Message-ID: <86d74cbea5667e2062d924d57ed52a7072570d70.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stanley Jhu <stanleyjhu@google.com>

The task management request (TMR) handling implemented for UFS supports
QUERY TASK and ABORT TASK, while other task management functions return
TASK MANAGEMENT FUNCTION NOT SUPPORTED. Update the documentation in
ufs.rst to reflect the current implementation by removing the outdated
note under nutmrs and updating the Limitations section accordingly.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 docs/system/devices/ufs.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
index d3482e92992..7e1fa671ab4 100644
--- a/docs/system/devices/ufs.rst
+++ b/docs/system/devices/ufs.rst
@@ -51,7 +51,6 @@ Host Controller Properties
 
 ``nutmrs`` (default 8, maximum 8)
   Number of UTP task management request slots advertised to the guest.
-  Task management requests are not processed yet (see Limitations).
 
 ``mcq`` (default off)
   Advertise Multi-Circular Queue (MCQ) support. When off, the guest
@@ -81,8 +80,10 @@ Limitations
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
2.43.0


