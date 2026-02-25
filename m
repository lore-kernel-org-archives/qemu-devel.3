Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FC7FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOA7-00079N-AY; Wed, 25 Feb 2026 18:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9p-00074E-DK
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9n-0003Qs-M4
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so2365305e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061542; x=1772666342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PEa1I4PUq5js8xe3wd/G3RCIRdUkaAjJuHmk8sEwGKA=;
 b=jqpBROlwz4091UHV+/osz/QsULh6aMflqtDRGnaN7l1wLBi5rGfhwpO35iI7NCaET4
 NvUEwlNOOIL0aKSO58lOEYFN4+3Sl4ojnt81VMVskv+j1CbztDnVlVtWr3RhHrj7z5rf
 CgLCcrjW9RvGWQFBDJBdMCd03O3/V/0Q7lHAT47B52TiFHq5qGurX07m+2tonX4cqS48
 0gfwnbl4uds85udWtmBl3jU6VtfenyVVaLZb3UoRgXe1wanujhpC+KzmGj3LRjbsdovQ
 MWrhX1rinjlgg923FrYdaw8AXcxTgtj+tiCRqTS7//u0AWppATSZGPw7zchcpyOgaC0V
 cAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061542; x=1772666342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PEa1I4PUq5js8xe3wd/G3RCIRdUkaAjJuHmk8sEwGKA=;
 b=RKr09OO1uxe3/yqkP/XKjcek4SdV/zdDIPfKsrqgXbr0lQ3lUgBNADFX03p6IExbje
 4Zt8uCPbi6GKd3euSyijOgRZtTkoLG9saigAQ5xeSrnHuBeISQ6H5Qt9fVvG/v6kwQI/
 OoQf85CRNLKm84qWUEK0sxJM11HujVk91kkW2DYOFrBvAZ6/0AZO1Y95weJes69FdB26
 em5b7fGtTsY5STRDxenOXsnLJjHd3TlU2W2p3wwHBV35VXxu7Q1tQhf4AhKpV/L+W/9d
 ywvLih+zadUPmk5WsQlW1tRx7Y18THf1pk9EfHXCz6B1FWu7VF40qnjU2xcyFH21WLrq
 WJEA==
X-Gm-Message-State: AOJu0YzHSUK2xmitgazK7UBSbttX0UFftJdT/WY3ph39XOG8ctBRSBd7
 mpNx/lhNEgCGUdGRqxlvUZl+kMbo2vAMM5h5JejucAFbURkShlet/WnUboDj8HivEseYP2AiuNb
 jTkLAMz0=
X-Gm-Gg: ATEYQzxmuAWUmQqChjLk9qtdarMFC6rE/WTszIrpqSMjMG2G1sasi5EhyN9ZHPhx4p+
 tl65N6MY9fEb3zy+WEF36FnUn795r0lH8DCfAKg8m0vsHg2YQKm0+PC06/cyaldktgEX05bi4kP
 NFvKxikeqKvkYiJAN4UXr5hTaM3kz1p87Z5KTYHq+v3+XlXOVuYC8H3oBMwoBGV5FhxuBsipvG0
 xBRqk+xd/R10bhRIEzlyIAX/ZAWY55NHo3WLFEN4hmQJiX3//IkbHWcPwANvidVl+is9ziYrYjf
 qDypsuWbeFTC1e433b8LABjLhuoua8kXFyy0fYjZI23J9pRlVT84GJeqveqItQmAB8CqMt79Q4W
 dxzbtf0r702FwD2PbjuaRaEHX2So1/RhtgHqUWCF8yimjL/iVpcYWVktyCdu7ie6PQ+FF4N9gj0
 n+c0Mt1hNLze94yICgPekCcfDIuxr/qk3hOHa22Bji5pF9lEzlhjUokyD08v+sU1JW84nE9g+j
X-Received: by 2002:a05:600c:3e05:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-483a95b3df6mr295360655e9.1.1772061541619; 
 Wed, 25 Feb 2026 15:19:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb776a3sm31172885e9.7.2026.02.25.15.18.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/70] target/rx: Expand gdb_get_regl() -> gdb_get_reg32()
Date: Thu, 26 Feb 2026 00:13:42 +0100
Message-ID: <20260225231411.96482-43-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

The Renesas RX target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/rx*
  configs/targets/rx-softmmu.mak:5:TARGET_LONG_BITS=32

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg32()

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-35-philmd@linaro.org>
---
 target/rx/gdbstub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index 30074c9da7b..8be5141f5bc 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -25,25 +25,25 @@ int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case 0 ... 15:
-        return gdb_get_regl(mem_buf, env->regs[n]);
+        return gdb_get_reg32(mem_buf, env->regs[n]);
     case 16:
-        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
+        return gdb_get_reg32(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
     case 17:
-        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
+        return gdb_get_reg32(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
     case 18:
-        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
+        return gdb_get_reg32(mem_buf, rx_cpu_pack_psw(env));
     case 19:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_reg32(mem_buf, env->pc);
     case 20:
-        return gdb_get_regl(mem_buf, env->intb);
+        return gdb_get_reg32(mem_buf, env->intb);
     case 21:
-        return gdb_get_regl(mem_buf, env->bpsw);
+        return gdb_get_reg32(mem_buf, env->bpsw);
     case 22:
-        return gdb_get_regl(mem_buf, env->bpc);
+        return gdb_get_reg32(mem_buf, env->bpc);
     case 23:
-        return gdb_get_regl(mem_buf, env->fintv);
+        return gdb_get_reg32(mem_buf, env->fintv);
     case 24:
-        return gdb_get_regl(mem_buf, env->fpsw);
+        return gdb_get_reg32(mem_buf, env->fpsw);
     case 25:
         return 0;
     }
-- 
2.52.0


