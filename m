Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF55C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhLE-0002GS-2C; Mon, 10 Jun 2024 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhLB-0002G0-Vq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhLA-0005vi-GF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718034827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEm5SypP4ujlvRPqKGgOWCwNC2b83/NcN8Gj0e/pphI=;
 b=Wp9M+T/5bUszuh8ki6AIRYOOfRnNTnbIhiRFK08PVCu/yZ2FfXOOKt3RGu/waoqBpNskr8
 rGUzFwY+i9DI27mNsn0N0LWLma10eFguMCaRseLUCrqboNETBlgHihh7EpYzgadiEY4ycM
 jULPBsID1g9rtikLRou43qFwGdn8oWQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Tm16QYLAMLqIiJY-wtQD4A-1; Mon, 10 Jun 2024 11:53:46 -0400
X-MC-Unique: Tm16QYLAMLqIiJY-wtQD4A-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70498a5c19dso1040679b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034825; x=1718639625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEm5SypP4ujlvRPqKGgOWCwNC2b83/NcN8Gj0e/pphI=;
 b=e9xlVBOd1ohqS35K2ACpKONkgSYgfi6sVem/CqPvdk7gHz/XN28H+VJ9deWCV9z15i
 5gP42u9xZpB2kkJAz6LKrJ4v4H5XmoLSSzXZ6WAeAi7or2sU6bkRXe36vI9HN52IN80P
 6T2ocrRHi/SZ5e8Hq1dmehqNfjyP0P07QDZFxHzkqArIsEXAbsGfW2yv4FGYh9T10pNc
 G0PqPkANntwl1rOzHDysMEUFi2eRrV+q22fAenlh14BWbABLFJS2WAWPAOXO8yJsP4xK
 neAAUSaI9IESOM3WKlQXmqr/U+Gmrgvd8dPBDS8prDGxmB4rvdajbEKOWlbWY8EOtSHz
 oyxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVURoSs3Zv4C47tw3fDCuN6LUZb4eHOLFGwlOoRz6/RbZOvDKYIsXi8mR1R5dn5aWxLPVkWIEB7ZQ++lvAwqxqsFR3wSxI=
X-Gm-Message-State: AOJu0Yw++mkNgGKgMkZulyaZCv3aDeBxhT+wla6tTauDMqY1Qynefulz
 yliN/rrxG3ViNnpN/AAxvFdAkL+ZeVAjFTEEmnSlCa11GjWtHvEWYYpbe6zxlV6PHfPv0ChFfda
 pPijA7A3lx2SlzEr5mtuzGVGkwvs/V75acuWTKx+f4EyFsbwLLMJP
X-Received: by 2002:a05:6a21:32a3:b0:1b5:cf9c:2936 with SMTP id
 adf61e73a8af0-1b5cf9c2b30mr5368398637.39.1718034825244; 
 Mon, 10 Jun 2024 08:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Zn2ooFk1wbPb5KmhsF4Ez1tcrY/SDRhIdn/tdAfdshOJw21+TFvBjJZMgVOvEmwDfKJTfw==
X-Received: by 2002:a05:6a21:32a3:b0:1b5:cf9c:2936 with SMTP id
 adf61e73a8af0-1b5cf9c2b30mr5368379637.39.1718034824841; 
 Mon, 10 Jun 2024 08:53:44 -0700 (PDT)
Received: from localhost.localdomain ([115.96.118.89])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-6e3819ffa94sm5155290a12.85.2024.06.10.08.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 08:53:44 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/3] qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
Date: Mon, 10 Jun 2024 21:22:58 +0530
Message-ID: <20240610155303.7933-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240610155303.7933-1-anisinha@redhat.com>
References: <20240610155303.7933-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

'pentium' cpu is old and obsolete and should be avoided for running tests if
its not strictly needed. Use 'max' cpu instead for generic non-cpu specific
numa test.

CC: thuth@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/numa-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 7aa262dbb9..f01f19592d 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -125,7 +125,8 @@ static void pc_numa_cpu(const void *data)
     QTestState *qts;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-cpu pentium -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
+    cli = make_cli(data,
+        "-cpu max -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
         "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
-- 
2.42.0


