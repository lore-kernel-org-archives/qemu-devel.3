Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF573C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9h-0007VE-L8; Mon, 06 May 2024 03:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9c-0007Fu-Js
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9b-0001l9-48
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNUmdwMafGjlAD1dD5b/rKg5wI+EEX021CPgKZXxVh0=;
 b=YEf1veEC9dpLLQ6zbFbLU0AbF1ABy5Rrykz4wQdeQRZCjc3kyd/J0oDDXqvjIf091vy8xp
 f8c/Hk8ZJqzRaLQ/IXEo2E2l0pcAlkCq9UwVgWb/HEVMUm8DmqIQNPHfwmWi4L6aCXYjHz
 2zDDLU6rEf/8OcqGYLIbNxCyZVACVSo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-8mejQz4wOkSf4i64-X8XpQ-1; Mon, 06 May 2024 03:52:53 -0400
X-MC-Unique: 8mejQz4wOkSf4i64-X8XpQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572f3859ff2so125530a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981971; x=1715586771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNUmdwMafGjlAD1dD5b/rKg5wI+EEX021CPgKZXxVh0=;
 b=ZemzCOxWfKOSbge83LVixi2NXMhp2XgTrfwdi6CnQzS6oD5gC3F2Oa8baZgMZ7gRDV
 8kdAAiOyw1jaw1nvLKE0swtZlhy8OucjNgTXouD34LsPmfV9jvwfVGq9AwVGzqRvdFV+
 SBoL4c92u8wKM0PzlntsCcZhB4ii/wFqNHZc2j31foS4WWl0AjeOQaVj/eET0CH0rOFM
 zFE3IcrIk5dmQwHvqPwUWnoiIy+Rg2BU8TSpHG2LDV+oFcacPFPXNAS2ygiXXHPaw/3m
 aKX5EJf5FR5uA3ZcySSbfiAdYLN9q58OrJE66oZ0xC56KAOQK/ufMgRJMMnQAFG1qo4+
 /slw==
X-Gm-Message-State: AOJu0YxZART6biA7IRTmlW1QE0Te9+ToCa52Fuz/uJeuLuf6JvTjU3Qa
 nGaj5F/QM4e0/WC3ojxoAscqq+6MzufpwhAh1bTdE1DYflzA7KLAw+cVEQt1PtSdzNCUqzswTK4
 rfZMCRdMvLZ+ARfs9RByZh9F8ENq2u7SchTvumeJkGa1J5qVNKqeCvdqK4UwvexY4RUjvtcioC+
 KFFR502BYcosfOT0uDeuri4CvI/QqIGHF58PdM
X-Received: by 2002:a50:bac6:0:b0:570:c8f:1a35 with SMTP id
 x64-20020a50bac6000000b005700c8f1a35mr5650890ede.8.1714981971501; 
 Mon, 06 May 2024 00:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmpFZCGUmOATqXnnTW5AYl2cczW/lWad/hKydNCf4e8bYD9XhhY2KDBRDZwWCpTk/mPFchEA==
X-Received: by 2002:a50:bac6:0:b0:570:c8f:1a35 with SMTP id
 x64-20020a50bac6000000b005700c8f1a35mr5650876ede.8.1714981971205; 
 Mon, 06 May 2024 00:52:51 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a0564021f0e00b00572cebc5f32sm4075895edb.65.2024.05.06.00.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/46] net: remove AnnounceTimer from typedefs.h
Date: Mon,  6 May 2024 09:51:13 +0200
Message-ID: <20240506075125.8238-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Exactly nobody needs it there.  Place the typedef in the header
that defines the struct.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/net/announce.h  | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/announce.h b/include/net/announce.h
index 3d90c83c237..72e7e501f7e 100644
--- a/include/net/announce.h
+++ b/include/net/announce.h
@@ -12,12 +12,12 @@
 #include "qapi/qapi-types-net.h"
 #include "qemu/timer.h"
 
-struct AnnounceTimer {
+typedef struct AnnounceTimer {
     QEMUTimer *tm;
     AnnounceParameters params;
     QEMUClockType type;
     int round;
-};
+} AnnounceTimer;
 
 /* Returns: update the timer to the next time point */
 int64_t qemu_announce_timer_step(AnnounceTimer *timer);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e0a0bc31e7f..520f421397b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -27,7 +27,6 @@ typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
 typedef struct Aml Aml;
-typedef struct AnnounceTimer AnnounceTimer;
 typedef struct ArchCPU ArchCPU;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
-- 
2.44.0


