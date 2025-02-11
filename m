Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF0C021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6K-0005iq-OA; Tue, 11 Feb 2025 17:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6G-0005gH-Eu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6E-000566-2E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ML7ApDFrpE6LdiaKUIk8tOpXVHTwr8mMl/oUpLjQuwc=;
 b=h31ymj82qf/0iLuLg4fcmwavHFZpVt7+ag9eezqLFh1AugolB3X9UkxffWj0wt6NrZtbAn
 WvBMJBrXnOXPB+DrDyxIr3on+qVM0kBR9mlRQRLSYg6k42ouy+RuaZFFnwqQ9l2wf8RkLR
 2AiO1eertjSTMfILt37l6O3VmGDvY5M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-S5ASt57XOhOVO6RL0Hv4tg-1; Tue, 11 Feb 2025 17:51:24 -0500
X-MC-Unique: S5ASt57XOhOVO6RL0Hv4tg-1
X-Mimecast-MFC-AGG-ID: S5ASt57XOhOVO6RL0Hv4tg
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-726d163f945so3620398a34.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314283; x=1739919083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ML7ApDFrpE6LdiaKUIk8tOpXVHTwr8mMl/oUpLjQuwc=;
 b=sH8DO4umCHptzmo7ECq2c0TEL7AMr7vmirS7+gckGlYz3Znh7/DeXeGIJy36CBeDZW
 jDqrBafwrwz/CYqCD6qR46M1sEWQB7Dt0Mr8ZLJqc9swb1nYe/vy1D793dwdb+MAmY9j
 9EpyV8YSVrjSLeqXEPoXa8Nclpotdrir3MhTvZjPjYEgMGvvKylT/0RpjCiRi8sC4GZD
 lrqCWa+oMEbIIcpg+o3R4Yd6PW1CTJ8KF4j96+v03s4DUOWFuziZVNv/4C5cP1h9dzVv
 Ua3nCdcajMDQpguXib6x66zZNr6vdyRDGeh9xuDlPKYGq7ODjiX2l0uy2db1ms8KQQHa
 uZ0A==
X-Gm-Message-State: AOJu0Yw3/drTI2cfX1PkwHc1kt3gokF280Bi+n0XChy9m0DnpJhq6gE+
 UKhb1P77cKInbtLmYjGL6U4QH/tMhT3scQoy6Dozu00K9BwnQ/memdPwQRg+GFd0pwQUnr7Lc8v
 1IEGkKrmaNlJHgpfKVPEXDsRcZQl9yBxaz6RBV42QqUK2d3LzeL5nchudYAE6mkW1gs8e/hBBnr
 keukne0AIsMOwtGUcM52uqNmrOFNdvGQUr5A==
X-Gm-Gg: ASbGncvt1EmP3gYjBsFArY/68s1mwMQ1DlTh20U7BH03rcKNBhAjHN9OUdoajufIHLI
 lTPYFXP+OhF80SzwyFt+pAvcjLg7cox0E9pKjExbfXLPcIHXMU+4qyiRZxcnIYgALWGSCtRHcn4
 9VRIIQh0pX+PLGA6ZkUFF4b5bPHQ5u0QyfRVIzB5eTdNLHgQRiHQX8nvqzErIFpsJUmbCpA/suF
 hy3gjPztKBaxPRYcTq55EJoe7In7/VZ3XBT8MnphCsgTbB/mAqeioHE
X-Received: by 2002:a05:6830:6483:b0:71e:7e4:c54e with SMTP id
 46e09a7af769-726f1c33b3fmr818457a34.3.1739314283086; 
 Tue, 11 Feb 2025 14:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6fL7Pyjhd7ZDtPaoHijVGa0J4q94S5Nxr8WauUHU94TAZlVZS6xxzABtBGgymiCaNBnVDEw==
X-Received: by 2002:a05:6830:6483:b0:71e:7e4:c54e with SMTP id
 46e09a7af769-726f1c33b3fmr818437a34.3.1739314282746; 
 Tue, 11 Feb 2025 14:51:22 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/14] hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
Date: Tue, 11 Feb 2025 17:50:55 -0500
Message-ID: <20250211225059.182533-12-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

We don't need the MemTxAttrs, so let's simply use the simpler function
variant.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-7-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor/hmp-cmds-target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 27ffe61818..239c2a61a4 100644
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
2.47.0


