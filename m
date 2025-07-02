Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE1CC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvnY-0002mA-0k; Wed, 02 Jul 2025 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvnO-0002jQ-El
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvnH-0006Gl-30
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751456302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBB/9guopiXK8gZ2++8NbRE4QeYOjI3e5QVO3PR4R2c=;
 b=i+6HrgP0XwGTgAwX5rWx7uuRMc+ZwuM7WQ8PG0Or4zIb3UJ6oqBlphK1zo646mG60O8UeP
 UB2KgTZqg8gqsdpJJgJHhPz8BpDfCWnROu0L9x3N05RsBLPFzcpAiXkrVdWdiT7e2PIL7c
 N0cDMPuOnRv4DRA6c2wS/F8uBWs6qFc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-sUKpUljJPEC70jsYObSzdA-1; Wed, 02 Jul 2025 07:38:21 -0400
X-MC-Unique: sUKpUljJPEC70jsYObSzdA-1
X-Mimecast-MFC-AGG-ID: sUKpUljJPEC70jsYObSzdA_1751456301
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235089528a0so63188775ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 04:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751456301; x=1752061101;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBB/9guopiXK8gZ2++8NbRE4QeYOjI3e5QVO3PR4R2c=;
 b=gg8+WkbEL1oX5AAj5Sxgs71XOkWV66bGIJYkV9cta3nY5x1h0+3MmvcZxCJB9m+Y+J
 wiGj09LqTo8RionvTg6ScmC5E17P8zTiADdjiJ5W/fuFv3NMHlAkPazhDfXf0M42gePm
 qq8rHZKjju/pHROLcyyp3gAZges8lpby+8QjI3b7uU4FAK3nhERSmUBGJ3Pmfmyklvfy
 3alAuJPnzWmN1Xk4W4gtZ1FXImnN2y6gyh62/KvdbagM8KeobXjLl5J+EU0IuN1CRSFT
 PECtsevK7yqi4ijePfnYQIxKGK+TGw30zBUNBwoWKA9s55ymX4nrowExx0scISSliPfL
 6o8Q==
X-Gm-Message-State: AOJu0Yx8hEHTBSPQIbt2/9gWZ98EtcsTWTKRCqHw1CQEkEyExCiFyHxR
 88Ba3JW+bLxkbIvf0VUm0IoLrVfVpIER4M+ZZM+uG/CKeSq/QFdn4JFCdWsSFTta53TMJrxxm7L
 MLIWvbSwGkmCZXS+dUn4/UTV+Celtik4xOfumcsXZAi5wL9LgvqkGuCZo
X-Gm-Gg: ASbGncvAmKAASZLPkQzrOZ2T4nqYG4D4GG218qjTWQoxiReV95KAWAqd1I7v5WIzHe0
 TdqvcsT7VQGcvzE7W3p1vrA9mF0BrIOjtO19UfdyJ7K6H5ohS1jeM218qJgJyCesND3oSkNEs28
 evKPPlWEoTEdop6b+zx53w1zLOIfihLGWKSl+0ARgAAjyR3xlbXiTeQ1Cxu9/m+5dF4MtWtAtWF
 6d8IufM+Voy4Wczt33k+Ri/lhmV17JMl8WAXmUqnXpSfb1TI5r0i38uybLQfXj8GqMEtr13jJVt
 tfr3UNrkVeSbIxgKvuOVt1b205XkkS1rd0E=
X-Received: by 2002:a17:902:cf0d:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-23c6e80493amr36310765ad.20.1751456300449; 
 Wed, 02 Jul 2025 04:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUBshxAa32+7Ex0UAMEyZYN8HiXOxZpEuhfSXsIKwc9sUqTNlBhXVsXg3AEdUWkOpb2g3fwg==
X-Received: by 2002:a17:902:cf0d:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-23c6e80493amr36310235ad.20.1751456300049; 
 Wed, 02 Jul 2025 04:38:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23b0b3bc0f1sm84265205ad.171.2025.07.02.04.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:38:19 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 02 Jul 2025 17:06:52 +0530
Subject: [PATCH v3 3/3] backends/tpm: Propagate vTPM error on migration failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-propagate_tpm_error-v3-3-986d94540528@redhat.com>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
In-Reply-To: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
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
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5848; i=armenon@redhat.com;
 h=from:subject:message-id; bh=wAhoO+RFXA5Im1Bw45FB6TkuwidRO+tG4hzoqJUl0wo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aqFH/D/Z8paa9EMzdeUPF3+hJQctOgxNVFQMlk7uwc5
 SUlnL4dpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJqJVy8jQduWwNI9iwTOrX66d
 obevX/+4x97oqube3jVWUxheHrEsZWToYufO+T7bfPts/vsTp4WzaeXNXftlvY9La/mT3Uee6Ke
 zAgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

- Use the post_load_with_error() hook to propagate TPM
  errors.
- The error object is set if the loading of state fails.
  It can then be retrieved using QMP command:
  {"execute" : "query-migrate"}

Buglink: https://issues.redhat.com/browse/RHEL-82826

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

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

-- 
2.49.0


