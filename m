Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05311D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56w-0004wj-Hg; Fri, 09 Jan 2026 00:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56u-0004rP-DQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56s-0003lg-VN
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso29080895ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936750; x=1768541550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJ7Ny1fushQyvG3cJN4w9kLF7wfFexjlIhaGImUgHcE=;
 b=xbYF6w6HrIFoOwXkt0Vl8jJwHys1nvMMQHcmHVUnbu/LOjzSsVgTzVQwbavt+AM/kN
 2fEfoAsOo73/8+9YKHEtkGyOLVFzoUIDOY8SH07+1V7uST2ofm2MQg7VO6EtFrT4/DUF
 7a3tgwqRybWfSQlO2acMglsmmb8arfoBamqVEJljx5arRQIrUL9k/ITR/4MhxqUu4On4
 yz4c05BAp7E2DN2gU2EYJodFh9ozeZcbVIQbH3CVfdQCMRuBBM/mvlisXJ9Gz6LIdGrf
 0ok0MuIvkxicmRC5oXV87eF9UtGE6zjgTTlZWbazkjmHl1w8OALmXwxQLxph+lnTYlXw
 a4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936750; x=1768541550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zJ7Ny1fushQyvG3cJN4w9kLF7wfFexjlIhaGImUgHcE=;
 b=e1V5sxd0mH2cJbT8fhkO+GaCH2yyR95PWOc52IbIa70zJ6AssHq5g0vvRifpVTqq+p
 ZiLE+EsEBTaXHvbDXvT021YlGfQ2SYkX99fABg1sCN/0oLFpQbn3NJhKiNjljhlPNq0l
 r4PkuMI22gaI9r0eAGACCc0cwP23tYIggbMlFv4vNJTVOFx7Qv4bWu9LHVYwO47+3UIw
 sqqJYc1t2RdJr8OkHTIcJcUvzPrrQqsL3NywdB4TGt25h5IFlIbzV9zKk8bhmQv+zGuD
 MLlgg7BQPCqsadX0M4tSVGbrfCHN0/eWSViHn35n2+4eHmisJ+ZSnQIQPGAE+fVoH6sF
 Jkgw==
X-Gm-Message-State: AOJu0YxtbtOuByVQ9sWkkLIqG7z7vT2zWvtcOEjOFSd2BPoMz6rFUoap
 Fr0ZG20QQxOit01+YIkCqENylKJ++iBNiOYzZNmxzIWT7oZf+CZQXmQxUbrTpWzwL2hB5KTK6d5
 jzD7o
X-Gm-Gg: AY/fxX7KWZfygMNI6okrkW5k3fjnergpCHd7IpMREtCvgPrwZaZQ6Gq2Iyw6NQyx++d
 AI3BmxJkGHAml0dWD5SJ7GYayND2uI44kSp9KW26cpv3yxok9vqRAwTb6XraXwUzQRwvDE6qAMC
 wZbJ6ZUUt+hIisTpNNLGGWxadRiRrKloncGNL2GTTmbYXZXf+FzrvhitWlJMXXZFadv8TCK3pcc
 E5jNE2vI6RxLm6YOHadM4YrO26AWK9kLBX5rK7zd99tE7IF3ZwBTVZUGD5djuVP8hTm7wRVDseE
 1O7HzKkNDxf0UydQ+WamF8dJqoHTzho4lXX+UBH0P7tnDcJOhLB42d1MzxUFsfJ3iSWobqmTP+r
 HIaW9xr0YoUdz+GrjTwT5oZiPpcPPsP/uFeBMD7m/nA4zWPLvKPpuvjaNVOgA6Hq+awhVg7cuyn
 aLj3kGfUaRtVjSPrJbTAvBtvdhMhFsFfLY5fKZzH8WRpUsobVBlJGZ01KIBX9HFDq/
X-Google-Smtp-Source: AGHT+IFv84Nysmw/L4ljyHQyu7gIi2++eiUUshUFpTm8sZZ89i+ac5s9lYAqIJnAD8IOl63vwFe6vA==
X-Received: by 2002:a17:902:d4cb:b0:2a0:d05c:7dde with SMTP id
 d9443c01a7336-2a3ee4c080amr84599655ad.44.1767936749536; 
 Thu, 08 Jan 2026 21:32:29 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 28/29] target/arm/tcg/translate.c: remove TARGET_AARCH64
Date: Thu,  8 Jan 2026 21:31:57 -0800
Message-ID: <20260109053158.2800705-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

We now need to stub aarch64_translator_ops. Those ops will never be
called anyway for 32 bit target.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/stubs32.c   | 2 ++
 target/arm/tcg/translate.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index c5a0bc61f47..ddb0610992b 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -15,3 +15,5 @@ void a64_translate_init(void)
 {
     /* Don't initialize for 32 bits. Call site will be fixed later. */
 }
+
+const TranslatorOps aarch64_translator_ops;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7128c633290..3cd05682ce8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6863,11 +6863,9 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
     if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
         ops = &thumb_translator_ops;
     }
-#ifdef TARGET_AARCH64
     if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
         ops = &aarch64_translator_ops;
     }
-#endif
 
     translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base);
 }
-- 
2.47.3


