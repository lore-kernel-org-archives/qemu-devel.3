Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E803DFDEE2D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSK-0000dv-JO; Thu, 23 Apr 2026 13:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSJ-0000dT-Gf
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSD-0005BX-2z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so88530865e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963783; x=1777568583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5QlbpkhLSFbpydkuquJtvxsAHOyc0Gt7hSL58Wv5bM=;
 b=x6DkY8h2cbp+2SIg3lJkDW5cmx39oYnLc1jU1YC3Me0FgNDkCQZOcZZfAaCJbBZSL6
 SNXX4/9F2l/zOr7HLpE3VZpfdGPpeuQn6C9mJN+NFRqr5i63W6sVxm3HnXCPGfb505P1
 4shihyK9asLwX39gJ0t1Kvj9rKrCjNyPUFJ+iTAvPfEmhpsEWI008h69JVLwP+tIqAAu
 OqQndSlZtgzw3JsGg+XEc+qzwfGOzqCibwfoCVgX/Cwv+BBrvxxc6SndnwTTMBSp662n
 9pbJTDa5/h77y33ntWEo4LqCZoxSBIxxSKI/EwyP4H+4Se72KkLX2ad7D+fGxC137Y3T
 1izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963783; x=1777568583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5QlbpkhLSFbpydkuquJtvxsAHOyc0Gt7hSL58Wv5bM=;
 b=KabJKzhgiLSYbny5aJVjcxTs6PqrVV/hFjPYgRp5R5jYh+xrc8hjZpqaaMMt+LESCy
 JyabVtZExkMtFYe2UayUN1HwWTVvXel7SbzW2wjYVoB//e7/ECITElkel7E5/gMSWT8E
 aoFvSLgZi+kydDKnSUa0SvudKW0BBDYxTzFFp7YT8eWuPLE4mJWj/WnmXzuTR7S2QgIb
 P1bOopWEgNYZ2rPBElAnkAIsLCth9mwdNwS2ldBGHZmnDwwlS/NqRMxumm0CufBFhimB
 4NB2c1o0vfewSkhcy9Pt2hMwfd2HqDS0tloac3bbbxsSKIZwIEIR4Hnrb06bbctOH11J
 rmrA==
X-Gm-Message-State: AOJu0YyhxYRAkd5H488ARuWLJEflV6gm2Ld4MsXOCb4E7LXcMWyyvpCp
 4fKe9o9hH/sz9lsextdUaZduAsTyETsEvzVPWBgrUWW/VlHLCkhMXHzYHLScVoIPLkaMasD1JfT
 D5CJJe+k=
X-Gm-Gg: AeBDievWv8z2sxt7nC1Y69AqbR26R1xYEVeG3Qetmoe7xvRo4e5iHOi7P4hT0bql+wS
 cyi3rFLuYJ21ocnUfBuMY3lNw5UV+Ex5BEyEKlgyrg0YmWwN3gOEt8SkYh4QSNRjgRWH3m+PiXw
 z9ZLFIuou9KXLex7v8DiImURAbBqfcDjlPw45cOWSPoX2qv8Qlew/gZ7t+3d1XCvm8CnDrM38Fe
 oLptVK4vWWWzRXH7evYNomGv3804jkTt9IkZinULTVb/4ZqRHPvuu3aK08iVvV+ueNT1WL7MhVL
 V8nvKJAjsxJXNdvBPuLi78iQhLlKGDZeB5HixroePYX6iHgO+CbZC3WDkNsy5CPRN1cI740E9uv
 QbuDoUQy83nmjfAbh7hq0B1rzp7/gi82mOId8iB/87PDE3+344AHUMfr318x86IIFCS8qoX0/ca
 oW0qgoxYaK4erI8Y6Hf19P4JaLudKet3bzlS2qh71I1/ptPdMfw3pnXFxXwqmoZoVXRRkh8k4P0
 1LnGtgfZWA=
X-Received: by 2002:a05:600c:8183:b0:488:b187:d898 with SMTP id
 5b1f17b1804b1-488fb771445mr339012825e9.14.1776963782997; 
 Thu, 23 Apr 2026 10:03:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a0b60sm156040625e9.17.2026.04.23.10.03.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/16] tests/functional/test_aarch64_kvm: Stop dumping kernel
 ringbuf
Date: Thu, 23 Apr 2026 19:02:16 +0200
Message-ID: <20260423170229.64655-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Avoid the following kernel message to interfere our stdout parsing:

  platform gpio-keys: deferred probe pending: gpio-keys: failed to get gpio

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/aarch64/test_kvm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index 7545f5ed554..a03a6134626 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -48,6 +48,7 @@ def _launch_guest(self, kvm_mode="nvhe"):
 
         self.wait_for_console_pattern('buildroot login:')
         ec_and_wait(self, 'root', '#')
+        ec_and_wait(self, 'dmesg -n 1', '#')
         ec_and_wait(self, f"export PS1='{self.PS1}'", self.OK_CMD)
 
     # this is just a smoketest, we don't run all the tests in the image
-- 
2.53.0


