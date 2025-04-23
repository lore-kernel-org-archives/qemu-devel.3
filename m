Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F27BC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wct-0007Pk-Vu; Wed, 23 Apr 2025 05:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcD-0005TK-Su
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcC-0008Ot-2y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUmS0U1RZBw7OOfHpaWWmQndl98q1MPqId+Jw47KBuU=;
 b=OVSBOdx9YJPOaxcrH4FwyEyeLoJFgugeke9rJW21DooP2cdRG/d3Ie0q+oQtPu+VWUXPC9
 AnYYZDWfRJ62A5n+zfB/gm8m5vY7Hd2cOID7aJVFUxpE/kz9o1axNTRmldMZCFdzFjoqhq
 rRMDCm+4OdYxA1mGKyMzvJoed3dcIV8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-wRRg_KqzMkuhrVXF-rh0lw-1; Wed, 23 Apr 2025 05:41:56 -0400
X-MC-Unique: wRRg_KqzMkuhrVXF-rh0lw-1
X-Mimecast-MFC-AGG-ID: wRRg_KqzMkuhrVXF-rh0lw_1745401315
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac31adc55e4so452468566b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401314; x=1746006114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUmS0U1RZBw7OOfHpaWWmQndl98q1MPqId+Jw47KBuU=;
 b=Eklp5KIsZyy7mhoDUCWgRt/UEJ27Ufbv5gvaws/BccN1yU90gh1OeI2W9k4wGEG7/G
 GxXUUgk+x74qz76Z6aMxt65CkXo3eXNk51nG3G8BJP0nNeliar1wUUH19ACJ6OLUxX+y
 qFPDyYYCI6DFi6fLJGbwonGyic5uwqNAX2VJv3h0G5FAApTx78ubMjVziJcbsxvySik3
 PNvlS8iQhVjg7+CyQ3YCGgKBIeD0tv+/BAN9sTQcB0r8NK52h57L3GOChzZARHwYlenp
 /kW2nUswIgalS5xIP/B/FC2Wt5yeuY5H0VV1r0WI2D7LFbWhTNv+UkcqUKqKG61/t5bL
 n3NA==
X-Gm-Message-State: AOJu0Ywr2HCXJVPxdZZtPWurI/C7AtVuaLvgXJUhwavi+XFBnwfx8vTD
 FtabLgV2635Hmnt22r6FxY01cWS1xagYSP7ULmGmIH3PUR/JO5hKpdnGPUZO9dGvuX/f+z6yCod
 SXwmgV5J3FNAdMangyw0GN3TI6SjJJc86d8uL0U7jyzkhHlKdp45WS13VvQ+QjBaiM6FPPOMVKl
 UgFsGAqV6u7tgovcG3DPpbf++qW39uK4nF2ckP
X-Gm-Gg: ASbGncvK2o80TRJRokpbZctSibyaZaTUN1EOr/Yd45k+GnGNuRNSCVyChbZJqJqvIxO
 rX8QWQGfCfuT8VtPOMQQcZ+xAZTc/m1kFS8Dt7jPWk0UYOMgvzRI+07jN/VAqRsHgfR93npijJa
 CuGjgftEWvmNd5wktudThiPikiP3HB5yNo7XhYxypOYzgo1WbY91AmEHxrgSE/IfJQosmQS+1IA
 ABf/iQs2IIqDbHiuA6/IQBv1WK5gj+ao8e31z9dN52vGujqwFF5vnWCXWzh1K2Go/qWHB2K8Kkm
 RIYTrDPNHpoizL1Z
X-Received: by 2002:a17:906:c108:b0:ac7:ec31:deb0 with SMTP id
 a640c23a62f3a-acb74adb1b5mr1194526966b.9.1745401314569; 
 Wed, 23 Apr 2025 02:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtjlw5QlM2KRMb9es3qKP/sOQwvblfB7LzIOXJOkY9aUL46c7kuvZqU2izdesV8Ft3OdayOw==
X-Received: by 2002:a17:906:c108:b0:ac7:ec31:deb0 with SMTP id
 a640c23a62f3a-acb74adb1b5mr1194525066b.9.1745401314052; 
 Wed, 23 Apr 2025 02:41:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f6255778e7sm7203796a12.29.2025.04.23.02.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 22/34] target/i386/hvf: rename some include guards
Date: Wed, 23 Apr 2025 11:40:52 +0200
Message-ID: <20250423094105.40692-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Wei Liu <liuwe@linux.microsoft.com>

These headers will be moved out to its own component.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-11-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.h        | 4 ++--
 target/i386/hvf/x86_decode.h | 4 ++--
 target/i386/hvf/x86_flags.h  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 063cd0b83ec..73edccfba00 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -16,8 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HVF_X86_H
-#define HVF_X86_H
+#ifndef X86_EMU_DEFS_H
+#define X86_EMU_DEFS_H
 
 typedef struct x86_register {
     union {
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index a2d7a2a27b6..930d965164a 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -15,8 +15,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HVF_X86_DECODE_H
-#define HVF_X86_DECODE_H
+#ifndef X86_EMU_DECODE_H
+#define X86_EMU_DECODE_H
 
 #include "cpu.h"
 #include "x86.h"
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 75c2a7feab5..6c175007b57 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -21,8 +21,8 @@
  * x86 eflags functions
  */
 
-#ifndef X86_FLAGS_H
-#define X86_FLAGS_H
+#ifndef X86_EMU_FLAGS_H
+#define X86_EMU_FLAGS_H
 
 #include "cpu.h"
 void lflags_to_rflags(CPUX86State *env);
@@ -78,4 +78,4 @@ void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
                              uint8_t diff);
 
-#endif /* X86_FLAGS_H */
+#endif /* X86_EMU_FLAGS_H */
-- 
2.49.0


