Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A821ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rpo-0002TJ-3I; Tue, 30 Sep 2025 00:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rpa-0001pc-Lr
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RpK-0002BI-7l
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759205930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3MHIDdNfc97WKh48J6xkwUmUQYbKad1LHr/M3AVUMY=;
 b=EdHi7mSa8G2dslsjbx+nHZt6PL6ZBhUA0D9V7fo/GSJo07EsaUOhl2ovr9QgeO5q52lqgh
 mUBnRTTR3WIf6gu4j8BGOCryTKp38C7lwmPr3EFhx331cfmA9+91WiQt/FDaeJQltz9LsE
 4xlz3uA+e9Coi9Gol2k+laVg/XNLLUA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ah4IH0xBN86Af_TFw6N55g-1; Tue, 30 Sep 2025 00:18:47 -0400
X-MC-Unique: ah4IH0xBN86Af_TFw6N55g-1
X-Mimecast-MFC-AGG-ID: ah4IH0xBN86Af_TFw6N55g_1759205927
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-780f82484faso3933050b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205926; x=1759810726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3MHIDdNfc97WKh48J6xkwUmUQYbKad1LHr/M3AVUMY=;
 b=VdRcymEBqasf65mYeP/bQ+xifOepKL51ygF5hN+AZiut0+JZbtzNe818assw3eL2wQ
 3CfkK8xSu39WdmSDrWLrp3g9TLRU6bzxWlEr4FMTH+1wtDeJBYdfbEcif76Tk0Xt/99Q
 zWrltzKWrA59Ij0kHshlj/urTqI3GIRuTglsmb03xOs8DxOdQX4uqOaUJk8oidrNut8h
 BTmqUOqAmFeSOnB6psw25O5lGFZq6OUA5zruOJvtgVr7ojEWrzjxOmfircENDoQxgac+
 ztmQZ7Wp39FqNKdyyVPwZmfeej/hDN5WpK6gmX0PlfZtg724zvT5OSPCrcE+31WTDuHw
 KDDA==
X-Gm-Message-State: AOJu0Yy0bbBoWs4VULfflE8z4dCKc+AcIuEiyTDi+7W+Y67bcnn7HWkh
 YO0iOJ+HraXpj6Hi43xMt6ffV5cd9enKMHvWeZVXkXr5Z32z4iDiDHeDLsTyhOvdHEJqgPxtJZL
 xi9xF1ih7PimcTmWSdvpUSz5q5Za81bQukoXmQk7QRHDUDiUzNTLlEvkv
X-Gm-Gg: ASbGncvbV2VBBAIge0FtgHTcKpU9Dudby+icd4NMJXmgp6+xUBBCF/6x832WU/85dHN
 JhSBptMJv8EifgLnQdW/+kL7sNqvc3fxkgWnRJ7aBEZuAZUzfRqo/P0g5zp7KPXeiurhAp2c2XO
 KWH8cMY/BHcuGlrciNDUHBS40bVkyr4IYNl6ILFZqW7OueyLEIfCarcAnDZNjJ/mtrPAxkmtT1V
 t3AoICuKKQkMu2UPAYJvdC759eLPV5ZTAOMdXJ9Z5eAshiOFHdDrPzlsNqqOWn4UGv2ftYn1FgL
 jEqGUrflJb0X5/0gwE4tQoR6veTWYjT8s5pa3T7LmJpgB02Vjy285txQMA==
X-Received: by 2002:a05:6a20:2448:b0:2db:77e1:72cd with SMTP id
 adf61e73a8af0-2e7d68d629fmr21290458637.60.1759205926497; 
 Mon, 29 Sep 2025 21:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFwZB+VNSr+1kjmugibFNtISMdnxaw7fovMeybVGnkFgUF60cFvwlDeEOWx7sDGAIrnvQQiA==
X-Received: by 2002:a05:6a20:2448:b0:2db:77e1:72cd with SMTP id
 adf61e73a8af0-2e7d68d629fmr21290410637.60.1759205926078; 
 Mon, 29 Sep 2025 21:18:46 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:18:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:10 +0530
Subject: [PATCH v15 01/26] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-1-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3595; i=armenon@redhat.com;
 h=from:subject:message-id; bh=CjRfsaaTl9HfWWgh7xdgHy4ywyfCJ5cqiMithr8pXJI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKIEpfFG3ZRc1RN3evSrUcuOe1VPuRR4VXZ3EE1T2w
 1vOb/eDjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNhc2D4Z/0i15bJbub3kp3v
 36rkPf3CnrFt+gb+MjbtWybcRlKyJxgZTufu2ehxrlnGp1/kGsP67UZ5V5X/NcsfLuhfuX2m9fm
 TTAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series,
when we are actually able to propagate the error to the calling
function using errp.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..08f2b562e3a5ec0e186336215ccfb378a7675f0c 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque);
+                                   void *opaque, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -136,6 +136,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 {
     const VMStateField *field = vmsd->fields;
     int ret = 0;
+    Error *local_err = NULL;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
@@ -225,9 +226,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, &local_err);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
+        error_report_err(local_err);
         return ret;
     }
     if (vmsd->post_load) {
@@ -566,7 +568,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -598,6 +600,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
+                       idstr, vmsd->name);
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +612,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp,
+                       "Loading VM subsection '%s' in '%s' failed: %d",
+                       idstr, vmsd->name, ret);
             return ret;
         }
     }

-- 
2.51.0


