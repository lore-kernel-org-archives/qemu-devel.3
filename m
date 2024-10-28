Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7C7D33997
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWx-0008Ln-P8; Mon, 28 Oct 2024 11:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWh-0008B3-56
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWe-0000oc-Ks
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gI8QJXLbvQlRAcKrirWFR61Xh1xeLANavYLMQJ90kOI=;
 b=WqjgPASO/B654zD8vC6EO7XWCOCopGz05XGXRfLLzyhT4++y64th/mFUfLdbbK0jHAdDtl
 VCqkVEmYMdIlVn1+sm4tv4y8dhXLxPHMiLK+5NVtKfYfxufKS20BjccEmkhrZcAjdrE49S
 3nqgikI7zFk0fsAw22EZG/ETD3gzLAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-UaobQeZdM12ZgBq103wWJQ-1; Mon, 28 Oct 2024 11:19:22 -0400
X-MC-Unique: UaobQeZdM12ZgBq103wWJQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d45de8bbfso3199755f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128760; x=1730733560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gI8QJXLbvQlRAcKrirWFR61Xh1xeLANavYLMQJ90kOI=;
 b=xCkX7Z/82cj+GvyzpkUJsqcOyprEryFgvavqKSAwdyou7LFfYxse3wP8zsbU9gA8jp
 FbIp9XtB6L2EWyU4CcCOu8AJwcGMAm3avEZWqWxnusfFIyoY3zXjvH5tICY3nhME/wMw
 PlVOjJn7KUICUvZQxCy3cdo3By22Srhx2lKt9NT/tLD91aksSsEzzyTTWMkFhy1vb/2Z
 0x3JZsfCgFxRFoFrFdOOE2fJztV6byySARTThQGChFHcsLUQ+9sxx0BZw+NMWpnwVMfM
 JwiRE2ZORxcXNmQ6aA5qwD2W/Oe2mVndvpWBdjSWzZ/8r32tPx1CvKM2C5e/UDxtVUYV
 //UA==
X-Gm-Message-State: AOJu0Yw/rG1J23DLxYUEi0v19Oxr9oAKOyfdaGV9WG/W25OwIx2Lv9GS
 w19nE5/0tjFj05dBSsuSj8KPDcLSgCR04HdqCmn/2hrUEs9SxNfyOas+OkS69uM+bRtcMi+8ZZL
 46kuRTN2MwXqjLtJObQVWGTzZg1Ev3Lf4pCuRfR8TAGpOM1d6CHpus+/1Z076FTThFWfpavmgR8
 /ajHz7GpAJmBhTEZBc9u+fSje1p+//+DDPLGJx4m8=
X-Received: by 2002:a05:6000:b11:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-38061227b35mr8278040f8f.41.1730128760331; 
 Mon, 28 Oct 2024 08:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtaqk5zLmvKhP/bE7I0RxmTQt4atuAaSDSfnv95kWFUtqcyTMwA3dOOXLp9GQU/E21g9B//Q==
X-Received: by 2002:a05:6000:b11:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-38061227b35mr8278019f8f.41.1730128759930; 
 Mon, 28 Oct 2024 08:19:19 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bcdsm9856223f8f.82.2024.10.28.08.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 08/14] target/i386: optimize TEST+Jxx sequences
Date: Mon, 28 Oct 2024 16:18:45 +0100
Message-ID: <20241028151851.376355-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mostly used for TEST+JG and TEST+JLE, but it is easy to cover
also JBE/JA and JL/JGE; shaves about 0.5% TCG ops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5e326ab1aff..d3bbcf7317c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1069,6 +1069,28 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         }
         break;
 
+    case CC_OP_LOGICB ... CC_OP_LOGICQ:
+        /* Mostly used for test+jump */
+        size = s->cc_op - CC_OP_LOGICB;
+        switch (jcc_op) {
+        case JCC_BE:
+            /* CF = 0, becomes jz/je */
+            jcc_op = JCC_Z;
+            goto slow_jcc;
+        case JCC_L:
+            /* OF = 0, becomes js/jns */
+            jcc_op = JCC_S;
+            goto slow_jcc;
+        case JCC_LE:
+            /* SF or ZF, becomes signed <= 0 */
+            tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size | MO_SIGN);
+            cc = (CCPrepare) { .cond = TCG_COND_LE, .reg = cpu_cc_dst };
+            break;
+        default:
+            goto slow_jcc;
+        }
+        break;
+
     default:
     slow_jcc:
         /* This actually generates good code for JC, JZ and JS.  */
-- 
2.47.0


