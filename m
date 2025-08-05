Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1932FC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMWS-00081c-Vt; Tue, 05 Aug 2025 14:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMVL-0002SN-6p
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQy-0004a8-8m
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unzr9BEH+PBOBEueJFcp5ST9RqE61zvJ2oDaENpfyiA=;
 b=DNX804iH2IztuiObUsi5u1kgbe0qlWTUfnqY740chY+RNe91KyC3TFqs3n9tUGuYsUlB6C
 oCqwl1gTuhYlXLaNhShsm+3fT8yFOIJ468gPwVhKSfeeeoOSfCi0aTnpe0qp/2UkJtNCNL
 tpQ99nb7GazAPOsyfkq8wXd8OfkAT5s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-40dNWocPNM6bieyZKCIIXg-1; Tue, 05 Aug 2025 14:30:46 -0400
X-MC-Unique: 40dNWocPNM6bieyZKCIIXg-1
X-Mimecast-MFC-AGG-ID: 40dNWocPNM6bieyZKCIIXg_1754418646
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b42249503c4so120182a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418645; x=1755023445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unzr9BEH+PBOBEueJFcp5ST9RqE61zvJ2oDaENpfyiA=;
 b=Bi1aj9GMMRl72JGP5t2aNUC6fkZINDxfRIVxTKuSCnTrUit2bxrurH/1NPjj4YAqjK
 HQBJAMZ6rhyrdePC5j8okdaXknNln+5lpdrQ6FhoD3VPMmw22vMzOUp52JvixEofcjTH
 PKjYVG1n51aTB9Hh7FLQ0SvMauvyEqEOhnYPzV42yMEVQxcrh7hLO2dfjlqa1U2AlE45
 w+rSD1MHbcfvaABoxhfOegxck9WEnUMSahXSbss3KtHbM3e7sRVkDQak4Z+r68BXIL4Y
 3PWd+pu0RssDoT+6wwH17Vcnz4fyrvFBDHgQhrmH6IgP+Z2/k7cVqWOg095l2DlM3w6i
 3CNw==
X-Gm-Message-State: AOJu0YwhSeAre4wYnqOvkBL3Kf9EZdkVjIjMk3TmSqlsjyThWZkjNkwA
 P7Rsy5iieAp9d9BXttwr+7XOU5f9x+16++UbNCp/zx9+1QfwSGqrd2+j2KDl9L+bwD/7vXs5+wr
 UUxEdsiongDJn9wUggQhAdUAL6ULTOvU80+1fZFUDCNAIS8uXgYS5aKAx
X-Gm-Gg: ASbGncvh1eqaq4ZoQ0+CsDNPdgjS0yun9RaYIwdqoVL8YfZbicXKcni/5wahenbwrjN
 Bx9b3lQM5emc3qMuVj8WjmDKteiIZh4XNS3/WQfduwau1enH2nnuirbnIvkw2dC/mTQmFSUpSTd
 1y4XrLtM+LFjS2QdhKvdTRmrOJzTax/KvM05J1E2u/R7sRdYA1PDitZ3e9Rt/4XxqOSxTyFX+oj
 uVW9XL7utNU4cVhPih7gUYeTh9qn9md8bk1NvZGCDcgYl1yQcX22pMnIELYjwgYwlky6WtoBMR0
 b6BlhCqmVlBoTrZn2ldEF+jIfPnxpT80dI3LyKD4+CEhQo7dEQ==
X-Received: by 2002:a17:903:1c8:b0:240:3cab:a57a with SMTP id
 d9443c01a7336-24288de3d19mr61783265ad.12.1754418645583; 
 Tue, 05 Aug 2025 11:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1QWqSt+kHqrcazog/ty+ylDlBd8/ZRKOzE/l5Nd5dxklkAHoJMKn6mZmi90jIHtlLg1oa5Q==
X-Received: by 2002:a17:903:1c8:b0:240:3cab:a57a with SMTP id
 d9443c01a7336-24288de3d19mr61782325ad.12.1754418644659; 
 Tue, 05 Aug 2025 11:30:44 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:30:44 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:26 +0530
Subject: [PATCH v9 19/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-19-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=armenon@redhat.com;
 h=from:subject:message-id; bh=+FcTJsfi5Ohk4wZicys8uXkAlUsFM3ystfG6IZbJVhs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkXxmdtS+jmPLZeKUtGWzOP1nY+SPCePK9H/qFDy8oJ
 0hWF2zrKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBEfNYZ/ygYHZ3msOOT1qJBj
 kuvb/YWLd973/7pneffnCwVLF0+OncfIcCpn4cy4TZJn79XMOehRfv7I2arjngn5gqVvolZK2HV
 MYAUA
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
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3abe4193e02aae9c813ff07fb388a7ee470c8a6a..938adb20270adbf9546b0884d0877c25c3f0f816 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2480,32 +2480,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
  * len (1 byte) + ramblock_name (<255 bytes)
  */
 static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
-                                     uint16_t len)
+                                     uint16_t len, Error **errp)
 {
     QEMUFile *file = mis->from_src_file;
     RAMBlock *rb;
     char block_name[256];
     size_t cnt;
+    int ret;
 
     cnt = qemu_get_counted_string(file, block_name);
     if (!cnt) {
-        error_report("%s: failed to read block name", __func__);
+        error_setg(errp, "failed to read block name: %s", block_name);
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "migration stream has error: %d", ret);
+        return ret;
     }
 
     if (len != cnt + 1) {
-        error_report("%s: invalid payload length (%d)", __func__, len);
+        error_setg(errp, "invalid payload length (%d)", len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "block '%s' not found", block_name);
         return -EINVAL;
     }
 
@@ -2640,11 +2643,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.50.1


