Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D343C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WcL-0005s7-W7; Wed, 23 Apr 2025 05:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc2-00052L-3B
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbz-0008N9-7y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sWFJAsd6uDegNVb1OR0ba7NgY+ZHMqGRsB8GOL/kKE=;
 b=bK/7ot64OxrhlzFcF51Wl7HESjJjCfIJWd0t4H+Cc9d87DP/95+AUzRlWXs1ND2sTK0tVr
 NBOPlVOZNF8nXpyjpxeMA7GbLNoe3I1sfcTcLActC2I0FHB6MF3YqJmsw3yJVi/pLZw/PT
 246WI0KX7W4bZOQ12XgQc0y9HHGXb2U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-lxMOG7WPM8O0FUAhUhgOrQ-1; Wed, 23 Apr 2025 05:41:32 -0400
X-MC-Unique: lxMOG7WPM8O0FUAhUhgOrQ-1
X-Mimecast-MFC-AGG-ID: lxMOG7WPM8O0FUAhUhgOrQ_1745401288
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5f4d2b91f1eso6279402a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401288; x=1746006088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sWFJAsd6uDegNVb1OR0ba7NgY+ZHMqGRsB8GOL/kKE=;
 b=sIpDUo4RNdIwhXSzkH+2T4lvwdsMs0z4UBxloJVPQGAew9O7vbJTPE3GsiYXoOKMQi
 yC6JE533iFwgqr4c0pAZil6xMFif5qxy7lst8VytNGejmhfbhfljlRwMgg1k0K5L0lCh
 AU/Jts1qDWWxmIqQy335oGlI/4t1T3uMQgLIBOZrshk00kXQTLSz+jkURz9CTiKiQdEo
 ikvBcfc8v5d2Rb/XgLLp/0G/OC5+bdrrUSA+nu9ANmDPJn3coh/AgmEsfsgjvhEYwaok
 Jd0QSwjsCu5RD2AZ7QqZ3IcLVSjaRma8fZwFEzsPJDD9QD3ksLDtaGwEDREAiYHcfvfD
 eJnw==
X-Gm-Message-State: AOJu0Yy6ACBOD6afOj+LoBJr+NjwbA5IPbU/cIBJchc0UvO1WJ12afqs
 F9DOg4hHJ1lNsV++QurWZ/Q+gOSSp97Vl6JfEptj2bEnQ+iLOORqUO1S07vdJRjNsV9qQ+Vt7+S
 aERbRemUbUkFNBn83BmB+6Z9ozwJfvOc8QbQEZp/OoUibFVQOy8j2qVLmWtODMOXfg+CRa7FGH0
 sH21Rqa+tjq+v6mUfMcFYDlFeTn6DqrpR4la2/
X-Gm-Gg: ASbGncv8mg0E8UzsprINhL8S35XeeFPBWuQknmfrMFoQzbiRa0ru4D98B6cJSIZGfZW
 b1EJdiT5dY8y4JTuScpKz3UZIbSBzCwwgpm/r14G5nUUIAHgsyLZedko9T8luxo58Ayx2fUBEjZ
 v741N1Y6NBuqp5TxKaCA0EeWiLzQNgZKsji6c8LTOLIbKF2j/wITkJCb5v/Ggc6pMQIsCGXsTYy
 bOALmZW+xKHhoPBNuluSxGH1NwFsu7FUk9Xs28bhSqIULsO1UWG9bGjCg2xdxvhTStPMoj0Uf31
 nmM8wWGT0qIrb9AO
X-Received: by 2002:a05:6402:34d0:b0:5f6:d2ac:be44 with SMTP id
 4fb4d7f45d1cf-5f6d2acc018mr1084753a12.8.1745401287906; 
 Wed, 23 Apr 2025 02:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg6CAUO2yLvCkBXi1cr/iz1i94ErO7ocpSDd6NN8FrGrHB+XwvsphFRJDuqjc/YNfuXZyTig==
X-Received: by 2002:a05:6402:34d0:b0:5f6:d2ac:be44 with SMTP id
 4fb4d7f45d1cf-5f6d2acc018mr1084729a12.8.1745401287477; 
 Wed, 23 Apr 2025 02:41:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625549cc7sm7496534a12.3.2025.04.23.02.41.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/34] target/i386: tcg: simplify computation of AF after
 INC/DEC
Date: Wed, 23 Apr 2025 11:40:40 +0200
Message-ID: <20250423094105.40692-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

No difference in generated code, but the XOR-based formula is
easily understood on its own.  This will make more sense once
ADD/SUB stop using dst^src1^src2 to compute AF.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 9aff16b8801..b821e5bca3b 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -175,13 +175,10 @@ static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     uint32_t cf, pf, af, zf, sf, of;
-    DATA_TYPE src2;
 
     cf = src1;
-    src1 = dst - 1;
-    src2 = 1;
     pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
+    af = (dst ^ (dst - 1)) & CC_A; /* bits 0..3 are all clear */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK) * CC_O;
@@ -191,13 +188,10 @@ static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     uint32_t cf, pf, af, zf, sf, of;
-    DATA_TYPE src2;
 
     cf = src1;
-    src1 = dst + 1;
-    src2 = 1;
     pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
+    af = (dst ^ (dst + 1)) & CC_A; /* bits 0..3 are all set */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK - 1) * CC_O;
-- 
2.49.0


