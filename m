Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02348E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1e-00025e-Dy; Tue, 14 Jan 2025 18:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1K-00021j-V0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1G-0004DF-SC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSPuM/xQN55RkRx/S3nnX/mnwXvxno14BL0e7ID8OVM=;
 b=dLSiulXxPPKrEG8SOxq8+8sJYfDqKK0cQu3ArJ+LFkWKWlwzGajNM5KR5RJ0l/ryKVwEim
 UVCqHFUE65FShHKrInDM05IuxFRkbo51vMkIHmTeipnqjuG24d5fYrb+DUenYFj9Q1kr9b
 PiGsrBYqv711GemZXPZU4eUiWTgeupo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-jxr_NqIqOjqv-opjs7SioQ-1; Tue, 14 Jan 2025 18:08:19 -0500
X-MC-Unique: jxr_NqIqOjqv-opjs7SioQ-1
X-Mimecast-MFC-AGG-ID: jxr_NqIqOjqv-opjs7SioQ
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-46790c5b1a5so151524391cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896098; x=1737500898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSPuM/xQN55RkRx/S3nnX/mnwXvxno14BL0e7ID8OVM=;
 b=Zgoz3ouT8satE7Hldw5JUAv+j4RpEdkTp6UReYA99GlHPm8jBLffct5qcWinqm4fkW
 RZFsibEpwarfciAkCp33HeoIYFIH02s/dWxsC8/35Rg1q3dpVm2VPk/sxjVifjL7JyER
 HeNeHxSNJtNDv5sAAOq6YYvrR7xZIwPe6/f6l0WKaq+VX4ruSMkKmwSwpQfZcKHD0/3t
 be0CsxqYQaBcNX56JXH7RylaPC4wj+/urziUU6U7GZavyAxACLIB4G8GRk6bDqiePQPE
 9iXYUOPwxi9Tkk1cX+2hbfx0UswYhvGVOG40t1wNvLOPwdmjiZdcufFB6EetyxLJkjmP
 Pn4A==
X-Gm-Message-State: AOJu0YxT7ZSA8h9r5nkzG0+DV0ZajNUy5YDgKhMUnkOTCHKA0xje/EAE
 ep1iEYfVgSTDcPgvqqQbLfd6FcRal0Vx0gI3newLmsWz/Hcvx8uap1e5bVC6juoPpaES8zVR/ii
 2KhxCIYFqVhoP2DPvgZuipL2Wmca3gI7AfW2BppHu82jyOwd+UiKdkbg9RUs88g+KGT3AQ7+FI8
 UMsGhaMtRG3j+RTHUzVdjsbvCu3qtlnwaciA==
X-Gm-Gg: ASbGncvHKLs43OfpKTfb+WtUoWPTwCTRgx/lb3SxTbVwEtPf2eUcFfnTlPZt+46atYR
 92fNZipMgbEJ7iE3Wwpi+h4b4WUK30rMSl1GddariQlp91QK+tkh7QFQPRcdmAtKTYq2q5HaetV
 ZDBy6ZQR0HbWav1/fv9KnocnUJaTOARIDvQkMrYoNZto33YcNFjd5S5AcUy5vdWppe5A0+XsyIR
 sE9RXt4aFEbq4d2mlLkE6TDb4/9PvCmFn+3HDKr1eaClG3AgaZvtKPpSTHRSommtOuqyhey4hH7
 HdzJNoTp5MShXFKEbDCNH/9BG2d+jNpF
X-Received: by 2002:a05:622a:1a0d:b0:467:525b:e540 with SMTP id
 d75a77b69052e-46c70fd31d9mr387709011cf.8.1736896097963; 
 Tue, 14 Jan 2025 15:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHHW69C9d68DiM1NK3PXF02OfpzQRaH4AH0+V4LHEgLBBw+tb9CCIn1FEGWOQsCF6uPCePgw==
X-Received: by 2002:a05:622a:1a0d:b0:467:525b:e540 with SMTP id
 d75a77b69052e-46c70fd31d9mr387708661cf.8.1736896097537; 
 Tue, 14 Jan 2025 15:08:17 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 16/16] migration: Trivial cleanup on JSON writer of
 vmstate_save()
Date: Tue, 14 Jan 2025 18:07:46 -0500
Message-ID: <20250114230746.3268797-17-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Two small cleanups in the same section of vmstate_save():

  - Check vmdesc before the "mixed null/non-null data in array" logic, to
  be crystal clear that it's only about the JSON writer, not the vmstate on
  its own in the migration stream.

  - Since we have is_null variable now, use that to replace a check.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 82bd005a83..047a52af89 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -459,6 +459,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 /*
+                 * This logic only matters when dumping VM Desc.
+                 *
                  * Due to the fake nullptr handling above, if there's mixed
                  * null/non-null data, it doesn't make sense to emit a
                  * compressed array representation spanning the entire array
@@ -466,7 +468,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                  * vs. nullptr). Search ahead for the next null/non-null element
                  * and start a new compressed array if found.
                  */
-                if (field->flags & VMS_ARRAY_OF_POINTER &&
+                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
                     is_null != is_prev_null) {
 
                     is_prev_null = is_null;
@@ -504,7 +506,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                     written_bytes);
 
                 /* If we used a fake temp field.. free it now */
-                if (inner_field != field) {
+                if (is_null) {
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-- 
2.47.0


