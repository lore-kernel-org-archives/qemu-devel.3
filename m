Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C560A2629
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVURTqlp;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Wytc0oII
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3j-0000sg-Lf; Fri, 20 Nov 2026 07:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3h-0000ri-Ls
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3f-0004m7-PE
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEp351wB5GQySx79Zc08YPzzjN27Sn3CHKUChdROs60=;
 b=eVURTqlp8490EpdS1u/A03JFRnIqz1EUVXruTrDRv/nofU1qKfCKHBESFRd+UX05se2HaA
 RMPu0u8zgxURP0vB0WfTHu3gcBhpacgekBdzu0qPN41HilKgCh65HvUWO0CqDpEHRxayZy
 bonT2e/D2+Ulym/qEsH5lIcibCTKIUg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-PLd15TT6OcK1HkM-YA9r0g-1; Fri, 20 Nov 2026 12:49:37 +0000
X-MC-Unique: PLd15TT6OcK1HkM-YA9r0g-1
X-Mimecast-MFC-AGG-ID: PLd15TT6OcK1HkM-YA9r0g_1795178976
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d7544d113so19566341cf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178976; x=1795783776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TEp351wB5GQySx79Zc08YPzzjN27Sn3CHKUChdROs60=;
 b=Wytc0oIIRdr8pqkLVJjJ87myPhCclX0fSp0zsu0yChmyJNcS7aYJpTCuvSDJClRKSP
 dVhEZt66Y3Nq14IRLfUpt+Ra2JldA0WomJ4Mkq/qaKZrh8Hf4oiCJuKKQqRKP6c97+YN
 CZ2/sMg6xFMl9K47YfAjIsmTGEuf7i+B1KOFOHYO/p5d68Lt55mvjcaNaapVZH9KPj/E
 mr15aAFs/lQoOzqevk/45B5ms5UKTz66q/ggvE2qyKkfF4NFihQFKHqLRWbXCl3K6OSP
 xOfFBAowyPscCya5u9Z1oulDTq+ifWiKNHxlozqwNdI/VZRmJ2LndYFhBlVR33RSV/6L
 9q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178976; x=1795783776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TEp351wB5GQySx79Zc08YPzzjN27Sn3CHKUChdROs60=;
 b=WsmpXxglYC9WatLPLfC9fF/bRURC8QeHeOrYstThCFgwLiO++cLqIuKrqC1+t8bBVt
 wZ3yOGIg2krGC2L2izUWpuxivWPMEzXx6cyV+fMWHIZMEN91myMDDnUVnO30KfYqQ4i2
 dykS7kl1ULKzSfboZG6ELm2vu4FtfgP71qyxcif0L0sOW/SyfZlgn6S9gKxJU3PpQUPM
 O1u3/klyUt32DjYixe2D6huopLFufkgV4WzhEO9GQ81x6c4iqkD5vg8rpXXDj5pCaTGi
 plmEn+v3/v7vnf7ZuWMmpIWJj2TRTVQDwcS+URtnZ419iBHO/MxxdN1Q+McMWZ2vTn7o
 fD0w==
X-Gm-Message-State: APuU4Z/4ZP0WCVXgh3zttPVQO/A57/oK6cYdPctgqFdK72WSR0uSpl6X
 7bG2WUS0aTOq4Njj6uUGfqopE6XfC2YG48Mkvm8C9Gy6Ki0Ls6Eow75dI7J1uUgjq8/gbfFmS3G
 1OIGBsDf2v/8N183PbDqlnspe81WAjJ2XwhfZTAWH176lP2dp5CUVNwAmfxdPk5rO0z00jz8jD2
 C9Nt0oiKp0kknlZ3jnN7d79en6pCbKpDTop1+oWw==
