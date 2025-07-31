Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8B5C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU5P-0007t7-4h; Thu, 31 Jul 2025 10:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTF0-0004Ti-60
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTEy-00088T-3I
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9J1Tq4hSBT5sDELmai4TDUPEnf2TI6fwgtJw67ORFg=;
 b=XY/8Ehzbj1it9/sPZvmNNnqI38WvMdk5JH1JBhcKplghYCgn/LctrzyAybzFEIjCfDSa+l
 fVq4eAITAz2rTMpjIjYA+NyTsH7hf3/mGx4jeeifj9LjrW7vr9EQcuRKJGG9Ohdbesj2pa
 YJXv3ZVRgRLhxRId8eBhRf0dmJ6jVHg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-LVkWuZjzMFqpL6bhtu--5A-1; Thu, 31 Jul 2025 09:22:32 -0400
X-MC-Unique: LVkWuZjzMFqpL6bhtu--5A-1
X-Mimecast-MFC-AGG-ID: LVkWuZjzMFqpL6bhtu--5A_1753968152
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-313d6d671ffso1021407a91.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968151; x=1754572951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9J1Tq4hSBT5sDELmai4TDUPEnf2TI6fwgtJw67ORFg=;
 b=d4QhxlZvQQX6VYc8WZHUE/Cye9xzC/LgvuOhWzULQPT+oPvi9cP9s1NXNpA9CEbNLV
 JaalqkpuAIzFAoNItE/LL83Fkc2C+ak8vaPxQZ4KaIOqQ9/GmBq+XGmq70tqEJpYDhmJ
 9tvXCbZcAdA2bf6a6rlch9jUhHi9HcDOxRcYUAwTlDe119mn2WB2zCv5gTVv0LkT4QiV
 sVZLg8RkIdQ8ISs5pRFLjnGwyfGOW16tYRFWBZ5ehwVlqEMTSLhNlduHvK+yJEiU+d+k
 MvyMVVbMBB7UdTqRy8kKe6VCJpMyuPTjCt3imnj1uEErouNWafFjabymQH6IHKUAqLcc
 o/jQ==
X-Gm-Message-State: AOJu0YxZ53z0V4H90NVgFJs6mgEl2P7aJ0BaleKV/j+8TIOTVHONKfz7
 D47PITVfIpdcBvIQ4RgEtvzZW4B81o1toI6qOIfI7UPn56OVrglWZ1Ikh0FHSgCRaW72cG6Sh/n
 pCx/trP7nBe/LZtCntx9S4RAIxlZJLYJHhfnlGRXQxu9EfKvpZyvGEQ1Q5yidCV+yofhQSX1nZe
 zTxVGR9mpo9EwuSeXqXBfztGm9ZNK4DkUD9/5Ev9LPXg==
X-Gm-Gg: ASbGncs4QofZL0mWY7AbNbYfvz5NW3x9MohivGT2+1Qou1mtjSqMntvA4SLXw3vQsQM
 Pdmp8jVP6IUOg79M72OUxEhL80Owa7oXNiFp3lsQ5Ui9a1lw54DkB5Bp7hG7Ir9FDWku8vnMGhj
 yg4uU4n1HwWHiuFhHF9QgUONrvTSPpDmHu2mETYiVY8/FAm+bkcY2lReJ8KKH/GEYiVRgdGaMDb
 5dNnJcS/4no5Pca2YwtsrGq5ZXtCEK0cu9gBwdlgGY/lUFaLKwzTt8PiwjPKZ95nod9mwAmu/Wa
 ZUtwi+OxnvwDfD4DI197P3dTvQNvUfwclK8EpF2i8T3OaH4Op1/8
X-Received: by 2002:a17:90b:48cf:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-31f5de6c834mr8973355a91.26.1753968151449; 
 Thu, 31 Jul 2025 06:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmNszBsD4ejVXmbDKe0gpXcTf/N5/bNazz9PyWnMpySaHBdThy86NQMlOmdlIWTk4y0AOB+g==
X-Received: by 2002:a17:90b:48cf:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-31f5de6c834mr8973289a91.26.1753968150894; 
 Thu, 31 Jul 2025 06:22:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:22:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:44 +0530
Subject: [PATCH v8 04/27] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-4-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=armenon@redhat.com;
 h=from:subject:message-id; bh=R9/G1j+qazRvGzjWA2NYgBZJVWEWhvj63YuptM9QLk8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37tNAHZ1D6mLlK1501C9NiY5dU+z2LecAQ8tzuad7O
 UTtOs53lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmEiGNSPDDSE3vwlTmc5+Tjg+
 z2X2rupUO/5D0bvnu/DvCauMOdg9leGfrejvv0ky98/vevYlj1lqif60T8y+24O3//0mHsF2PL6
 YEwA=
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
index 842ff3dc6d5ccb05f7d33cef9f7319b141419501..736410be867a29efa24d749528c9bc203a3e8131 100644
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
+            error_setg(errp, "Failed to load VM version_id: '%d', ret: '%d'",
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
2.50.0


