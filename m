Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47980C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPS6-00077n-F3; Mon, 10 Feb 2025 03:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRj-0006Ou-NH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRi-000472-BY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFImN/HdVJsdxlU8bHIXd3zfUtn9U7Os5n4jpooO1h4=;
 b=L6vgEqWt9suW5et2qRZudO2/EpdSDvQqiFgsMOiHmvOT0JCHx3ZWbrr4VPojdM45BflG2s
 6dAoowmrQgfBQaEzKPD2Sd4FNY6JNGPxqp1vUs+K5bokeztmx3udRkAnmqchVyECroLxxs
 cBLiwFxz2ijvGUupmPrNCLuNI+aSDnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-tXl5K-DHMKGwoYwjt24K4w-1; Mon, 10 Feb 2025 03:47:11 -0500
X-MC-Unique: tXl5K-DHMKGwoYwjt24K4w-1
X-Mimecast-MFC-AGG-ID: tXl5K-DHMKGwoYwjt24K4w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43942e82719so5093255e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177230; x=1739782030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFImN/HdVJsdxlU8bHIXd3zfUtn9U7Os5n4jpooO1h4=;
 b=wqmjF0wPTxX0uV0ooEHLN/zxThwJWtod4yj9cOtwKiXhnSs7kwvwonDHjVmqCZ0c76
 6x7inJ0VlrmDUefYmW4H9aInlrC/QomGw3Y5ouVzOI06k0qciNBI+QlA7A8fh4+TjQIi
 ntVtNMgmT+UsU2bMtOOztdKHX2HDofXbQ7IT85JjBrYn8+7VoBdFYI9BDCSrKDY+/05n
 ZXJO/opTPv8MJHNFUQSN+m88L28vco/fllW/I6a7zxKcLWYn9JyE0FU3tRCBTbw2cSX3
 1UrGUxDgkJMJGzBy4RFFvzBfMvFZMzLUKHjzqkEKda5GFWCs6Scncq9a1KMU/Pm5QrlY
 gftg==
X-Gm-Message-State: AOJu0YwnSH5uTBEC8GERC2WKf29SgDp5WZLt3LFkqpsoInn2JtsWLTy1
 vcHE77StlwvcR9t0t6hw8StZoQARSUzq/EzfPkqsp8XaxsOApi2tA3ALq3VgxUEVQGb8dibUtoo
 qhxGjd0+1LXzkW+VwJpe91HFRIz4+KlK0AoLhM7O4iXR0/RpXGh9CjwkB/8uBYULDgpj5Nwwmsl
 b6zBg9VmLuLzCDWMVP9vYaSbcMaIsqd6hY
X-Gm-Gg: ASbGncsV7fxmWJGa057fXLDB6NdjIaHlHeILwldgPbvS0pO0a7yROltJ7/p2UFCwv0p
 9XB6nkBldIn99nLeAzyMHGbEqbm4pGuJ1MFklRikxOhdzN7XgUSJokYXKa+GKzI9xjNBLxHlWe4
 ha8ZLOCOTMPP6/GeUxRx80U9ZQs/0kodKZyc8a0QhfPVvyVf0vhZw1sdjlKYNdZFq/3sqRz2wd8
 8JKAK4w6icSSczY9LVnDYQJWoypOqtK8+xC6lmsjCLmHsrH3+1YyxheqjzTS9B9kbI5F/lwFP/e
 A8H7aSYmg5BPQidhkSll64NIBi3+qa/A4HaAX0+DaAsx3O+raHPOUkDZ06RQRi/O3w==
X-Received: by 2002:a05:600c:899:b0:439:3d5c:8bfb with SMTP id
 5b1f17b1804b1-4393d5c8d77mr33969245e9.22.1739177230383; 
 Mon, 10 Feb 2025 00:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp6UWtq7vu5blmjXrPLaNFKPaZZqzIQyhYVtaxoENvz2WoRKjzsgyLFLSoQ2ACPzIa/RpknA==
X-Received: by 2002:a05:600c:899:b0:439:3d5c:8bfb with SMTP id
 5b1f17b1804b1-4393d5c8d77mr33968965e9.22.1739177229993; 
 Mon, 10 Feb 2025 00:47:09 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4390daf4480sm173550055e9.27.2025.02.10.00.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:47:08 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v3 6/7] hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
Date: Mon, 10 Feb 2025 09:46:47 +0100
Message-ID: <20250210084648.33798-7-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

We don't need the MemTxAttrs, so let's simply use the simpler function
variant.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 monitor/hmp-cmds-target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 0300faa8a2..0d2e9dce69 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -301,7 +301,6 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
     target_ulong addr = qdict_get_int(qdict, "addr");
-    MemTxAttrs attrs;
     CPUState *cs = mon_get_cpu(mon);
     hwaddr gpa;
 
@@ -310,7 +309,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_page_attrs_debug(cs, addr & TARGET_PAGE_MASK, &attrs);
+    gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-- 
2.48.1


