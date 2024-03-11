Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B7FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngJ-0000Bq-4L; Mon, 11 Mar 2024 17:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngH-0000BA-Lj
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngF-0003y8-Tg
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgD8Hj1BkAhj8rZZ5gxcPG2OyHSFcGpD603UIiwTf/s=;
 b=ZZEIiedu6TLxiG76RPImfWhwuWVKtzVMmUBWkecjHNHZ3oqKZML49JmyBa1URhvkU5G1eg
 ktzGYl6agBvyGrGcjN19RboSqWxkSbZPSJgyOy+YTGtcrVFa+zUt0iVc7aFkgJnNs470rO
 2NDqaJkLTdCneM+vpz+Xno0xUKq8Ek8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-10zwMXv3Piy4pF5EbOqIFQ-1; Mon, 11 Mar 2024 17:59:34 -0400
X-MC-Unique: 10zwMXv3Piy4pF5EbOqIFQ-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7dadf2f724aso283616241.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194373; x=1710799173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgD8Hj1BkAhj8rZZ5gxcPG2OyHSFcGpD603UIiwTf/s=;
 b=MEpnCZxh0zj8ouIscwrBZSjbsYaU7ewojB/Hn1gP/sF92IaOgn6YC9Z/BnZXUt4R69
 scKZUR05B2f+GQzkwo5kUf41AKyp5aUYWX2IafaQUSieKiNus9AcPIykAoKsuOhiVdym
 BaSGQKyMkwe6O7xU1cFWVDE21D4+4CPdxl5s61T2R8sDYa77h2O3d4c0cSiTPymN++V6
 WH/FO8F1h3spdp2knANLdCPPaETgpvRARWS24KDNCxv5o8AMl9B0WRcYryNBlrecQnfh
 pSZT7ck8GPTI6iIuu53USJofBhFvGdQcEbM1lIrDLrKA6zZRiSEHmwfVV4k+44kBk2Hh
 TDMg==
X-Gm-Message-State: AOJu0YxuE9L0cpWF1c9M0iBwB/4piP8lLOcJvnpQM+/5Y253BVRKaZU6
 gFwrp4og/3NVNvHf7WtPdAGN+4UWpGY5E0Z58+1NlMggxvqlWEjUQvLskEXs9nR/m5eFsgrRfXR
 Kte2xUqj2QJ9nRc3Ruo99N+tOp3kDuvNZCpOxtxQBfj0OD2Ggd0boZDYDQ0EJNwVu80I5kwnjdK
 KccrdRmGGB52zLpf9SeQnbpJhuQ8Qu8lgKtA==
X-Received: by 2002:a05:6102:4187:b0:472:e88d:6839 with SMTP id
 cd7-20020a056102418700b00472e88d6839mr4628840vsb.3.1710194373568; 
 Mon, 11 Mar 2024 14:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbnSImJ380TOrwkmT2l3GIUpyxYn/MMIhuun7lyslKJ+TgvEM6Sn10ZLMcXrpE7YCWdCiK7g==
X-Received: by 2002:a05:6102:4187:b0:472:e88d:6839 with SMTP id
 cd7-20020a056102418700b00472e88d6839mr4628823vsb.3.1710194373097; 
 Mon, 11 Mar 2024 14:59:33 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:32 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>
Subject: [PULL 04/34] migration/ram: add additional check
Date: Mon, 11 Mar 2024 17:58:55 -0400
Message-ID: <20240311215925.40618-5-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

From: Maksim Davydov <davydov-max@yandex-team.ru>

If a migration stream is broken, the address and flag reading can return
zero. Thus, an irrelevant flag error will be returned instead of EIO.
It can be fixed by additional check after the reading.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Link: https://lore.kernel.org/r/20240304144203.158477-1-davydov-max@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 003c28e133..2cd936d9ce 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4214,6 +4214,12 @@ static int ram_load_precopy(QEMUFile *f)
         i++;
 
         addr = qemu_get_be64(f);
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            error_report("Getting RAM address failed");
+            break;
+        }
+
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;
 
-- 
2.44.0


