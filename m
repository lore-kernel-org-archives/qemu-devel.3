Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB9606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ampg6iFI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IrJ7joHk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWihy-0008CV-Is; Thu, 26 Nov 2026 18:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihu-00088R-Ie
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihs-00063T-AR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWXrbqJoIWI67nNPfPVrmoK5FoKi8MMDx293CLAjU/U=;
 b=Ampg6iFIGNBMKPVqiRMl5nyrUO5n8Lnj/QJBoyLK27BTLFdjhcbUtbP2SbB2TI2k7y7VvJ
 PPzmZl7zMTcFC2uO4790GUACyVczNOwO+PMXw50d41cptL3Mc5K1/IV72WXfYJ6xbiOuQT
 iPBTcWMckgoa9XSExnpQfH2CK44Z/A8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-44b_zG4jOwSscQWwHckwsw-1; Thu, 26 Nov 2026 23:16:45 +0000
X-MC-Unique: 44b_zG4jOwSscQWwHckwsw-1
X-Mimecast-MFC-AGG-ID: 44b_zG4jOwSscQWwHckwsw_1795735005
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-55d846fd50aso52227771cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795735005; x=1796339805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWXrbqJoIWI67nNPfPVrmoK5FoKi8MMDx293CLAjU/U=;
 b=IrJ7joHkINXHjLAU/tRCXoztIOGeF2wFCBCGwHY18xvPpHxf4jzDIZengBaUcB2I7t
 NeMeQAlipDOlrgybfQbAGrEee2rBfGkmR3EIRoWzBoopg+9zchkG9NuZy/qaDqZsHhop
 zudq00zfhLC94vEUu8jXeusRrhOAdGXM3aI9NH8kNz/oQLNt7fkmBNTRD/r2c/IrObG9
 TpfUlq8equHS/fT8gKb/NQGEvdxMCL+zLIWUaax+1WsrEsPVjiJi6WOtlhRR7/b6AAT0
 xq7e3Uy9wCVquc6FdfOU+SmuiztII723KCBTCYSJFTNM813eaTMlZxvNazkeUah1JsDI
 36SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735005; x=1796339805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWXrbqJoIWI67nNPfPVrmoK5FoKi8MMDx293CLAjU/U=;
 b=yFaPmgVEC52fLF8UXkFSp/fvGS2zemDdzcZCOSw2zSBus8vG07VDV74LT5PCb8SiN8
 fV3IT5FcIr2t/uAWlD94WuhlLRGVH7yaAIgJxy9RZRPFKh1Lx7qwCrasrGO22JPPjE6G
 FJA4MrMZgPZepDbE+00cVskclIQJ35eStv9RfyzFdDdoFi2UVs1XRd7E51aSfSskZ+u6
 7TTV8eoWO7ReC+gR8NZNlEXjedKXEAaVdYJee9145lZGGbbDKxvrFdZ+FoZ1E+QDaX7K
 7GOHGtxW4i5gyJvjfGW/1oVCcAO3E5xB9t7v55oF7YcGCskA3ASkHzP/E1jinGamCAG2
 RmJA==
X-Gm-Message-State: APuU4Z/7CgkRPeScEgk9T1gNFI3NaBYz81d/YppWxN0fUs+GVKsp/Neo
 zyo4efZAr0fs30fbuTAzG00uQiBZI1pfgJKxOtrB+kq+SfmDmcBSgAeA6ZUMyQ6twXapR5HTvzq
 TVy3Fptjw+upaxIHc2SBOYoa2jDCj5Vq6GHGYQ6roBCF/vOC4wqNHX4sG1qcSWpJz0D0nvi0UWD
 M082pj35qOROpi9f1brnioeqxpYo/j8yNwIoVIbg==
X-Gm-Gg: AZFdTZdVFE2O3QLB3DVv0b1hc3RfMOlBo0fPj5Ni6BFq8TmYXZb3m8r6Xb4yVyFxS5C
 7XywinNg65qcP5Tu/mEsi0IEmMkUm+FofikkiY379zsonCGxy2yUsiRHYJS8lNWeF10U9WT6gjc
 vEaXDrBBaID/uCx0MH1rPEUPeS7BcV/g0qTmEQSeTRQRBPJnmO22sos1ApuCpptzghC3V5ozGiS
 3T6o+QyxfRTkNM55DD4WR5qyWK7O5FtIXwgYHGZmJ6zS6eicVt3Ep8r3tlSz/FsJLB7H3YxOosW
 waIoSeoBr8ufPNGxZKRnPwLlGHzc71GHJyNZbFOyIvuur1vslBh4NsuEGpkDRk7ezHtlOFOaMSr
 FKBlSVsCAZkbUVqk5ptOYppQKCspkF6cULPo7/9piwITO
X-Received: by 2002:ac8:6545:0:b0:537:b9f5:cd69 with SMTP id
 d75a77b69052e-55d76aa8ef9mr406133241cf.75.1795735005101; 
 Thu, 26 Nov 2026 15:16:45 -0800 (PST)
X-Received: by 2002:ac8:6545:0:b0:537:b9f5:cd69 with SMTP id
 d75a77b69052e-55d76aa8ef9mr406132781cf.75.1795735004640; 
 Thu, 26 Nov 2026 15:16:44 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921347a0b6bsm197783836d6.1.2026.11.26.15.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:43 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-12.0 v2 6/9] hpet: Move VMSTATE_VALIDATE() check into
 post_load
Date: Thu, 26 Nov 2026 18:16:28 -0500
Message-ID: <20261126231631.3392756-7-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To pave way for removing VMSTATE_VALIDATE(), move the usage of hpet into
post_load.  To make it safer, loading the timers with the num_timers, then
only check against the wire number at last.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/timer/hpet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 42285cff76..85cd26a454 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -254,25 +254,28 @@ static int hpet_pre_save(void *opaque)
     return 0;
 }
 
-static bool hpet_validate_num_timers(void *opaque, int version_id)
+static bool hpet_validate_num_timers(HPETState *s)
 {
-    HPETState *s = opaque;
-
     return s->num_timers == s->num_timers_save;
 }
 
-static int hpet_post_load(void *opaque, int version_id)
+static bool hpet_post_load(void *opaque, int version_id, Error **errp)
 {
     HPETState *s = opaque;
     int i;
 
+    if (!hpet_validate_num_timers(s)) {
+        error_setg(errp, "num_timers must match");
+        return false;
+    }
+
     for (i = 0; i < s->num_timers; i++) {
         HPETTimer *t = &s->timer[i];
         t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
         t->last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - NANOSECONDS_PER_SECOND;
     }
 
-    return 0;
+    return true;
 }
 
 static bool hpet_offset_needed(void *opaque)
@@ -332,14 +335,13 @@ static const VMStateDescription vmstate_hpet = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_save = hpet_pre_save,
-    .post_load = hpet_post_load,
+    .post_load_errp = hpet_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
         VMSTATE_UINT8(num_timers_save, HPETState),
-        VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
-        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
+        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
                                     vmstate_hpet_timer, HPETTimer),
         VMSTATE_END_OF_LIST()
     },
-- 
2.56.0


