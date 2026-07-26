Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01475C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QE-00089h-Vg; Sun, 26 Jul 2026 17:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QC-000824-KS
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QA-0004Z0-Ps
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qGDDGWT38pNxOONe007eUvij33uws6GbrZoTgh2JBM8=;
 b=fKLpm4L6gFkwtwTeeaADz4AMTa9phM/idowdOLGO64qzTowMEbmyazgbVDKI3vMqG3uuul
 vKP42Xa5IcGSOYwZ0oeWswRtC5CSNyK+W7TPFfRmx9FM+0GyfSfNvZ7zu7ZXkKhkDsj1nw
 EmdtaIu8OTKgtyiaX4dRS9y3rpgcDyY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Fj98fVvcNlmvvVdB-BOC_A-1; Sun, 26 Jul 2026 17:30:04 -0400
X-MC-Unique: Fj98fVvcNlmvvVdB-BOC_A-1
X-Mimecast-MFC-AGG-ID: Fj98fVvcNlmvvVdB-BOC_A_1785101403
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954a93c565so9469025e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101403; x=1785706203; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qGDDGWT38pNxOONe007eUvij33uws6GbrZoTgh2JBM8=;
 b=nCzNRmwu0Yj5QbMDR6aeUXtJ3UXHklmPaTNKeV1PceSkCn84tKEW3qAwAFpMJyl6Eb
 7PKxhKkYvAyCXQVtH27Z3f63qecMvKc5ehko8oGlrcqdOXpe+qa8kd4ztfqBdB/OZfwu
 ipx4YvXmu5L5jVnVFXKt3oW9M/SVTUr+kYNeAr0e/lirc9a03+OmVQ336ZgOri3NbajV
 xaNAw6UPsEcD5jSKsw3pBJhNPK11wlSwH/2PkeeoDj5z+exBKpFZLv14pngRPb/IEuRk
 kH76v/FaRJCOMSm5g7a78kaAov8PZBR/PhU0R0lSKm+gQkP7n+9Y+FPrRyg7OyS3+mRW
 Va7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101403; x=1785706203;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qGDDGWT38pNxOONe007eUvij33uws6GbrZoTgh2JBM8=;
 b=Y8DEhaX2snTXF6m89mZZPAcm08mh1edxCXSQBS9UBm45a1GbeXCcFmKdZ3Cm0c56V5
 hOY1WCU01Nh9/G9BZtweXbFGir3maqYfI/FZzTSTTA16wj4Edp+Hl5+WdQF1ZLIjpiJn
 prq1y+GHhQvKrygQEra3Q9UiWia0HGsTQu0O24MYSeu8RiBI8i9W6ovtD0a3Y88l8Tm6
 AaRsvYrFXGGW4xoN9ED9X9S/gE2+FUqObCQFMeDYDBK6sm+jdcicv7K0ucJZx1fSHnl8
 TSY6eSRwuiQQX1JGayc9wQ9KO0XaR2+zHTV6A4XATjfpZ0q+5+AGQgZHk/k8fEqqC+gF
 PF0Q==
X-Gm-Message-State: AOJu0YxR3xZuqRPIT4eKymh4HTubTW73RiZGVMWjEqdOyvdXmqkATbJe
 fp9J7gZWIGalVEUGDJUI6LQQXfSSBi4xu2qjgjR/gAfhacx7Ng1OHkT2pZJBfvfIVV5rovmQjGb
 whYL9qeTG2DMUEdgDCVtXuVbfVVepSJgnVeD+6tjKWsrSkrZkXDRSTO0SoZ2duqOCrA+G0OTnYP
 W3htTQLPSAkmp8jtyZvcZ3Sj1k6v9hKWAdWw==
X-Gm-Gg: AR+sD126jBHgvo9aKsz75jsslBia/GUyObO+B/uPlrklfB8eGX5Rrz/amjalCzgIprr
 1oILELKw8nw5UI8Kn9KeJhgv0eIJbbWnbElh6yDShSA+JMMWGrNEBe90f4lQH/YQAdXBOG0Kkje
 MfGngUD43e/stS9TeOA1LpiNPzIcYaYMeMLklNbEectxf69GoGD3NuqXhD6GKskpEMEWF7QaY39
 2cOGsvZTbIPK2ff57VsJxj8OBBcHQ9egUIDFugZN3ReAFllnkMPEUpzetdNX4zvZu1q00QO7Cyk
 6FSB8kqmZyfGWUNuKoRGqLl56NJ0Mg6k8t+PBypx02EO2K7u7ZXFWUq6F6r9KM6n/t7tPPdvnGK
 qLlBgvxRJOScxzKcJgH8Tkw==
X-Received: by 2002:a05:600c:8b4c:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-496b56e6f9dmr82243165e9.2.1785101403162; 
 Sun, 26 Jul 2026 14:30:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4c:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-496b56e6f9dmr82242905e9.2.1785101402620; 
 Sun, 26 Jul 2026 14:30:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f33b73sm164778245e9.14.2026.07.26.14.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:30:02 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:30:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhaoxin <lizhaoxin04@baidu.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 25/30] hw/virtio/vdpa-dev: pass set_config buffer to vhost
 backend
Message-ID: <2fac08ccceeeb57132584af6e06aae5dfdff87fa.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


