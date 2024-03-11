Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDBBC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngK-0000CE-9O; Mon, 11 Mar 2024 17:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngJ-0000Br-8q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngH-0003yV-Jv
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+T3rLu53eP93SiwWxcECCKMxAP2DCTkljq+aiGvFxI4=;
 b=eG4DsXcTzLsvxqRRjuq6qNahxiUlKXP4LwpQOEf4uAVUtlmw9kMeRIyV0lQTF8wvdTZlqu
 T6WxPo0fx2Hm64J+6Tnn3qKGmuVTaVazlTsY0LppQeysxLYGQVOibgytNlOwa72m7nRQGj
 mp6FPdzLVPnptU3Eo7sXs27lzrLGPUQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-N8TqUTR0PBqkrixC9m3SUw-1; Mon, 11 Mar 2024 17:59:35 -0400
X-MC-Unique: N8TqUTR0PBqkrixC9m3SUw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15026526d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194375; x=1710799175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+T3rLu53eP93SiwWxcECCKMxAP2DCTkljq+aiGvFxI4=;
 b=A5qlU0MLO1ZTuXzwFve0nY5vnvtW1dcSPWS6PKW7LGUq6eHGfvAPNRrDDsqpdCvyQ5
 H/5NorgPJiffJ0+OiAmfCeKrY62zgyGBMsxy8jf+x+VeMFQyhaDakIWUoLdvR1Vplx5t
 gRifCvntyX1tAulbq0Ud+4V4giRJAGYkoJc1blIfs3LGkmfZ12oGA5Swk3FI65GRdqCU
 9FSuSTi8iC+lg9H9U/rptaINEa3CYgXvFj8c9PKyM5ksiJ0iB63iS0I+U4ojQgARW1O1
 FJ84G3YB/aN/zBLB3MywM+c0GJrD/PI4xh/9W6MJ2k42YCcnaSM/Nhk/2q9z1YJc3jhy
 BqJQ==
X-Gm-Message-State: AOJu0YyuymR+a5Lnxindr2iDk4vHuKSdbqUQdDwBub7+Vd/VPN9ZIsw+
 gnznnPAeECWsjA0SS7mhqfC9eHI+LEy2HmJO/Or3ZMxDNaQNKgBP1jKNF0eNcuSz0GIi2Ej70kc
 lLUR+sBD3R4oZZAJ78ej2eImwVbY+cGc3NYun1raX9DUhiTzOcIPybDnpf8SqYQ6JrcsEj+C2dS
 g3yF7Wfqjn21knYKrP+r0M1dTJprY9PaS0uQ==
X-Received: by 2002:a05:6214:4c11:b0:690:de72:316f with SMTP id
 qh17-20020a0562144c1100b00690de72316fmr1714533qvb.1.1710194374883; 
 Mon, 11 Mar 2024 14:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFledxb02XIcVimWBw7Swd7/bBA4koJR+YAws4GER3eGEKY5lu/AlbFGVIb99KYWEIsDlC6Aw==
X-Received: by 2002:a05:6214:4c11:b0:690:de72:316f with SMTP id
 qh17-20020a0562144c1100b00690de72316fmr1714509qvb.1.1710194374437; 
 Mon, 11 Mar 2024 14:59:34 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:33 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/34] migration: Report error when shutdown fails
Date: Mon, 11 Mar 2024 17:58:56 -0400
Message-ID: <20240311215925.40618-6-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cédric Le Goater <clg@redhat.com>

This will help detect issues regarding I/O channels usage.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240304122844.1888308-7-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b10c882629..a10882d47f 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -63,6 +63,8 @@ struct QEMUFile {
  */
 int qemu_file_shutdown(QEMUFile *f)
 {
+    Error *err = NULL;
+
     /*
      * We must set qemufile error before the real shutdown(), otherwise
      * there can be a race window where we thought IO all went though
@@ -91,7 +93,8 @@ int qemu_file_shutdown(QEMUFile *f)
         return -ENOSYS;
     }
 
-    if (qio_channel_shutdown(f->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL) < 0) {
+    if (qio_channel_shutdown(f->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, &err) < 0) {
+        error_report_err(err);
         return -EIO;
     }
 
-- 
2.44.0


