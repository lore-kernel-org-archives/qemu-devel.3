Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BC8FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06O8-0000eO-9l; Tue, 10 Mar 2026 19:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06O7-0000eF-8b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06O5-0008Gr-QP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so40027415e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184876; x=1773789676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryhT2pIL2ziR09MwVWDioEa4N4ab6svjwvbFx+xxq7Y=;
 b=WTmH8kTO+rLaxSZYASWu0s/NVTcmoSc0qKpMCZAK872vJwIZ64CeJrTILnuYjeC+Ip
 yn0cLmVTcNTt0kUgQHSJX1pKrEwF5hwykeIISc2J+whbIkcYqpmQ6x+7v7a3mElNBQGK
 ZGvfCp/Uvy3RwKYgXpGfcpEbYaaBJXx5gNspSuiAzi9hebH+jE+lEo3yjtZ2t73BTbv9
 ARBBZLLSThpyelNr4J5orbnrw7G5iBbtAmweb7YlTmbx5hIbHiliINo7eOXEMSg23EWU
 7Qhjy14llDQa1Qk8qJk5vjtjPV7PTTD/LoVET//4rKpa60+4SigTP1qZOn/ADbFkMIA/
 Uu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184876; x=1773789676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ryhT2pIL2ziR09MwVWDioEa4N4ab6svjwvbFx+xxq7Y=;
 b=WagMX+WKIqDxGyBWlNXpivGbUQ+IIdliYwxbYY3nWLBjzp7BGemlEsCAnmv7Ea/Qdf
 R1nLNfkpgGRRTnd39lG43JfLuF+bUYdTFAhL9YMJiZH8rdNoEhUEovsp5PF8MfUqiEm6
 NY0mIyOwsz0iZeGrXJfmPxtM0jJc+fIdhzNuvnTlFf1o3IMA5XdpdvqEigMwImwTtLM8
 hyDxjHmBL2HW55IQ5T/TP/lUnVmWpH3e/BO9Qkh0e24PJcVv+9w9rEG/oI6h881BFuzO
 DTubTxL52Vtvrhbw2oo3/e8vZY8Cotx0nDnQgZuDhieFNA0U3OwkRSW52UoycJ7txaDn
 CbxQ==
X-Gm-Message-State: AOJu0YyQ+7kYQhUUyso8II3B4Z4RBqmz99lFzWCs0qopJBp2Txsq/sYf
 EADvdQZW28QVsgQ8+lkyYWIOr4TqD9xekAE4XCViHAJYD9t3zmjdpwJXv0hZX8uIMiTwbJA61WZ
 vL45tZlk=
X-Gm-Gg: ATEYQzwePjAUDkRGoY2moWrqieDb4NQxuhaFcl9vaw3UtTWNdJ6+dyfOpg9/Swbyrng
 zD7GzIHVqTFQuWK5awUVqVIHDSoOcAxDg7HmDwDojURKCizaRMsZ36P+VoNqd2qp+MXGuhoFjBR
 Nm60Q844pvxXyfSgYH9+fkyJ4YWX4tdTvw65Eha+mIQlVfVB+ufKpmMbpXrHIhTtGXpZd5o48hj
 Z5SaIZC6cm1ceBeCTGHQ1R0gz9+wrOrWih/r/SgKNu/4uJLZA7s3vmqIgfdJulm4QAnoxEC2N3D
 TEoh3a5bAY5ms4rCP//+73QIMa0XD0RfK8wPMootDXEDuQ1FHoLGsn+wjMhZ7u1ywPk+ujjnIu0
 mI8xVvltjUT+x958HN4wVFhsTh3CNhprktDC0fw77sISSTEVGO4kOo3BjMGSYGLCq7jfDL/X9XC
 ZVhhOY5oiMbU89zGxTugqK8Hm1CHEh6DTXh4i3PXjMcm//ImPlqL2ii2G4LJIUoynowX0VNrET
X-Received: by 2002:a05:6000:290e:b0:439:f605:afde with SMTP id
 ffacd0b85a97d-439f84144abmr1207742f8f.51.1773184875973; 
 Tue, 10 Mar 2026 16:21:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f8224420sm1980561f8f.39.2026.03.10.16.21.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 04/16] target/i386/gdbstub: Remove stale comment
Date: Wed, 11 Mar 2026 00:20:32 +0100
Message-ID: <20260310232045.58440-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Since commit ecd6f6a8820 ("gdbstub: Infer number of core
registers from XML") gdb_num_core_regs is inferred for
the x86 targets. Remove a stale comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/gdbstub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f1ce90a046e..b86520f8f9c 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -39,9 +39,7 @@ static const int gpr_map[CPU_NB_EREGS] = {
 static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 /*
- * Keep these in sync with assignment to
- * gdb_num_core_regs in target/i386/cpu.c
- * and with the machine description
+ * Keep these in sync with the machine description
  */
 
 /*
-- 
2.53.0


