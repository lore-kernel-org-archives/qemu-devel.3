Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC2C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrK3-0001KU-Cr; Mon, 08 Apr 2024 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrK1-0001Jx-T6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrK0-0001qZ-De
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8MpXgSrFJSCnePEmrzhpTfLb35G0CERg/TyFB4eszo=;
 b=A8wC9N7/WnAj+TWZwt06qIuj8YxOAeVbje0kTxmFvEVhad13dXHCf3dyqBMkJSS7wsT6i8
 aNcBkKXKUOEhSJthOrDprEqr6/6kSPo62tBIsp8+17EbtHBetvQ0DChQmvw8abQLfYGVVy
 PGo6uETkwIvkOBC97RxvtIhLHB0l2Wc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-K8SqHeFrMB6qGkJEtwsrVA-1; Mon, 08 Apr 2024 11:54:10 -0400
X-MC-Unique: K8SqHeFrMB6qGkJEtwsrVA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41663c713b7so6462065e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591648; x=1713196448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8MpXgSrFJSCnePEmrzhpTfLb35G0CERg/TyFB4eszo=;
 b=eweWsyDW6rv9A7BUZeSiKIYxKzMvnvMre7stt82e71gpEQ/gkgr9ISS7ePBJHqwRRn
 jIPhv/D4h3e288YamN2XF3QqvMTk9V8C/ihn1QKL1pFY0Kncg/nzXxftGGF9PboMw91a
 5HRtSkNibp2RdofPFp6KSJKByjPm3rFSnkpxWv3BOoM6boagU46Q1NvS82BORD9OFhrU
 4HFeF4RGydbCJ86XZSqDOySgNeHt++I8Wo1yCTso5wodfI2xyVC5+oAzjDlQ2PQGriS/
 RvljuCpcn/oIGXX+8gq3//yIBqBpe3oGd/SF+9N9Ira5+2gPif8/ol1ouBptcyj4ujOd
 BPIg==
X-Gm-Message-State: AOJu0Yx3oM7esbTaiUg2ru598LpFBcqIRcQtCosZCfNvssF327MBjPqc
 nGQiWSvo6SCnjgZ/maX54Mcac8HYfRFedDcLuxnk2k2CybYxRYgoBe5HCT9AFNxmPwUB4hOB4pm
 Hz2YluxEVQgJU5R9M80EUA5uNTuNAb6Eo6gBFdaM8iNIa4K7eNoRVQRALXLVoLpyhL61HQbF7qN
 7mANcSrjtQgXTVmWSnWPpWnHurTwgp+vm9KOnG
X-Received: by 2002:a05:600c:3b05:b0:416:350c:db48 with SMTP id
 m5-20020a05600c3b0500b00416350cdb48mr66708wms.9.1712591647835; 
 Mon, 08 Apr 2024 08:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP9lHEYolnWP9iqS/nlVDLY633f/HIAymM5td6KUGBoZefnbs6NoGM8NjjedsS6fvl3gVyiQ==
X-Received: by 2002:a05:600c:3b05:b0:416:350c:db48 with SMTP id
 m5-20020a05600c3b0500b00416350cdb48mr66698wms.9.1712591647565; 
 Mon, 08 Apr 2024 08:54:07 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 m37-20020a05600c3b2500b00416665d3e09sm5019754wms.9.2024.04.08.08.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 12/18] semihosting: move stubs out of stubs/
Date: Mon,  8 Apr 2024 17:53:24 +0200
Message-ID: <20240408155330.522792-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the semihosting stubs are needed exactly when the Kconfig symbols
are not needed, move them to semihosting/ and conditionalize them
on CONFIG_SEMIHOSTING and/or CONFIG_SYSTEM_ONLY.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/semihost-all.c => semihosting/stubs-all.c | 0
 stubs/semihost.c => semihosting/stubs-system.c  | 0
 semihosting/meson.build                         | 3 +++
 stubs/meson.build                               | 2 --
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename stubs/semihost-all.c => semihosting/stubs-all.c (100%)
 rename stubs/semihost.c => semihosting/stubs-system.c (100%)

diff --git a/stubs/semihost-all.c b/semihosting/stubs-all.c
similarity index 100%
rename from stubs/semihost-all.c
rename to semihosting/stubs-all.c
diff --git a/stubs/semihost.c b/semihosting/stubs-system.c
similarity index 100%
rename from stubs/semihost.c
rename to semihosting/stubs-system.c
diff --git a/semihosting/meson.build b/semihosting/meson.build
index b07cbd980f2..34933e5a195 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -9,5 +9,8 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: fil
   'uaccess.c',
 ))
 
+common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index 60e32d363fa..84ecaa4daa1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,9 +55,7 @@ if have_block or have_ga
 endif
 if have_system
   stub_ss.add(files('fw_cfg.c'))
-  stub_ss.add(files('semihost.c'))
   stub_ss.add(files('xen-hw-stub.c'))
 else
   stub_ss.add(files('qdev.c'))
 endif
-stub_ss.add(files('semihost-all.c'))
-- 
2.44.0


