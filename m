Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DDEC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7ay-0005rQ-Gr; Wed, 14 Feb 2024 00:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7ax-0005rA-Ns
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:07 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7aw-0007rV-A6
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:07 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e0cd3bed29so1694490b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887645; x=1708492445;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGm/yeCb4fxZuqjysuL7fb9UBHAA2o92NlG+eX2nX9E=;
 b=gBw+gLNgjqGz4fmd6G1oIj15/ODgmO6+caY5Uy7JqXzeiXGzJ7SxCHT0fT/o0RblY+
 pB+VQ7qweWZzbp1P1+xzmxcduoEXQiDYnL3Er7lwsLMA8Zotv7CImED/obt7BnM5JpMH
 ykZ98CGd976rBDp+0CtvZW1mI/W7rjgjqga/4k1Sk4RiprXCGIgE6iCYw5tVLRVAliJ3
 j9dd/iV84NcnBjf1X4j5vzgPpj3sSuyrBcWhvU4+ZKeZkc1nFWRMnCrQljmEPzrrOOdV
 ocvZ5+PI82/aRDKpOca+FiulXrGElwUuXzjwcN816ua23Us8Z7hE1A1VXPPsq6pF7ixt
 KJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887645; x=1708492445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGm/yeCb4fxZuqjysuL7fb9UBHAA2o92NlG+eX2nX9E=;
 b=pKn5EVuf5VCawqTxR9Xm7AaEeQXrXKVanRzN5iGjRu+E1s1LHcqe/Orf8+GVRfbE4I
 kYLYhwH2o0QYdGSowsAaH6h1XDqH908jhsgu8x9R7dW+Jk+BwRY7bT+BvA5JN6i06mWT
 RUKDSf26Wt7VXDfUCGJ22982VoNJ+LDQHaqacQpbn2sKYqfuHshQId/sO0TpAwKPN2sb
 BVm06QmNTzkRaKwWd/72qJ3AnpXFKXIRJ5Gf34NmL7oH3ZMHRdTNxk/2WJTN2nsZyKiv
 EgnRSLLCYwH54iZSuUiwnIPUVafYlaQnsYehvSWPjARn3xACNH7f2jgamLQq4Sg1ipKn
 tshQ==
X-Gm-Message-State: AOJu0YzbNmCT3GRFquUekQjQNKy3yHMiHm5pMyG1hV8Al4GAH02EtMn7
 00NR7LmfokGUHMEAmcbOdhEctcIfmiPefaLK0zFXUuJpt6v0E/nT0blx4WOLdhs=
X-Google-Smtp-Source: AGHT+IGkIF1yNibwcTzdUwqu2hjVOuPWns3tPwmK46+/XHAvdyx5YP+NE2vzKlmhcyRXlbvbW0BXzg==
X-Received: by 2002:a05:6a21:3606:b0:19e:a524:a92c with SMTP id
 yg6-20020a056a21360600b0019ea524a92cmr1355351pzb.23.1707887645001; 
 Tue, 13 Feb 2024 21:14:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX/wSQ8RoCCVRCnCH8yVRWlYS1vs8h2eSvxvCOJrNN+ltOf0++42F5iJU7r744Fa5wwOcFz+RVEROSrjzGOVID/NOBlvR3ojxjhvjpJoGyKIu3hiXD/Yo51cwryJYjc/30LJTcL1ZCY+oxollAey7FJKZLjhY6IGk+JfweDE+1r/bfZza9s7P1k601jehnjpCwLhErB7rMUj0W4tfbx2Se8VMZ+1nFUBR3aKx7SmHs7scMf90L6HnwexN+tTyTVrjYlla2GczWVN+naNF758IE5onoSBoFVeTkByUOCLLx5WovbrcZjOCFqY4Ff540SQDbHjAjFkXXjzLS0mMlYJao52VMPcyW8KmbSaN6M+gH3I04v6P52bt4zBx9Wd6Wj+4nuccOtfwj5Wao++bnlzmcfn6tfbC3ZAlU6ZYbILAOR216FHOE358PRMyYx80k=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 o8-20020a17090323c800b001d78a08e8e7sm2874199plh.250.2024.02.13.21.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:14:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:42 +0900
Subject: [PATCH v4 4/9] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-reuse-v4-4-89ad093a07f4@daynix.com>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
In-Reply-To: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9228e96c87e9..5954404dcbfe 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -237,10 +237,6 @@ struct DeviceState {
      * @pending_deleted_expires_ms: optional timeout for deletion events
      */
     int64_t pending_deleted_expires_ms;
-    /**
-     * @opts: QDict of options for the device
-     */
-    QDict *opts;
     /**
      * @hotplugged: was device added after PHASE_MACHINE_READY?
      */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c68d0f7c512f..7349c9a86be8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5dd..71c00f62ee38 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* set properties */
-    dev->opts = qdict_clone_shallow(opts);
-    qdict_del(dev->opts, "driver");
-    qdict_del(dev->opts, "bus");
-    qdict_del(dev->opts, "id");
+    properties = qdict_clone_shallow(opts);
+    qdict_del(properties, "driver");
+    qdict_del(properties, "bus");
+    qdict_del(properties, "id");
 
-    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_json,
+    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
                                       errp);
+    qobject_unref(properties);
     if (*errp) {
         goto err_del_dev;
     }

-- 
2.43.0


