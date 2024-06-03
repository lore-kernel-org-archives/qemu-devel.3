Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E125AC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Tl-0000BH-6Z; Mon, 03 Jun 2024 09:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Ti-0000AK-Gm
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Tf-0005j3-Iz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717420313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5owbhz2WQol3DxPAYYlnJH90VodwM8bU2nN3YGvfIjo=;
 b=Jl1RUtRn7YeaFIqvFxSzFCXqRR4XTnymAKrXLywjWbGl/SjVn+2H9woKAJvy4ycII1HQu+
 sj2ZvloYuoapCLDBCRtl7EcN2mqKaWlF7MnkkupRlLHD0Ndbn2tUz504vBxl72A9sqff4C
 Q04CxlPN8UQr+w/2T4p9aq1K6BENAf4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46--tWpTLG9Nju5SX51ASwFTw-1; Mon, 03 Jun 2024 09:11:52 -0400
X-MC-Unique: -tWpTLG9Nju5SX51ASwFTw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68ce57fb14so87241066b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717420311; x=1718025111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5owbhz2WQol3DxPAYYlnJH90VodwM8bU2nN3YGvfIjo=;
 b=vpgWOoa6aNtRgMoFyD/b91+oCq4EYwJXVSRyDl3n7QQYZOfBrrQDMtKXHThBVl6lFP
 O0JEojHk0KMF8cDXFLmps2rR1T37yZgTT9p6e6AmvTPi0EkvipvWa7jKjZ/bryUIQmRV
 bUzixxADzADxuRPgdCGBRl9hS0SB18Cfg1khNVtYtPduQsxlDG55xb5D7Uv1WT9Palfo
 BOhHXnhpnvmWc9LcQ9hPBXZPC6QnI1ZegERlAjjTEuc7zKahFu5Uawss3xpSsSu/j0Ko
 BFhS0bUpCz+IAKMwUvkW4MjwXto9K4n4qVrTE2z6uJgOQvgq9eW1gIadpmO3EHP2QfhV
 bAvg==
X-Gm-Message-State: AOJu0YyOgnBkMhXT85rqi7ky9LkldLkDOU4PSrZxmFh24DXQdLWpUIMy
 Ll/Nj3n3C8yxt/S0xmt2Gs+yeL3TK9TN+oP7LyIPnrQwsAtd/1BKYZ7mBJ9zAv0ASmYisxXvFN8
 JI1W8XNzb/ootgSLixh4kRy7RkcCN2wgc6xQR8Ymv7HtdZLvAs6Rb3xrgT8HiKieYFPWsI4zBcK
 TpjqQp4UfgwKIV2TXXLMhUaAY89yCJsUr8rbc4
X-Received: by 2002:a17:906:a90:b0:a69:edd:3339 with SMTP id
 a640c23a62f3a-a690edd35c8mr159128566b.10.1717420310773; 
 Mon, 03 Jun 2024 06:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2VRvtp93tGzOLFf2wTo3xi3rWLyaX5HdVGZkWFMEVzlog42Vgdn+ICwoNzmLiAR9d5anpQQ==
X-Received: by 2002:a17:906:a90:b0:a69:edd:3339 with SMTP id
 a640c23a62f3a-a690edd35c8mr159126566b.10.1717420310317; 
 Mon, 03 Jun 2024 06:11:50 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ce706436sm293420066b.119.2024.06.03.06.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 06:11:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	cohuck@redhat.com
Subject: [PATCH 2/4] update-linux-headers: move pvpanic.h to correct directory
Date: Mon,  3 Jun 2024 15:11:39 +0200
Message-ID: <20240603131141.834241-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603131141.834241-1-pbonzini@redhat.com>
References: <20240603131141.834241-1-pbonzini@redhat.com>
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

Linux has <misc/pvpanic.h>, not <linux/pvpanic.h>.  Use the same
directory for QEMU's include/standard-headers/ copy.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/{linux => misc}/pvpanic.h | 0
 hw/misc/pvpanic-isa.c                              | 2 +-
 hw/misc/pvpanic-pci.c                              | 2 +-
 hw/misc/pvpanic.c                                  | 2 +-
 scripts/update-linux-headers.sh                    | 6 ++++--
 5 files changed, 7 insertions(+), 5 deletions(-)
 rename include/standard-headers/{linux => misc}/pvpanic.h (100%)

diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/misc/pvpanic.h
similarity index 100%
rename from include/standard-headers/linux/pvpanic.h
rename to include/standard-headers/misc/pvpanic.h
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index ccec50f61bb..b4f84c41109 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -21,7 +21,7 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
-#include "standard-headers/linux/pvpanic.h"
+#include "standard-headers/misc/pvpanic.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicISAState, PVPANIC_ISA_DEVICE)
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 83be95d0d24..4d44a881dad 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -21,7 +21,7 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
-#include "standard-headers/linux/pvpanic.h"
+#include "standard-headers/misc/pvpanic.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 1540e9091a4..80289ecf5fe 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,7 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
-#include "standard-headers/linux/pvpanic.h"
+#include "standard-headers/misc/pvpanic.h"
 
 static void handle_event(int event)
 {
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index ae34d18572b..7b39cc426e0 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -231,10 +231,12 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/const.h" \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/vhost_types.h" \
-         "$hdrdir/include/linux/sysinfo.h" \
-         "$hdrdir/include/misc/pvpanic.h"; do
+         "$hdrdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
+mkdir -p "$output/include/standard-headers/misc"
+cp_portable "$hdrdir/include/misc/pvpanic.h" \
+            "$output/include/standard-headers/misc"
 mkdir -p "$output/include/standard-headers/drm"
 cp_portable "$hdrdir/include/drm/drm_fourcc.h" \
             "$output/include/standard-headers/drm"
-- 
2.45.1


