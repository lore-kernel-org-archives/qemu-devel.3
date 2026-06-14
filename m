Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E209CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBo-0004dW-J9; Sun, 14 Jun 2026 15:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBn-0004d5-G2
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBl-00026b-L0
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OaUZT96fAwiJONpo6DOLyRAzoALjcbufa5FttKGfo4g=;
 b=XAlVzuLxvlOZ4GWgUe0onhmRBvZ4kRvWv8V/wpwaCgGHrJNJaoJzM4iEF7zlt/MwMFfG5J
 3DXQ2I722cIgd69Yv9n2JqAbIkXCQ/vobwXpcaRnNALS2naDRX0S2OX1Qu1wWA5rG9DU/q
 0swzKInrLu9dOH46wiN72eap88kfWr8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Yj4oPXSPNjaAAcO6YY6S8Q-1; Sun, 14 Jun 2026 15:08:07 -0400
X-MC-Unique: Yj4oPXSPNjaAAcO6YY6S8Q-1
X-Mimecast-MFC-AGG-ID: Yj4oPXSPNjaAAcO6YY6S8Q_1781464086
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so1710068f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464086; x=1782068886; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OaUZT96fAwiJONpo6DOLyRAzoALjcbufa5FttKGfo4g=;
 b=KbDGhzCtOILcuY3cEISiyD0MpuStv/JBydnq0CNKqgYiqAv/vUUVHjVEtzFeePbAg6
 HzyVSVqu3SLXwA2uJ302f+CS96nUs4wutwB45Acz6ehn2qjE4HjplG/1qv7WCv3jaMSi
 Q0Asg6z4ZescLFz4ycWp3gBNoAO7c0meqoJ8CHLAeWaIipOtaWyjZNzckcgZY07xd6OT
 SOwfKfKVFTHpKRkNi9ZE8tIVOQcE8Uxugn01uTy/TqHshNIl/77LbZC0de9v3X4kM3VI
 eE4N1pognnurASqn90u+B/0funA3WomTtGv7sxZ/0Fid9V+wMfTOR4zehUnU0T6aTWse
 4jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464086; x=1782068886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OaUZT96fAwiJONpo6DOLyRAzoALjcbufa5FttKGfo4g=;
 b=GLHzQhQPh5/g+TGGTt2SiJbKsNdnyi7gQIapyVBD9suSv7RrDHK262F/2MoEpuj2NW
 zkhBVMUO4jYsaYD3IPaaZOI4T9d3WK3wvat62ELx+hx85jThdiR12xgYEHiMZHXBsYW4
 wM5gAS9/TILbTSB4+7XafwNHX8BZ++YIcTHhZkHSbP/hYlgJFnKSMYkDX6jJiEZo2mA+
 koSsllZ1N6dX+jkOuoqriyBFpr7YxXj704MeG5Dh56aW//avwAsE8j6FsjCKDp1iC5k5
 Z4OVbt0uL5POchh7JuAQXYDnWYGFd5ND75YtbP5fvHqENuMZWiSMDR6kbd73GXYogsAe
 0F9g==
X-Gm-Message-State: AOJu0YxvFOSsGpfA1w0k5DPBSEVDNfFenXGOGI2VKlsxaPv/K358Ue70
 BbNIyaTUrbL2f1ff1Yfj117Amf/xgHBsEqaDm+GvRDFOH2Ob2TNAcew1fore1wUJXDxlRHWhYSH
 c65NlYzEP3M4rjw9prNBNx20gdZIxl3q5ClQBoqBZYCJjlQ6Cv76k+zPf9O3Kw0M/bhgKvlUnfk
 i395ihvmXr/oh7LCLftMKRheCKNT3R/Xz2KA==
X-Gm-Gg: Acq92OEeiIvvLUg1ACJRFstIcJ+2f68Gf76cc08aGwDmzaOrcOE7n8ggu9eJJ3CMIV+
 dedUI4KxjFfMBeXxgclmCWl1YquCIip5rhmf8URxRYxofkfIuLhyEyo5ITkcBNwdQtCkW9M0sro
 1HnUaow3ZUe5XS6x5cqm54J9ploSKVSZG60DbNqyd9YH+muaxX/x1JBezdNY0SXyisX11hZRCpI
 QelkOBm4DF7OhJ2SJxoSidp53r+R7FZVlzkXXH1i8u/i7PpYdDwjdAvt8zygFJJtzdLv3bJ3MMY
 ExJJESiIed34c6yGoD7fn/FGW2gOra5YWJAqJQSYIIzMY3rL8yJHqVqdcONp57KwksrDrc4NGAA
 wZltlTc1pZtStcwCLV1Rw84e2CvfXBuMuPER1VtpGUkQ=
