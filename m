Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93CC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8Ue-0002Kq-2z; Fri, 27 Jun 2025 08:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8Uc-0002KX-Kr
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8UX-00019e-FA
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751028459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuWJM0+F8B5absd6Si1Su4ADKtTJVbXncgvEgJSNOQo=;
 b=ikaWm0Rab2FzzmZeNS6NkZu7xaHJBwWsww3zDxgGXEWIY/4zXWKAzCaoBoPWD88yLF62Za
 nMYhdoNPEwRVE2FI3p9v5IAPV1uz9wDSrNQIknRBtaGtqVKbmb6OjPyUo3ZFuzgot+470j
 fqUfrFjh/JL+oqMOq8/OUR3hKPv4tEM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-nA8-_wd9OnWkSviEKNJW0Q-1; Fri, 27 Jun 2025 08:47:37 -0400
X-MC-Unique: nA8-_wd9OnWkSviEKNJW0Q-1
X-Mimecast-MFC-AGG-ID: nA8-_wd9OnWkSviEKNJW0Q_1751028457
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2369dd58602so18145485ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751028457; x=1751633257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuWJM0+F8B5absd6Si1Su4ADKtTJVbXncgvEgJSNOQo=;
 b=r+Ua0jnwiHbSO2klGwC9PX6B3Lc4XNpw3gp4ThtElz3GHYafbBwtS5aAYqo2P72i4M
 HA6I1LzEoFSyUyhYQUq/hFAg9Y9E82m8y9/VY2frpMbgN5UT4LDYLMAheevY7pgZgFR9
 KF8UdWJTMH93sm4K8RgVmsDKiilbzlT8DQrRSf9og9imBLWKUmnQ8UpgLWrEDrKVPB8T
 NpQe8ydDj0GGpHVen+oBiVwfDCDmuNSJPQXnUJgs0dpeDALSwPSJfyPPFujKfIQcoCm3
 O/xkCgOLjFxHt9DJrOIoW4ZwAVWnYmuj6REiJ6oaEv3EvnVI+qFH5TgFJuYOxJ0BjALt
 SoXw==
X-Gm-Message-State: AOJu0YwVLfsMFPeaNiyvNXSOAeXY7q7bvqZpcgvymi4d4cU4Pd186vVT
 vsAFsZpBMDzbt62vrGSzMFURx7rGzI78o5bpdOqxNRNaXo8IOHvWH1WZzcujXcl9PeEVAapvbDF
 f9ncnbyisT40Wlxwk3FgdhdrCW5Fe2z/6xcL2j1saUeiTXmDTIl0q9N6P
X-Gm-Gg: ASbGnctF+n2a+4JR2rUex8nXw3JCzqcaH+t4I8qgusYigX8QEPN32MnM2oTUzmJGlnr
 Ca+Sim8E6sXQQk6ov2ylWkDVCToobnl2f4yUIMm6x73DpnR/3Xzm8xGRGjMfTzIyqr0/WbvWURg
 jrhk7ahd5DihCAl+vRMIrOjP0mMnthJr1kCKA6dARd2PZspNInKW4PLnCpXidJwQnYEDupiGdjZ
 83yAidl4Pz+wdFqcyWbEBDf2HpF3lBQ7Q5XGRS5zBu0zxyTQHNV2qM5jOwElg6P7UgYMj0KvNSN
 Y3u8TOSVtyTk+aLLt0sOIZsblaCKDUgI
X-Received: by 2002:a17:902:fc8f:b0:235:737:7ba with SMTP id
 d9443c01a7336-23ac460753bmr53506665ad.44.1751028456822; 
 Fri, 27 Jun 2025 05:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDA+GhWES2/Q3RITXzFqguPC7i6aXc+ehphiHBrf+dIsDDFY+7DHAkEQRa/cof6lzoadHRpw==
X-Received: by 2002:a17:902:fc8f:b0:235:737:7ba with SMTP id
 d9443c01a7336-23ac460753bmr53506125ad.44.1751028456407; 
 Fri, 27 Jun 2025 05:47:36 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bfcesm16731575ad.135.2025.06.27.05.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 05:47:36 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 27 Jun 2025 18:16:59 +0530
Subject: [PATCH v2 2/2] backends/tpm: Propagate vTPM error on migration failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-propagate_tpm_error-v2-2-85990c89da29@redhat.com>
References: <20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com>
In-Reply-To: <20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7204; i=armenon@redhat.com;
 h=from:subject:message-id; bh=WsVU/9NBhRGrVqgURcGwuX9m1ptUgPf3rVjADOG97dM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0bcpEvn3weenCe8jGfl9MNm3Zr1cW8DL7XyyM38dU3gA
 tupEwL/O0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAEwkYhbD/7r9558vkT5/Kapz
 q+WlJZc6px7Xlp3aFL9UZccUae6FsXMY/pluv7izs6o3na+jXtzbbV2A0qvFKdkmG8XrsxZ+4Np
 4jxkA
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

