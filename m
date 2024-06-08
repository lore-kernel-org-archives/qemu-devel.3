Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5193DC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXY-0000fZ-Nl; Sat, 08 Jun 2024 04:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXX-0000fE-2m
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXV-0008WA-K7
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjEoegWfDNY+Lc7QINoZm6Kl3jY2Ro+dU3R8pgO2/MA=;
 b=HEr4nD4Ein4CiqnW9uOpqlEO1cgCIxhPvsynGFn6a76FAj0lXMIDY48y/YoaApHpah8NsS
 QyUrNj/GVQoMKTgn4c/7nJmmPwqPpFwA5+kazugrBPVDOo5FaBy+aAWd0FcdTfNRbKlkEa
 ObCYuSIIWDrGSaf0T1760oPSd8ABGv4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-KCklGU2yPdSqA6QTS-gLGw-1; Sat, 08 Jun 2024 04:35:03 -0400
X-MC-Unique: KCklGU2yPdSqA6QTS-gLGw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f0f008f9aso2312966b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835702; x=1718440502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjEoegWfDNY+Lc7QINoZm6Kl3jY2Ro+dU3R8pgO2/MA=;
 b=IzNzoniVQiHp++7g4rORG8xe0relwzPQTTTx8v7iTL2Zp1T9CTb18GXJevda6TVXQ+
 ESGZC0V5Imo0HuMJ3qm2UQo9J/pf02vA1PSJd1VVmNrHp7ErxxuB47dBd061uBBKxr7T
 dhuyuozA9ng6eYNeDEe/soMLK24EXMlBGLz8qaIJgAqL+a7TaXOq0prevY/fYEKt5+42
 9Dz+qzQMaKK++UI03m+jq+8llAF8/mpm3oBa3fiy7VHxa95fZ1qUM5t/EXVxw871PjzB
 SQy6EMt3gOxYw7L5XwyieoYaZaioN9kr2dGvXC55Azt94VJx0UQ86DOHOJPciFh3YDXQ
 QIlw==
X-Gm-Message-State: AOJu0Yzn1udg0+ZLdYcWxS/j8hqNheBfKEEzbCdxnJwF4+3LErtTHpHt
 S3QgpeNUgdsw+AgWn5W3IjIj4dKnChlEwLyJd81hPDI+C1+k+W1pmpnhs/MeV1OnUcl3/VFdtuo
 bBNR8e9+a2ZFRiLBy1OjuuF8p7F6daP7JZhGGeR6u/CFmr9wGs0ZAy4v80Fsz8WDzlr5mP+KvB0
 ECjgG2dRSUhIY0zEaHDLgKwosZ3ZTL8sCUfePh
X-Received: by 2002:a50:9550:0:b0:57c:5bdd:178d with SMTP id
 4fb4d7f45d1cf-57c5bdd19acmr3048200a12.6.1717835701806; 
 Sat, 08 Jun 2024 01:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6C5KTAHB0MulmqpcXAQBmnvfiPQ2QVFcnjYKTDgC/YwOpWYZeAmnIKNxchFDM1xawiPZcsg==
X-Received: by 2002:a50:9550:0:b0:57c:5bdd:178d with SMTP id
 4fb4d7f45d1cf-57c5bdd19acmr3048184a12.6.1717835701495; 
 Sat, 08 Jun 2024 01:35:01 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae202965sm3974372a12.77.2024.06.08.01.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 16/42] machine: default -M mem-merge to off is
 QEMU_MADV_MERGEABLE is not available
Date: Sat,  8 Jun 2024 10:33:49 +0200
Message-ID: <20240608083415.2769160-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Otherwise, starting any guest on a non-Linux guests results in

qemu-system-arm: Couldn't set property 'merge' on 'memory-backend-ram': Invalid argument

Cc: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 77a356f232f..a0ee43ca5c0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -17,6 +17,7 @@
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qemu/madvise.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
@@ -1129,7 +1130,7 @@ static void machine_initfn(Object *obj)
     container_get(obj, "/peripheral-anon");
 
     ms->dump_guest_core = true;
-    ms->mem_merge = true;
+    ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
     ms->enable_graphics = true;
     ms->kernel_cmdline = g_strdup("");
     ms->ram_size = mc->default_ram_size;
-- 
2.45.1


