Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A73C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAk-0001lj-UZ; Mon, 06 May 2024 03:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9x-0008Jf-PI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9t-0001nz-P7
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx3cqDAGG/FUVVIhy0ip+ac1LgAXvC3VwS8/rT+0MBI=;
 b=FB4u42VFxOTlbkbjSJLVymUYzBmKijTpFsvo/ooi3DoTXwad4J+CXTH+2nGdl48E1ftaGo
 J7HzQCsaGkmd3nBkJL6YmcYzl0vjDd7/ibWWmrzWUsATl5AyVxpzR+xzsdnCdPF1L3I81V
 PiqobrprmmQ/WXNQ29k8m11Yk2Nduvk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-_XiwniApPouKA-YoDNLV1w-1; Mon, 06 May 2024 03:53:10 -0400
X-MC-Unique: _XiwniApPouKA-YoDNLV1w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59bfd32b8fso71385166b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981989; x=1715586789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vx3cqDAGG/FUVVIhy0ip+ac1LgAXvC3VwS8/rT+0MBI=;
 b=CcpmVhyVkoqpdPhG4eA1GiKazHK0hYKYbxv5uX6kzp5xtfxDSHyWvyEstDKkXcjhhe
 6I52dwkEiEGD8IlqVXW/Y2G10p5t1UvPwGTNkwivyfU/cgLVDXOCHiRg5q+0S32ArSus
 Fse32eG/T1ipyRslHuXAz9gKV41Dd4cSM65XgYLWIVxu2bLfJsY/UrsvOuxyNKBo7jQ6
 YxPqYOSbHHEpITeiDyzcGCshut6vsRKMLE1PsJtvTpe08wL4j1B22tpRDHD0FBH+AIVJ
 9C+jtr6XB8/Jbu7CdqGZptn+y1UBHyxAKfqFYjdSXllMlyb8Hd38V1gKOhAzF9ijrCoU
 6QqA==
X-Gm-Message-State: AOJu0YyKd+7UxIzLIIKgk2mzxYJ8ULTZKhnI9WzwtPa0i7l+5DNhyeGw
 4CjinHLSBTVo4c3D/jQLEuzLLw0KaOPNeyImXY90L9BT0l2LyBAtFWLYB1EwMjtv0/gIVXrhbMI
 IfnEEfG2+uZkdsst+V5dsDx0zwmd4DmAERf1S3npi3bsZ12BHvBR2gRFYtZcOIbFa4/hXkBY3Wk
 PmliISoXmwYwEWY0k7/cqRETHQDJlmLHUDYH8v
X-Received: by 2002:a17:906:2bc4:b0:a59:adf8:a6d5 with SMTP id
 n4-20020a1709062bc400b00a59adf8a6d5mr3235870ejg.72.1714981989420; 
 Mon, 06 May 2024 00:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOFmjkT3cSnAj5zlggx2UCg96ZnxgEm6Q5D4mk7hv5lJ9f81m2ESqCzxSYoHP+mIZsNeAbsg==
X-Received: by 2002:a17:906:2bc4:b0:a59:adf8:a6d5 with SMTP id
 n4-20020a1709062bc400b00a59adf8a6d5mr3235855ejg.72.1714981989000; 
 Mon, 06 May 2024 00:53:09 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 rn9-20020a170906d92900b00a59a229564fsm3009364ejb.108.2024.05.06.00.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/46] display: remove GraphicHwOps from typedefs.h
Date: Mon,  6 May 2024 09:51:20 +0200
Message-ID: <20240506075125.8238-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Basically all uses of GraphicHwOps are defining an instance of it, which requires the
full definition of the struct.  It is pointless to have it in typedefs.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga_int.h    | 1 +
 include/qemu/typedefs.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 876a1d3697b..f77c1c11457 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -25,6 +25,7 @@
 #ifndef HW_VGA_INT_H
 #define HW_VGA_INT_H
 
+#include "ui/console.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 78598f27f32..7e3597e94c5 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -53,7 +53,6 @@ typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
 typedef struct FWCfgState FWCfgState;
-typedef struct GraphicHwOps GraphicHwOps;
 typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
-- 
2.44.0


