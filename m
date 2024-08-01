Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZT9p-0001fS-7T; Thu, 01 Aug 2024 06:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT9n-0001ej-Mu
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT9m-0001Oj-9n
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Wj9jvYkwctqz/9QIPv8Y88E3joIG5eue0pkA+KNkvE=;
 b=F1D6HVMIs0Bw6Bj6lOrSV0L8ooQgJ8IXZAwDrBYKdwNqjbd3eqvmTXnsXl2apRYahxABkv
 dOuVFHlmWEdO+E4Hxz6LXz53pwx4/0ln4DMwpj51O3PR8PhZhZyMIr2BYLnVOj91u2uh9U
 GobdXawFTidiD6N+5vP6RLB8zfZLgPc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Vq0s2RrZMf6defh1NbuEnA-1; Thu, 01 Aug 2024 06:35:36 -0400
X-MC-Unique: Vq0s2RrZMf6defh1NbuEnA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52f00bde29dso8982687e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508534; x=1723113334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Wj9jvYkwctqz/9QIPv8Y88E3joIG5eue0pkA+KNkvE=;
 b=ZDbhBSZ/Yx3kpdYQkZ8JZ0Pfzfg546rRe+D/00njTVFs+oYi+xcvwwVMTmw3Y9d03T
 +/GxK31lcn/LPTez0WiZeriOz5xEm44MfRKHhpjCGCstRZ16hlVVTd1EMx13W8N/mKy6
 QGP7e3Q8FQrHZlhRe+KBGSM6uiXaSg46j4QT8x/g9xUE3or5hNLP1T92Zbhcbf+DMZw0
 5lQ6hGjvO3PRJkapdCY5K91INj6QZSGzHkgcm95vs+Cyzq4rnMlv4JPxpHYiFYSGAItj
 GrTTSLZT9E9jzAycjT74BdgeR5bTNYzFstwjfLaZ9WN1ZfiypXghFLAptVq+CLW5yaHp
 Cg5A==
X-Gm-Message-State: AOJu0YwTyCE27Pqeb27HlCBeLL+FpCMiHY3XFnFxR4+sc1zn5+223JWJ
 BCc4ITWJV/FVLrfhQ0gvcyPNnxG5Oi9PABrehLR6daApwICzIhaL0881ACUZOua+6dqdHod+hLK
 TJEaoFMVy2tLiHCFFnu35v2p+2n3IMZVraVd+TccxhIc+YhcLdVzrGRXOcNZebiXr/9TOQ1AcTw
 cHocMxtQnjoau0esDM5KriDOl1jUdO8g==
X-Received: by 2002:a2e:9ad6:0:b0:2ef:29cd:3191 with SMTP id
 38308e7fff4ca-2f1533999b0mr18871271fa.35.1722508534242; 
 Thu, 01 Aug 2024 03:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvxQzX0PQfR0fBq9sA8VK3QO61hJaW0B3vbhwcp+54qgAjq+YdGlBGK4cBBgnOQkksgMmXKA==
X-Received: by 2002:a2e:9ad6:0:b0:2ef:29cd:3191 with SMTP id
 38308e7fff4ca-2f1533999b0mr18868141fa.35.1722508525365; 
 Thu, 01 Aug 2024 03:35:25 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4a188sm880835066b.134.2024.08.01.03.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:35:18 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:35:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
Subject: [PULL 01/19] virtio-rng: block max-bytes=0
Message-ID: <024d046bf41b5256adec671085bcee767a6da125.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

with max-bytes set to 0, quota is 0 and so device does not work.
block this to avoid user confusion

Message-Id: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-rng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index f74efffef7..7cf31da071 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -184,8 +184,9 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 
     /* Workaround: Property parsing does not enforce unsigned integers,
      * So this is a hack to reject such numbers. */
-    if (vrng->conf.max_bytes > INT64_MAX) {
-        error_setg(errp, "'max-bytes' parameter must be non-negative, "
+    if (vrng->conf.max_bytes == 0 ||
+        vrng->conf.max_bytes > INT64_MAX) {
+        error_setg(errp, "'max-bytes' parameter must be positive, "
                    "and less than 2^63");
         return;
     }
-- 
MST


