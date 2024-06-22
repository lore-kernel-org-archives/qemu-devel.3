Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2FFC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3T-0000Ul-ET; Sat, 22 Jun 2024 02:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3E-0000M9-Vd
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3D-0006Tq-HZ
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1Dd/q0yvFV1Rcm+rk+YwoeGVJGUNMen0d4jeqopdXw=;
 b=JcaLbmYCyCiXi8Jcz5BQMl57l22E8lY/05q9pcb/80aeUxl/YJphg+Kadj2I65h0AfrbIa
 lsU6ofYNUamJEBUYKCoDdqfxhEKW7X3wEx6boDofP+2OFeddrcj8zzG07tl4dCpvSGrXlU
 LPJKVvRDLh07Z2s9APWazsDBNW6QQqw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-d6DKQ74ANRakPLlSFbS2jA-1; Sat, 22 Jun 2024 02:16:36 -0400
X-MC-Unique: d6DKQ74ANRakPLlSFbS2jA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c8ddc2ef9so1965648e87.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036994; x=1719641794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1Dd/q0yvFV1Rcm+rk+YwoeGVJGUNMen0d4jeqopdXw=;
 b=WnChdM2O7eEQ/mm9T8pnqNqSmVTU4xY/Rae9EID9GXCl1vdeYuvg8mB9p+5lKzv4iJ
 /wB+JzTRSGeE5CfsZIegolpi3WWyTwUawKcb342aCCb9rM3v6llBkLo1bnfZshKNOiGT
 sdktxLuFfE/yApz8Y+MKFtKDXKxOH72R5CHAYykJBDf/UHVY9WmCvlvvFXs7Dn9jfer5
 bKPWw6nlhUX+vZRIeah3Ngjwu8T/Io419SbBdgwOLCYWAoCi34M4ve+v4NUlD0WfPQXO
 7RISlT7BTorJeBjEbXK3MhuNZwiMNQiLQLAQg/J65y43HrAjVT0AwPKcqsn+0R9F6D7e
 uOiQ==
X-Gm-Message-State: AOJu0Yze0nDMLj2UoKx/OmSPHiVe3HO2rjS9UkvybNJnpyzECKO66kFE
 +jMsjQtAG8jfznmVQ7eRTJgNlsqneuRD/lm70ISaIItcQURe2vt9nEvHJ1RUBAWySpu4yV1l8sK
 iyDye0nHM7IfAkrdpqvma/BBb8jYb6qlxnZnsJ9FMbplzZbJJBY3GQBV36STExJ6YewWNBSoiG7
 VX61cAesWuebeBVIHGbKVBv47DBCWIXHoxQ9Mc
X-Received: by 2002:a05:6512:3f8:b0:52c:804e:e831 with SMTP id
 2adb3069b0e04-52ccaa524ffmr6791268e87.47.1719036994369; 
 Fri, 21 Jun 2024 23:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5EA4tWFfgpmubFf5d/xQnTeW8V4nxpZ2RzvCLa+40jFtd7EZgJIclJrNO2cGy2ARbhk9ENA==
X-Received: by 2002:a05:6512:3f8:b0:52c:804e:e831 with SMTP id
 2adb3069b0e04-52ccaa524ffmr6791258e87.47.1719036994003; 
 Fri, 21 Jun 2024 23:16:34 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fd4f75309sm121604966b.106.2024.06.21.23.16.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/23] Revert "host/i386: assume presence of SSSE3"
Date: Sat, 22 Jun 2024 08:15:48 +0200
Message-ID: <20240622061558.530543-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 433cd6d94a8256af70a5200f236dc8047c3c1468.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/cpuinfo-i386.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 6d474a6259a..ca74ef04f54 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -38,8 +38,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
-        /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
-        info |= (c & bit_AES) ? CPUINFO_AES : 0;
+        /* Our AES support requires PSHUFB as well. */
+        info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.45.2


