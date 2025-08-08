Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCFDC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHLg-0007NP-IA; Fri, 08 Aug 2025 03:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHK3-00069j-Od
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHJz-0007Bo-PY
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3KCUTS9bthE/q+vuH7wXyUsB8QAxl3I26xc+I+6qlk=;
 b=AFMOFbUp4HRl5xB+LAkIfinBuoSMoji+Zo52sRscBEG3MX3qVREDwTgr1LNRG5YaASw4yu
 ro1bwtAUBHC6URTklHuLSfvVMvYOXtW/CjHjVJT09f77vSYHx71BK2cmVG3knh2n9cvB6l
 gBTcWcAYk2Tc2c/GhjCp4rNJgaBSLsg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-xbnuOWazN2aRdlyeWIrOqg-1; Fri, 08 Aug 2025 03:15:17 -0400
X-MC-Unique: xbnuOWazN2aRdlyeWIrOqg-1
X-Mimecast-MFC-AGG-ID: xbnuOWazN2aRdlyeWIrOqg_1754637316
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b429e665c7dso1310294a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637316; x=1755242116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3KCUTS9bthE/q+vuH7wXyUsB8QAxl3I26xc+I+6qlk=;
 b=GArV/Dx+dia3nKZJOvgPEGi452Nz3EUywzXv2P9LKWMaBvl7+RHb7hrszQHW+SS/4y
 GBcx7drIwF0aGvRhrgL8RJc5fcQv4ftyalEIvkoXKPWuz7uHUtWwAG42S5DqNunHClon
 aYbWYGGokBKwDhJepVQ8+rqD2zFftATgwZDigr8ni5IlV8OAmoZYQP4vfMocpLM5lHKr
 XJpgqlFjapiWmq5c6fG8ECMcwVvULWJ55teSstqxtUWkQrfE6mxUvC3UxrCC7Rv2+bdk
 rsvYzCmdFn2x1kXkK9aaYGA3hLUUqSMiF7W+ZXCoK5UGNEE/OSI7y4IRxcqYP5BjhFow
 bUCQ==
X-Gm-Message-State: AOJu0YwwaULeTFbZZqgMwGsvDlxeVsympRFOhDobxSXx6v1v4RnWwVWk
 57aEKEroNxzBLC6iEjgZ/SQFlL0sVNiyq9L8SquDQaFHQl5PD+4OESVgBafXdz6S73OjwUv35un
 RstZ09Vwi+7NBhe5l5JjLWn95ezV+vubFNfriV/LhlfnhxqwbG4h4ia2J
X-Gm-Gg: ASbGnctveCpLragHEhJVoIF7jN4iEZLbxi0S/PwaltkH8oY7l7wS7BobKg57Z7bnTFP
 farfMfW1JE+N/e8a0E/hh0H+aEo71Y+9DjKur2/sEGl3JDT20YDLq/5GeMXTMu7I9Jh+mbZixGi
 VOvIk6L+Zee3qm8GzxBFmMuQ5wCMJtx7aKedk4Fj6nMUrSdhuTbNsTKiAVRPZRgeyTHmZe7RmLk
 wXyu61ktKcdQs2wC/ML4Me/nBI5vhEVC22cCxHjg+dl5/UCNm07VCeK+gUQJfCptqNzf4kf5VFG
 M6TO5SL+GMbde6FGcNxnl34AnyXryWUKwMUz2bIPjZojsxf1uP1Isw==
X-Received: by 2002:a17:902:e544:b0:242:1b:7f05 with SMTP id
 d9443c01a7336-242c21c30e2mr32738615ad.24.1754637315852; 
 Fri, 08 Aug 2025 00:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnNUOrvi5zQ8ysoZYbKUu+dltVp0hfcCYn7vsOZmcBdXf/Uix04dYsE9GelD834mymqR88rA==
X-Received: by 2002:a17:902:e544:b0:242:1b:7f05 with SMTP id
 d9443c01a7336-242c21c30e2mr32738255ad.24.1754637315485; 
 Fri, 08 Aug 2025 00:15:15 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:15:15 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:30 +0530
Subject: [PATCH v10 04/27] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-4-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395; i=armenon@redhat.com;
 h=from:subject:message-id; bh=lv1wyhoSKPghBwYXHzxqme8sGZVcV6fS6AKrxDBIaJA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVf0XvjwMqs+3n6R030q78qVheH7FxRvWScnIc8lO
 0tw0crTHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACYSvJfhnw6LU7Wjb7mXPoNk
 yYPTgostvI+Jf/j49lnGz0W9Ag6uVYwMf3OemOod8E38UOLws2qmkN4XlbkXu9+UrJyqs2Xj/we
 f2QE=
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 0c445a957fc99f826e6753ed3795bcdd51f1e3f5..5806c1822c5712fa7c22185e02050f3b16503757 100644
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
-                              &error_fatal);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2741,7 +2747,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &error_warn);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
@@ -2794,7 +2800,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &error_warn);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);

-- 
2.50.1


