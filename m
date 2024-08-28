Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3339EC54FB3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxX-0004YB-Pz; Wed, 28 Aug 2024 09:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxW-0004RJ-4a
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxU-0002LA-Hf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:37 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5beb6ea9ed6so7317398a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852615; x=1725457415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1Wxn4ztcsSpgPNwkQzBp5z/GYAcrxDMGZtIkBFIolE=;
 b=SZHiHS1P4PRrBLheYrGCrtWwVaLXlELsW/MYZrCTvTPBlb5lgJQHvgNkNzNE+m8LtD
 gCz1ToxXDShQZhWwNc70dDjw93JyeuuIBCrUusmsZxOVb5viagVNjiyQYHaQjFgdqjoZ
 jw4EFjhUrPXf8lIh5l+r8Ra4QQx5LAcVfbSH1k7ilX0aMZ9156GLhGvNfnQvTpb9aFJ1
 R+RbQjEk2N5zPicHqJiyGVH4pDS/fcFxajoCzPGvSoV8qx8xfoFdqHK3SjCZkXHg+jNX
 ZfEFt6xVkZatgGpcpgTA6QgwGcf/IVdYsykE+6mT2S6joB9gB6dLmUv3z/DinuZp4xVf
 Sdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852615; x=1725457415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1Wxn4ztcsSpgPNwkQzBp5z/GYAcrxDMGZtIkBFIolE=;
 b=KXpWCXEdclj4kofWyDMoJ13gNlj1UOIHs9oAAOzTbDOU/YiddkqXTbkOnWanxptIV0
 LfYp6HNwK2WmUkVbJDbmYCObqhabE93P0noaoV+mZ2qIIu5FnE/dNHNvWzkmlGHUkYFX
 eYn6Af/6GuAwrj4v/Pf6uym3M9vwfmpU17CQL/htsWN9GUp7nkp9L/07OF+/+qHZUq1z
 Z46I2WWKN/+ioI+X5AozPLy+0ZhCX/F0Vvr2e2jwA77/ZHI4wZZGBLgdkt7AB7fq5nOx
 yiZB3aDFIvtDTURaTKhYVE/IhZoH/w6M+EjD8i6w42BwsRd4JxxID1rUxvuW0X09qsg6
 l7Wg==
X-Gm-Message-State: AOJu0Yy3JAzUJSxSZ79Q8hvoNtNylgQ7O4XfHrb+qcD1TDvvuH9TY7oY
 jfDOZQ4K7fTjHbImB/nOPy7DFwABVzli0SR9eeZ3STRTIj0zelmTOuZuWg==
X-Google-Smtp-Source: AGHT+IFIq0m7iVk4g3lUrpPJAI2qlO1wt2qk860rXKrsGobCTPeGLMggLSwjht8zoeTHwVb1AGkTuQ==
X-Received: by 2002:a17:907:d3d1:b0:a86:721d:3021 with SMTP id
 a640c23a62f3a-a870a99137dmr164617766b.24.1724852614604; 
 Wed, 28 Aug 2024 06:43:34 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:34 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 5/7] vfio/igd: add ID's for ElkhartLake and TigerLake
Date: Wed, 28 Aug 2024 15:43:26 +0200
Message-ID: <20240828134328.94528-6-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ElkhartLake and TigerLake devices were tested in legacy mode with Linux
and Windows VMs. Both are working properly. It's likely that other Intel
GPUs of gen 11 and 12 like IceLake device are working too. However,
we're only adding known good devices for now.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0d68c6a451..8a41b16421 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -88,6 +88,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x2200:
     case 0x5900:
         return 8;
+    /* ElkhartLake */
+    case 0x4500:
+        return 11;
+    /* TigerLake */
+    case 0x9A00:
+        return 12;
     }
 
     /*
-- 
2.46.0


