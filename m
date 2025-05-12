Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BEBC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXWi-0002EL-Bi; Mon, 12 May 2025 14:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWg-00027G-2a
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWd-0008Qk-9C
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso3371717a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073113; x=1747677913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJMyYCTFAIbu3EwtVFYHiNKkH2seNanmqLNgECsCQ48=;
 b=WsjPtszpvsOBG/MQ7KYjiNDHsQpRYhbJMxC5GY4ErZA5kvpahwfY7SoaxMSNnB2xsz
 kCSzPTkRGyzWmzYBDHumLWBDhWQXZeyVh5QVRkx/iWT0eYgRL6PFVqBbi2cs+MhnHPSp
 XBuIFSgirdd0XxmJ97OS3CjuhEh1NIS0nHLmAlOxIssB4BFJKVDZ4KX5oHsDhKrNNsVl
 w34kuvon/epCJogGW2vWUwriGQwJbMgX/lYBYLP6xMntXm+4mE90ygc8YZHAXtEQeA/v
 coyrohSgPgndWQUosMMk4OfTVI6Rh74dN1D2XRMBN99iOY4thaHnJAkzl6aeIhrs3DOj
 31Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073113; x=1747677913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJMyYCTFAIbu3EwtVFYHiNKkH2seNanmqLNgECsCQ48=;
 b=oB5AnntPW6xbnBCMT8rw5RBDiuffEaS9s/QVUDbB8JBXN1zT/Y1hJEIisrVOisQNLI
 UZDqO5XiRyxzmf7u5uf8rZ9x1naEOp8h0+j1Zqi2npSNFqn4kqFJP967q9DPB7LOZ7cH
 9aHR1I0nHY2ZJsMHWuLxYS4Yqs5ETsDurl6jpJKuKXUik6umnN3g27o/oMie7WbHmrCG
 fHwW2XLF06xRTACxOH+POVHCIEk0laovEy6SN2UxyP6CXSejCu1FAfK9cedzWyI4g4AS
 4f9+Ap31LCLomkxjf43a+UPYnjxK/+0mjsipYdLh3kcBeJmMtZ2AGV629yOBQo/cq947
 BgHQ==
X-Gm-Message-State: AOJu0Yx5tKlQShDg5r7nFUy6/DO7HEzUFczbXfMCQaNcQAUEaU3TXqO7
 uyoUkW1a85jvttilbP+o7jYH2J4hXlfTaKjsyZgIfA1y2MtCxxJz4pzTx0Y5/rov83GrogbMsq3
 I
X-Gm-Gg: ASbGncvu4m6i10lk6PS3dOZis9nYu1eKiyob6bl3gfrp4freWbP40WLA+L9Xxf4/4ds
 grdsQo/hQ1IO1HhK7V0HdiisuottbGtZ2RaDA3zq2oUih8hifEf5EyF2+xSp83aCOY44pU9kWkR
 DOslzN9XqhUmOuN95nOEMrlRZFgHEDvXa4spBTads6gshFiH0OLN7of8zA/ECms80rHu3kEAct0
 lz8N83X2m1JmDnJPI8hzEuxTuAq9/4Qd17mGHVcu/dOCP5/jNYhFzS/D+5MaJL24Amt3FU4BneL
 8VFO1H+aiC95BOjbWKUwuC9bgZ4KVZqwpX4CZuDP2Wjt4PgkSVImsCrMiHAkRg==
X-Google-Smtp-Source: AGHT+IHdpFnpSMK7x9VszJ7ESn4Xre+yM34qcZNm54/vUIBuvH533/FuI4IGWiU34ZcU4u+AyvAchw==
X-Received: by 2002:a17:902:c950:b0:22f:c83d:d726 with SMTP id
 d9443c01a7336-22fc8e99ec8mr190068085ad.33.1747073113601; 
 Mon, 12 May 2025 11:05:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 02/48] include/system/hvf: missing vaddr include
Date: Mon, 12 May 2025 11:04:16 -0700
Message-ID: <20250512180502.2395029-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 7b45a2e1988..a9a502f0c8f 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -17,6 +17,7 @@
 #include "qemu/queue.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_HVF
-- 
2.47.2


