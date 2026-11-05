Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C4606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WdmhKr8I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvvY-0004MK-6X; Thu, 05 Nov 2026 06:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOvvU-0004Lt-NQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:46:40 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOvvS-0005zy-U1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:46:40 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1226536f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793879197; x=1794483997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CJB6qusbJ8tyksMbVVI6J6ynrp4ykLCnIeVaWrqmqOU=;
 b=WdmhKr8IZICu0DCeywwpU6IvQ5K8brWJG4jjXzlKj5eEcIxI6j4kHcCuLOiRKSMhFl
 y1sErbsCFShmtsa4LH2RIpaA7adBGvRUsLI1rOmbIAc8sKxrNb2xFjSPE4C6V9211tqH
 mRn+c20S26c70/aDlvORVI/fKijm6r0i/P0jE0ncieUHC74xHSLA7lbv5yZd1NBpiewC
 FJZK1FUk2QY2WNY7NAvboxPhnbprcziGH8vtmK0lIdPp0TjZ5Rn/tL3m8igt9S2Jg0cf
 crjyMKw47eZ7X37Yvq01UUnP4ckEmJnGqiKmnE57w9ZoqMlRFM1swbxaHxosAMy7aNuw
 QFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793879197; x=1794483997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CJB6qusbJ8tyksMbVVI6J6ynrp4ykLCnIeVaWrqmqOU=;
 b=JNdTmzBO/hjMiXTP+T3V9Zdgt/aSfM/wKTHynRUS1IFNh4raHGKOTH6lBu3lfoplE3
 rC2jlk/oJ7uNArtk6hRJW5Awuq/4SPloXn+H8auyRpombpolIu4XyNe92B5BQSd5LFYB
 kxeYIQ3vN1Dgf9vF12iD3D00k0yMTsDlJCK6aU52QiajbV2m7frm0xZuMDbHjHn4jun/
 3D8nucxad1xC4il3dLMYmmtU+UlNND3E5LSEX68oaiVF6Zat5YqR3+d6l2cQ9ha7490I
 copvyWWlvp45ttmnfrGSfpVVO6i06OkolvgiXIkQ8N3NTnLeRCsf6ModwY+kt+MZfba8
 p4xA==
X-Gm-Message-State: APuU4Z9Lxpmoj49jVMA+gNZTEB62mwm//bKbqGtY0+1gxzH0XX8wEK7o
 iPtJZ7o/pdAQnozc95KknlcQL7NXJ/DUVOLTgZUIUwxrlMLJInJdhi5OwdCOrddKfhnyVb0C7WB
 OxD39U5I=
X-Gm-Gg: AYBFou3XzWlBrdlBCYgbGP0OoAJSoPpoKB2VTwjX2K2GpyVmWkDgnzvE3Ld3fDm9RCo
 szHjoZKUjjwCfds0u8OTzoqJS0HMXHJ+feXLTVIvh/47xuNAby1drz376j3kKgkwHqmCdjRQwIZ
 JD4nXinUpRXeRiK6lxWu/g9+LhQteQkpzglG6E2GzCesO4zd8AMWu1/rOtS8mQgndL4+FRDgUR1
 OCM7Dcy02Rk1nhh6GSd8pjx1rb/0vKSzo6kmNfoGIBCKME/JwjbetiEY4MIsRJ1TUVfgrGMRTUk
 MaT6kbcCkyE4iQL8L69C4BZKzefTbd2WYo1b5wDLQNerXVeDjh14zLgzQvUCvQqdaEvqWGeBc15
 etCb1Gyook9V4zn3nb3GXubaADMuG9qLJPprlirXxtMiw051uOm0+2AKWU7xu3Z1mIAyiNdmSUJ
 Bz+SHpaa25xRcSwkIYF1Q38ZwCJqkBsSV9D6ZcHxs1CPfK99NAlDG3FH1IJhVzvDp0yVOEtItIg
 J0LuSUb8N/fsgkS7yqa1aPWo2s9qWMbeDhor/dUdyUUUnEPcm4uzwEOmrtxUEAnxFLrmrBG98Rz
 1y/YV7IjlUaGVqlawmHh0oJlrWvVUTmncwfPXrN/qJK0YEeaYFdr8K+m6B2ch/xImP3w/FZZBof
 ntQ7NCNapTIJJfaQ+/W19gdfnKUb5JoEBz0SxA0uqDcTx8S5mKM6cjMY=
X-Received: by 2002:a5d:5886:0:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e6e2b9e63mr39719757f8f.2.1793879196958; 
 Thu, 05 Nov 2026 03:46:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd40csm9546985f8f.13.2026.11.05.03.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 03:46:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] hw/core/qdev-properties-system.c: Don't leak str in
 set_drive_helper()
Date: Thu,  5 Nov 2026 11:46:35 +0000
Message-ID: <20261105114635.3286252-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
---
Sorry for forgetting qemu-devel on first send...

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


