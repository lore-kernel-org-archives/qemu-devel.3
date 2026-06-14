Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5604CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDR-0000KW-8B; Sun, 14 Jun 2026 15:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDO-0008PT-Aq
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDM-0002kg-KW
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bGcYn11R2LgZ0N8Eq0gBNse4cv0sy4gULFVLSiEvbYk=;
 b=Fs99KkAgw2J/4YhVjWnsMQgTT+FTg+GvW0cxaX1FjgwpWua5gvaAcjiZ0TuxwckMOY1tiu
 Dm7ZtxIbCnDUxf2UTpgKd3Yd+wtWBGnJaJFg/2tHUAeYYaLJHqa0NWYul8YfVKJT7ctJHE
 fpj7ji/NzcNZEHkC2NPOKN5Bgv6zitM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-bM7uY3HINim4RnTrWwV46w-1; Sun, 14 Jun 2026 15:09:46 -0400
X-MC-Unique: bM7uY3HINim4RnTrWwV46w-1
X-Mimecast-MFC-AGG-ID: bM7uY3HINim4RnTrWwV46w_1781464185
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490addd42bbso13714125e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464185; x=1782068985; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bGcYn11R2LgZ0N8Eq0gBNse4cv0sy4gULFVLSiEvbYk=;
 b=CNm5ONx/G0u5MOtMz8yQp84ZF89iObxDd+oP3H5EzcxuOkw0uILn4W0r7g0UYAoDRj
 Q4y8YGoS+ZmZaDRq3eQTrMcClg1ABQ9lptwIC/qaUvt3Z6wwny4wgjhKKvJj2D/8k5aB
 vynkQCu5cicggHaEkvMSsKcjh1vBOMx8aQiHIf1iGzxgoD7o89HS2Bx3a0PIKrVCPKoR
 qDz5TRaurbTv9k4uV9BPmKgGOelcZ3VBqxEcR6Rt6nm3g8zXeffs3ZXBmVIFbr+ALYTd
 CwylmQqnYU2kqjCT12SWWJRznnzL9dkORnoUAFFtVh8P0ba4Ls3ARnirwjaEh/UXfKAG
 BKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464185; x=1782068985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGcYn11R2LgZ0N8Eq0gBNse4cv0sy4gULFVLSiEvbYk=;
 b=G56j7ZgEuF0ByCCQFO6sPYCkFQR6DpmtxjEu9Ujtwk+vCBawr+vZWBsh7KsMmpwhWB
 FEC2Y69cZoUl0FzUj+meyDGosP6fHiE++H+IpwU/ZyVZA5vCM4P5xPZXMyo6kwr+BOX2
 LaGVur1e203kJmKpO0ch+NXYVP3UHDIYscoVH/B17nehgNbvuLgbWhxq28udHyiyMCAs
 4rzM1djwyUxbc8S7kfQoCcjvSRIxBZucLZP0ED7P9DPlFjsU049A3ZKhVkw2Cea6hRgT
 UkT/gGvdBKNkK/aNXRd0HkKYQ0ht/WDRbLFf8LmHnwqovmWbX5TJ4T5Pc+XXdPZhscuZ
 dWWQ==
X-Gm-Message-State: AOJu0Ywg4mjP72gfQIW4cmXWLfDpkIOrDy84+CeIBuf4HLCo2dpAEheh
 fWOw/iTOlPm/vNoHGeFmdlHzRBWKcFeA9sStgXJXWo+bCPu2GEvXy+6F5/SKuAqH4Q3Omn5S359
 tNh3VBF6BPmO7aamUFK12OAYUUQtD62G0IyH+MBXcuNuBMqEEgNUkqbmXm1B0kYmC+wlPVE8GKM
 2+yr89kh44vnNfhSopsAeA9ptD5CJ+OT8uRw==
X-Gm-Gg: Acq92OG3HZs1Jn7wnwuxmAFUdLjDXSMNM9TsQjl+TkpNXezTcJzUMs5IJiOCJP+6CEK
 jdEAw2jChjO9qu/R7JFE2KufpxjKzHk4ffa+mdrLV124e3Um1x6PNFvDkeO3U/PWB3r3rtpOYNA
 4o448gQNXJIVbdPOMGwaJbjjLAHzxkpFUVIs+hLtqOSrONWPokH/YC+EorWhocNtj7YRAQ7Evsk
 d4wWhYEqw2BDLjuBpNxV460gi7oV6ZKcetAoXWA3Kjlyg8OubTD9jlAsEJHdzQlowgrzXGLCaM3
 N/vXK4RZZU2MEnI5mtQTsFZcKR176j331RMj4V2XA4jKQGbL2sKr+V/dly612tZBgAWv7bbn9Z2
 vt4PfHVdaX+94O/MNHZUnrH1VMjkYU/2Y/PkIIwdzdBA=
X-Received: by 2002:a05:600c:3512:b0:491:9969:739d with SMTP id
 5b1f17b1804b1-4922011393fmr99586765e9.29.1781464185152; 
 Sun, 14 Jun 2026 12:09:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3512:b0:491:9969:739d with SMTP id
 5b1f17b1804b1-4922011393fmr99586505e9.29.1781464184493; 
 Sun, 14 Jun 2026 12:09:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922037055csm191285985e9.13.2026.06.14.12.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 096/106] qmp: add shmem feature map
Message-ID: <0578926e3a6ddaf011f00e41ee7e490b446518eb.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Albert Esteve <aesteve@redhat.com>

Add new vhost-user protocol
VHOST_USER_PROTOCOL_F_SHMEM feature to
feature map.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304165223.2166175-7-aesteve@redhat.com>
---
 hw/virtio/virtio-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index ae9be0a00f..57cc03828c 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -123,6 +123,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
             "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
             "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHMEM, \
+                "VHOST_USER_PROTOCOL_F_SHMEM: Backend shared memory mapping "
+                "supported"),
     { -1, "" }
 };
 
-- 
MST


