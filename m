Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA99C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzgt-0005mb-FT; Wed, 16 Jul 2025 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcG-0006GL-51
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcE-0000FI-Ef
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6idEMhh83uqC5z427pjdZmOU5UfrJ0zUiwqia8wpnxM=;
 b=SjmLuh+DlRUfeTKtREJV51xIfLTERuINHBoXvkQH5G78R4o/uh6rnS3qg0Djb0kO9xnxcv
 zIJKXuYtfWTd0fBezpEaGDgczDSxvTxMGm5kdJrOl8z7wTtXf4qWeCr3t9Rj06bHjjpt2i
 FBAhSJlnMnx21hyDSZFb9FLyuIlALdw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-5cGVAknNPLOjrYRGoOPbTA-1; Wed, 16 Jul 2025 06:43:55 -0400
X-MC-Unique: 5cGVAknNPLOjrYRGoOPbTA-1
X-Mimecast-MFC-AGG-ID: 5cGVAknNPLOjrYRGoOPbTA_1752662634
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23507382e64so65884045ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662634; x=1753267434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6idEMhh83uqC5z427pjdZmOU5UfrJ0zUiwqia8wpnxM=;
 b=rWtmjVijLI+ndO56jVAgAjtqdyLZJlwV3KOyee+866qBc8KV4Gvi9FUITQeTQv7WnY
 7rf2MNbavelqDT9NNEFgtc9jWASsMl+YHoy9aEjOPMFdM2rQwlh9rrQnbNaBYXfhhAtv
 AbhlfDayoFSze3PIPe715Mwyl7FhaMdFO6Vsi5eQrTs/ULVnAuXg14JU7CLby2Plbzeu
 39vYFgdQp3HrhxPUSFEG15Ef4ZwBro9q5JOHXKTgnkVGVktNZkc/85f+Tlu0bZ6lSIOb
 ypzr0vx6b7uCcgG4N0ZpfpAXpGQh26cisgpVNqGGr905vp+yb69REqvrO2N/eCQHq3aI
 XiMw==
X-Gm-Message-State: AOJu0Yy0mq3VjoIc293kZBgnFJbbi6SGKy9lRIiksl+S6DC9PXfSDRBg
 7xgrOFAij+RGbv2oaONMeS1dExpXJRFHHidgpkYmrntLbhxHA5u3+Ss3RKUAE5sypYSEj2+e3WU
 hMUD4Gbf9FCzJxhhKFZMZYwUrwD0daxszE/+uvrtCadbFR/xguf7sLMWe
X-Gm-Gg: ASbGncvo6REGqaIFHchVZ+2TfJSGWqNV3hBTYMiYdRriJqzbtf3gQbnsGVM7NcMPlA5
 Xe/OAYkofJ+QwQ5BofJs3Hae5Hp2XD0oV18g+iu7b9wfS7u3GL4QlsTSNhrh2JWg1cWSKAmyI21
 UHsviahFMGE3FAIuyzGcDE31keaw253Bc8FfhgvY661Pxu/qy8FO1p9WiftXm5YeRssdPLYkUEn
 nIK/W+BTqEQeocpWgtZUvihjmtLUj/BQRzpbbgwKxuFK5Fe7JaXpm2AVuiw4qbmwQ9sVGVFoKJH
 YYmqRMToxNGAU7v5iFW5DCCJwUeyqv3b4QpciZk3oYU95iuQTg==
X-Received: by 2002:a17:903:1106:b0:234:98eb:8eda with SMTP id
 d9443c01a7336-23e2572aad3mr36240515ad.28.1752662634493; 
 Wed, 16 Jul 2025 03:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0q/MXUu+qdbL/fKEK3wHxt1cqJvPweE+Ec3XhQMCtP88+SCkU1PxvkSgtzbBGlGgCT8pFpA==
X-Received: by 2002:a17:903:1106:b0:234:98eb:8eda with SMTP id
 d9443c01a7336-23e2572aad3mr36240065ad.28.1752662634046; 
 Wed, 16 Jul 2025 03:43:54 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:43:53 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:54 +0530
Subject: [PATCH v4 04/23] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-4-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ipdA30K0WlD1GlemlwMPQb7dvJDBNmh94bTKeAzukGY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k537zP2LDgTNr93dx879rbH6gyjbti9tklpsGrO12
 ZxFOV93lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMjtZwz/LO03zO6ZzVut/F7I
 V/7wtZV/Z684HW2uX/hR4/S06NkLtjH8Tw87ssd/wrHaypntXYKeFzTmflySsX6luBzrn3Dr7Xu
 X8gIA
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3ccbc724eb808db09b77088a858ecc7f06b21155..1c1a46e4a01f812b559c451d278916426aa1cf40 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,14 +963,14 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
         return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              NULL);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2741,7 +2741,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
@@ -2794,7 +2794,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);

-- 
2.50.0


