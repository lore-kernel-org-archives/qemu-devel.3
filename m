Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B71C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMOm-00059E-VI; Tue, 05 Aug 2025 14:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOk-00053X-Q9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOj-0003zC-52
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMi5bu/ogxF3WgMfV3R0P80z1lfeesWFvEcbsCzQTGM=;
 b=THzoRJ9Lp6Mr3XnMVyQGZIF4xHQxhsOlbB2/JKto86Fwm60xbKPZx4kmI7nenYOdib//f4
 7y1H1viaBZ2zz9vShVt33I2ejzd2MD0DJ0WU3dqUPg3YD1IzyvTX73UASsOuCAeHi7Uakk
 LiLGuMmv0yQpDaNBIBt2ChKznu+czyQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-oqeffTUzMt-PJkeaRHnyUA-1; Tue, 05 Aug 2025 14:28:27 -0400
X-MC-Unique: oqeffTUzMt-PJkeaRHnyUA-1
X-Mimecast-MFC-AGG-ID: oqeffTUzMt-PJkeaRHnyUA_1754418506
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2425e41424cso41018985ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418506; x=1755023306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMi5bu/ogxF3WgMfV3R0P80z1lfeesWFvEcbsCzQTGM=;
 b=amLSeYdamXDwoSKPrGW8hjwCAQEtcbY3W875WpbgZzu2ilH7HL3B3PGx/T2vdjngh1
 ExP84+PrDUuPwdHcknenlnZtH2vngToZQrVKnY6oqLT2BpYbtbO+o2laR0ujYvbWmG6y
 1/CtdFvWR1ePWwUpQSlSWzUgII7QaX6VDxXGPScTHSnxA6nY4pToTS/XcFiC0k2kgryP
 FttRVoCNjQ2UppkivloaAR6Hbl8UUYiLfqAeGBhtNDtB71s144LCnziQXN7oGtIXAjoa
 erMqsHPxKJK3shCxvgfBipPYKmUBQFZQASNPTvEwdSkKICVBpjwumi4izzL1B7OvHZOP
 rjXQ==
X-Gm-Message-State: AOJu0YwtfN/mN6Pi12+m3W/VYWj7eXE2ND47aGlPgNQaXSPzj+U9JGLR
 jw+WQzfetV2Cxy649FP9kc7dwUa72Er4Z0s2yB+H/8+j9toDy45SoNSrUV8huhe3i/1eLuPMfPy
 xNk1FR7d0MtWWrRm+5eut7sOS9F2Rg3jF53UiTusBQUjQA2vsQIpiWwd1
X-Gm-Gg: ASbGncsedinmikCOyHrAWKY5XgLS87EV3sGQ06Z+Ps+RMmEWpTPnydl3LGaHTkG1zD3
 48Q8l7efcANvzJxAyrwlXNkttfX/c01JFC+va45psfP20E11AD3rYxDw9Qp2iY+qs2utoaAj/kP
 zI1j6UL+NlMezoJHEu0uyMplik2MK3uCl/Jo+5gKag6/XW8blSS2eW58Hnhq1gTteR6ch4HBe6r
 yy1o6QSh/LpKgbhDps6Wsw3CrcPaot/kIk7wnRL715acvl4KQ8fMDyq7uKjS1zhAdkxyVZRJItx
 wSeZ6ujtONIqRwFgOrUIq5C4892MuGCGjH3tDiLkscitfHZfBg==
X-Received: by 2002:a17:902:e742:b0:242:3855:c77a with SMTP id
 d9443c01a7336-2429f42cd9fmr1326605ad.34.1754418506483; 
 Tue, 05 Aug 2025 11:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWiYF8ROYLWT7ZMRMJbopUbyQuhMXGKb+hf4yWZmI6JpodSlPuoLxWZPq3lKufq1xIN53hBA==
X-Received: by 2002:a17:902:e742:b0:242:3855:c77a with SMTP id
 d9443c01a7336-2429f42cd9fmr1326105ad.34.1754418506102; 
 Tue, 05 Aug 2025 11:28:26 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:28:25 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:11 +0530
Subject: [PATCH v9 04/27] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-4-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=armenon@redhat.com;
 h=from:subject:message-id; bh=EBOvtpFBOEOXHD8b7F3/LB/vCtG2890+FlcbT3emFRo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+myBDkNfcbmJRl/Ou9kBNrLL82Z6e+wV6p20z2pu
 0dv6a/oKGFhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJGclwxfZdxX7PMqar8beCt1
 xbw3nStkVdju79x77f618z5rL9xgZ/hfrrhzfZOn7dIl16JeCxUceDW3yef2ZJnFj27lsTS/2De
 FEQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_load() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b517e3bec651cb5b4050564f7dcbbf34c80a5035..f37c4455dcf839d46f026fc7c7ff02e2dfffe7b4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
+    int ret;
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, se->load_version_id);
+        ret = se->ops->load_state(f, se->opaque, se->load_version_id);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load VM version_id: %d, ret: %d",
+                       se->load_version_id, ret);
+        }
+        return ret;
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              NULL);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2741,7 +2747,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
@@ -2794,7 +2800,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);

-- 
2.50.1


