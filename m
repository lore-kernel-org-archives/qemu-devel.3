Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C22EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb6E-0001AB-7T; Thu, 01 May 2025 17:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6C-00019Y-95
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:40 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6A-0006XP-Jq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:40 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d81768268dso11950385ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133537; x=1746738337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+9tG6D5CrQpBCxb8rCcSa1c4gmLBRkbtI6i0IG/w1E=;
 b=eJAPIuGoHz+Os1ioFy6Diov6MpfVL59X1ly52+VBSCl7qsfIwbMwkkKLb43kohHlBU
 LXpuEdY5hLoBK7moDYFkrnHUcSY67fK9PE8DjLC3pnpmCwf2+B1eJpzDEAB6vk4Wrevc
 KP9LID+1ezZP7sR9bXtbARcaC/WMgUsyb6/H9/IvCFzBzFhP0f+E5K9hWc/q4nlc2Ppn
 i5M6cK4+0veskFSm0vtYEhHI+zYuu7kdqTwVh+qljNZCAjoo/cRjxuZVi53EFX5wCeFe
 LULiJlK4Cgja+/u5iVYAvbsTaKEqAX2IZXKjLyPygWBjHcxTY3wMjlmY/FtGu5LW1/4l
 SWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133537; x=1746738337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+9tG6D5CrQpBCxb8rCcSa1c4gmLBRkbtI6i0IG/w1E=;
 b=ttdT5BtAnpIH5I9/K0hXZ5ZnvPWJW5VOtJw9d79hn9z+BaGWA/0Ks16mItwNOuPfZl
 nZXqu1SZ3v0FKTkBwWB/mX5LG20/OIRG54pGqFwFS5MjF/KKjj7PJ5mOS0jqMb1o+NfG
 xul9z68ZgQtDxp+7fONpQPzfzHEYejPLgdemFWEg67PHDFgiIYocE5V7qHpK40GdA5/0
 K3wBpNiHleAMkwW5jvIDXIqfk5RMaYUjvGvg9AZSe8l4qLKSAKGeGNtaPQ3gNj+E6X2w
 sr15uo5gwJWHM6HZkCDgqZUcEDGW2znBzGbPB6KJY+h7BXA9aBR6JSOCPqPdjBgvxtGx
 hdvA==
X-Gm-Message-State: AOJu0YyOsRyUKiNb5uUgpPSD0ex1TXCHVol9NQUO+tFcSwSGD9sSuVyK
 Isbq3gyp2x5K3f0HQgnWl2i8OPc+fvqJLZ4gsU8ZEMfW/kStu4c0iAiyywBe1Juaed7lPKu4sE2
 T
X-Gm-Gg: ASbGncvjq5typ2P/IJR9uBzCqUgNhh7NVdJLzzAuKAvkUOUo+QzIdqUhohpOQcEmVzW
 3DF+LktaHLqUZTE9Vk50bF2T7EwEKzi16na2Q4jTTRlo3k0H6tsF1CaREYShHzT8qghKrN2NVs3
 m4gTd+14WugsOG4RfAx8VmiVCMJ63nKqPA4hUCjH4ImsegKDipl+n4fV1+Jq9ysca79tK5nFJ2s
 PIaHiV4VU/T0QATILqJWvuKYLm5HLSDtudjQ/VrSgB3DQHpUsKZI+u4RCfJBq6Pm9vLc3PMVeme
 jWYD+aqND8w3DLCVlaeS2sddRkGkijcsZkBFsb9C6/wpgylGrWQc3R5NJ4Ea+i5WbKBU8oaGhjS
 rWQKR4Iz0ZOBWIpQ=
X-Google-Smtp-Source: AGHT+IH+u44+gr3VhAkwNxNdek+w2gvKkYRpBzQeqoif+zOyBP4Kz54Rrnu1ivOMXpo9f6cHu3CQ5A==
X-Received: by 2002:a05:6e02:1529:b0:3d9:3e8e:60da with SMTP id
 e9e14a558f8ab-3d97c237917mr4932745ab.17.1746133536916; 
 Thu, 01 May 2025 14:05:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a918039sm48520173.55.2025.05.01.14.05.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 04/18] hw/i386/kvm: Remove
 KVMClockState::mach_use_reliable_get_clock field
Date: Thu,  1 May 2025 23:04:42 +0200
Message-ID: <20250501210456.89071-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The KVMClockState::mach_use_reliable_get_clock boolean was only
used by the pc-q35-2.8 and pc-i440fx-2.8 machines, which got removed.
Remove it, along with the 'x-mach-use-reliable-get-clock' property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/clock.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index f56382717f7..726ebfcb0cb 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -23,7 +23,6 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/i386/kvm/clock.h"
-#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 
 #include <linux/kvm.h>
@@ -43,9 +42,6 @@ struct KVMClockState {
     /* whether the 'clock' value was obtained in the 'paused' state */
     bool runstate_paused;
 
-    /* whether machine type supports reliable KVM_GET_CLOCK */
-    bool mach_use_reliable_get_clock;
-
     /* whether the 'clock' value was obtained in a host with
      * reliable KVM_GET_CLOCK */
     bool clock_is_reliable;
@@ -232,18 +228,10 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
 }
 
-static bool kvmclock_clock_is_reliable_needed(void *opaque)
-{
-    KVMClockState *s = opaque;
-
-    return s->mach_use_reliable_get_clock;
-}
-
 static const VMStateDescription kvmclock_reliable_get_clock = {
     .name = "kvmclock/clock_is_reliable",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = kvmclock_clock_is_reliable_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(clock_is_reliable, KVMClockState),
         VMSTATE_END_OF_LIST()
@@ -304,18 +292,12 @@ static const VMStateDescription kvmclock_vmsd = {
     }
 };
 
-static const Property kvmclock_properties[] = {
-    DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
-                      mach_use_reliable_get_clock, true),
-};
-
 static void kvmclock_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
-    device_class_set_props(dc, kvmclock_properties);
 }
 
 static const TypeInfo kvmclock_info = {
-- 
2.47.1


