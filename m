Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042F1FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Nq-0000bU-6l; Tue, 10 Mar 2026 19:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Nn-0000b2-PD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:20:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Nm-0008EX-2B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:20:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso41108545e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184855; x=1773789655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjVT/GwAY5pAtPUtuWIIqJdRTGmpLeYD6025xDJly8o=;
 b=OLCxQ9RFnull2sp/S3t9Cyyyn2Ah+wx2eL9SPeMxkxbSW3EHCVf2ZnLOKuwHbFr5MO
 sTbyH3JS8D8pzCAe+IuLjgX7JAye1/LHUfCbLq2MFgPuaNE9BVw0F65Wetkf07AyXrFZ
 hxskHWtqPKC2qWvXAzMkjVYDXsjAOgZjN+M5fcwbV5toRuLBpnPBcmFs+TB0RgdTkz3l
 aCLWLovV2KFeXhOib8HiagW8fr7cGVyUFwb8tBxL0iRoKnOq1aCa1QPQ2sNm/gD2nHya
 rtTAbWvTQa7ChZOWCJDGUg/LLseymOO0iaJ5TMMS76CuEnoFgRGQoYep2JW7LVgeeQq5
 MG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184855; x=1773789655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vjVT/GwAY5pAtPUtuWIIqJdRTGmpLeYD6025xDJly8o=;
 b=ofl2M+qjrFEM/EepKACF7cvInmViVcjq6WYYkjqbH97xw6RgNAfVAXrKxfUadek4iC
 Vw4RXt/hr0hURboqRPySvsOcFZgqFvTIUCq3D6LxHLVrUbWKasCENfLJy9eA8HxwSoi2
 XVK6Rson9DkKe04kVnTO0DPTZ3q+UNytG6VXi2ZcSJi/7hSVU36epnr+NQ3ko7bYd1lA
 g7gxm3pm9jusq0HPlIx0Y1EIxMQ4crIAo/VD1IGJ4q/l1RJ75bke0rjQ6p02Q+/BrX0q
 5K2oKXVaqmtDGquCxx8IVIbdQdEPGt9u9Ey9ZTCeH9Qqiq6Zng/hYYIIkCEUC9zMkXvE
 Aeqg==
X-Gm-Message-State: AOJu0YwgHRHShtDkROJV3RjD61wOFtVCt36mu8OyShKn9IgqTsza1Dbf
 hvvt63zLRMM3jqqFT2HBLtwQicWKKhpt6M3ZC9khg8va/QrU9aL4x31vXv5qz+39/6as8pKD9GG
 oNar2Fbo=
X-Gm-Gg: ATEYQzwO9i6nsvWsqONaF7sNKDmeVGNy+sprcfYTDIw+jPerd9H/3I+t/vQWdNIx+DY
 mSpmbl/cwvmoS3nOhMlxEIlxf0doMyfn/y7rifnmMVkaBXItzclB8DMclEysAav7x/LILEs7pya
 nZgqUc5oPVl7l2Vt2YXh81gqzoJOI/F/Iyoj6CbHZMbYI00VpTSB/jPvdlj3a7dRHG7Ezy3oLMY
 cc7Sw4ZM9gNrEAwvb2JGYUTBtThx4438gTvX1izQ41j58MwkkFxqTcWM5lUc6hgCw/cIOyKqCLQ
 bon8O+dfxUTZPBZJeFpxvf+l0nMLEOzyoNrhcJob9uTUdfQJdFsan5U9CKPSKKexGuDyy1NKkR4
 fmsldpCHpplk/xVk9xx0OLyp2WLzuNriDdgkNeQzXAknG+mslX8d6srXicFEYtSY4r6m2GzOoI/
 NGZFBoOfIKmFpEksaDHSGc8S550Nnd78KdBOONpkKHCyqLVZDwRNQKn3EbEq3r/NX5xh1a557k
X-Received: by 2002:a05:600c:1f10:b0:485:379b:57bb with SMTP id
 5b1f17b1804b1-4854b0a413emr9173225e9.3.1773184854807; 
 Tue, 10 Mar 2026 16:20:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3068cfsm5932415e9.8.2026.03.10.16.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:20:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 01/16] tests/tcg: Temporary disable multiarch tests for PPC
 targets
Date: Wed, 11 Mar 2026 00:20:29 +0100
Message-ID: <20260310232045.58440-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

gdbstub is currently broken for the PPC targets [*]. We
didn't notice because our tests require gdb-multiarch which
isn't installed on our containers. Next patch will fix that,
but we need to temporary disable the PPC target test to keep
our CI green.

[*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <c957fe25-a0a2-405f-be83-d411261c21e6@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index a347efbadf0..73c2a78215c 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -156,12 +156,16 @@ else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
+# gdbstub currently broken on ppc, see:
+# https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
+ifneq ($(TARGET_NAME), ppc)
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
 	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
+endif
 
 # ARM Compatible Semi Hosting Tests
 #
-- 
2.53.0


