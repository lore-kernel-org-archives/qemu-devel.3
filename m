Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F23AD15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vNo-0005rM-IC; Mon, 21 Oct 2024 12:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNm-0005pQ-Qn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNl-0006H6-DN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgNTM++YIgCcMVNRZLJ+GHrP659GMVVlwBbB2mHseDc=;
 b=aM6zRzpALTl2GzndK30rci4luqaGZ0PTPmiPpw0h/6GGSO8BhWTLAfI1Jsub4WstbYH29g
 6WktRDcSGDFxgTci2olWRImg8zgzEU1u8hOMZi4zskuosNioGoaq8XLwNv65RxVg/cygI6
 QkpbiGZcptJ2SUG8gmpp6oXZJ+O+JA4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-CmK8tIxjNW2TpSf28P-6Sg-1; Mon, 21 Oct 2024 12:35:47 -0400
X-MC-Unique: CmK8tIxjNW2TpSf28P-6Sg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so36829705e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528545; x=1730133345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgNTM++YIgCcMVNRZLJ+GHrP659GMVVlwBbB2mHseDc=;
 b=hrcOb0WGBxdj8CqZMMrM6XXqvXKC0le1BVOLbPlMqRpBrrxniKAwC690JqInUAiaXR
 kVJitZH2V8rXRIzVkRfuLmYbBUreuEasWbONzbbOEl2I2S28a7qDw12NvZS1Lnoo9WjY
 xfVaIvCt4JNldtNAk3NR88cDbojc3poW6WRm/Qi4/V+2oMcN/pLq31YEHAeBhYJb2Srl
 2AUYZ/IDGk/FxGow1yU/7DLsmdQrPl80mjOJa2oLwgQz7lrs2D+V9vccGKG9bDnTbGo3
 6d6scQddGHGu5NjEk3n314fBQUNjQgoAKWxpT6Crs63xg6MPcx7KTsRFyx1fiojyz+K0
 uoEw==
X-Gm-Message-State: AOJu0YyWzsLxgEYWORdNUFqlgW0knZ14pbePBSB5Dqy/18BQy+89SM0Y
 i8qTxDkPFor0yQ0U85wtX2gqApeClA+OV8cBZSMQqykwZ31PnRXybIjRR+86QzVSgwWTmHw25sv
 V4A2Ki6rMwesdcTR6jN2/nhX0Z85S3gkQkahyC24Pj8GmH7eyjunaYa1TgUBcAQaOFNrPQZKzJA
 3fQQxKb6+AVkqwFolAzUg7RQN+ALcTauc43zckHkQ=
X-Received: by 2002:a05:600c:4f92:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-43161686a3fmr117308245e9.27.1729528545251; 
 Mon, 21 Oct 2024 09:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtO1iqb6KRvjMiC8dB0Rk81DkMIeot/0voDENG6HbftMXggPeZAB/BRJKdwJOmrXxiaPcYGg==
X-Received: by 2002:a05:600c:4f92:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-43161686a3fmr117307955e9.27.1729528544699; 
 Mon, 21 Oct 2024 09:35:44 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c3497sm62752035e9.29.2024.10.21.09.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:35:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/13] meson: import rust module into a global variable
Date: Mon, 21 Oct 2024 18:35:26 +0200
Message-ID: <20241021163538.136941-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 +
 rust/qemu-api-macros/meson.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d26690ce204..ffd78b6cbb3 100644
--- a/meson.build
+++ b/meson.build
@@ -15,6 +15,7 @@ meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
 not_found = dependency('', required: false)
 keyval = import('keyval')
+rust = import('rust')
 ss = import('sourceset')
 fs = import('fs')
 
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 517b9a4d2d5..24325dea5c2 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -2,7 +2,7 @@ quote_dep = dependency('quote-1-rs', native: true)
 syn_dep = dependency('syn-2-rs', native: true)
 proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
 
-_qemu_api_macros_rs = import('rust').proc_macro(
+_qemu_api_macros_rs = rust.proc_macro(
   'qemu_api_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
-- 
2.46.2


