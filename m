Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB8FEB2714
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu7V-0005nh-Ha; Tue, 10 Feb 2026 15:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7U-0005nM-3Y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7S-0007nR-Le
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:13:59 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso2898444b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754437; x=1771359237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUXohQh66NEYdqhO2tX9stkTnV8Hh6W32mBAqP3BQwU=;
 b=tkNjyPCHZDGW+ayP+lnwgOUBAymzOTfluBwMtQvZ4hF/DNFrkt4K0ZYzFQmlLGrRG/
 KmKIRWilu24AeSHjEI+7JQBvkUI+RuyqH9kcO5Dbqc3FjkChOEMYl4lUBa5MnWAorRwZ
 +ikqUb7XHxJM1+H1p1CBVhdfhq1ZjVeCwn70k5u+nTH51n12LSWFh9tx2OvmF8PXj9+L
 Rlua9UvalF6iT4znge+PLeTIeVU+gueSJtOaXIokwQuvGtdVaRVCbnDBwd3uooluwQvh
 NLelRXkQE/Q4Ke2UyXQOLE3jQPH0N2zZj0RBeFFrQfpLBJ0xY3+cx69qQxblo6rEKWsW
 OhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754437; x=1771359237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TUXohQh66NEYdqhO2tX9stkTnV8Hh6W32mBAqP3BQwU=;
 b=FlnmhCETwUV6BI41siGQwQp0nEQY6dBr9a6v7zNtZbDmq1IliLMhjdQOQ8qnS09q3A
 Kp5wrO6OzB6BrXO3+rT+vku4gEws9Yw1cxeCrsEfiD4ofPQJMaQqCmYQ26T6djMzi/tm
 zFRMLp4l8A1Drd6H7AjQLnMj7xO5p4D1tNLPfKFqebX+04klbaqdIEAYl3zeetLfJElH
 Tg3VIkUpC/Yye5Oy+K1suwRrOLh/hfTODCKMnJL7dk9X0w4PZO/SaGl8Nszse4OB6lRA
 v2PDxCiGhM62Mowz6Xz56c0ydjmYF2X07iDzfOuj3a1JJLV5DwSuAtqcfXXFbK9LP5k+
 HDLg==
X-Gm-Message-State: AOJu0YxS9vlJ6nhHbCDz2H6/AgHE+ZTuzLyf/uO0uUseUDXFgx7onZJ/
 46BHHMmIx6EO7RgEwarRpC/zX5fOntj7vXJSBAlUxfhdE/pNgFW4bj0klnYTYDJOU+aQVukrR+b
 QtQsB
X-Gm-Gg: AZuq6aLeteOEgs7RWgNhGEBJY8nOHqJFz5w0jKaQo7f9ggWa8beW3CMomY/WtsRqZbY
 LgiVEuT9LZ/OdTE1IxkYQLgFqwNwwYw2/pJJR+8Rd4kwy356lENpqp6riSIuyOceeYto2vR3sPV
 hWy7xPn28EAkGoofqh0LX0u1HYTA1KLSYUhAoxqhw+yA1t2MdpFYkSaEmg43D0tzrc0s85B3+I/
 2Y8Ty6jwAuhoDY1LQNMrT6fXXpWkdJDhOhIJmzPW4b1A86IJWL2HB9c2gtXhlLGHsIYD2/oHKum
 rhK/9a+6Pk5pllaI6r/qvnWFrfNobvs0wgcKXX2cXSqGMum1Ris56FwIMk+jriOjA5IktAmrCuJ
 okbQrHt+CYL4/g5GWdc2MOCfXvY76DOrn579FyXZ19mfavd/kufUjdIK45g8MILv1q19Q23nLHT
 AZCNrky8DcVEt7jZ7T0sNMX/Dkwos3ZxIANNefgET2GqBFhDAbPPuP+pldwAZ0H94YKhkmMqmcA
 u9M
X-Received: by 2002:a05:6a21:8202:b0:304:313a:4bcd with SMTP id
 adf61e73a8af0-39417c1fae3mr3025900637.30.1770754436624; 
 Tue, 10 Feb 2026 12:13:56 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e3e8csm13930031a12.21.2026.02.10.12.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:13:56 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, anjo@rev.ng, brian.cain@oss.qualcomm.com
Subject: [PATCH 1/4] contrib/plugins/uftrace: fix infinite stack unwind
 detection
Date: Tue, 10 Feb 2026 12:13:41 -0800
Message-ID: <20260210201344.1403613-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

So far, we were detecting infinite stacks but not stopping unwinding
since break only exited inner loop.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index a7e21b5b87a..1ed982999ed 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -443,7 +443,7 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
         /* check we don't have an infinite stack */
         for (size_t i = 0; i < depth; ++i) {
             if (frame_pointer == unwind[i].frame_pointer) {
-                break;
+                goto after_unwind;
             }
         }
         CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
@@ -456,6 +456,7 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
     } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
     #undef UNWIND_STACK_MAX_DEPTH
 
+after_unwind:
     /* push it from bottom to top */
     while (depth) {
         callstack_push(cpu->cs, unwind[depth - 1]);
-- 
2.47.3


