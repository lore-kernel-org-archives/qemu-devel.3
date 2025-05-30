Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A1FC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiY-0002e0-0C; Fri, 30 May 2025 04:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiO-0002Yw-DT
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiJ-0004de-Kq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8G+ZwNewrKmt3y0x+FnEurAOu2EK1ulbB74Dqd2P+4=;
 b=SLI8ZgtJn/qfm8Ae4zqAqoa4BwHxjmzuLZLEXA+zJdDkj1okZtG6UgZSKNN6aqkxPbmMcx
 8hVh4Cfq5z/rTxUrsQFxf+K/XHfLMqx1zL4rByHFe15NmdJWRz/EsmuGNTxW3r253u+lvv
 qt/w4IFOU4jF5J5efkEPic4/yBULKM4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-gbNaLtv2Oqq9yfd8RSYH2Q-1; Fri, 30 May 2025 04:03:37 -0400
X-MC-Unique: gbNaLtv2Oqq9yfd8RSYH2Q-1
X-Mimecast-MFC-AGG-ID: gbNaLtv2Oqq9yfd8RSYH2Q_1748592216
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6045875e52fso1297263a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592215; x=1749197015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8G+ZwNewrKmt3y0x+FnEurAOu2EK1ulbB74Dqd2P+4=;
 b=gj1z5XR8wTIHrOnvIElNCTkDzDC6t1Ej3uDmtsrkHfMDTVNuqVv7k/xiPg/xvOTtp5
 PYPh5CFwrVrOUF1K9AfsB6FqVhiKZHvhJ94Ve0GKnZS6zM9Td0R6dZoDk+mY+yGiepA8
 gd5OE/s2seS2K3DY7G4krjzBDvt2+YCfqioPmyJctSk5STRPiMjVHcwcVQ4A3gR5IB4F
 AeG8sg9NjxQNjIT3XRp1W3XBJ9M+2KXwe1K4V9+GMXWpvNmawUcg3U7LSgrMGGHaQg/P
 /blvuxdvlN/D94/hQBPmKkMOW2iYFVatC59NTcw95fTPxwtLOyqVKFi4OmGJkD9q/KzH
 gBtQ==
X-Gm-Message-State: AOJu0YwwSBMXobpDH0+N3nvjZZ7te3BAkMFiRBriui/CMIWDsGlPkXOp
 RD+DyZA2YCD2eSm5RtpODHcSRHIWL3YYzxEHT6FHAvrv/t5SIw7OrEYd0uEkqaCfVY90K5oelcJ
 krx8pOit3x/SE4t0hW/KGBlias0mYZOVuju5kenBRCYrVjk/Lu5FGb+hG8mBWKdqjRIlqPm3+h4
 tl2R11/0JpmNN09msLEyJIcFVdTkXzStHjtKGc1sGh
X-Gm-Gg: ASbGncvi7v+KWFhMmVYXnGvxfL5om+EGDWmxkxtClaI/6P88PBoVyOKwDYXeiLJpEkE
 5AGnZveT3ScsRsdz4jaa5BdOOUhhHdeVVxoxM6QbvZUivJlVP3lrC3U49i0Y6Bo/8oz05n7nkzm
 Va3O08Ij1hQsf0WbMrTNz0megk+X8JwZEaKjB0u1TajbfWdodBL+nBsgfJ+ITObMq1j4GRwnE1O
 OOmZNt2dtuqHw/QGipr61Q79J6BqfWoY0XalhCD6/pafVGK5VBg+YyXDm6nLhWntNbr/rnXLvV1
 DbJ7vHRdCiNQaZRtiM9a390Q
X-Received: by 2002:a05:6402:50d0:b0:602:1b8b:290a with SMTP id
 4fb4d7f45d1cf-6056d673ad4mr1982001a12.0.1748592215306; 
 Fri, 30 May 2025 01:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLGzXezFRlg+nvYk3YPoKVr5+Ye7gtdDwNNem7qNeMTPnt09ZShpToc8TgQf2WbG4ALxvYwA==
X-Received: by 2002:a05:6402:50d0:b0:602:1b8b:290a with SMTP id
 4fb4d7f45d1cf-6056d673ad4mr1981969a12.0.1748592214847; 
 Fri, 30 May 2025 01:03:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567141d48sm1232570a12.60.2025.05.30.01.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/14] hpet: adjust VMState for consistency with Rust version
Date: Fri, 30 May 2025 10:03:02 +0200
Message-ID: <20250530080307.2055502-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No functional change intended.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0fd1337a156..9db027cf76f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -328,16 +328,16 @@ static const VMStateDescription vmstate_hpet_timer = {
 static const VMStateDescription vmstate_hpet = {
     .name = "hpet",
     .version_id = 2,
-    .minimum_version_id = 1,
+    .minimum_version_id = 2,
     .pre_save = hpet_pre_save,
     .post_load = hpet_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
-        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),
+        VMSTATE_UINT8(num_timers_save, HPETState),
         VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
-        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
+        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
                                     vmstate_hpet_timer, HPETTimer),
         VMSTATE_END_OF_LIST()
     },
-- 
2.49.0


