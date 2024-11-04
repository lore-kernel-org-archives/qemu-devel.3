Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A4D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rs-00058o-Bd; Mon, 04 Nov 2024 12:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rp-00057j-SZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rj-0000Ck-Ou
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhAX4O/uTEOcD1m0vx1NVf8UCEBi1EOArDSUiAiYLDo=;
 b=TEZiNy79ijN13bp4mQ1md6L5aea1FiHFks7TPlzlKeYmtP3b1siy7/rRc6sry014/2sO2R
 TjYwBsjQNAx2qpIBvNT1Bt2IzKwNohyv1casPcDje4XDPSHnOVn+ZsT89mnVsu3sSg+Mk+
 2i+DE2l+nPS7VDTupe7NlFiEf2eksDk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-M2UGbusnNUeNdXFYjYkGCA-1; Mon, 04 Nov 2024 12:27:45 -0500
X-MC-Unique: M2UGbusnNUeNdXFYjYkGCA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539ebb67c28so3118229e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741263; x=1731346063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhAX4O/uTEOcD1m0vx1NVf8UCEBi1EOArDSUiAiYLDo=;
 b=mhkiKRwL3ye4+Ki3Cno4DD0C457mTREGaE9SCr7r0/gfyVPO7UACoyRcGNj8uBHDt2
 eWrstvpnRdOQaUDfUZswR1bgashlABr5HMN+vGS8mdSFH/LSQNoDF62bYSsIq74zg2IP
 mExMy9s1JtanFiLsPr6gXZYd8YnNYqIhXvP4VtOvciGTZqO+Tfr1vQ8J+emFOwvuWhEO
 jSj1Rmt26GxHU22V6OQNdbv3FMf8+1O11lEcHC5GRWPWLMNP8LXplAz0RFzXG7U0Vvq2
 l8XVmfmwmRnJIHqBULcGQ88FCM9Acv4svqY/y+qiMqrt+y3RgSvjhuNlQiwaPlPoL28b
 Km6A==
X-Gm-Message-State: AOJu0YxcrRjbTbZikk7uslgUgjWJ/SW1ZSd1Q8dcSApKPWRW+qfSAJuf
 OaYQHlTMoVyynCxW5ime9L9d3gxSQBRfTfE4qSzUMp9MS2coD6olE+v/Epc12ku0h+bq20fqpxq
 wL9Ne4SZ/rhCRPUscISpoFdcq6ZQ/NieV26k+ZSeKE9Mr2Bsey0eFVvfmH4mAFhel4qf7GQWi48
 DbB4AQMXhX4JX0wLfBXeFROmKfejYzQGG2dXPUABg=
X-Received: by 2002:a05:6512:3b1e:b0:539:e1c6:2128 with SMTP id
 2adb3069b0e04-53d65e11a8dmr5771235e87.39.1730741262934; 
 Mon, 04 Nov 2024 09:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0B582pRp84m7/eh5z6hePKdDfQ0WgL9n4QcrtrNq8U+I4BysDqmkYkqeLS38uQ8KtTzZo9g==
X-Received: by 2002:a05:6512:3b1e:b0:539:e1c6:2128 with SMTP id
 2adb3069b0e04-53d65e11a8dmr5771213e87.39.1730741262464; 
 Mon, 04 Nov 2024 09:27:42 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5c65c7sm158964125e9.19.2024.11.04.09.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/40] rust: do not use --no-size_t-is-usize
Date: Mon,  4 Nov 2024 18:26:48 +0100
Message-ID: <20241104172721.180255-10-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is not necessary and makes it harder to write code that is
portable between 32- and 64-bit systems: it adds extra casts even
though size_of, align_of or offset_of already return the right type.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 -
 rust/qemu-api/src/definitions.rs | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 7d06d2fe74e..34328f7394c 100644
--- a/meson.build
+++ b/meson.build
@@ -3948,7 +3948,6 @@ if have_rust and have_system
     '--no-doc-comments',
     '--use-core',
     '--with-derive-default',
-    '--no-size_t-is-usize',
     '--no-layout-tests',
     '--no-prepend-enum-name',
     '--allowlist-file', meson.project_source_root() + '/include/.*',
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 60bd3f8aaa6..0b681c593f2 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -81,13 +81,13 @@ macro_rules! type_info {
             } else {
                 ::core::ptr::null_mut()
             },
-            instance_size: ::core::mem::size_of::<$t>() as $crate::bindings::size_t,
-            instance_align: ::core::mem::align_of::<$t>() as $crate::bindings::size_t,
+            instance_size: ::core::mem::size_of::<$t>(),
+            instance_align: ::core::mem::align_of::<$t>(),
             instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
             instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
             instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
             abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
-            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>() as $crate::bindings::size_t,
+            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
             class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
             class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
             class_data: ::core::ptr::null_mut(),
-- 
2.47.0


