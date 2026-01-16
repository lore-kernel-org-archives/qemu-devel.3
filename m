Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93348D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtY-0006sr-Vf; Fri, 16 Jan 2026 06:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtW-0006ip-Nx
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtV-0007Ne-4r
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-432dc56951eso1238901f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562491; x=1769167291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hYBppovx5aTKboLp6qMxPvKWQRGV5NsjKuRsihbv0cc=;
 b=WSxUESZwOcYUEZDb1iG2HEp04ik0dSm/xMAG7YEthY0M/uAZffBUNOE6L55UJz29ZZ
 bo+galtlegvHPhRKlqSB5LLNg6XQl6Vys1faNemkFroy5vW8P7BSy/fqhtjmlrn7ywBo
 B0E6w+aiDhpRsMTJZbrLNYA6f1EXlyiG7BVcEAv7LAwMbON7oAvM5lZsxq51/0Kf4bR0
 A9zuP1dceYEMZ0eNrA6JkWZNq2Vxrt/ncvjXTp/YuAX8m9ABe68qTxjynfqguC9pfG6F
 0i2Idrm8tiPhNUp9AW95tWugz5X0UvHQdGfQPDZ487VWbSFJxL2WIzFeK6cmNc6CQM9v
 6OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562491; x=1769167291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hYBppovx5aTKboLp6qMxPvKWQRGV5NsjKuRsihbv0cc=;
 b=fn2kheec8HpRvnkJpLwQkLNgEwcB54mE4dOrdBIsU3/ai38u/tuPxa68ykcTnOngbX
 mMGKiQcE0kgm+rbSQmnazd7PB0w/RcagyJV/lfr1bBHlSPuPtlZqh9jsgVm3+8smS/jP
 Fv+b+B8LhNt/6xKDXIQ70RNBCYqzvTBPC83AfsFkKsnx2dXpDl3jVyI5nPlz9DAejFEi
 IGuESsOC3lVnqhLHFH1Q3a58bHAY9oFbDohOxnQv6UTRIkoQfXNu1PyQ6Piqz1gYTqsK
 1Qk9VMEpRIvl5dZP4xunDb+6hhO72gpQ6YKTVIjeSISbFvM9Cs8Tr4hwhT3G5x0sopR3
 teog==
X-Gm-Message-State: AOJu0YzUtLnf/ujo+Pk7WDg5c9aektOI8eclX6ABapld8sHnClOHGOA6
 zGvzAtjkBao8Ey+uUQsCexp9cp2ZorAr7T/NreIRMCyXWWF6RYRQo5jf6UdxYpeECmhCBfLd/Vh
 khoe7y1A=
X-Gm-Gg: AY/fxX6r0vD0qw3kyMr9l5aQMen8k0ZPq0KZYg3opypwMwYx1y6q5QDrZHzbzXg2H0y
 Kl2zWSuBJ3MOH3YYJHkz+XtXLqPkrqOZwx3+ymy4au3El468dS4x25YCti2tW3DzHAmk3c7a8ur
 EswxIaTf79eb+31R7wyn47Hu/Y0XEyN8HVPxCWfxY5EgQg3CC4Z+L+X1k18WgXQj2tYW/Smr7vC
 NVRyVOxNy6pumgE87f9YeOiuHiH7Z4RP8emBOcCDH4vaoP1Y9RNbVlJZ5Lo092de85lz/fqhvPw
 CNnWDibxd6kP0hcaIfpAHDRGzncJzmCrL4fevyDLVGmA91ZzbFnH/NBb7eyhnfU7f5PzRM4qMV3
 zueCKXWOIMiXG1JKcLSi3SurVWdKfqE1FSoldhr0tSDO6eeqc0zUj+mwb62S4C7u2sqKZyBn6ce
 tmpWuxPwnpdI7AjFe4VINvbSnN4AVjrFbBjuCXoJCRaPILVnRk8cWn5zINXWEm
X-Received: by 2002:a05:6000:2389:b0:430:fd9f:e6e2 with SMTP id
 ffacd0b85a97d-4356996f593mr2867406f8f.9.1768562491069; 
 Fri, 16 Jan 2026 03:21:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996d02dsm4581186f8f.23.2026.01.16.03.21.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:21:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/30] tests/functional: Require TCG to run reverse debugging
 tests
Date: Fri, 16 Jan 2026 12:18:07 +0100
Message-ID: <20260116111807.36053-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Record/replay is specific to TCG. Require it to avoid failure
when using a HVF-only build on Darwin:

  qemu-system-aarch64: -icount shift=7,rr=record,rrfile=/scratch/replay.bin,rrsnapshot=init: cannot configure icount, TCG support not available

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260115161029.24116-1-philmd@linaro.org>
---
 tests/functional/reverse_debugging.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 8b9507674a0..8e6f0b0e923 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -67,6 +67,8 @@ def vm_get_icount(vm):
     def reverse_debugging(self, gdb_arch, shift=7, args=None, big_endian=False):
         from qemu_test import GDB
 
+        self.require_accelerator("tcg")
+
         # create qcow2 for snapshots
         self.log.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
-- 
2.52.0


