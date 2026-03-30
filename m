Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F51061B16
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7FhF-0001E3-L5; Mon, 30 Mar 2026 12:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7EIs-0005eG-KN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:13:23 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7EIp-0002Hg-Ir
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:13:22 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so5315905e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774883596; x=1775488396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n7HlmvMzBYazc7D6vTdfmqu/05s3azuW4vD89xhQmnk=;
 b=lEZd9TIvUzlbV5KcdpcdJGlbz89r8IGiLfqC67rgrS+QZPNBdayx4ITz4RBJJ8UdST
 /o50gfrqUouuKgBCvVvc5D6YCd44dyudO7M3EibrgPFeyzUR5YO63cmzyFb9bFofcLzJ
 rwKvvkZUAc80r+Gs4eHleyaFRlJNfSzRlpfvrBxhyIJpVIbvetx5IReyDVyQC2xNlMyE
 tCxIxlK4sQEdeJUr5FcQqZ/7u9ibxnVcR9Ogscv+ZKpZufk72Ry6L8Tbh/p33KOf9sli
 CvL7YxenjeZ/e1HvJcgPz8aWJsBjBC/uXu56dczomQ1R+JOSjTc5ubdDcfGwb1cWM5mB
 2N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774883596; x=1775488396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7HlmvMzBYazc7D6vTdfmqu/05s3azuW4vD89xhQmnk=;
 b=UtabvPvGnHhtRhWxhGJgLzJv817vWEdldn2S53++chduIKEa0QAhy8k3IdGYhx09Z3
 m21a98ims4fHV5+QhgO7LL7LAhNMS/dQtPwhDpMp2NcWYPkDHDzfTN07XpUOQLR2ZBpQ
 cqdORBl+nKHJctYDyaVOYm6jzzbZgpsUoLEmh4srNPxQLeiLK96qEqzeKWnn6GRO8K2F
 f7iTD91mrwVfXUDZ8kuGw+3EXUGz11getlWeWYRByjys0wAJLLFmjQtZouZ6pj/3zWIC
 ik5il9lFKvnAsU6Dqv5v+Ps4K2i5TnbelGKH3MX/DG9y4BablxYKADc/Jo8o4sVvSkXd
 YFXg==
X-Gm-Message-State: AOJu0YyyfL0uoRO1oCLM5bzfoOqKxYrH6x3cF62IQxM5GjG+3xE4RFBA
 unPuKChadvKsvMWVjLSCSkvtWMZGanyQqFhtZ/BIOaVIZvsbFLox97ixyBlxm5et
X-Gm-Gg: ATEYQzxgIBfNZfIxJ+8neJnebtNNB1Wqt/N7n2fs1HOhX4Se9mCh4X+dy7rhLm7Ui2b
 +qQ5SvFceaCcv0IgW4cOsjaxGhR6Tp0tRdxGc0+bfu95uC6Mlro9EJW0D0mtr5eotPfZe/HLVqt
 Zquo+Ko8wzV7+D+Ot+kgsHerx1oeD4VroF3t4SYeB6g1WGvGE6+9zzKrxxCn1jUtNsgn8dJK4JP
 XUgz/DlTifbaMkzkVzcaN8us5NBlIwABIzzzyImPDcH4g5j8xr7AjZC7Gi01zhRr7UMDoozFD3v
 KcwNbOY75m7sUMmXmlVi24rUyuOD3+TggWo76IQ92EL66rdPiJQdLlndHO4CCYXGFjw3SbMzDl0
 njZUpf/VY+snfOwMq/ivIx07f1ETSyR/Mw6Z0fjdifPpwEwTP93lBoXEd4Sg4JR8klo3CswYBVG
 GrvnlgewUrFHcNqbbtcx3sciKC3QoTox7XVjpV4k4jP3PICA==
X-Received: by 2002:a05:6512:1391:b0:5a1:2e83:a7f1 with SMTP id
 2adb3069b0e04-5a2ab91cfddmr4325669e87.23.1774883595471; 
 Mon, 30 Mar 2026 08:13:15 -0700 (PDT)
Received: from localhost.localdomain ([89.21.130.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b144f75bsm1718129e87.60.2026.03.30.08.13.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Mar 2026 08:13:14 -0700 (PDT)
From: Max Makarov <maxpain177@gmail.com>
X-Google-Original-From: Max Makarov <maxpain@linux.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Max Makarov <maxpain@linux.com>
Subject: [PATCH] vhost-user-blk-server: fix size_max=0 breaking Windows guests
Date: Mon, 30 Mar 2026 18:13:13 +0300
Message-ID: <20260330151313.66318-1-maxpain@linux.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=maxpain177@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Mar 2026 12:42:36 -0400
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

The QSD vhost-user-blk export sets size_max=0 in the virtio config,
but the vhost-user-blk frontend unconditionally advertises
VIRTIO_BLK_F_SIZE_MAX. This creates a spec-violating state: the
feature bit tells the guest that size_max is valid, but the value
is 0.

Native virtio-blk-pci does not advertise VIRTIO_BLK_F_SIZE_MAX when
size_max=0, so guests never see this contradiction there.

The Windows viostor driver trusts the feature bit and uses size_max=0
in its MaximumTransferLength calculation, producing malformed
scatter-gather requests. The disk appears completely empty to Windows
(no GPT, no partitions in diskpart), causing INACCESSIBLE_BOOT_DEVICE
BSOD. Linux is unaffected because its virtio_blk driver falls back to
PAGE_SIZE when size_max=0.

Set size_max to 4096 (PAGE_SIZE) to provide a valid segment size limit
that matches what Linux assumes as a fallback. This fixes Windows
Server 2025 (and likely all Windows versions) booting from
vhost-user-blk.

Buglink: https://github.com/spdk/spdk/issues/3199
Buglink: https://github.com/virtio-win/kvm-guest-drivers-windows/issues/692
Signed-off-by: Max Makarov <maxpain@linux.com>
---
 block/export/vhost-user-blk-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index e89422b..827502d 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -240,7 +240,7 @@ vu_blk_initialize_config(BlockDriverState *bs,
     config->capacity =
         cpu_to_le64(bdrv_getlength(bs) >> VIRTIO_BLK_SECTOR_BITS);
     config->blk_size = cpu_to_le32(blk_size);
-    config->size_max = cpu_to_le32(0);
+    config->size_max = cpu_to_le32(4096);
     config->seg_max = cpu_to_le32(128 - 2);
     config->min_io_size = cpu_to_le16(1);
     config->opt_io_size = cpu_to_le32(1);
-- 
2.53.0


