Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BCCC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTm0-0004mF-3H; Thu, 17 Jul 2025 14:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8m-0002uq-Cq
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8e-0002Gl-Oo
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDBnlPqeGv4rwPb8eQVz5uOF6kllE9KhwMqiqUrgjcE=;
 b=A++TT8itp7jx32yjP3X4KYNPllyuUeDR29mYYGk9S6rBUDlu7axGEacgWOklGTIlCn6mFQ
 lAjli8XvQOTZoOxvgIrSwI5VMxDBQE3jyxd2XaW5tvY12jFG8c3EtEvPOsg9BminoDAAUN
 3kjeqGppe7ct8dcKb1YyNoPMQj7TSds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-PWbRZiTrNOKeuyx7V41frQ-1; Thu, 17 Jul 2025 12:07:14 -0400
X-MC-Unique: PWbRZiTrNOKeuyx7V41frQ-1
X-Mimecast-MFC-AGG-ID: PWbRZiTrNOKeuyx7V41frQ_1752768433
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so794922f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768432; x=1753373232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDBnlPqeGv4rwPb8eQVz5uOF6kllE9KhwMqiqUrgjcE=;
 b=l/lUKYn5zqKIkFNf9AHqUe2GftzNrFgYMlhMjCIc2ivzvJer9VO2pa/KlcSr/IdlUE
 t5Ndkg1gLP0F6NMejDFBXk87Y9TeQF+AT0N8JwtZjX5de21GEQnDroY8Tf2kAi0cooN6
 IIT3j01hs2jWi9AuKMCDvY75efuix2mkF1aq+I+jRp3dbflDPCpu+UIDLXWVJeKzuaiA
 PSwdprLrgv+QJF08VNG1ihW+b74iDiHdVRQVuvkqNEgU8pqZAho0P+1YdS2vRrXCQEGg
 cEUZMbi0aWeHx8cGv/kzZN8G8ioZb4Dk8/lq7NXsmoceBF5t0Odfq5sWkYmPHJXLWzQ6
 z9jg==
X-Gm-Message-State: AOJu0Yzp5qZbeK0jbYfaNROPTjwzdnrCquIP9CctKbL36JLHP730x6Sx
 G4svotxQjyuF/SDGVUfZnUJ6f4sgNZQFZeHIK9Dvy/PjUN2DEMvzbPu2e/1zv55lOfsll9A9/3f
 Y8hgKuyXgu/oJmaCyxo5Wd5qkMqjSd6H58375vu6I4jdKGk9rTkVg1St+1qE1gdQscldpJSYwDW
 YdyyWo7/PVINTOhAIGuSwDnA27gM4fGRD9wb3Ht6L1
X-Gm-Gg: ASbGncuUCp1pfuoQ3FClaKab8HhE/3Uml5z1zAZtUDOCyvMdpu9oexM6tnOORP2274S
 Y99lChSbviFlx2MPZiac5HpripI4KF+dCxxvD0VLPCJn9fCpnveJ0tDwi0jAjcytrQV0YdYZMxr
 qoHRnQXTDG06IBelu2P3CZhGxH7I3Q8z+6wjqyONelS+wJHC0ip1o6ItKWK7lvMzqujgn6Q8xvr
 u3FmndjR/H/Jta5dtgIDsi+Dv9Uyk2lhfcHsJMHHHZqZ5xqSFrhP/rRW+35VDaUX/uXDQA0grM8
 j2aNk80P3AjZaIsARuO+J3qv0M/vDvrunxH2R1F2KmE=
X-Received: by 2002:a05:6000:2d81:b0:3a5:2848:2e78 with SMTP id
 ffacd0b85a97d-3b60dd7a9cemr4362076f8f.28.1752768432059; 
 Thu, 17 Jul 2025 09:07:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvLUtCRYbDv9ccuADerlNA1hmLwN76YfXv7CG6kJvfmSXOKUdvxTJ8fKMTbicphX72mw8MPQ==
X-Received: by 2002:a05:6000:2d81:b0:3a5:2848:2e78 with SMTP id
 ffacd0b85a97d-3b60dd7a9cemr4362033f8f.28.1752768431337; 
 Thu, 17 Jul 2025 09:07:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e2cfsm20840222f8f.75.2025.07.17.09.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 4/6] target/i386: tdx: fix locking for interrupt injection
Date: Thu, 17 Jul 2025 18:06:58 +0200
Message-ID: <20250717160700.357384-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
References: <20250717160700.357384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Take tdx_guest->lock when injecting the event notification interrupt into
the guest.

Fixes CID 1612364.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7d69d6d7b06..1574e7d76fe 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1126,10 +1126,15 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
-static void tdx_inject_interrupt(uint32_t apicid, uint32_t vector)
+static void tdx_inject_interrupt(TdxGuest *tdx)
 {
     int ret;
+    uint32_t apicid, vector;
 
+    qemu_mutex_lock(&tdx->lock);
+    vector = tdx->event_notify_vector;
+    apicid = tdx->event_notify_apicid;
+    qemu_mutex_unlock(&tdx->lock);
     if (vector < 32 || vector > 255) {
         return;
     }
@@ -1179,8 +1184,7 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
         error_report("TDX: get-quote: failed to update GetQuote header.");
     }
 
-    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
-                         tdx_guest->event_notify_vector);
+    tdx_inject_interrupt(tdx);
 
     g_free(task->send_data);
     g_free(task->receive_buf);
-- 
2.50.1


