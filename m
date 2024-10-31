Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAF4D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLU-00076E-K8; Thu, 31 Oct 2024 13:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLT-000758-G5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLS-0007CR-0v
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=leQodRwO8cbwBZJdEKIZ8FGqkROJiM0fBvAauKBAI60=;
 b=ZMpNATsPxdEG2T6vfuM8bPmJ24zetXZw1nPpJhJtVqFurvcENX4xkZG+tNGX3PRl2e3n0X
 CxhNln9gBkBT+CtB2uu4CYgUxyLa3FDpbZpoFrwDEzcTSU2pTKxzo9QW7/6ufsw6oFICgc
 JtNA/CaSwtXBrgN8Au743EJXGYj+d1I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-23SLY1ZcOSqVgxQU69T-fw-1; Thu, 31 Oct 2024 13:52:28 -0400
X-MC-Unique: 23SLY1ZcOSqVgxQU69T-fw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so530806f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397145; x=1731001945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leQodRwO8cbwBZJdEKIZ8FGqkROJiM0fBvAauKBAI60=;
 b=J54VLHBsK6RzAM/aJYfLTzNqXzrs3s543wLeLdFSSZXG52C4TTgMuwNWUMHTJNJZb3
 9kCBvDfYSj5HGwBLzkD/2+CsH0EppxZiX5dGQhQzSf13/+5I/vLuqOyHph+jZFiijijf
 FNbwzjCyFikdDtYQ2SFvt/s1/lE9ugT1ofarEetpw5tuTu20YnJtD+uZ5r7Tjv99o4TD
 MQyAHeNCgr/gyvcQodJMBwx+zWdTbTKZhVcrynLJMzHkku4wH/yhc7Eo4/dTSCFgXtDH
 K//PylP5A9uWxvlmRXKeghNB08ZY2dpgmaxHp+gvuznTcTAtsRblVlDY1F0haPMIua4P
 4smQ==
X-Gm-Message-State: AOJu0YwNKUrF8Sm2rcN6AS46xCJyxyZ3H1nxGXyaLprVM9tElLeL4h2B
 dI2JC9zKhZP+kQk61a61cYbTgGZJSRySrd8eL+IrUtWQ47fZMZRPnMa+eQrTI/2rHI2c9OGkh1i
 B+6QXZaDYGatsnoakpSxBfM8SESfAm5XUn6Rc1Z689X5iNX8upBiy1fWMxJN/E9Ejf766XbAFW4
 jjIFJ5lR/zbdDyMWjZdeTBS+oVwfmGegxgQFAwmIo=
X-Received: by 2002:adf:ec4f:0:b0:374:c614:73df with SMTP id
 ffacd0b85a97d-381b710f3f4mr5615862f8f.57.1730397145217; 
 Thu, 31 Oct 2024 10:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWMh0EabJUHlFuCXm/NodT+fp49N5dtzKOI52zWCQbCsb0G8nzaBnepQL8h3NC/ZH3WJOHRA==
X-Received: by 2002:adf:ec4f:0:b0:374:c614:73df with SMTP id
 ffacd0b85a97d-381b710f3f4mr5615815f8f.57.1730397143491; 
 Thu, 31 Oct 2024 10:52:23 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e885sm2788798f8f.89.2024.10.31.10.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	qemu-stable@nongnu.org
Subject: [PULL 04/49] target/i386: fix CPUID check for LFENCE and SFENCE
Date: Thu, 31 Oct 2024 18:51:28 +0100
Message-ID: <20241031175214.214455-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

LFENCE and SFENCE were introduced with the original SSE instruction set;
marking them incorrectly as cpuid(SSE2) causes failures for CPU models
that lack SSE2, for example pentium3.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f193716468..48bf730cd3e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
         [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
         [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
+        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
         [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
-        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
+        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
     };
 
     static const X86OpEntry group15_mem[8] = {
-- 
2.47.0


