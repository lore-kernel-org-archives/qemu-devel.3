Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC78BC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU2H-0000PU-SZ; Thu, 31 Jul 2025 10:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTIB-0003MH-Cu
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTI5-0000Rp-UX
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ie03UL/e0zjWpu2wXMCsfga71bFRAfQb7J1DQVdmwYw=;
 b=WE01v8HIEiYk91Ie44CkivP89tfU9AaKVBFRM3xhvCZrR61WR1QWbXmUmbEn/F2os4GpyF
 MmkrDa689H72c7pL3tHI7iIzoKGBZ8WAimSdLJolMe+y5boWjYIFb8QsYuVxG8mgvW0tix
 sj/KT2VFtTBVqgvfixeNRUgoCvfcGLA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-xFxDXk7eNCqxAXbAKLDIZQ-1; Thu, 31 Jul 2025 09:25:45 -0400
X-MC-Unique: xFxDXk7eNCqxAXbAKLDIZQ-1
X-Mimecast-MFC-AGG-ID: xFxDXk7eNCqxAXbAKLDIZQ_1753968344
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b42249503c4so1192521a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968344; x=1754573144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ie03UL/e0zjWpu2wXMCsfga71bFRAfQb7J1DQVdmwYw=;
 b=TWk6akJBcCBJ5h5PqWlyY+NC7KLs+cqPK1q6Pdpw6l7s69Kzdd0vlPO/AaGtw1Z/vj
 TPVYGNmnZuUT6SEHkE2EVPg2u7tyFatooJ9xuSTO0sHfRPNnbQoaKo3KXFJcrtI4yyvi
 leD3ZGKr18aCTKvGvmiNKO0x2wATbEsqmi0v1/Xsu90cFtD1JOBaaaSx20qGD/Fb/k4O
 R/nM42B8kv4Drvcs9K+VmG/bMTPT4Df4TW5l/w+0vVr7ShmftJajk+F9UsJHgCYn4OsG
 XMMHRY4vv2j/3K/25bycO8vrvxEnhqEk2RF1y05pU4DlLvVU2EYUI3EvcpduyJXRZtTR
 DX/Q==
X-Gm-Message-State: AOJu0YxROaztSkXXDnacJqws0AgwTPyciFiqz2DPGKRU6TlEg9OigdwQ
 rnx0g+PRNgj6f2baR6hau7+8+GFsm31tiszWvukkkpu5gcydX1BU6agZ+s3jXX0zWOrfWT9c1RA
 PWXdrjcn/toaGVzozOEsv7YYPxkkoCfRpihTLWZ+Av1mnlefzzmV9+lRSThl/4/gkJtHn5B8IUs
 vWzDcfNUqcvW2PYIXI6mvfmgstlJO7iC4iFa3k1s0GGg==
X-Gm-Gg: ASbGncvwNzg2QZFRRxCasaen/7iHbU8H/U/QHX7FFjlItmZVCwYJMztP+9g723Vkk28
 FqTDgTIeUAfwFxU9WvVhRJbsJrPMiL2LhmmJGINGnr2yxaayfs5azDM2K++xQWCG3oYSXIhTzy4
 Siy7E5up8aaFEptCIVoZ1GuI5Mhl4Yb95DkWkbfplYR8SIUeAedLcF0+CfWc/cRDERLfGrVa1tX
 SGI6AjaDpvMCx9AQCOTAT6Jr2YMxbqeb/u+WcqfydOhEDz8MwUdTZZCprkfPk5YuceyMe1Srkc+
 fBauOfiWwV1DVLf3nEzuCkJkoH02gI1JudJ3GyQTpDBoFvNSKmb2
X-Received: by 2002:a17:90b:1e08:b0:312:dbcd:b94f with SMTP id
 98e67ed59e1d1-320da5db33bmr3026332a91.11.1753968343463; 
 Thu, 31 Jul 2025 06:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs2qA7ABmrPDlwEuQddok3IMT6nI/WDNfoR5Z1lOvMTTx++entz+1uUqebihTBWx0QRWDazg==
X-Received: by 2002:a17:90b:1e08:b0:312:dbcd:b94f with SMTP id
 98e67ed59e1d1-320da5db33bmr3025736a91.11.1753968333496; 
 Thu, 31 Jul 2025 06:25:33 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:25:32 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:51:03 +0530
Subject: [PATCH v8 23/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-23-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534; i=armenon@redhat.com;
 h=from:subject:message-id; bh=oA7/haUdk80U620L61W03FFxXXZTo082B5XNVpXtEvg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37nMlyaQM25cZ19e57TT8+lo0NeR8/t6VGyaveDyNQ
 04ryyqxo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwERuHGT4K6hybW/Oi0BZxWZ+
 1e4v67I+bi4PjZy+/wHPRYtZDqlPIhgZnm2+vyRRWcxjk5DbfhP7O0/d6x2ehASJlc/a22lwPuo
 PIwA=
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

Currently post_save hook is called without checking its return. If post_save
fails, we need to set an error and propagate it to the caller.

Since post_save hook is called regardless of whether there is a preceeding error,
it is possible that we have 2 distict errors, one from the preceeding function
call, and the other from the post_save call.

Return the latest error to the caller.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index b725202bfcf69c3c81338f1f5479aa2ddc5db86f..25a819da069b982d4043f287b4562ea402d9eb0e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -418,6 +418,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
     int ret = 0;
+    int ps_ret = 0;
     const VMStateField *field = vmsd->fields;
 
     trace_vmstate_save_state_top(vmsd->name);
@@ -533,7 +534,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
                     if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
+                        ps_ret = vmsd->post_save(opaque);
+                        if (ps_ret) {
+                            ret = ps_ret;
+                            error_free_or_abort(errp);
+                            error_setg(errp,
+                                       "post-save for %s failed, ret: '%d'",
+                                       vmsd->name, ret);
+                        }
                     }
                     return ret;
                 }
@@ -561,10 +569,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
     if (vmsd->post_save) {
-        int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
+        ps_ret = vmsd->post_save(opaque);
+        if (ps_ret) {
             ret = ps_ret;
-            error_setg(errp, "post-save failed: %s", vmsd->name);
+            error_free_or_abort(errp);
+            error_setg(errp, "post-save for %s failed, ret: '%d'",
+                       vmsd->name, ret);
         }
     }
     return ret;

-- 
2.50.0


