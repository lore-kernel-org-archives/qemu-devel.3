Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F3AD1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80s7-0005HE-NS; Mon, 04 Nov 2024 12:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s4-0005Gj-Lx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s1-0000JH-Kd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnNbN2/GG/cHatir8SHvYVVNQ8/dSXQusHp7oYcZdJw=;
 b=fLHHwqP9QsscfVzxCkIRfvWUod0DFsv0bjMCkVO3m0qJ2Nr1etjK/m2NFT8XX4TfH2kx/q
 2vdKjdav5xyxZ3wcL+jf1Uh8uVMoBDB5silNQokf69dazxCA/Mkt5yM2vezlCdabQ0XoL+
 bDY/VX1hTqTKtHOjOagjkAYk8amcK+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-en6nXlSyP4Kw2r6bJ1346A-1; Mon, 04 Nov 2024 12:28:03 -0500
X-MC-Unique: en6nXlSyP4Kw2r6bJ1346A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4317391101aso29007865e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741281; x=1731346081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnNbN2/GG/cHatir8SHvYVVNQ8/dSXQusHp7oYcZdJw=;
 b=mSGeCQGj63l0cmB/KVD6UkDCOLwnEheWIqnLC3OLNR27HpGHF+nkVeepEaQqWLGRFk
 SN3aB/4hUeqCN3kxkWUqS5O0ujwsszmOqDiHY7DB5fImIXlAfQCGViQQrZPhuTZIU8Cl
 n6iNdcT2uY/KuESG6rP1tJ+Zhc8gkhTTfkK+ybF0+wZEBIpi8mh1/lRR6JXBe20KCW7/
 zLRTh5wz4VSLbRhQXyt42HE+DzT9m0WBanYZscb4LrkP3UNbAks/nIucHZamAGMyGFdS
 15VItKyyqL0xydfDe61LXqO3QEA9g0+WRJQHfSkgPLjmI7aB7qxOo+n2UXQYilDxql4I
 2BYg==
X-Gm-Message-State: AOJu0YxHHOtSdHMebwemepvqU8+odVt2y/cXSVCcaEfis3gAoY1rc0Os
 0GnfJ5kSlDJCMvoZ4qNIkQbSG/7COUcvxszA3FUbQbtQvFMxjbqupTjQk9Iy/NL2VdJN0fPp6BL
 MAaBVn4qZ1L22ueI6XiGixUHBS0OKJggA1lJGA99lQXdL0rym6PJJWvgMHoCealc8EUSxPhJrO1
 1tUMinWNTloEP4V+H/onVcu0Wm9c2rPL7UpAuEzrY=
X-Received: by 2002:a05:600c:16ca:b0:431:5847:f63f with SMTP id
 5b1f17b1804b1-43283246cb4mr109632935e9.13.1730741281454; 
 Mon, 04 Nov 2024 09:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfxSOey6TZyJjVfmDTDe9k/TwZjeQYQc92a9I03gILRXMQw/VCMGkfvUlxrdaiJYLpFJrBpA==
X-Received: by 2002:a05:600c:16ca:b0:431:5847:f63f with SMTP id
 5b1f17b1804b1-43283246cb4mr109632615e9.13.1730741281071; 
 Mon, 04 Nov 2024 09:28:01 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983c2sm163506775e9.42.2024.11.04.09.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 17/40] rust: do not use TYPE_CHARDEV unnecessarily
Date: Mon,  4 Nov 2024 18:26:56 +0100
Message-ID: <20241104172721.180255-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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


