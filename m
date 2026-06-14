Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26365CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDL-00083j-Sq; Sun, 14 Jun 2026 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCi-0007Df-3o
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCg-0002OY-Nn
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRsUC3cDyPKsm/U7J25nkVTJSXN6mbxsHqYdeSrlC54=;
 b=OcE1TvnokQ43ndTvmgBQviXEwltIpM2cGteWAIZqgzzg8V5enoRudRi40c4M0N4gtgD784
 aad5rfMzxtNIQeNHDwwrOM5L5EkoESiJDUHrBLD+ACGXSKpc0RHit3y6wlhr8EWMc+1cEq
 0E+bt+W9zgzeXgnuRpNQB/P6SLxfvrw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-D-PwjmRTPU662KLFcisw6g-1; Sun, 14 Jun 2026 15:09:04 -0400
X-MC-Unique: D-PwjmRTPU662KLFcisw6g-1
X-Mimecast-MFC-AGG-ID: D-PwjmRTPU662KLFcisw6g_1781464143
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa7755faso1005593f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464143; x=1782068943; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JRsUC3cDyPKsm/U7J25nkVTJSXN6mbxsHqYdeSrlC54=;
 b=NpVm+iS6ZKTK3cxKWwf8kb3Qv2kshMXNNZWh5cEMkkrU8Q+RqBHg0OULhZRX0XF+Y2
 7sMIDVl2fLZdrVs7sQD1h45N6aTicRjJSjOFxQC0hjlNqtuVZ/aPlRfzgFB73x1o2Wvn
 A04hzLXwBs/QchJfZRX9o+G9fNxgB/UO03x1njoyi20srm6r5rOzaImtUMmPIVx7lnTR
 LDIM6QJ2nLLP8ktAwIEIrc3hFfwA52wj+6WsG3jjpaWUktoIeex6R5NYz1Ybs0CTfzne
 yblcu56/4Y88VQ4oD8oicVSPUL8Svc7EAp9nM+4HsIRxozHnarzgc3LuXr9YGQaiWB4y
 IiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464143; x=1782068943;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRsUC3cDyPKsm/U7J25nkVTJSXN6mbxsHqYdeSrlC54=;
 b=Xh24KK8k6dgdbZ/fJMLgOfEUwY8C2zagJIkCX6m612ofju/awbWkolkpHHgEWTFAbf
 AFWOJBGh40kyQuVkoTYUW63Pg5p9Xp3Bg4frZ+N1yhVfCOnwcv/mSUBfePs1p7orJFpY
 ixOQQiOmQ8/WQwWIWQYOrUILre+OmCEmyVOk2HsNAyWFsEdHJh6n6OEWcOUtc21rzzxY
 7VU0nyGtDJaVsQ05o2VQo/ndWa1Y/nyCV26M86EPH5ZaqUjCwhip5NNWTJaSnwPw8Y2Y
 98jcTx2i7r1AnHemLlJje2GT0GT7Rjzl9rNbsUYoC89OPhBI00BtBtrhEksTftN+1j2d
 Mqrg==
X-Gm-Message-State: AOJu0Yzr3rD1DWzXhO9odAi7vIZ30xOZj0uDpqR+QjWonTKHDOjZceNb
 ah3DX4Ync8JT2aqIckNODQWNH8kanElOqudXpHxAm01XixX//hFvn5j5U6anPKN2sKn7Y7foCBc
 wItXquWaV95PUPrF/gI1ejgXgNpJcOfh7z6c1obK9avFG9+FgnfkI0Jq5z8hUe6BsJWCinKyLEo
 dIJgtPpY59EImKvVN72Ky8iULdruU8wsfFAg==
X-Gm-Gg: Acq92OHnNpXBs+Eu3ltGrVMRRmLpjyzJ+XEEH/o3YLZJpdgmIKZMgd3CemwR4su4H2+
 qpP3dTHxowRRMehCcCSxgMo5ZJ+J7pd7qJmWDt0uNNtSkIdNaJ0K8lRqI5u3zLjaOT/ItrPJb2c
 XuhaYqpJcjddoFoVu8xlsjuL3rvUbrVqAdpeTk9TRQMUK4DuQqZurUWfJU+qZ0L8dSxt17HpDri
 mgXdpgkFBJP8hxHFEE3I9yGTWTV+a2/bi7g7Enen2l84FVVYZ1VN02KZA0OegJJLqhaipZENqBJ
 E5w8onIH3jKVxgsb/f6T7Rdow+7HJqdENpow9ucRttufC1Nc5zBxc5V5z2vOYKj117Yph4f089w
 dpGkHesNLRCXvhqRXDXhBFNTHPnwDXLaJ6CyyVapWioM=
X-Received: by 2002:a7b:c041:0:b0:490:50eb:b777 with SMTP id
 5b1f17b1804b1-492200514f3mr68037165e9.5.1781464143314; 
 Sun, 14 Jun 2026 12:09:03 -0700 (PDT)
X-Received: by 2002:a7b:c041:0:b0:490:50eb:b777 with SMTP id
 5b1f17b1804b1-492200514f3mr68036935e9.5.1781464142797; 
 Sun, 14 Jun 2026 12:09:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492201fad25sm193218865e9.0.2026.06.14.12.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:02 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 078/106] vhost: accept in order feature flag
Message-ID: <942a1a32300859576f2917b920c25bb949faa1e8.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

Let's accept the feature flag with all the infrastructure to process it
in place.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-8-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 60212fcd7b..bcb7f2ffc7 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -38,6 +38,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
         case VIRTIO_F_ANY_LAYOUT:
         case VIRTIO_RING_F_EVENT_IDX:
         case VIRTIO_RING_F_INDIRECT_DESC:
+        case VIRTIO_F_IN_ORDER:
             continue;
 
         case VIRTIO_F_ACCESS_PLATFORM:
-- 
MST


