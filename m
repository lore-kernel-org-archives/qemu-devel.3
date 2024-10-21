Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4804D15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vP7-0007kR-BG; Mon, 21 Oct 2024 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOU-0006Oc-Mm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOR-0006MI-IY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLppDWV53KItuDjPGr/az+c8hOztlyzUeTjrRwEDn8w=;
 b=KeTOmW+DrMHb90ndDT0Uzw3R7TVi3rLfT1B2rWezyI3Vo3qxWVabIDTpECS8flJ6xDyAzr
 ynWs63Qso6ESuBk6KJoUAVWO/xlfuM6gHAF8qbIbxw9Rd9R7DofKLHu6UtyOnj8/pCXn3L
 7zvkZ5Ry9PyShEOYb/1rENwgpgy9XE0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-cyt-7jYsMcqxEEcvUIvI6w-1; Mon, 21 Oct 2024 12:36:29 -0400
X-MC-Unique: cyt-7jYsMcqxEEcvUIvI6w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso34318985e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528587; x=1730133387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLppDWV53KItuDjPGr/az+c8hOztlyzUeTjrRwEDn8w=;
 b=XwaQsqTrkHQ8Q8PBT74nE2xiuj7rx13DduLtKSIp8dWoccdgqdykFAdd6sreXrvAGv
 h87q+zCoDYX+RIzymMkg0lFJ/3wobNbjz2SCdtbZHQaaebbExANs1mUtO4/tLnM5Cipb
 9sJFDIdFxeSJwVXvm+s/Wp0izscd8UiIT/0U/KNvhNGwRNVggFW81ZsAhvpDrrdQvMKf
 Q7jjITQ8RGVhm+MwGqANZC3vUtt6L9LjdQoi4qBuWWos3FPX2AMh+I1suEn6BEiZOE9v
 seojJzRH4fv5HYHX0JRNF1+GQsaPjlrAQtW2IeDAgadGVdRINCAYx3493Cwlm4Ce2tWB
 bD7A==
X-Gm-Message-State: AOJu0Yx+w8XkKIQmUjieJsd+ZKCjUvxIZYwTV6olCuJTzkS1MG5rkxOz
 oS3p3pr2ve4o67HLbKl7iMAhwcI1kXkBzakPCE4a3ITQDODwcsA7IrnlWG+W4C1ycYnb32k/SJI
 n0X9SADe8LjQOw3wZ9OULpkOckvol6Rslm66Ftbne9fjN2FLt50aKALaRb9gvyvtHv8nSkQ/1bC
 NLmgjK8ABgj62uPdYVXlGcs7QNi6N4WZhuGxUNQsc=
X-Received: by 2002:adf:f7d1:0:b0:37d:50e1:b3e1 with SMTP id
 ffacd0b85a97d-37eab6da72emr7715256f8f.16.1729528587139; 
 Mon, 21 Oct 2024 09:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0E3RXCUgPvGNLsmyjB1DuEXohlouR9ILqS17064F9Ug1RPc47zYzAaPfTaRs9BJWxTYRhVw==
X-Received: by 2002:adf:f7d1:0:b0:37d:50e1:b3e1 with SMTP id
 ffacd0b85a97d-37eab6da72emr7715242f8f.16.1729528586786; 
 Mon, 21 Oct 2024 09:36:26 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a5c529sm4704753f8f.62.2024.10.21.09.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 13/13] rust: do not use TYPE_CHARDEV unnecessarily
Date: Mon, 21 Oct 2024 18:35:38 +0200
Message-ID: <20241021163538.136941-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2b43f5e0939..0f6918dd224 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -572,7 +572,7 @@ pub fn update(&self) {
         let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
-        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
+        qdev_prop_set_chr(dev, c"chardev".as_ptr(), chr);
         sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
-- 
2.46.2


