Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D28C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsT-0000iX-Ph; Mon, 27 Jul 2026 15:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsN-0000ce-V8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsM-0000eD-BV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qGDDGWT38pNxOONe007eUvij33uws6GbrZoTgh2JBM8=;
 b=VE18v7zPpVjQUoEJIfI7aLUu2Yar9MaBy8Zxi1E9gNFzirG+EOHWvi1bJ3ceWYgQ0bzGIu
 ydlffMtJkMUkmL+RmAuy1aXOJl0cXIad2iBfSYnpCSusujOUD1Xe0GxiK0pvTScJ2d3bgP
 sb0q525MdZxJUeFWt6OASmfdiQFk9Rs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-EMMuC_CZO1Gn2QazUjz-6A-1; Mon, 27 Jul 2026 15:20:32 -0400
X-MC-Unique: EMMuC_CZO1Gn2QazUjz-6A-1
X-Mimecast-MFC-AGG-ID: EMMuC_CZO1Gn2QazUjz-6A_1785180031
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so28147815e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180031; x=1785784831; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qGDDGWT38pNxOONe007eUvij33uws6GbrZoTgh2JBM8=;
 b=iUWtshSlWc3X1gaRGrlTx4tu7Mre/4OEc+2uePoONFqZgv0zq15YYsKo07WGUrQoDs
 LqZyadId2h6e3oQtzzYoOU1iuaV0welNiR7L7y0Rfsp/38yotU1bdMzBCf2YZhI2e5uR
 sKjDhnyBEtd84HcvtSMyj+sPxYBb4AiJu+ItsHUCx7L/fJ29dmyA0tjZPL9lUh8AOiny
 t3GuxxIKuQPR0uQy/AndLgeqdDoDdP/Sw2Jsocy6BKMBT9U5M8EFVyGMZEEP0QfNyjaQ
 zb4nNvaydDn5rEUtxVx4jkbJbd3Mgl9eFUAy5q5shHS0EBKeqi7O3rmorR0P56kOxI34
 ikKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180031; x=1785784831;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qGDDGWT38pNxOONe007eUvij33uws6GbrZoTgh2JBM8=;
 b=G60gzFCsK8uwez99IJw2AXCM+3mdq5etHBc3yAX21c8opCzNgwqAk6yukALTB7Zgur
 jIrrTW3Jee1Cqu8owe91zoVN+rPf7sWes/F1pc5S+8edWH/n6s1j6b89ty9nAOvOvzAL
 BxS0iY+X8TtxGt3THqp9isPmBM/O06BNDYR6tMGBtJu0aiSfTIne5SspmpMSXbhfe+Cc
 eHJPNau/qJkXE0IyJEUBBuTafVh04JqOW3Wva54HPpQI1gyKsSWYxB/FxdA6DMiViT7n
 hXy01EuyjIX2xDTiP0CddYX2uOeTuVMRA67CEaBPqMHo6KHEDnw5nw+f/JS1bSBG2H4z
 yeFQ==
X-Gm-Message-State: AOJu0YxFMi480J3EpUGchzpKVmfGxWz6WJQttg9QkamjnbgNJdEXIzGM
 lmJk+w35jqCEVo0xYfmZgIbefaRrczaIwGyEbPE3cod0RN3VNsmMxYxfi8NVHKP9TJ7OROAkEqq
 QApLOGUxT6hQeUK6jxjI8v1h1o7gx0nonzi45C5frsPUH3YWjqkPDRM2rFvqpHSGuGk8/h+xs1q
 K4eYRqVkq1pmsmcSFShCM4H63ENLMsDiKaGg==
X-Gm-Gg: AR+sD12kS57a2ycqFNcFNFGGOhSsV2TCU2swM/f5FOVqB7UhpkJSbTuymKAN0mfIwRR
 LpUvL/qwsLtbl095S8Zgq4DtUL4GhsYWVPvBNtyO44FQo7e7hNq8VmT7CoxB5s2uc6iVfOjcO79
 m87Je6v6xfi+99pSJmQaWIpu0L1+HR7gMR3aNG4C2O/N3qlnYiCMCVjEvCA4UJ/soV7YQIRDntc
 u2bTDyKESzJclcY/lCQHnYJV6u/JrVErZZC2BhzzwuUIdUstknYae4tmR/iYgqkyi8aM+DRl/lk
 9QjkTf1+p2vqAflIyU/mYlJYgg8DnyE1VyXKV/tQvUaGiNAmFe6/AS1QgJnb6xb4wcmaHlsBMcH
 /+VEsI/BfYZmUMtak/Hxv7Q==
X-Received: by 2002:a05:600c:6d83:b0:495:7d78:7fb2 with SMTP id
 5b1f17b1804b1-496b570027amr78367455e9.27.1785180030628; 
 Mon, 27 Jul 2026 12:20:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6d83:b0:495:7d78:7fb2 with SMTP id
 5b1f17b1804b1-496b570027amr78367265e9.27.1785180029976; 
 Mon, 27 Jul 2026 12:20:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45e92eesm14309415e9.15.2026.07.27.12.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:29 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Li Zhaoxin <lizhaoxin04@baidu.com>
Subject: [PULL v2 24/30] hw/virtio/vdpa-dev: pass set_config buffer to vhost
 backend
Message-ID: <421f45d03f328267ebf77fab823a7a25ab3d6c83.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vhost_vdpa_device_set_config() receives the updated config buffer, but
forwards s->config to the vhost backend. Since s->config is refreshed by
get_config(), it may contain stale backend state.

Pass the supplied config buffer to vhost_dev_set_config() instead.

Fixes: b430a2bd2303 ("vdpa: add vdpa-dev support")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260709073225.2341642-1-zhaoguohan@kylinos.cn>
---
 hw/virtio/vdpa-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 089a77f4d0..6dc684ab09 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -212,7 +212,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, const uint8_t *config)
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
     int ret;
 
-    ret = vhost_dev_set_config(&s->dev, s->config, 0, s->config_size,
+    ret = vhost_dev_set_config(&s->dev, config, 0, s->config_size,
                                VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("set device config space failed");
-- 
MST


