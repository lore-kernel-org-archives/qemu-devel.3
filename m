Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D74CCD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nF-0000JJ-4L; Thu, 21 May 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n4-0000Gy-Ea
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:38 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n2-00026N-JW
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:37 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so3691242a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386795; x=1779991595; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mce15bqHzvNgL+6+BcL1FB9WiNDPad0v55v3KAaqQ+8=;
 b=hF76rN1K7ilUUsV/1tlnYMz8hH8rTZFYnVw0QBMOjLWEDMMVt/+Dc/yWW6E83pbGuK
 2mW8+nC11i2cWUd7+Ei2M0el0o5/mjx/ViT7hMASo9zGb7ogzStgKUgxeu1xAdam0tHI
 WuEeB7mTF2h3xDj/h1RDONN6V+l922tCtCqB92FHIbX5PJjUzSumk+4QPfhzpk4gyWQf
 tsZnPMi4gKMHpywRxdYPi60R9w/lyLw9qB/QZF7uRCObEGLlTNdqB246okRIiUd2kOCI
 qC+cRGe+nLDJAfVGhb7gzoSZW9cXAYoddxeMnhJYL7i4yIznZlkvFWA/vIOwtkzg0NB+
 Tgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386795; x=1779991595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mce15bqHzvNgL+6+BcL1FB9WiNDPad0v55v3KAaqQ+8=;
 b=JsQrghtbJvQ2AkOUT8ZtdRax5yAKskejsQSr/6dwCNNIkWxdVHutetgsaPAMlamQv+
 IckmatUmZcrpEUdJ0y73UNOjBE1Zb6+WkTfsnrPfXMzfj39TfwZ0QtjKxAseh4wpf6A4
 ldyMVO8zSGrkiFE4a9JhhT3QSNWySHkZULXODgX0+yRqVq3rhon5B79nbGnCsNguS+Nv
 OFzV2RyBjnrSXm0+aoRdYXHdSnmyKU1LwJ9iSjYOwNfyoI0MCRHlPQIlXzwc28JJ0y1A
 gVmICsuTAbiCl5+rkbY58paXzjcqYfP1iC161vTIA1Xdk67AnCIKl/Z/5nK2tSNznhko
 uFdg==
X-Gm-Message-State: AOJu0YzVBVsOrxyiLUWe+i7J7G7wBDtX/jafSbdRCQzAMpD3dSf6XQO3
 PmsYp8RGLLJdmiNcMNlE2vect9JXI4dU/ivvwleTr3FBD/z7owZLEWaJ
X-Gm-Gg: Acq92OFkiy11+5jAHagq2ZI2DdPzGDajLLfWJ0Dksn+My9ZHcJe8osb3dHdg/zfLC2u
 lF8EIbf6NOvQqAkP2o1trjNeUzILCgpzSAuVtEVcOWOXtA4NX+HczFwcPi1BA7wC0tNEaB8mAyj
 767vVqHmvjeiyTPM41m56F652yWEtle0BotPdVYZWWHz8S8iz6kWYguWLIg9Yt8rq1bhSeV6s3A
 AakqsNtpkWhpVW+DQeIhVjaqVAOieq627/aE1getdt/q6YLPFSuL2Tyjq/WvpDD6exyW8EOH/PM
 edtMqo317zquOX5B1hcIuOw+vYVEIhd1GCz8QehPz6a2Vn1bm+9/XPTg8ddeUtEhw4ExfLc3bYD
 k8VLzuOyFGtVUUeifT5RNi5WmRVZguKF6Hh5jn0MhbXKHkRbIyANsnC+wneADv/EovL9K8+2WFy
 qs4CLzWd/m8MuQ3gDrZ9I7897RVRdxq5hVvQPLCxGy0DvDujTuxNJ9qcmABhex08xJps1UFv1mr
 l7Iz8wsTkruZL/DYnR1uYN7tOCvJ7Et3vIVx/xTC/yv+Xj1J6obRQPbehDP9pfiplhK
X-Received: by 2002:a05:6830:6d4d:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e5fea05c4dmr205697a34.0.1779386795456; 
 Thu, 21 May 2026 11:06:35 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:11 -0600
Subject: [PATCH v13 18/22] target/mips: decode Octeon ZUC and SNOW3G COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-18-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add explicit decodetree entries and translator bindings for the Octeon
ZUC and SNOW3G COP2 operation selectors.  These stream-cipher selectors
operate on the shared HSH register window state, so dispatch them through
the per-operation helpers added with the corresponding engine support.

Keep stream-cipher decode separate because these selectors share the HSH
register window with unrelated engines.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v9 -> v10:
  - Split ZUC/SNOW3G selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Kept stream-cipher operation selectors helper-backed because they
    operate on the shared HSH register-window state.
---
 target/mips/tcg/octeon.decode      | 4 ++++
 target/mips/tcg/octeon_translate.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 31c857fa89..87d98673ba 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -258,8 +258,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
+    CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
     CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
     CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_ZUC_START                     010010 00101 rt:5 0100 0000 0101 0101 &cp2
+    CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e975774332..d1db676c17 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -289,6 +289,10 @@ CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
 CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
 CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
 CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);

-- 
2.54.0


