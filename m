Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE4C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqpw-0003b4-Or; Fri, 01 Aug 2025 10:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhX-0005ah-3J
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhV-0002pB-DJ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL9+A2pIj1svEtoSCipjyGY+zemWuaFe+SiKFMe1fHI=;
 b=QZ1MrVDcELObq4s+/kTgZoQBtTy1P6mVMcBjuLyz9xuhN4GryatX8z3nAukDtKcFCtymwE
 nmeTF3yHGzQqB7QCpa6BhOpoUXd0AwkgLzSCBqb7nhJgyjQ9mqwNN2zrxK4CfK+YqNoRe/
 Nc0NOcmp6DsgOh1c+mE+Bie1smAOBUc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-mO4hzbMLPdKttM8DZIMqog-1; Fri, 01 Aug 2025 10:25:34 -0400
X-MC-Unique: mO4hzbMLPdKttM8DZIMqog-1
X-Mimecast-MFC-AGG-ID: mO4hzbMLPdKttM8DZIMqog_1754058333
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-458a533c069so6680795e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058333; x=1754663133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL9+A2pIj1svEtoSCipjyGY+zemWuaFe+SiKFMe1fHI=;
 b=wjL5aI2go3BxMo7AgPlS2Nlp0k98OYqXoomUuRKRSRSZshrFvRLhwgtptF1llJ1L26
 2c7zzG1BP+XoxkZhmCIf6yqfWSpERXBvkcPQFR4XeHovWqMvG1dPQ9KrPgWdv0bYZzik
 2XizUsHjhlcHB6GzFT5kXcnwenf0rXLsGU7thl37NHjHKc6F7cUuISBSr2ebs62KinCj
 w/0IadhBMUpKDoFuTIXMCb8Jk8NKQcZ/P/TuAiOQsXGciCs6zpOknTxXjz/Rqe3leG8X
 iIDqe+E2/qTIwVlSfnQw48gMwKQZ/wGHT77it6nTGVC9JAuEbetHk+7ZaJ9XQ9BoFSEz
 A4Pw==
X-Gm-Message-State: AOJu0YzsSt5AR8LjlQaDT7jntL7S4QTSUDQCqKtoG2/Hxh2RoURse8nX
 LOWWRpfmHEbea9IjIwg/bsGQ8hq0M6VGRn4AKXAplZJnt8pcK+8sGIpuZMWT5GTtNO3mTmSSaXq
 cfId2t2QaMR/2A63zDMvvpt9tbbNX7+bP33lJjMswJC8it7j3wFrqEvzIedfoZuXXHKGcCQnP9H
 8gYxqsgxUWhgAWsh3qKuJ2kqqVTojr+DhGPg==
X-Gm-Gg: ASbGncsqmZ0BkI6fcxUC3y+Mvq4QnX9wcRM8kveO8Mfeqnoy6qITmxSQ1fYpR9DWW3t
 ufVU4xSlVK+unxTKUNdzysmJQivDOQ7L/0nJzv3WbkHXAuEhJjZTmQbAZxkBHFZpqQB+KtAL+rn
 N7YwAJPV8T+dmoVpMBMMeRHupMMbOnMTS84vWQgUkC3XZNr44RtZYfvzVdiRmAbyPQVgYurmXX/
 up01p6as615mzynM6wPFjGSinRuXGT45B8GHVXVvOAxa3SlmhFUYkTgbXi7T7+IMq0xiwEB+Tpl
 BqQ/fer4szyHM6pfyG07aDYBtOZxCUjo
X-Received: by 2002:a05:600c:4ecc:b0:456:e39:ec1a with SMTP id
 5b1f17b1804b1-45892ba272cmr117865945e9.14.1754058332910; 
 Fri, 01 Aug 2025 07:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF65kXBkLk75B+1vmQcp7lIPRgHiznzOTqOqwyfRCF5KbOK+NMbKxZ5d+iDfWzJ1uk0ojI4pg==
X-Received: by 2002:a05:600c:4ecc:b0:456:e39:ec1a with SMTP id
 5b1f17b1804b1-45892ba272cmr117865495e9.14.1754058332450; 
 Fri, 01 Aug 2025 07:25:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453aeasm6285769f8f.40.2025.08.01.07.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:32 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/17] tests/qtest/bios-tables-test: extend to also check HEST
 table
Message-ID: <5088651138b94542807414eb841363b16d6aa535.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, aarch64 can generate a HEST table when loaded with
-machine ras=on. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <9ce77140500ef68cc939d63952c25579f711ea52.1749741085.git.mchehab+huawei@kernel.org>
---
 tests/qtest/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 6aec68decc..e7e6926c81 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2208,7 +2208,7 @@ static void test_acpi_aarch64_virt_tcg(void)
 
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
-    test_acpi_one("-cpu cortex-a57 "
+    test_acpi_one("-cpu cortex-a57 -machine ras=on "
                   "-smbios type=4,max-speed=2900,current-speed=2700", &data);
     free_test_data(&data);
 }
-- 
MST


