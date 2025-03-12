Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9033C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 00:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts9cA-000473-9u; Tue, 11 Mar 2025 20:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1ts9c1-00044E-1F
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 20:06:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1ts9bt-00036X-QP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 20:06:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso29257135e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1741737967; x=1742342767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JQeiZwQw2YY/VoRXzH8x6XdaYXFQY0XQRR9yg0JXEk0=;
 b=HR1lBB31K6YPadlsNbOGeUeKHpD3ddaiMT7CO0mdOq/X4Pio1/DpaQ5GN2GzqON5NU
 OMV7lFDFe64/+Yppqc9tx/C5pUZ0jkZ0mzzMIK9JttsWAeLL9aYTFARNnapcWUpXNVet
 hwNIlf7IEEAfhVdCWIE+YCaFz6Yt2ttsyRaI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737967; x=1742342767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQeiZwQw2YY/VoRXzH8x6XdaYXFQY0XQRR9yg0JXEk0=;
 b=qFrMmE176YyRT9Tq+6QoefmWuFy+xcFRi6HtGqb3EELfPk7X6++04hrBY17+CJ3y6J
 vHCLHtalXvRJEAdoIya5H9v20N+OnZLzly7bmGLjaO8Zj1b+UuYcyb2cI6YCxFgAiCsg
 zj34xk+TeGwhgXkBs3ANruz2eqKmtWTfJayuVSkCFgUDUe+K7naiIjAQpEstccoUs+pP
 VwuBmi7DICqVhK4iClPtv4o4b2825sXUwjIMnDLE2JhUtkaMuxtHlX4NhRztR6KGvFI4
 xjlk07YbDM+Wpqixgxz0fPRxYQu1oOfV4evJKPz1lrcUNY1wFpngzyGk+fN7SY6bG0OJ
 ASUg==
X-Gm-Message-State: AOJu0Yy2bcjlhp8HIY2Z5i5DqQVPR+cWoUD0O26cq0SZqKNBZPKB7gay
 ZMENKDYCAdNTocMu7OkEOEIi5IGaLc1i7Mra+al2uawk1IX7SfZU1xZDFZ3HxvWLtfT1tuw/p5S
 +
X-Gm-Gg: ASbGncsbIEEZ1bi8X/XxzvFRlid75/fXrQje4sD/i3oCj1hnBD9q+oID2cNBI7gXa/0
 zvPg0sQHi5Nmi1xNK9IoR8NWtq4ZzEL1QpcBzrXzSIRQwN71XZH9j8gO3V3HDh1hFHH1a+HB9b9
 BLeZh2NmZsApgnxAvzz50zVRev6M3mva8GqZjx2HX6CVgt9ZNjyAo/0DOj5hqd4AAVOned/G6TN
 aHsJ+oTpIaUpJPsB+WpsbiDeJmDSgrtlOwwj+gcj0ZLywcQiEMDgerWmMZW2+0UfGDefbXE/Rz8
 GxB2AanqHf4+qn9slZtojBV0oRkrSbA7k/55vwJKlpGurjHcqFkbtvaqp6++KDd7tKylU7UHEix
 Hn0nETjupqW/jv1CG0Q2C818M0iwpB8CKv44=
X-Google-Smtp-Source: AGHT+IE5XOhxIAghFYPTOOAc+xF6iFMk5RFloLCpuvURutJFFw8UDW3JFEbg8tqV3ent+V008P8V5Q==
X-Received: by 2002:a05:600c:19c8:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43d082c2db3mr24410985e9.23.1741737966822; 
 Tue, 11 Mar 2025 17:06:06 -0700 (PDT)
Received: from andrewcoop.eng.citrite.net (host-92-26-98-202.as13285.net.
 [92.26.98.202]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c101febsm18947711f8f.81.2025.03.11.17.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:06:05 -0700 (PDT)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: qemu-devel@nongnu.org
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] target/i386: Fix #GP error code for INT instructions
Date: Wed, 12 Mar 2025 00:06:03 +0000
Message-Id: <20250312000603.3666083-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=andrew.cooper@cloud.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

While the (intno << shift) expression is correct for indexing the IDT based on
whether Long Mode is active, the error code itself was unchanged with AMD64,
and is still the index with 3 bits of metadata in the bottom.

Found when running a Xen unit test, all under QEMU.  The unit test objected to
being told there was an error with IDT index 256 when INT $0x80 (128) was the
problem instruction:

  ...
  Error: Unexpected fault 0x800d0802, #GP[IDT[256]]
  ...

Fixes: d2fd1af76777 ("x86_64 linux user emulation")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <richard.henderson@linaro.org>
CC: Eduardo Habkost <eduardo@habkost.net>
---
 target/i386/tcg/user/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index c45f2ac2ba68..ff328b2a9522 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -64,7 +64,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
         cpl = env->hflags & HF_CPL_MASK;
         /* check privilege if software int */
         if (dpl < cpl) {
-            raise_exception_err(env, EXCP0D_GPF, (intno << shift) + 2);
+            raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
         }
     }
 

base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
-- 
2.39.5


