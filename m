Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BB7CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrK9-0001LT-C1; Mon, 08 Apr 2024 11:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrK8-0001LJ-1G
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrK6-0001r4-L6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTrT2BEVdcUWgqnmnvX6ad7E9+4n+PuOGXheGFWkRfI=;
 b=cc15dIc/hWaRCxVVvLSACOLTD90A7rjVC8R/vQIz/CBwJBTpzF2mHSWfnp/3+Vix7us/ub
 ZG9afpJXydVBsq6WxHu+pd5OoM8PehldnjA+7dAb7vtnlB93cf0AAzZ6ueuWrhMm3h/r14
 Ao58es6BQmECVwbg1MlB/MNg+0wdg20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-cmH3mPuGPIS0AQihc0w2EA-1; Mon, 08 Apr 2024 11:54:16 -0400
X-MC-Unique: cmH3mPuGPIS0AQihc0w2EA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4165339d3a5so7513905e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591654; x=1713196454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTrT2BEVdcUWgqnmnvX6ad7E9+4n+PuOGXheGFWkRfI=;
 b=Yku6i0ujnbGKSy4/HfuT0qBGkcuw9Qd0oxQm3UR7e4k3MXz/ih/Ct6Eswaoq/OsT1B
 sq5CU3YHUNjjwhtZxBHuo1nRzIhm8aEJJNxJg79Z3h6Rqdye90C8S45znasYqc846VFQ
 Btb7JO6SaT5+qk8biA/cUUTrCGq7AOp2WapExzsKXDEjHBtxPePtrX69BwMBmExywRtt
 xbsng2IpKLnGfkTTkOPkUbJS8OJ4c4wyraRy7otm19ucJxRjOAiWJIZAGdTlDjsOTbDn
 HAd1nLOkmo5sli0tQtBk4px8vUQSVWqe8hjBBt9jDcedB0qvD2WRM9xz05U8GqzQ94u4
 z5eA==
X-Gm-Message-State: AOJu0YwRvnSzrCra+zGd+g2GCUJ7BM73KiZNSWiPj3JfORutIMOgoqv1
 KZTTpvb/nAWdqLsly1qoExSnuibTn3+WkV0R4yB2Ov/t8bT2AI8dHFCevBqsg7LP0pmHKJ2tzZF
 zcw54qQ1HWeLN8XkaA6X0Em6a6DGRq+ThwIAHp4WFcrkK6FYKZIM3fY74HWddKQOggFcpfRQZ0v
 Huk/VIpFBvQcDPGLL6oEH2BF3oJ4AZbVdtgH59
X-Received: by 2002:a05:600c:3592:b0:416:8152:8a70 with SMTP id
 p18-20020a05600c359200b0041681528a70mr1347598wmq.33.1712591654767; 
 Mon, 08 Apr 2024 08:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsAfPLKZcP/L4W12iqKbbF1J8CSVamSQWifNyHScTj3pfsqnHu7p+STcDmCalydrTXyhm1tg==
X-Received: by 2002:a05:600c:3592:b0:416:8152:8a70 with SMTP id
 p18-20020a05600c359200b0041681528a70mr1347591wmq.33.1712591654520; 
 Mon, 08 Apr 2024 08:54:14 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c358f00b004156b689edfsm13918903wmq.33.2024.04.08.08.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 14/18] memory-device: move stubs out of stubs/
Date: Mon,  8 Apr 2024 17:53:26 +0200
Message-ID: <20240408155330.522792-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Since the memory-device stubs are needed exactly when the Kconfig symbols are not
needed, move them to hw/mem/.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/memory_device.c => hw/mem/memory-device-stubs.c | 0
 hw/mem/meson.build                                    | 1 +
 stubs/meson.build                                     | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename stubs/memory_device.c => hw/mem/memory-device-stubs.c (100%)

diff --git a/stubs/memory_device.c b/hw/mem/memory-device-stubs.c
similarity index 100%
rename from stubs/memory_device.c
rename to hw/mem/memory-device-stubs.c
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index faee1fe9360..1c1c6da24b5 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -6,6 +6,7 @@ mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 system_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
 
+system_ss.add(when: 'CONFIG_MEM_DEVICE', if_false: files('memory-device-stubs.c'))
 system_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
 system_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index 92887660e41..a4404e765ab 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -31,7 +31,6 @@ stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('physmem.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
-stub_ss.add(files('memory_device.c'))
 stub_ss.add(files('qmp-command-available.c'))
 stub_ss.add(files('qmp-quit.c'))
 stub_ss.add(files('qtest.c'))
-- 
2.44.0


