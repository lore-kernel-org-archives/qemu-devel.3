Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E12EE7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRI-0005wa-25; Fri, 06 Dec 2024 07:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRD-0005w3-En
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:03 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRB-00041H-NK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:02 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-7fc8f0598cdso2457879a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488080; x=1734092880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhIrThlkutEtVHP85kOO3RvGh84lj/zvtAYPVdYZ2YE=;
 b=CfvUoFejQS4B/08LTohEVVac9Omeo/CB3LLX7dRwDFFlrICx03Ndr4FnIHlMIGJIOZ
 haW1yB3yQzfLqDGTWmJ8LdDNRdGoSsar6/kCkgFMOy+kLMOaPEcGpkYq8+9SMKP9yXpt
 2TPlyz6qspmi3pFhrPGXdxBl10R5pN9jOjXxdQRGe+TdOSaa4sRyN2DIH9+wkrHg98zR
 qGyPCUm65gYBAw22vwSn9O/NkhUUK0ciwzSWfTYjIPMVeX1cnNGNWPhOBLKB2fyzKIXw
 EMWrFeC+DGNgUHLp/c7LTiCOtKvoshhovNTfmu03DBJP/miOW8HwQRwUqWavgDo6kQ1V
 X8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488080; x=1734092880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhIrThlkutEtVHP85kOO3RvGh84lj/zvtAYPVdYZ2YE=;
 b=MHUjtpG/AsIQKHI09KYrlYNdXHjKkgqqOe5u+rsgJdZXHy55uhhpnigBN+RBIgd9fg
 9GLibBITyKwuN9ewHpgT7R4hDny+Y09JTQP1KKhyKSDUSK3LpR+oY5zY5WY6+6nshK74
 wcsZoxEntfJnkVYmtBP1EOCf5iEvK2xWnfUvQJvLbBo0plQWM/6G8xvnqHjHhGWGtMgG
 10JlABDvzavX02uAqZ90FDuX0+KucuGNWPTNWZIi/kS8Vya89oQhAXG6pDWu01TtBom6
 +0AFjJ6apFuHp/9dbxs0t4qyFtBUOHC6xWksz0y3Oi94ne5b8i3+W/F+mvzfoNry0XG7
 4v4w==
X-Gm-Message-State: AOJu0YwwTbesM2YUmvM4j3arN7GagGmtG1RUFK/uClBUQbf6e7IReO7s
 rkBvGFeacv9224BJzNST2NEulBLwuntZe54xGA7Jr0uwCj4glRk=
X-Gm-Gg: ASbGncsakJd+g8pPGVXpgRCuK2DANSSOP+P4N4UZJNg25fWZ9kmypeS6drkV74LI5N7
 eYWE8EC6QMgoFqxrwG0en2Fev7BoByhyvC8ppVL+9D9ILOstMIwHXZ5HPcPOUIWtnZ7XmoFwIU0
 JBtdW88fOyQu0lMqcEtXmOoBwiH8VZ/0kqDe1lQ2tXx5N0C25uFVJNIg4zIdq04y9hUHnLn1XrS
 +GOzECmgHZ7Bteha+ulqgyllfYJ2I8MxQldH+iqCh4teodFPXShggBVkg==
X-Google-Smtp-Source: AGHT+IH8Qyc65xY1MGfV/+jM0YE3H69rEV7PTkQNx8+hqDRClYm+5KbRHEI8fphq1VTqEXscp/V2jQ==
X-Received: by 2002:a05:6a20:258a:b0:1e0:d0b9:9a90 with SMTP id
 adf61e73a8af0-1e17d3a210fmr12350637637.13.1733488080300; 
 Fri, 06 Dec 2024 04:28:00 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:27:59 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 02/10] vfio/igd: remove unsupported device ids
Date: Fri,  6 Dec 2024 20:27:40 +0800
Message-ID: <20241206122749.9893-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since e433f208973f ("vfio/igd: return an invalid generation for unknown
devices"), the default return of igd_gen() was changed to unsupported.
There is no need to filter out those unsupported devices.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 73ed1ec8e6..059ed56439 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -64,16 +64,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* Old, untested, unavailable, unknown */
-    case 0x0000:
-    case 0x2500:
-    case 0x2700:
-    case 0x2900:
-    case 0x2a00:
-    case 0x2e00:
-    case 0x3500:
-    case 0xa000:
-        return -1;
     /* SandyBridge, IvyBridge, ValleyView, Haswell */
     case 0x0100:
     case 0x0400:
-- 
2.45.2


