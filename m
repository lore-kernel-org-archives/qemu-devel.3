Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ED1C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YlP-0001PZ-15; Thu, 02 May 2024 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl9-0000x7-Fm
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl7-0002Ob-Cv
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtBhkmkXIzApssHVLlGMVUZMyVYQcct5zCRdK4CsSCk=;
 b=Gf4MGDLeiKfhfX5CokziMuEd3yvFJPhYKgWmmOMctOL+THFJD1evqFX5/cZ3keaKWAI8fY
 mL4AY8oBOsFp+Aqmz3ZVxSg6+rbx6y+rl0EzHNubnP/cue81+t0xqTCJOqTfBWrAAeXE2L
 pK89X1oQ7j+WzlS2symNmDLDmNMm5VA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-tQaaipzpMgaB4uQl_aSkig-1; Thu, 02 May 2024 11:54:04 -0400
X-MC-Unique: tQaaipzpMgaB4uQl_aSkig-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a58d2d13937so194968866b.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665243; x=1715270043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtBhkmkXIzApssHVLlGMVUZMyVYQcct5zCRdK4CsSCk=;
 b=VzivnNW4ihGLhmjmdhnVv77sIm8Ucr3QZtQhWgmdIu0GIjE15yIWuNANIZfLxL+DXh
 hT7g9KFkY5ENR+D7Xgf2mqj63pRIdzYiR78L01+mNw7ALrxjPJ4cqMR61nMNOiV8MLGC
 MRRRxJowwiLUjzVTFngjEZc4pq5LXiK5vI/+VdEyGGYEoSWQ2DRkzL6EM190oInqA8g3
 QFlOk2a6IteJa95vsZzyqK5GxqC3j2DKIIhruB4GkyQg0WIx2f3mBJqQEWVjNVe5slcU
 IKSroF3vh+GDiiULOntfjLFUQSiik2AUBkdIc45LIDttEZUc2m1zifoxkriSZLPco+TW
 U9yg==
X-Gm-Message-State: AOJu0YxQqoswPdzdSDCF5WYG5xHVgvLjMpIAZgohN1Ys3707vkLBh0px
 5QOqG4ZBbdfLkpK0s4XpY0fwwlDmKkWgjnkbFRQSdNlWAwibP7QrTmeOPpdLpshwiRZSAO0ijRV
 7DToz6ylt61bdLeFeo1CJmHpDFEvtsPjfoI38UYvK+GJ8zzAiI8j5p7NNMi0nFVpDAmErO6rwpr
 iZV4KeV18cUKYsRpNwIVG/U7VzBUSoRktRohXZ
X-Received: by 2002:a50:aad1:0:b0:572:689f:6380 with SMTP id
 r17-20020a50aad1000000b00572689f6380mr5181856edc.3.1714665243239; 
 Thu, 02 May 2024 08:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3fMzml2XGHmHQHsuK7d5oOdr2YwshJ3w5WHo5ccPlaqweuyij2bR6VrhziKlFFhlac3uLCw==
X-Received: by 2002:a50:aad1:0:b0:572:689f:6380 with SMTP id
 r17-20020a50aad1000000b00572689f6380mr5181838edc.3.1714665242896; 
 Thu, 02 May 2024 08:54:02 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 el4-20020a056402360400b005725ffd7305sm646956edb.75.2024.05.02.08.54.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:54:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] display: remove GraphicHwOps from typedefs.h
Date: Thu,  2 May 2024 17:53:29 +0200
Message-ID: <20240502155331.109297-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Basically all uses of GraphicHwOps are defining an instance of it, which requires the
full definition of the struct.  It is pointless to have it in typedefs.h.

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


