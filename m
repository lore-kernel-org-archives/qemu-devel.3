Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFE4D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRT-000292-B5; Tue, 15 Oct 2024 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRQ-00027u-7j
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRO-0001Nq-Rz
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdLWe8e10X1kwD0xpB96tiefr/UoeaIQizsR+wID6Y0=;
 b=PO9WjlBMJ/Dez8GfVIPgxLDiOyxy6MNYdVQO++4rq/PA2gGP5mkHvFqUd3sYUbGI0vozRy
 xtDzYAJ+KctDHv2dxoO2+zrv6zNXLmwwvxZbmbe216ZTm1qxamMHC+/RWNpbJuaOaUTFnJ
 UCdfHhlI1JViFPjUc7NsFxeonmkrJNk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-4_y_-o8XPIGdoLv7khvKsA-1; Tue, 15 Oct 2024 09:18:20 -0400
X-MC-Unique: 4_y_-o8XPIGdoLv7khvKsA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43057565db5so28938015e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998299; x=1729603099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdLWe8e10X1kwD0xpB96tiefr/UoeaIQizsR+wID6Y0=;
 b=LYsmeM315ghUK1122ctjRClilBYb3Tz72A6MPDd0O5qifkzEUMz3Rj0LMM4VBBh51G
 UAiskAtOeKWMldq07ki3ss7OQdSqyc+yp8tgBgXLxTod7lqmGHIHTTI7bnQ0cBDCrwuA
 ak35qC410R5QTXYTdV+2G9V7wLYSG9WJ9hJjYiH2aH1bVKBxvahF9fGkuhn+L5Ya/ynm
 DtKXJxB6MzmwhvQc0wDwoNpnOSlANJCbTx80OEYrLIwf6w5Qj32akpfAKV4PHmIIbqHI
 s44d6jqClNVwJWU2/YReHR9ce8v89l5NbwNhlLou4P5AY4uG0++d28MnpRZ+I/HWumDn
 H8HQ==
X-Gm-Message-State: AOJu0YyZ9Hac4YRyS5dViXnb9frDIF3stTPnl/+fTJl/DoJKiX0RuQd9
 wvx07uakO23mXhp2hS2+dReXRHF3oZ+0arELAQNeP8aHg1zLDcVqJwxwHOdjE96Mo6D75Ym0TKi
 r1gUdFyDDbLiVAEgXDaGjI8TPPpuMOBf65HCuZrXv4aCDovMwIkWwq6LaYW6wUpGenPQG5zwyKb
 Nw/XD3PNFjL7R5CTIXwIibrImaJDkZFF/lcQyvp/o=
X-Received: by 2002:a05:600c:46c6:b0:431:44aa:ee2c with SMTP id
 5b1f17b1804b1-43144aaeec0mr13429585e9.9.1728998299168; 
 Tue, 15 Oct 2024 06:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5Lb252grUWQH1PcJrO0kJpoywXi2ebXkYrfEEID1Imy11xOGW5HjR282unTgexG0ZdwvLjw==
X-Received: by 2002:a05:600c:46c6:b0:431:44aa:ee2c with SMTP id
 5b1f17b1804b1-43144aaeec0mr13429375e9.9.1728998298731; 
 Tue, 15 Oct 2024 06:18:18 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43096601152sm181034845e9.0.2024.10.15.06.18.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] rust: do not use TYPE_CHARDEV unnecessarily
Date: Tue, 15 Oct 2024 15:17:31 +0200
Message-ID: <20241015131735.518771-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In the invocation of qdev_prop_set_chr(), "chardev" is the name of a
property rather than a type and has to match the name of the property
in device_class.rs.  Do not use TYPE_CHARDEV here, just like in the C
version of pl011_create.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index f331a13b5f1..ca67d452e7e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -582,7 +582,7 @@ pub fn update(&self) {
         let dev: *mut DeviceState =3D qdev_new(PL011State::TYPE_INFO.name);
         let sysbus: *mut SysBusDevice =3D dev.cast::<SysBusDevice>();
=20
-        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
+        qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
         sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mu=
t Error);
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
--=20
2.46.2


