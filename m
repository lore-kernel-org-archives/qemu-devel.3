Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B27D232E2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56j-0004Mj-Hx; Fri, 09 Jan 2026 00:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56f-0004Jr-Jy
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:17 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56e-0003i4-2G
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:17 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so2071143b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936735; x=1768541535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3glddST4pF+GtWls5bl1khZgRZGG/niGmnEoiRLSSNM=;
 b=EdwT5KOf7qU2sBIvAa2qAlfaCWFwCx6wvIrqEK1ZBw22EraMpVrYUKVBpNMEgE+7D4
 0GJUqeBUZ/19QA+a5FkI0TJLNNMx+4XWC2SmROJgOm3YXSUGd3EK74NFZmp3CeK0uhFh
 wkDGLjb/Y205KYmum72qDdiHYwHE77/d3GmszZNYVwE3aupkPHmRNAieNUkhz1vL4h+6
 0k7MYkd4+jz/O2Ht/iSKqkmNfE0yzlfgoKRuPyrxb+HCC8bRNZZpHuf/P3CC9zIilXQY
 QSoH0btdj+W+9HOqAyDIc+87HWSmNkRDxYJo45E4qUxP63jlEP2BQXZXH8DKkjD0xKyt
 JH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936735; x=1768541535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3glddST4pF+GtWls5bl1khZgRZGG/niGmnEoiRLSSNM=;
 b=imD6K9E7J/CuLSv1zsjQFRDzm9/u2t6ymqJtezfL4NNRFlKdBW+0G9w58eKeDYo6nO
 YYES5XiBjO3EsRU2IRJF9QFADL/4op9hEERzkfLomrlG2lk6yd8Ho+GZyKtOlzEFIvFF
 2NnTC8Sz14ebQlnkBhngmXH9wAw/FXYnccQKAJND49EBETCZPjI04a+5V79KaoPCf1hy
 zVuIebUi7Z9kkqFxxF/VFV2Jaz4y9C45QzvfJSEYRVCH5i4xfaCkHMpFIG6qHd+Fc1qc
 pDR13iOdEfCn9dP/WaO+5weAHhQzJZyF2gcbxQ5yd0qnwSbvfIr5VbxxCk93XAt9CLyT
 gxvw==
X-Gm-Message-State: AOJu0YzVmyFR6Dc7l/9SsKIMAN3ziUHPO+4SZS2Z6VGFY5BIHZnZ4/1u
 f40JAzjqssoPdWz8DyRMuuuBui23Ci1qXkE214RiRDWKV1BBUDckQ6SGkZr+kzR/LfvF/YC4d2+
 C3QTo
X-Gm-Gg: AY/fxX7waRPm25TPpzuYZzWfcqW/13UV/JYS+VVlmggTK5T8a5ptDAaEoWfWXDeYyRJ
 CURv+IbwbdT50YS657Co4pCy2OEtlLFLVdrnoiiJQbsrKR18xCtky5hgfdZ2xmmUn4i4rQYxZ3w
 CM/LDEMEV3/mUmJ2WG3s/Oa9PiYGEHfv3wbjYxviPs6cSGwE1njVwXbd4bhzhs4BEH9XOrAnra7
 +ylRLvivkjfulekKkDc7vO7S0k6rM6TFeKFVA+CirBDGKcMl/AVPyeGbmArQcpBmuYRT2AwDkdV
 zNMIiePGc3ofPmcjjgeCD3cBJP6+oH3P6EAuI8RCoPWIm37K2sG44xOaYieuLZnF1FKk8YvaY9J
 IGNjNTqcXeiU3uQQDLuwxNA58q0eZmhE/37o5ahw7SfHHpAwHC4GBOwXM6vqgdqjaw1ay9gqMr0
 5UGNvJq8S2p+3SNFdWAO7A38QL72VwyLx/WwRuB02zW1KdsWfI5eXrVwJco4o8M7yrS+jd6H+fy
 fY=
X-Google-Smtp-Source: AGHT+IGlfmj6wSySWl9I3ONmZ7YA9kT9sSBhNaiyE75MIlpEJ8WvQUjH+C2Vgtli+voBAy+pDUFS0Q==
X-Received: by 2002:a05:6a20:728c:b0:366:14af:9bc5 with SMTP id
 adf61e73a8af0-3898fa41070mr8079033637.79.1767936734587; 
 Thu, 08 Jan 2026 21:32:14 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/29] target/arm/tcg/translate.h: replace target_ulong with
 uint64_t
Date: Thu,  8 Jan 2026 21:31:39 -0800
Message-ID: <20260109053158.2800705-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b62104b4ae8..63f187d4150 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -18,7 +18,7 @@
  */
 typedef struct DisasLabel {
     TCGLabel *label;
-    target_ulong pc_save;
+    uint64_t pc_save;
 } DisasLabel;
 
 /*
@@ -42,7 +42,7 @@ typedef struct DisasContext {
     DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
-    target_ulong pc_curr;
+    uint64_t pc_curr;
     /*
      * For CF_PCREL, the full value of cpu_pc is not known
      * (although the page offset is known).  For convenience, the
@@ -56,8 +56,8 @@ typedef struct DisasContext {
      * pc_save contains -1 to indicate that relative updates are no
      * longer possible.
      */
-    target_ulong pc_save;
-    target_ulong page_start;
+    uint64_t pc_save;
+    uint64_t page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
-- 
2.47.3


