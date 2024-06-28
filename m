Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E5C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPY-0005aP-Sk; Fri, 28 Jun 2024 13:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPT-0005ZW-6z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPR-0002B3-Rs
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrycet3jL1WSrURyl4kYUHh4gIffr2JcIs+cSDvgvbc=;
 b=R6bl7CxkWyeZrCiOWI06SJOs8JvPz3sBDcY/ry36JUKmjg6IjGx6YUGCrp+gCBXqY7rljc
 ldwFUtkuEMrVzCt4icAlvRA+4PG2/S1SHwQFWZf6HgG7wkGQSJdJnZ1WSYAK5kfmnDnjVl
 lHtni1MROkC0C1HUFfsA5MLGNvzEki4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-VEGTQrC7Np-G6hkKg-XF1g-1; Fri, 28 Jun 2024 13:29:14 -0400
X-MC-Unique: VEGTQrC7Np-G6hkKg-XF1g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7246c24b00so60613266b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595752; x=1720200552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrycet3jL1WSrURyl4kYUHh4gIffr2JcIs+cSDvgvbc=;
 b=kedmopj+mQ+rHv2pKNlTVFDp28mwyx6ZJ4Pd+JDB1dcVwv+cPKWQZMUZdVZrHNCsFO
 jlnJcMkojNWde2XAZkGFzqaGFMRTp7cakTT4IH/SOSN/ZVcbqe5T7FSz955AX4r7CVXt
 4ete8dmImEsIzVmZGxtV+vikCHmUpezzxsbX29cklxu3DAKqny4TLgUJkd++mQQ+RDIQ
 CVG3vBnqN6v4jZV2HoF+uoTODWZd/AWUJ8ypToOrt8VB/WOdClBgHNXNz9dIeBQl9wmg
 BBS6ovAhxDvzeKTrjH9ePI+99YPQlYZdVjs2zsgfGTaVZFy2hGmQWV8Q1O/t7vUyrIHL
 iVxw==
X-Gm-Message-State: AOJu0YybXf9NrHHv8n2qWnG9xFeFnEuYiIi3hge+C3hlzl+AaTrxLEi7
 L8VIKhQRn5bBnUo8I41yPAEcxROlNz25W/VG647qfg+b/ifWGRneqI+xxppLj7GtRfl8WdOd6e5
 ZWpxlKjoHxNC9NclNj3B8IBO5cYzZIYEy2GB+NKFg0AbaX7+pIX5fYdjYR9zKXFiXGn3V+3FSxU
 n6Hz7Iwzly9HjgOMUSc7XiteV9VIWOoew1odyT
X-Received: by 2002:a17:907:a709:b0:a72:8a0b:9ba5 with SMTP id
 a640c23a62f3a-a728a0ba5f6mr758861066b.54.1719595752713; 
 Fri, 28 Jun 2024 10:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDjDkUflzZxcA71Z5WcNR6icVZeEH16WRvJ6Bv0LppHSA4QooULAB0rLE9Ld9YvEHGbLpjBQ==
X-Received: by 2002:a17:907:a709:b0:a72:8a0b:9ba5 with SMTP id
 a640c23a62f3a-a728a0ba5f6mr758859566b.54.1719595752310; 
 Fri, 28 Jun 2024 10:29:12 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafba2cesm96613466b.93.2024.06.28.10.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] block: make assertion more generic
Date: Fri, 28 Jun 2024 19:28:39 +0200
Message-ID: <20240628172855.1147598-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

.bdrv_needs_filename is only set for drivers that also set bdrv_file_open,
i.e. protocol drivers.

So we can make the assertion always, it will always pass for those drivers
that use bdrv_open.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 468cf5e67d7..69a2905178a 100644
--- a/block.c
+++ b/block.c
@@ -1655,8 +1655,8 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     bs->drv = drv;
     bs->opaque = g_malloc0(drv->instance_size);
 
+    assert(!drv->bdrv_needs_filename || bs->filename[0]);
     if (drv->bdrv_file_open) {
-        assert(!drv->bdrv_needs_filename || bs->filename[0]);
         ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
     } else if (drv->bdrv_open) {
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
-- 
2.45.2


