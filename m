Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C9606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wjKUkXFE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnUT-0007H9-OV; Thu, 22 Oct 2026 03:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GL_ZagoKClsLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUS-0007Ga-FO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:32 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GL_ZagoKClsLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUQ-0002HK-Lv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:32 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-89e96c03cd0so1214188b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655129; x=1793259929; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JErEDf1V1JkwNyPIaYWtSeaKHe2MEITTzSoWnSSXLZc=;
 b=wjKUkXFEW59YEjQSxs2prFAbhqAwuoHL3J5t6QdSe084G43Q0yN5JSbHq785XViPJo
 C6bgEI7BlIx0k7B/DgAnBV3tOHdg2CVgUxCb8VQTKWXKvXPP4slTn6te9sYnXNpHquM3
 XRopY7SQmzwDVVLE4HF7hRk2++XMWi1HrA+q77z/a2NEAXmmCvK4hSDGbWzOpf12W7uM
 fxvdnJG5WKKuwxKnTmV833WpP/J1tmwX9BqiI5l49XYXV6Vrp3KdfC+wbY5ruDLds/Oe
 tFna7+o7Dyl1K1pfjR5epmFTNZYuUq/BX5R9HlqotCCDLHLcsfS4uX3KEdqTZE7mCLd9
 HCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655129; x=1793259929;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JErEDf1V1JkwNyPIaYWtSeaKHe2MEITTzSoWnSSXLZc=;
 b=Plddh2HpS16Mz+yVkA5FRsPLIovo80SAiM62q3Mwa5kzgP2g65hEOgUuIvtwYhYiuA
 2uzjqYRnIS0ulhyGGJZJb2uZX+e9JnFw8sCRPYmtkjM4JkVCiTBkjVliK341VBPgVhj+
 B12UjXJoMV+67tbKXPRvo0Yxcu+EPJP2S2eMhNI03ksjcg+3Pox/7HWCdZzz3/LV7pWx
 JXeKJ8iOfHx368sOt7zxyeLS/50XLrrhJwC+yf05KQVs2X0BDT5L0FMWEhlDvW5UDwVz
 AHZbsZJAaljkCZo6Qyg6m2tMxb+LiTAUV0YhBR+SLEqDlWg+RGbFf36l0agdIy7cju4M
 AhLQ==
X-Gm-Message-State: AFq9FYKyqdPUkCfnSfduS4jJe9Yb+20wqfPIG5y3ep1EgzMz4+2wqDuj
 JxtHjg76tvOjc03pYzaAIeO2mV0YV+RgNDNB0q5pNmTmu45R21/OzlxaOMB+AWG/4oxCOyBL2ds
 jbUOQ0q2qvfMY+P8SIKwn1A==
X-Received: from pfav10.prod.google.com ([2002:a05:6a00:ab0a:b0:88c:e369:e5a4])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d90:b0:87c:e44e:5694 with SMTP id
 d2e1a72fcca58-8a089d0d36amr3427738b3a.21.1792655128773; 
 Thu, 22 Oct 2026 00:45:28 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:09 +0800
In-Reply-To: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-5-stanleyjhu@google.com>
Subject: [PATCH v2 4/8] docs/system/ufs: Update task management request
 support status
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=3GL_ZagoKClsLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
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
2.56.0.218.g1ec904b173-goog


