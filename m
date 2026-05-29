Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3E1CD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyAm-0007AK-4B; Fri, 29 May 2026 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAk-00077u-DO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAh-0003OA-MP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so82668275e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064806; x=1780669606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5ag1C+2SG1c3WsflC/6w87NYFOhc1Xx+nqXj9RTveg=;
 b=NStu9ErOgmmuYI5JKfGo+t8xhW6yWsgzQt0znAtRSF3/XjB5aN3TcJMEIC2rG4RFtt
 lf5MoTBXamNUQBvs6B/PU4j5pojEhVuGdYGw+4bapZvTB4gFsCrNqi39osZhUcOAmtx+
 y90ull9GKnqZZfG6OSKkVSPjYN2N7WpfFk74qsjuBVK7GXQSXNUaYXhgZC9Latr7M2/4
 FBlrf9u5xLc/WR5KWEP4+DLZ0tgXyDcdfc19AcwHUxZA1DeUraKw4LQd9sysbad4jXAa
 PuL4aZzg14NOZIEtT6XNjwtf9+ia3PTBjFFo1hqfmdF1HYR6m0/XOhjOrwTVxV20CTT+
 8Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064806; x=1780669606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z5ag1C+2SG1c3WsflC/6w87NYFOhc1Xx+nqXj9RTveg=;
 b=c5z0Zp0QRE1rfK8iPKrHo4fWo1m2kVjoCjqIfi1ETvcUIKvvhKAlnZIkFElSyiQJ3f
 MEojxc6haLSjXFoLge5RiecfFEJfZffaaupTg8PKMU3RM62Mgl0CCPqphkmFhMHyhAhO
 KHrghXDEDibPeUH6avWgi07HMj2fbb/s1ypLQJL9pUaXxfCxPZQPgywyZyclp+H6BlzQ
 psSEJd8DNkR8fX7AXve2isqWW0g2sJA+OMcB3ZhD4BUl/ljkMBSWApG/2LLITYSZYfSl
 jeI+n/6dFXxoRpRkrkXQhaZREZKJmz7OCD8uowlonwxpLBrcfb+K6iTrWPN4TUk2pHHs
 xzqA==
X-Gm-Message-State: AOJu0YxyOuX6SXGUrYSZjoqAo/n4cccvrZTmcArNq87ooqYJVbl/Jt/x
 pQB6/WKRlOt3LGpFwPht2n0jekhyTUtIdrP/zV5vN5h6Ymj+S4YbRSqqGF6zu0iInj5kdFqgtbU
 Ck1kV5P2thg==
X-Gm-Gg: Acq92OFGFUbiBTN4b6+OjLxy0ks5Q7imNaHG2vKNUuhm7iSX5MgKBzPHbSQrPRYJHA8
 ucOshNgyLWaR5dCZjduN6AB4RDmHE0I0T1HLhBvginm3Z2HokYOPjq+Dq/u5j5jnAqGo8smvzDU
 GM7z+Yz28LNj1dSFOgiRQ1v4eBrz9swIcnQPKtv1RgoJByWqgBAWK2t2yhggzum/qPIHUTP1tkO
 kalCEky7KvZL66m8TBBAsbmie8UQIq6rmeP8dadiIaKt2cdxruRPbf2HS8dXeiQRpD54k4vHuTv
 A8+09ZSunzr8heyp1DIa1GPSrG2Uv664LfJGDi7wZtSatOAK978DzcpjU+ZXwTTe956b8hp4HAx
 KWLpGGGwoo2qfpwj1WSUIv0k+1T3ncuTvaEioDA/ZEih4BRKC4B0CopbmjeJQu3aV5C0i+H7zB8
 fAcHeksGDf9mD5TlhD5Vr34JaLEOo39y3uzPLoed0r9MkovcU1yNlnHFJNMIGCtQGvGA==
X-Received: by 2002:a05:600c:a105:b0:490:6e12:542c with SMTP id
 5b1f17b1804b1-4909c0e4476mr45336475e9.23.1780064806113; 
 Fri, 29 May 2026 07:26:46 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c103b98sm14989405e9.19.2026.05.29.07.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:26:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/17] accel: Remove AccelCPUClass::cpu_target_realize()
Date: Fri, 29 May 2026 16:24:32 +0200
Message-ID: <20260529142434.87880-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We removed all implementations of AccelCPUClass::cpu_target_realize,
remove the calls in accel_cpu_common_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu.h | 2 --
 accel/accel-common.c      | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index c42221f96cf..d7ea45ada2e 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -14,8 +14,6 @@
 
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
-
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
 #endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 04482b6b57e..d8ee6d62667 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -52,13 +52,6 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
-    /* target specific realization */
-    if (cpu->cc->accel_cpu
-        && cpu->cc->accel_cpu->cpu_target_realize
-        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
-        return false;
-    }
-
     /* generic realization */
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
-- 
2.53.0


