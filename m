Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957F4CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2i0-0006j8-En; Tue, 23 Jun 2026 11:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-aA6agcKCn4ltjknmgiqqing.eqosgow-fgxgnpqpipw.qti@flex--jrhilke.bounces.google.com>)
 id 1wc2hy-0006is-2d
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:38 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-aA6agcKCn4ltjknmgiqqing.eqosgow-fgxgnpqpipw.qti@flex--jrhilke.bounces.google.com>)
 id 1wc2hw-0006oJ-7o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:37 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2c725d3e886so76670875ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782227194; x=1782831994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=mLeTvO+TAT0U9Hqanhzqp9AmOAQssIaaKQ1hKkdaXcs=;
 b=DTTUf6+Ks0CBcUo3wA7iTI2XoDL/Di0ZIRcE15K39VsCRdSoE5FkCJESJjRR5wj+VQ
 3mHtbhDqv4WiqSPSfvQ7sb8VdxKTyn8wBI5wPpQ5W8IMFjd0xIubWwDMluhU/jvvAxdM
 9m8XOtS3VBhkga39GzXrco2cTZX29hYHE8b3qZo2hD9wfzF8GLZaXrKqk4IsRffNXJjv
 HpuW43EiHOYdB1iUxDHB4PLZeBT9Qos3nLa5u3/2j3DlQkbldgGUaxssaFRl7RKQhO32
 ogF+eE9Rvc1VhXfZq9IPy5ruiFDhhomrHWKRvY+FrKTZOTfUA8V8nM1prW+MpYPT4qlf
 E6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782227194; x=1782831994;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mLeTvO+TAT0U9Hqanhzqp9AmOAQssIaaKQ1hKkdaXcs=;
 b=Wv1EF4taB4b0uLBHUG2aiap3Rv/rYOkYOgeF/uAyg4fuldDqTuq60R0uJz3/xo/C5N
 mEgic8wiPrxcptP2Cal/ARNRTWBevq+sQuIzcIxFbFAkF0DOUEbf7sYthGFfG4bbT508
 mFt9wGuAcaZERYl0+Fjw7eM/Lr6NCetSwrxLwBGnNXfF18eA4wci8QALpR+/B3mJVEpn
 m86sfWTLrHT5qk7k561ns2ST47teSmPBU6sntO0wQ9UlKh5nJnxK2L29zDjYUGqLVmc3
 NXd7Ba+iFRjdfA0C7pHiGwhO9QotWc45plTHUlUvOI39oKcVkNROL+y0pQd4OBoUQCkc
 if5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGIo8zoYixWTjn/hDBXFlrsra2DZQxfpL31svzpyEUzBBsJFY1Sj2SXXP/otvgk20sEIhcCpKpz+KP@nongnu.org
X-Gm-Message-State: AOJu0Yxk2nQ5RdccvGmjFzlPVqNYCi8lBRaOHYw/ry2CsvdUdWY3Sc2i
 iDRib6S2v290V5h7MXmreFX6+ZTbveAdB8/qTyqPhfHRUOZ9DRyiEJ6sf4uTt4UBIXTeS8MqO2v
 rXmB4D4/H
X-Received: from plof5.prod.google.com ([2002:a17:902:8605:b0:2bf:1274:c8f])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce84:b0:2c0:ab92:584c
 with SMTP id d9443c01a7336-2c7c9a2884dmr28369985ad.25.1782227193727; Tue, 23
 Jun 2026 08:06:33 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:06:00 +0000
In-Reply-To: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
Mime-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260623-igb-trl-v8-2-c9b1fc6c3304@google.com>
Subject: [PATCH v8 2/7] igb: Add VMState support for TRL state
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3-aA6agcKCn4ltjknmgiqqing.eqosgow-fgxgnpqpipw.qti@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add VMState representation for the Transmit Rate Limiter (TRL) state to
support migration. This includes the TRL timers and target rates per
queue.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
---
 hw/net/igb.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index c076807..773da26 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -563,6 +563,45 @@ static const VMStateDescription igb_vmstate_intr_timer=
 =3D {
     VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                           \
                          igb_vmstate_intr_timer, IGBIntrDelayTimer)
=20
+static bool igb_trl_needed(void *opaque)
+{
+    IGBState *s =3D opaque;
+
+    for (int i =3D 0; i < IGB_NUM_QUEUES; i++) {
+        if (s->core.trl[i].trlrc) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static const VMStateDescription igb_vmstate_trl_queue =3D {
+    .name =3D "igb-trl-queue",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, IGBTrlQueue),
+        VMSTATE_UINT32(trlrc, IGBTrlQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_IGB_TRL_QUEUE_ARRAY(_f, _s, _num)                    \
+    VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                            \
+                         igb_vmstate_trl_queue, IGBTrlQueue)
+
+static const VMStateDescription igb_vmstate_trl_state =3D {
+    .name =3D "igb/trl_state",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D igb_trl_needed,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_IGB_TRL_QUEUE_ARRAY(core.trl, IGBState, IGB_NUM_QUEUES),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription igb_vmstate =3D {
     .name =3D "igb",
     .version_id =3D 1,
@@ -591,6 +630,10 @@ static const VMStateDescription igb_vmstate =3D {
         VMSTATE_INT64(core.timadj, IGBState),
=20
         VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription * const []) {
+        &igb_vmstate_trl_state,
+        NULL
     }
 };
=20

--=20
2.55.0.rc0.786.g65d90a0328-goog


