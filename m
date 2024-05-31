Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E00C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyM0-0000ol-Bn; Fri, 31 May 2024 05:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLy-0000nh-Tu
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLx-0006VY-AV
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEFP5XulFyFkWbdx6jRm5tpvw2lCppUkXM8RgWoJ+xw=;
 b=McWvfJiW3h9yLpM6rPM0HnFbq+Em0UBnWwvGxloSmz2LyD4eXMiBt4jyEWGZqETM8mVakT
 Cu+2XJi7CGDRR9HYfUUZcB0QF/5DXuGjwkzVYhbceDeEbFzvrXvLFEHQT3aOGdwYeSw1t4
 jYVaF0tEQPS1wGMHXMiOpCk1Elu6Flk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-YIpumE7_Nlao06bLT3kgpg-1; Fri, 31 May 2024 05:15:04 -0400
X-MC-Unique: YIpumE7_Nlao06bLT3kgpg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6661f44448so69393066b.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146902; x=1717751702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEFP5XulFyFkWbdx6jRm5tpvw2lCppUkXM8RgWoJ+xw=;
 b=Qkz5oTruNXncsXhylRUCTxEy+B/+bDLzii8Dq+LugEeTtFUWQLr12eKqXNUXZIDKRw
 gdSpHssFvIFVEQZbed0Y0ylcLXyXnTWmnBapSGbUTvbaSYbB3k95+RHa4W/Z/1tELPbe
 t9LL6wTDxe7EqujgDOdDeeMHIsCLUyyuyALM5Fq4cIomojkRbs3qvznYcBEora4va0Uc
 9tZ0A0wKyjR81kwgqLrx+kTrM9hf9hpdPshFb6LPxb09N5Q7TOH+3xejx1+xp8RLJygK
 6I9jMgC3k4QfaZijCSgqfdkhm0KD3yOKMsbM+bBNIQfqKlS9w7dFFNntmo3gYKWTl1iT
 AcOg==
X-Gm-Message-State: AOJu0YxTSevVl+spX3xHyC1bOpZcMPerRtBY03KAaUemaGv7/07r+ktd
 s7jjH0Fiuk3sBd0zV8Q7590WvLkOWJdBSxXrau3AAcixklHZkLggkdBaYHnJBOjKOPCK7PqkEWx
 gJIZclXFmH1lHDQdWRmZ3YODOh6qh6B0HSDIaHxSdwhS4n8U65RtG2IE8LTDoPoM5HnRy0efhEl
 Gua31tlE9zXIfeCxk3nBWE+jWMgzLapHWCf6Ev
X-Received: by 2002:a17:906:1e09:b0:a62:8859:6aff with SMTP id
 a640c23a62f3a-a682022f887mr98315866b.30.1717146902641; 
 Fri, 31 May 2024 02:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdETNJJXT9OknGXMid77He9GW/3CMmDMjtbYcal7FBm9eKvJ2FKJD9k+SRc4XISflOCu+Fcg==
X-Received: by 2002:a17:906:1e09:b0:a62:8859:6aff with SMTP id
 a640c23a62f3a-a682022f887mr98312866b.30.1717146901971; 
 Fri, 31 May 2024 02:15:01 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e6f03b0dsm66945466b.15.2024.05.31.02.15.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:15:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] host/i386: nothing looks at CPUINFO_SSE4
Date: Fri, 31 May 2024 11:14:52 +0200
Message-ID: <20240531091457.42200-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The only user was the SSE4.1 variant of buffer_is_zero, which has
been removed; code to compute CPUINFO_SSE4 is dead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 -
 util/cpuinfo-i386.c              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index b89e6d2e55a..9386c749881 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -16,7 +16,6 @@
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
 #define CPUINFO_SSE2            (1u << 7)
-#define CPUINFO_SSE4            (1u << 8)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 9fddb18303d..18ab747a6d2 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -36,7 +36,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
         info |= (d & bit_CMOV ? CPUINFO_CMOV : 0);
         info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
-        info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.45.1


