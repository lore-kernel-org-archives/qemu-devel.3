Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D713C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZc-0004Xf-34; Tue, 12 Mar 2024 18:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZY-0004UG-AC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZS-0004Eb-Lq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAOsHoQ8Q+B9MtUklOYVBNfmlL6poKBOv9a1HTNc0Ww=;
 b=RKGkadLCEG/SgL8g/e74EWQ9HcaoMjGwz1biawuF3u3zzv4ftBPiu20kkqE1CFnSHNJAdY
 FUzcOOYMOQQj+Wn+y5xTjELR1t5v2vN11NwEjk+QUjHu4q2lminK3hErpqz5fZLPo1Gvpz
 ggLSwe71yvqxl7iSjR4vNb+Sc2z0Me8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-2yzKWk6MMfavFceh9OjiiQ-1; Tue, 12 Mar 2024 18:26:03 -0400
X-MC-Unique: 2yzKWk6MMfavFceh9OjiiQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4655acf23dso4013666b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282362; x=1710887162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAOsHoQ8Q+B9MtUklOYVBNfmlL6poKBOv9a1HTNc0Ww=;
 b=iXx22IiV8mbuN17rvJpu0iNnw3zxKKpg1Aq3pePAroWDrKsB9l8cN4CGxAiDwN5XAZ
 naWjzD2NI20CfDk8SW/gJlq1tjUykOMa6oe2tx9feJkKHpb+j/lEseGuuM/pYem3C5GW
 wi8o2U8CcdSas7a+25YroN268Vy3mtM9aXs7JNJKp992ft/bjlGKafWfCZrh5sjxYNTF
 sPTCsOIAe6ruM3Ft/etpErIXzYD7F1IzjiFMReRB0sUauDtr8nVqYCTLi2mLp42l0/2A
 1QhAplrypYgwB8X3IHcWVNRoesuQgqbTesjhj7jRIzl7jxwEbjbLqciITrbC6uuvFfvL
 KzWw==
X-Gm-Message-State: AOJu0YylvdvUTRylwSctd5Wb3N/Ga52WIZDilt433IdUFJcHs/emQ2pe
 MH2xZ5KEyjs48p34iddURuZ85t+/iZjB1RWXorNHYb8bzMQv+ugKwssSBrfpZn0HGFpmV/YSEeH
 n9dT4wSg3qC1fpwQrpXqKU2SfXPO+f/FQMv49P+LvDW5tEHkmYhRg5qsdByTDULiUefR05zdEwy
 +HBcGqdmNzS/xQ0MHzA8MieIA0m65Qxxak
X-Received: by 2002:a17:906:6442:b0:a45:a7e5:fb98 with SMTP id
 l2-20020a170906644200b00a45a7e5fb98mr3555083ejn.27.1710282362140; 
 Tue, 12 Mar 2024 15:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELeuHmFBCuFVOPXX9dQq9GCtGMvqGuR2zAxARIMBvnfY3ka2AEo6kKYVOKYgfyvzfBIhiuVQ==
X-Received: by 2002:a17:906:6442:b0:a45:a7e5:fb98 with SMTP id
 l2-20020a170906644200b00a45a7e5fb98mr3555070ejn.27.1710282361779; 
 Tue, 12 Mar 2024 15:26:01 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 t13-20020a170906a10d00b00a4605a343ffsm3829944ejy.21.2024.03.12.15.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:01 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/68] vdpa: indicate transitional state for SVQ switching
Message-ID: <db4cba36a7356f5e94e97735af8c578c55838386.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

svq_switching indicates the transitional state whether
or not SVQ mode switching is in progress, and towards
which direction. Add the neccessary state around where
the switching would take place.

Message-Id: <1707910082-10243-12-git-send-email-si-wei.liu@oracle.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 2254859dec..5f06c39f63 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -324,6 +324,8 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     data_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
     cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
                                   n->max_ncs - n->max_queue_pairs : 0;
+    v->shared->svq_switching = enable ?
+        SVQ_TSTATE_ENABLING : SVQ_TSTATE_DISABLING;
     /*
      * TODO: vhost_net_stop does suspend, get_base and reset. We can be smarter
      * in the future and resume the device if read-only operations between
@@ -336,6 +338,7 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     if (unlikely(r < 0)) {
         error_report("unable to start vhost net: %s(%d)", g_strerror(-r), -r);
     }
+    v->shared->svq_switching = SVQ_TSTATE_DONE;
 }
 
 static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
-- 
MST


