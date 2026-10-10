Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E37CA9EC1
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 20:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFdcB-0001TN-0U; Sat, 10 Oct 2026 16:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dennylin0707@gmail.com>)
 id 1xFche-0000T4-M7
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 15:25:54 -0400
Received: from mail-dy2-x0b.google.com ([2607:f8b0:4864:36::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dennylin0707@gmail.com>)
 id 1xFchd-0001pv-2b
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 15:25:54 -0400
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-350783faf89so386665eec.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791660326; x=1792265126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jtgb0WEDD8R68F5sBUSNy8Zg/SR8IbLbKdGk12ymBAw=;
 b=PWlUshT02h6vPKjvxPICzRuc7nGW5do6wXL5fiKSSKdB2qs2ZX7g6wIjGuKNz8kOoa
 luL1tYciTAYy0Y0lWVCXSNV/x53yT8rDcd29c3QJd8iZU8wXad1/ZRFZyQRoGpxxpyV3
 ze4NaGsEGHkb0ID27j1Lo7kHNV5uSa2F/l9PAmQRg4SFu2nS3Tl+vFNfh2kPzG9DyNAI
 J7hVy09BSiSQ23ghMrccizXzrCeQ9SdOU2HEYi8T7LPGv8pLniTCntoYpI77KOuppTEI
 6NgBSQSMhwoqT8PDFhaZSSOPIq6spiWi5a/3otJ/AcugB2NBBvmOxnfnosGDDMdmtmfW
 yGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791660326; x=1792265126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtgb0WEDD8R68F5sBUSNy8Zg/SR8IbLbKdGk12ymBAw=;
 b=rt+t/tf9T47wSdRpOx628LfC6WKx7Qy7FPn1HB42zvRkUuI2bvQ/+5+jvOjfYya/CJ
 76gkIft2uQwpTxPKrSMe1rAwVVcgL0bGQq5g51cm/PtlLwcWAqlIj37CtXhhrWdtqNEh
 sMTQsZF4T4O1DgAZ3eymFqqtHz34AIBtoKeJMeDov+kI41HHENDuf9m+LNXH3tzxR5UD
 09bmiL4tBkLYyeoudjjrjYhKASxJE5F1NJ4n8XMCXfDbJ545I33bgajAGTL8dG0QlmuW
 uiATQws/QXNKRMcYGKJ2lYWdluYPpwlR+iGAxBNFza6UzKi49bbdNv1rCYrFYTFQrc+h
 y5qw==
X-Gm-Message-State: AFq9FYKHIYkCtlfgK6O9GdsFNYUJ6kRJvJXswZqzNa78/RmZ20Cfwy7B
 9jQSEU3tALGSajVWLtYXRR6LC6p24JJrAf/NeAqqEGRMCIBW/+vLWrNoax8bBxQJIfI=
X-Gm-Gg: AYBFou1ckkVxOz9TDni2aR/AJJ/HfmCgJxYeaFYFA/tOZ5+Ft0KRqf5L8vY8pGR6mhq
 uCL0oEtxwv9xX2fXivXupxlotAl3PYrZSqWJddrn7CFY7xfHG4rE7KuqUZAv/bHE9ReyFUZpeZo
 7MQNGYcfje32PTUhwfTD31uWxLtTFlO6LJaIqQbMtRaolzXRo3COu4ypmTrLgGZiYPuxfMOQqWA
 Jgy9fo/xW4nur9VmPH6jLS9yfx9AnlW6J9tA12FUN9QiWVp0Q3Dm6aXfhsfGmp2LuZkEaoZLCap
 +hDR0nHjrjOmMAS9ZuFoWN1+WrTbULZ+Amf8n5jcm7qWL93g0YbyljLPidaR4l4zfChPzGTC8tA
 WbsPc/PNJKusGdVNoPrWP2LW0QH5IpG9G7owqWJQz8kNRLsnqjQTTd66cnyN0/SJ8a8r1fss5gv
 JzwLw7rS2OPMwj0mD51rSmauX3l4vWrtptGzt7btdiHkV89TTA28UZgeA9V0uDNUbeLA5QF4Hb+
 O83SO//aqMRLfyQMv4C7w==
X-Received: by 2002:a05:693c:80db:b0:353:5d25:1de7 with SMTP id
 5a478bee46e88-3537e0abb18mr8603434eec.33.1791660325487; 
 Sat, 10 Oct 2026 12:25:25 -0700 (PDT)
Received: from Mac.lan ([2603:8002:4200:2724:745e:5e73:30b8:9f24])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2fd33sm16690421eec.28.2026.10.10.12.25.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 10 Oct 2026 12:25:24 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH] target/i386/tcg: Clear cc_op_dirty after UCOMI
Date: Sat, 10 Oct 2026 12:25:20 -0700
Message-ID: <20261010192520.37355-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::b;
 envelope-from=dennylin0707@gmail.com; helo=mail-dy2-x0b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 Oct 2026 16:24:17 -0400
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

A self-XOR can leave cc_op_dirty set when UCOMI keeps the CC_OP_EFLAGS
selector, causing a redundant store to cpu_cc_op. The UCOMI helper
already writes CC_OP_EFLAGS, so clear the dirty flag after assume_cc_op()
to avoid emitting that store.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 target/i386/tcg/emit.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 531398d..918122b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4914,6 +4914,7 @@ static void gen_VUCOMI(DisasContext *s, X86DecodedInsn *decode)
     fn = s->prefix & PREFIX_DATA ? gen_helper_ucomisd : gen_helper_ucomiss;
     fn(tcg_env, OP_PTR1, OP_PTR2);
     assume_cc_op(s, CC_OP_EFLAGS);
+    s->cc_op_dirty = false;
 }
 
 static void gen_VZEROALL(DisasContext *s, X86DecodedInsn *decode)
-- 
2.43.0


