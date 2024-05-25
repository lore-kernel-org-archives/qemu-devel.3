Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F968C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 13:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sArCs-00014b-OA; Sat, 25 May 2024 09:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCq-00013e-JV; Sat, 25 May 2024 09:13:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCp-0007FJ-4M; Sat, 25 May 2024 09:13:04 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f333e7a669so29328515ad.3; 
 Sat, 25 May 2024 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716642780; x=1717247580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k55Y6DV4WOIGnZ+GT9e2Ud91C2qHGHQZ7NwmPFN6yig=;
 b=DgrRTbB0ZrNXS5/Ozl25U9sknjFvjDBMCI8MOJoPUJb2QskF5223xsk8BOXro27Og5
 oq3pdC9Viui5w3XQLsMFyGRr8ocd1mvQ1w8OomDhc5/jElRDqZ77HT8Np1ISm0CdB3N3
 03xa7aV+rHKKwrVdHp5AbcB25xSEf+Hda5sQbF16kjiAhS3J6LRVyc5phhFdUFeCRzL/
 AOmHX1TwTLXMEFfFIdNMv2Y16X+25bbmYjG0kSZF8YwuKjkjKPrm1UmrAc1xr57MCo0T
 n6k+5eOtyzCs1+7C/0gA6eTubNKkqjlz8ZQBw099rQyO28dwIj4rRBkWLiuS/cuamfJT
 r8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716642780; x=1717247580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k55Y6DV4WOIGnZ+GT9e2Ud91C2qHGHQZ7NwmPFN6yig=;
 b=CaWk5+DhpPZZEIvfyeQ+CsGK0iBX1Y9n9V4gI2et/32qDuiYZ1oPuzvdspIuemYNCM
 DMd8zCETMAqE/JhryHSmvIPEkJPa/gprKGDwvUv2FwfLJvbT4PfFp7uZdKgsa2HBmXqh
 AkcjG6oF/dLRdhpPOBcPBRjJd9SmPt9/ZsoWXQQoLDflzsIf/eU7czdxh5MLEEN3kNUr
 NFkkNe89G0Oxa/PgpBhJD0LVIGzGnA6KHpO0yTn8dSt1yqKJEpjLskxalDKplMIELMri
 YYM7aCzPepQebu4mImA3RbbHC5ysxPNuuJB1AyELqDTs2EmTUUQhZ07+8ecyKPZD/4cQ
 0TCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYQ4tLgcaMTEVEq3IiBS40VDxJSbvDy64Fj+U5VhJRJqoahilozHal+hE5CyRWayh28loxOe9DyTuBDwE0UxfS4Mtj0vQ=
X-Gm-Message-State: AOJu0YwZHn5YQpMIiHtPVAfr0i+tJ8TxA8TkPD+AijvepsPNELEoPi7/
 gUfG6L8/Bg9ht0+EOLzlreNrayAK6kiUGdb2sWZB0VWeVpGx+lTcIbbLaw==
X-Google-Smtp-Source: AGHT+IH1anC0Js/dMhugsQC8ninNLg3wK5lvuPUsHSgYpXwgIO+kLeaZUXxWFLst40mfg38dF/qTRg==
X-Received: by 2002:a17:902:c401:b0:1f2:f954:d6a3 with SMTP id
 d9443c01a7336-1f4486d1cb5mr51043715ad.5.1716642780067; 
 Sat, 25 May 2024 06:13:00 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9dd1efsm29653525ad.291.2024.05.25.06.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 06:12:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] hw/intc/s390_flic: Migrate pending state
Date: Sat, 25 May 2024 23:12:38 +1000
Message-ID: <20240525131241.378473-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525131241.378473-1-npiggin@gmail.com>
References: <20240525131241.378473-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The flic pending state is not migrated, so if the machine is migrated
while an interrupt is pending, it can be lost. This shows up in
qtest migration test, an extint is pending (due to console writes?)
and the CPU waits via s390_cpu_set_psw and expects the interrupt to
wake it. However when the flic pending state is lost, s390_cpu_has_int
returns false, so s390_cpu_exec_interrupt falls through to halting
again.

Fix this by migrating pending. This prevents the qtest from hanging.
Does service_param need to be migrated? Or the IO lists?

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/s390_flic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 6771645699..b70cf2295a 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -369,6 +369,7 @@ static const VMStateDescription qemu_s390_flic_vmstate = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(simm, QEMUS390FLICState),
         VMSTATE_UINT8(nimm, QEMUS390FLICState),
+        VMSTATE_UINT32(pending, QEMUS390FLICState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


