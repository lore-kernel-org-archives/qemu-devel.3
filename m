Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC4606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WxlwsXeV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NRMyYdPU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HG-0002Kb-5t; Wed, 28 Oct 2026 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GS-00018s-KY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GO-0003ud-EV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJxLNCDYXkJkiCMAoJTPbsgTkEN/PblvOc1OCcyjt04=;
 b=WxlwsXeVlNDwZWDPI4w9Ucmf4pxmyva/RggWld9oClO0VSCYrayqin8N2P7CJiHMPLsjwe
 KVZQyJZgujrDiX3X2E9UNIoIrkErMrRTPlW3Wgm4iIplcZc5JH2aQE6iuu1I8AVdgQKtsc
 d41fBLbn+BUZ8G99l7xmPjJf91OWcvg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-eJ_r8gP5P_OHL87Bd6UOcQ-1; Wed, 28 Oct 2026 13:16:33 -0400
X-MC-Unique: eJ_r8gP5P_OHL87Bd6UOcQ-1
X-Mimecast-MFC-AGG-ID: eJ_r8gP5P_OHL87Bd6UOcQ_1793207790
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso7352895e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207790; x=1793812590; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oJxLNCDYXkJkiCMAoJTPbsgTkEN/PblvOc1OCcyjt04=;
 b=NRMyYdPUjur12geEhQdmeQ7ttgo8HTX9stRvbLQ750iTFdyVMd3YmcmkRkkU3hYC5F
 ghHPKiAmzYbpiWZJORkJRm2W7TGwPADslcLPK2Zo/IA3eEQgPzWrIHaGXF4k6Sy57J06
 iy5qxJBnfCghEWfNZGb18bwVUzrTaz7eCQ+12VPk23M6DOiQaahErumtrnd/LnoMIdww
 PlQt2+qQDqHXvbDKpFe96cTGrC/jhHcEIkF/d0ymHDPGcHIJ9gjzVHab4xoY+nj4Tcl/
 igX4d9dVlyfYxuZ67rD7WDOgJl7thinIBtGSzcPzbZeTHeHp+rWG4HsyCuL/oVJB2Q48
 BcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207790; x=1793812590;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oJxLNCDYXkJkiCMAoJTPbsgTkEN/PblvOc1OCcyjt04=;
 b=QmdVhlQw32el6hgdNCAx8yT/CJLfcQBPe8xg9e9h9VU4bH5zPFHCRehbwiqnGGXp9a
 lo5krOjhACxY5LhUq76K84LGHMzMy2fvBwrwJk86AKZtV1KdlCHtTv/h2CCD66VugdqJ
 OJpZKdNSOO4sZGnd/HTicMc7BM9ncmm0Bhxk5o/T/15nUouRqrDKpnm6FY9BgQRkOE3W
 hasH5isQJ+Bd3KiCpDSJ5I6Ua04DXoiwKhm/pOfUTz5J4yF7DGTT5IZCgQfc9HtkJoTE
 TUoG+f7m8mhDmSY6J7ZH2CABeVr363dolmel86oTJf4hcnOYEIHiDMM8Th17vETcyzRc
 C/hA==
X-Gm-Message-State: AFq9FYJcrqa+TgQjWO3I+6ooQnF6xR6XPbCR3GRs0ROkuasgddMC8Q30
 RNu9RYSVsoQYD/rBRsHU8zvDQhQeokX0j3JDVWeAMiUpHfLEwhw1Gdz/G1w+3YNmu5MZo0/Ax1+
 kpqD74nhurediJkLYpYtkGNks8AWXY7aTs2zpyQaWBAtbVZqZsSqhnAz63XLfkNxMuCNfKgwvOL
 prIM0oEcsxSW3Mz0nUDZ4V46IlS8nSESUPEQ==
X-Gm-Gg: AYBFou1NPflwv8T+8oXw0kzXmZ/xal82U+UpjQNgz4TkJ4R2/wZfA8t1TjeaBreai35
 KZRKgyfCiu+KyRDzFiVWcs62oij4B8EGbHCLLlOHfD28SYvV6jc5PCw/TbZMGVJrISU8OU+ztBL
 uv8dCVUc+a3YadbPrNe3HzloSfAiP4S047emMilAn7U8J2fnAPRNB14Bit9YKVW+0gVreg8EHxY
 5SbDv5ePavc+ITOuaqcBMIHxelpkIQqRX3cyr1d5YogRwFt70wqx7e+sT0YJEsOLAvml+OCxCF5
 4+mHNUfgDKziu8LfxuKnSCqq5DU0xNkuzkcL8eMdDcFNlQWJCSc7b5nlNJcE575FEsRJj7IxQQm
 7ocMYKlR46zJ9ZOM2vtf/vrNtneCoyD9iYCeXPwUL
X-Received: by 2002:a05:600c:c8f:b0:4a6:42cc:bf6c with SMTP id
 5b1f17b1804b1-4a9661ab555mr72163845e9.7.1793207790132; 
 Wed, 28 Oct 2026 10:16:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:4a6:42cc:bf6c with SMTP id
 5b1f17b1804b1-4a9661ab555mr72163225e9.7.1793207789529; 
 Wed, 28 Oct 2026 10:16:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f50d3sm9405045e9.8.2026.10.28.10.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 57/78] vhost-user: add missing stub for
 vhost_user_has_protocol_feature()
Message-ID: <3fae3d54fdd73fb50872a3c78ce098738aca354b.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Currently, building with --disable-vhost-user fails to link when other
vhost backends are enabled: vhost.c calls vhost_user_has_protocol_feature(),
but its implementation is not built.

Add a stub returning false to fix the link error.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Fixes: 5eb2347867ee ("vhost-user: add skip_drain param to do_vhost_virtqueue_stop")
Tested-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost-user-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
index 45559788dd..9d2e521788 100644
--- a/hw/virtio/vhost-user-stub.c
+++ b/hw/virtio/vhost-user-stub.c
@@ -4,3 +4,8 @@
 void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
 {
 }
+
+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
+{
+    return false;
+}
-- 
MST


