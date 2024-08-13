Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67E1C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduyL-0005ds-Ht; Tue, 13 Aug 2024 13:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyJ-0005TV-6R
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyH-00037U-IG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZXlzV39Bim9cmuseTRKv20dsdOW1fHZ/3mxSLQ2cMk=;
 b=REKM8EGoH7nPwn/8cVfy8/tGRh0hWh6E0HXSqKJMPj8XyHcGBnEqHVroOlAeCsETe1ubb3
 BkwqytkoXMYJhph9RASW9xb0IDuoY9JlOWuhVtPruii2k1IONSFrntB7ea8zOKAgPVf3Tw
 3Om889GCZdmZdWL6K0N60MRnfHBLLWs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-YraP02siNiqVeUZJZFXBEw-1; Tue, 13 Aug 2024 13:06:07 -0400
X-MC-Unique: YraP02siNiqVeUZJZFXBEw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7aa56d8b14so408128566b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568766; x=1724173566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZXlzV39Bim9cmuseTRKv20dsdOW1fHZ/3mxSLQ2cMk=;
 b=TwZVaXh/2Ltp64m+GyZo+K8Iu2vrx3ByXDojqdEVTp6zEksdGvyg31vpkUyMB1EeBM
 UFefW26q75MCqCarwxQWhobnGBOOO/O6GA/+JQ7lyYTLx68UiuT/4KQbx7nMFpRC0Uy8
 XnxU3CcBfyKxGtLn1bB0ZIsiEL24PPzAS2nP5IHLimfA2iP+YzTsUR/3hem0FojXp6+M
 t4WN+DaDuBdBHB2ieuVyfoVVCTd8iXynBqAHCG/CdbGMa7//cARpg4obka1O9+1vgWPT
 rfPMq7+G6T42XSedLO5BgtUbw7BfRcnIjoz0W2Z32mrKDj22j/Lbawi4cxfklc8F/r7O
 vQJA==
X-Gm-Message-State: AOJu0YxqXTxCAAQbujPXzaTbKvUh9eBXWzH/FvVoSTValBUdqzte2LlV
 e0Ykz8KfxZJ4CHoX8feylTCUmLxLlm9tfHcRT4Cnfday6bz6LNMAZXkxET6TvIbcqCXgcgVBnXx
 v8/jB2r8BpnyzVUWAeY6uKilbsozR3QGBiv/laKe5MmtCPwy64WXrq4977/xdHr5rd38QPJB+3R
 6GvdD+L60HGEGNd/0JtI5A9KngxL1lfxMtcP1M
X-Received: by 2002:a17:906:d7e7:b0:a7a:a30b:7b95 with SMTP id
 a640c23a62f3a-a8366c26253mr2075566b.2.1723568765648; 
 Tue, 13 Aug 2024 10:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFJVHGFkd4orfaHBg8BfzfVJxoPcxESAT8xVw5ZnHb10zCowPxZJzQdayqmuf+e+sfZI4whQ==
X-Received: by 2002:a17:906:d7e7:b0:a7a:a30b:7b95 with SMTP id
 a640c23a62f3a-a8366c26253mr2071566b.2.1723568765084; 
 Tue, 13 Aug 2024 10:06:05 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f48ed5sm84047766b.29.2024.08.13.10.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:06:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 2/6] target/i386: Do not apply REX to MMX operands
Date: Tue, 13 Aug 2024 19:05:51 +0200
Message-ID: <20240813170556.104193-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
References: <20240813170556.104193-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Cc: qemu-stable@nongnu.org
Fixes: b3e22b2318a ("target/i386: add core of new i386 decoder")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2495
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240812025844.58956-2-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b22210f45d9..03138b3876d 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1979,7 +1979,10 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
             op->unit = X86_OP_SSE;
         }
     get_reg:
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((get_modrm(s, env) >> 3) & 7);
+        if (op->unit != X86_OP_MMX) {
+            op->n |= REX_R(s);
+        }
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
-- 
2.46.0


