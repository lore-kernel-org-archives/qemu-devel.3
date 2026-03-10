Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A989CFD88CE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Nx-0000cX-Q0; Tue, 10 Mar 2026 19:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Nu-0000bw-3H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Ns-0008FB-Ca
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48374014a77so159775615e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184862; x=1773789662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6tKvUfztERW9EFL9HLa8BjD2a2aQehJmMD1H4t3ElY=;
 b=WhFIOWu1vdXjCnjRKtgZUxNC7sS/sJjZPIIpy3FB08FGudxHije0o5izI/ZEfsyEZv
 sJAFcZueE+i82jgRN5PnE1bKHlmuNxMH1PHw5XQYXFDNFuYTfMnPaUNbHebvYiclOKpP
 +fknxj06if4BAOA1/DCcm55z4Fpl++3o6SJiUtJUDEsy+RiHBrp7rU59y+4LwhdOs7q6
 Xr8nc0SCV5kVLpfPQ2XxJ0AJntc6C+Px33GiEpr97WbyYahRC1WHUgH4cxeBVQ112Hlv
 8kvaNm0tfYZaX3p3zA7Ch/5XhZk2ulJtKCQdF+dlGgMgP9PkLSMHWP9dL2+vof/U2VOs
 lrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184862; x=1773789662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6tKvUfztERW9EFL9HLa8BjD2a2aQehJmMD1H4t3ElY=;
 b=OVXpgBQ3N0W8XVpt9/adafJlDLBu4FbzqM/uiRFSspyK1YOq9rbxiwpGOf3qNxj9ZB
 ftDBfPRrV8PX9AHumic+5MOKKoHy52w2UHpL/HwB7+oz3gq7Dipc12c+7FQaWepTaQTM
 mmZnX88mII9I3sezYfxJUL0+HgCxpyUxNassgyE9vVw99AaWOFppP3auzEtISsQikqkj
 Z7AgBhCMJbmacBbWWK7xqs+ifNBF4NalLoeWY5zKA7ZLGS/Z/tuaudxvRXUCIv03NIEw
 D5TTGjzCC3FsraHbcYhoZcnK/lbJLJSB2QxnnPdr3XoSN3FKsyYNN6mACn5FuWKWDD0I
 mlng==
X-Gm-Message-State: AOJu0Yzh4mOAEteh/YIWdH7invvF56GrPkNlAkxAwmzZVm02vEVnalEE
 dQpbg8iiBbwdb9zfrsPCJN4rFmt2F7usTk6oRmIcPpwgitfC3fRFcQd+DKmKGhWRRxBAXdyjoe1
 rYkAGNYk=
X-Gm-Gg: ATEYQzzfa/QYq1H4Y3QtE7KUX9Lct/maYvVdmBh/aIJnJDionMqtjvveieAtKDidnTY
 bTjlaB9SaDdhPtTa/cjfXBFWLCW25RtL/WVUml580fOw2n673nuZZPx/s4gR/3xMRSYRI+oGqMS
 c9fC9kDGm/ajPJvn6Hq0owWyJzngWdiX2jFI4YRaP+sTwdPgiA3WSIRD4UWXM8eXcc9w+t2EoJ4
 JTIhhjDvfebBZHsuRlaZYIlPsUUtbKr635L+/9Xh3D+LricM2TQCJX7u43VnJQblOoIx4kLS7ID
 prbL6VpXE006e7lbMdkZ0lTgAJeDmG9l+eg7XRLSqC1O4e+nS5OvVtdPXHKtxXiZdTMd81Zpc0v
 Db/ukVlKrUGtzX5YfwlUs460nRUFZh/nWBPIdRnygkFmKqGEqKmyuCT1Bgw5kEqhhmdd13RRVZx
 GjsdxX4bqJBfcFQG7Bj+rOvOF3cC83gHYMfx2dW/vXyLJN1Utyoyp0y3VHL9Q++G7YDn4Js4yV
X-Received: by 2002:a05:600c:1e88:b0:485:3ff1:d5c3 with SMTP id
 5b1f17b1804b1-4854b0cb356mr9340145e9.5.1773184862449; 
 Tue, 10 Mar 2026 16:21:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f821a672sm1496769f8f.31.2026.03.10.16.21.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 02/16] tests/tcg: Disable prot-none test on GitLab
Date: Wed, 11 Mar 2026 00:20:30 +0100
Message-ID: <20260310232045.58440-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

When adding gdb-multiarch on our container images, we
see the prot-none tests to pass on GitHub but fail on
GitLab. Disable and track:
https://gitlab.com/qemu-project/qemu/-/issues/3329

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 73c2a78215c..70e2ac38f5a 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -117,12 +117,17 @@ run-gdbstub-registers: sha512
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
 	checking register enumeration)
 
+# The prot-none test was skipped on gitlab due to missing gdb-multiarch,
+# however it seems to have bitrotten. Disable, it is tracked as
+# https://gitlab.com/qemu-project/qemu/-/issues/3329
+ifneq ($(GITLAB_CI),)
 run-gdbstub-prot-none: prot-none
 	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
 		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
 	accessing PROT_NONE memory)
+endif
 
 run-gdbstub-catch-syscalls: catch-syscalls
 	$(call run-test, $@, $(GDB_SCRIPT) \
-- 
2.53.0


