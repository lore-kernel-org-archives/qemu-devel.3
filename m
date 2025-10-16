Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDC6CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWx-0002Hm-4N; Thu, 16 Oct 2025 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWl-0002Fp-7a
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWX-0001B2-5E
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:25 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso859944f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627047; x=1761231847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwPFf1pbtLyHgXrVD3lp8OL749C/noD+jZkGwklcu94=;
 b=UzaxLOUXbDdAToDIvWDQ6IkyRfq47hkUOkWodmOLqIOaLBdNX+LE/RYQOegN8vpdBn
 qQDwOG6X+33BW0uKtwZMWYNwOC9eaVM+M60WQ7dA3utiRpE+l9lm2Bg6MIKQ7j4lIK9F
 UNtqogToeOriF/v7jrsznpSohiOhzdc7wvAc3MKQsQIwRdv2HKSBax1z69XP3zDrPa/s
 FJzdAu3O6nE4ZrYNAzU7oFnAPVGtY30aYBdhqDeipiMGlfhJhHPbrnaqGqFacRhbQ5Ya
 ZxrbspROJop4REp0bkWuO9l3WxqQ5IPj1DeK/tSKGz4kHByss53/mxtE275fOOh6dNxK
 qGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627047; x=1761231847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwPFf1pbtLyHgXrVD3lp8OL749C/noD+jZkGwklcu94=;
 b=rBYpyXeJEPE/jffJpz4uWKzPyhRCvCXnYcx2CQTQZ22EYHyz9TLYZrZGJrQ9+C6+hC
 WDFtI6btvtmbgXG2Yn1/eOdCL1nzE0jlSGLu7kLObT8C/o4bJFM3RSTB77F5uFITk+29
 fIHk4eJtNL8LymCl5/xQs358YacLYqlrEGVMraiY6b4aG9N77kHRZZItnOuccj1b9hee
 66r42+Ix+T/ulpA1/zjalos+r/1k6047geguqY0wkVMvXscgnvm3V58rN+ntu7c8b93I
 htr4RvyWjbQo59t9TrQSeieD+c1s+BZsWLvt6Pjj9ocmvKnxXwsZQN+4525pIdZ5nWqI
 +DPA==
X-Gm-Message-State: AOJu0YyhAgBS1DLVTLJAIMAqhfg9TSQd6WIBRIdzqVD5U130dNxTs9dv
 aAQRH/RCzl6UdGBGLss4d5Ic5EE1vfcaJZoXusQv5FIkonSIxaxqbWFZNxiTarvO/ss=
X-Gm-Gg: ASbGncsH3DpagedfLBPycIneKttFvkil1V0x05jSHR+eR/a5MB+kZ+xUQFUkYiPSXjq
 JXAwvFJImnUu4qfEyYcf13iRlVGK5831OsUobERC3tFdlaajqo2sHtaLbesFvUaInpiO6vjBfi4
 Rk+WYyRhHLzPYZr83nqulhz2eG2vbGSjgs8fztsQaoLl4RdmCMHe9SQWUoNBH9iDBuT61AJe0cO
 0iblbwvX02NMO9Y0T/IQ09Zsvx5WOfWw9g8I1PI7T8g4Eq9OZH7daJxiOlAOvn13t38/wXsDJcI
 A95dBxuBf5SLbB9E35DPtTb66X1mhv4j9SRxDmkXPfW0qNDokZYctd5tk9wRSA9etVJMI6HTaAe
 SVwvvEV45+9PxBC/unwxgUJkWb/eBRets8kbAba6S5mYq+BFXzAHfGiuoJckltpl2sX7G+Fe6Ur
 wK3vzOxxwkfuk=
X-Google-Smtp-Source: AGHT+IGoiWPVXoZ/ttIWoCl7fBJNOKmMRiQlCb2EZQENFkAVwYkjC72SIJ5jdNk9rZkYOr25tJ5f/g==
X-Received: by 2002:a05:6000:4b08:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-42705261894mr182405f8f.58.1760627047183; 
 Thu, 16 Oct 2025 08:04:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ff65596csm4134085f8f.24.2025.10.16.08.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7589B5FAEB;
 Thu, 16 Oct 2025 16:03:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 10/11] docs/system: drop vhost-user-rng docs
Date: Thu, 16 Oct 2025 16:03:55 +0100
Message-ID: <20251016150357.876415-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

This is a fairly lightweight document which doesn't add much to the
general advice in vhost-user. Update the vhost-user docs to point
directly at the rust-vmm repo.

Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/virtio/index.rst          |  1 -
 docs/system/devices/virtio/vhost-user-rng.rst | 41 -------------------
 docs/system/devices/virtio/vhost-user.rst     |  2 +-
 3 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 docs/system/devices/virtio/vhost-user-rng.rst

diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/virtio/index.rst
index fc457ca74c7..e3839e61824 100644
--- a/docs/system/devices/virtio/index.rst
+++ b/docs/system/devices/virtio/index.rst
@@ -25,6 +25,5 @@ can also be off-loaded to an external process via :ref:`vhost user
    virtio-snd.rst
    vhost-user.rst
    vhost-user-input.rst
-   vhost-user-rng.rst
 
 .. _VirtIO specification: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
diff --git a/docs/system/devices/virtio/vhost-user-rng.rst b/docs/system/devices/virtio/vhost-user-rng.rst
deleted file mode 100644
index ead14053264..00000000000
--- a/docs/system/devices/virtio/vhost-user-rng.rst
+++ /dev/null
@@ -1,41 +0,0 @@
-.. _vhost_user_rng:
-
-QEMU vhost-user-rng - RNG emulation
-===================================
-
-Background
-----------
-
-What follows builds on the material presented in vhost-user.rst - it should
-be reviewed before moving forward with the content in this file.
-
-Description
------------
-
-The vhost-user-rng device implementation was designed to work with a random
-number generator daemon such as the one found in the vhost-device crate of
-the rust-vmm project available on github [1].
-
-[1]. https://github.com/rust-vmm/vhost-device
-
-Examples
---------
-
-The daemon should be started first:
-
-::
-
-  host# vhost-device-rng --socket-path=rng.sock -c 1 -m 512 -p 1000
-
-The QEMU invocation needs to create a chardev socket the device can
-use to communicate as well as share the guests memory over a memfd.
-
-::
-
-  host# qemu-system								\
-      -chardev socket,path=$(PATH)/rng.sock,id=rng0				\
-      -device vhost-user-rng-pci,chardev=rng0					\
-      -m 4096 									\
-      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on	\
-      -numa node,memdev=mem							\
-      ...
diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
index bddf8df5ed5..9c9a28df380 100644
--- a/docs/system/devices/virtio/vhost-user.rst
+++ b/docs/system/devices/virtio/vhost-user.rst
@@ -45,7 +45,7 @@ platform details for what sort of virtio bus to use.
     - :ref:`vhost_user_input`
   * - vhost-user-rng
     - Entropy driver
-    - :ref:`vhost_user_rng`
+    - See https://github.com/rust-vmm/vhost-device
   * - vhost-user-scmi
     - System Control and Management Interface
     - See https://github.com/rust-vmm/vhost-device
-- 
2.47.3


