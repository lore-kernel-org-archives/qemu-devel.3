Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B08C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZSG-00050H-6e; Wed, 24 Jan 2024 04:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZSF-000504-6O
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:21:55 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZSD-0002cr-LD
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:21:54 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a313b51cf1fso15293166b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706088112; x=1706692912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1uS8xkP6N2RvxCfq88kSdHzC5sq+DHUXo+Qf0Z6sK6Q=;
 b=PXUgUXEh1Pr280kfEU1sM5SAQXyNyalJMbuR6CDbKZhF5OafwyhjlRCyr1RxOevFaW
 AfDIrKQEEe0n0+BjQ++GWLIUCtZqP70B/9jzKQ+V3NjB1c1zxoWjOpagzD6+Nu4G/ZYQ
 QGCPcGJIrZJQsIQGVaiKHf+LT0bR97dGhfm4X2KZD2E6tcJyfNeyXChWwSLBTb68sw8d
 QVVxxu4p1IZRsz0HsW74jgdhy2yl4xNTGunpDMDthKpd9mRWarmRNIg0AR2XjiowtZpi
 75VtvXPf6D1WG/rLaEE9QOPJflLAvkSo/l6b7LtMVjB0amKFEGeoJRdgnblQWJU4Jt3O
 77aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706088112; x=1706692912;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uS8xkP6N2RvxCfq88kSdHzC5sq+DHUXo+Qf0Z6sK6Q=;
 b=cDom4xdocslUX8f0k5ZiSxxzqCqf45ATi0aviVmiFi8N1q2THBKscxcVcXycdlVAUn
 FZYcm7QQciCH2pPBnGQ6wSc4FT3WCFIpIputvyvkFoYOqHTYpe+bv21Cp1hIjkrxSeH6
 OJvzDbawelBrjb62dzBvEnrPoYbYaQbDBrJtmQWChX5i6dSExC121Rs1dEm4vLBs7mS+
 bb4IG/n2zw/clUYbl4ZQD14HHQcqDOM+4lQ8krCeQctvQ7RUj1e9KT0A2EaFPdzKhofH
 7YaY3bfr+0mCfaHXAFa5nYlZXlktxkna2syO1FtBs8jG4VYmW31+wWKj+dRh05m9Kqpa
 Gusw==
X-Gm-Message-State: AOJu0YwUxu6aVXe2WgNHzaAgfTyG3WQ/Fc4HQ7nqc+0+mHm5KXVFbWjZ
 hYz5M+DVuwaZ/x2cUMb9fAKIjhVUF6mJvcHyGDPnVZ9XEv2HS16RtwAuwQo170VJr1bxP5aYkzi
 NnzY=
X-Google-Smtp-Source: AGHT+IERHKwmkA21ZLaUK6JzSVRlHPobry6+wah9aDIpW/+rLcRNxYZi6zgnlt/FjFXe9vya4ejsKw==
X-Received: by 2002:a17:906:558:b0:a28:da52:8de with SMTP id
 k24-20020a170906055800b00a28da5208demr1065841eja.52.1706088111699; 
 Wed, 24 Jan 2024 01:21:51 -0800 (PST)
Received: from meli.delivery (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a1709064bc100b00a2c70caccbasm14988706ejv.107.2024.01.24.01.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 01:21:51 -0800 (PST)
Date: Wed, 24 Jan 2024 11:17:07 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 4/6] hw/scsi/virtio-scsi: Use RCU_READ macro
User-Agent: meli 0.8.5-rc.3
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-5-philmd@linaro.org>
In-Reply-To: <20240124074201.8239-5-philmd@linaro.org>
Message-ID: <7re0d.o8r1pancklv@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 24 Jan 2024 09:41, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Replace the manual rcu_read_(un)lock calls by the
>WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
>"docs/style: call out the use of GUARD macros").
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/scsi/virtio-scsi.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>index 690aceec45..998227404a 100644
>--- a/hw/scsi/virtio-scsi.c
>+++ b/hw/scsi/virtio-scsi.c
>@@ -343,14 +343,14 @@ static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
>         target = req->req.tmf.lun[1];
>         qatomic_inc(&s->resetting);
> 
>-        rcu_read_lock();
>-        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
>-            SCSIDevice *d1 = SCSI_DEVICE(kid->child);
>-            if (d1->channel == 0 && d1->id == target) {
>-                device_cold_reset(&d1->qdev);
>+        WITH_RCU_READ_LOCK_GUARD() {
>+            QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
>+                SCSIDevice *d1 = SCSI_DEVICE(kid->child);
>+                if (d1->channel == 0 && d1->id == target) {
>+                    device_cold_reset(&d1->qdev);
>+                }
>             }
>         }
>-        rcu_read_unlock();
> 
>         qatomic_dec(&s->resetting);
>         break;
>-- 
>2.41.0
>

Unrelated to your patch: I just noticed in hw/scsi/virtio-scsi.c, 
s->resetting is used to flag whether the bus is resetting; but there's 
no check if a resetting is taking place before starting another. Is this 
single threaded code so it's not necessary?

As for the patch:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

