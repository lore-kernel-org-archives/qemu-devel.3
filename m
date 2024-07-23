Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2598C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDG1-0006lQ-1m; Tue, 23 Jul 2024 07:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFi-0005k8-Ps
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFh-0002sM-2c
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+taPMy5Q8060TvpZgWRsF1ltpcOrUHjqjPNdMJkSVmk=;
 b=fDQ8JiECSs6v6fhi93xEUF23fubAGLQqYNfvBzj9JItZHFrKJB2+9qoBXbfm1Lz/Qv5VKu
 hLyO9bhFVHF7UTClMMz6ybpCmwCu7Pb/86p1izTF3xPcSauqsSJQTMP23lVb1JVHB0Yvqc
 yjm8bl7P6OFsX1fiUGByvyLvHDJrU0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-GF6x2VEVPWmYdJotyRjKIw-1; Tue, 23 Jul 2024 07:00:13 -0400
X-MC-Unique: GF6x2VEVPWmYdJotyRjKIw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so3169065f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732412; x=1722337212;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+taPMy5Q8060TvpZgWRsF1ltpcOrUHjqjPNdMJkSVmk=;
 b=YeAOFnOaQVCN0wbASAJMiNw63WB0CHP1ApAsYRKWWLGow79LgUL648/pfoHAwp1Mxi
 SBOYQgAEekv1Id2M56FLXe8f9iCBShg2vU3ver5XvQo0H1bLG6p1X7nihtaUaqZAFOEI
 qX8tyVRcMrdAlcG7peH/79yEf7pJrchZYkn2R1nuHl/B556BGxE/OXoAZ2DsdHzzEhef
 uKmk6901m72t2lJziSFz0ntHWBSosfO6eyCHIspzr4cpvzaQ6oI3vyqlBd4uH99Fsji3
 jqLXUKe9FIOCGIraK2RCM0mfZVS5EC2GoPvweGvVe8Qs53OK0QRxOkNmWnHKVoi5EOcC
 VnjA==
X-Gm-Message-State: AOJu0Yx7ebXkraYpnOdVhDdmLEQcWBh2jjZxF/R2ApZXoRU3CaBHs1jS
 ct02F1T1eNc0mxM88LHEmdIKnegGcAfYTEtzn7LPtaCPRvUMJHcSb9IyJt/An5zsN2R1DMsT9KF
 FNUDspqSIQtQWBUNfI/W7WQweaHu67DrhdjQHdDWg4Jtr3mxDQHEZFwcza59Zh66j6BGdnw9M1i
 E+zObyHKL0DPQ2qFmF0oKvQWHMVt+7Fw==
X-Received: by 2002:a5d:5009:0:b0:368:7fca:9040 with SMTP id
 ffacd0b85a97d-369bae25150mr5262601f8f.39.1721732412252; 
 Tue, 23 Jul 2024 04:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+BNfMM8nS6aU8G8BR+o4eeCV+qwUohnxtOCVkIHK/RgCUwBdVDVYzzC/Of+/HyYF2TQPbbw==
X-Received: by 2002:a5d:5009:0:b0:368:7fca:9040 with SMTP id
 ffacd0b85a97d-369bae25150mr5262578f8f.39.1721732411704; 
 Tue, 23 Jul 2024 04:00:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ec8ccsm11133845f8f.97.2024.07.23.04.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:11 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL v2 47/61] virtio-iommu: Remove the end point on detach
Message-ID: <1993d634d57718d6eb107c973b7c8b80a6d91338.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

We currently miss the removal of the endpoint in case of detach.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-5-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2de41ab412..440dfa6e92 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -786,6 +786,7 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
     if (QLIST_EMPTY(&domain->endpoint_list)) {
         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
     }
+    g_tree_remove(s->endpoints, GUINT_TO_POINTER(ep_id));
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
MST


