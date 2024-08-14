Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7718C531DE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNY8-0001rh-1J; Wed, 14 Aug 2024 19:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY5-0001fz-2v
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY2-0006Vx-L1
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so1060332b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678617; x=1724283417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYFEGUaBbs4kAr/qhpAyjUWtir2g5OojC1AciDAIaeA=;
 b=a/wh6CFnrZF+SvqoJIGBE0rNFFquOHRbtwPbnEWcv8oMl8VhVYfthVt9q1NUnieat3
 +7rbaWV8I8wR+9dL5Hmj3nsTmr/SAhOZgr6bZT3O+laOETH0ck9mL2Si3+SdbD1qt1DO
 4ouyKh8wgsQuTzg2cBwSE+panYpQwHeWJSrGSA8HreEH3ChfFMKAXC9HcQOqZN/xIhgL
 vzZjIdWtIM2uzfJQh8A/rGuvU83DFZv+pDfz+KGgjugTlbAPZLwzrn4NRxVT5VqcstO0
 ZyH2zr75LCc6Zg+y4+DX9iZUaI/mP/bc8JdrHvTpbrj1fGkzIVFCecw52Xx7vESl0cAS
 zMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678617; x=1724283417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYFEGUaBbs4kAr/qhpAyjUWtir2g5OojC1AciDAIaeA=;
 b=kcg/dFiHURQKvb9T3glR38e6Y4OH2Te7S4/heaUex1/jhcvfj+CJYayp/pIAD/hK0s
 nBHNr12gPno4Jn+hUH/Kowtupff1XQKDLBAnAHiH8soezGwT8EFq84NXwstzqb2Gxqbv
 l3rW20gigE2Jy658cuuI/sjqTeQMbtgw7Q5Rr5pzXDl8ar/0hAuKwMONDG0821PsELx9
 kGxJ6a+lw7Yq4GMgyEmBWDCrh0/OwU91XB3vrrUmycJj0MPbbptTsh3xhEVnFbEqHe4K
 lw6V6Jm+d2T9ARvxKE08mRTvMiSghXFZysCMobl/T65iSZXiTA2bo6TSmosZbQR2BHWT
 HCHg==
X-Gm-Message-State: AOJu0Yxpxrb99TdXswdYzHu7LrAa4LmUozzgMhotK5EKKz9bLCLQr0Sm
 ozaN1C5tsh0c76Yn59NhUGbJGjyon6oY1tcsBdg2uN2wwZWVU3RPhcSLFwF02NcnNzmDspJZLrJ
 0hUg=
X-Google-Smtp-Source: AGHT+IEK3TwW4ycE/0mRFuPXDeQ5wyJmp0/McRZ5fntPOU3bdIsVbC9LiikVo5iCDBOKLiIN8n0V0A==
X-Received: by 2002:a05:6a20:c508:b0:1c0:f630:97a5 with SMTP id
 adf61e73a8af0-1c8f859e750mr1567761637.10.1723678617181; 
 Wed, 14 Aug 2024 16:36:57 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:36:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
Date: Wed, 14 Aug 2024 16:36:41 -0700
Message-Id: <20240814233645.944327-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Found on debian stable (i386).

../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
../contrib/plugins/cache.c:477:30: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  477 |             effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 512ef6776b7..82ed734d6d4 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     n_insns = qemu_plugin_tb_n_insns(tb);
     for (i = 0; i < n_insns; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        uint64_t effective_addr;
+        uintptr_t effective_addr;
 
         if (sys) {
-            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
+            effective_addr = (uintptr_t) qemu_plugin_insn_haddr(insn);
         } else {
-            effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
+            effective_addr = (uintptr_t) qemu_plugin_insn_vaddr(insn);
         }
 
         /*
-- 
2.39.2


