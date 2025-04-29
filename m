Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AF6C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9leY-00039G-0Z; Tue, 29 Apr 2025 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leT-00035S-5C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leR-0006ST-Hv
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so7012002f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935773; x=1746540573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjm2NV3MsVuXzERs7qPetKCBg7pCwU7Ow/3BPmE8MOo=;
 b=s8tELiNfdWUMK/re0nnttFyDPyg2LCNNmhEUpPibsumqSYnO40Zt8XpMUjb1lkNvCB
 NP+PF+gIgDd2b7r/qUWLh1ymJuOZy9NPGXhyUTIOef7XoxUzZP/kll1KvzngCti0P/kM
 6zx1E1wporjSQD1NStIOr2Qm2lMTdZWEcSYVlxW3TekCh833Yv6ZkXpHp7ZfCHZ/IK9a
 Hqx6Hfouz8Se47CzoLTjBdN27QtaNsxFvmT2lIbmjHvPIb7osieqdTTNw5oBDkpflhrI
 3tXIbv4rbuUVVktpSyoCSkLlkZl7+rl04iQ7hfi2uhnFjWD4nB+6Mmh/KCXZPdtO4Y7I
 x5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935773; x=1746540573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjm2NV3MsVuXzERs7qPetKCBg7pCwU7Ow/3BPmE8MOo=;
 b=IbfTBdTg8dpJ78wQq4HHj3x2DWzMMy3NlE4dXqQS8FcMP01cDV6hP8or7omsrEx333
 B2PuerXaTaVMOOAJtn1sdBZovKxtr8lyoDP/zGXHSQ393V25JLnDOnXLwDNnedUNNz03
 i433P7xmUgzWUfaiH0dYe3U/E45duXd0jELZNypiIThEirKSTz6JUvEf0F9b6dITCGpX
 CR47Btc8gCOn5B2EkiqBJic/DqHpel7ZRv6AQSbhc/ytDrXunJ1JpyvDd5G6BQggwlSt
 4tUSUzVxYcnQEwY+s7yjQltEB6wKwVpdUsjwVEDA66O4YJ69k3qgXk4eEQsemGpbvDW4
 8zeQ==
X-Gm-Message-State: AOJu0YxMBIt4UUN5z8ywTZMxsbErqqd8k0qYdm1isPJ2767ixUlkX6B6
 ueAFixKNWXYyFy2SPLRZ4GnyM7Bb3yiq0nh0ujIQ0dGQsimVtUoFvSiXTvc6r0/+aHAFtNNDTxH
 Q
X-Gm-Gg: ASbGncul+K9cfnY6kHSYJhg0zgoA2rebwqJ4eOXsaCxlWlJA2TTD9VlGVsi7UoMaBqw
 Ag04PX6/QpViRxW/H41bgsT9MQi4YZnwnLM3Zw0yOReLszYYQPGE1NtR+G++/OkNfPGHcXaYUm6
 0UGAmLEOF4MAqsSW/pdHgWZeQlI0JXX7khoLi6NBq+5woVqEBaYbWxKHj8Sq8N++9LJvRasfuno
 7UH54lTeRwPlGIUPQkfexNW5esrst81jxLMp3vsdJqdiiM03JSwu4HWjGP3V8G5d5pHUo9jg0u2
 Pkv/bY/BXPUqf/akavFLMsxmkr03NhYjIIpHNh2ZiePLsrWFqN6OTXSh98Ps7SIrIYPe9Y/w4bP
 TMFel+/0PBiLJHDgn+b71
X-Google-Smtp-Source: AGHT+IHmtjd22uvPcFnUpa/nMrx3oCiUUi2PRaaIGjDRAHalryLJau6NB77HdgTQ0VKUnMxJQN7Nrg==
X-Received: by 2002:a5d:59a7:0:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-3a0890a516cmr3487498f8f.2.1745935773168; 
 Tue, 29 Apr 2025 07:09:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm14065276f8f.1.2025.04.29.07.09.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 13/19] hw/block/fdc-isa: Remove 'fallback' property
Date: Tue, 29 Apr 2025 16:08:19 +0200
Message-ID: <20250429140825.25964-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The "fallback" property was only used by the hw_compat_2_5[] array,
as 'fallback=144'. We removed all machines using that array, lets
remove ISA floppy drive 'fallback' property, manually setting the
default value in isabus_fdc_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/fdc-isa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 6d1790e0e61..090b91361cd 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -112,6 +112,7 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
+    qdev_prop_set_enum(dev, "fallback", FLOPPY_DRIVE_TYPE_288);
 
     fdctrl_realize_common(dev, fdctrl, &err);
     if (err != NULL) {
@@ -293,9 +294,6 @@ static const Property isa_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1].type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
-                        FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
-                        FloppyDriveType),
 };
 
 static void isabus_fdc_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


