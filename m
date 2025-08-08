Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D0CA0EC0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMc-0002tt-8O; Fri, 08 Aug 2025 03:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMI-0001QF-DJ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMF-0007X2-HC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Hr1xq017ATqgOHRripH8YNVyaWvaNlyBe9lB1bdJLA=;
 b=Gnk6sFr48SEbAhr4yT50d5wHSPVCwxw/aaUrUKnbhYKD24c1tTkelV0tIYWKkSNEQpMO2f
 6+Os1UiPcGuDdjrYsFks8g7KjJw+HIF8lhAqBqTiL6sR2CP93A1cTybZQLCcTR/rwEYfEQ
 hBq0v/9aTgA6DHGpcAELQdPHGLvpW74=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-lHcvIUNhMUmESebDC0Hf-g-1; Fri, 08 Aug 2025 03:17:40 -0400
X-MC-Unique: lHcvIUNhMUmESebDC0Hf-g-1
X-Mimecast-MFC-AGG-ID: lHcvIUNhMUmESebDC0Hf-g_1754637460
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b3f38d3cabeso1494349a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637460; x=1755242260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Hr1xq017ATqgOHRripH8YNVyaWvaNlyBe9lB1bdJLA=;
 b=d8ThAoaMi7RFKAA7VrncWc71CXcUE+RBcOvESxdanUh6AJjhFMXVIqsy38Y3rqq1Jl
 liwZs7HNYH4If1FOx+6iqEVBY7EhtOCVClaL2hG/YfnLBjxSYayqikJ3rosR+RfBzDY7
 uIEOkrdk9Q8NDp80EwoN35sFa8VZ/2UsnfoAWa6Mq6BacUcbIt+QnENbCFNlCDydU3Tt
 aXkZosG5T7DAQOG956roJrOh5pSGneshtBq00+4QncOrFDuCv92kYTeh3omrMFdA9EG3
 CkfnUptFQXWtkUTYJlm6/CTB/yPtR3H1io60KM5o5F1h0+jlNGNaaIsDo5fnjgjsvbGH
 50yg==
X-Gm-Message-State: AOJu0Yyr8uoMxTUwOcRSgMFUB258OxhfQnqaNTZCpRJBIossxgWZl1/z
 MsGPOdmi1cvQAA6SzSGB8aydzG1pgFHX9jyN6mjZGZF6jbM1kG7d/P76q08NO+PkFuKp8rY4JXl
 T/0USuUsynhKjz+87T6RCeV0StLZEZje7G/tq+pgYzbFnPoAcEmSJmilv
X-Gm-Gg: ASbGncsVd3BkoEl53AmlsHpUXUgOAyTeo5F5sOVFxHH9yunzcqeiEDUvC89YlEPOoUD
 N8YqpiimW4G4+I9fuk2kPmUXfGwP/sLLUxkY3Pc5xx7Viwz0M8vD2Ys55eAvLTz2ixtUqKe7wsZ
 TnBFyA68j3KzpvZ6QCrTu0RSRsGDMmhEZsf4u0sVrRUJ03RtngA/XX6CVaD0CrV6w++1HrlBK0y
 7Y8a7Qpns91hpfdWbGvudjUJnCmip5+nDoy4lRyquZXn7u227IzEYY2iJ8Btc5lOicHViKnBj0c
 c8R7Tujbws03MwNSFbykihY5L0tLut0znWfqB9/mBVEmtMKOr97D8A==
X-Received: by 2002:a17:903:1b66:b0:240:7753:3bec with SMTP id
 d9443c01a7336-242c228e4e1mr28444125ad.51.1754637459683; 
 Fri, 08 Aug 2025 00:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg9QpvMKsPSqdiPnUvaSIgKXT8yIxg2F3REG4AHfWCvrngHZwGBuwPslaHpGez3bkQifCQqA==
X-Received: by 2002:a17:903:1b66:b0:240:7753:3bec with SMTP id
 d9443c01a7336-242c228e4e1mr28443665ad.51.1754637459212; 
 Fri, 08 Aug 2025 00:17:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:17:38 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:46 +0530
Subject: [PATCH v10 20/27] migration: Return -1 on memory allocation
 failure in ram.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-propagate_tpm_error-v10-20-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=armenon@redhat.com;
 h=from:subject:message-id; bh=+A43aE4QGjzjKoNQN+TnSj5Fed4DOQR/ypVBqBxUdgs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdduajP9eyRyNPn609aVf+bWLfBh1bFimPh54b5c+
 0eyK6wlOkpZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExEw4ThN0tiq3lCileBWyR7
 JZ9XPMtRdqFr2XcFX84xYrios71oG8N/35Pdy2WvmBZem7hCfeWRMl3V6a0N4oveB1tLfigUtF3
 ABQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function colo_init_ram_cache() currently returns -errno if
qemu_anon_ram_alloc() fails. However, the subsequent cleanup loop that
calls qemu_anon_ram_free() could potentially alter the value of errno.
This would cause the function to return a value that does not accurately
represent the original allocation failure.

This commit changes the return value to -1 on memory allocation failure.
This ensures that the return value is consistent and is not affected by
any errno changes that may occur during the free process.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a0dcc04f436524a37672c41c38f201f06773374..163265a57f26fb1dc88d9797629d58c278e9afb7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3575,6 +3575,8 @@ static void colo_init_ram_state(void)
  * colo cache: this is for secondary VM, we cache the whole
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
+ *
+ * Returns zero to indicate success or -1 on error.
  */
 int colo_init_ram_cache(void)
 {
@@ -3594,7 +3596,7 @@ int colo_init_ram_cache(void)
                         block->colo_cache = NULL;
                     }
                 }
-                return -errno;
+                return -1;
             }
             if (!machine_dump_guest_core(current_machine)) {
                 qemu_madvise(block->colo_cache, block->used_length,

-- 
2.50.1


