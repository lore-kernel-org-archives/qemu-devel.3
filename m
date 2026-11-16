Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01A606A79A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XEORzx0P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueh-0003xD-1V; Mon, 16 Nov 2026 06:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueF-0003p8-VS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-000288-LW
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1533886f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827593; x=1795432393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x9fh8JA9gVFz8cwQu86NZFxxA8oztzeT72ENqRdxmBc=;
 b=XEORzx0P/liPYcGORXFJwGiPSIkLxLKn7LamSAWFjuXmbkpRSjqK85LeON61hgIGVP
 f2Go62wJ2S5DKuVlu19hEh9aHUezAnlD3Nklo/paV5iVQwQGzk76EqivRwOp9sFL4yNL
 aHfJmxvB8grQgmmurhhWgnsYGIlIZJ4iFFXCSyco25SO1B9TQL7cCAPF3/1dP59+ndyR
 hhZ6b4jZR55+ZyLAJ5NJkOY72xZM1p5GCXunFirl2HDDDRNYlLKFOYy/RNZL4ceQEXOx
 XSpNx/TOLVpfWDK2I57/T10iLioiEmF8AelFLkm75hUDhC84taGZ0RjKWNd6jhYrX3R3
 1iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827593; x=1795432393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x9fh8JA9gVFz8cwQu86NZFxxA8oztzeT72ENqRdxmBc=;
 b=dmBFS7V6DWXQfK+BlZjENQFQWqgJzfmEedxIdn5jkKmu2jDubWGScQYKr4tqetEt+u
 uT4bOw8UPph6Ng6tXci/ZAJIlWHT8rkoiMZiDLpqqkewU64OesuB2lAqccqI8nu0M7WB
 9C9Aez1qmFdQ5ixbFm72MSD6PbmQrXcLygV8zrbunreyhr7z0EWN1LwWxGuXGRn/4du/
 kh+J1Pd51xQW47Z2vUrPbZx7Qt53Z0LxxlpL2l+8GS6AltfgvkpkqfLQGf5e52PeOsOa
 1DUQ7fvyyWjCQ3VD68yTwMRbzI+6bolTADg1JMeGyK9chrJdJiUdNnOQk9L70IHJQxHS
 j+YA==
X-Gm-Message-State: APuU4Z9jV/pEyPLFCoQlOLpPWD6hr63En6puCMZXt6+rDzKJVhYl2AV2
 CSE5Zr7LnYvbnuMQv+RFsvVuZyarQ0AmlBnWWPpEFMu14BjjR+Hog7BJA1oDnjm5CVlHm4ylv8o
 tcWJrpWc=
X-Gm-Gg: AZFdTZc2eWgG8ZEhOFUM8aSya2Ny0J4mK7dksnQH10lB6iInSLA1h5TgBgHOMDfpepS
 bDT/6oLlzW/HnboLEGbwaB7iiSqArS3XaFw2JsRLzuU3ztknRUcr0HcYpGv6cm7h1//j6imiNI0
 nQdzybQeZ40dvDSv/qakG/t4u2NThq8Ym1sHYLX8KE6gwrzGeni7k2WJSEJeAHPtQ5lR08mJ1zu
 7rxlxvcqlXCw+mQkXVFzj/Cx1+QEE8tSi8FpdEAc0evITldJKkya7i8Np06Tw6vloTpmPNjOkow
 lxXUQa9wdAIZ8RS+o/SoS8E2yXfntReMlJr59PZjqXxJwYQgMaR6Ro3sQvynV9M9vH+9ZRQg4BP
 Nkh467W9pRhkhdEUjiXjePtwVNu3Ecz5oVuVb7F6H0jBetsdEDhTRVz4BS0SiptIHOmnziyUSvT
 OQ5mbEiE4HcNH0yVWwtj8nsE80d4NB1engA4JoN87bkAgo766Oaa+yeXqzBsmXG8ld4Nl60k1/Q
 RpKCZs25bjVL29PF6vYhEz7UO8cwkv5kGzSsIDVSKSqhaLa+4ClYZmwxh02GNjBtBpfMf0lgVJm
 hkcKS+PN0Zr5TzZGfGLKJst/ExE6KRWNnXHhBbKPFHK/7YjGpC8MpiEIu6MgpdnLg6QQdza7XZ/
 WYn6Kacc6nE8bGf3f9PhgjcRgT/K7cWM2iA==
X-Received: by 2002:a5d:5e02:0:b0:499:81db:47a3 with SMTP id
 ffacd0b85a97d-49c71e3e123mr21600359f8f.11.1794827592704; 
 Mon, 16 Nov 2026 03:13:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/33] hw/core/qdev-properties-system.c: Don't leak str in
 set_drive_helper()
Date: Mon, 16 Nov 2026 11:12:37 +0000
Message-ID: <20261116111303.1692832-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In set_drive_helper(), we call visit_type_str() to get the value
being set as a string.  This is an allocated string, and we're
supposed to free it, but not all paths out of this function do so.
In particular, the "block backend already exists, change the attached
node" code path does not free the string. This shows up as a memory
leak under the newly added virtio-scsi-tests/replaced-node-size
qtest:

$ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
  QTEST_QEMU_BINARY=./qemu-system-i386 \
  ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
  ./tests/qtest/qos-test --tap -k \
  -p /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi-pci/virtio-scsi/virtio-scsi-tests/replaced-node-size
[...]
Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x55f7744155e3 in malloc (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-i386+0x20115e3) (BuildId: 271ffb42d2e322de7813813d8c6cc85351e48a4f)
    #1 0x713dbd345b79 in g_malloc /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gmem.c:100:13
    #2 0x713dbd35b988 in g_strdup /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gstrfuncs.c:323:17
    #3 0x55f777208021 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
    #4 0x55f777208021 in qobject_input_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qobject-input-visitor.c:542:12
    #5 0x55f777204d1c in visit_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qapi-visit-core.c:349:10
    #6 0x55f774df80d1 in set_drive_helper /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:129:10
    #7 0x55f774dee9fa in set_drive_iothread /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:224:5
    #8 0x55f7767cc5c8 in field_prop_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties.c:89:12
    #9 0x55f7767ec12b in object_property_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:1562:5

Switch to using g_autofree so that the string is properly freed
all all exit paths.

Cc: qemu-stable@nongnu.org
Fixes: d1a58c176a11b ("qdev: allow setting drive property for realized device")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Message-id: 20261105114635.3286252-1-peter.maydell@linaro.org
---
 hw/core/qdev-properties-system.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 4d605c20561..d5b227dbecb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -120,7 +120,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
-    char *str;
+    g_autofree char *str = NULL;
     BlockBackend *blk;
     bool blk_created = false;
     int ret;
@@ -155,7 +155,6 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     }
 
     if (!*str) {
-        g_free(str);
         *ptr = NULL;
         return;
     }
@@ -209,8 +208,6 @@ fail:
         /* If we need to keep a reference, blk_attach_dev() took it */
         blk_unref(blk);
     }
-
-    g_free(str);
 }
 
 static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
-- 
2.43.0


