Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE37C43327
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 06:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdM4I-0002xe-LI; Sat, 27 Jun 2026 01:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wdM4A-0002xH-FB
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 01:58:58 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wdM48-0000Gc-N0
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 01:58:58 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-30ca1b4b278so1796426eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782539933; x=1783144733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcR8L0WC/Ee3sh1/HeRViPr1GzlOHSGGVXj0ax8e8Dc=;
 b=sdcNJS/sAKBt34XB827GXL8saM9mEJ1ChuDkhwqnCNTFU2+m+qlgR9vAzielnjKRw+
 R+D4uu/tCrRRGd1r5NYV41IOUvmwFKOfpKrLBAY8ywX+FJ3Ag+zB12/KKgtn/WrmUSdx
 7ymygwj/2Ftuju+4CZc1PMNkVSCcA1eLgGJ1vlBmx4MAYc8cgYcsMSWdHlsMCePplU7u
 EGk+DdQxD2EuFJQltAolDWR4pkwuI0NznfQ2yBtZ5P+HZjcY0IlULnzXfLQBHuoPuwLl
 ie8g16fjtG9MQd8ckl8fDmv+mqqLTBqD6pnKxqTYTrwlbC5qzYTnZunePJ0UjxO+yAGT
 SLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782539933; x=1783144733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcR8L0WC/Ee3sh1/HeRViPr1GzlOHSGGVXj0ax8e8Dc=;
 b=aMP5hi+C81iKPZMY6kadvWQBcp4H7EOCsmGi90Vt18YUFIjAYhSquPYh8TwoPMRVt8
 +pOwGIEYbpQkA5X4lJlnlFmu3volBnPm0rapDYd6XG6zSvzrt6qsaB5fZdP/Y2eBMUiR
 fgNhqOVXj/sGFh7aOTh5SQe4Wft1FCrjJyT705MMhs/MElAhUJ60G7Mv03xDvS4n2k9e
 cxwQdGbat5zyc3QQKGYcRS0zb0atneuGpoLX1vB3z9wYRVLD/xc8mFDydsRQHZr8WV7J
 O4z4l6FsfPcmJyBSQ2OQhb6xiCiXveMQ1t0LxHxsxsJz/ddvMi9ISixVoXPFeJCQH5Dr
 crgQ==
X-Gm-Message-State: AOJu0YwXcuzwFB73Jf2B8im3sZLOdVAu74UR6xYq2M0XkbiTJ2o/wbC+
 RSezu/+KQUABp7y+sz5YtN4tyaM/wuxuqZYS0x/OG2c7lVdYHZV43P9U9G9QFGg6pGvyGg==
X-Gm-Gg: AfdE7cmh4pLGVULLYk9TcRuDnwURlzS8xTM5XkvdPPngKurNDfEMFxQQ4HeSXhZcyST
 SUBXeL1TeMsF/lWD0T+1auqQjX9u92hPsbhT7s3Y71h7hbZJx3pOoOkR+I5uOsPXccNCMVw40Qu
 XxeVDbU1gLdBrlGO12l25n3rf9OYojivWHo80C4ATdXTyGCpVTachMiOt3qoVgeB4zaM8QWIqMo
 IuFEEejqNKjKBIQTOET+nOIgoeOgq3weSYtph6TJMW/Ih/l3GthNQDQQsd/nRAnPbkRui5BjbfC
 gGerFMn9AQnkjnkBsWPT5ZI8LaJDS3bUNKYLdfTpvlap+vJu+Eq5UiDQYrkEx6CNAulQrXZFQ1/
 PXRfZyUdNQvepCENa5LayBYkvg/ktTzAnT6oUmu6DcUaZupGroUVXkNSA3eBcP768u5o/CZvQNK
 2ic7MBjxGVgn7WzGg7ow==
X-Received: by 2002:a05:7300:3207:b0:30c:ab4d:382d with SMTP id
 5a478bee46e88-30cab4d3bf1mr2601077eec.36.1782539932543; 
 Fri, 26 Jun 2026 22:58:52 -0700 (PDT)
Received: from ubuntu.. ([111.196.134.99]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca438ddsm23462629eec.23.2026.06.26.22.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 22:58:52 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@processmission.com>
To: qemu-devel@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH] docs(arm): Update Nuvoton OpenBMC image guidance
Date: Sat, 27 Jun 2026 13:58:47 +0800
Message-Id: <20260627055848.28279-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Describe the current OpenBMC target naming and release status for
Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
so point users at older 2.14.0 sources and explain how to find
Jenkins MTD artifacts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index e4827fb43a..51d36b2bc0 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -94,16 +94,60 @@ Boot options
 ------------
 
 The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
-a kernel using the ``-kernel`` option. OpenBMC images for ``quanta-gsj`` and
-possibly others can be downloaded from the OpenBMC jenkins :
+a kernel using the ``-kernel`` option. OpenBMC machine names do not always
+match QEMU machine names. Check the OpenBMC supported-machine list and Jenkins
+for currently available source and pre-built images.
+
+Known OpenBMC (v2.18.0) target names for QEMU Nuvoton machines per:
+
+   https://github.com/openbmc/openbmc/blob/2.18.0/meta-phosphor/docs/supported-machines.md
+
+.. list-table::
+   :header-rows: 1
+
+   * - QEMU machine
+     - OpenBMC machine
+   * - ``npcm750-evb``
+     - ``evb-npcm750``
+   * - ``npcm845-evb``
+     - ``evb-npcm845``
+   * - ``quanta-gbs-bmc``
+     - ``gbs``
+   * - ``kudo-bmc``
+     - ``kudo``
+   * - ``mori-bmc``
+     - ``mori``
+
+As of June 2026, the latest OpenBMC release, ``2.18.0``, no longer lists a
+``gsj`` machine. To build an image for QEMU's ``quanta-gsj`` machine, use an
+older OpenBMC release that still contains ``meta-quanta/meta-gsj``. The
+``2.14.0`` release contains the ``gsj`` machine:
+
+   https://github.com/openbmc/openbmc/tree/2.14.0/meta-quanta/meta-gsj
+
+Some pre-built OpenBMC images for QEMU Nuvoton machines may be available on
+Jenkins:
 
    https://jenkins.openbmc.org/
 
-The firmware image should be attached as an MTD drive. Example :
+To find a pre-built MTD image on Jenkins, start from the Jenkins home page and
+open the ``latest-master`` job. Select the matrix configuration whose
+``target`` matches the OpenBMC machine name, for example
+``label=docker-builder,target=gbs``, then open its latest successful build's
+artifacts. The MTD image is usually published under
+``openbmc/build/tmp/deploy/images/<machine>/`` as
+``obmc-phosphor-image-<machine>-<timestamp>.static.mtd``. If Jenkins does not
+list a matching target, or the build artifacts do not include an MTD image,
+there is no current pre-built MTD image for that machine.
+
+The firmware image should be attached as an MTD drive. Example:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -machine quanta-gsj -nographic \
-      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
+  $ qemu-system-arm -machine quanta-gbs-bmc -nographic \
+      -drive file=obmc-phosphor-image-gbs-xxxxxx.static.mtd,if=mtd,bus=0,unit=0,format=raw
 
 The default root password for test images is usually ``0penBmc``.
+
+For other machines that don't have pre-built images on Jenkins, build an image
+from source by following the OpenBMC build documentation.
-- 
2.34.1


