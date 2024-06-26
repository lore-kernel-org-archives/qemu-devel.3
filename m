Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F7C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQV7-0006RV-FG; Wed, 26 Jun 2024 07:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUt-0005vY-GL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:33 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUe-0004k2-9e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:31 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5c21a177affso637898eaf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400035; x=1720004835;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9ZmBpokay/lsP22q1IUevpTwDSp5jcANCIzAYF/y6M8=;
 b=Kasg5Bb6Tt1MkaOqRSR7GYkmqClZjSFA1Ek09+duFTpFHx8U/caOqF3wwwDCHi8Cs6
 MvaXjdmCZvQxjkJYrcpMIKAt55JWqv8oiaL0ZMXyZe+hUm+F5jCHPKk5flUDlBcLivSW
 af1/socvMxka6Es9Smlf6QBhQog53apInvYwoGj96q4gLIEXAGBClT0r2jc3LcW0kH5k
 r4R03sL57xjHxPjRRPTz4sklJYVS7Rvb7ih8YnDw8yHIBKQJmD1/7Z3XqgcbfdWnMnQY
 IDO7nKvObSJzw8s9irW7dVvNRKNrqQWqmQpm7rbQlaAd6bQoZ94sk80fYzMRpy3X1JuV
 /x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400035; x=1720004835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZmBpokay/lsP22q1IUevpTwDSp5jcANCIzAYF/y6M8=;
 b=s8+tAAdtssglbgLgGe3auF+XD8sepJ8ioSNrzZ8SnvUsqhd81/yNF+y82ny7aVOvTA
 kWWpbrCF+IkzPIGqei5b+KktUj7eY4OPXE9oqa4G+V13blRqm3XNwLveliqcpk9RtkN5
 T+rDgyyzeZRTMx/NOq8H2ItiV9y/I4fx2Yx+bVa7Nb/LKGIYZsR2NUcr1WAnsR7Iqi4L
 6RaVQEb2MEjds/O/7y/dJlBQb9aaNqzmnYQQjrWIlyYC4tnooLwehLnKCgYmIElPwJU0
 OBX6jFphys9hMJGhD/ovkiVjGLXhwBGh8ktIBiErg+n7fSgC8aEpbXlvwUbDvSMoy9UQ
 lsaQ==
X-Gm-Message-State: AOJu0Yz7QScGomP5E2AUGdhgLhBTo9wLxpJLM1/7LAjCdfhlHjDCDvjQ
 B9xi/YNEGckDfxE8Yn2mLEgLB47uzAjoXi8BbcRm+SplXAOhCUY8Y1tftqKUdEo=
X-Google-Smtp-Source: AGHT+IGr7mhUQc/kwzoC2SIj/Sh4EbH/tfTc7GcCgH2CK8pzXdS0VBUK4r8QMhdZTjnrV0Z6lwmRkw==
X-Received: by 2002:a05:6358:2824:b0:1a1:cb05:243c with SMTP id
 e5c5f4694b2df-1a23c1b2289mr1333891255d.25.1719400034980; 
 Wed, 26 Jun 2024 04:07:14 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-71e1314dc83sm4678927a12.56.2024.06.26.04.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:29 +0900
Subject: [PATCH 06/14] hw/virtio: Free vqs before vhost_dev_cleanup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-6-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/vhost-user-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index a83167191ee6..124ef536206f 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -223,6 +223,7 @@ static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
 
     if (!vub->connected) {
         return;
@@ -231,6 +232,7 @@ static void vub_disconnect(DeviceState *dev)
 
     vub_stop(vdev);
     vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
 
     /* Re-instate the event handler for new connections */
     qemu_chr_fe_set_handlers(&vub->chardev,

-- 
2.45.2


