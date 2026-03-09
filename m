Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8143DF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcvz-0007KJ-CI; Mon, 09 Mar 2026 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvm-0007Ez-Eq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvj-0000LW-QO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so17544945e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071642; x=1773676442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vQ2Sn8Wbqu1NrXuJtMyexGGxp0O6O+LoeTC8M+EESYw=;
 b=hWev81pIKmphWWSpLrOAF0CA1WQ22MJXkU4PPtBhm05fzvi8EzioAxJRQ+eDitb4kB
 UkhalOxwOsku5CLr0eDAlZ5s3MDArbuY+F0CvcmiHQilJSDVpuUoTJmnIk0xC5BgAeZK
 6Rnef4JujChbyZ4lC5WWj96DNfc8uZ0PuuFKGBBllhRwky7PRCaHSLb/++Pnc3AblBUC
 WDj4f9bc/PTOkTD4fpuhAX+YCL4lIRpIJ0aV96KBtyaKqNl0Y7T77uXUP1t67+DZV9R8
 qsHQi84m3ZxNfm+qfyxv96islowNDNBabkwAimCNXLzJl+LECdkubphz7kBTZ7uI5D+5
 V3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071642; x=1773676442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vQ2Sn8Wbqu1NrXuJtMyexGGxp0O6O+LoeTC8M+EESYw=;
 b=stWh7l3uRRQWN3CvH0Vk3jv2Z+bN61Uq8GN3vSW7rKv5/9Fv7J4I0SDxDo6hHhZx7D
 +qBPfd0a1aKdbb25Rfh9eLJ5sz39oG2pW+74sfPY44L5tc1qJOKmqQZhEOcuTfOpPVL7
 gowgF/cLyTF0zfmWau76HzKJmlWbz1N4ZryL+wUrBuGQsO4CaeO0s+dpB3RxO4K4tSSy
 JAXqoPJgoW9re7kMXVSHkzHzeq18CAqFQjVG6JAqzrWkLle0pqASMTPd1VvxK4/7Wyai
 bcjr4Xnsr6cVLQDaaTFPxo938GrvuzLXX21i+4lQ4dj8acpk6FwfrkzIsmSqLdai5wTe
 YK3A==
X-Gm-Message-State: AOJu0Yz8cbPYN9unRgq6EI0mLYUcAIYFICuvpM6gZGt/iH3+nefJEjse
 Bd+KYsvg5kEuPQu2K74Odtw1qc3SogI1xmpPxip/rm1Df+LuUvO3Px0/pot4tn6Wmx3unCgXK5H
 DdHwMg8w=
X-Gm-Gg: ATEYQzyK99qNgPIjYZm1nRKbxusjLJCd5xK8ajRMU7Kbm0V9EgKrlBW8KFiqM0nTe1y
 viqHSfdlZxjNXloGK+lXdKtNHLYkISaPlB+tH9LJObVSMmHyH6Ahii67eEXQtw9S/E1Qhx2Kdv/
 18f8jJTKw81/5mQ2o8TF7zUGmxZWrOmgs67mNJz7CZ3l5pSUSF8cTgRtKXkaRruorZ15R7CZVZ5
 1Mq6EtKXxaooqbc/QxZwBR380+BHIMjl7a63s3PZuV7sYZXqURXuixKx0tGQzQ7P+ryOhbn6X3d
 sfyl8UvqtNTIn9Q80ar6N1sZhaGE8kCa1TPK46ONFF/7+YLc26xvqDeKe0+CUUdfPmhUbELqmLK
 V45ZiyLnydnSh3xs5VT2a5tGc7aPNqhWUo6DINUAeCcJioRwYDkiTjsXXtI0/Qyx6KMyjzWs0Ir
 CuRrJqspYBCHrRa8YLejbmuRDJKeusLuNtVi5v+y/iamhKCUIxaSXtSaSCqKNt6vCraaEyNF92
X-Received: by 2002:a05:600c:8b2f:b0:485:3a59:99ca with SMTP id
 5b1f17b1804b1-4853a599b8cmr81905465e9.16.1773071641839; 
 Mon, 09 Mar 2026 08:54:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb3668csm558452765e9.13.2026.03.09.08.54.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/49] hw/rtc/pl031: : Remove PL031State::migrate_tick_offset
 field
Date: Mon,  9 Mar 2026 16:51:45 +0100
Message-ID: <20260309155219.62400-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PL031State::migrate_tick_offset boolean was only set in
the hw_compat_4_0[] array, via the 'migrate-tick-offset=false'
property.  We removed all machines using that array, lets remove
that property, along with the pl031_properties[] array which is
now empty.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307154202.86309-7-philmd@linaro.org>
---
 include/hw/rtc/pl031.h |  1 -
 hw/rtc/pl031.c         | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/hw/rtc/pl031.h b/include/hw/rtc/pl031.h
index c8b26c2f00e..75779c63122 100644
--- a/include/hw/rtc/pl031.h
+++ b/include/hw/rtc/pl031.h
@@ -36,7 +36,6 @@ struct PL031State {
     uint32_t tick_offset_vmstate;
     uint32_t tick_offset;
     bool tick_offset_migrated;
-    bool migrate_tick_offset;
 
     uint32_t mr;
     uint32_t lr;
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index b56877c3a20..09d1b15c779 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -278,18 +278,10 @@ static int pl031_tick_offset_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pl031_tick_offset_needed(void *opaque)
-{
-    PL031State *s = opaque;
-
-    return s->migrate_tick_offset;
-}
-
 static const VMStateDescription vmstate_pl031_tick_offset = {
     .name = "pl031/tick-offset",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = pl031_tick_offset_needed,
     .post_load = pl031_tick_offset_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tick_offset, PL031State),
@@ -319,25 +311,11 @@ static const VMStateDescription vmstate_pl031 = {
     }
 };
 
-static const Property pl031_properties[] = {
-    /*
-     * True to correctly migrate the tick offset of the RTC. False to
-     * obtain backward migration compatibility with older QEMU versions,
-     * at the expense of the guest RTC going backwards compared with the
-     * host RTC when the VM is saved/restored if using -rtc host.
-     * (Even if set to 'true' older QEMU can migrate forward to newer QEMU;
-     * 'false' also permits newer QEMU to migrate to older QEMU.)
-     */
-    DEFINE_PROP_BOOL("migrate-tick-offset",
-                     PL031State, migrate_tick_offset, true),
-};
-
 static void pl031_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_pl031;
-    device_class_set_props(dc, pl031_properties);
 }
 
 static const TypeInfo pl031_info = {
-- 
2.53.0


