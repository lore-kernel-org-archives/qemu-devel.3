Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3B606A33E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aslv5Y7J;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J2rGzI6W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3e-0000qw-Jn; Fri, 20 Nov 2026 07:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3c-0000pe-CE
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3a-0004lM-Oa
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWXrbqJoIWI67nNPfPVrmoK5FoKi8MMDx293CLAjU/U=;
 b=Aslv5Y7JbuWRgJFrBHh3xcu7LDa8LasVi1JZuhZaX8FBi8OQEgUF8B/rMlQou0sAMF7U4X
 dV13puS3rlvsueSAkRT4bRVT4NppcJJwkZFrcQRnRXfkt6XKX89gHL8Z+syVUjYw4gSjkJ
 rUUko7l+rEQ+bRj8yMQeoL0T/SIQsmg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-UW3JAVUFP1OuUTBNPXBw4g-1; Fri, 20 Nov 2026 12:49:31 +0000
X-MC-Unique: UW3JAVUFP1OuUTBNPXBw4g-1
X-Mimecast-MFC-AGG-ID: UW3JAVUFP1OuUTBNPXBw4g_1795178971
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55d846fd50aso2703211cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178971; x=1795783771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWXrbqJoIWI67nNPfPVrmoK5FoKi8MMDx293CLAjU/U=;
 b=J2rGzI6WpaJkLwI0HdyIORdbmEVGyvHt+uraX7dNoE2LHais/xDuI+JMIDTsB9rEJk
 iV1MPrWJEVEjMAhJ5A/xN3EVtB8uqAK47efTe7Fc3ldEBSr5iW0fxt58uEDu1zX1z29a
 +kIvBl/vUAufvTrq7pivcliukFP3BpmL7dx03/RMzO3TpaNDqtTXnATv4MQ5Nd2/g/No
 8Qn4lwu82jmsdjOike1qibdrz5YRotUvdUKkoSTAQ7+bo1tDviISnvglTAZ9WYX8ciaP
 896duw8jVsoIEvozsLkWMondmHIINeu7LUGYBCwrZ7vIBYtoFw4D6DER6nUaIjHdUcKp
 5Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178971; x=1795783771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWXrbqJoIWI67nNPfPVrmoK5FoKi8MMDx293CLAjU/U=;
 b=RmpCLiNfCmiMt1nriZDlC8TcZsu377OhTziqlnnA9eEFQw8Eu9yKDGET+iVStGuA78
 HLuTz7kfjXS3DT1kRu3q1DL97ZSjEe2U8T/hv/gcTxutoOguBmVcLOR0ISthsrr1Mhy/
 2hCB/UcgdphlLBBzot63hjvRramHhQW7bOfRzGI/nWlkLh3QVV/o2llFgDuoVKao/z1w
 J8iDOtTQ6aMT+fiym8a5ahrWaKMgkhBkYd+YjMzrQhrokUDmJPLxQh7YLBRNWt/bkbev
 uLYltEzOWE1OsGRIUAjUKTVL7AD9qoQGHzQWpP5GvZBPb0daikN9/bHpUNZdLdlUEd31
 gk+w==
X-Gm-Message-State: APuU4Z9+g/vBUtdm1KpMN7O53TIUDsyfcIbRFoEaIrfuhfF+ecGeagZw
 Ut7ENl8O9F7Yk3U4XZ52TUCUcCiM+8lK5gljssPrB8bM8DZxenTHtG7DdYtNEuJt2zK+n/pPpbo
 yjiZIIH5Nx9hMKC4nD4oSYbvp+RELmHN/aCiDl9zaWqKoQztxovpSbvMcjDceNeWow/K789hrf5
 wXA6smwntwmEVlURUXfPZMz88KPX5jQuAd+N/czg==
X-Gm-Gg: AYBFou1Xzl2PKQbhISSzGvcCVejCjgHHrXsp4by9fA5NZ4IQ5nOvtl3d6IZF7cnufGx
 5EpDxA33JmJ/hwxnPp3Wpyf4YVEpV/c4Tul9pZrauz3k2afE4njdCop1ToXfMukz9K5ITPgy/tr
 bWq/C5LBnaOSbujHAC8A1XJycbe9Bn8mq+KdPpv2CAqxW8A7gXi+atSenKe9JqVjS8trh600XWc
 sXXmiMUAPyYnDyq3v3IxxOlmH9r0vl58qS/1ohEJto6cHj4I7Q86SQvK20K8v8AzbnbFSdg5bjg
 p5QHkYD/fVW0RbmQXG3efKf72Zpb/U1NGfR+BpA5j+L37EChYpQtCckQD8loFKyQaeVliwBV1p6
 k/IJ3lahPvgD4tXtghRGX9q0hXYLoWtUjHSKlrIfpnAOf
X-Received: by 2002:a05:622a:60e:b0:535:a5f7:d588 with SMTP id
 d75a77b69052e-55d76a811d3mr49713391cf.66.1795178970882; 
 Fri, 20 Nov 2026 04:49:30 -0800 (PST)
X-Received: by 2002:a05:622a:60e:b0:535:a5f7:d588 with SMTP id
 d75a77b69052e-55d76a811d3mr49712991cf.66.1795178970345; 
 Fri, 20 Nov 2026 04:49:30 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882ea2dsm21610551cf.15.2026.11.20.04.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:29 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-12.0 3/6] hpet: Move VMSTATE_VALIDATE() check into
 post_load
Date: Fri, 20 Nov 2026 07:49:20 -0500
Message-ID: <20261120124923.1656220-4-peterx@redhat.com>
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


