Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD02BC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAat-0007dj-GU; Tue, 12 Mar 2024 18:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAak-0007Lz-MX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaj-0004OJ-6a
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=faJjZcgxeJc4r0dC1qxSrJM/ByQyn32iy5RAHwtp21Y=;
 b=a3cZDmUfEVgHZb9WiAmhjpvGwkDo0UskJQTJj1nBwk+vLC7Y6f0V+lmobdI9DJ7B5HIcZv
 y3oheOjMTlPCdQ+IBlpHKkLQM9GUQQ+bkWeJqM0mrJRYi2GRIe5hNp3OKTXre9NQ4bIJFu
 kM/i9yVgy1bWcwaNC2zZDKL73+MnMMQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-YenIqga5MXaBxcbXBuU7jA-1; Tue, 12 Mar 2024 18:27:22 -0400
X-MC-Unique: YenIqga5MXaBxcbXBuU7jA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d45f5bfdd6so8794541fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282440; x=1710887240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faJjZcgxeJc4r0dC1qxSrJM/ByQyn32iy5RAHwtp21Y=;
 b=gsV7i2LAKCYd53AWdpu8x1mOqryAO6FHnCY38VPJ0J3muEgjE04qlKAROllqwmtGdl
 toJ1zCLaY+UEtREf+vvFGJDmAmJ9rBX08YsPVX5OGOS2jJjQSUkrmO39ctgueFCYhra5
 OKHN04p1WTzBJ3jf9TYl/mqyfrueemV0MyKLnXzbr8NAo51Z20djTiIwgSwIq5AU5MGo
 sn/klqhsmn58ok1QKw3yAQiE67rLJQ0Os3zYZbltlKyigHnJjSFT+7z6az5XraEXBz8l
 GhiCmSe5mr/Mr7ugltsR4KYiLZFY6vfQRoq96dpa6yQEixRytBRT4VgQtOzeOhzziae/
 osqA==
X-Gm-Message-State: AOJu0YwuWu5HnjAUtp4FMcG9GcF2SBWLalfkzC8OskNhdM+JjXsIUCQU
 IRupbvUCRfKSxWpEaFF5mpdov44Z5ysPAoLzfbPZna/fy3EOISaj7ak4wc4Revg6kFUkTjd9xUN
 9XLxeCN9TvKsAYhOUEuD6WmTCd2OvbYkwW+OFPKg9A3r5NIeD6m7tuHV2BaYe/DOv6lK+06R06z
 fyiKrQVF1/6kFWZwXKDULz0EPvAeIAT3xt
X-Received: by 2002:a2e:9b92:0:b0:2d4:3df6:5330 with SMTP id
 z18-20020a2e9b92000000b002d43df65330mr4505707lji.38.1710282439966; 
 Tue, 12 Mar 2024 15:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3YX9G6WbZMkL7HIiFH3dR6CIOBVpQSNi87CHPEqh8tgYkMZAXGYT9x6vL+ERqSREaGP/ztw==
X-Received: by 2002:a2e:9b92:0:b0:2d4:3df6:5330 with SMTP id
 z18-20020a2e9b92000000b002d43df65330mr4505691lji.38.1710282439509; 
 Tue, 12 Mar 2024 15:27:19 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 e20-20020a056402149400b00568229390f2sm4359050edv.70.2024.03.12.15.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:18 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 34/68] hw/display/macfb: Fix missing ERRP_GUARD() in
 macfb_nubus_realize()
Message-ID: <5aa4a6417b0f7acbfd7f4c21dca26293bc3d9348.1710282274.git.mst@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in macfb_nubus_realize(), @errp is dereferenced without
ERRP_GUARD():

ndc->parent_realize(dev, errp);
if (*errp) {
    return;
}

Here we check *errp, because the ndc->parent_realize(), as a
DeviceClass.realize() callback, returns void. And since
macfb_nubus_realize(), also as a DeviceClass.realize(), doesn't get the
NULL @errp parameter, it hasn't triggered the bug that dereferencing the
NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
macfb_nubus_realize().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240223085653.1255438-3-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/macfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 418e99c8e1..1ace341a0f 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -714,6 +714,7 @@ static void macfb_nubus_set_irq(void *opaque, int n, int level)
 
 static void macfb_nubus_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     NubusDevice *nd = NUBUS_DEVICE(dev);
     MacfbNubusState *s = NUBUS_MACFB(dev);
     MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);
-- 
MST