X-Received: by 2002:a05:600c:81c5:b0:490:ea88:9d4c with SMTP id
 5b1f17b1804b1-4922016094fmr73990125e9.32.1781464086301; 
 Sun, 14 Jun 2026 12:08:06 -0700 (PDT)
X-Received: by 2002:a05:600c:81c5:b0:490:ea88:9d4c with SMTP id
 5b1f17b1804b1-4922016094fmr73989765e9.32.1781464085681; 
 Sun, 14 Jun 2026 12:08:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203bfb27sm210094875e9.11.2026.06.14.12.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:05 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 054/106] qapi: remove user addresses from
 x-query-virtio-vhost-queue-status
Message-ID: <ad865ad765feb322a3f414c480dc57efaf78a529.1781463125.git.mst@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Semantics of these (actually, internal) fields is not simple, they may
contain either virtual or physical addresses. We are going to change
this to simplify the logic. Keeping this logic only for unstable
info command seems too much. Changing semantics of info fields doesn't
seem to make real sense too. So, let's just drop them. We can dot it,
as command is experimental.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-7-vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-hmp-cmds.c |  3 ---
 hw/virtio/virtio-qmp.c      |  3 ---
 qapi/virtio.json            | 15 ---------------
 3 files changed, 21 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 4bf9a3109d..a91bb7dbed 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -203,15 +203,12 @@ void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  call:                 %"PRId64"\n", s->call);
     monitor_printf(mon, "  VRing:\n");
     monitor_printf(mon, "    num:         %"PRId64"\n", s->num);
-    monitor_printf(mon, "    desc:        0x%016"PRIx64"\n", s->desc);
     monitor_printf(mon, "    desc_phys:   0x%016"PRIx64"\n",
                    s->desc_phys);
     monitor_printf(mon, "    desc_size:   %"PRId32"\n", s->desc_size);
-    monitor_printf(mon, "    avail:       0x%016"PRIx64"\n", s->avail);
     monitor_printf(mon, "    avail_phys:  0x%016"PRIx64"\n",
                    s->avail_phys);
     monitor_printf(mon, "    avail_size:  %"PRId32"\n", s->avail_size);
-    monitor_printf(mon, "    used:        0x%016"PRIx64"\n", s->used);
     monitor_printf(mon, "    used_phys:   0x%016"PRIx64"\n",
                    s->used_phys);
     monitor_printf(mon, "    used_size:   %"PRId32"\n", s->used_size);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 51e3a42c4c..ae9be0a00f 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -794,9 +794,6 @@ VirtVhostQueueStatus *qmp_x_query_virtio_vhost_queue_status(const char *path,
     status->name = g_strdup(vdev->name);
     status->kick = hdev->vqs[queue].kick;
     status->call = hdev->vqs[queue].call;
-    status->desc = (uintptr_t)hdev->vqs[queue].desc;
-    status->avail = (uintptr_t)hdev->vqs[queue].avail;
-    status->used = (uintptr_t)hdev->vqs[queue].used;
     status->num = hdev->vqs[queue].num;
     status->desc_phys = hdev->vqs[queue].desc_phys;
     status->desc_size = hdev->vqs[queue].desc_size;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 671f1ad793..1fc4e38a44 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -650,12 +650,6 @@
 #
 # @call: vhost_virtqueue call
 #
-# @desc: vhost_virtqueue desc
-#
-# @avail: vhost_virtqueue avail
-#
-# @used: vhost_virtqueue used
-#
 # @num: vhost_virtqueue num
 #
 # @desc-phys: vhost_virtqueue desc_phys (descriptor area physical
@@ -678,9 +672,6 @@
   'data': { 'name': 'str',
             'kick': 'int',
             'call': 'int',
-            'desc': 'uint64',
-            'avail': 'uint64',
-            'used': 'uint64',
             'num': 'int',
             'desc-phys': 'uint64',
             'desc-size': 'uint32',
@@ -720,12 +711,9 @@
 #              "avail-size": 2054,
 #              "desc-size": 16384,
 #              "used-size": 8198,
-#              "desc": 140141447430144,
 #              "num": 1024,
 #              "call": 0,
-#              "avail": 140141447446528,
 #              "desc-phys": 5216108544,
-#              "used": 140141447448640,
 #              "kick": 0
 #          }
 #        }
@@ -744,12 +732,9 @@
 #              "avail-size": 262,
 #              "desc-size": 2048,
 #              "used-size": 1030,
-#              "desc": 140141413580800,
 #              "num": 128,
 #              "call": 0,
-#              "avail": 140141413582848,
 #              "desc-phys": 5182259200,
-#              "used": 140141413583168,
 #              "kick": 0
 #          }
 #        }
-- 
MST


