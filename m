Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4550DD33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qo5-0003OM-D1; Mon, 28 Oct 2024 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlR-0000dz-5J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlO-00040b-Tj
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnNbN2/GG/cHatir8SHvYVVNQ8/dSXQusHp7oYcZdJw=;
 b=R0b9ManYnK5JH2M1DHCkAQIZ1aBA4Wa/S6jw+ly1it2EScdBWoqD1z/CTRcAZT/DSitIJx
 pOpF7DsOWb/iLhaUHWW5mYvb6EB8m5rHhFN8JPuV8BlHSVHi9E26nKvyDg0Q2jp2qenFOO
 cOeeq6jAYB52m+sLxexGaAaKraG5+0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-N_2Eh0skOB20H3OBA8vycA-1; Mon, 28 Oct 2024 10:30:30 -0400
X-MC-Unique: N_2Eh0skOB20H3OBA8vycA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso2434022f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125828; x=1730730628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnNbN2/GG/cHatir8SHvYVVNQ8/dSXQusHp7oYcZdJw=;
 b=ZNkD3gJAb/qEfFsanMtKu2dG3nzOD9G5p0C/ALau46FuBhdw1Ls0UoWKUnKogoyu+l
 90WEpflBqiq14r/j2MTSgczc/zoLCFr7BJa6kHPiBCbN5PVvrOePHbhBt/abg7CsFHGm
 mTglGQu9jSVZC+fmLWcXyYVbQupYpMiECSYTXGk03iBzCnZw6AtmpG54Pwvu6xptklc1
 txI08IQdcnHJVs5IdKPE9Di8RKFY7PAEXQggFhrqhfka4t915Boxdyl5AX/G7gaqSefN
 iaj7ohlwXoytZW34a6adkkiF0rBdxeEUZvJ1txkwkfIOvkQIKDs/nvW+enUI8E/t6r8G
 ezuQ==
X-Gm-Message-State: AOJu0YyB5A1FSbnojhnujpBu+znM5pIMtbFpDjJau+a+k0qlPbYrWL+I
 CV16QFHm4T1KAVvBQVrNeuGNH2J1V5uYcJq+sUHDrrsk9q5sVlBA/AWT8yp3000oO36hdBJOpmg
 hT06q3UqXuyrfbjqy6U80ARsAjMFGHcwPFFsGbmVfBDHbr7q/fp0DtpmNSitUWwYqdHtm6w85xp
 7eqtIO2i1k7WFVVApb3dEnIacomIvMCBd3mo+H2QU=
X-Received: by 2002:a05:6000:c06:b0:380:54f2:3408 with SMTP id
 ffacd0b85a97d-38061143056mr6529030f8f.25.1730125828241; 
 Mon, 28 Oct 2024 07:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjsyH6bB1qi6q0kO0/Doh1av82wreuGOUMs/tD2LCHzJwljal3gYBDqY8F45UnGhU43Ssc3g==
X-Received: by 2002:a05:6000:c06:b0:380:54f2:3408 with SMTP id
 ffacd0b85a97d-38061143056mr6529004f8f.25.1730125827786; 
 Mon, 28 Oct 2024 07:30:27 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bc1sm9687269f8f.70.2024.10.28.07.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 21/24] rust: do not use TYPE_CHARDEV unnecessarily
Date: Mon, 28 Oct 2024 15:29:28 +0100
Message-ID: <20241028142932.363687-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the invocation of qdev_prop_set_chr(), "chardev" is the name of a
property rather than a type and has to match the name of the property
in device_class.rs.  Do not use TYPE_CHARDEV here, just like in the C
version of pl011_create.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 0347a027c5f..b3d8bc004e0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -573,7 +573,7 @@ pub fn update(&self) {
         let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
-        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
+        qdev_prop_set_chr(dev, c"chardev".as_ptr(), chr);
         sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
-- 
2.47.0


