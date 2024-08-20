Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB47C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMcD-0005Zb-9z; Tue, 20 Aug 2024 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc7-0005Ue-9A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc5-0000PO-OW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724151681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCcGW+ALijD/XxNzFrrw4isqUnFZstEHUc5PP/YQ7Rk=;
 b=eBptwR44CtBf3timWuVkgs94/gozkmlGXtSTsbZu+kZVmJBWNGQVpj3TVuXYuWyIveQ0Sy
 /LFkhRdh93GlhZAGsx9bfp1ub9uomUMk6NFkn2zRtUyfKJW1VTenFJFvOXcagJU1eilgtq
 cm014grNe+vfAPG9epzTg9IfcY0B5no=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-pNjWxlDUMRSePmyiIpSaAg-1; Tue, 20 Aug 2024 07:01:18 -0400
X-MC-Unique: pNjWxlDUMRSePmyiIpSaAg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5334344ae21so514079e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 04:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724151676; x=1724756476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qCcGW+ALijD/XxNzFrrw4isqUnFZstEHUc5PP/YQ7Rk=;
 b=hdp/dPWzMI/pAVwm6/cVpiLAaPIlls1BdYJ8pjC3r3vAfo8Mj0n5t8bHoLZMe1oR3g
 xR0ZZBGnqMJ/KM1+lHolL/8gl+eZNHwRQAmUBXmSEtzyRLaiEKlh0Iyy3PTJFFojNlq/
 ZQOYKD3Y9PWO/o3fZtt/eMJ3r9on9urHQiWRbIYWnQlrOOlf4o2eNVq92wn0P5jf8Evb
 OAXuv8UVaKYfSxpLHPNyFd4bf/AXGMBJr60fmHk5EFDpeSdOG/SSre94oL2zCcEGdRX7
 vzeh44ISBPhGReb49ysyf53bXyMKld/qGdX5dGkHlnYENSMbbvTXreLcNYgk8La1gu20
 YkjA==
X-Gm-Message-State: AOJu0YzQq/+AbHrg3wX7pWKlFqQDIp5WdDB+TY3wFoAbYiwa6q5GdKXG
 8ubtvs1//zXigKvUoXfde/OqEN586PpRHraBx1J3MGd39bPkJvyrUDxdnBHbgV01AFYXBB/1/h3
 rE3JEUi8+IrVTWhqhmMWvuKgWXwUAMdzegyrc9AS49zHY0bX2HTspx2Y3Mb2TQI3umaqwlvb05m
 SjAFvSXAhGylzPWI5zhkwq+VigZZaxUg==
X-Received: by 2002:a05:6512:3082:b0:52f:cd03:a847 with SMTP id
 2adb3069b0e04-5331c6f47f1mr6862069e87.61.1724151676157; 
 Tue, 20 Aug 2024 04:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnaGbjhvECjZGX/+U/amy2wM1iWcIbENPbz5aJRC50d4M+yjDKtzZ8p2jqewILqSg1aFOhXg==
X-Received: by 2002:a05:6512:3082:b0:52f:cd03:a847 with SMTP id
 2adb3069b0e04-5331c6f47f1mr6861976e87.61.1724151674972; 
 Tue, 20 Aug 2024 04:01:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed6586f7sm138714165e9.23.2024.08.20.04.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 04:01:14 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:01:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 2/3] hw/audio/virtio-snd: fix invalid param check
Message-ID: <7d14471a121878602cb4e748c4707f9ab9a9e3e2.1724151593.git.mst@redhat.com>
References: <cover.1724151593.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1724151593.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Commit 9b6083465f ("virtio-snd: check for invalid param shift
operands") tries to prevent invalid parameters specified by the
guest. However, the code is not correct.

Change the code so that the parameters format and rate, which are
a bit numbers, are compared with the bit size of the data type.

Fixes: 9b6083465f ("virtio-snd: check for invalid param shift operands")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20240802071805.7123-1-vr_qemu@t-online.de>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e5196aa4bb..d1cf5eb445 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -282,12 +282,12 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Number of channels is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (BIT(params->format) > sizeof(supported_formats) ||
+    if (params->format >= sizeof(supported_formats) * BITS_PER_BYTE ||
         !(supported_formats & BIT(params->format))) {
         error_report("Stream format is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (BIT(params->rate) > sizeof(supported_rates) ||
+    if (params->rate >= sizeof(supported_rates) * BITS_PER_BYTE ||
         !(supported_rates & BIT(params->rate))) {
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
-- 
MST


