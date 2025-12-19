Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E4AD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdDx-0007Kf-Dy; Fri, 19 Dec 2025 11:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDs-0007EG-QQ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDn-00061E-26
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:56 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so1401036f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161246; x=1766766046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+LBKH6mpM3QJZ+LjMWVH1Zu0cPNjKfwSazzmUt2kNQ=;
 b=hfVgAtn3OerjeWH1XHPfjMx9dSWAx4kKc7WTyaMT+TYgFsQCzDiFicQFPgYCy/efJA
 cNBGc4iqPmVBAjkKThCHoAfPGVoyX5KEKC+kjOqQj4+ZshmZRh49JQqukBtHudH7wHIV
 opyJTmNQKm8psFDGrCjM9cck/VCwksiZ0zN12CSi/F6Aw/+KhxwglC08txjuceHbTnWq
 dMsFoM5Zt/5jarNFSFlYFJYuvUEZiWvy1ZU9EV5IVlKIldDeAIPbUfHG4T7zp9L4JunI
 +l015p51XGQNhDucWACEQ4U+oKE61smckMOAAF81l4upKh8DH4O5z48Jbzei/D/URuTv
 HKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161246; x=1766766046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+LBKH6mpM3QJZ+LjMWVH1Zu0cPNjKfwSazzmUt2kNQ=;
 b=WZ/y4YedkvGed2xYn+hI3tnZbCFbFeKgzfN86YjSSvB6MBirOxyeyKwxn94N/lTWqv
 hzNkRRXX5tX+KCLDjdMKgF/QiYxKAB4dr1w+GRQcxbhvLIjUfLZwjHzSHMhuUz5DHvuP
 HzKl+GC6EOtMgh1UxLie53InyXH0SCzIowYqFTEQDI/2biygbUm9D+rkXuzM/RPejYPq
 UiT6yTIwX0G1FM5ef6ZDUgIk5IsuwhFXcPU7GFDXVhsuPeiS8bY6iLlJSiRD90XhBN5B
 Jzffg/1Iy73mUrXW3mIm6eGcvhNidypViTufxCMP54Ww0RiQB4xpCnUtLy5OjKEG/2Nj
 zo4A==
X-Gm-Message-State: AOJu0Yy2O262YYIZAS8deJJ7zG4WmBLGtSyjKLwFFOnZ3560REWF9jsP
 5B+/jUAu3yrIy+l9r4MZ4vj1Wn4kbGYXt6x7tlvXO6AVKgpsAb1cbI4L+nQXzsLCnowzpqXipMT
 UoUWKDk8=
X-Gm-Gg: AY/fxX7a4aoSwWJhYz9ArTWPW1c6f3WiiR7xojHDfWG5Ys5VGIMGHaYq0Qu+40xwijt
 Db2YPcQ3fvQ/NRtWJpTBcst5FtOnX5bN+dxlg9Y2kN9017UoFUB2Qkk9uKQ1HNxoOLko645OIch
 8zhxAUjXsBqh98NUzPvwzrYHII0FVnSphxdlQyWttcnVMR5MzbRifFlft8OWedxtRujphmFUMIc
 gLKjH5flJkrDEF9zPFVA6AAkRh63YSd4zivL4pV2MsJUIhlHZ/EXmKzEuh5+9I3p2XGpdvrgpN+
 ZcypiZLPvgSHhSmi79wUq8Sxxh98e6L2culCuNvPoyoGps72+6/5WKzRAMWqjrhFikEasfkWNW/
 UWXWiVztsbEhTZzjtSzeiXOWw/ClRSpePcoj6hDue/uXhdbOkQ7akr0+oheyoxcYzhi71gtL4/2
 VPbKLN1W5kIeM+7H/6/IBSgT2EsOH2U7j1JM30kKi9QaWS5Yi25FUAzioBIRX2LA4WB1gORHE=
X-Google-Smtp-Source: AGHT+IEbdFvENNm2T3P7y/Dzi5F/D3Z6/aRSAG/M2kZitD0dYxX3crylYwSeWhfWzjwm60VOioH2gw==
X-Received: by 2002:a05:6000:2906:b0:431:48f:f79e with SMTP id
 ffacd0b85a97d-4324e4ccfb7mr3716248f8f.25.1766161246277; 
 Fri, 19 Dec 2025 08:20:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2a94sm5790472f8f.43.2025.12.19.08.20.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/24] system/memory: Inline address_space_stq_internal()
Date: Fri, 19 Dec 2025 17:19:34 +0100
Message-ID: <20251219161953.72724-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

As its name suggests, address_space_stq_internal() is an
internal method which can be inlined like all the other
ones in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index b45bfecd137..d5776678edf 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -422,7 +422,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
                                DEVICE_BIG_ENDIAN);
 }
 
-static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
+static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-- 
2.52.0


