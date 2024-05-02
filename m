Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECA4C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yl4-0000wG-Ld; Thu, 02 May 2024 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yko-0000og-H0
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykm-0002Mb-3d
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmAbnr6lvMxeU57acGRPp6vsIYEtlNzFQk94MJStruc=;
 b=TeSmF+h90O+cgVmiWaaYXdL+iZlGneE7crCAw+xeu4tg4M4KNSNsbi9/zCwvRttCXlHEVu
 1XoqP26RdowihFZKAB3PrNp7pFI98eIxS6qEV7YlYsK9b+L8fheWUHVmIrb2SAQs9uMAWM
 9X9bS+CAV9aR7TWOIl/OrZMUww9A+60=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-LTSnMjlCOJiQS0vWmOiaKg-1; Thu, 02 May 2024 11:53:46 -0400
X-MC-Unique: LTSnMjlCOJiQS0vWmOiaKg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572146eeed3so936467a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665224; x=1715270024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmAbnr6lvMxeU57acGRPp6vsIYEtlNzFQk94MJStruc=;
 b=BB4tXHRWaiaGISun9sWJmgoZVk0V02ZslAmoeD8NWLAQiSDpbJn/xKhaDmBYjSlM9m
 HNQWvBOeTZixtqLWTbZozvX8bVl5Pr12IiuixH9MUuitlnuEdAteWSW/iZoYAcPS3Euz
 xSf+oI3bSh1CBcIx4aUnfT3SXjqq2qarTU3/Oo+uEY0Jd8V6n/A19wEOoJNuCxovULfw
 vYMRkmLUxK1FvWDOpXhH9lm3M84NQuRmhP2Y9L026ZyYfSl8tRkkOcUqIEptdqcbKMe0
 7Wlz7PsD+SD6tkU2fykPKf7p2AWPtHeGaUs4coKa2P1hejDE50cd0G4aEYAEmuBzRcz+
 WYBg==
X-Gm-Message-State: AOJu0YxFPiwwjccFQMhUFyLE250axp6iv5oaV7vD/RyIXpWONtG/glbA
 yUh24vznF7cdkMvfam+4HZzxW0V8Ye269qPE7M+5y3pVe+oAbwRKvFY3m94O/Y1eVu88YLiBVdi
 nZnNRcVQm32E+Q8XH8gZGolWYzy1TPeITRbw+I0wO9yi788AxABjEZACcTm7o6x0rg/sZkDOtPx
 mhjYj8Y/qECNBEcnQ7Z43efnXI5IiFIXi37jHZ
X-Received: by 2002:a50:d4d6:0:b0:571:fc02:1ce with SMTP id
 e22-20020a50d4d6000000b00571fc0201cemr3519076edj.38.1714665224258; 
 Thu, 02 May 2024 08:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8DjgAksimvapgkbLAkiTCxuFt3cOP/K8OB9LzisarFgUf2sbwkvKhNO0HcoC22su501tXg==
X-Received: by 2002:a50:d4d6:0:b0:571:fc02:1ce with SMTP id
 e22-20020a50d4d6000000b00571fc0201cemr3519069edj.38.1714665223900; 
 Thu, 02 May 2024 08:53:43 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ds9-20020a0564021cc900b005705bfeeb27sm657988edb.66.2024.05.02.08.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/13] net: remove AnnounceTimer from typedefs.h
Date: Thu,  2 May 2024 17:53:22 +0200
Message-ID: <20240502155331.109297-5-pbonzini@redhat.com>
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

Exactly nobody needs it there.  Place the typedef in the header
that defines the struct.

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


