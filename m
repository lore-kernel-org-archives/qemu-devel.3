Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB025C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelB-0007l1-Ew; Thu, 27 Feb 2025 09:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekp-0007OK-1v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekk-0003nx-Uo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1jc2WOXKFzU8PfCDoo9XS4Niue04Jb6wNaS0Mo76Zc=;
 b=K6TZW6jD8zVQSvi03zNhhps36qqS8RowlMXiLJvs9obwm1Hls0wAvpBCJdMl/ff8V0tQfL
 gAR0uEtq4D/CL2KCIBbiwsfvWsNl1RyYkdXAk6A/LLYkobP4isl3WaRQtVB+GuD/xeGZzX
 4A6O0VOAKFET2+sPrPQQA8YjaBi/WFI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-2JBPx0O5Ma6aDwmL2KHgyw-1; Thu, 27 Feb 2025 09:20:39 -0500
X-MC-Unique: 2JBPx0O5Ma6aDwmL2KHgyw-1
X-Mimecast-MFC-AGG-ID: 2JBPx0O5Ma6aDwmL2KHgyw_1740666038
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5dc5beb5eb0so760122a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666037; x=1741270837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1jc2WOXKFzU8PfCDoo9XS4Niue04Jb6wNaS0Mo76Zc=;
 b=ZULiVD9PXu2T9OOvj5QtdDqnhjBfhli6ql9MToyAtGN/HGgMJ199adCf4qfF57IRK3
 fll8h7jFZ+YyUkQluOH27QNAL8QuQIt3hCYCepf6hFRMgJYXBbB3Cw5us39h4BC6Yb3q
 plf2UxkrrDfDcus+FIb/GnesmHTjVcN4QYch7cTR+Dq0uV80V8fbUYSDY1FGVJVhHR1A
 /JmLWS0NCEBOoivvxDBdI7C3OybOQmokeh59dDpwYWuPbm29wPH31Bt24PYLT6gzjMj6
 IRx5rU1td7w47VmQtMr+aPc0WYG7ObeDpUu3zWMYWQq2FN3C78ucErNppHaCKsIzVnIr
 XtSA==
X-Gm-Message-State: AOJu0Yz7oJCKPO0zd4h+RjimZaH9VDaQ9HD5J+RWEHeHQ4TYnJlvg4gW
 ow4eVv6il9evZXQdivKiqYSfJbXxaEPVFaZApC5LwuGea0w6f0bCrUzuvyoEwfVEMqv8elN8oVM
 FAYyDXXSAbMkHl2jxxenkNdXnGciBAZoPAyYNUeAYiX2wrq60Fo/cnwkcsIamWja/ivNazmK+7P
 6xHQ7hLYWPaE9p1mPvfHnrsfBxNwsmDz7mBBEFpG8=
X-Gm-Gg: ASbGncvfLwlqRLVLryTsYC9TXvDIMKJRhqHhaU3pj1z1XZny7PeDT0eVDth25xF7JFZ
 +l2kJUl+HRCPVY/rVZN/9iaHz/YfEAOtpYP+/CEZg0mnkWLfu5i44P6sv0R4qfzVu0N8GCB6rcd
 Y55inJarGe7bAHAIL8J56EJKbDfof8vCJzfW78GgWKs0itmTTzLWvPK5IPfFpb1nX3PYhYUPNgc
 mdvyigepXdJp7cqENMo9yORkkRAN+MlCOsjU/aPVyxp+01xf8kOupE4p5jBbRgDEZU4yemaaV7O
 njjdIis2QCxzWdcihj94
X-Received: by 2002:a05:6402:1e8c:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5e4448537c6mr27471029a12.2.1740666037387; 
 Thu, 27 Feb 2025 06:20:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeekzDsDRoq56vyy5wcxRzuFXiLqthAQSLuboWUfkfWzEl5l81rxbtKBKgyuDpnZH456lHUg==
X-Received: by 2002:a05:6402:1e8c:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5e4448537c6mr27470942a12.2.1740666036823; 
 Thu, 27 Feb 2025 06:20:36 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c74fbc2sm128752366b.137.2025.02.27.06.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 19/34] target/i386/hvf: drop some dead code
Date: Thu, 27 Feb 2025 15:19:37 +0100
Message-ID: <20250227141952.811410-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1740126987-8483-16-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index df815941156..ebba80a36b5 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1241,10 +1241,6 @@ static void init_cmd_handler(void)
 
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
-    /*if (hvf_vcpu_id(cs))
-    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cs),  env->eip,
-          decode_cmd_to_string(ins->cmd));*/
-
     if (!_cmd_handler[ins->cmd].handler) {
         printf("Unimplemented handler (%llx) for %d (%x %x) \n", env->eip,
                 ins->cmd, ins->opcode[0],
-- 
2.48.1