- Introduce a new post_load_with_error() hook that will
  take in the Error object as a parameter.
- This error object is set if the loading of state fails.
- The error can then be retrieved using QMP command
  {"execute" : "query-migrate"}

Buglink: https://issues.redhat.com/browse/RHEL-82826

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
 include/migration/vmstate.h |  1 +
 migration/vmstate.c         |  4 +++-
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..816134d7b4de00a75a3d0b928d160595b17be810 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -819,7 +819,8 @@ static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
 static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
                                        uint32_t type,
                                        TPMSizedBuffer *tsb,
-                                       uint32_t flags)
+                                       uint32_t flags,
+                                       Error **errp)
 {
     ssize_t n;
     ptm_setstate pss;
@@ -838,17 +839,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     /* write the header only */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
                              offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
-        error_report("tpm-emulator: could not set state blob type %d : %s",
-                     type, strerror(errno));
+        error_setg(errp, "tpm-emulator: could not set state blob type %d : %s",
+                   type, strerror(errno));
         return -1;
     }
 
     /* now the body */
     n = qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->size);
     if (n != tsb->size) {
-        error_report("tpm-emulator: Writing the stateblob (type %d) "
-                     "failed; could not write %u bytes, but only %zd",
-                     type, tsb->size, n);
+        error_setg(errp, "tpm-emulator: Writing the stateblob (type %d) "
+                   "failed; could not write %u bytes, but only %zd",
+                   type, tsb->size, n);
         return -1;
     }
 
@@ -856,17 +857,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
                              (uint8_t *)&pss, sizeof(pss.u.resp));
     if (n != sizeof(pss.u.resp)) {
-        error_report("tpm-emulator: Reading response from writing stateblob "
-                     "(type %d) failed; expected %zu bytes, got %zd", type,
-                     sizeof(pss.u.resp), n);
+        error_setg(errp, "tpm-emulator: Reading response from writing "
+                   "stateblob (type %d) failed; expected %zu bytes, "
+                   "got %zd", type, sizeof(pss.u.resp), n);
         return -1;
     }
 
     tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
     if (tpm_result != 0) {
-        error_report("tpm-emulator: Setting the stateblob (type %d) failed "
-                     "with a TPM error 0x%x %s", type, tpm_result,
-                     tpm_emulator_strerror(tpm_result));
+        error_setg(errp, "tpm-emulator: Setting the stateblob (type %d) "
+                   "failed with a TPM error 0x%x %s", type, tpm_result,
+                   tpm_emulator_strerror(tpm_result));
         return -1;
     }
 
@@ -880,7 +881,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
  *
  * Returns a negative errno code in case of error.
  */
-static int tpm_emulator_set_state_blobs(TPMBackend *tb)
+static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
@@ -894,13 +895,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb)
 
     if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
                                     &state_blobs->permanent,
-                                    state_blobs->permanent_flags) < 0 ||
+                                    state_blobs->permanent_flags, errp) < 0 ||
         tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
                                     &state_blobs->volatil,
-                                    state_blobs->volatil_flags) < 0 ||
+                                    state_blobs->volatil_flags, errp) < 0 ||
         tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
                                     &state_blobs->savestate,
-                                    state_blobs->savestate_flags) < 0) {
+                                    state_blobs->savestate_flags, errp) < 0) {
         return -EIO;
     }
 
@@ -948,12 +949,12 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
  *
  * Returns negative errno codes in case of error.
  */
-static int tpm_emulator_post_load(void *opaque, int version_id)
+static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
 {
     TPMBackend *tb = opaque;
     int ret;
 
-    ret = tpm_emulator_set_state_blobs(tb);
+    ret = tpm_emulator_set_state_blobs(tb, errp);
     if (ret < 0) {
         return ret;
     }
@@ -969,7 +970,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
     .name = "tpm-emulator",
     .version_id = 0,
     .pre_save = tpm_emulator_pre_save,
-    .post_load = tpm_emulator_post_load,
+    .post_load_with_error = tpm_emulator_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
         VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3be5955978b6b7d0b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -207,6 +207,7 @@ struct VMStateDescription {
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
+    int (*post_load_with_error)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 158dcc3fcddfe70ab268dc5ace6e4573fa1ccbab..0048c4e1e7ee1d6ff3a3349abb0dc1578985a56e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -236,7 +236,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         }
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_with_error) {
+        ret = vmsd->post_load_with_error(opaque, version_id, errp);
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
     }
     trace_vmstate_load_state_end(vmsd->name, "end", ret);

-- 
2.49.0


