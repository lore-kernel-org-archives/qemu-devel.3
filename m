Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD6BC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 21:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to7pZ-0003R4-IQ; Fri, 28 Feb 2025 16:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VCnCZwcKCvMqZiopmZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--venture.bounces.google.com>)
 id 1to7pY-0003Qp-Bz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 16:23:36 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VCnCZwcKCvMqZiopmZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--venture.bounces.google.com>)
 id 1to7pW-0000rc-Ch
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 16:23:36 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fec1f46678so3338615a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 13:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740777812; x=1741382612; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lWNWnue0c31YA9zeqzUvVQoQA8l2UEI+EnJy1W6IoeM=;
 b=tHga/S0k/gpD/oIBHAEceh2EARuWwuEKLp5TcOwrnONcvE+Y0n1O2GK8xAFeRCH7tT
 hnqOb2dIjPMsfScmBmwbr9fUp/WmCHqsZfOV9NkOWSBvgaSUwE0jHs0duL+rc0iDW0Id
 jYWLf1cA0Lq9N24J84Jf/VNAT9XxSCAcVr9sHU5r9hDh6ULKv2NRoveNzKUQ+PIDvKCf
 UZ9mL3jNTKDiuBluUzqFfsb1Et2+ehVML83Q+ks3ejUPHRZbacQn8KtGr3dAUiEflvOh
 4XFfxqOp5X4XtjpHgC3rwdel7SfGi61ty8RnMvxCYwjVxHSidIL4nZaHBHFdFNLWSIYo
 TXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740777812; x=1741382612;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWNWnue0c31YA9zeqzUvVQoQA8l2UEI+EnJy1W6IoeM=;
 b=Lz3OTwD45fZ2K7Hs9n03DxqD2pqGUrWC6rweAZDenQ+2qcBWQZK0YQUkXEZewdoO9e
 XVdfY4V67GiUMaoX7Vu9BRnNDOyfca88bBFkG/ohARSITA5Zsj4BW6CClJBvxTIoqQCa
 efLS6fJ+Ps7tSmq3V/mbdO8XlfvGcpdwwNnZf0x13GiSFHY0d9ZfDgpq80p1KzRLT0oc
 MjbRN7OYX8AlmOxHTfH/d4vJZyutinyAtobtqhr13Emp8FCqIpajC8sgUkzcDh1oj7xD
 Xsq+asw92uuNmnVAIDN8xBeCfV05cyotdCfm/DnjnGKFFjzy3xdlsN4Y+Qkp6ID5yxFP
 ROcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqXyRCMON8DcdxXFqBvlcnoXRMR51UUtV+Sz9TwvHPNC10lRy3hnrrCbMr2IZmmf45VoDvyiASQYqx@nongnu.org
X-Gm-Message-State: AOJu0YzN9DsVohM+di+JEzC1n+u2BnWTjCn6aIth9HnSkFjvn0wDxHOe
 ibnCju0qIjxbIiBND+AzulDscZ/ueY4r1yh5VRzvS3kdPrck4p+VrhMORIsuQqZ1sQ7N9haOsGQ
 t7eOtMw==
X-Google-Smtp-Source: AGHT+IEa5XIFhfJv9FWp13IEr9S6fiU1W7XtI/gFtxz8EGBI4glRCNONPt2LwgjkjEpOR7uIQxFtCWdHFuGk
X-Received: from pjbpd10.prod.google.com ([2002:a17:90b:1dca:b0:2fa:15aa:4d1e])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b08:b0:2ee:c291:765a
 with SMTP id 98e67ed59e1d1-2febab3e2demr8561631a91.8.1740777812297; Fri, 28
 Feb 2025 13:23:32 -0800 (PST)
Date: Fri, 28 Feb 2025 21:23:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228212329.1775669-1-venture@google.com>
Subject: [PATCH] accel/tcg: fix msan findings in translate-all
From: Patrick Venture <venture@google.com>
To: richard.henderson@linaro.org, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, 
 Peter Foley <pefoley@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3VCnCZwcKCvMqZiopmZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--venture.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

From: Peter Foley <pefoley@google.com>

e.g.
  Uninitialized value was created by an allocation of 'host_pc' in the stack frame
  #0 0xaaaac07df87c in tb_gen_code third_party/qemu/accel/tcg/translate-all.c:297:5

Signed-off-by: Peter Foley <pefoley@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d4189c7386..f584055a15 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
     int64_t ti;
-    void *host_pc;
+    void *host_pc = NULL;
 
     assert_memory_lock();
     qemu_thread_jit_write();
-- 
2.48.1.711.g2feabab25a-goog


