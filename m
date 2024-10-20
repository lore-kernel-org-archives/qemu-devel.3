Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27887D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG8-0003aT-VM; Sun, 20 Oct 2024 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFo-0003OC-Gn
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFi-0005QQ-CA
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26EBxQ0Z85mnaPKsgMajhtGRoo57YJy8Zn6ojuxhHvM=;
 b=W/yVPBohzJozaXZJ7flZOewXrrgQYdMAsBWBKJY9qrYlHx1ZmYHc/bOThyOUuj8Ifgdzb8
 2u8DtGP7Q4MGazdpzA2FA3us0mfdvvZWJL5NvVr4hxPom9UQgPrgXYpv1mR5dxsqNiiDz+
 kgeOwSuVg1lZ1Kr/hrQNMXYGsAOKnIk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-BpIugzauNIWOqXyVlppEaA-1; Sun, 20 Oct 2024 11:53:56 -0400
X-MC-Unique: BpIugzauNIWOqXyVlppEaA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so16819625e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439634; x=1730044434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26EBxQ0Z85mnaPKsgMajhtGRoo57YJy8Zn6ojuxhHvM=;
 b=j1p2JSe6heJ1pEl+wfEpdIhFpxOx7tCIESxxyplJ6Mn0PGcvg6giZTNHgS3bXjOgtB
 XsmDENKqjjsJIqa1w9K2wEIV2/Iv2PN7R6UngyPOth2i1+2UTUiCiBUD6HV4pMFek7Az
 jdGcgpFoRE0fCuEIMy7ZC0ctlQqHxtAq8tMLiQaKxBNWf/MqdJ9lMnyxUJn2ujqfTr1r
 qUPMatB35ewnV2jOVSDmetdFXnS3FUL2m53x7DpC7+QEokNu1vrq2gCkMk0gIt/BCArL
 QTjtvNdEjdfZA79PGWBIzd4WRfZUHTPWlYmB/eDSGoAk2mD2K+R1xyFxocU6FC1hqomU
 oWlw==
X-Gm-Message-State: AOJu0YzrQ1BDy2++GWRtTiIVGSUvfzzYtmh22xIxqwtnkveEQYZ/5PXt
 9q/N9cyFc3gi8TMZMRvaitDmY0P6GyGEM50fj4t/1oqtM1YQBVYiGMJ2w/2X5PXRWgSbrjMUSGf
 wHdv1l0H4fjTItGrKFU3ObhJiYQpK2WRpvnDCrxYAm1v07E6Dte+L26ZkaUmyUk3KYm/YKL3RCM
 l4hqS6jgxy1puEglYOOrXQaKCXdi5jyWORmrM2kDc=
X-Received: by 2002:a05:600c:4f16:b0:430:52ec:1e2b with SMTP id
 5b1f17b1804b1-431616a0a01mr69858275e9.29.1729439634045; 
 Sun, 20 Oct 2024 08:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnxG1tmyJImvSSC3JcG7HxZykM4C6BBR8/ekYkE3UJHObp0k3zoLKei6RCPgoDHckFwaDx8A==
X-Received: by 2002:a05:600c:4f16:b0:430:52ec:1e2b with SMTP id
 5b1f17b1804b1-431616a0a01mr69858135e9.29.1729439633551; 
 Sun, 20 Oct 2024 08:53:53 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57bc1dsm27167725e9.11.2024.10.20.08.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 08/14] target/i386: optimize TEST+Jxx sequences
Date: Sun, 20 Oct 2024 17:53:18 +0200
Message-ID: <20241020155324.35273-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
2.46.2


