Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A54C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5y9-00070W-W7; Tue, 09 Apr 2024 03:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5y8-0006uJ-08
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5y6-0001dj-I5
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vH5L5pFLaSI06lO9xjFE/z5WyjmKBK04Tet3f92vU6A=;
 b=QPpZ4paws40fXcfih4ZXaSSrhCExmXzVEpj5We2PR39RfN7IyAJvyLUXtlyMC0xeP9yJ9U
 OsJ60KknqM2HsnM/b+DF25qXq/z3K7efgWtTvn5fDBbRVF6E3FRKk/xnrfuBDA+zZVb5U5
 lbp7TEJU8yvv30gHl5ROhNI23Y1Moww=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-H2D3u9lrPviAi5CWT4jYSQ-1; Tue, 09 Apr 2024 03:32:32 -0400
X-MC-Unique: H2D3u9lrPviAi5CWT4jYSQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5684bf1440dso2015061a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647950; x=1713252750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vH5L5pFLaSI06lO9xjFE/z5WyjmKBK04Tet3f92vU6A=;
 b=cZIsy39Ooe8BEpQCESqVjrRkQHoDlNXiYWctjzNuSL3rOUXFI3ADdq1O4lncQS+EgW
 YViLAPUTHjfcYLsA/dZldPm1LHTkGGm2tOfOl0wMO5DKzjnmRlaxkpL4sBp1syKvmJou
 uUjo4qgQm0/a5E62Z6v65z2/Jqc5b2s5LRGYtsPgj+JJHjobtG4obCzqXOlzXcm+I/cZ
 X0Y1gUko6kpR8EcUgTEWzByZW9n3FiUa1CxwrbZondVU4Y5sQXPJJzIK3725cdEbBW05
 eU3jUS1AAAfAbM2aBSmdwpGzKEB1+ZBFjQbCtWs4ZySMUZAYc6gz1zcl+VkhV70PJtWq
 oziw==
X-Gm-Message-State: AOJu0Yx0FTi1xNWbwQQ0/rlNr5LX0jAc7iSPQ+ZARPl4/MfTlCGSAY44
 sChcIGx7EX1j/hrLbh7jE1Lv4mVScOdjlFXDtI4moJuNiqTovaeQhAOXK/WN8mIEZQZe+FY9RU1
 D8cmAC7WiGgwZ9/eTnM54LuEyUFOdr8UIs2cPa/8U6g/6wsNLQB1RKbPAa4jDF02ctYg8/GP2Rf
 XdT3fejdhavQzG9YY+QFToXG3ABrd0RA==
X-Received: by 2002:a50:9b56:0:b0:56b:fd17:3522 with SMTP id
 a22-20020a509b56000000b0056bfd173522mr7971078edj.14.1712647950465; 
 Tue, 09 Apr 2024 00:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfmI15z1iU+N/YJLVDAItEnxPyp/nYlAdrcAtTJS3jYozitVZVbWUZBXkcu36NpRQzo9+b4w==
X-Received: by 2002:a50:9b56:0:b0:56b:fd17:3522 with SMTP id
 a22-20020a509b56000000b0056bfd173522mr7971038edj.14.1712647949828; 
 Tue, 09 Apr 2024 00:32:29 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 q18-20020aa7d452000000b0056e247de8e3sm4928413edr.1.2024.04.09.00.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:29 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 lyx634449800 <yuxue.liu@jaguarmicro.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/7] vdpa-dev: Fix the issue of device status not updating
 when configuration interruption is triggered
Message-ID: <6ae72f609a21cfc56bf655cd4bcded5d07691ce7.1712647890.git.mst@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: lyx634449800 <yuxue.liu@jaguarmicro.com>

The set_config callback function vhost_vdpa_device_get_config in
vdpa-dev does not fetch the current device status from the hardware
device, causing the guest os to not receive the latest device status
information.

The hardware updates the config status of the vdpa device and then
notifies the os. The guest os receives an interrupt notification,
triggering a get_config access in the kernel, which then enters qemu
internally. Ultimately, the vhost_vdpa_device_get_config function of
vdpa-dev is called

One scenario encountered is when the device needs to bring down the
vdpa net device. After modifying the status field of virtio_net_config
in the hardware, it sends an interrupt notification. However, the guest
os always receives the STATUS field as VIRTIO_NET_S_LINK_UP.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240408020003.1979-1-yuxue.liu@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vdpa-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 13e87f06f6..64b96b226c 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -195,7 +195,14 @@ static void
 vhost_vdpa_device_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    int ret;
 
+    ret = vhost_dev_get_config(&s->dev, s->config, s->config_size,
+                            NULL);
+    if (ret < 0) {
+        error_report("get device config space failed");
+        return;
+    }
     memcpy(config, s->config, s->config_size);
 }
 
-- 
MST


