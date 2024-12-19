Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22ABE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxq-0004Vx-EA; Thu, 19 Dec 2024 03:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxo-0004Ud-0k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxm-00056d-8j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/ENCW2ZbKsFmMbQzc45gFjdcifV8MZLOt5dduiBsBs=;
 b=RtWAtRQyb8h91gFSbC9OHiwsBc9Kx6EoeitqMgjgvauc2A5fV8sk9fXLbwmjPdYuIJ7oDt
 xCuJntnRjyCy2jAz8yHqSAbySnscIFdBrlCEfS1riqDVOsz74Ww6b60qH2QrVVCdUGjj7F
 BpgLDVqS429sPN29jHid6B8KvhFThi0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-me-VUX5AOXWAHkvO4-wAPg-1; Thu, 19 Dec 2024 03:32:51 -0500
X-MC-Unique: me-VUX5AOXWAHkvO4-wAPg-1
X-Mimecast-MFC-AGG-ID: me-VUX5AOXWAHkvO4-wAPg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so2983505e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597169; x=1735201969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/ENCW2ZbKsFmMbQzc45gFjdcifV8MZLOt5dduiBsBs=;
 b=YmmLtnxSW5WF28qor+baCwaje4nnh0JYtuVlqrF1sCCpjm91v5vNjoQpe8U7lfUusJ
 paZIymDEa5kwpS38Aw6Zni8xeBR+w2F4PxEmx0CsJ6S9eHW99IbFhK9qiHrj6ykzi90c
 yEDekkUNsqxk8IXFU78S5Elj+1t8cnSTgwJFJHAZVYCPY8q7yoSxjbGPZH+aVGW/pwfu
 7klrLAIDFBpw3nspOkvS46HW6bu2U+owz7z3Rvau5Vr03Hl0Z6SO/9xB1dYQ6oky0Mak
 R94Rg2VMKozhfJ5hfRG13Wf2DeCBGXLzULdiW2xMxeRkGEhmiIW7XeLR29xJU79kxpXJ
 SNPg==
X-Gm-Message-State: AOJu0Yy1lm+6Z3k/Mjy6pnLI/NkYT/Q8osXSpHKE61ZxF0n1k/GuH/3C
 UvHzqHRm+XVxwHjD5uvmq6e3h9RC5KYB3pUsLXWizktaibgswHg96XsrqRwLXUY39v6A5Qhrv4d
 F0CB+/QUhnJDxZTwN+qWU8i16nQn3AD1D5JTNu+AUFNpphIb2i1wEryQRVURYIOTxzM4XiF/3ze
 fD8kvopaP4hs4HVksnTG5/NAJ7AvbVr0kFL75R
X-Gm-Gg: ASbGncsOEsQOK+/svKZJfdQ2VgXh5dRmYRm2SQ52KNVgnim0T7dr6a5DMVmra/a9GG0
 HjGXnRe6TVLOL7ektm4a8JqH+ttXuKHlWGlzLEHMzQsYwLS7E1sFKVjTW+H4LGYvTo1/ULmUSiE
 QQpjtiRtcgBUTo7KV0BlbvpOZYOQMWLMGN68pdVhxRWp9O1dnrdEvSuFp58Q1Se3kCU1xrNz6mW
 99DPOHcWbEK1eg0icd7EYFEhCmVlQa3Fh/g6jNhMzB0klQoY7EC21raQVZk
X-Received: by 2002:a7b:cde1:0:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-4365c7c9713mr14808285e9.26.1734597169705; 
 Thu, 19 Dec 2024 00:32:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcjR+VMxAu0nFHCgL4AzVlqS/5SaastdJGcxUUecubn4xtJRVQYzz0CHTdDnXcZOqc/2/u+Q==
X-Received: by 2002:a7b:cde1:0:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-4365c7c9713mr14808035e9.26.1734597169333; 
 Thu, 19 Dec 2024 00:32:49 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008bcsm11140035e9.16.2024.12.19.00.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/41] hw/sparc: Remove empty Property lists
Date: Thu, 19 Dec 2024 09:31:57 +0100
Message-ID: <20241219083228.363430-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-11-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sparc/sun4m.c   | 5 -----
 hw/sparc64/sun4u.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213f..7ec346533e2 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -732,15 +732,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
-    {/* end of property list */},
-};
-
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 7088ac273ea..05b8c7369e2 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -471,15 +471,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
-    {/* end of property list */},
-};
-
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
-- 
2.47.1