X-Gm-Gg: AZFdTZduypssCJlZ9qnYxKp4MjfYd2Vxy7j02oOItxnAoRHXW0lIK2g666A8w0VywZP
 wJldNwxPYIkNAmsbOAKMz7hCi6XRWMxhDlrkAuFzULZjiq2qNIsk9eX4oxm3sdeNtda82OlDDV1
 DHDl0W9bANr7PNd3judcOe5hgi/kPpK3TwokSIi+PMbCPiSl44z+2bp+hxOqvnAn8c8UTkZSjys
 awtcGqrl4ZqPee2C20d7l90k5OOK+k9HGcmJAS30KDeMPweYZu4RgTLZZilBwqP2kV1W0q6NYYH
 e9O4ZBYCtsqCOfiQsoKDhyOokORl6Gg/c2kcPZuabLMNCs+/ZawwYeSnDHhJQ1R3zud/+WTcNFl
 DlhHo/okBM0NHXMhCOA/e5mGk9Rn8LLz5lvbAhQWIKAOq
X-Received: by 2002:a05:622a:178f:b0:531:172f:79e7 with SMTP id
 d75a77b69052e-55d76a6595bmr52765781cf.39.1795178976406; 
 Fri, 20 Nov 2026 04:49:36 -0800 (PST)
X-Received: by 2002:a05:622a:178f:b0:531:172f:79e7 with SMTP id
 d75a77b69052e-55d76a6595bmr52765431cf.39.1795178975823; 
 Fri, 20 Nov 2026 04:49:35 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d788074desm21715581cf.7.2026.11.20.04.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:35 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH for-12.0 6/6] migration: Drop VMSTATE_VALIDATE() and
 VMS_MUST_EXIST
Date: Fri, 20 Nov 2026 07:49:23 -0500
Message-ID: <20261120124923.1656220-7-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120124923.1656220-1-peterx@redhat.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We have moved all users to other API, now they're never used.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 11 -----------
 migration/savevm.c          |  5 -----
 migration/vmstate.c         | 12 ------------
 3 files changed, 28 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2901877308..de7a957140 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -130,10 +130,6 @@ enum VMStateFlags {
      * allocated. Only valid in combination with VMS_VBUFFER. */
     VMS_MULTIPLY         = 0x200,
 
-    /* Fail loading the serialised VM state if this field is missing
-     * from the input. */
-    VMS_MUST_EXIST       = 0x1000,
-
     /* When loading serialised VM state, allocate memory for the
      * (entire) field. Only valid in combination with
      * VMS_POINTER. Note: Not all combinations with other flags are
@@ -458,13 +454,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset       = vmstate_offset_value(_state, _field, _type),     \
 }
 
-/* Validate state using a boolean predicate. */
-#define VMSTATE_VALIDATE(_name, _test) { \
-    .name         = (_name),                                         \
-    .field_exists = (_test),                                         \
-    .flags        = VMS_MUST_EXIST | VMS_NO_STATE,                   \
-}
-
 #define VMSTATE_POINTER(_field, _state, _version, _info, _type) {    \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
diff --git a/migration/savevm.c b/migration/savevm.c
index fe94ba96e4..e4f614cc86 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -622,11 +622,6 @@ static void dump_vmstate_vmsd(FILE *out_file,
         fprintf(out_file, ",\n%*s\"Fields\": [\n", indent, "");
         first = true;
         while (field->name != NULL) {
-            if (field->flags & VMS_MUST_EXIST) {
-                /* Ignore VMSTATE_VALIDATE bits; these don't get migrated */
-                field++;
-                continue;
-            }
             if (!first) {
                 fprintf(out_file, ",\n");
             }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 24004565bf..7734caab06 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -116,8 +116,6 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
         n_elems = field->num;
     } else if (field->flags & VMS_VARRAY) {
         n_elems = vmstate_read_from_offset(&field->num_indirect, opaque);
-    } else if (field->flags & VMS_MUST_EXIST && field->flags & VMS_NO_STATE) {
-        n_elems = 0;
     } else {
         n_elems = 1;
     }
@@ -430,10 +428,6 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                     return false;
                 }
             }
-        } else if (field->flags & VMS_MUST_EXIST) {
-            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
-                       vmsd->name, field->name, vmsd->version_id);
-            return false;
         }
         field++;
     }
@@ -810,12 +804,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     vmdesc_loop = NULL;
                 }
             }
-        } else {
-            if (field->flags & VMS_MUST_EXIST) {
-                error_report("Output state validation failed: %s/%s",
-                        vmsd->name, field->name);
-                assert(!(field->flags & VMS_MUST_EXIST));
-            }
         }
         field++;
     }
-- 
2.56.0


