Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B4DC25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfQ-0002Xd-Bj; Sat, 25 May 2024 07:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfJ-0002RG-MI
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApf8-000455-NI
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lB1PVNS3MVtMz/CPvzlI0uG9BYZEF10RS2KlIpk+5c=;
 b=UYX5xnChcKabXJUQ03ych3L2iHk3IlmXsD8lpobSYITz2PTcyCE0DbihCjO6TM/wG/L/y2
 OESIitnft9KYIV0DmvjoFm4SLOVoP0zJvlHkgGx8aiEfCfK51inEbScjFBh5oF0gdsN8wx
 4gRRi5orzlAVbKhZYzh+ivJu4CI647o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-xYhfNIypO7KuNjoZ0Oynqw-1; Sat, 25 May 2024 07:34:02 -0400
X-MC-Unique: xYhfNIypO7KuNjoZ0Oynqw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5a5fdd6185so398723866b.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636841; x=1717241641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lB1PVNS3MVtMz/CPvzlI0uG9BYZEF10RS2KlIpk+5c=;
 b=YVMKyfal/+AKvp0ppV7G+EsTqt5iHyUf7j5A8GbNEQ8GOUiugOgeHiiiTAFbMw/rov
 XxKYhMQD8X9veKXsfBuH+pPLR8nkUiJCDr5MGB4kmUU10PMP3R9loqK4zmsSGPXsA2WB
 GuDzlvO/I7V4jVHnYNoOkipoPY/IlS4Fs4fkp8wUV2r8oXB1oMUoYBL2ir91i01Wr42V
 9ig5s/f9aQQ65UU2fAk49FvAR+aYKwXF+H8ves8M/hdypTS8ttnZi5Pot/v+FL61euoc
 AqQKmsvGFlK86wg+wXpoCQ3FpMLK4hU2rXvmUVxnQs0pocQuRevO1p7YKqLn74McamZZ
 N93g==
X-Gm-Message-State: AOJu0Yw5dA9AAGg8DZuzr4MIhwxlxUVaZvDqIADVNkFcEqZSbgGWwqA5
 xJxr7EbiQyw1M2VeAxxNNGTCcoxc7gAabe3Sbasr343fw07ILQUVTQAyFNjwQ2wYHKp0Zd6PqfJ
 0aGu9T1enqKdd64Ta//AdMMdFYvxoeyFf+HwC4NCBDXotDp9ThxCg835Q6ok8XcvYACbQDiIBft
 hJJJ4VXau5AgKj2cvUDIHEDwLUzs7iO7cMNSqw
X-Received: by 2002:a17:906:b0e:b0:a5a:8afd:33b4 with SMTP id
 a640c23a62f3a-a6262b146f7mr355972166b.37.1716636841262; 
 Sat, 25 May 2024 04:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/+sIYxhhK8uAshYqN6eiXF+M1fQzFwQ60DnLaij1DCcAjhCvD+vxYjBwd2AqXwzXsaI2Wng==
X-Received: by 2002:a17:906:b0e:b0:a5a:8afd:33b4 with SMTP id
 a640c23a62f3a-a6262b146f7mr355971066b.37.1716636840885; 
 Sat, 25 May 2024 04:34:00 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda1c32sm243892266b.190.2024.05.25.04.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/24] target/i386: document and group DISAS_* constants
Date: Sat, 25 May 2024 13:33:16 +0200
Message-ID: <20240525113332.1404158-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Place DISAS_* constants that update cpu_eip first, and
the "jump" ones last.  Add comments explaining the differences
and usage.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1b0485e01b3..1246118e42b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -144,9 +144,28 @@ typedef struct DisasContext {
     TCGOp *prev_insn_end;
 } DisasContext;
 
-#define DISAS_EOB_ONLY         DISAS_TARGET_0
-#define DISAS_EOB_NEXT         DISAS_TARGET_1
-#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_2
+/*
+ * Point EIP to next instruction before ending translation.
+ * For instructions that can change hflags.
+ */
+#define DISAS_EOB_NEXT         DISAS_TARGET_0
+
+/*
+ * Point EIP to next instruction and set HF_INHIBIT_IRQ if not
+ * already set.  For instructions that activate interrupt shadow.
+ */
+#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_1
+
+/*
+ * Return to the main loop; EIP might have already been updated
+ * but even in that case do not use lookup_and_goto_ptr().
+ */
+#define DISAS_EOB_ONLY         DISAS_TARGET_2
+
+/*
+ * EIP has already been updated.  For jumps that wish to use
+ * lookup_and_goto_ptr()
+ */
 #define DISAS_JUMP             DISAS_TARGET_3
 
 /* The environment in which user-only runs is constrained. */
-- 
2.45.1


