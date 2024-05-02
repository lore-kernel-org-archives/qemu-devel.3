Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07114C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ykt-0000sH-CS; Thu, 02 May 2024 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yki-0000nH-1r
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykg-0002KZ-Jo
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9KEt6XMz/3aDUxWpJILF4vs1Zn9/lFwOUkcNdsMxQM=;
 b=e1q6ybL3Lh8SCnbUH9QWt6uAJ24LcSJ/3ll7JJ8DuTpL476Y46AORMD0vy2NUuTQEt9Ffw
 mugTAz4zwutEoRIa+lvhMepPX/iMchzP/LuqATk5FjfmQNr7ucKwkGWdzYiKI2Ta4FDIAW
 uY/P0a+2BB/Jx79XjwkTONAyw2U3c+k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-xno0mZL-Ov65lm19mKQk_Q-1; Thu, 02 May 2024 11:53:40 -0400
X-MC-Unique: xno0mZL-Ov65lm19mKQk_Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a598111be0fso7233066b.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665219; x=1715270019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9KEt6XMz/3aDUxWpJILF4vs1Zn9/lFwOUkcNdsMxQM=;
 b=BUZmvpqCmTS/zOt50T/scKOipEr3uPrVETyJalhf2ZDRx2dMcJagWi2Tn/k73R4Xpm
 EHE5diHgEJu48KXWoAiZng1r4SH77qab7mvoPFGrOpBvg9xHUDR5YxINHgD+flNCEInR
 ZEh6Ay18QyQCEvl3Mzrik5qP29gqQ4aqA1jKVdX5U8pRt8oh8wpHinWlMe0kYJR2PM0/
 7ZgQmfaMa1cpQdN1gklumrBRypkrJTKonJ52ia+OHI8hoXVToMS6JkRZfsz6D1dIKcd9
 8NOY0op+Kw6lbXshOXvhX4za38BPvyI8jPiMQe9CN21YSGvwuQgLpiMMUmAcasH85gf/
 BOFg==
X-Gm-Message-State: AOJu0YwiEOLXN3eSUmk6l48Rln5KtR+N/WaciogJY6SXgoegbUC2BzeR
 fjY0dV/jMaNw09u8ldU0jS6wNhVpZwyaT26ieeEPXZHod5HfG+YPVUzso3AJmf2cKxe/KnRH/+6
 NZYgomIgudW3wMB4CQ7IovB3kwyJlzcQqaOSL0XjA7BdZbVQBY2pXFJwClRUGMqgZL3Y/SzNmXk
 0aZO+NZKX7WimEpjVoP0N7lymaGknX4RvJNJT6
X-Received: by 2002:a17:906:64b:b0:a58:eba0:b358 with SMTP id
 t11-20020a170906064b00b00a58eba0b358mr2138380ejb.53.1714665218745; 
 Thu, 02 May 2024 08:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyD93xJaJB8LxSgo67g39VaLDzkRn1yB3azhiICnIgXTEJnqWiNw3eHeOkhF341MX0uqyiKg==
X-Received: by 2002:a17:906:64b:b0:a58:eba0:b358 with SMTP id
 t11-20020a170906064b00b00a58eba0b358mr2138367ejb.53.1714665218382; 
 Thu, 02 May 2024 08:53:38 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a17090617c300b00a51da296f66sm694485eje.41.2024.05.02.08.53.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/13] qdev-core: remove DeviceListener from typedefs.h
Date: Thu,  2 May 2024 17:53:20 +0200
Message-ID: <20240502155331.109297-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

It is needed in very few places, which already depend on other parts of
qdev-core.h files.  The benefit of having it in typedefs.h is small.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h  | 1 +
 include/qemu/typedefs.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9228e96c87e..5336728a23f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -294,6 +294,7 @@ struct DeviceState {
     MemReentrancyGuard mem_reentrancy_guard;
 };
 
+typedef struct DeviceListener DeviceListener;
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 949d3e1daf9..66f0b146c8c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -47,7 +47,6 @@ typedef struct CpuInfoFast CpuInfoFast;
 typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
-typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisplayChangeListener DisplayChangeListener;
-- 
2.44.0


